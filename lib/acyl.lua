
list       = {}
list.files = {}

-- находит в директории path все файлы (не симлинки), соответствующие
-- шаблону pattern и возвращает их список
function list:refresh (path, pattern)	
   for file in lfs.dir(path) do
      if file ~= "." and file ~= ".." then
	 local pf = path .. "/" .. file
	 attrs = lfs.symlinkattributes (pf)
	 if attrs.mode == "directory" then
	    list:refresh(pf, pattern)
	 elseif attrs.mode == "file" and string.match(file, pattern) then
	    table.insert(list.files, pf)
	 end
      end
   end
end

module("spikes")
