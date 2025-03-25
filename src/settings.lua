local settings = {
  window = {
    real = {
      width = 1280,
      height = 720
    },
    flags = {
      fullscreen = false,
      resizable = false,
    }
  }
}

settings.window.scalingFactor = 0.7

settings.window.virtual = {
  width = settings.window.real.width * settings.window.scalingFactor,
  height = settings.window.real.height * settings.window.scalingFactor
}

return settings
