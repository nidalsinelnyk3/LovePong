local settings = {
  window = {
    title = "Pong",
    real = {
      width = 1280,
      height = 720
    },
    virtual = {}
  }
}

settings.window.virtual.scalingFactor = 0.8

settings.window.virtual = {
  width = settings.window.real.width * settings.window.virtual.scalingFactor,
  height = settings.window.real.height * settings.window.virtual.scalingFactor
}

return settings
