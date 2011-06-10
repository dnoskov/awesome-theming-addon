require("colors")
local utils = require "utils"
local palette = {}

function palette.parse (palettefile)
   local clrs = {}
   
   for cline in io.lines(palettefile) do
      if string.find(cline, "%d+%s+%d+%s+%d+") then
	 
	 local clrstring = string.match(cline, "%d+%s+%d+%s+%d+")
	 local clrpartials = {}
	 local clrname = ""
	 
	 for clrpartial in string.gmatch(clrstring, "%d+") do
	    table.insert(clrpartials, string.format("%x", clrpartial))
	 end
	 
	 clrnamestring = string.match(cline, "%a[^%c]+")
	 clrstring = "#" .. clrpartials[1] .. clrpartials[2] .. clrpartials[3]
	 for clrname in string.gmatch(clrnamestring, "[^,]+") do
	    clrs[utils.trim(clrname)] = colors.new(clrstring)
	 end
      end
   end
   
   return clrs     
end



return palette