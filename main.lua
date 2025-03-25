require("lib/class")

local G = love.graphics

local Paddle = require("src/Paddle")
local Player = require("src/Player")

local defaultFont = G.newFont("assets/fonts/mono.ttf", 30)
local push = require("lib/push")
local settings = require("src/settings")
local windowSettings = settings.window

function love.load()
  push:setupScreen(
    windowSettings.virtual.width, windowSettings.virtual.height,
    windowSettings.real.width, windowSettings.real.height,
    windowSettings.flags
  )

  G.setDefaultFilter("nearest", "nearest")

  gameState = "start"

  player1 = Player:new()
  player2 = Player:new()

  paddle1 = Paddle:new({0, 0}, player1)
  paddle2 = Paddle:new({windowSettings.virtual.width - Paddle.width, windowSettings.virtual.height - Paddle.height}, player2)
end

function love.update(dt)
  paddle1:update(dt)
  paddle2:update(dt)
end

function love.draw()
  push:start()

  G.setFont(defaultFont)

  if gameState == "start" then
    G.printf(
      "Press Enter/Return to start",
      0, 30,
      windowSettings.virtual.width,
      "center"
    )
  end

  player1:draw()
  player2:draw()

  paddle1:draw()
  paddle2:draw()

  push:finish()
end

function love.keypressed(key, _scanCode, _isRepeat)
  if key == "enter" or key == "return" then
    gameState = "playing"
  end
end
