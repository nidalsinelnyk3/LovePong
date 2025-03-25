local commands = {
  game = {
    start = {
      ["return"] = function()
        gameState = "playing"
      end,
    },
    over = {
      ["return"] = function()
        gameState = "playing"
        players:reset()
        ball:reset()
      end,
    }
  }
}

commands.game.start.enter = commands.game.start["return"]
commands.game.over.enter = commands.game.over["return"]

return commands
