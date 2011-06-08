module(..., package.seeall)

acyl       = {}
acyl.files = {}

-- находит в директории path все файлы (не симлинки), соответствующие
-- шаблону pattern и возвращает их список
function acyl.files.append (path, pattern)	
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

function acyl.replaceSettings (xmlfile, xmlstring)
   xmldata = ""
   for line in io.lines(xmlfile) do xmldata = xmldata .. line .. "\n" end
   callbacks = {
      StartElement  = function (parser, name, attr)
			 if name == "acyl-settings" then
			    io.write(name .. " starts\n")
			 end
		      end,
      EndElement    = function (parser, name)
			 if name == "acyl-settings" then
			    io.write(name .. " stops\n")
			 end
		      end,
      CharacterData = function (parser, string)
		      end
   }
   p = lxp.new(callbacks)
   p:parse(xmldata)
end


