require 'lfs'
require 'pl'
local acyl       = {
   test = {
      files = {},
      path = { os.getenv("HOME") .. "/.icons/ACYL_Icon_Theme_0.9.3" },
      patterns = { ".+svg$", ".+png$"},
   }
}

-- находит в директории cfg.path все файлы (не симлинки), соответствующие
-- каждому шаблону cfg.patterns и записывает в таблицу cfg.files полученный
-- список файлов
function acyl.appendFiles (cfg)
   local function getlist (pth, ptn)
      for filename in lfs.dir(pth) do
	 if filename ~= "." and filename ~= ".." then
	    local fpath = pth .. "/" .. filename
	    local attr = lfs.symlinkattributes(fpath)
	    assert (type(attr) == "table")
	    if attr.mode == "directory" then
	       getlist(fpath, ptn)
	    elseif attr.mode == "file" then
	       if string.match(filename, ptn) then
		  table.insert(cfg.files, fpath)
	       end
	    end
	 end
      end
   end

   for ipath in List.iter(cfg.path) do
      for patrn in List.iter(cfg.patterns) do
	 getlist(ipath, patrn)
      end
   end   
end

function acyl.resetFileList (cfg)
   cfg.files = {}
end

return acyl

