local tbl = require("lib/tbl")

local utils = {}

function utils.distanceBetweenPoints(pos1, pos2)
  x1, y1 = unpack(pos1)
  x2, y2 = unpack(pos2)

  return math.sqrt((x1 - x2) ^ 2 + (y1 - y2) ^ 2)
end

function utils.hex(hex, alpha)
  local convertHex = function(code) return math.floor((tonumber(code, 16) / 255) * 100) / 100 end

  hex = hex:gsub("#", "")
  local colorCodes = {hex:match('(..)(..)(..)')}
  local convertedColors = tbl.map(colorCodes, convertHex)
  table.insert(convertedColors, alpha or 1)

  return unpack(convertedColors)
end

function utils.rgb(r, g, b, alpha)
  local convertRgb = function(code) return math.floor((code/255) * 100) / 100 end

  local colorCodes = {r, g, b}
  convertedColors = tbl.map(colorCodes, convertRgb)
  table.insert(convertedColors, alpha or 1)

  return unpack(convertedColors)
end

return utils
