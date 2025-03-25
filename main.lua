require("lib/class")

local G = love.graphics

local Ball = require("src/Ball")
local Paddle = require("src/Paddle")
local Player = require("src/Player")

local collisions = require("src/collisions")
local defaultFont = G.newFont("assets/fonts/mono.ttf", 30)
local push = require("lib/push")
local settings = require("src/settings")
local virtualWindow = settings.window.virtual

function love.load()
  local push = push

  -- Create scaled down virtual window and change default aliasing to make the game feel low-res
  push:setupScreen(virtualWindow.width, virtualWindow.height, G.getWidth(), G.getHeight())
  G.setDefaultFilter("nearest", "nearest")

  gameState = "start"

  player1 = Player:new()
  player2 = Player:new()

  paddle1 = player1:createPaddle({0, virtualWindow.height/2 - Paddle.height/2})
  paddle2 = player2:createPaddle(
    {virtualWindow.width - Paddle.width,
     virtualWindow.height/2 - Paddle.height/2}
  )

  ball = Ball:new()
end

function love.update(dt)
  paddle1:update(dt)
  paddle2:update(dt)

  ball:update(dt)

  collisions.betweenBallAndPaddles(ball, {paddle1, paddle2})
  collisions.betweenBallAndWalls(ball)
end

function love.draw()
  local push = push

  G.clear(0.1, 0.1, 0.1, 1)
  G.setColor(1, 1, 1, 1)

  push:start()

  G.setFont(defaultFont)

  if gameState == "start" then
    G.printf("Press Enter/Return to start", 0, 30, virtualWindow.width, "center")
  end

  player1:draw()
  player2:draw()

  paddle1:draw()
  paddle2:draw()

  ball:draw()

  push:finish()

  displayFPS()
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

function displayFPS()
  G.setFont(defaultFont)
  G.setColor(0, 1, 0, 1)
  G.printf("FPS: " .. love.timer.getFPS(),
           0, G.getHeight() - defaultFont:getHeight()*2,
           G.getWidth(), "center")
end
