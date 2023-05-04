-- Example code block below (try-catch)
--
-- try {
--    function()
--       error("5")
--    end,
--    function(error)
--       print(error)
--    end
-- }
function try(fn)
  if not fn[1] or not fn[2] then
    return error('No function specified')
  end

  local ok, result, err = pcall(fn[1])

  if not ok then
    fn[2](result)
  end
end

function generateUUID()
  local pattern = 'xxxxxxxx-xxxx-4xxx-yxxx-xxxxxxxxxxxx'
  return string.gsub(pattern, '[xy]', function(c)
    local v = (c == 'x') and math.random(0, 0xf) or math.random(8, 0xb)
    return string.format('%x', v)
  end)
end

function generateTicket()
  return math.random(0xBAFF1ED)
end

function tableCount(T)
  local count = 0
  for _ in pairs(T) do
    count = count + 1
  end
  return count
end

function rotationToDirection(rotation)
  local radiansZ = rotation.z * 0.0174532924;
  local radiansX = rotation.x * 0.0174532924;
  local num = math.abs(math.cos(radiansX));
  local direction = {};

  direction.x = (-math.sin(radiansZ)) * num;
  direction.y = (math.cos(radiansZ)) * num;
  direction.z = math.sin(radiansX);

  return direction;
end

function tableMerge(...)
  local t = {}
  for n = 1, select('#', ...) do
    local arg = select(n, ...)
    if type(arg) == 'table' then
      for _, v in ipairs(arg) do
        t[#t + 1] = v
      end
    else
      t[#t + 1] = arg
    end
  end
  return t
end
