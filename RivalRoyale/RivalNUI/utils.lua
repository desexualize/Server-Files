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
