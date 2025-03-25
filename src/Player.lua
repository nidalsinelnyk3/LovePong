local G = love.graphics
local settings = require("src/settings")

local Player = class()

Player:set{
  availableSlots = {1, 2},
  scoreFont = G.newFont("assets/fonts/mono.ttf", 80)
}

function Player:init()
  self.id = table.remove(Player.availableSlots, 1)
  self.score = 0
end

function Player:draw()
  if gameState == "playing" then
    self:renderScore()
  end
end

function Player:renderScore()
  local halfWindowWidth = settings.window.virtual.width/2
  local x = self.id == 1 and 0 or halfWindowWidth

  G.setFont(Player.scoreFont)
  G.printf(self.score, x, 50, halfWindowWidth, "center")
end

return Player
