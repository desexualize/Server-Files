globalBlips = {}
function tAQUA.addBlip(a, b, c, d, e, f, g, h)
    local i = AddBlipForCoord(a + 0.001, b + 0.001, c + 0.001)
    SetBlipSprite(i, d)
    SetBlipAsShortRange(i, true)
    SetBlipColour(i, e)
    if d == 403 or d == 431 or d == 365 or d == 85 or d == 140 or d == 60 or d == 44 or d == 110 or d == 315 then
        SetBlipScale(i, 1.1)
    elseif d == 50 then
        SetBlipScale(i, 0.7)
    else
        SetBlipScale(i, 0.8)
    end
    SetBlipScale(i, g or 0.5)
    if h then
        SetBlipDisplay(i, 5)
    end
    if f ~= nil then
        BeginTextCommandSetBlipName("STRING")
        AddTextComponentSubstringPlayerName(f)
        EndTextCommandSetBlipName(i)
    end
    table.insert(globalBlips, i)
    return i
end
function tAQUA.removeBlip(j)
    RemoveBlip(j)
end
local k = {}
function tAQUA.setNamedBlip(l, a, b, c, d, e, f, g)
    tAQUA.removeNamedBlip(l)
    k[l] = tAQUA.addBlip(a, b, c, d, e, f, g)
    return k[l]
end
function tAQUA.removeNamedBlip(l)
    if k[l] ~= nil then
        tAQUA.removeBlip(k[l])
        k[l] = nil
    end
end
function tAQUA.setGPS(a, b)
    SetNewWaypoint(a + 0.0001, b + 0.0001)
end
function tAQUA.setBlipRoute(j)
    SetBlipRoute(j, true)
end
local m = {}
local n = Tools.newIDGenerator()
local o = {}
local p = {}
local q = {}
function tAQUA.addMarker(a, b, c, r, s, t, u, v, w, x, y, z, A, B, C, D, E, F, G, H)
    local I = {
        position = vector3(a, b, c),
        sx = r,
        sy = s,
        sz = t,
        r = u,
        g = v,
        b = w,
        a = x,
        visible_distance = y,
        mtype = z,
        faceCamera = A,
        bopUpAndDown = B,
        rotate = C,
        textureDict = D,
        textureName = E,
        xRot = F,
        yRot = G,
        zRot = H
    }
    if I.sx == nil then
        I.sx = 2.0
    end
    if I.sy == nil then
        I.sy = 2.0
    end
    if I.sz == nil then
        I.sz = 0.7
    end
    if I.r == nil then
        I.r = 0
    end
    if I.g == nil then
        I.g = 155
    end
    if I.b == nil then
        I.b = 255
    end
    if I.a == nil then
        I.a = 200
    end
    I.sx = I.sx + 0.001
    I.sy = I.sy + 0.001
    I.sz = I.sz + 0.001
    if I.visible_distance == nil then
        I.visible_distance = 150
    end
    local j = n:gen()
    m[j] = I
    q[j] = I
    return j
end
function tAQUA.removeMarker(j)
    if m[j] ~= nil then
        m[j] = nil
        n:free(j)
    end
    if q[j] then
        q[j] = nil
    end
end
function tAQUA.setNamedMarker(l, a, b, c, r, s, t, u, v, w, x, y, z, A, B, C, D, E, F, G, H)
    tAQUA.removeNamedMarker(l)
    o[l] = tAQUA.addMarker(a, b, c, r, s, t, u, v, w, x, y, z, A, B, C, D, E, F, G, H)
    return o[l]
end
function tAQUA.removeNamedMarker(l)
    if o[l] ~= nil then
        tAQUA.removeMarker(o[l])
        o[l] = nil
    end
end
local J = {}
Citizen.CreateThread(
    function()
        while true do
            for K, L in pairs(p) do
                if J[K] then
                    if J[K] <= L.visible_distance then
                        if L.mtype == nil then
                            L.mtype = 1
                        end
                        DrawMarker(
                            L.mtype,
                            L.position.x,
                            L.position.y,
                            L.position.z,
                            0.0,
                            0.0,
                            0.0,
                            L.xRot,
                            L.yRot,
                            L.zRot,
                            L.sx,
                            L.sy,
                            L.sz,
                            L.r,
                            L.g,
                            L.b,
                            L.a,
                            L.bopUpAndDown,
                            L.faceCamera,
                            2,
                            L.rotate,
                            L.textureDict,
                            L.textureName
                        )
                    end
                end
            end
            Wait(0)
        end
    end
)

-- GPS

-- set the GPS destination marker coordinates
function tAQUA.setGPS(x,y)
  SetNewWaypoint(x+0.0001,y+0.0001)
end

-- set route to native blip id
function tAQUA.setBlipRoute(id)
  SetBlipRoute(id,true)
end

-- MARKER

local markers = {}
local marker_ids = Tools.newIDGenerator()
local named_markers = {}
local drawing_markers = {}

-- add a circular marker to the game map
-- return marker id
function tAQUA.addMarker(x,y,z,sx,sy,sz,r,g,b,a,visible_distance)
  local marker = {x=x,y=y,z=z,sx=sx,sy=sy,sz=sz,r=r,g=g,b=b,a=a,visible_distance=visible_distance}


  -- default values
  if marker.sx == nil then marker.sx = 2.0 end
  if marker.sy == nil then marker.sy = 2.0 end
  if marker.sz == nil then marker.sz = 0.7 end

  if marker.r == nil then marker.r = 0 end
  if marker.g == nil then marker.g = 155 end
  if marker.b == nil then marker.b = 255 end
  if marker.a == nil then marker.a = 200 end

  -- fix gta5 integer -> double issue
  marker.x = marker.x+0.001
  marker.y = marker.y+0.001
  marker.z = marker.z+0.001
  marker.sx = marker.sx+0.001
  marker.sy = marker.sy+0.001
  marker.sz = marker.sz+0.001

  if marker.visible_distance == nil then marker.visible_distance = 150 end

  local id = marker_ids:gen()
  markers[id] = marker

  return id
end

-- remove marker
function tAQUA.removeMarker(id)
  if markers[id] ~= nil then
    markers[id] = nil
    marker_ids:free(id)
  end
end

-- set a named marker (same as addMarker but for a unique name, add or update)
-- return id
function tAQUA.setNamedMarker(name,x,y,z,sx,sy,sz,r,g,b,a,visible_distance)
  tAQUA.removeNamedMarker(name) -- remove old marker

  named_markers[name] = tAQUA.addMarker(x,y,z,sx,sy,sz,r,g,b,a,visible_distance)
  return named_markers[name]
end

function tAQUA.removeNamedMarker(name)
  if named_markers[name] ~= nil then
    tAQUA.removeMarker(named_markers[name])
    named_markers[name] = nil
  end
end

-- markers draw loop
Citizen.CreateThread(function()
  while true do
    Citizen.Wait(0)

    local px,py,pz = tAQUA.getPosition()

    -- if this loop get filled with too many markers, the clientside
    -- starts lagging
    for k,v in pairs(drawing_markers) do
      -- check visibility
      if #(vector3(v.x,v.y,v.z) - vector3(px,py,pz)) <= v.visible_distance then
        DrawMarker(1,v.x,v.y,v.z,0,0,0,0,0,0,v.sx,v.sy,v.sz,v.r,v.g,v.b,v.a,0,0,0,0)
      end
    end
  end
end)

-- AREA

local areas = {}

-- create/update a cylinder area
function tAQUA.setArea(name,x,y,z,radius,height)
  local area = {x=x+0.001,y=y+0.001,z=z+0.001,radius=radius,height=height}

  -- default values
  if area.height == nil then area.height = 6 end

  areas[name] = area
end

-- remove area
function tAQUA.removeArea(name)
  if areas[name] ~= nil then
    areas[name] = nil
  end
end

-- areas triggers detections
Citizen.CreateThread(function()
  while true do
    Citizen.Wait(250)

    local px,py,pz = tAQUA.getPosition()

    for k,v in pairs(areas) do
      -- detect enter/leave

      -- local player_in = (GetDistanceBetweenCoords(v.x,v.y,v.z,px,py,pz,true) <= v.radius and math.abs(pz-v.z) <= v.height)
      
      local player_in = (#(vec(v.x, v.y, v.z) - vector3(px, py, pz)) <= v.radius and math.abs(pz-v.z) <= v.height)

      if v.player_in and not player_in then -- was in: leave
        AQUAserver.leaveArea({k})
      elseif not v.player_in and player_in then -- wasn't in: enter
        AQUAserver.enterArea({k})
      end

      v.player_in = player_in -- update area player_in
    end
  end
end)

-- DOOR

-- set the closest door state
-- doordef: .model or .modelhash
-- locked: boolean
-- doorswing: -1 to 1
function tAQUA.setStateOfClosestDoor(doordef, locked, doorswing)
  local x,y,z = tAQUA.getPosition()
  local hash = doordef.modelhash
  if hash == nil then
    hash = GetHashKey(doordef.model)
  end

  SetStateOfClosestDoorOfType(hash,x,y,z,locked,doorswing+0.0001)
end

function tAQUA.openClosestDoor(doordef)
  tAQUA.setStateOfClosestDoor(doordef, false, 0)
end

function tAQUA.closeClosestDoor(doordef)
  tAQUA.setStateOfClosestDoor(doordef, true, 0)
end
