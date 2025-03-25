local G = love.graphics

local WINDOW_WIDTH, WINDOW_HEIGHT = 1280, 720
local GAME_WIDTH, GAME_HEIGHT = WINDOW_WIDTH * 0.8, WINDOW_HEIGHT * 0.8

local defaultFont = G.newFont("assets/fonts/mono.ttf", 30)
local push = require("lib/push")

function love.load()
  push:setupScreen(
    GAME_WIDTH, GAME_HEIGHT,
    WINDOW_WIDTH, WINDOW_HEIGHT,
    {
      fullscreen = false,
      resizable = false,
    }
  )

  G.setDefaultFilter("nearest", "nearest")
end

function love.update()
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

  push:finish()
end
