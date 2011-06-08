module(..., package.seeall)

configs.gtktest = {
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

function configs.getGTKrcString (gtkconfig)
   cfgstr = ""
   scheme = ""
   for k, v in pairs(gtkconfig) do
      if k == "gtk_color_scheme" then
	 scheme = k .. " =\""
	 for m, n in pairs(v) do
	    scheme = scheme .. m .. ":" .. n .. "\\n"
	 end
	 scheme = scheme .. k .. "\"\n"
      else
	 cfgstr = cfgstr .. k .. " = " .. v .. "\n"
      end
   end
   return cfgstr .. scheme
end

configs.testxcolors = {
   ["foreground"] = "#dbe1ee",
   ["background"] = "#1b1e21",
   ["color0"] = "#1b1e21",
   ["color8"] = "#16141e",
   ["color1"] = "#b04734",
   ["color9"] = "#c9756a",
   ["color2"] = "#234c19",
   ["color10"] = "#5ea02f",
   ["color3"] = "#b09a34",
   ["color11"] = "#c9b56a",
   ["color4"] = "#1e445e",
   ["color12"] = "#6caabf",
   ["color5"] = "#501b39",
   ["color13"] = "#a6409d",
   ["color6"] = "#637287",
   ["color14"] = "#b1bacb",
   ["color7"] = "#dbe1ee",
   ["color15"] = "#ffffff",
}


function configs.getXcolorsString (xcolorsdata)
   cfgstr = ""
   for k, v in pairs(xcolorsdata) do
      cfgstr = cfgstr .. "*" .. k .. ":" .. v .. "\n"
   end
   return cfgstr
end

function configs.xcolorsApply (file)
   return os.execute("xrdb -merge " .. os.getenv("HOME") .. file)
end