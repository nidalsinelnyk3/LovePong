local settings = require("src/settings")

local virtualWindow = settings.window.virtual

local over = {
  name = "over",
  commands = {
    ["return"] = function()
      game:startPlaying()
      players:reset()
      ball:reset()
    end,
  }
}

over.commands.enter = over.commands["return"]

function over:update(dt) end

function over:draw()
  local G = love.graphics

  G.printf(
    "Press Enter/Return to restart",
    0, virtualWindow.height - 60,
    virtualWindow.width, "center"
  )
end

return over
