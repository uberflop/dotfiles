local awful = require('awful')
local beautiful = require('beautiful')
local wibox = require('wibox')
local gears = require('gears')
local has_fdo, freedesktop = pcall(require, "freedesktop")
local vicious = require("vicious")

local RightPanel = function(s)

  -- Wiboxes are much more flexible than wibars simply for the fact that there are no defaults
  local rightpanel =
    wibox(
      {
        ontop = false,
        screen = s,
        height = 28,
        width = 5000,
        x = s.geometry.x + 1195,
        y = 5,
        stretch = false,
        bg = "#00000000",
        fg = "#d8dee9",

    visible = true,
      }
    )

  rightpanel:struts(--struts are used to change the work area size so tiling windows don't
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


mylauncher = awful.widget.launcher({ image = beautiful.awesome_icon,
                                     menu = mymainmenu })
--Tags
-- Create a taglist widget
    s.mytaglist = awful.widget.taglist {
        screen  = s,
        filter  = awful.widget.taglist.filter.all,
        buttons = taglist_buttons
    }

--Prompt Box
s.mypromptbox1 = awful.widget.prompt()

--memory widget from vicious
memwidget = wibox.widget.textbox()
vicious.register(memwidget, vicious.widgets.mem, "<span foreground='#9dd7de' font_desc='Hack 11'>/  </span> <span foreground='#9dd7de' font_desc='Hack Bold 11'>$2 GB $1% /</span> ", 15)

--network from vicious
netwidget = wibox.widget.textbox()
vicious.cache(vicious.widgets.net)
vicious.register(netwidget, vicious.widgets.net, "<span foreground='#9dd7de' font_desc='Hack 11'>歷 </span> <span foreground='#9dd7de' font_desc='Hack Bold 11'>${enp3s0 down_kb} ${enp3s0 up_mb}</span>", 2)

--cpu freq from vicious
cpuinfwidget = wibox.widget.textbox()
vicious.register(cpuinfwidget, vicious.widgets.cpuinf, "<span foreground='#9dd7de' font_desc='Hack 11'>/  </span> <span foreground='#9dd7de' font_desc='Hack Bold 11'>${cpu0 ghz} Ghz</span>", 120)
--cpu from vicious
cpuwidget = wibox.widget.textbox()
vicious.register(cpuwidget, vicious.widgets.cpu, "<span foreground='#9dd7de' font_desc='Hack Bold 11'>$1%</span>", 5)

--volume from vicious
volwidget = wibox.widget.textbox()
vicious.register(volwidget, vicious.widgets.volume, "<span foreground='#9dd7de' font_desc='Hack 11'> </span> <span foreground='#9dd7de' font_desc = 'Hack Bold 11'>$1 /</span>", 2, "Master")

--time & date from vicious
--datewidget = wibox.widget.textbox()
--vicious.register(datewidget, vicious.widgets.date, "<span foreground= '#d8dee9' font_desc= 'Hack 11' %b %d </span>", 2)
datewidget = wibox.widget.textbox()
vicious.register(datewidget, vicious.widgets.date, "<span foreground='#9dd7de' font_desc='Hack Bold 11' > %a %d %b %y %R </span>")

--gaps
--icongap = wibox.widget{
--           markup = '<span font_desc="Hack Bold 11">|</span>',
--    align  = 'center',
--    valign = 'center',
--    widget = wibox.widget.textbox
--}

--panel
rightpanel:setup {
   {
        -- Force the textbox to always be 300 pixel long
        {

      {

                align  = "center",
                widget =netwidget
            },


            bg     = "#2c2c2c",
            widget = wibox.container.background,
        },
        width    = 140,
        strategy = "min",
        layout   = wibox.layout.constraint
    },
    {
        -- Force the textbox to always be 300 pixel long
        {
      
      {
            
                align  = "center",
                widget = cpuinfwidget
            },


            bg     = "#2c2c2c",
            widget = wibox.container.background,
        },
        width    = 110,
        strategy = "min",
        layout   = wibox.layout.constraint
    },
 {
        -- Force the textbox to always be 300 pixel long
        {
      {
                align  = "center",
                widget = cpuwidget
            },
            bg     = "#000000",
            widget = wibox.container.background,
        },
        width    = 50,
        strategy = "min",
        layout   = wibox.layout.constraint
    },
{
        -- Force the textbox to always be 300 pixel long
        {
      {
                align  = "center",
                widget = memwidget
            },
            bg     = "#2c2c2c",
            widget = wibox.container.background,
        },
        width    = 150,
        strategy = "min",
        layout   = wibox.layout.constraint
    },
{
        -- Force the textbox to always be 300 pixel long
        {
      {
                align  = "center",
                widget = volwidget
            },
            bg     = "#2c2c2c",
            widget = wibox.container.background,
        },
        width    = 75,
        strategy = "min",
        layout   = wibox.layout.constraint
    },
{
        -- Force the textbox to always be 300 pixel long
        {
      {
                align  = "center",
                widget = datewidget
            },
            bg     = "#2c2c2c",
            widget = wibox.container.background,
        },
        width    = 150,
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


  return rightpanel
end

return RightPanel

