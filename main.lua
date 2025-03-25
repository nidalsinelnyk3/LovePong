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

  player1 = Player:new(1)
  player2 = Player:new(2)

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

  G.printf(
    "Hello Pong",
    0, windowSettings.virtual.height/2 - defaultFont:getHeight()/2,
    windowSettings.virtual.width,
    "center"
  )

  paddle1:draw()
  paddle2:draw()

  push:finish()
end
