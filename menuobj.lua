menuobj = {}

menuobj.group = "main"

menuobj.title = "Vidya"

menuobj.actions = {}

temp = {}
temp.value = "New Game"
temp.group = {"main"}
function temp:func_select(menu,key)
  state = "newgame"
end
table.insert(menuobj.actions,temp)

temp = {}
temp.value = "Settings"
temp.group = {"main"}
function temp:func_select(menu,key)
  menu:set_group("settings")
end
table.insert(menuobj.actions,temp)

temp = {}
temp.value = "Resolution"
temp.group = {"settings"}
temp.show_left = false
temp.show_right = true
function temp:func_left(key)
  --lower res
  -- if lower res
  return 1 -- Show left arrow
  -- else
  --return 0 -- Fade left arrow
end
function temp:func_right(key)
  --raise res
  -- if higher res
  return 1 -- Show right arrow
  -- else
  --return 0 -- Fade right arrow
end
function temp:draw_desc(x,y,w,h)
  love.graphics.rectangle("line",x,y,w,h)
end
temp.print_desc = "This will allow you to change the resolution."
table.insert(menuobj.actions,temp)

temp = {}
temp.value_on = "Sound (On)"
temp.value_off = "Sound (Off)"
if sound then
  temp.value = temp.value_on
  temp.show_left = true
  temp.show_right = false
else
  temp.value = temp.value_off
  temp.show_left = false
  temp.show_right = true
end
temp.group = {"settings"}
function temp:func_right(key)
  temp.show_left = false
  temp.show_right = true
end
function temp:func_left(key)
  temp.show_left = true
  temp.show_right = false
end
table.insert(menuobj.actions,temp)

temp = {}
temp.value = "Apply"
temp.group = {"settings"}
function temp:func_select(menu,key)
  menu:set_group("main")
end
table.insert(menuobj.actions,temp)

temp = {}
temp.value = "Cancel"
temp.group = {"settings"}
function temp:func_select(menu,key)
  menu:set_group("main")
end
table.insert(menuobj.actions,temp)

temp = {}
temp.value = "Quit"
temp.group = {"main"}
function temp:func_select(menu,key)
  love.event.quit()
end
table.insert(menuobj.actions,temp)

return menuobj