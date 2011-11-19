require("menu/menu")
function love.load()
  menu:toggle()
  local view = {}
  view[1] = {
    title="Welcome to the game!",
    {t="New Game",cb="ng"},
    {t="Options",cb="op"},
    {t="Exit",cb="exit"}
  }
  view[2] = {
    title="Set your options here.",
    {t="Fullscreen",cb="fs"},
    {t="Change Res",cb="res"},
    {t="Sound on/off",cb="sound"},
    {t="Back",cb="mm"}
  }
  view[3] = {
    title="Are you sure you want to exit?",
    {t="Confirm Quit",cb="cexit"},
    {t="Return to Main Menu",cb="mm"}
  }
  menu:load(view)
end
function love.draw()
  menu:draw()
end

function love.keypressed(key)
  menu:keypressed(key)
end

function menu:callback(cb)
  if cb == "ng" then
    menu:toggle()
  elseif cb == "op" then
    menu:setstate(2)
  elseif cb == "exit" then
    menu:setstate(3)
  elseif cb == "cexit" then
    love.event.push("q")
  elseif cb == "fs" then
    love.graphics.toggleFullscreen( )
  elseif cb == "res" then
    print("change res")
  elseif cb == "sound" then
    print("muted!")
  elseif cb == "mm" then
    menu:setstate(1)
  end
end
