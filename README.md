Mouse, keyboard input.
See main.lua for example usage.
Press R for bg roate.
<img src="https://github.com/josefnpat/lovemenu/raw/master/screenshot.png" />



# Simple Setup

1. Require the "lovemenu" in your game before `love.load` function.
```lua
menu = require("path-to-menu.lua") --no need to put the .lua extension

function love.load()

end
```
2. Then inside the `love.load` function:
```lua
menu = require("libraries/menu")
function love.load()
	menu:toggle()
	menu_view = {} --table to hold all the menu views
	
	--THIS IS THE MAIN MENU
	menu_view[1] = {
		title = "Main Menu", --Title to show
		desc = "This is the main menu.", --You could put empty string if you dont want to show anything
		{t = "Start", cb = "sg"}, --t is the text, cb is callback
		{t = "Settings", cb = "st"}, --keep the cb variable simple
		{t = "Quit", cb = "quit"} -- you can add as many as you want.
	}
end
```
Now, that is all for the "main menu". 

3. Now, let us add the other views (start,settings, quit, etc)
```lua
menu = require("libraries/menu")

function love.load()
	--MAIN MENU CODE ABOVE

	--View for the Settings
	menu_view[2] = {
		title = "Settings",
		desc = "This is for customizing the default settings",
		{t = "Sound", cb = "sound"},
		{t = "Controls", cb = "cntrl"},
		--MAKE MORE IF YOU LIKE
		{t = "Return", cb "mainmenu"}
	}

	--Go and make the rest of the other views
end
```

4.






