menu = {}

menu.font = love.graphics.newFont("assets/crass.ttf",32)
menu.icon = love.graphics.newImage("assets/icon.png")

menu.option = 0
menu.state = 1
menu.run = false;
function menu:load(views)
  menu.view = views
end

function menu:toggle()
  menu.run = not menu.run
end

function menu:draw()
  if menu.run then
    local orig_font = love.graphics.getFont()
    love.graphics.setFont(menu.font)
    local pos = 0
    local h = 64
    love.graphics.print(menu.view[menu.state].title,100,0)
    love.graphics.draw(menu.icon,100-32,menu.option*32+h)
    for i,v in ipairs(menu.view[menu.state]) do
      love.graphics.print(v.t,100,pos*32+h)
      pos = pos + 1
    end
    love.graphics.setFont(orig_font)
  end
end

function menu:keypressed(key)
  if menu.run then
    if key == "up" then
      menu.option = (menu.option - 1) % #menu.view[menu.state]
    elseif key == "down" then
      menu.option = (menu.option + 1) % #menu.view[menu.state]
    elseif key == "return" or key == "enter" or key ==" " then
      if menu.callback then
        menu:callback(menu.view[menu.state][menu.option+1].cb)
      else
        print("menu:callback not defined.")
      end
    end
  end
end

function menu:setstate(stateid)
  if menu.view[stateid] then
    menu.option = 0
    menu.state = stateid
  else
    print("Menu state does not exist.")
  end
end
