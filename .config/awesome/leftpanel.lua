local awful = require('awful')
local beautiful = require('beautiful')
local wibox = require('wibox')
local gears = require('gears')
local has_fdo, freedesktop = pcall(require, "freedesktop")
local vicious = require("vicious")

local LeftPanel = function(s)
local os = os
local confdir                                   = os.getenv("HOME") .. "/.config/awesome/themes/forest"
--Icons
local launchicon                               = confdir .. "/tile.png"

  -- Wiboxes are much more flexible than wibars simply for the fact that there are no defaults
  local leftpanel =
    wibox(
      {
        ontop = false,
        screen = s,
        height = 28,
        width = s.geometry.width,
        x = s.geometry.x + 10,
        y = 5,
        stretch = false,
        bg = "#00000000",
        fg = "#d8dee9",
    visible = true,
      }
    )

  leftpanel:struts(--struts are used to change the work area size so tiling windows don't
--overlap the bar 
    {
      top = 20
    }
  )

--Widgets
--Menu
myawesomemenu = {
   { "hotkeys", function() hotkeys_popup.show_help(nil, awful.screen.focused()) end },
   { "manual", terminal .. " -e man awesome" },
   { "edit config", editor_cmd .. " " .. awesome.conffile },
   { "restart", awesome.restart },
   { "quit", function() awesome.quit() end },
}

local menu_awesome = { "awesome", myawesomemenu, beautiful.awesome_icon }
local menu_terminal = { "open terminal", terminal }

if has_fdo then
    mymainmenu = freedesktop.menu.build({
        before = { menu_awesome },
        after =  { menu_terminal }
    })
else
    mymainmenu = awful.menu({
        items = {
                  menu_awesome,
                  { "Debian", debian.menu.Debian_menu.Debian },
                  menu_terminal,
                }
    })
end


mylauncher = awful.widget.launcher({ image = launchicon,
                                     menu = mymainmenu })
--Tags
-- Create a taglist widget
    s.mytaglist = awful.widget.taglist {
        screen  = s,
        filter  = awful.widget.taglist.filter.all,
style   = {
       shape = gears.shape.rectangle,
    },
    layout   = {
font = "Hack Bold 11",
        spacing = 18,
fg_focus = "#9dd7de",
        spacing_widget = {
            color  = '#2c2c2c',
          shape  = gears.shape.rectangle,
            widget = wibox.widget.separator,
        },
        layout  = wibox.layout.fixed.horizontal
    },        

buttons = taglist_buttons
    }

--Prompt Box
s.mypromptbox1 = awful.widget.prompt()

--memory widget from vicious
memwidget = wibox.widget.textbox()
vicious.register(memwidget, vicious.widgets.mem, "<span foreground='#d8dee9' font_desc='Hack 11'> </span> <span foreground='#d8dee9' font_desc='Hack Bold 11'>$2 GB $1%</span> ", 15)

--network from vicious
netwidget = wibox.widget.textbox()
vicious.cache(vicious.widgets.net)
vicious.register(netwidget, vicious.widgets.net, "<span foreground='#d8dee9' font_desc='Hack 11'>歷 </span> <span foreground='#d8dee9' font_desc='Hack Bold 11'>${enp3s0 down_kb} ${enp3s0 up_mb} </span>", 2)

--cpu freq from vicious
cpuinfwidget = wibox.widget.textbox()
vicious.register(cpuinfwidget, vicious.widgets.cpuinf, "<span foreground='#3eccdd' font_desc='Hack 11'> </span> <span foreground='#3eccdd' font_desc='Hack Bold 11'>${cpu0 ghz} Ghz</span> ", 60)
--cpu from vicious
cpuwidget = wibox.widget.textbox()
vicious.register(cpuwidget, vicious.widgets.cpu, "<span foreground='#3eccdd' font_desc='Hack Bold 11'> $1%</span> ", 10)

--panel
--leftpanel:setup {
--    {
--	-- align  = "center",
--	 widget = mylauncher,               
--    },
--	{ widget = s.mytaglist
--},
--    layout = wibox.layout.fixed.horizontal,
--}

leftpanel:setup {
   {
        -- Force the textbox to always be 300 pixel long
        {

      {

                align  = "center",
                widget = mylauncher
            },


            bg     = "#2c2c2c",
            widget = wibox.container.background,
        },
        width    = 30,
        strategy = "min",
        layout   = wibox.layout.constraint
    },
   {
        -- Force the textbox to always be 300 pixel long
        {

      {

                align  = "center",
                widget = s.mytaglist
            },


            bg     = "#2c2c2c",
            widget = wibox.container.background,
        },
        width    = 115,
        strategy = "min",
        layout   = wibox.layout.constraint
    },
    layout = wibox.layout.fixed.horizontal,
}
 


--panel
 -- rightpanel:setup {
 --   { -- Left widgets
   --   {--making a round bar that stuff will go inside
    --    {--stuff at the beginning actually goes here
     --     wibox.widget.textbox(""),
--mylauncher,
--s.mytaglist,
--          layout = wibox.layout.align.horizontal
--        },
--        bg = "#000000",--the background color
--        shape = gears.shape.rect,--the background shape. 
--        widget = wibox.widget.background,
 --     },
 --     layout = wibox.layout.flex.horizontal,
 --   },
--    {--middle widgets. This thing is expanded to as big as it can get, so if you want something
--    --that isn't really long it has to be inside another set of {}, within middle
--      nil,--used for making it centered
--      {--making a round bar that stuff will go inside
--        {--stuff in the middle actually goes here
--mypromptbox1,        
-- wibox.widget.textbox("!"),
--	s.mypromptbox1,
--          layout = wibox.layout.align.horizontal
--  
--      },
--        bg = "#000000", --the background color
--        shape = gears.shape.rounded_bar,--the background shape. 
--        widget = wibox.widget.background,
--      },
--      expand = "none",--used for making it centered
--      layout = wibox.layout.align.horizonta-------l
--
--    },
--
--    { -- Right widgets
--      {--making a round bar that stuff will go inside
--        {--stuff at the end actually goes here
--netwidget,
--cpuinfwidget,
--cpuwidget,
--memwidget,         
-- wibox.widget.textbox("hello end"),
--          layout = wibox.layout.align.horizontal
--        },
 --       bg = "#000000",--the background color
 --      	 shape = gears.shape.rect,--the background shape. 
  --      widget = wibox.widget.background,
 --     },
 --     layout = wibox.layout.fixed.horizontal,
 --   },
 --   layout = wibox.layout.align.horizontal,--an allign layout expands the middle widget to as big as it can get
--}


  return leftpanel
end

return LeftPanel

