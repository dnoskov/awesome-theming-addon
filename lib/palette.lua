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



module("palette")
