require 'colors'
require 'pl'
stringx.import()
local palette = {}

function palette.parse (palettefile)
   local clrs = {}
   
   for cline in io.lines(palettefile) do
      if string.find(cline, "%d+%s+%d+%s+%d+") then
	 
	 local clrstring = string.match(cline, "%d+%s+%d+%s+%d+")
	 local clrpartials = {}
	 local clrname = ""

	 clrnamestring = string.match(cline, "%a[^%c]+")

	 for clrpartial in string.gmatch(clrstring, "%d+") do
	    hpart = string.format("%2x", clrpartial)
	    if # hpart < 2 then hpart = "0" .. hpart end
	    table.insert(clrpartials, hpart)
	 end
	 
	 clrstring = "#" .. clrpartials[1] .. clrpartials[2] .. clrpartials[3]
	 for clrname in string.gmatch(clrnamestring, "[^,]+") do
	    clrs[clrname:strip()] = colors.new(clrstring)
	 end
      end
   end
   
   return clrs     
end



return palette