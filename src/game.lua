require("src/players")

local push = require("lib/push")
local settings = require("src/settings")

local G = love.graphics
local T = love.timer
local virtualWindow = settings.window.virtual

game = {
  states = {
    start = require("src/states/start"),
    playing = require("src/states/playing"),
    over = require("src/states/over"),
  }
}

function game:load()
  local G = love.graphics
  local Ball = require("src/classes/Ball")
  local players = players
  local push = push

  self:goToStart()

  -- Create scaled down virtual window
  -- and change default aliasing to make the game feel low-res.
  push:setupScreen(virtualWindow.width, virtualWindow.height, G.getWidth(), G.getHeight())
  G.setDefaultFilter("nearest", "nearest")

  defaultFont = G.newFont("assets/fonts/mono.ttf", 30)

  players:create()
  ball = Ball:new()
end

function game:update(dt)
  local ball = ball
  local players = players

  ball:update(dt)
  players:update(dt)
  self.state:update()
end

function game:draw()
  local ball = ball
  local push = push
  local players = players

  G.clear(0.1, 0.1, 0.1, 1)
  G.setColor(1, 1, 1, 1)
  G.setFont(defaultFont)

  push:start()
  ball:draw()
  players:draw()
  self.state:draw()
  push:finish()

  if self:isPlaying() then
    self:renderFPS()
  end
end

function game:getCommands()
  return self.state.commands or {}
end

-- Game state
function game:goToStart()
  self.state = self.states.start
end

function game:startPlaying()
  self.state = self.states.playing
end

function game:over()
  self.state = self.states.over
end

function game:isStart()
  return self.state == self.states.start
end

function game:isPlaying()
  return self.state == self.states.playing
end

function game:isOver()
  return self.state == self.states.over
end

function game:renderFPS()
  G.setColor(0, 1, 0, 1)
  G.printf("FPS: " .. T.getFPS(),
           0, G.getHeight() - defaultFont:getHeight()*2,
           G.getWidth(), "center")
  G.setColor(1, 1, 1, 1)
end
