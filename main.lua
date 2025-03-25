require("lib/class")
require("src/game")

local tbl = require("lib/tbl")

function love.load()
  game:load()
end

function love.update(dt)
  game:update(dt)
end

function love.draw()
  game:draw()
end

function love.keypressed(key, _scanCode, _isRepeat)
  local game = game
  local cmd = tbl.dig(game:getCommands(), key)

  if cmd then cmd() end
end
