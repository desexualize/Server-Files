local isJudge = false
local isMedic = false
local isDoctor = false
local isNews = false
local isInstructorMode = false
local myJob = "unemployed"
local isHandcuffed = false
local isHandcuffedAndWalking = false
local hasOxygenTankOn = false
local gangNum = 0
local cuffStates = {}
MetPD = false
onduty = MetPD

--RegisterNetEvent("ERP:PoliceClockedOn")
--AddEventHandler("ERP:PoliceClockedOn", function(MetPD)
--    onduty = MetPD
--end)

--[[
function UpdateMetPD(MetPD)
    MetPD = MetPD 
    --print(MetPD)
end]]


rootCarMenuConfig =  {
    {
        id = "general",
        displayName = "Vehicle General",
        icon = "#vehicle-options",
        enableMenu = function()
            return true
        end,
        subMenus = {"vehmenu:openboot", "vehmenu:lockcar","vehmenu:repaircar","vehmenu:lockpick",'general:exitmenu'}
    },
    {
        id = "police-action",
        displayName = "Police Vehicle Actions",
        icon = "#police-action",
        enableMenu = function()
            if onduty then 
                return true
            end
        end,
        subMenus = {--[['vehmenupd:openboot',]]'vehmenupd:clampveh','vehmenupd:unclampveh','general:exitmenu'}
    },
}

rootInCarMenuConfig =  {
    {
        id = "general",
        displayName = "Vehicle General",
        icon = "#vehicle-options",
        enableMenu = function()
            return true
        end,
        subMenus = {"vehmenu:lockcar","vehmenu:repaircar","vehmenu:lockpick",'general:exitmenu'}
    },
    {
        id = "police-action",
        displayName = "Impound Vehicle",
        icon = "#vehicle-options",
        functionName = "police:impound",
        enableMenu = function()
            if onduty then 
                return true
            end
        end,
    },
    {
        id = "vehicle-seats",
        displayName = "Vehicle Seats",
        icon = "#chair",
        functionName = "veh:options",
        enableMenu = function()
            if IsPedInAnyVehicle(PlayerPedId()) then 
                return true
            end
        end,
    },
}





rootMenuConfig =  {
    {
        id = "general",
        displayName = "General",
        icon = "#globe-europe",
        enableMenu = function()
            return true
        end,
        subMenus = { "general:askid", "general:searchnearest", 'general:givemoney','general:exitmenu'}
    },
    {
        id = "police-action",
        displayName = "Police Actions",
        icon = "#police-action",
        enableMenu = function()
            if onduty then 
                return true
            end
        end,
        subMenus = {'general:exitmenu',"police:cpr","cuffs:cuff", "police:escort", "police:putinvehicle", "police:unseatnearest", "cuffs:checkinventory", "police:getid", "police:jail", "police:unjail", 'police:fine', 'police:seize', 'police:seizeitems'}
    },
}

newSubMenus = {
    ['vehmenu:openboot'] = {
        title = "Open Boot",
        icon = "#vehicle-options-vehicle",
        functionName = "serverBoot"
    }, 
    -- ['vehmenu:repaircar'] = {
    --     title = "Repair Vehicle",
    --     icon = "#general-check-vehicle",
    --     functionName = "ERP:ComingSoon"
    -- }, 
    ['vehmenu:lockpick'] = {
        title = "Lockpick Vehicle",
        icon = "#general-keys-give",
        functionName = "ERP:LockPick2"
    },
    ['general:exitmenu'] = {
        title = "Exit Menu",
        icon = "#animation-hurry",
        functionName = "None"
    },  

    ['police:cpr'] = {
        title = "CPR",
        icon = "#general-check-over-target",
        functionName = 'ERPClient:ReviveCPR'
    },
    




    ['vehmenupd:openboot'] = {
        title = "Search Boot",
        icon = "#vehicle-options-vehicle",
        functionName = "serverBoot"
    }, 
    ['vehmenupd:clampveh'] = {
        title = "Clamp Vehicle",
        icon = "#car-side",
        functionName = "ERP:ClampVehicle"
    },  
    ['vehmenupd:unclampveh'] = {
        title = "Unclamp Vehicle",
        icon = "#car-side",
        functionName = "ERP:UnClampVehicles"
    },  
    ['general:exitmenu'] = {
        title = "Exit Menu",
        icon = "#animation-hurry",
        functionName = "None"
    },  


    -- Vehicle Menu ^






    ['general:emotes'] = {
        title = "Store Weapons",
        icon = "#general-emotes",
        functionName = "ERP:Storeweapons"
    },    
    ['general:askid'] = {
        title = "Ask For ID",
        icon = "#police-vehicle-plate",
        functionName = "ERP:AskID"
    },
    ['general:searchnearest'] = {
        title = "Search Player",
        icon = "#cuffs-check-inventory",
        functionName = "ERP:SearchNearest"
    },
    ['general:aparttakekey'] = {
        title = "Take Key",
        icon = "#general-apart-givekey",
        functionName = "menu:takekeys"
    },
    ['general:givemoney'] = {
        title = "Give Money",
        icon = "#animation-money",
        functionName = "ERP:GiveMoney"
    },
--[[     ['general:checkoverself'] = {
        title = "Examine Self",
        icon = "#general-check-over-self",
        functionName = "Evidence:CurrentDamageList"
    },
    ['general:checktargetstates'] = {
        title = "Examine Target",
        icon = "#general-check-over-target",
        functionName = "requestWounds"
    }, ]]
--[[     ['general:checkvehicle'] = {
        title = "Examine Vehicle",
        icon = "#general-check-vehicle",
        functionName = "towgarage:annoyedBouce"
    }, ]]
    ['general:putinvehicle'] = {
        title = "Seat Vehicle",
        icon = "#general-put-in-veh",
        functionName = "police:forceEnter"
    },
    ['general:unseatnearest'] = {
        title = "Unseat Nearest",
        icon = "#general-unseat-nearest",
        functionName = "unseatPlayer"
    },    
    ['general:flipvehicle'] = {
        title = "Flip Vehicle",
        icon = "#general-flip-vehicle",
        functionName = "FlipVehicle"
    },
    ['animations:brave'] = {
        title = "Brave",
        icon = "#animation-brave",
        functionName = "AnimSet:Brave"
    },
    ['animations:hurry'] = {
        title = "Hurry",
        icon = "#animation-hurry",
        functionName = "AnimSet:Hurry"
    },
    ['animations:business'] = {
        title = "Business",
        icon = "#animation-business",
        functionName = "AnimSet:Business"
    },
    ['animations:tipsy'] = {
        title = "Tipsy",
        icon = "#animation-tipsy",
        functionName = "AnimSet:Tipsy"
    },
    ['animations:injured'] = {
        title = "Injured",
        icon = "#animation-injured",
        functionName = "AnimSet:Injured"
    },
    ['animations:tough'] = {
        title = "Tough",
        icon = "#animation-tough",
        functionName = "AnimSet:ToughGuy"
    },
    ['animations:sassy'] = {
        title = "Sassy",
        icon = "#animation-sassy",
        functionName = "AnimSet:Sassy"
    },
    ['animations:sad'] = {
        title = "Sad",
        icon = "#animation-sad",
        functionName = "AnimSet:Sad"
    },
    ['animations:posh'] = {
        title = "Posh",
        icon = "#animation-posh",
        functionName = "AnimSet:Posh"
    },
    ['animations:alien'] = {
        title = "Alien",
        icon = "#animation-alien",
        functionName = "AnimSet:Alien"
    },
    ['animations:nonchalant'] =
    {
        title = "Nonchalant",
        icon = "#animation-nonchalant",
        functionName = "AnimSet:NonChalant"
    },
    ['animations:hobo'] = {
        title = "Hobo",
        icon = "#animation-hobo",
        functionName = "AnimSet:Hobo"
    },
    ['animations:money'] = {
        title = "Money",
        icon = "#animation-money",
        functionName = "AnimSet:Money"
    },
    ['animations:swagger'] = {
        title = "Swagger",
        icon = "#animation-swagger",
        functionName = "AnimSet:Swagger"
    },
    ['animations:shady'] = {
        title = "Shady",
        icon = "#animation-shady",
        functionName = "AnimSet:Shady"
    },
    ['animations:maneater'] = {
        title = "Man Eater",
        icon = "#animation-maneater",
        functionName = "AnimSet:ManEater"
    },
    ['animations:chichi'] = {
        title = "ChiChi",
        icon = "#animation-chichi",
        functionName = "AnimSet:ChiChi"
    },
    ['animations:default'] = {
        title = "Default",
        icon = "#animation-default",
        functionName = "AnimSet:default"
    },
    ['mechanic:hijack'] = {
        title = "Hijack",
        icon = "#police-vehicle",
        functionName = "st:hijack"
    },
    ['mechanic:repair'] = {
        title = "Repair",
        icon = "#police-vehicle",
        functionName = "st:mechrepair"
    },
    ['mechanic:clean'] = {
        title = "Clean",
        icon = "#police-vehicle",
        functionName = "st:mechclean"
    },
    ['mechanic:impound'] = {
        title = "Impound",
        icon = "#police-vehicle",
        functionName = "st:mechimpound"
    },
    ['k9:spawn'] = {
        title = "Summon",
        icon = "#k9-spawn",
        functionName = "K9:Create"
    },
    ['k9:delete'] = {
        title = "Dismiss",
        icon = "#k9-dismiss",
        functionName = "K9:Delete"
    },
    ['k9:follow'] = {
        title = "Follow",
        icon = "#k9-follow",
        functionName = "K9:Follow"
    },
    ['k9:vehicle'] = {
        title = "Get in/out",
        icon = "#k9-vehicle",
        functionName = "K9:Vehicle"
    },
    ['k9:sit'] = {
        title = "Sit",
        icon = "#k9-sit",
        functionName = "K9:Sit"
    },
    ['k9:lay'] = {
        title = "Lay",
        icon = "#k9-lay",
        functionName = "K9:Lay"
    },
    ['k9:stand'] = {
        title = "Stand",
        icon = "#k9-stand",
        functionName = "K9:Stand"
    },
    ['k9:sniff'] = {
        title = "Sniff Person",
        icon = "#k9-sniff",
        functionName = "st:k9drugsniff"
    },
--[[     ['k9:sniffvehicle'] = {
        title = "Sniff Vehicle",
        icon = "#k9-sniff-vehicle",
        functionName = "sniffVehicle"
    }, ]]
--[[     ['k9:huntfind'] = {
        title = "Hunt nearest",
        icon = "#k9-huntfind",
        functionName = "K9:Huntfind"
    }, ]]
--[[     ['judge-raid:checkowner'] = {
        title = "Check Owner",
        icon = "#judge-raid-check-owner",
        functionName = "appartment:CheckOwner"
    },
    ['judge-raid:seizeall'] = {
        title = "Seize All Content",
        icon = "#judge-raid-seize-all",
        functionName = "appartment:SeizeAll"
    },
    ['judge-raid:takecash'] = {
        title = "Take Cash",
        icon = "#judge-raid-take-cash",
        functionName = "appartment:TakeCash"
    },
    ['judge-raid:takedm'] = {
        title = "Take Marked Bills",
        icon = "#judge-raid-take-dm",
        functionName = "appartment:TakeDM"
    }, ]]
    ['cuffs:cuff'] = {
        title = "Cuff",
        icon = "#cuffs-cuff",
        functionName = "ERP:policeCuff"
    }, 


    ['police:jail'] = {
        title = "Jail Near",
        icon = "#cuffs-cuff",
        functionName = 'ERP:Jail'
    }, 
    ['police:unjail'] = {
        title = "Unjail Player",
        icon = "#cuffs-uncuff",
        functionName = "ERP:Unjail"
    }, 

    ['police:fine'] = {
        title = "Fine Nearest",
        icon = "#animation-money",
        functionName = 'ERP:Fine'
    }, 
    ['police:seize'] = {
        title = "Seize Weapons",
        icon = "#police-action-remove-weapons",
        functionName = 'ERP:SeizeWeapons'
    }, 
    ['police:seizeitems'] = {
        title = "Seize Items",
        icon = "#police-action-remove-weapons",
        functionName = 'ERP:SeizeItems'
    }, 
    ['cuffs:softcuff'] = {
        title = "Soft Cuff",
        icon = "#cuffs-cuff",
        functionName = "st:softcuff"
    },
    ['cuffs:uncuff'] = {
        title = "Uncuff",
        icon = "#cuffs-uncuff",
        functionName = "st:uncuff"
    },
--[[     ['cuffs:remmask'] = {
        title = "Remove Mask Hat",
        icon = "#cuffs-remove-mask",
        functionName = "police:remmask"
    }, ]]
    ['cuffs:checkinventory'] = {
        title = "Search Person",
        icon = "#cuffs-check-inventory",
        functionName = "ERP:SearchNearest"
    },
    ['police:escort'] = {
        title = "Drag Player",
        icon = "#general-escort",
        functionName = 'ERP:policeDrag'
    },
    ['police:putinvehicle'] = {
        title = "Put In Vehicle",
        icon = "#general-put-in-veh",
        functionName = "ERP:putinveh"
    },
    ['police:unseatnearest'] = {
        title = "Unseat Player",
        icon = "#general-unseat-nearest",
        functionName = "ERP:takeoutveh"
    },
    ['police:cuff'] = {
        title = "Cuff",
        icon = "#cuffs-cuff",
        functionName = "police:cuffFromMenu"
    },
    ['police:getid'] = {
        title = "Get ID",
        icon = "#police-vehicle-plate",
        functionName = "ERP:AskID"
    },
}

RegisterNetEvent("menu:setCuffState")
AddEventHandler("menu:setCuffState", function(pTargetId, pState)
    cuffStates[pTargetId] = pState
end)


RegisterNetEvent("isJudge")
AddEventHandler("isJudge", function()
    isJudge = true
end)

RegisterNetEvent("isJudgeOff")
AddEventHandler("isJudgeOff", function()
    isJudge = false
end)

RegisterNetEvent('pd:deathcheck')
AddEventHandler('pd:deathcheck', function()
    if not isDead then
        isDead = true
    else
        isDead = false
    end
end)

RegisterNetEvent("drivingInstructor:instructorToggle")
AddEventHandler("drivingInstructor:instructorToggle", function(mode)
    if myJob == "driving instructor" then
        isInstructorMode = mode
    end
end)

RegisterNetEvent("police:currentHandCuffedState")
AddEventHandler("police:currentHandCuffedState", function(pIsHandcuffed, pIsHandcuffedAndWalking)
    isHandcuffedAndWalking = pIsHandcuffedAndWalking
    isHandcuffed = pIsHandcuffed
end)

RegisterNetEvent("menu:hasOxygenTank")
AddEventHandler("menu:hasOxygenTank", function(pHasOxygenTank)
    hasOxygenTankOn = pHasOxygenTank
end)

RegisterNetEvent('enablegangmember')
AddEventHandler('enablegangmember', function(pGangNum)
    gangNum = pGangNum
end)

function GetPlayers()
    local players = {}

    for i = 0, 255 do
        if NetworkIsPlayerActive(i) then
            players[#players+1]= i
        end
    end

    return players
end

function GetClosestPlayer()
    local players = GetPlayers()
    local closestDistance = -1
    local closestPlayer = -1
    local closestPed = -1
    local ply = PlayerPedId()
    local plyCoords = GetEntityCoords(ply, 0)
    if not IsPedInAnyVehicle(PlayerPedId(), false) then
        for index,value in ipairs(players) do
            local target = GetPlayerPed(value)
            if(target ~= ply) then
                local targetCoords = GetEntityCoords(GetPlayerPed(value), 0)
                local distance = #(vector3(targetCoords["x"], targetCoords["y"], targetCoords["z"]) - vector3(plyCoords["x"], plyCoords["y"], plyCoords["z"]))
                if(closestDistance == -1 or closestDistance > distance) and not IsPedInAnyVehicle(target, false) then
                    closestPlayer = value
                    closestPed = target
                    closestDistance = distance
                end
            end
        end
        return closestPlayer, closestDistance, closestPed
    end
end
