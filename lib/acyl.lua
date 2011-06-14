require 'lfs'
require 'pl'
stringx.import()
local posix = require 'posix'


local acyl = {
   test = {
      icons = {},
      paths = { 
	 source = os.getenv("HOME") .. "/.icons/ACYL_Icon_Theme_0.9.3",
	 dest = "/home/dnoskov/.config/awesome/themes/medusa/test",
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
}

local function getIcons (pth, ptn, tab)
   tab = tab or {}
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

function expandDots (relpath, abspath)
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

function createPaths (icons, paths)
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

function redrawIcons (icons, paths, data)
   for si, sil in pairs(icons) do
      sirn = string.gsub(si, paths.source.."/scalable/", "")
      di = string.gsub(si, utils.escape(paths.source), paths.dest)

      for i, sett in ipairs(data) do
	 for i, pat in ipairs(sett.patterns) do
	    if string.match(di, pat) or string.match(path.basename(di), pat) then
	       tpl = text.Template(utils.readfile(sett.template))
	       rs = "<acyl-settings>\n" .. tpl:substitute(sett.variables) .. "</acyl-settings>\n"
	    end
	 end
      end
      
      ss = utils.readfile(si)
      ds = string.gsub(ss, "<acyl%-settings>.*</acyl%-settings>", rs)

      sirp = string.gsub(sirn, utils.escape("/"..path.basename(sirn)), "")
      dp = paths.dest .. "/scalable/" .. sirp
      if not path.exists(dp) then
   	 dir.makepath(dp)
      end
      utils.writefile(di, ds)
   end
end

function symLink (icons, paths)
   for icon, links in pairs(icons) do
      local slp = string.gsub(icon, utils.escape(paths.source), paths.dest)
      for link in List.iter(links) do
	 local tlp = string.gsub(link, utils.escape(paths.source), paths.dest)
	 posix.link(slp, tlp, true)
      end      
   end
   posix.link(paths.dest, paths.symlinkto, true)
end

function rebase (bpath, nbpath)
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

function applySettings (settings, paths)
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

function genIndex (index, paths)
   idxf = utils.readfile(paths.source .. "/index.theme")
   utils.writefile(paths.dest .. "/index.theme", string.gsub(idxf, "AnyColorYouLike", index.Icon_Theme.Name))
end

function acyl.Apply (cfg)
   for pattern in List.iter(cfg.patterns) do
      getIcons (cfg.paths.source, pattern, cfg.icons)
   end
   createPaths   (cfg.icons, cfg.paths)
   redrawIcons   (cfg.icons, cfg.paths, cfg.data)
   applySettings (cfg.settings, cfg.paths)
   symLink       (cfg.icons, cfg.paths)
   genIndex      (cfg.index, cfg.paths)
end

return acyl

