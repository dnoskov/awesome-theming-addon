local actions = require 'actions'
local gtkcfg = {}


function getString (data)
   for k, v in pairs(data) do
      if k == "gtk_color_scheme" then
	 scheme = k .. " =\""
	 for m, n in pairs(v) do
	    scheme = scheme .. m .. ":" .. tostring(n) .. "\\n"
	 end
	 scheme = scheme .. k .. "\"\n"
      else
	 cfgstr = cfgstr .. k .. " = " .. tostring(v) .. "\n"
      end
   end
   return cfgstr .. scheme
end

function gtkcfg.Apply (cfg)
   
end


return gtkcfg