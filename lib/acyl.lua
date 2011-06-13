require 'lfs'
require 'pl'
stringx.import()
require 'vardump'
local posix = require 'posix'


local acyl = {
   test = {
      icons = {},
      links = {},
      paths = { 
	 source = os.getenv("HOME") .. "/.icons/ACYL_Icon_Theme_0.9.3",
	 dest = "/home/dnoskov/.config/awesome/themes/medusa/icons",
	 symlinkto = "/home/dnoskov/.icons/awesome-icon-theme"
      },
      patterns = { ".+svg$", ".+png$"},
      index = {
	 Icon_Theme = {
	    Name = "awesome-icon-theme"
	 }
      },
      data = {
	 ['all'] = {
	    template = "/home/dnoskov/.config/awesome/themes/medusa/icons/one_color_flat.xml",
	    color = "#00AAFF"
	 },
	 ['real_icons/actions/Close.svg'] = {
	    template = "/home/dnoskov/.config/awesome/themes/medusa/icons/one_color_flat.xml",
	    color = "#FF0000"
	 }
      }
   }
}

function acyl.maintainIcons (cfg)
   -- esc(str) экранирует символы ^$()%.*+-? в строке str
   local function esc(str)
      res = ""
      for char in List.iter(str) do
	 if string.match(char, "[%^%$%(%)%%%.%[%]%*%+%-%?]") then
	    res = res .. "%" .. char
	 else res = res .. char end
      end
      return res
   end

   -- convertdots(fpath, lpath) - преобразует относительный путь fpath в абсолютный,
   -- исходя из того, что этот путь задан относительно пути lpath
   local function convertdots(fpath, lpath)
      fpathtab = string.gsub(fpath, esc(path.basename(fpath)), ""):split("/")
      lpathtab = string.gsub(lpath, esc(path.basename(lpath)), ""):split("/")
      for it in List.iter(fpathtab) do
	 if it == ".." then
	    table.remove(lpathtab)
	 end
      end
      table.remove(fpathtab, 1)
      res = table.concat(lpathtab, "/") .. "/" ..  table.concat(fpathtab, "/") .. "/" .. path.basename(fpath)
      return res
   end

   -- Заполнение cfg.icons и сfg.links
   local function getlist (pth, ptn)
      for sourcefn in lfs.dir(pth) do
	 if sourcefn ~= "." and sourcefn ~= ".." then
	    local fpath = pth .. "/" .. sourcefn
	    local attr = lfs.symlinkattributes(fpath)
	    assert (type(attr) == "table")
	    
	    if attr.mode == "directory" then
	       getlist(fpath, ptn)
	    
	    elseif attr.mode == "file" then
	       if string.match(sourcefn, ptn) then
		  if cfg.icons[fpath] == nil then
		     cfg.icons[fpath] = {}
		  end
	       end
	    
	    elseif attr.mode == "link" then
	       if string.match(sourcefn, ptn) then
		  local linkattr = lfs.attributes(fpath)
		  assert (type(linkattr) == "table")
		  local fname = posix.readlink(fpath)
		  fname = convertdots(fname, fpath)
		  if cfg.icons[fname] == nil then
		     cfg.icons[fname] = {}
		  end 
		  table.insert(cfg.icons[fname], fpath)
	       end
	    end
	 end
      end
   end

   for pattern in List.iter(cfg.patterns) do
      getlist(cfg.paths.source, pattern)
   end
   -- cfg.icons заполнена

   -- Создание структуры директорий
   for icon, links in pairs(cfg.icons) do
      pth = string.gsub(string.gsub(icon, esc(cfg.paths.source), cfg.paths.dest), esc(path.basename(icon)), "")
      if not path.exists(pth) then dir.makepath(pth) end
      for link in List.iter(links) do
	 lpath = string.gsub(string.gsub(link, esc(cfg.paths.source), cfg.paths.symlinkto), "/"..esc(path.basename(link)), "")
	 if not path.exists(lpath) then dir.makepath(lpath) end
      end
   end

   -- Запись иконок
   for srcIcon, iconLinks in pairs(cfg.icons) do
      iconRelativeName = string.gsub(srcIcon, cfg.paths.source.."/scalable/", "")
      -- Выбор шаблона
      tpl = text.Template(utils.readfile(cfg.data['all'].template))
      replStr = "<acyl-settings>\n"..tpl:substitute(cfg.data['all']).."\n</acyl-settings>\n"
      if cfg.data[iconRelativeName] ~= nil then
	 print("match!")
	 tpl = text.Template(utils.readfile(cfg.data[iconRelativeName].template))
	 replStr = "<acyl-settings>\n"..tpl:substitute(cfg.data[iconRelativeName]).."\n</acyl-settings>\n"
      end
      srcStr = utils.readfile(srcIcon)
      destStr = string.gsub(srcStr, "<acyl%-settings>.*</acyl%-settings>", replStr)

      -- Задание пути и запись файла
      iconRelativePath = string.gsub(iconRelativeName, esc("/"..path.basename(iconRelativeName)), "")
      destPath = cfg.paths.dest .. "/scalable/" .. iconRelativePath
      if not path.exists(destPath) then
   	 io.write("Attempting to create path ... " .. destPath)
   	 dir.makepath(destPath)
   	 io.write("Done.\n")
      end
      destIcon = string.gsub(srcIcon, cfg.paths.source, cfg.paths.dest)
      utils.writefile(destIcon, destStr)
      if string.match(srcIcon, "folder") then
	 local file = "/home/dnoskov/acyllog"
	 local str = ""
	 if path.exists(file) then
	    str = utils.readfile(file)
	 end
	 str = str .. srcIcon .. "\n" .. pretty.write(iconLinks) .. replStr
	 utils.writefile(file, str)
      end
   end

   -- Создание индекса темы иконок (index.theme)
   -- local function genindex (indexOrig, indexConfig)
   --    for iI1, iC1 in pairs(indexOrig) do
   -- 	 for iI2, iC2 in pairs(indexConfig) do
   -- 	    if iI1 == iI2 then 
   -- 	       if type(iC1) == type(iC2) then 
   -- 		  if type(iC1) == "table" and type(iC2) == "table" then
   -- 		     genindex(iC1, iC2)
   -- 		  else
   -- 		     indexOrig[iI1] = iC2
   -- 		  end
   -- 	       else print("Type mismatch! Skipping index generation.") end
   -- 	    end
   -- 	 end
   --    end
   -- end
   -- Нормальную генерацию индекса сделаю потОм!

   index = utils.readfile(cfg.paths.source .. "/index.theme")
   index = string.gsub(index, "Name=AnyColorYouLike", "Name="..cfg.index.Icon_Theme.Name)
   utils.writefile(cfg.paths.dest .. "/index.theme", index)


   -- Создание симлинков
   dir.copyfile(cfg.paths.dest .. "/index.theme", cfg.paths.symlinkto .. "/index.theme")
   for icon, links in pairs(cfg.icons) do
      local srcLinkPath = string.gsub(icon, esc(cfg.paths.source), cfg.paths.dest)
      for link in List.iter(links) do
	 trgLinkPath = string.gsub(link, esc(cfg.paths.source), cfg.paths.symlinkto)
	 posix.link(srcLinkPath, trgLinkPath, true)
      end      
   end
   
end

return acyl

