local tbl = {}

function tbl.each(list, fn)
  if #list == 0 then return end
  for i, v in ipairs(list) do fn(v, i) end
end

function tbl.reverseEach(list, fn)
  if #list == 0 then return end
  for i=#list, 1, -1 do fn(list[i], i) end
end

function tbl.map(list, fn)
  t = {}
  for i, v in ipairs(list) do t[i] = fn(v) end
  return t
end

function tbl.reverseMap(list, fn)
  t = {}
  for i=#list, 1, -1 do t[i] = fn(list[i], i) end
  return t
end

function tbl.filter(list, fn)
  t = {}
  for i, v in ipairs(list) do if fn(v) then table.insert(t, v) end end
    return t
end

function tbl.keys(t)
  t2 = {}
  for k, _v in pairs(t) do table.insert(t2, k) end
  return t2
end

function tbl.values(t)
  t2 = {}
  for _k, v in pairs(t) do table.insert(t2, v) end
  return t2
end

return tbl
