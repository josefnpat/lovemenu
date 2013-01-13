defaults = {}

defaults.scale = love.graphics.getWidth()/800

defaults.group = nil

defaults.bg = {}
defaults.bg.img = love.graphics.newImage("menu/bg.png")
defaults.bg.color = {255,255,255,127}

defaults.action = {}
defaults.action.x = love.graphics.getWidth()*6/10
defaults.action.width = love.graphics.getWidth()*3/10
defaults.action.align = "center"
defaults.action.font = love.graphics.newFont("menu/action.ttf",20*defaults.scale)
defaults.action.color = {255,255,255,255}
defaults.action.bgcolor = {0,0,0,127}
defaults.action.hpadding = 8*defaults.scale
defaults.action.vpadding = 8*defaults.scale

defaults.select = {}
defaults.select.img = love.graphics.newImage("menu/select.png")

defaults.left = {}
defaults.left.img = love.graphics.newImage("menu/left.png")

defaults.right = {}
defaults.right.img = love.graphics.newImage("menu/right.png")

defaults.desc = {}
defaults.desc.font = love.graphics.newFont("menu/desc.ttf",26*defaults.scale)
defaults.desc.padding = 32*defaults.scale
defaults.desc.color = {255,255,255,255}

defaults.title = {}
defaults.title.font = love.graphics.newFont("menu/title.ttf",64*defaults.scale)
defaults.title.color = {255,255,255,255}
defaults.title.y_offset = 32*defaults.scale

return defaults