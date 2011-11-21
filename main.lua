require("menu/menu")
function love.load()
  --love.mouse.setVisible(false)
  --newCursor = love.graphics.newImage("cur.png")
  menu:toggle()
  view = {}
  view[1] = {
    title="Space Hell",
    desc="Never before has mankind seen such a sexy menu screen. Presenting the lovemenu.",
    {t="Login",cb="ng",
      form={
        {title="Username:",type="text",name="un"},
        {title="Password:",type="password",name="pass"}
      }
    },
    {t="Options",cb="op"},
    {t="Credits",cb="cr"},
    {t="Exit",cb="exit"}
  }
  view[2] = {
    title="Options",
    desc="Set your options here.",
    {t="Fullscreen",cb="fs"},
    {t="Resolution ("..love.graphics.getWidth().."x"..love.graphics.getHeight()..")",cb="res"},
    {t="Sound (on)",cb="sound"},
    {t="Return",cb="mm"}
  }
  view[3] = {
    title="Quit",
    desc="Are you sure you want to quit?",
    {t="Confirm",cb="cexit"},
    {t="Return",cb="mm"}
  }
  view[4] = {
    title="Credits",
    desc="Josefnpat - Programmer\nSomeone Else - Artist",
    {t="Return",cb="mm"}
  }
  videomodes = love.graphics.getModes()
  currentmode = 1
  menu:load(view)
end
function love.draw()
  menu:draw()
  if not menu.run then
    love.graphics.print("Press escape to return to the menu!",128,128)
  end
  --love.graphics.draw(newCursor, love.mouse.getX(), love.mouse.getY(),0,.75,.75)
end

curbg = 0
function love.keypressed(key)
  menu:keypressed(key)
  if not menu.run and key == "escape" then
    menu:toggle()
  end
  if key == "r" then
    curbg = (curbg + 1)%4
    if curbg == 0 then
      menu.bg = love.graphics.newImage("menu/assets/bg.png")
    else
      menu.bg = love.graphics.newImage("bg"..curbg..".png")
    end
  end
end

sound = true
function menu:callback(cb)
  if cb == "ng" then
    menu:toggle()
  elseif cb == "op" then
    menu:setstate(2)
  elseif cb == "cr" then
    menu:setstate(4)
  elseif cb == "exit" then
    menu:setstate(3)
  elseif cb == "cexit" then
    love.event.push("q")
  elseif cb == "fs" then
    love.graphics.toggleFullscreen( )
  elseif cb == "res" then
    love.graphics.setMode( videomodes[currentmode].width, videomodes[currentmode].height )
    view[2][2].t = "Resolution ("..love.graphics.getWidth().."x"..love.graphics.getHeight()..")"
    currentmode = ((currentmode + 1)% #videomodes)+1
  elseif cb == "sound" then
    sound = not sound
    local temp_x = ""
    if sound then
      temp_s = "on"
    else
      temp_s = "off"
    end
    view[2][3].t = "Sound ("..temp_s..")"
  elseif cb == "mm" then
    menu:setstate(1)
  else
    print("unknown command:"..cb)
  end
end

function love.update(dt)
  menu:update(dt)
end

function love.mousepressed(x,y,button)
  menu:mousepressed(x,y,button)
end
