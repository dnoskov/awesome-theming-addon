---------------------------------
--  "Oxygen" awesome theme     --
-- By Dmitriy Noskov (dnoskov) --
---------------------------------

-- Alternative icon sets and widget icons:
--  * http://awesome.naquadah.org/wiki/Nice_Icons


-- {{{ Main
theme = {}
theme.wallpaper_cmd = { "awsetbg /home/dnoskov/share/images/wallpapers/min/dust.png" }
-- }}}

-- {{{ Styles
theme.font      = "Monospace 8"

-- {{{ Colors
c = {
   orange     = "#c6551c",
   black      = "#343b36",
   grey       = "#505b54",
   greengrey  = "#536251",
   darkgreen  = "#728D5F",
   green      = "#98bb6b",
   lightgreen = "#bbd099",
   lightgrey  = "#D2D2D2"
}

theme.fg_normal = c.lightgrey
theme.fg_focus  = c.lightgreen
theme.fg_urgent = c.lightgrey
theme.bg_normal = c.grey
theme.bg_focus  = c.black
theme.bg_urgent = c.orange
-- }}}

-- {{{ Borders
theme.border_width  = "1"
theme.border_normal = c.greengrey
theme.border_focus  = c.black
theme.border_marked = c.orange
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
theme.taglist_squares_sel   = "/home/dnoskov/.config/awesome/themes/darkcamo/taglist/squarefz.png"
theme.taglist_squares_unsel = "/home/dnoskov/.config/awesome/themes/darkcamo/taglist/squarez.png"
theme.taglist_squares_resize = "false"
-- }}}

-- {{{ Misc
theme.awesome_icon           = "/home/dnoskov/.config/awesome/themes/darkcamo/awesome-icon.png"
theme.menu_submenu_icon      = "/home/dnoskov/.config/awesome/themes/darkcamo/submenu.png"
theme.tasklist_floating_icon = "/home/dnoskov/.config/awesome/themes/darkcamo/floatingw.png"
-- }}}

-- {{{ Layout
theme.layout_tile       = "/home/dnoskov/.config/awesome/themes/darkcamo/layouts/tile.png"
theme.layout_tileleft   = "/home/dnoskov/.config/awesome/themes/darkcamo/layouts/tileleft.png"
theme.layout_tilebottom = "/home/dnoskov/.config/awesome/themes/darkcamo/layouts/tilebottom.png"
theme.layout_tiletop    = "/home/dnoskov/.config/awesome/themes/darkcamo/layouts/tiletop.png"
theme.layout_fairv      = "/home/dnoskov/.config/awesome/themes/darkcamo/layouts/fairv.png"
theme.layout_fairh      = "/home/dnoskov/.config/awesome/themes/darkcamo/layouts/fairh.png"
theme.layout_spiral     = "/home/dnoskov/.config/awesome/themes/darkcamo/layouts/spiral.png"
theme.layout_dwindle    = "/home/dnoskov/.config/awesome/themes/darkcamo/layouts/dwindle.png"
theme.layout_max        = "/home/dnoskov/.config/awesome/themes/darkcamo/layouts/max.png"
theme.layout_fullscreen = "/home/dnoskov/.config/awesome/themes/darkcamo/layouts/fullscreen.png"
theme.layout_magnifier  = "/home/dnoskov/.config/awesome/themes/darkcamo/layouts/magnifier.png"
theme.layout_floating   = "/home/dnoskov/.config/awesome/themes/darkcamo/layouts/floating.png"
-- }}}

-- {{{ Titlebar
-- theme.titlebar_close_button_focus  = "/home/dnoskov/.config/awesome/themes/darkcamo/titlebar/close_focus.png"
-- theme.titlebar_close_button_normal = "/home/dnoskov/.config/awesome/themes/darkcamo/titlebar/close_normal.png"

-- theme.titlebar_ontop_button_focus_active  = "/home/dnoskov/.config/awesome/themes/darkcamo/titlebar/ontop_focus_active.png"
-- theme.titlebar_ontop_button_normal_active = "/home/dnoskov/.config/awesome/themes/darkcamo/titlebar/ontop_normal_active.png"
-- theme.titlebar_ontop_button_focus_inactive  = "/home/dnoskov/.config/awesome/themes/darkcamo/titlebar/ontop_focus_inactive.png"
-- theme.titlebar_ontop_button_normal_inactive = "/home/dnoskov/.config/awesome/themes/darkcamo/titlebar/ontop_normal_inactive.png"

-- theme.titlebar_sticky_button_focus_active  = "/home/dnoskov/.config/awesome/themes/darkcamo/titlebar/sticky_focus_active.png"
-- theme.titlebar_sticky_button_normal_active = "/home/dnoskov/.config/awesome/themes/darkcamo/titlebar/sticky_normal_active.png"
-- theme.titlebar_sticky_button_focus_inactive  = "/home/dnoskov/.config/awesome/themes/darkcamo/titlebar/sticky_focus_inactive.png"
-- theme.titlebar_sticky_button_normal_inactive = "/home/dnoskov/.config/awesome/themes/darkcamo/titlebar/sticky_normal_inactive.png"

-- theme.titlebar_floating_button_focus_active  = "/home/dnoskov/.config/awesome/themes/darkcamo/titlebar/floating_focus_active.png"
-- theme.titlebar_floating_button_normal_active = "/home/dnoskov/.config/awesome/themes/darkcamo/titlebar/floating_normal_active.png"
-- theme.titlebar_floating_button_focus_inactive  = "/home/dnoskov/.config/awesome/themes/darkcamo/titlebar/floating_focus_inactive.png"
-- theme.titlebar_floating_button_normal_inactive = "/home/dnoskov/.config/awesome/themes/darkcamo/titlebar/floating_normal_inactive.png"

-- theme.titlebar_maximized_button_focus_active  = "/home/dnoskov/.config/awesome/themes/darkcamo/titlebar/maximized_focus_active.png"
-- theme.titlebar_maximized_button_normal_active = "/home/dnoskov/.config/awesome/themes/darkcamo/titlebar/maximized_normal_active.png"
-- theme.titlebar_maximized_button_focus_inactive  = "/home/dnoskov/.config/awesome/themes/darkcamo/titlebar/maximized_focus_inactive.png"
-- theme.titlebar_maximized_button_normal_inactive = "/home/dnoskov/.config/awesome/themes/darkcamo/titlebar/maximized_normal_inactive.png"
-- }}}
-- }}}

return theme
