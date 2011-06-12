require 'lfs'
require 'pl'
require 'vardump'


local acyl = {
   test = {
      icons = {

      },
      paths = { 
	 source = os.getenv("HOME") .. "/.icons/ACYL_Icon_Theme_0.9.3",
	 dest = "/home/dnoskov/.config/awesome/themes/medusa/icons",
	 symlinkto = "/home/dnoskov/.icons/awesome-icon-theme"
      },
      patterns = { ".+svg$", ".+png$"},
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
   local function esc(str)
      res = ""
      for char in List.iter(str) do
	 if string.match(char, "[%^%$%(%)%%%.%[%]%*%+%-%?]") then
	    res = res .. "%" .. char
	 else res = res .. char end
      end
      return res
   end

   -- Заполнение cfg.icons
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
		  table.insert(cfg.icons, fpath)
	       end
	    end
	 end
      end
   end

   for pattrn in List.iter(cfg.patterns) do
      getlist(cfg.paths.source, pattrn)
   end
   -- cfg.icons заполнена

  

   -- Создание структуры директорий
   -- for icon in List.iter(cfg.icons) do
   --    pth = string.gsub(string.gsub(icon, esc(cfg.paths.source), cfg.paths.dest), esc(path.basename(icon)), "")
   --    if not path.exists(pth) then dir.makepath(pth) end
   -- end

   for srcicon in List.iter(cfg.icons) do
      desticon = string.gsub(srcicon, cfg.paths.source, cfg.paths.dest)
      iconRelativePath = string.gsub(srcicon, cfg.paths.source.."/scalable/", "")
      for iconPath, iconData in pairs(cfg.data) do
	 if iconpath == iconRelativePath then
	    t = text.Template(utils.readfile(icondata.template))
	    replstr = "<acyl-settings>\n"..t:substitute(icondata).."\n</acyl-settings>\n"
	 else
	    t = text.Template(utils.readfile(cfg.data['all'].template))
	    replstr = "<acyl-settings>\n"..t:substitute(cfg.data['all']).."\n</acyl-settings>\n"
	 end
      end
      srcstr = utils.readfile(srcicon)
      deststr = string.gsub(srcstr, "<acyl%-settings>.*</acyl%-settings>", replstr)
      utils.writefile(desticon, deststr)
   end
end

return acyl

