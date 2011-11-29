require("button/button")

function love.load()
  buttons = {
    b1 = button:newButton("Submit","sub"),
    b2 = button:newButton("Cancel","can"),
    b3 = button:newButton("Disabled Button, don't even try it.","dis")
  }
  buttons.b3.disabled = true
end

function love.draw()
  button:drawb(buttons.b1,100,100)
  button:drawb(buttons.b2,100+buttons.b1:getWidth()+2,100)
  button:drawb(buttons.b3,100+buttons.b1:getWidth()+buttons.b2:getWidth()+4,100)
end

function button:pressed(cb)
  print("Pressed cb:"..cb)
end

function love.update(dt)
  button:update(buttons)
end

function love.mousepressed(x,y,b)
  button:mousepressed(b,buttons)
end

function love.mousereleased(x,y,b)
  button:mousereleased(b,buttons)
end
