WINDOW_WIDTH = 1280
WINDOW_HEIGHT = 720

function love.load()
  love.window.setMode(
    WINDOW_WIDTH,
    WINDOW_HEIGHT,
    {
      fullscreen = false,
      resizable = false,
      vsync = true,
    }
  )
end

function love.update()
end

function love.draw()
  love.graphics.printf(
    "Hello Pong",
    0,
    WINDOW_HEIGHT/2,
    WINDOW_WIDTH,
    "center"
  )
end
