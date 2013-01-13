lovemenu = require("menu/menu")
m = lovemenu.new("menuobj")

state = "menu"

function love.update(dt)
  if state == "menu" then
    m:update(dt)
  end
end

function love.draw()
  if state == "menu" then
    m:draw()
  end
end

function love.keypressed(key)
  if state == "menu" then
    m:keypressed(key)
  end
end

function love.mousepressed(x,y,button)
  if state == "menu" then
    m:mousepressed(x,y,button)
  end
end