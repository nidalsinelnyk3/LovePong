require("lib/class")
require("src/players")

local G = love.graphics

local Ball = require("src/Ball")

local collisions = require("src/collisions")
local push = require("lib/push")
local settings = require("src/settings")
local virtualWindow = settings.window.virtual

function love.load()
  local push = push

  -- Create scaled down virtual window
  -- and change default aliasing to make the game feel low-res.
  push:setupScreen(virtualWindow.width, virtualWindow.height, G.getWidth(), G.getHeight())
  G.setDefaultFilter("nearest", "nearest")

  defaultFont = G.newFont("assets/fonts/mono.ttf", 30)
  gameState = "start"

  players:create()

  ball = Ball:new()
end

function love.update(dt)
  players:update(dt)
  ball:update(dt)

  collisions.betweenBallAndPaddles(ball)
  collisions.betweenBallAndWalls(ball)
end

function love.draw()
  local push = push

  G.clear(0.1, 0.1, 0.1, 1)
  G.setColor(1, 1, 1, 1)

  push:start()

  G.setFont(defaultFont)

  players:draw()

  if gameState == "start" then
    G.printf("First player to score 10 points wins", 0, 30, virtualWindow.width, "center")
    G.printf("Press Enter/Return to start", 0, virtualWindow.height - 60, virtualWindow.width, "center")

    ball:draw()
  elseif gameState == "playing" then
    ball:draw()
    displayFPS()
  elseif gameState == "over" then
    G.printf("Press Enter/Return to restart", 0, virtualWindow.height - 60, virtualWindow.width, "center")
  end

  push:finish()
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
