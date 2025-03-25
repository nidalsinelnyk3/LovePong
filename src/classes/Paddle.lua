local G = love.graphics
local K = love.keyboard

local Paddle = class()

Paddle:set{
  width = 15,
  height = 80,
  dy = 200
}

function Paddle:init(pos, player)
  self.x, self.y = unpack(pos)
  self.player = player

  self.keys = {
    moveUp = player.id == 1 and "w" or "up",
    moveDown = player.id == 1 and "s" or "down"
  }
end

function Paddle:update(dt)
  self:move(dt)
end

function Paddle:draw()
  if self.player.isWinner then G.setColor(0, 1, 0, 1) end
  G.rectangle("fill", self.x, self.y, Paddle.width, Paddle.height)
  G.setColor(1, 1, 1, 1)
end

function Paddle:move(dt)
  local settings = require("src/settings")
  local vWindowHeight = settings.window.virtual.height

  if K.isDown(self.keys.moveUp) then
    self.y = math.max(0, self.y + -Paddle.dy * dt)
  elseif K.isDown(self.keys.moveDown) then
    self.y = math.min(vWindowHeight - Paddle.height, self.y + Paddle.dy * dt)
  end
end

return Paddle
