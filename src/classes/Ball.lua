local random = require("lib/random")
local settings = require("src/settings")

local A = love.audio
local G = love.graphics
local virtualWindow = settings.window.virtual

local Ball = class()

Ball:set{
  sounds = {
    bounce = A.newSource("assets/sounds/ballBounces.wav", "static"),
  }
}

function Ball:init()
  self.width, self.height = 20, 20
  self:reset()
end

function Ball:update(dt)
  if game:isPlaying() then
    self:move(dt)
  end
end

function Ball:draw()
  if game:isStart() or game:isPlaying() then
    G.rectangle("fill", self.x, self.y, self.width, self.height)
  end
end

function Ball:reset()
  self.x = virtualWindow.width/2 - self.width/2
  self.y = virtualWindow.height/2 - self.height/2
  self.dx = random.number(2) == 1 and 200 or -200
  self.dy = random.number(-120, 120)
end

function Ball:move(dt)
  self.x = self.x + self.dx * dt
  self.y = self.y + self.dy * dt
end

function Ball:bounceFromPaddle(paddle)
  self.shooter = paddle.player
  self.dx = -self.dx * 1.1
  self.dy = random.number(120) * (self.dy > 0 and 1 or -1)

  Ball.sounds.bounce:play()
end

function Ball:bounceFromWall()
  self.dy = -self.dy

  Ball.sounds.bounce:play()
end

function Ball:isOffScreen()
  return self.x >= virtualWindow.width or self.x + self.width <= 0 or
    self.y >= virtualWindow.height or self.y + self.height <= 0
end

return Ball
