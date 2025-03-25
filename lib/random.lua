local random = {}

function random.number(min, max)
  math.randomseed(os.time())

  local from = max and math.min(min, max) or math.min(min, 1)
  local to = max and math.max(min, max) or math.max(min, 1)
  local randomNum = math.random(from, to)

  return randomNum == 0 and math.random(from, to) or randomNum
end

return random
