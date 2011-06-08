-- Standard awesome library
require("awful")
require("awful.autofocus")
require("awful.rules")

rcpath = {
   awful.util.getdir("config").. "/lib/?.lua",
   awful.util.getdir("config").. "/lib/?/init.lua"
}
package.path = package.path .. ";" .. table.concat(rcpath, ";")

-- Theme handling library
require("beautiful")
-- Notification library
require("naughty")
-- Tag management
require("shifty")
-- Widgets
require("vicious")

require("scratch")


-- {{{ Variable definitions
-- Themes define colours, icons, and wallpapers
beautiful.init(awful.util.getdir("config") .. "/themes/medusa/theme.lua")

-- This is used later as the default terminal and editor to run.
config = {
   modkey        = "Mod4",
   terminal      = "urxvtcd",
   browser       = "conkeror",
   torrentclient = "deluge",
   editor        = os.getenv("EDITOR") or "editor",
   xsudo         = "gksu"
}

config.cmd = {
   editor       = config.editor .. " -c -a \"\"",
   tod          = config.terminal .. " -name terminalondemand",
   dropterminal = config.terminal .. " -name dropterminal",
   halt         = config.xsudo .. " halt",
   reboot       = config.xsudo .. " reboot"  
}

-- Default modkey.
-- Usually, Mod4 is the key with a logo between Control and Alt.
-- If you do not like this or do not have such a key,
-- I suggest you to remap Mod4 to another key using xmodmap or other tools.
-- However, you can use another modifier like Mod1, but it may interact with others.
modkey = config.modkey

-- Table of layouts to cover with awful.layout.inc, order matters.
layouts = {
   awful.layout.suit.floating,	      -- 1
   awful.layout.suit.tile,	      -- 2
   awful.layout.suit.tile.left,	      -- 3
   awful.layout.suit.tile.bottom,     -- 4
   awful.layout.suit.tile.top,	      -- 5
   awful.layout.suit.fair,	      -- 6
   awful.layout.suit.fair.horizontal, -- 7
   awful.layout.suit.spiral,	      -- 8
   awful.layout.suit.spiral.dwindle,  -- 9
   awful.layout.suit.max,	      -- 10
   awful.layout.suit.max.fullscreen,  -- 11
   awful.layout.suit.magnifier	      -- 12
}
-- }}}

-- {{{ Shifty
shifty.config.tags = {
   ["1:sys"] = { init = true, position = 1, screen = 1, mwfact = 0.60 },
   ["3:www"] = { exclusive = true, position = 3, spawn = config.browser,
                 layout = layouts[5]                                  },
   ["2:term"] = { persist = true, position = 2, layout = layouts[12]  },
   ["p2p"] = { spawn = config.torrentclient },
}

shifty.config.apps = {
   { match = { "htop", "Wicd", "jackctl"       }, tag = "1:sys",        screen = 1,     },
   { match = {"Iceweasel.*", "Firefox.*", 
	      "Conkeror.*", "uzbl", "surf", 
	      "rekonq", "luakit"               }, tag = "3:www",                        },
   { match = {"urxvt", "x-terminal-emulator",
              "xterm", "Termit"                }, tag = "2:term",       screen = 1,     },
   { match = { "dropterminal"                  }, intrusive = true, 
                                                  geometry = { nil,nil,0,32 },          },
   { match = { "terminalondemand"              }, intrusive = true                      },
   { match = { "emacs", "texmacs"              }, intrusive = true,                     },
   { match = { "Deluge","nicotine"             }, tag = "p2p",                          },
   { match = { "" }, clientbuttons = {
	 button({ }, 1, function (c) client.focus = c; c:raise() end),
	 button({ modkey }, 1, function (c) awful.mouse.client.move() end),
	 button({ modkey }, 3, awful.mouse.client.resize ), }, },
}

shifty.config.defaults = {
   layout = layouts[1],
   run = function(tag) naughty.notify({ text = tag.name, position = "bottom_right" }) end,
}

shifty.init()
-- }}}



-- {{{ Menu
-- Create a laucher widget and a main menu
myawesomemenu = {
   { "manual", config.terminal .. " -e man awesome" },
   { "edit config", config.cmd.editor .. " " .. awful.util.getdir("config") .. "/rc.lua" },
   { "restart", awesome.restart },
   { "quit", awesome.quit }
}

programsmenu ={
   {"lxappearance", "lxappearance"},
   {"PCmanFM", "pcmanfm"},
   {"AbiWord", "abiword"},
   {"Gnumeric", "gnumeric"},
   {"gcue2tracks", "gcue2tracks"},
   {"quodlibet","quodlibet"}
}

powermenu = {
   { "Reboot", config.cmd.reboot },
   { "Halt", config.cmd.halt }
}

mymainmenu = 
   awful.menu({ items = { 
		    { "awesome", myawesomemenu, beautiful.awesome_icon },
		    { "Programs", programsmenu },
		    { "Terminal", config.terminal },
		    { "Power", powermenu }
		 }
	      })

mylauncher = awful.widget.launcher({ image = image(beautiful.awesome_icon),
                                     menu = mymainmenu })
-- }}}

-- {{{ Wibox
-- Create a textclock widget
mytextclock = awful.widget.textclock({ align = "right" })

-- My AWESOME Clock
cwhours = widget({ type = "textbox", align = "left", width = "0"})
vicious.register(cwhours, vicious.widgets.date, "<span font='Monospace bold 28' color='"..beautiful.fg_focus.."'>%H</span>", 1)
cwminutes = widget({ type = "textbox", align = "left", width = "0"})
vicious.register(cwminutes, vicious.widgets.date, "<span font='Monospace bold 11' color='"..beautiful.fg_focus.."'>%M</span>", 1)
cwseconds = widget({ type = "textbox", align = "left", width = "0" })
vicious.register(cwseconds, vicious.widgets.date, "<span font='Monospace 11' color='"..beautiful.fg_focus.."'>%S</span>", 1)

-- My AWESOME Date (not so awesome for now)
cwdate = widget({ type = "textbox", align = "left", width = "0"})
vicious.register(cwdate, vicious.widgets.date, "<span font='Monospace 10' color='"..beautiful.fg_focus.."'> %a <b>%d</b> %b </span>", 1)

-- Create a systray
mysystray = widget({ type = "systray" })


-- CPU Widget
cpubar = awful.widget.progressbar()
cpubar:set_width(50)
cpubar:set_height(6)
cpubar:set_color(beautiful.fg_normal)
cpubar:set_background_color(beautiful.bg_widget)
awful.widget.layout.margins[cpubar.widget] = {top = 5}
vicious.register(cpubar, vicious.widgets.cpu, "$1")
cpucaption = widget({ type = "textbox" })
cpucaption.text = "<span weight='bold' color='" .. beautiful.fg_focus .. "'> cpu: </span>"

-- Mem Widget
membar = awful.widget.progressbar()
membar:set_width(50)
membar:set_height(6)
membar:set_color(beautiful.fg_normal)
membar:set_background_color(beautiful.bg_widget)
awful.widget.layout.margins[membar.widget] = {top = 5}
vicious.register(membar, vicious.widgets.mem, "$1", 10)
memcaption = widget({ type = "textbox" })
memcaption.text = "<span weight='bold' color='" .. beautiful.fg_focus .. "'> mem: </span>"

-- FS Widgets
fsrootbar = awful.widget.progressbar()
fsrootbar:set_width(50)
fsrootbar:set_height(6)
fsrootbar:set_color(beautiful.fg_normal)
fsrootbar:set_background_color(beautiful.bg_widget)
awful.widget.layout.margins[fsrootbar.widget] = {top = 5}
vicious.register(fsrootbar, vicious.widgets.fs, "${/ avail_p}", 10)
fsrootcaption = widget({ type = "textbox" })
vicious.register(fsrootcaption, vicious.widgets.fs, 
		 "<span weight='bold' color='" .. beautiful.fg_focus .. "'> root:</span> ${/ avail_gb}GB ", 10)

fshomebar = awful.widget.progressbar()
fshomebar:set_width(50)
fshomebar:set_height(6)
fshomebar:set_color(beautiful.fg_normal)
fshomebar:set_background_color(beautiful.bg_widget)
awful.widget.layout.margins[fshomebar.widget] = {top = 5}
vicious.register(fshomebar, vicious.widgets.fs, "${/home avail_p}", 10)
fshomecaption = widget({ type = "textbox" })
vicious.register(fshomecaption, vicious.widgets.fs, 
		 "<span weight='bold' color='" .. beautiful.fg_focus .. "'> home:</span> ${/home avail_gb}GB ", 10)

-- Net Widgets
netupgraph = awful.widget.graph()
netupgraph:set_width(50)
netupgraph:set_height(13)
netupgraph:set_color(beautiful.fg_normal)
netupgraph:set_background_color(beautiful.bg_widget)
awful.widget.layout.margins[netupgraph.widget] = {top = 2}
vicious.register(netupgraph, vicious.widgets.net, "${eth0 up_kb}", 0.28)
netupcaption = widget({ type = "textbox" })
vicious.register(netupcaption, vicious.widgets.net, " ↑: ")

netdowngraph = awful.widget.graph()
netdowngraph:set_width(50)
netdowngraph:set_height(13)
netdowngraph:set_color(beautiful.fg_normal)
netdowngraph:set_background_color(beautiful.bg_widget)
awful.widget.layout.margins[netdowngraph.widget] = {top = 2}
vicious.register(netdowngraph, vicious.widgets.net, "${eth0 down_kb}", 0.28)
netdowncaption = widget({ type = "textbox" })
vicious.register(netdowncaption, vicious.widgets.net,
		 "<span weight='bold' color='" .. beautiful.fg_focus .. "'> net</span> ↓: ")



-- Create a wibox for each screen and add it
wiboxmain = {}
wiboxclock = {}
mystatusbar = {}
mypromptbox = {}
mylayoutbox = {}
mytaglist = {}
mytaglist.buttons = awful.util.table.join(
                    awful.button({ }, 1, awful.tag.viewonly),
                    awful.button({ modkey }, 1, awful.client.movetotag),
                    awful.button({ }, 3, awful.tag.viewtoggle),
                    awful.button({ modkey }, 3, awful.client.toggletag),
                    awful.button({ }, 4, awful.tag.viewnext),
                    awful.button({ }, 5, awful.tag.viewprev)
                    )
mytasklist = {}
mytasklist.buttons = awful.util.table.join(
                     awful.button({ }, 1, function (c)
                                              if not c:isvisible() then
                                                  awful.tag.viewonly(c:tags()[1])
                                              end
                                              client.focus = c
                                              c:raise()
                                          end),
                     awful.button({ }, 3, function ()
                                              if instance then
                                                  instance:hide()
                                                  instance = nil
                                              else
                                                  instance = awful.menu.clients({ width=250 })
                                              end
                                          end),
                     awful.button({ }, 4, function ()
                                              awful.client.focus.byidx(1)
                                              if client.focus then client.focus:raise() end
                                          end),
                     awful.button({ }, 5, function ()
                                              awful.client.focus.byidx(-1)
                                              if client.focus then client.focus:raise() end
                                          end))

for s = 1, screen.count() do
    -- Create a promptbox for each screen
    mypromptbox[s] = awful.widget.prompt({ layout = awful.widget.layout.horizontal.leftright })
    -- Create an imagebox widget which will contains an icon indicating which layout we're using.
    -- We need one layoutbox per screen.
    mylayoutbox[s] = awful.widget.layoutbox(s)
    mylayoutbox[s]:buttons(awful.util.table.join(
                          awful.button({ }, 1, function () awful.layout.inc(layouts, 1) end),
                          awful.button({ }, 3, function () awful.layout.inc(layouts, -1) end),
                          awful.button({ }, 4, function () awful.layout.inc(layouts, 1) end),
                          awful.button({ }, 5, function () awful.layout.inc(layouts, -1) end)))
    -- Create a taglist widget
    mytaglist[s] = awful.widget.taglist(s, awful.widget.taglist.label.all, mytaglist.buttons)

    -- Create a tasklist widget
    mytasklist[s] = awful.widget.tasklist(function(c)
                                              return awful.widget.tasklist.label.currenttags(c, s)
                                          end, mytasklist.buttons)
    
    -- Create the wibox
    wiboxmain[s] = awful.wibox({ height=32, width=1215, screen = s, ontop = false })
    wiboxclock[s] = awful.wibox({ height=32, width=80, x= 1215, screen = s })
    -- Add widgets to the wibox - order matters
    wiboxmain[s].widgets = {
       {	     
	  {
	     mylayoutbox[s],
	     mytaglist[s],
	     s == 1 and mysystray or nil,
	     mypromptbox[s],
	     layout = awful.widget.layout.horizontal.leftright
	  },
	  cwdate,
	  cpubar.widget, cpucaption, 
	  membar.widget, memcaption, 
	  fshomebar.widget, fshomecaption,
	  fsrootbar.widget, fsrootcaption,
	  netupgraph.widget, netupcaption,
	  netdowngraph.widget, netdowncaption,
	  layout = awful.widget.layout.horizontal.rightleft
       },
       {
	  mytasklist[s],
	  layout = awful.widget.layout.horizontal.leftright
       },
       layout = awful.widget.layout.vertical.flex
    }
    wiboxclock[s].widgets = {
       cwhours,
       {
	  cwminutes, cwseconds,
	  layout = awful.widget.layout.vertical.flex
       },
       layout = awful.widget.layout.horizontal.leftright
    }

 end
shifty.taglist = mytaglist
-- }}}

-- {{{ Mouse bindings
root.buttons(awful.util.table.join(
    awful.button({ }, 3, function () mymainmenu:toggle() end),
    awful.button({ }, 4, awful.tag.viewnext),
    awful.button({ }, 5, awful.tag.viewprev)
))
-- }}}

-- {{{ Key bindings
globalkeys = awful.util.table.join(
    awful.key({ modkey,           }, ",",  awful.tag.viewprev       ),
    awful.key({ modkey,           }, ".",  awful.tag.viewnext       ),
    awful.key({ modkey, "Shift"   }, ",",  shifty.shift_prev       ),
    awful.key({ modkey, "Shift"   }, ".",  shifty.shift_next       ),
    awful.key({ modkey,           }, "Escape", awful.tag.history.restore),

    awful.key({                   }, "F12", function () scratch.drop(config.cmd.dropterminal, "top", "center", 1, 0.4, 0, 32) end),

    awful.key({ modkey,           }, "j",
        function ()
            awful.client.focus.byidx( 1)
            if client.focus then client.focus:raise() end
        end),
    awful.key({ modkey,           }, "k",
        function ()
            awful.client.focus.byidx(-1)
            if client.focus then client.focus:raise() end
        end),
    awful.key({ modkey,           }, "w", function () mymainmenu:show({keygrabber=true}) end),


    awful.key({                   }, "XF86AudioPrev",    awful.tag.viewprev),
    awful.key({                   }, "XF86AudioNext", awful.tag.viewnext),
    awful.key({ modkey            }, "XF86AudioPrev",    shifty.shift_prev),
    awful.key({ modkey            }, "XF86AudioNext", shifty.shift_next),
    awful.key({ modkey            }, "t", function()     shifty.add({ rel_index = 1 }) end),

    awful.key({ modkey, "Control" }, "t",           function() shifty.add({ rel_index = 1, nopopup = true }) end),
    awful.key({ modkey            }, "r",           shifty.rename),
    awful.key({ modkey, "Shift"   }, "c",           shifty.del),



    -- Layout manipulation
    awful.key({ modkey, "Shift"   }, "j", function () awful.client.swap.byidx(  1)    end),
    awful.key({ modkey, "Shift"   }, "k", function () awful.client.swap.byidx( -1)    end),
    awful.key({ modkey, "Control" }, "j", function () awful.screen.focus_relative( 1) end),
    awful.key({ modkey, "Control" }, "k", function () awful.screen.focus_relative(-1) end),
    awful.key({ modkey,           }, "u", awful.client.urgent.jumpto),
    awful.key({ modkey,           }, "Tab",
        function ()
            awful.client.focus.history.previous()
            if client.focus then
                client.focus:raise()
            end
        end),

    -- Standard program
    awful.key({ modkey,           }, "Return", function () awful.util.spawn(config.terminal) end),
    awful.key({ modkey, "Shift"   }, "Return", function () awful.util.spawn(config.cmd.tod) end),
    
    awful.key({ modkey, "Control" }, "r", awesome.restart),
    awful.key({ modkey,           }, "q", awesome.quit),

    awful.key({ modkey,           }, "l",     function () awful.tag.incmwfact( 0.05)    end),
    awful.key({ modkey,           }, "h",     function () awful.tag.incmwfact(-0.05)    end),
    awful.key({ modkey, "Shift"   }, "h",     function () awful.tag.incnmaster( 1)      end),
    awful.key({ modkey, "Shift"   }, "l",     function () awful.tag.incnmaster(-1)      end),
    awful.key({ modkey, "Control" }, "h",     function () awful.tag.incncol( 1)         end),
    awful.key({ modkey, "Control" }, "l",     function () awful.tag.incncol(-1)         end),
    awful.key({ modkey,           }, "space", function () awful.layout.inc(layouts,  1) end),
    awful.key({ modkey, "Shift"   }, "space", function () awful.layout.inc(layouts, -1) end),

    -- Prompt
    awful.key({ modkey },            "Menu",  function () mypromptbox[mouse.screen]:run() end),

    awful.key({ modkey }, "x",
	      function ()
		 awful.prompt.run({ prompt = "Run Lua code: " },
				  mypromptbox[mouse.screen].widget,
				  awful.util.eval, nil,
				  awful.util.getdir("cache") .. "/history_eval")
              end)
)

clientkeys = awful.util.table.join(
    awful.key({ modkey,           }, "f",      function (c) c.fullscreen = not c.fullscreen  end),
    awful.key({ modkey,           }, "c",      function (c) c:kill()                         end),
    awful.key({ modkey, "Control" }, "space",  awful.client.floating.toggle                     ),
    awful.key({ modkey, "Control" }, "Return", function (c) c:swap(awful.client.getmaster()) end),
    awful.key({ modkey,           }, "o",      awful.client.movetoscreen                        ),
    awful.key({ modkey, "Shift"   }, "r",      function (c) c:redraw()                       end),
    awful.key({ modkey, "Shift"   }, "t",      function (c) c.ontop = not c.ontop            end),
    awful.key({ modkey,           }, "n",      function (c) c.minimized = not c.minimized    end),
    awful.key({ modkey,           }, "m",
        function (c)
            c.maximized_horizontal = not c.maximized_horizontal
            c.maximized_vertical   = not c.maximized_vertical
        end)
)


-- Bind all key numbers to tags.
-- Be careful: we use keycodes to make it works on any keyboard layout.
-- This should map on the top row of your keyboard, usually 1 to 9.
for i=1, 9 do
  
  globalkeys = awful.util.table.join(globalkeys, awful.key({ modkey }, i,
  function ()
    local t = awful.tag.viewonly(shifty.getpos(i))
  end))
  globalkeys = awful.util.table.join(globalkeys, awful.key({ modkey, "Control" }, i,
  function ()
    local t = shifty.getpos(i)
    t.selected = not t.selected
  end))
  globalkeys = awful.util.table.join(globalkeys, awful.key({ modkey, "Control", "Shift" }, i,
  function ()
    if client.focus then
      awful.client.toggletag(shifty.getpos(i))
    end
  end))
  -- move clients to other tags
  globalkeys = awful.util.table.join(globalkeys, awful.key({ modkey, "Shift" }, i,
    function ()
      if client.focus then
        local t = shifty.getpos(i)
        awful.client.movetotag(t)
        awful.tag.viewonly(t)
      end
    end))
end

clientbuttons = awful.util.table.join(
   awful.button({ }, 1, function (c) client.focus = c; c:raise() end),
   awful.button({ modkey }, 1, awful.mouse.client.move),
   awful.button({ modkey }, 3, awful.mouse.client.resize))

-- Set keys
root.keys(globalkeys)
shifty.config.globalkeys = globalkeys
shifty.config.clientkeys = clientkeys
-- }}}

-- {{{ Rules
awful.rules.rules = {
    -- All clients will match this rule.
    { rule = { },
      properties = { border_width = beautiful.border_width,
                     border_color = beautiful.border_normal,
               	     size_hints_honor = false,
                     focus = true,
                     keys = clientkeys,
                     buttons = clientbuttons } },
    { rule = { class = "MPlayer" },
      properties = { floating = true } },
    { rule = { class = "pinentry" },
      properties = { floating = true } },
    { rule = { class = "gimp" },
      properties = { floating = true } },
    -- Set Firefox to always map on tags number 2 of screen 1.
    -- { rule = { class = "Firefox" },
    --   properties = { tag = tags[1][2] } },
}
-- }}}

-- {{{ Signals
-- Signal function to execute when a new client appears.
client.add_signal("manage", function (c, startup)
    -- Add a titlebar
    -- awful.titlebar.add(c, { modkey = modkey })

			       
    -- Enable sloppy focus
    c:add_signal("mouse::enter", function(c)
        if awful.layout.get(c.screen) ~= awful.layout.suit.magnifier
            and awful.client.focus.filter(c) then
            client.focus = c
        end
    end)

    if not startup then
        -- Set the windows at the slave,
        -- i.e. put it at the end of others instead of setting it master.
        -- awful.client.setslave(c)

        -- Put windows in a smart way, only if they does not set an initial position.
        if not c.size_hints.user_position and not c.size_hints.program_position then
            awful.placement.no_overlap(c)
            awful.placement.no_offscreen(c)
        end
    end
end)

client.add_signal("focus", function(c) c.border_color = beautiful.border_focus end)
client.add_signal("unfocus", function(c) c.border_color = beautiful.border_normal end)
-- }}}




-- Startup

-- Stopdown
