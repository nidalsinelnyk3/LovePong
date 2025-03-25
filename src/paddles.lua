local settings = require("src/settings")

local virtualWindow = settings.window.virtual

local Paddle = require("src/classes/Paddle")

paddles = {
  initialPositions = {
    {0, virtualWindow.height/2 - Paddle.height/2},
    {virtualWindow.width - Paddle.width, virtualWindow.height/2 - Paddle.height/2}
  }
}
