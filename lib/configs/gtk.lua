local utils = require 'pl.utils'
local gtk = {}

local test = {
   file = os.getenv("HOME") .. "/.gtkrc-2.0",
   data = {
      ["gtk-theme-name"]        = '"Termlike"',
      ["gtk_color_scheme"] = {
	 ["fg_color"]          = "#ff0000",
	 ["bg_color"]          = "#ff0000",
	 ["base_color"]        = "#ff0000",
	 ["text_color"]        = "#ff0000",
	 ["selected_bg_color"] = "#ff0000",
	 ["selected_fg_color"] = "#ff0000",
	 ["tooltip_fg_color"]  = "#ff0000",
	 ["tooltip_bg_color"]  = "#ff0000",
      },
      ["gtk-icon-theme-name"]   = '"ACYL_Icon_Theme_0.9.3"',
      ["gtk-font-name"]         = '"Sans 8"',
      ["gtk-cursor-theme-name"] = '"OpenZone_Black_Slim"',
      ["gtk-cursor-theme-size"] = 0,
      ["gtk-toolbar-style"]     = "GTK_TOOLBAR_BOTH_HORIZ",
      ["gtk-toolbar-icon-size"] = "GTK_ICON_SIZE_LARGE_TOOLBAR",
      ["gtk-button-images"]     = "1",
      ["gtk-menu-images"]       = "1",
      ["gtk-enable-event-sounds"] = "1",
      ["gtk-enable-input-feedback-sounds"] = "1",
      ["gtk-xft-antialias"]     = "1",
      ["gtk-xft-hinting"]       = "1",
      ["gtk-xft-hintstyle"]     = '"hintfull"',
      ["gtk-xft-rgba"]          = '"rgb"',
   }
}

local function getString (data)
   cfgstr = ""
   scheme = ""
   for k, v in pairs(data) do
      if k == "gtk_color_scheme" then
	 scheme = k .. " =\""
	 for m, n in pairs(v) do
	    scheme = scheme .. m .. ":" .. tostring(n) .. "\\n"
	 end
	 scheme = scheme .. "\"\n"
      else
	 cfgstr = cfgstr .. k .. " = " .. tostring(v) .. "\n"
      end
   end
   return cfgstr .. scheme
end

function gtk.test ()
   print(getString(test.data))
end

function gtk.Apply (cfg)
   utils.writefile(cfg.file, getString(cfg.data))
end


return gtk