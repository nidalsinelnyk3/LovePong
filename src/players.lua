require("src/paddles")

local tbl = require("lib/tbl")

players = {}

function players:create()
  local Player = require("src/classes/Player")

  for i=1, 2, 1 do
    local player = Player:new()

    table.insert(players, player)
    table.insert(paddles, player:createPaddle(paddles.initialPositions[i]))
  end
end

function players:update(dt)
  tbl.each(
    players,
    function(p)
      p.paddle:update(dt)
    end
  )
end

function players:draw()
  tbl.each(
    players,
    function(p)
      p:draw()
      p.paddle:draw()
    end
  )
end

function players:reset()
  tbl.each(players, function(p) p:reset() end)
end
