vRPCbc = {}
Tunnel.bindInterface("vrp_chief",vRPCbc)
Proxy.addInterface("vrp_chief",vRPCbc)
vRPSbc = Tunnel.getInterface("vrp_chief","vrp_chief")
vRP = Proxy.getInterface("vRP")

-- do not edit
local CT = Citizen.CreateThread
local notputontable = false

local tables = { -- you can edit this
    {-1194.1097412109,-888.77905273438,13.995308876038},
    {-1191.5727539062,-892.44781494141,13.995309829712},
    {-1187.5766601562,-893.54156494141,13.995308876038},
    {-1185.0959472656,-891.80078125,13.99530506134},
    {-1183.2351074219,-890.55871582031,13.99530506134},
    {-1184.1710205078,-888.91009521484,13.99530506134},
    {-1186.4243164062,-888.94989013672,13.995301246643},
    {-1188.9324951172,-885.18444824219,13.995301246643},
    {-1188.1666259766,-883.16955566406,13.99530506134},
    {-1189.2899169922,-881.72839355469,13.995306968689},
    {-1191.1026611328,-882.83923339844,13.995332717896},
    {-1193.5701904297,-884.50390625,13.995425224304},
    {-1192.1768798828,-885.94946289062,13.99530506134}
}

local food = { -- you can edit this ["text"] = {coords, 'function'}
    ["~w~Press ~g~[E] ~w~to preparing ~g~meat"] = {-1202.2666015625,-896.947265625,13.995309829712, 'meat'}, 
    ["~w~Press ~g~[E] ~w~to preparing ~g~fries"] = {-1201.1925048828,-898.71752929688,13.995308876038, 'fries'},
    ["~w~Press ~g~[E] ~w~to take ~g~fruits and vegetables"] = {-1198.80078125,-902.05194091797,13.995301246643, 'fruitsandvegetabels'},
    ["~w~Press ~g~[E] ~w~to take ~g~Coke"] = {-1198.6949462891,-895.49993896484,13.995308876038, 'coke'}
}

CT(function()
    local ticks = 1000
    while true do Wait(ticks)
        ticks = 1000
        local ped = PlayerPedId()
        if not notputontable then
            local distanta = #(vector3(-1195.1647949219,-893.66424560547,13.995307922363) - GetEntityCoords(ped))
            if distanta < 1 then
                ticks = 1
                drawtxt2d("~w~Press ~g~[E] ~w~to open a ~g~Burger Shot Menu", 0.52, 0.83)
                DrawMarker(2,-1195.1647949219,-893.66424560547,13.995307922363,0,0,0,0,0,0, 0.5001,0.5001,0.5001,0,255,0,100,0,1,0,0)
                if IsControlJustPressed(0, 51) then
                    vRPSbc.openchiefmenu({})
                end
            end
            for i,v in pairs(food) do
                local distanta = #(vector3(v[1],v[2],v[3]) - GetEntityCoords(ped))
                if distanta < 1 then
                    ticks = 1
                    drawtxt2d(i, 0.52, 0.83)
                    DrawMarker(2,v[1],v[2],v[3],0,0,0,0,0,0, 0.5001,0.5001,0.5001,0,255,0,100,0,1,0,0)
                    if IsControlJustReleased(0,51) then
                        _G[v[4]]()
                    end
                end
            end
        else
            local distanta = #(vector3(randomtables[1],randomtables[2],randomtables[3]) - GetEntityCoords(ped))
            if distanta < 40 then
                ticks = 1
                DrawMarker(0,randomtables[1],randomtables[2],randomtables[3],0,0,0,0,0,0, 0.5001,0.5001,0.5001,0,255,0,100,0,1,0,0)
                if distanta < 3 then
                    drawtxt2d("~w~Put food cooked by you on the table\n~g~Press [E] to put food on the table", 0.52, 0.83)
                    if IsControlJustReleased(0,51) then
                        vRPSbc.paychief({})
                        notputontable = false
                    end
                end
            end
        end
    end
end)


function vRPCbc.startMissionbook()
    notputontable = true
    randomtables = tables[math.random(1,#tables)]
end


-- here you have function, you cand edit this and add some things.
function meat()
    vRP.playAnim({true, {task="PROP_HUMAN_BBQ"}, false})
    vRP.notify({"~w~You now preparing ~g~Meat"})
    Wait(30000)
    vRP.stopAnim({false})
    vRP.notify({"~w~Finishng to preparing ~g~Meat"})
    vRPSbc.getfood({1})
end

function fries()
    vRP.playAnim({true, {task="PROP_HUMAN_BBQ"}, false})
    vRP.notify({"~w~You now preparing ~g~Fries"})
    Wait(30000)
    vRP.stopAnim({false})
    vRP.notify({"~w~Finishng to preparing ~g~Fries"})
    vRPSbc.getfood({2})
end

function fruitsandvegetabels()
    vRP.playAnim({true, {task="PROP_HUMAN_PARKING_METER"}, false})
    vRP.notify({"~w~You now take ~g~Fruit and Vegetables"})
    Wait(3000)
    vRP.stopAnim({false})
    vRPSbc.getfood({3})
end

function coke()
    vRP.playAnim({true, {task="PROP_HUMAN_PARKING_METER"}, false})
    vRP.notify({"~w~You take a ~g~Coke"})
    Wait(3000)
    vRP.stopAnim({false})
    vRPSbc.getfood({4})
end

drawtxt2d = function(msg, x, y)
    SetTextFont(6)
    SetTextProportional(0)
    SetTextScale(0.6, 0.6)
    SetTextColour(255, 255, 255, 255)
    SetTextDropShadow(0, 0, 0, 0,255)
    SetTextEdge(1, 0, 0, 0, 255)
    SetTextCentre(1)
    SetTextEntry("STRING")
    AddTextComponentString(msg)
    DrawText(x - 0.0/2, y - 0.0/2 + 0.005)
end
