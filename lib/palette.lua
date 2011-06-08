require("lxp")
require("lfs")


function parsepalette(palettefile)
   local colors = {}
   
   for cline in io.lines(palettefile) do
      if string.find(cline, "%d+%s+%d+%s+%d+") then
	 
	 local colorstring = string.match(cline, "%d+%s+%d+%s+%d+")
	 local colorpartials = {}
	 local colorname = ""
	 
	 for colorpartial in string.gmatch(colorstring, "%d+") do
	    table.insert(colorpartials, string.format("%x", colorpartial))
	 end
	 
	 colorname = string.match(cline, "%a+[^%c]+")
	 colors[colorname] = "#" .. colorpartials[1] .. colorpartials[2] .. colorpartials[3]
      end
   end
   
   return colors     
end

function replace_xml_chunk (xmlfile)
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


module("palette")
