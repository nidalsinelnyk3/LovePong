local Paddle = require("src/classes/Paddle")
local settings = require("src/settings")
local tbl = require("lib/tbl")

local virtualWindow = settings.window.virtual

local A = love.audio
local G = love.graphics

local Player = class()

Player:set{
  availableSlots = {1, 2},
  defaultFont = G.newFont("assets/fonts/mono.ttf", 50),
  scoreFont = G.newFont("assets/fonts/mono.ttf", 80),
  sounds = {
    score = A.newSource("assets/sounds/playerScores.wav", "static"),
    win = A.newSource("assets/sounds/playerWins.wav", "static")
  }
}

function Player:init()
  self.id = table.remove(Player.availableSlots, 1)
  self:reset()
end

function Player:draw()
  if not game:isStart() then self:renderScore() end

  if self.isWinner and game:isOver() then
    self:renderVictoryMsg()
  end
end

function Player:reset()
  self.score = 0
  self.isWinner = false
end

function Player:createPaddle(pos)
  self.paddle = Paddle:new(pos, self)
  return self.paddle
end

function Player:increaseScore()
  self.score = self.score + 1

  if self.score < 10 then
    Player.sounds.score:play()
  else
    self.isWinner = true
    Player.sounds.win:play()
    game:over()
  end
end

function Player:renderScore()
  local halfWindowWidth = settings.window.virtual.width/2
  local x = self.id == 1 and 0 or halfWindowWidth

  G.setFont(Player.scoreFont)
  G.printf(self.score, x, 50, halfWindowWidth, "center")
  G.setFont(defaultFont)
end

function Player:renderVictoryMsg()
  G.setFont(Player.defaultFont)
  G.printf(
    "Player #" .. self.id .. " wins!",
    0, virtualWindow.height - 120,
    virtualWindow.width, "center"
  )
  G.setFont(defaultFont)
end

return Player
