require("lib/class")

local G = love.graphics

local Ball = require("src/Ball")
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

  love.window.setTitle("Pong")

  G.setDefaultFilter("nearest", "nearest")

  gameState = "start"

  player1 = Player:new()
  player2 = Player:new()

  paddle1 = player1:createPaddle({0, 0})
  paddle2 = player2:createPaddle(
    {windowSettings.virtual.width - Paddle.width,
     windowSettings.virtual.height - Paddle.height}
  )

  ball = Ball:new()
end

function love.update(dt)
  paddle1:update(dt)
  paddle2:update(dt)

  ball:update(dt)
end

function love.draw()
  G.clear(0.1, 0.1, 0.1, 1)
  G.setColor(1, 1, 1, 1)

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

  ball:draw()

  push:finish()

  displayFps()
end

function love.keypressed(key, _scanCode, _isRepeat)
  if gameState == "start" then
    if key == "enter" or key == "return" then
      gameState = "playing"
    end
  elseif gameState == "playing" then
    if key == "r" then
      ball:reset()
    elseif key == "escape" then
      ball:reset()
      gameState = "start"
    end
  end
end

function displayFps()
  G.setFont(defaultFont)
  G.setColor(0, 1, 0, 1)
  G.printf("FPS: " .. love.timer.getFPS(),
           0, G.getHeight() - defaultFont:getHeight()*2,
           G.getWidth(), "center")
end
