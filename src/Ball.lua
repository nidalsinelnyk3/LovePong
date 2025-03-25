local G = love.graphics
local settings = require("src/settings")
local virtualWindow = settings.window.virtual

local Ball = class()

function Ball:init()
  local randomizedInitialSpeed = function()
    math.randomseed(os.time())

    local dx = math.random(2) == 1 and 200 or -200
    local dy = math.random(-50, 50)

    return dx, dy
  end

  self.width, self.height = 20, 20

  self.x = virtualWindow.width/2 - self.width/2
  self.y = virtualWindow.height/2 - self.height/2

  self.dx, self.dy = randomizedInitialSpeed()
end

function Ball:update(dt)
  if gameState == "playing" then
    self:move(dt)
  end
end

function Ball:draw()
  G.rectangle("fill", self.x, self.y, self.width, self.height)
end

function Ball:move(dt)
  self.x = self.x + self.dx * dt
  self.y = self.y + self.dy * dt
end

return Ball
