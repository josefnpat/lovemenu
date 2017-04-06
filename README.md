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

4. After the main menu views setup
```lua
menu = require("libraries/menu")
function love.load()
	-- GAME VIEWS SETUP ABOVE
	menu:load(menu_view) 
	menu.bg = love.graphics.newImage("path-to-image") -- for the bg
end

function love.update(dt)
	menu:update(dt)
end

function love.draw()
	menu:draw() 
end
```

5. Now let us setup a simple callbacks system (cb)
```lua
function menu:callback(cb)
	if cb == "sg" then --the start game callback we used above
		--code to start the game
	elseif cb == "st" then --settings
		menu:setstate(2) --go to the "menu_view[2]"
	elseif cb == "quit" then --quit
		menu:setstate(3)
	end --etc
end
```
6. Last is the keyboard function
6. Last is the keyboard function
6. Last is the keyboard function
6. Last is the keyboard function
6. Last is the keyboard function
6. Last is the keyboard function
```lua
function love.keypressed(key)
	menu:keypressed(key)
end
```

# And that's it! Hope you got it!
























