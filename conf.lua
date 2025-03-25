local settings = require("src/settings")

function love.conf(t)
  t.version = "11.3"

  t.window.title = settings.window.title

  t.window.width = settings.window.real.width
  t.window.height = settings.window.real.height

  t.window.fullscreen = false
  t.window.resizable = false
  t.window.vsync = 1
end
