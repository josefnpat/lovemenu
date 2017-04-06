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
function love.load()
	menu:toggle()
	menu_view = {} --table to hold all the menu views
	
	--THIS IS THE MAIN MENU
	menu_view[1] = {
		title = "Main Menu", --Title to show
		desc = "This is the main menu." --You could put empty string if you dont want to show anything

	}
end
```





