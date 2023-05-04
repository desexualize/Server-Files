RegisterNetEvent("ARMA:jobInstructions",function(a) -- send this when selecting job from sv job selector
    if a == "Royal Mail Driver" then
        royalMailInstructions()
    elseif a == "Bus Driver" then
        busDriverInstructions()
    elseif a == "Deliveroo" then
        deliverooInstructions()
    elseif a == "Scuba Diver" then
        scubaDivingInstructions()
    elseif a == "G4S Driver" then
        G4SInstructions()
    elseif a == "Taco Seller" then
        tacoInstructions()
    elseif a == "Burger Shot Cook" then
        burgerShotInstructions()
    end
end)

function burgerShotInstructions()
    PlaySound(-1, "CHECKPOINT_BEHIND", "HUD_MINI_GAME_SOUNDSET", 0, 0, 1)
    initializeInstructionalJobScaleform("Welcome to Burgershot","I have set a waypoint to Burgershot where you can start your career.")
    SetNewWaypoint(-1202.330078125, -896.974609375)
end
function royalMailInstructions()
    PlaySound(-1, "CHECKPOINT_BEHIND", "HUD_MINI_GAME_SOUNDSET", 0, 0, 1)
    initializeInstructionalJobScaleform("Royal Mail","I have set a waypoint to the Royal Mail garage where you can start your shift.")
    SetNewWaypoint(-19.447393417358, -705.32580566406)
end
function busDriverInstructions()
    PlaySound(-1, "CHECKPOINT_BEHIND", "HUD_MINI_GAME_SOUNDSET", 0, 0, 1)
    initializeInstructionalJobScaleform("Bus Driving","I have set a waypoint to the Bus garage where you can start your shift.")
    SetNewWaypoint(429.52169799804, -587.45068359375)
end
function deliverooInstructions()
    PlaySound(-1, "CHECKPOINT_BEHIND", "HUD_MINI_GAME_SOUNDSET", 0, 0, 1)
    initializeInstructionalJobScaleform("Deliveroo","I have set a waypoint to the restaurant where you can start your shift.")
    SetNewWaypoint(-1174.4127197266, -872.98626708984)
end
function scubaDivingInstructions()
    PlaySound(-1, "CHECKPOINT_BEHIND", "HUD_MINI_GAME_SOUNDSET", 0, 0, 1)
    initializeInstructionalJobScaleform("Scuba Diving","I have set a waypoint to the Scuba Diving shop where you'll start your first job.")
    SetNewWaypoint(-2195.6926269531, -394.82040405273)
end
function G4SInstructions()
    PlaySound(-1, "CHECKPOINT_BEHIND", "HUD_MINI_GAME_SOUNDSET", 0, 0, 1)
    initializeInstructionalJobScaleform("G4S","I have set a waypoint to the G4S depot where you'll start your first job.")
    SetNewWaypoint(-710.4659, 269.6835)
end
function tacoInstructions()
    PlaySound(-1, "CHECKPOINT_BEHIND", "HUD_MINI_GAME_SOUNDSET", 0, 0, 1)
    initializeInstructionalJobScaleform("Taco Seller", "Buy a Taco truck at Simeons then type /taco to start selling!")
    SetNewWaypoint(-47.174137115479, -1109.6021728516)
end
function initializeInstructionalJobScaleform(b, c)
    Citizen.CreateThread(function()
        function Initialize(d)
            local d = RequestScaleformMovie(d)
            while not HasScaleformMovieLoaded(d) do
                Citizen.Wait(0)
            end
            BeginScaleformMovieMethod(d, "SHOW_SHARD_WASTED_MP_MESSAGE")
            ScaleformMovieMethodAddParamTextureNameString(b)
            ScaleformMovieMethodAddParamTextureNameString(c)
            ScaleformMovieMethodAddParamInt(5)
            EndScaleformMovieMethod()
            return d
        end
        local d = Initialize("mp_big_message_freemode")
        local e = true
        SetTimeout(
            10000,
            function()
                e = false
            end
        )
        while e do
            local f = 0.5
            local g = 0.35
            local h = 1.0
            local i = h
            DrawScaleformMovie(d, f, g, h, i)
            Wait(0)
        end
    end)
end

function subtitleText(E)
    BeginTextCommandPrint("STRING")
    AddTextComponentSubstringPlayerName(E)
    EndTextCommandPrint(1000,1)
end