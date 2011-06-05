---------------------------------
--  "Medusa" awesome theme     --
-- By Dmitriy Noskov (dnoskov) --
---------------------------------

-- {{{ Main
theme             = {}
theme.name        = "Medusa"
theme.path        = awful.util.getdir("config") .. "/themes/" .. theme.name:lower()

theme.configs         = {}
theme.configs.gtk     = os.getenv("HOME") .. "/.gtkcolors"
theme.configs.xcolors = os.getenv("HOME") .. "/.Xcolors"


theme.wallpaper_cmd = { "awsetbg " .. theme.path .. "/wallpaper.jpg" }
-- }}}

-- {{{ Styles
theme.font      = "Monospace 8"

-- {{{ Colors
theme.colors    = parsepalette(theme.path .. "/palette.gpl" )
local c = theme.colors

theme.fg_normal = c["pattens blue"]
theme.fg_focus  = c["stratos4"]
theme.fg_urgent = c["pattens blue"]
theme.bg_normal = c["gunmetal"]
theme.bg_focus  = c["bunker"]
theme.bg_urgent = c["stratos3"]
-- }}}

gtk_color_scheme = 
   'gtk_color_scheme ="fg_color:'..theme.fg_normal
   ..'\\nbg_color:'..theme.bg_focus
   ..'\\nbase_color:'..c["dark slate"]
   ..'\\ntext_color:'..theme.fg_normal
   ..'\\nselected_bg_color:'..theme.fg_focus
   ..'\\nselected_fg_color:'..theme.bg_focus
   ..'\\ntooltip_fg_color:'..theme.fg_normal
   ..'\\ntooltip_bg_color:'..theme.bg_focus
   ..'"'

gtkcolorfile = io.open(theme.configs.gtk, "w")
gtkcolorfile:write(gtk_color_scheme)
gtkcolorfile:flush()
gtkcolorfile:close()


-- Xcolors
Xcolors = "!! " .. theme.name
   .. "\n" .. "*foreground:" .. theme.fg_normal
   .. "\n" .. "*background:" .. theme.bg_focus
   .. "\n" .. "!black"
   .. "\n" .. "*color0:" .. theme.bg_focus
   .. "\n" .. "*color8:" .. c["black russian"]
   .. "\n" .. "!red"
   .. "\n" .. "*color1:" .. c["rouge"]
   .. "\n" .. "*color9:" .. c["zest"]
   .. "\n" .. "!green"
   .. "\n" .. "*color2:" .. c["kaitoke green"]
   .. "\n" .. "*color10:" .. c["fruit salad"]
   .. "\n" .. "!brown/yellow"
   .. "\n" .. "*color3:" .. c["nugget"]
   .. "\n" .. "*color11:" .. c["Dark Khaki"]
   .. "\n" .. "!blue"
   .. "\n" .. "*color4:" .. c["stratos2"]
   .. "\n" .. "*color12:" .. c["stratos4"]
   .. "\n" .. "!magenta"
   .. "\n" .. "*color5:" .. c["jagger"]
   .. "\n" .. "*color13:" .. c["fuchsia"]
   .. "\n" .. "!cyan" 
   .. "\n" .. "*color6:" .. c["bismark"]
   .. "\n" .. "*color14:" .. c["blue haze"]
   .. "\n" .. "!white"
   .. "\n" .. "*color7:" .. c["pattens blue"]
   .. "\n" .. "*color15:" .. "#ffffff\n"

xcolorsfile = io.open(theme.configs.xcolors, "w")
xcolorsfile:write(Xcolors)
xcolorsfile:flush()
xcolorsfile:close()


table.foreach(theme.configs, print)


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

return theme
