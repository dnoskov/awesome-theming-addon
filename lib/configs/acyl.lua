local lfs = require 'lfs'
require 'pl'
stringx.import()
local posix = require 'posix'

local acyl = {}

local test = {
   icons = {},
   paths = { 
      -- Место, где установлена тема иконок ACYL
      source = os.getenv("HOME") .. "/.icons/ACYL_Icon_Theme_0.9.3",
      -- Место, куда будет записана перекрашенная тема
      dest = "/home/dnoskov/.config/awesome/themes/medusa/test",
      -- Место, куда будет создан симлинк на тему, которая находится в paths.dest
      symlinkto = "/home/dnoskov/.icons/awesome-icon-theme-test"
   },
   patterns = { ".+svg$", ".+png$", "arch", "debian", "fedora", "gentoo", "gnome", "ubuntu", "zenwalk" },
   index = {
      Icon_Theme = {
	 Name = "awesome-icon-theme"
      }
   },
   settings = {
      alternatives = {
	 folders = "acyl_1",
	 logos = { "fedora", 
	    "real_icons/apps/checkbox-gtk.svg", "real_icons/places/distributor-logo.svg", "real_icons/apps/start-here.svg"
	 },
	 navigation = "moblin"
      },
      applications = { }
   },
   data = {
      [1] = { 
	 patterns = { ".+" },
	 template = "/home/dnoskov/.config/awesome/themes/medusa/icons/one_color_flat.xml",
	 variables = { color = "#00AAFF" }
      },
      [2] = {
	 patterns = { ".+folder.+" },
	 template = "/home/dnoskov/.config/awesome/themes/medusa/icons/one_color_flat.xml",
	 variables = { color = "#aaAA00" }
      },
      [3] = {
	 patterns = { ".+real_icons/actions/Close%.svg" },
	 template = "/home/dnoskov/.config/awesome/themes/medusa/icons/one_color_flat.xml",
	 variables = { color = "#FF0000" }
      }
   }
}


local function getIcons (pth, ptn, tab)
   tab = tab or {}

   local function expandDots (relpath, abspath)
      rptab = relpath:split("/")
      aptab = string.gsub(abspath, 
			  utils.escape("/"..path.basename(abspath)), 
			  ""):split("/")
      for i, part in pairs(rptab) do
	 if part == ".." then
	    table.remove(aptab)
	    table.remove(rptab, i)
	 elseif part == "." then
	    table.remove(rptab, i)
	 end
      end
      return table.concat(aptab, "/") .. "/" .. table.concat(rptab, "/")
   end
   
   for sfn in lfs.dir(pth) do
      if sfn ~= "." and sfn ~= ".." then
	 local fp = pth .. "/" .. sfn
	 local attr = lfs.symlinkattributes(fp)
	 assert (type(attr) == "table")
	 
	 if attr.mode == "directory" then
	    getIcons(fp, ptn, tab)
	 else
	    if string.match(sfn, ptn) then
	       if attr.mode == "file" then
		  if tab[fp] == nil then tab[fp] = {} end
	       elseif attr.mode == "link" then
		  local ltn = expandDots(posix.readlink(fp), fp)
		  if tab[ltn] == nil then tab[ltn] = {} end
		  table.insert(tab[ltn], fp)
	       end
	    end
	 end
      end
   end
end

local function createPaths (icons, paths)
   for icon, links in pairs(icons) do
      ip = string.gsub(string.gsub(icon, 
				   utils.escape(paths.source), 
				   paths.dest), 
		       utils.escape("/"..path.basename(icon)), 
		       "")
      if not path.exists(ip) then dir.makepath(ip) end
      for link in List.iter(links) do
	 lp = string.gsub(string.gsub(link,
				      utils.escape(paths.source),
				      paths.dest), 
			  utils.escape("/"..path.basename(link)),
			  "")
	 if not path.exists(lp) then dir.makepath(lp) end
      end
   end
end

local function redrawIcons (icons, paths, data)
   for si, sil in pairs(icons) do
      sirn = string.gsub(si, paths.source.."/scalable/", "")
      di = string.gsub(si, utils.escape(paths.source), paths.dest)

      for i, sett in ipairs(data) do
	 for i, pat in ipairs(sett.patterns) do
	    if string.match(di, pat) or string.match(path.basename(di), pat) then
	       if path.exists(sett.template) then
		  tpl = text.Template(utils.readfile(sett.template))
		  rs = "<acyl-settings>\n" .. tpl:substitute(sett.variables) .. "</acyl-settings>\n"
	       else print("FAIL: Template "..sett.template.." not found") end
	    end
	 end
      end
      
      ss = utils.readfile(si)
      ds = string.gsub(ss, "<acyl%-settings>.*</acyl%-settings>", rs)

      sirp = string.gsub(sirn, utils.escape("/"..path.basename(sirn)), "")
      dp = paths.dest .. "/scalable/" .. sirp
      if not path.exists(dp) then
	 print(dp .. " not exist. Attempting to create.")
   	 dir.makepath(dp)
      end
      utils.writefile(di, ds)
   end
end

local function symLink (icons, paths)
   for icon, links in pairs(icons) do
      local slp = string.gsub(icon, utils.escape(paths.source), paths.dest)
      for link in List.iter(links) do
	 local tlp = string.gsub(link, utils.escape(paths.source), paths.dest)
	 posix.link(slp, tlp, true)
      end      
   end
   if path.exists(paths.symlinkto) then 
      posix.unlink(paths.symlinkto)
   end
   posix.link(paths.dest, paths.symlinkto, true)
end

local function rebase (bpath, nbpath)
   if not path.exists(nbpath) then
      dir.makepath(nbpath)
   end
   for file in lfs.dir(bpath) do
      if file ~= "." and file ~= ".." then
	 local fp = bpath .. "/" .. file
	 local nfp = nbpath .. "/" .. file
	 local attr = lfs.attributes(fp)
	 assert(type(attr)=="table")
	 if attr.mode == "directory" then
	    if not path.exists(nfp) then
	       dir.makepath(nfp)
	    end
	    rebase (fp, nfp)
	 else
	    dir.copyfile(fp, nfp)
	 end
      end
   end
end

local function applySettings (settings, paths)
   dp = paths.dest .. "/scalable/"
   for sett, op in pairs(settings) do
      if sett == "alternatives" then
	 for alt, sel in pairs(op) do
	    altpath = dp .. "alternative_icons/" .. alt
	    if alt == "folders" then
	       local bpath = altpath .. "/" .. sel
	       local nbpath = dp .. "real_icons"
	       rebase(bpath, nbpath)
	    elseif alt == "logos" then
	       for i, l in ipairs(sel) do
		  if i ~= 1 then
		     dir.copyfile(altpath .. "/" .. sel[1], dp .. sel[i])
		  end
	       end
	    elseif alt == "navigation" then
	       local bpath = altpath .. "/" .. sel
	       local nbpath = dp .. "real_icons/actions"
	       rebase(bpath, nbpath)
	    end
	 end
      end
   end
end

local function genIndex (index, paths)
   idxf = utils.readfile(paths.source .. "/index.theme")
   utils.writefile(paths.dest .. "/index.theme", string.gsub(idxf, "AnyColorYouLike", index.Icon_Theme.Name))
end

function acyl.Apply (cfg)
   io.write("Применение настроек темы иконок Any Color You Like .. \n")
   for pattern in List.iter(cfg.patterns) do
      io.write("Получение списка иконок для шаблона \"" .. pattern .. "\" .. ")
      getIcons (cfg.paths.source, pattern, cfg.icons)
      io.write("ГОТОВО.\n")
   end
   io.write("Обновление путей .. ")
   createPaths   (cfg.icons, cfg.paths)
   io.write("ГОТОВО.\n")

   io.write("Перекрашивание иконок .. ")
   redrawIcons   (cfg.icons, cfg.paths, cfg.data)
   io.write("ГОТОВО.\n")

   io.write("Применение настроек .. ")
   applySettings (cfg.settings, cfg.paths)
   io.write("ГОТОВО.\n")

   io.write("Создание симлинка .. ")
   symLink       (cfg.icons, cfg.paths)
   io.write("ГОТОВО.\n")

   io.write("Создание индекса новой темы .. ")
   genIndex      (cfg.index, cfg.paths)
   io.write("ГОТОВО.\n")
   io.write(".. ГОТОВО.\n")
end

return acyl

