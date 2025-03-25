local settings = require("src/settings")

local G = love.graphics
local virtualWindow = settings.window.virtual

local start = {
  name = "start",
  commands = {
    ["return"] = function()
      game:startPlaying()
    end,
  }
}

start.commands.enter = start.commands["return"]

function start:update(dt) end

function start:draw()
  local ball = ball

  ball:draw()

  G.printf("First player to score 10 points wins", 0, 30, virtualWindow.width, "center")
  G.printf("Press Enter/Return to start", 0, virtualWindow.height - 60, virtualWindow.width, "center")
end

return start
