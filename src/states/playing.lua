require("src/collisions")

local playing = {
  name = "playing"
}

function playing:update(dt)
  collisions:update()
end

function playing:draw() end

return playing
