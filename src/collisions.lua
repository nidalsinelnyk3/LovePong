local tbl = require("lib/tbl")
local settings = require("src/settings")

collisions = {}

function collisions:update()
  self.betweenBallAndPaddles()
  self.betweenBallAndWalls()
end

function collisions.betweenBallAndPaddles()
  local ball = ball

  tbl.each(
    paddles,
    function(p)
      local collidedInX
      local collidedInY = ball.y >= p.y and ball.y <= p.y + p.height or
        ball.y + ball.height >= p.y and ball.y + ball.height <= p.y + p.height

      if p.player.id == 1 then
        collidedInX = ball.x <= p.x + p.width
      elseif p.player.id == 2 then
        collidedInX = ball.x + ball.width >= p.x
      end

      if collidedInX and collidedInY then ball:bounceFromPaddle(p) end
    end
  )
end

function collisions.betweenBallAndWalls()
  local collidedInX, collidedInY
  local ball = ball

  -- Handle collision with top and bottom sides of the screen
  if ball.dy < 0 then
    collidedInY = ball.y <= 0
  elseif ball.dy > 0 then
    collidedInY = ball.y + ball.height >= settings.window.virtual.height
  end

  if collidedInY then ball:bounceFromWall() end

  -- Handle ball moving beyond the window's edges
  if ball:isOffScreen() then
    if ball.shooter then
      ball.shooter:increaseScore()
      ball.shooter = nil
    end

    ball:reset()
  end
end
