menu = {}

function menu.new(menuobj)
  local m = require(menuobj)
  m.theme = require("menu/defaults")
  m.draw = menu.draw
  m.update = menu.update
  m.keypressed = menu.keypressed
  m.mousepressed = menu.mousepressed
  m.get_action_y_offset = menu.get_action_y_offset
  m.get_action_hot_spot = menu.get_action_hot_spot
  m.get_current_actions = menu.get_current_actions
  m.get_mouse_action = menu.get_mouse_action
  m.set_group = menu.set_group
  m.cursor = 0
  m.dt = 0
  m.select = 1
  return m
end

function menu.in_table(needle,haystack)
  for _,v in pairs(haystack) do
    if needle == v then
      return true
    end
  end
end

function menu:get_action_y_offset()
  local count = #self:get_current_actions()+2
  return (love.graphics.getHeight() - count*(self.theme.action.font:getHeight()+self.theme.action.vpadding))/2
end

function menu:get_action_hot_spot(cur_index)
  local x,y,w,h
  x = self.theme.action.x
  local y_offset = self:get_action_y_offset()
  h = self.theme.action.font:getHeight()+self.theme.action.vpadding
  y = cur_index*h+y_offset
  w = self.theme.action.width
  return x,y,w,h
end

function menu:get_current_actions()
  local aux = {}
  for i,v in pairs(self.actions) do
    if menu.in_table(self.group,v.group) then
      table.insert(aux,v)
    end
  end
  return aux
end

function menu:set_group(group_name)
  self.group = group_name
  self.select = 1
end

function menu:get_mouse_action()
  mx,my = love.mouse.getPosition()
  for i,v in ipairs(self:get_current_actions()) do
    local x,y,w,h = self:get_action_hot_spot(i)
    if mx > x and mx < x + w and my > y and my < y + h then
      return i
    end
  end
end

function menu:draw()
  local oc = {love.graphics.getColor()}
  local of = love.graphics.getFont()
  if self.theme.bg.img then
    local bg_x_scale = love.graphics.getWidth()/self.theme.bg.img:getWidth()
    local bg_y_scale = love.graphics.getHeight()/self.theme.bg.img:getHeight()
    love.graphics.setColor(self.theme.bg.color)
    love.graphics.draw(self.theme.bg.img,0,0,0,bg_x_scale,bg_y_scale)
  end
  love.graphics.setColor(self.theme.action.bgcolor)
  love.graphics.rectangle("fill",
                          self.theme.action.x,
                          0,
                          self.theme.action.width,
                          love.graphics.getHeight())

  love.graphics.setColor(255,255,255)
  local x,y,w,h = self:get_action_hot_spot(self.select)
  love.graphics.draw(self.theme.select.img,
                 x,
                 self.select_tween+h/2,
                 0,
                 self.theme.scale,self.theme.scale,
                 0,
                 self.theme.select.img:getHeight()/2)

  love.graphics.setColor(self.theme.action.color)
  love.graphics.setFont(self.theme.action.font)
  for i,v in ipairs(self:get_current_actions()) do
    local x,y,w,h = self:get_action_hot_spot(i)
    love.graphics.printf(v.value,
                         x+self.theme.action.hpadding,
                         y+self.theme.action.vpadding/2,
                         w-self.theme.action.hpadding*2,
                         self.theme.action.align)
    if i == self.select then
      local dx = defaults.desc.padding
      local dy = defaults.desc.padding+defaults.title.y_offset+defaults.title.font:getHeight()
      local dw = self.theme.action.x-defaults.desc.padding*2
      local dh = love.graphics.getHeight()-defaults.desc.padding*2-defaults.title.y_offset-defaults.title.font:getHeight()
      if v.draw_desc then
        v:draw_desc(dx,dy,dw,dh)
      end
      if v.print_desc then
        love.graphics.printf(v.print_desc,dx,dy,dw,"center")
      end
    end
    if v.show_left ~= nil then
      if v.show_left == false then
        love.graphics.setColor(255,255,255,127)
      end
      love.graphics.draw(self.theme.left.img,
                         x,
                         y+h/2,
                         0,
                         self.theme.scale,self.theme.scale,
                         self.theme.left.img:getWidth()/2,
                         self.theme.left.img:getHeight()/2)
      love.graphics.setColor(255,255,255)
    end

    if v.show_right ~= nil then
      if v.show_right == false then
        love.graphics.setColor(255,255,255,127)
      end
      love.graphics.draw(self.theme.right.img,
                         x+w,
                         y+h/2,
                         0,
                         self.theme.scale,self.theme.scale,
                         self.theme.right.img:getWidth()/2,
                         self.theme.right.img:getHeight()/2)
      love.graphics.setColor(255,255,255)
    end

  end

  love.graphics.setColor(self.theme.title.color)
  love.graphics.setFont(self.theme.title.font)
  love.graphics.printf(self.title,
                       0,
                       self.theme.title.y_offset,
                       self.theme.action.x,
                       "center")
  love.graphics.setColor(oc)
  if of then love.graphics.setFont(of) end
end

function menu:update(dt)
  self.dt = self.dt + dt

  if self.old_mouse == nil then
    self.old_mouse = {love.mouse.getPosition()}
  else
    local mx,my = love.mouse.getPosition()
    if self.old_mouse[1] ~= mx or self.old_mouse[2] ~= my then
      self.old_mouse = {mx,my}
      local test_mouse = self:get_mouse_action()
      if test_mouse then
        self.select = test_mouse
      end
    end
  end

  local x,y = self:get_action_hot_spot(self.select)
  if self.select_tween == nil then
    self.select_tween = y
  end
  if y > self.select_tween then
    self.select_tween = self.select_tween +
      math.abs(self.select_tween-y)/2
  elseif y < self.select_tween then
    self.select_tween = self.select_tween -
      math.abs(self.select_tween-y)/2
  end
end

function menu:keypressed(key)
  if key == "up" then
    self.select = self.select - 1
    if self.select < 1 then
      self.select = #self:get_current_actions()
    end
  elseif key == "down" then
    self.select = self.select + 1
    if self.select > #self:get_current_actions() then
      self.select = 1
    end
  elseif key == "escape" then
    self.select = #self:get_current_actions()    
  elseif key == "return" or key == " " then
    local cur = table.remove(self:get_current_actions(),self.select)
    if cur.func_select then
      cur:func_select(self,key)
    end
  elseif key == "left" then
    local cur = table.remove(self:get_current_actions(),self.select)
    if cur.func_left then
      cur:func_left(self,key)
    end
  elseif key == "right" then
    local cur = table.remove(self:get_current_actions(),self.select)
    if cur.func_right then
      cur:func_right(self,key)
    end
  end
end

function menu:mousepressed(x,y,button)
  if button == "l" then
    local test_mouse = self:get_mouse_action()
    if test_mouse then
      self.select = test_mouse
      local cur = table.remove(self:get_current_actions(),self.select)
      if cur.func_select then
        cur:func_select(self,key)
      end      
    end
  end
end

return menu