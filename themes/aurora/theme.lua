---------------------------------
--  "Aurora" awesome theme     --
-- By Dmitriy Noskov (dnoskov) --
---------------------------------
local cfgs = require "configs"
local palette = require "palette"
require 'colors'
require 'pl'

-- {{{ Main

theme = {}
theme.name       = "Aurora"
theme.path       = awful.util.getdir("config") .. "/themes/" .. theme.name:lower()

cfgs.gtk.cfg     = {
   -- Таблица, содержащая все файлы, которые нужно модифицировать в данной конфигурации
   file = os.getenv("HOME") .. "/.gtkrc-2.0",
   
   -- В этой таблице содержатся настройки конфигурации, необходимые указанным выше функциям (см. ниже)
   data  = {},
}
cfgs.xcolors.cfg = {
   file    = os.getenv("HOME") .. "/.Xcolors" ,
   data    = {},
}
cfgs.acyl.cfg = {
   icons = {},
   paths = { 
      -- Путь, откуда будут браться иконки (строго говоря, не обязательно acyl)
      source = os.getenv("HOME") .. "/.icons/ACYL_Icon_Theme_0.9.3",
      -- Путь, куда будут помещаться перекрашенные иконки
      dest = theme.path .. "/icons",
      -- Имя симлинка, который будет указывать на dest
      symlinkto = os.getenv("HOME") .. "/.icons/awesome-icon-theme"
   },
   patterns = { ".+svg$", ".+png$", "arch", "debian", "fedora", "gentoo", "gnome", "ubuntu", "zenwalk" },
   index = {
      Icon_Theme = {
	 Name = "awesome-icon-theme"
      }
   },
   settings = {
      alternatives = {
	 folders = "acyl_2",
	 logos = { "arch", 
	    "real_icons/apps/checkbox-gtk.svg", "real_icons/places/distributor-logo.svg", "real_icons/apps/start-here.svg"
	 },
	 navigation = "moblin"
      },
      applications = { }
   },
   data = {},
}



theme.wallpaper_cmd = { "awsetbg " .. theme.path .. "/wallpaper.jpg" }
-- }}}

-- {{{ Styles
theme.font      = "Monospace 8"

-- {{{ Colors
theme.colorobjects    = palette.parse(theme.path .. "/palette.gpl" )
theme.colors = {}
for clrname, clrobj in pairs(theme.colorobjects) do
   theme.colors[clrname] = tostring(clrobj)
end
local c = theme.colors


theme.fg_normal = c["fg_normal"]--
theme.fg_focus  = c["fg_focus"]--
theme.fg_urgent = c["fg_urgent"]--
theme.bg_normal = c["bg_normal"]--
theme.bg_focus  = c["bg_focus"]--
theme.bg_urgent = c["bg_urgent"]--
-- }}}


-- {{{ Borders
theme.border_width  = "1"
theme.border_normal = theme.bg_normal
theme.border_focus  = theme.bg_focus
theme.border_marked = theme.bg_urgent
-- }}}

-- {{{ Titlebars
theme.titlebar_bg_focus  = "#3F3F3F"
theme.titlebar_bg_normal = "#3F3F3F"
-- }}}

-- There are other variable sets
-- overriding the default one when
-- defined, the sets are:
-- [taglist|tasklist]_[bg|fg]_[focus|urgent]
-- titlebar_[normal|focus]
-- tooltip_[font|opacity|fg_color|bg_color|border_width|border_color]
-- Example:
--theme.taglist_bg_focus = "#CC9393"
-- }}}

-- {{{ Widgets
-- You can add as many variables as
-- you wish and access them by using
-- beautiful.variable in your rc.lua
--theme.fg_center_widget = "#88A175"
--theme.fg_end_widget    = "#FF5656"
theme.bg_widget          = theme.bg_focus
theme.border_widget      = theme.fg_focus
-- }}}

-- {{{ Mouse finder
theme.mouse_finder_color = "#CC9393"
-- mouse_finder_[timeout|animate_timeout|radius|factor]
-- }}}

-- {{{ Menu
-- Variables set for theming the menu:
-- menu_[bg|fg]_[normal|focus]
-- menu_[border_color|border_width]
theme.menu_height = "15"
theme.menu_width  = "150"
theme.menu_border_color = theme.bg_normal
-- }}}

-- {{{ Icons
-- {{{ Taglist
theme.taglist_squares_sel   = theme.path .. "/taglist/squarefz.png"
theme.taglist_squares_unsel = theme.path .. "/taglist/squarez.png"
theme.taglist_squares_resize = "false"
-- }}}

-- {{{ Misc
theme.awesome_icon           = theme.path .. "/awesome-icon.png"
theme.menu_submenu_icon      = theme.path .. "/submenu.png"
theme.tasklist_floating_icon = theme.path .. "/floatingw.png"
-- }}}

-- {{{ Layout
theme.layout_tile       = theme.path .. "/layouts/tile.png"
theme.layout_tileleft   = theme.path .. "/layouts/tileleft.png"
theme.layout_tilebottom = theme.path .. "/layouts/tilebottom.png"
theme.layout_tiletop    = theme.path .. "/layouts/tiletop.png"
theme.layout_fairv      = theme.path .. "/layouts/fairv.png"
theme.layout_fairh      = theme.path .. "/layouts/fairh.png"
theme.layout_spiral     = theme.path .. "/layouts/spiral.png"
theme.layout_dwindle    = theme.path .. "/layouts/dwindle.png"
theme.layout_max        = theme.path .. "/layouts/max.png"
theme.layout_fullscreen = theme.path .. "/layouts/fullscreen.png"
theme.layout_magnifier  = theme.path .. "/layouts/magnifier.png"
theme.layout_floating   = theme.path .. "/layouts/floating.png"
-- }}}

-- {{{ Titlebar
-- theme.titlebar_close_button_focus  = theme.path .. "/titlebar/close_focus.png"
-- theme.titlebar_close_button_normal = theme.path .. "/titlebar/close_normal.png"

-- theme.titlebar_ontop_button_focus_active  = theme.path .. "/titlebar/ontop_focus_active.png"
-- theme.titlebar_ontop_button_normal_active = theme.path .. "/titlebar/ontop_normal_active.png"
-- theme.titlebar_ontop_button_focus_inactive  = theme.path .. "/titlebar/ontop_focus_inactive.png"
-- theme.titlebar_ontop_button_normal_inactive = theme.path .. "/titlebar/ontop_normal_inactive.png"

-- theme.titlebar_sticky_button_focus_active  = theme.path .. "/titlebar/sticky_focus_active.png"
-- theme.titlebar_sticky_button_normal_active = theme.path .. "/titlebar/sticky_normal_active.png"
-- theme.titlebar_sticky_button_focus_inactive  = theme.path .. "/titlebar/sticky_focus_inactive.png"
-- theme.titlebar_sticky_button_normal_inactive = theme.path .. "/titlebar/sticky_normal_inactive.png"

-- theme.titlebar_floating_button_focus_active  = theme.path .. "/titlebar/floating_focus_active.png"
-- theme.titlebar_floating_button_normal_active = theme.path .. "/titlebar/floating_normal_active.png"
-- theme.titlebar_floating_button_focus_inactive  = theme.path .. "/titlebar/floating_focus_inactive.png"
-- theme.titlebar_floating_button_normal_inactive = theme.path .. "/titlebar/floating_normal_inactive.png"

-- theme.titlebar_maximized_button_focus_active  = theme.path .. "/titlebar/maximized_focus_active.png"
-- theme.titlebar_maximized_button_normal_active = theme.path .. "/titlebar/maximized_normal_active.png"
-- theme.titlebar_maximized_button_focus_inactive  = theme.path .. "/titlebar/maximized_focus_inactive.png"
-- theme.titlebar_maximized_button_normal_inactive = theme.path .. "/titlebar/maximized_normal_inactive.png"
-- }}}
-- }}}

cfgs.gtk.cfg.data = {
   ["gtk-theme-name"]        = '"Termlike"',
   ["gtk_color_scheme"] = {
      ["fg_color"]          = c["gtk_fg_color"],--
      ["bg_color"]          = c["gtk_bg_color"],--
      ["base_color"]        = c["gtk_base_color"],--
      ["text_color"]        = c["gtk_text_color"],--
      ["selected_bg_color"] = c["gtk_selected_bg_color"],--
      ["selected_fg_color"] = c["gtk_selected_fg_color"],--
      ["tooltip_fg_color"]  = c["gtk_tooltip_fg_color"],--
      ["tooltip_bg_color"]  = c["gtk_tooltip_bg_color"],--
   },
   ["gtk-icon-theme-name"]   = '"' .. cfgs.acyl.cfg.index.Icon_Theme.Name .. '"',
   ["gtk-font-name"]         = "\"" .. theme.font .. "\"",
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

-- Xcolors
cfgs.xcolors.cfg.data = {
   ["foreground"] = c["xc_foreground"],
   ["background"] = c["xc_background"],
   -- black
   ["color0"] = c["xc_0"],
   ["color8"] = c["xc_8"],
   -- red
   ["color1"] = c["xc_1"],
   ["color9"] = c["xc_9"],
   -- green
   ["color2"] = c["xc_2"],
   ["color10"] = c["xc_10"],
   -- brown/yellow
   ["color3"] = c["xc_3"],
   ["color11"] = c["xc_11"],
   -- blue
   ["color4"] = c["xc_4"],
   ["color12"] = c["xc_12"],
   -- magenta
   ["color5"] = c["xc_5"],
   ["color13"] = c["xc_13"],
   -- cyan
   ["color6"] = c["xc_6"],
   ["color14"] = c["xc_14"],
   -- white
   ["color7"] = c["xc_7"],
   ["color15"] = c["xc_15"],
}

local t = {
   ["one color flat"] = theme.path .. "/icons/one_color_flat.xml"
}

cfgs.acyl.cfg.data = {
   [1] = { 
      patterns = { ".+" },
      template = t["one color flat"],
      variables = { color = c["icons"] }
   },
   [2] = {
      patterns = { ".+folder.+" },
      template = t["one color flat"],
      variables = { color = c["folder"] }
   },
   [3] = {
      patterns = { ".+alternative_icons/logos/.+" },
      template = t["one color flat"],
      variables = { color = c["logo"] }
   },
   [4] = {
      patterns = { ".+navigation.+back.+", ".+navigation.+forward.+" },
      template = t["one color flat"],
      variables = { color = c["navigation"]}
   }
}


-- Включенные конфиги (раскомментируйте для отключения)
-- cfgs.gtk.cfg     = nil
-- cfgs.xcolors.cfg = nil
-- cfgs.acyl.cfg    = nil

cfgs.Apply()

-- for cfgname, cfg in pairs(cfgs) do
--    if cfg.cfg ~= nil then
--       io.write("Применяется конфигурация " .. cfgname .. " .. ")
--       cfg.Apply(cfg.cfg)
--       io.write("ГОТОВО.\n")
--    else print("Конфигурация " .. cfgname .. " отключена. Никакие действия не выполняются.") end
-- end


return theme
