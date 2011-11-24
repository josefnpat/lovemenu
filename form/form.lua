form = {}
form.font = love.graphics.newFont("menu/assets/League_Gothic-webfont.ttf",22)
form.run = false;
form.state = 1
form.active_element = nil
function form:load(views)
  form.view = views
  --TODO Put this in an init section so that setstate works.
  form.line_height = form.font:getHeight()
end

function form:toggle()
  form.run = not form.run
end

form.w = 320
form.margin = 4
form.padding = 10
form.inputpadding = 4

function form:draw()
  if form.run then
    local orig_font = love.graphics.getFont()
    local orig_r, orig_g, orig_b, orig_a
    orig_r, orig_g, orig_b, orig_a = love.graphics.getColor( )
    love.graphics.setFont(form.font)
    love.graphics.setColor(255,255,255,127)
    --TODO add rounded edges so that it looks nicer.
    love.graphics.rectangle("fill",
        form.bounding_x - form.margin,
        form.bounding_y - form.margin,
        form.w + form.margin * 2,
        form.bounding_h + form.margin * 2
    )

    for i,v in ipairs(form.view[form.state]) do
      local ele_x,ele_y,ele_w,ele_h = form:get_bounding(i)
      form:draw_element(v,ele_x,ele_y,ele_w,ele_h,form.highlight==i)
    end
    love.graphics.setFont(orig_font)
    love.graphics.setColor(orig_r,orig_g,orig_b,orig_a)
  end
end

--TODO Get bounding for buttons to work.
function form:get_bounding(i)
  local ele_x = form.bounding_x + form.padding - form.inputpadding
  local ele_y = form.bounding_y + form.line_height * (i-1) - form.padding + i*(form.padding*2) - form.inputpadding
  local ele_w = form.w - form.padding * 2 + form.inputpadding * 2
  local ele_h = form.line_height + form.inputpadding * 2
  local buttondiv = 1
  if form.view[form.state][i].type == "submit" then
    buttondiv = 4
  end
  return ele_x,ele_y,ele_w/buttondiv,ele_h
end

function form:draw_element(obj,x,y,w,h,highlight)
  if highlight then
    love.graphics.setColor(255,255,255,255)
  else
    love.graphics.setColor(255,255,255,127)
  end
  if obj.type == "text_input" or obj.type == "password_input" then
    love.graphics.rectangle("fill",x,y,w,h)
    love.graphics.setColor(0,0,0,255)
    love.graphics.printf(obj.value,x+form.inputpadding,y+form.inputpadding,w-form.inputpadding*2,"left")
  end
  if obj.type == "title" then
    love.graphics.setColor(0,0,0,255)
    love.graphics.printf(obj.value,x+form.inputpadding,y+form.inputpadding,w-form.inputpadding*2,"center")
  end
  if obj.type == "submit" then
    love.graphics.rectangle("fill",x,y,w,h)
    love.graphics.setColor(0,0,0,255)
    love.graphics.printf(obj.value,x+form.inputpadding,y+form.inputpadding,w-form.inputpadding*2,"center")
  end
end

function form:update(dt)
  form.bounding_h = #form.view[form.state] * (form.line_height + form.padding * 2)
  form.bounding_x = love.graphics.getWidth()/2 - form.w/2
  form.bounding_y = love.graphics.getHeight()/2 - form.bounding_h/2
  if form.run then
    form.highlight = form:mouse_over_ele()
  end
end

function form:mouse_over_ele()
  for i,v in ipairs(form.view[form.state]) do
    ele_x,ele_y,ele_w,ele_h = form:get_bounding(i)
    if love.mouse.getX() >= ele_x and love.mouse.getX() <= ele_x + ele_w and love.mouse.getY() >= ele_y and love.mouse.getY() <= ele_y + ele_h then
      return i
    end
  end
end

--TODO When element is selected, allow input fields to be altered.
function form:keypressed(key)
  if form.run then

  end
end
function form:keyreleased(key)
  if form.run then

  end
end

function form:callback_exec(obj)
  if form.callback then
    form:callback(form.state,obj)
  else
    print("form:callback not defined.")
  end
end

function form:setstate(stateid)
  if form.view[stateid] then
    form.state = stateid
  else
    print("Form state does not exist.")
  end
end
--TODO Change what element is selected, or callback_exec if it's a submit, and toggle view.
function form:mousepressed(x,y,button)
  if form.run then
    if form.highlight then
      print("Element id "..form.highlight.." pressed.")
    else
      print("Nothing pressed.")
    end
  end
end
