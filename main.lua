require("lib/class")

local G = love.graphics

WINDOW_WIDTH, WINDOW_HEIGHT = 1280, 720
GAME_SCALE = 0.7
GAME_WIDTH, GAME_HEIGHT = WINDOW_WIDTH * GAME_SCALE, WINDOW_HEIGHT * GAME_SCALE

local Paddle = require("src/Paddle")
local Player = require("src/Player")

local defaultFont = G.newFont("assets/fonts/mono.ttf", 30)
local push = require("lib/push")
local settings = require("src/settings")

function love.load()
  local windowSettings = settings.window

  push:setupScreen(
    windowSettings.virtual.width, windowSettings.virtual.height,
    windowSettings.real.width, windowSettings.real.height,
    windowSettings.flags
  )

  G.setDefaultFilter("nearest", "nearest")

  player1 = Player:new(1)
  player2 = Player:new(2)

  paddle1 = Paddle:new({0, 0}, player1)
  paddle2 = Paddle:new({GAME_WIDTH - Paddle.width, GAME_HEIGHT - Paddle.height}, player2)
end

function love.update(dt)
  paddle1:update(dt)
  paddle2:update(dt)
end

function love.draw()
  push:start()

  G.setFont(defaultFont)

  G.printf(
    "Hello Pong",
    0, GAME_HEIGHT/2 - defaultFont:getHeight()/2,
    GAME_WIDTH,
    "center"
  )

  paddle1:draw()
  paddle2:draw()

  push:finish()
end
