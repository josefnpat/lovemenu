button = {}
button.graphics = {}
function button:load()
  local theme = "blue_200"
  button.img_inactive = love.graphics.newImage("button/"..theme.."/inactive.png")
  button.img_active = love.graphics.newImage("button/"..theme.."/active.png")
  button.img_depress = love.graphics.newImage("button/"..theme.."/depress.png")
  button.img_disabled = love.graphics.newImage("button/"..theme.."/disabled.png")
  button.font = love.graphics.newFont("button/DejaVuSansCondensed.ttf",16)
  love.graphics.setFont(button.font)
  button.q_left = love.graphics.newQuad(0,0,16,32,33,32)
  button.q_center = love.graphics.newQuad(16,0,1,32,33,32)
  button.q_right = love.graphics.newQuad(17,0,16,32,33,32)
  button.active = false
  button.data = {}
end

button:load()

function button:drawb(b,x,y)
  b.x = x
  b.y = y
  local text_width = button.font:getWidth(b.text)
  local text_height = button.font:getHeight(b.text)
  local img = button.img_inactive
  if b.active then
    img = button.img_active
  end
  if b.depress then
    img = button.img_depress
  end
  if b.disabled then
    img = button.img_disabled
  end
  love.graphics.drawq(img,button.q_left   ,x              ,y)
  love.graphics.drawq(img,button.q_center ,x+16           ,y,0,text_width,1)
  love.graphics.drawq(img,button.q_right  ,x+16+text_width,y)
  love.graphics.print(b.text,x+16,y-text_height/2+16)
end

function button:newButton(text,cb)
  local b = {
    x=0,
    y=0,
    text=text,
    cb=cb,
    disabled=false
  }
  local width = button.font:getWidth(text) + 32
  b.getWidth = function() return width end
  b.getHeight = function() return 32 end
  return b
end


function button:update(butarray)
  for _,v in pairs(butarray) do
    if button:mouseIntersect(v) then
      v.active = true
    else
      v.active = false
    end
  end
end

function button:mousepressed(b,butarray)
  if b == "l" then
    for _,v in pairs(butarray) do
      if button:mouseIntersect(v) then
        v.depress = true
      else
        v.depress = false
      end
    end
  end
end

function button:mousereleased(b,butarray)
  if b == "l" then
    for _,v in pairs(butarray) do
      v.depress = false
      if button:mouseIntersect(v) then
        if not v.disabled then
          if button.pressed then
            button:pressed(v.cb)
          else
            print("function button:pressed(cb) not defined")
          end
        end
      end
    end
  end
end

-- Mouse intersect
function button:mouseIntersect(button)
  local x,y = love.mouse.getX(), love.mouse.getY()
  if button.x <= x and x <= button.x + button.getWidth() and button.y <= y and y <= button.y + button.getHeight() then
    return true
  end
end
