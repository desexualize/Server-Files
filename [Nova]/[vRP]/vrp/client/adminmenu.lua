vRPclient = Tunnel.getInterface("vRP", "vRP")

local user_id = 0
local isPlayerAdmin = false
local Is_Staffed_On = false
local foundMatch = false
local inSpectatorAdminMode = false
local players = {}
local playersNearby = {}
local playersNearbyDistance = 250
local searchPlayerGroups = {}
local selectedGroup
local Selected_Menu
local Groups = {}
local povlist = ""
local SelectedPerm = nil
local SelectedName = nil
local Selected_Temp_ID = nil
local hoveredPlayer = nil

local f = nil
local g
local h = {}
local i = 1
local k = {}

bantarget = nil
bantargetname = nil
banduration = 0
banevidence = nil
banstable = {}
banreasons = ""

local acbannedplayers = 0
local acadminname = ''
local acbannedplayerstable = {}
local acplayerstable = {}
local actypes = {}

local admincfg = module('vrp', 'cfg/admin_menu')

local vehicle_garages = module("Nova-Cars", "garages")
local garage_types = vehicle_garages.garage_types
local Vehicle_Selected_Category = nil
local Valid_Vehicle_Models = {}

local tpLocationColour = "~b~"
local q = {
    tpLocationColour .. "Legion",
    tpLocationColour .. "Mission Row",
    tpLocationColour .. "St Thomas (Top)",
    tpLocationColour .. "St Thomas (Bottom Side)",
    tpLocationColour .. "LFB",
    tpLocationColour .. "HMP",
    tpLocationColour .. "City Hall",
    tpLocationColour .. "Rebel Diner",
    tpLocationColour .. "Heroin",
    tpLocationColour .. "Casino"
}
local r = {
    vector3(151.61740112305, -1035.05078125, 29.339416503906), -- Legion
    vector3(446.88418579102, -983.67224121094, 30.689336776733), -- Mission Row
    vector3(283.01950073242, -569.90423583984, 43.132835388184), -- St Thomas (Top)
    vector3(372.32885742188, -602.53656005859, 28.840867996216), -- St Thomas (Bottom)
    vector3(1201.9948730469,-1460.4489746094,34.774551391602), -- LFB
    vector3(1858.4948730469,2585.0393066406,45.671989440918), -- HMP
    vector3(-539.22729492188, -214.67526245117, 37.649806976318), -- City Hall
    vector3(1582.8811035156, 6450.40234375, 25.189323425293), -- Rebel
    vector3(2985.07, 3489.944, 71.38177), -- Heroin
    vector3(923.24499511719, 48.181098937988, 81.106323242188) -- Casino
}
local s = 1

menuColour = "~b~"

RMenu.Add("adminmenu", "main", RageUI.CreateMenu("", "~b~Admin Menu", 1300, 100, "banners", "adminmenu"))
RMenu.Add("SettingsMenu", "MainMenu", RageUI.CreateMenu("", menuColour .. "Settings Menu", 1300, 100, "banners", "setting"))

RMenu.Add(
    'adminmenu',
    'admin_stuff',
    RageUI.CreateSubMenu(
        RMenu:Get("adminmenu", "main"),
        "",
        menuColour .. "Admin Menu",
        1300,
        100,
        "banners",
        "adminmenu"
    )
)

RMenu.Add(
    "SettingsMenu",
    "crosshairsettings",
    RageUI.CreateSubMenu(
        RMenu:Get("SettingsMenu", "MainMenu"),
        "",
        menuColour .. "Crosshair Settings",
        1300,
        100,
        "crosshair",
        "crosshair"
    )
)

RMenu.Add(
    "adminmenu",
    "players",
    RageUI.CreateSubMenu(
        RMenu:Get("adminmenu", "admin_stuff"),
        "",
        menuColour .. "All Players Menu",
        1300,
        100,
        "banners",
        "adminmenu"
    )
)

RMenu.Add(
    "adminmenu",
    "closeplayers",
    RageUI.CreateSubMenu(
        RMenu:Get("adminmenu", "admin_stuff"),
        "",
        menuColour .. "Nearby Players Menu",
        1300,
        100,
        "banners",
        "adminmenu"
    )
)

RMenu.Add(
    "adminmenu",
    "searchoptions",
    RageUI.CreateSubMenu(
        RMenu:Get("adminmenu", "admin_stuff"),
        "",
        menuColour .. "Player Search Menu",
        1300,
        100,
        "banners",
        "adminmenu"
    )
)

--[[ Functions ]]
RMenu.Add(
    "adminmenu",
    "adminfunctions",
    RageUI.CreateSubMenu(
        RMenu:Get("adminmenu", "admin_stuff"),
        "",
        menuColour .. "Admin Functions Menu",
        1300,
        100,
        "banners",
        "adminmenu"
    )
)

RMenu.Add(
    "adminmenu",
    "devfunctions",
    RageUI.CreateSubMenu(
        RMenu:Get("adminmenu", "main"),
        "",
        menuColour .. "Developer Functions Menu",
        1300,
        100,
        "banners",
        "adminmenu"
    )
)

RMenu.Add(
    "adminmenu",
    "vehiclelist",
    RageUI.CreateSubMenu(
        RMenu:Get("adminmenu", "devfunctions"),
        "",
        menuColour .. "Vehicle List Menu",
        1300,
        100,
        "banners",
        "adminmenu"
    )
)

RMenu.Add(
    "adminmenu",
    "vehiclelistmain",
    RageUI.CreateSubMenu(
        RMenu:Get("adminmenu", "vehiclelist"),
        "",
        menuColour .. "Vehicle Spawn Menu",
        1300,
        100,
        "banners",
        "adminmenu"
    )
)

--[[ End of Functions ]]
RMenu.Add(
    "adminmenu",
    "submenu",
    RageUI.CreateSubMenu(
        RMenu:Get("adminmenu", "players"),
        "",
        menuColour .. "Admin Player Interaction Menu",
        1300,
        100,
        "banners",
        "adminmenu"
    )
)

RMenu.Add(
    "adminmenu",
    "searchname",
    RageUI.CreateSubMenu(
        RMenu:Get("adminmenu", "searchoptions"),
        "",
        menuColour .. "Admin Player Search Menu",
        1300,
        100,
        "banners",
        "adminmenu"
    )
)

RMenu.Add(
    "adminmenu",
    "searchtempid",
    RageUI.CreateSubMenu(
        RMenu:Get("adminmenu", "searchoptions"),
        "",
        menuColour .. "Admin Player Search Menu",
        1300,
        100,
        "banners",
        "adminmenu"
    )
)

RMenu.Add(
    "adminmenu",
    "searchpermid",
    RageUI.CreateSubMenu(
        RMenu:Get("adminmenu", "searchoptions"),
        "",
        menuColour .. "Admin Player Search Menu",
        1300,
        100,
        "banners",
        "adminmenu"
    )
)

RMenu.Add(
    "adminmenu",
    "searchhistory",
    RageUI.CreateSubMenu(
        RMenu:Get("adminmenu", "searchoptions"),
        "",
        menuColour .. "Admin Player Search Menu",
        1300,
        100,
        "banners",
        "adminmenu"
    )
)

RMenu.Add(
    "adminmenu",
    "bansub",
    RageUI.CreateSubMenu(
        RMenu:Get("adminmenu", "players"),
        "",
        menuColour .. "Select Ban Reasons",
        1300,
        100,
        "banners",
        "adminmenu"
    )
)

RMenu.Add(
    "adminmenu",
    "notesub",
    RageUI.CreateSubMenu(
        RMenu:Get("adminmenu", "players"),
        "",
        menuColour .. "Player Notes",
        1300,
        100,
        "banners",
        "adminmenu"
    )
)

RMenu.Add(
    "adminmenu",
    "confirmban",
    RageUI.CreateSubMenu(
        RMenu:Get("adminmenu", "players"),
        "",
        menuColour .. "Confirm Ban",
        1300,
        100,
        "banners",
        "adminmenu"
    )
)

--[[groups]]
RMenu.Add(
    "adminmenu",
    "groups",
    RageUI.CreateSubMenu(
        RMenu:Get("adminmenu", "submenu"),
        "",
        menuColour .. "Player Groups Menu",
        1300,
        100,
        "banners",
        "adminmenu"
    )
)

RMenu.Add(
    "adminmenu",
    "staffGroups",
    RageUI.CreateSubMenu(
        RMenu:Get("adminmenu", "groups"),
        "",
        menuColour .. "Staff Groups Menu",
        1300,
        100,
        "banners",
        "adminmenu"
    )
)

RMenu.Add(
    'adminmenu',
    'FactionGroups',
    RageUI.CreateSubMenu(
        RMenu:Get("adminmenu", "groups"),
        "",
        menuColour .. "Faction Groups Menu",
        1300,
        100,
        "banners",
        "adminmenu"
    )
)

RMenu.Add(
    "adminmenu",
    "mpdGroups",
    RageUI.CreateSubMenu(
        RMenu:Get("adminmenu", "FactionGroups"),
        "",
        menuColour .. "MPD Groups Menu",
        1300,
        100,
        "banners",
        "adminmenu"
    )
)

RMenu.Add(
    "adminmenu",
    "nhsGroups",
    RageUI.CreateSubMenu(
        RMenu:Get("adminmenu", "FactionGroups"),
        "",
        menuColour .. "NHS Groups Menu",
        1300,
        100,
        "banners",
        "adminmenu"
    )
)

RMenu.Add(
    "adminmenu",
    "lfbGroups",
    RageUI.CreateSubMenu(
        RMenu:Get("adminmenu", "FactionGroups"),
        "",
        menuColour .. "LFB Groups Menu",
        1300,
        100,
        "banners",
        "adminmenu"
    
    )
)

RMenu.Add(
    "adminmenu",
    "hmpGroups",
    RageUI.CreateSubMenu(
        RMenu:Get("adminmenu", "FactionGroups"),
        "",
        menuColour .. "HMP Groups Menu",
        1300,
        100,
        "banners",
        "adminmenu"
    )
)

RMenu.Add(
    "adminmenu",
    "UserGroups",
    RageUI.CreateSubMenu(
        RMenu:Get("adminmenu", "groups"),
        "",
        menuColour .. "User Groups Menu",
        1300,
        100,
        "banners",
        "adminmenu"
    )
)

RMenu.Add(
    "adminmenu",
    "PovGroups",
    RageUI.CreateSubMenu(
        RMenu:Get("adminmenu", "groups"),
        "",
        menuColour .. "Pov Groups Menu",
        1300,
        100,
        "banners",
        "adminmenu"
    )
)

RMenu.Add(
    "adminmenu",
    "whitelistgroups",
    RageUI.CreateSubMenu(
        RMenu:Get("adminmenu", "groups"),
        "",
        menuColour .. "Whitelist Groups Menu",
        1300,
        100,
        "banners",
        "adminmenu"
    )
)

RMenu.Add(
    "adminmenu",
    "licenseGroups",
    RageUI.CreateSubMenu(
        RMenu:Get("adminmenu", "groups"),
        "",
        menuColour .. "License Groups Menu",
        1300,
        100,
        "banners",
        "adminmenu"
    )
)

RMenu.Add(
    "adminmenu",
    "addgroup",
    RageUI.CreateSubMenu(
        RMenu:Get("adminmenu", "groups"),
        "",
        menuColour .. "Add Group Menu",
        1300,
        100,
        "banners",
        "adminmenu"
    )
)

RMenu.Add(
    "adminmenu",
    "removegroup",
    RageUI.CreateSubMenu(
        RMenu:Get("adminmenu", "groups"),
        "",
        menuColour .. "Remove Group Menu",
        1300,
        100,
        "banners",
        "adminmenu"
    )
)

--[[ AntiCheat ]]
menuColour = '~b~'
RMenu.Add('anticheat', 'main', RageUI.CreateMenu("", menuColour..'AntiCheat Menu',1300,100,"adminmenu","adminmenu"))
RMenu.Add("anticheat", "actypes", RageUI.CreateSubMenu(RMenu:Get("anticheat", "main"), "", menuColour .. 'Anti Cheat Types', 1300, 100, "adminmenu", "adminmenu"))
RMenu.Add("anticheat", "acbannedplayers", RageUI.CreateSubMenu(RMenu:Get("anticheat", "main"), "", menuColour .. 'AC Banned Players', 1300, 100, "adminmenu", "adminmenu"))
RMenu.Add("anticheat", "acbanmenu", RageUI.CreateSubMenu(RMenu:Get("anticheat", "main"), "", menuColour .. 'AC Banned Player Submenu', 1300, 100, "adminmenu", "adminmenu"))
RMenu.Add("anticheat", "acmanualbanlist", RageUI.CreateSubMenu(RMenu:Get("anticheat", "main"), "", menuColour .. 'AC Manual Ban', 1300, 100, "adminmenu", "adminmenu"))
RMenu.Add("anticheat", "acmanualban", RageUI.CreateSubMenu(RMenu:Get("anticheat", "main"), "", menuColour .. 'Choose an AC Type to ban for', 1300, 100, "adminmenu", "adminmenu"))
RMenu.Add("anticheat", "confirmacban", RageUI.CreateSubMenu(RMenu:Get("anticheat", "main"), "", menuColour .. 'Confirm AC Ban', 1300, 100, "adminmenu", "adminmenu"))

RMenu:Get("adminmenu", "main")

-- Variables and functions
local getStaffGroupsGroupIds = {
    "Founder",
    "Co-Founder",
    "Developer",
    "Car Developer",
    "Staff Manager",
    "Community Manager",
    "Head Admin",
    "Senior Admin",
    "Admin",
    "Senior Moderator",
    "Moderator",
    "Support Team",
    "Trial Staff",
}

local getmpdGroupsGroupIds = {
    "Commissioner",
    "Deputy Commissioner",
    "Assistant Commissioner",
    "Deputy Assistant Commissioner",
    "Commander",
    "Chief Superintendent",
    "Superintendent",
    'Officer of the week',
    "Chief Inspector",
    "Inspector",
    "Sergeant",
    "Special Constable",
    "Senior Constable",
    "Police Constable",
    "PCSO",
    "SCO-19",
    'MPD Needs Training',
    'MPD Suspended',
}

local getnhsGroupsGroupIds = {
    "Chief Medical Director",
    "Deputy Medical Director",
    "Assistant Medical Director",
    "Captain",
    "Specialist",
    'Medic of the week',
    "Senior Doctor",
    "Doctor",
    "Junior Doctor",
    "Critical Care Paramedic",
    "Paramedic",
    "Trainee Paramedic",
    'NHS Needs Training',
    'NHS Suspended',
}

local getlfbGroupsGroupIds = {
    'Chief Fire Command',
    'Divisional Command',
    'Sector Command',
    'Honourable Firefighter',
    'Firefighter of the week',
    'Leading Firefighter',
    'Specialist Firefighter',
    'Advanced Firefighter',
    'Senior Firefighter',
    'Firefighter',
    'Junior Firefighter',
    'Provisional Firefighter',
    'LFB Needs Training',
    'LFB Suspended',
}

local gethmpGroupsGroupIds = {
    'Governor',
    'Deputy Governor',
    'Assistant Governor',
    'Custodial Supervisor',
    'Custodial Officer',
    'Honourable Guard',
    'Guard of the week',
    'Supervising Officer',
    'Principal Officer',
    'Specialist Officer',
    'Senior Officer',
    'Prison Officer',
    'Trainee Prison Officer',
    'HMP Needs Training',
    'HMP Suspended',
}

local getlicenseGroupsGroupIds = {
    "Scrap Job",
    "Iron",
    "Weed",
    "Gang",
    "Diamond",
    "Heroin",
    "LSD",
    "Rebel",
}

local getUserGroupsGroupIds = {
    "Platinum",
    "Gold",
    "Silver",
    "Bronze",
}

local getUserPovGroups = {
    "Pov List",
}

local getWhitelistedGroupsGroupIds = {
    "Drone Trained",
}

local function Get_Permission_From_Name(perm_name)
    -- Staff Perms
    if perm_name == 'Founder' then
        return 'founder'
    elseif perm_name == 'Co-Founder' then
        return 'cofounder'
    elseif perm_name == 'Developer' then
        return 'developer'
    elseif perm_name == 'Car Developer' then
        return 'cardeveloper'
    elseif perm_name == 'Staff Manager' then
        return 'staffmanager'
    elseif perm_name == 'Community Manager' then
        return 'commanager'
    elseif perm_name == 'Head Admin' then
        return 'headadmin'
    elseif perm_name == 'Senior Admin' then
        return 'senioradmin'
    elseif perm_name == 'Administrator' then
        return 'administrator'
    elseif perm_name == 'Senior Moderator' then
        return 'srmoderator'
    elseif perm_name == 'Moderator' then
        return 'moderator'
    elseif perm_name == 'Support Team' then
        return 'supportteam'
    elseif perm_name == 'Trial Staff' then
        return 'trialstaff'

    -- Pov Perms
    elseif perm_name == 'Pov List' then
        return 'pov'

    -- Donator Perms
    elseif perm_name == 'Platinum' then
        return 'platinum'
    elseif perm_name == 'Gold' then
        return 'gold'
    elseif perm_name == 'Silver' then
        return 'silver'
    elseif perm_name == 'Bronze' then
        return 'bronze'
    else
        return perm_name
    end
end

local df = {
    {"10%", 0.1},
    {"20%", 0.2},
    {"30%", 0.3},
    {"40%", 0.4},
    {"50%", 0.5},
    {"60%", 0.6},
    {"70%", 0.7},
    {"80%", 0.8},
    {"90%", 0.9},
    {"100%", 1.0},
    {"150%", 1.5},
    {"200%", 2.0},
    {"250%", 2.5},
    {"300%", 3.0},
    {"350%", 3.5},
    {"400%", 4.0},
    {"450%", 4.5},
    {"500%", 5.0},
    {"600%", 6.0},
    {"700%", 7.0},
    {"800%", 8.0},
    {"900%", 9.0},
    {"1000%", 10.0},
}
local d = {
    "10%",
    "20%",
    "30%",
    "40%",
    "50%",
    "60%",
    "70%",
    "80%",
    "90%",
    "100%",
    "150%",
    "200%",
    "250%",
    "300%",
    "350%",
    "400%",
    "450%",
    "500%",
    "600%",
    "700%",
    "800%",
    "900%",
    "1000%",
}
local dts = 10

warningbankick = {
    {
        name = "1.0 Trolling",
        desc = "Duration: 1hr",
        selected = false,
        duration = 1
    },
    {
        name = "1.1 Offensive Language/Toxicity",
        desc = "Duration: 2hr",
        selected = false,
        duration = 2
    },
    {
        name = "1.2 Exploiting ",
        desc = "Duration: 6hr",
        selected = false,
        duration = 6
    },
    {
        name = "1.3 Out of game transactions (OOGT)",
        desc = "Duration: Permanent",
        selected = false,
        duration = 9000
    },
    {
        name = "1.4 Scamming",
        desc = "Duration: Permanent",
        selected = false,
        duration = 9000
    },
    {
        name = "1.5 Advertising",
        desc = "Duration: Permanent",
        selected = false,
        duration = 9000
    },
    {
        name = "1.6 Malicious Attacks",
        desc = "Duration: Permanent",
        selected = false,
        duration = 9000
    },
    {
        name = "1.7 PII (Personally Identifiable Information)",
        desc = "Duration: 168hr",
        selected = false,
        duration = 168
    },
    {
        name = "2.1 Chargeback",
        desc = "Duration: Permanent",
        selected = false,
        duration = 9000
    },
    {
        name = "2.2 Staff Discretion",
        desc = "Duration: Permanent",
        selected = false,
        duration = 9000
    },
    {
        name = "2.3 Cheating",
        desc = "Duration: Permanent",
        selected = false,
        duration = 9000
    },
    {
        name = "2.4 Ban Evading",
        desc = "Duration: Permanent",
        selected = false,
        duration = 9000
    },
    {
        name = "2.5 Association with External Modifications",
        desc = "1st Offense: Permanent\n2nd Offense: N/A\n3rd Offense: N/A",
        selected = false,
        duration = 9000
    },
    {
        name = "3.1 Failure to provide Pov ",
        desc = "Duration: 24hr",
        selected = false,
        duration = 24
    },
    {
        name = "3.2 Withholding Information From Staff",
        desc = "Duration: 24hr",
        selected = false,
        duration = 24
    },
    {
        name = "3.3 Blackmailing",
        desc = "Duration: Permanent",
        selected = false,
        duration = 9000
    },
    {
        name = "3.4 Community Ban",
        desc = "Duration: Permanent",
        selected = false,
        duration = 9000
    }
}

local InSpectatorMode = false
local TargetSpectate = nil
local LastPosition = nil
local polarAngleDeg = 0
local azimuthAngleDeg = 90
local radius = -3.5
local cam = nil
local PlayerDate = {}
local ShowInfos = false
local group

local function polar3DToWorld3D(entityPosition, radius, polarAngleDeg, azimuthAngleDeg)
    local polarAngleRad = polarAngleDeg * math.pi / 180.0
    local azimuthAngleRad = azimuthAngleDeg * math.pi / 180.0
    local pos = {
        x = entityPosition.x + radius * (math.sin(azimuthAngleRad) * math.cos(polarAngleRad)),
        y = entityPosition.y - radius * (math.sin(azimuthAngleRad) * math.sin(polarAngleRad)),
        z = entityPosition.z - radius * math.cos(azimuthAngleRad)
    }
    return pos
end

function StopSpectatePlayer()
    inRedZone = false
    InSpectatorMode = false
    TargetSpectate = nil
    local playerPed = PlayerPedId()
    SetCamActive(cam, false)
    DestroyCam(cam, true)
    RenderScriptCams(false, false, 0, true, true)
    SetEntityVisible(playerPed, true)
    SetEntityCollision(playerPed, true, true)
    FreezeEntityPosition(playePed, false)
    if savedCoords ~= vec3(0, 0, 1) then
        SetEntityCoords(PlayerPedId(), savedCoords)
    else
        SetEntityCoords(PlayerPedId(), 3537.363, 3721.82, 36.467)
    end
end

function Draw2DText(x, y, text, scale)
    SetTextFont(4)
    SetTextProportional(7)
    SetTextScale(scale, scale)
    SetTextColour(255, 255, 255, 255)
    SetTextDropShadow(0, 0, 0, 0, 255)
    SetTextDropShadow()
    SetTextEdge(4, 0, 0, 0, 255)
    BeginTextCommandDisplayText("STRING")
    AddTextComponentSubstringPlayerName(text)
    EndTextCommandDisplayText(x, y)
end

function DrawHelpMsg(msg)
    SetTextComponentFormat("STRING")
    AddTextComponentSubstringPlayerName(msg)
    DisplayHelpTextFromStringLabel(0, 0, 1, -1)
end

function KeyboardInput(TextEntry, ExampleText, MaxStringLenght)
    AddTextEntry("FMMC_KEY_TIP1", TextEntry)
    DisplayOnscreenKeyboard(1, "FMMC_KEY_TIP1", "", ExampleText, "", "", "", MaxStringLenght)
    blockinput = true
    while UpdateOnscreenKeyboard() ~= 1 and UpdateOnscreenKeyboard() ~= 2 do
        Citizen.Wait(0)
    end
    if UpdateOnscreenKeyboard() ~= 2 then
        local result = GetOnscreenKeyboardResult()
        Citizen.Wait(500)
        blockinput = false
        return result
    else
        Citizen.Wait(500)
        blockinput = false
        return nil
    end
end

function notify(string)
    BeginTextCommandThefeedPost("STRING")
    AddTextComponentSubstringPlayerName(string)
    EndTextCommandThefeedPostTicker(true, false)
end

function SpawnVehicle(VehicleName)
    local hash = GetHashKey(VehicleName)
    RequestModel(hash)
    local i = 0
    while not HasModelLoaded(hash) and i < 50 do
        Citizen.Wait(10)
        i = i + 1
    end
    if i >= 50 then
        return
    end
    local Ped = PlayerPedId()
    local Vehicle = CreateVehicle(hash, GetEntityCoords(Ped), GetEntityHeading(Ped), true, 0)
    i = 0
    while not DoesEntityExist(Vehicle) and i < 50 do
        Citizen.Wait(10)
        i = i + 1
    end
    if i >= 50 then
        return
    end
    SetPedIntoVehicle(Ped, Vehicle, -1)
    SetModelAsNoLongerNeeded(hash)
end

function bank_drawTxt(x, y, width, height, scale, text, r, g, b, a, outline)
    SetTextFont(0)
    SetTextProportional(0)
    SetTextScale(scale, scale)
    SetTextColour(r, g, b, a)
    SetTextDropShadow(0, 0, 0, 0, 255)
    SetTextEdge(1, 0, 0, 0, 255)
    SetTextDropShadow()
    if (outline) then
        SetTextOutline()
    end
    BeginTextCommandDisplayText("STRING")
    AddTextComponentSubstringPlayerName(text)
    EndTextCommandDisplayText(x - width / 2, y - height / 2 + 0.005)
end

function tvRP.getStaffLevel()
    return GlobalAdminLevel
end

function tvRP.setStaffedOn(bool_value)
    Is_Staffed_On = bool_value
end

function tvRP.isStaffedOn()
    return Is_Staffed_On
end

function tvRP.getModelGender()
    local B = PlayerPedId()
    if GetEntityModel(B) == "mp_f_freemode_01" then
        return "female"
    else
        return "male"
    end
end

function tvRP.LoadModel(r)
    local s
    if type(r) ~= "string" then
        s = r
    else
        s = GetHashKey(r)
    end
    if IsModelInCdimage(s) then
        if not HasModelLoaded(s) then
            RequestModel(s)
            while not HasModelLoaded(s) do
                Wait(0)
            end
        end
        return s
    else
        return nil
    end
end

function tvRP.drawNativeText(V)
    BeginTextCommandPrint("STRING")
    AddTextComponentSubstringPlayerName(V)
    EndTextCommandPrint(1, true)
end

function tvRP.isAdmin()
    return isPlayerAdmin
end

function tvRP.setAdmin(bool_value)
    isPlayerAdmin = bool_value
end

-- Commands and Events
RegisterNetEvent("Jud:ReturnNearbyPlayers")
AddEventHandler("Jud:ReturnNearbyPlayers", function(table)
    playersNearby = table
end)

RegisterNetEvent("Nova:OpenSettingsMenu")
AddEventHandler("Nova:OpenSettingsMenu", function(admin)
    if not admin then
        RageUI.Visible(RMenu:Get("adminmenu", "main"), false)
        RageUI.Visible(RMenu:Get("SettingsMenu", "MainMenu"), true)
    end
end)

RegisterKeyMapping("opensettingsmenu", "Opens the Settings menu", "keyboard", "F2")
RegisterCommand("opensettingsmenu", function()
    TriggerServerEvent("Nova:OpenSettings")
end)

RegisterNetEvent("Nova:ReturnPov")
AddEventHandler("Nova:ReturnPov", function(pov)
    if pov then
        povlist = "~g~true"
    else
        povlist = "~r~false"
    end
end)

RegisterNetEvent("Nova:sendNotes")
AddEventHandler('Nova:sendNotes', function(a7)
    a7 = json.decode(a7)
    if a7 == nil then
        f = {}
    else
        f = a7
    end
end)

--[[
RegisterNetEvent("Nova:sendNotes")
AddEventHandler("Nova:sendNotes", function(text)
    notes = text
end)
]]

RegisterNetEvent("Nova:updateNotes") 
AddEventHandler('Nova:updateNotes', function(admin, player)
    TriggerServerEvent("Nova:getNotes", admin, player)
end)

RegisterCommand("return", function()
    if inTP2P then
        if savedCoords1 == nil then
            return notify("~r~Couldn't get Last Position")
        end
        
        DoScreenFadeOut(1000)

        local client_ped = PlayerPedId()
        NetworkFadeOutEntity(client_ped, true, false)
        Wait(1000)

        SetEntityCoords(client_ped, savedCoords1)
        NetworkFadeInEntity(client_ped, 0)
        DoScreenFadeIn(1000)

        notify("~g~Returned to position")
        inTP2P = false
        TriggerEvent("Nova:vehicleMenu", false, false)
        inTP2P2 = false
    end
end)

RegisterCommand("cleanup", function()
    TriggerServerEvent("Nova:CleanAll")
end)

RegisterCommand("blips", function()
    TriggerServerEvent("Nova:checkBlips")
end)

RegisterNetEvent("Nova:SlapPlayer")
AddEventHandler("Nova:SlapPlayer", function()
    SetEntityHealth(PlayerPedId(), 0)
end)

FrozenPlayer = false
RegisterNetEvent("Infinite:Freeze")
AddEventHandler("Infinite:Freeze",function(isFrozen)
    FrozenPlayer = isFrozen
    TriggerEvent("godmodebypass", isFrozen)
end)

RegisterNetEvent("Nova:Client:Teleport")
AddEventHandler("Nova:Client:Teleport", function(coords)
    DoScreenFadeOut(1000)
    NetworkFadeOutEntity(PlayerPedId(), true, false)
    Wait(1000)
    SetEntityCoords(PlayerPedId(), coords)
    NetworkFadeInEntity(PlayerPedId(), 0)
    DoScreenFadeIn(1000)
end)

RegisterNetEvent("Nova:Teleport2Me2")
AddEventHandler("Nova:Teleport2Me2", function(target2)
    local coords = GetEntityCoords(GetPlayerPed(GetPlayerFromServerId(target2)))
    SetEntityCoords(PlayerPedId(), coords)
end)

RegisterNetEvent("Nova:SendPlayerInfo")
AddEventHandler("Nova:SendPlayerInfo", function(players_table, btns)
    players = players_table
    buttons = btns
    RageUI.Visible(RMenu:Get("adminmenu", "main"), not RageUI.Visible(RMenu:Get("adminmenu", "main")))
end)

RegisterNetEvent("Nova:GotGroups")
AddEventHandler("Nova:GotGroups", function(gotGroups)
    searchPlayerGroups = gotGroups
end)

RegisterNetEvent("Nova:NotifyPlayer")
AddEventHandler("Nova:NotifyPlayer", function(string)
    notify("~g~" .. string)
end)

RegisterCommand('openadminmenu',function()
    TriggerServerEvent("Nova:GetPlayerData")
	TriggerServerEvent("Nova:Server:GetAntiCheatData")
end)

RegisterNetEvent("Nova:Client:GetAntiCheatData")
AddEventHandler("Nova:Client:GetAntiCheatData", function(admin_name, totalbannedplayers, bannedplayers, playerstable, types)
    acbannedplayerstable = bannedplayers
    acbannedplayers = totalbannedplayers
    acadminname = admin_name
	actypes = types
	acplayerstable = playerstable
end)

RegisterKeyMapping("openadminmenu", "Opens the Admin menu", "keyboard", "F2")
RegisterCommand("openadminmenu", function()
    TriggerServerEvent("Nova:GetPlayerData")
    TriggerServerEvent("Nova:GetNearbyPlayerData")
end)

RegisterNetEvent("Nova:TPCoords")
AddEventHandler("Nova:TPCoords", function(coords)
    SetEntityCoordsNoOffset(PlayerPedId(), coords.x, coords.y, coords.z, false, false, false)
end)

RegisterNetEvent("Nova:EntityWipe")
AddEventHandler("Nova:EntityWipe", function(id)
    Citizen.CreateThread(function()
        for k, v in pairs(GetAllEnumerators()) do
            local enum = v
            for entity in enum() do
                local owner = NetworkGetEntityOwner(entity)
                local playerID = GetPlayerServerId(owner)
                NetworkDelete(entity)
            end
        end
    end)
end)

local Spectating = false
local LastCoords = nil
RegisterNetEvent("Nova:Spectate")
AddEventHandler("Nova:Spectate", function(plr, tpcoords)
    local playerPed = PlayerPedId()
    local targetPed = GetPlayerPed(GetPlayerFromServerId(plr))
    if not Spectating then
        LastCoords = GetEntityCoords(playerPed)
        if tpcoords then
            SetEntityCoords(playerPed, tpcoords - 10.0)
        end
        Wait(300)
        targetPed = GetPlayerPed(GetPlayerFromServerId(plr))
        if targetPed == playerPed then
            tvRP.notify("~r~I mean you cannot spectate yourself")
            return
        end
        NetworkSetInSpectatorMode(true, targetPed)
        SetEntityCollision(playerPed, false, false)
        SetEntityVisible(playerPed, false, 0)
        SetEveryoneIgnorePlayer(playerPed, true)
        Spectating = true
        tvRP.notify("~g~Spectating Player")
        while Spectating do
            local targetArmour = GetPedArmour(targetPed)
            local targetHealth = GetEntityHealth(targetPed)
            local targetplayerName = GetPlayerName(GetPlayerFromServerId(plr))
            local targetSpeedMph = GetEntitySpeed(targetPed) * 2.236936
            local targetvehiclehealth = GetEntityHealth(GetVehiclePedIsIn(targetPed, false))
            local targetWeapon = GetSelectedPedWeapon(targetPed)
            local targetWeaponAmmoCount = GetAmmoInPedWeapon(targetPed, targetWeapon)
            DrawAdvancedText(0.320, 0.850, 0.025, 0.0048, 0.5, "Health: " .. targetHealth, 51, 153, 255, 200, 6, 0)
            DrawAdvancedText(0.320, 0.828, 0.025, 0.0048, 0.5, "Armour: " .. targetArmour, 51, 153, 255, 200, 6, 0)
            DrawAdvancedText(
                0.320,
                0.806,
                0.025,
                0.0048,
                0.5,
                "Vehicle Health: " .. targetvehiclehealth,
                51,
                153,
                255,
                200,
                6,
                0
            )
            bank_drawTxt(
                0.90,
                1.4,
                1.0,
                1.0,
                0.4,
                "You are currently spectating " .. targetplayerName,
                51,
                153,
                255,
                200
            )
            if IsPedSittingInAnyVehicle(targetPed) then
                DrawAdvancedText(
                    0.320,
                    0.784,
                    0.025,
                    0.0048,
                    0.5,
                    "Speed: " .. math.floor(targetSpeedMph),
                    51,
                    153,
                    255,
                    200,
                    6,
                    0
                )
            end
            Wait(0)
        end
    else
        NetworkSetInSpectatorMode(false, targetPed)
        SetEntityVisible(playerPed, true, 0)
        SetEveryoneIgnorePlayer(playerPed, false)
        SetEntityCollision(playerPed, true, true)
        Spectating = false
        SetEntityCoords(playerPed, LastCoords)
        tvRP.notify("~r~Stopped Spectating Player")
    end
end)

OMioDioMode = false
adminTicketSavedCustomization = nil
savedAdminTicketGuns = nil

RegisterCommand("staffon", function()
    if tvRP.isAdmin() then
        if tvRP.isStaffedOn() then
            tvRP.notify('~r~You are already staffed on')
        else
            if tvRP.isInTicket() then
                tvRP.notify("You are in a ticket, use /return")
            else
                TriggerEvent("Nova:OMioDioMode", true)
                tvRP.notify("~g~Staff Powerz Activated!")
            end
        end
    else
        tvRP.notify('~r~You are not an admin')
    end
end)

RegisterCommand("staffoff", function()
    if tvRP.isAdmin() then
        if tvRP.isStaffedOn() then
            if tvRP.isInTicket() then
                tvRP.notify("You are in a ticket, use /return")
            else
                TriggerEvent("Nova:OMioDioMode", false)
                tvRP.notify("~g~Staff Powerz deactivated!")
            end
        else
            tvRP.notify('~r~You are not staffed on')
        end
    else
        tvRP.notify('~r~You are not an admin')
    end
end)

RegisterNetEvent("Nova:OMioDioMode")
AddEventHandler("Nova:OMioDioMode", function(DioMode)
    OMioDioMode = DioMode
    tvRP.setStaffedOn(DioMode)
    local client_ped = PlayerPedId()

    if OMioDioMode then
        adminTicketSavedCustomization = tvRP.getCustomization()
        savedAdminTicketGuns = tvRP.getWeapons()
        savedArmour = tvRP.getArmour()
        if GetEntityModel(PlayerPedId()) ~= GetHashKey("mp_m_freemode_01") then
            local mhash = "mp_m_freemode_01"
            RequestModel(mhash)
            Wait(0)
            SetPlayerModel(PlayerId(), mhash)
            SetModelAsNoLongerNeeded(mhash)
        end

        SetPedComponentVariation(client_ped, 4, 168, 0, 0) -- [Legs]
        SetPedComponentVariation(client_ped, 3, 1, 0, 0) -- [Arms]
        SetPedComponentVariation(client_ped, 6, 119, 0, 0) -- [Shoes]
        SetPedComponentVariation(client_ped, 8, 15, 0, 0) -- [Undershirt]
        SetPedComponentVariation(client_ped, 11, 424, 0, 0) -- [Jacket]
        TriggerServerEvent("Nova:OMioDioMode", true)
    else
        SetEntityInvincible(client_ped, false)
        SetPlayerInvincible(PlayerId(), false)
        SetPedCanRagdoll(client_ped, true)
        ClearPedBloodDamage(client_ped)
        ResetPedVisibleDamage(client_ped)
        ClearPedLastWeaponDamage(client_ped)
        SetEntityProofs(client_ped, false, false, false, false, false, false, false, false)
        SetEntityCanBeDamaged(client_ped, true)
        SetEntityHealth(client_ped, 200)

        tvRP.setCustomization(adminTicketSavedCustomization)
        tvRP.giveWeapons(savedAdminTicketGuns, false)
        TriggerServerEvent("Nova:OMioDioMode", false)
    end
end)

-- Threads and Loops
Citizen.CreateThread(function()
    while true do
        Citizen.InvokeNative(0xA76359FC80B2438E, df[dts][2])
        Citizen.Wait(0)
    end
end)

Citizen.CreateThread(function()
    while true do
        if hoveredPlayer ~= nil then
            local hoveredPedCoords = GetEntityCoords(GetPlayerPed(GetPlayerFromServerId(hoveredPlayer)))
            DrawMarker(
                2, -- Marker Type
                hoveredPedCoords.x, hoveredPedCoords.y, hoveredPedCoords.z + 1.1, -- Marker Coords (x, y, z)
                0.0, 0.0, 0.0, -- Marker Direction (x, y, z)
                0.0, -180.0, 0.0, -- Marker Rotation (x, y, z)
                0.4, 0.4, 0.4, -- Marker Scale (x, y, z)
                255, 255, 0, 125, -- RGBA
                false, -- Bob Up and Down
                true, -- Face Camera
                2, -- P19 Number
                false -- Rotate
            )
        end
        Citizen.Wait(0)
    end
end)

Citizen.CreateThread(function()
    while true do
        if InSpectatorMode then
            DrawHelpMsg("Press ~INPUT_CONTEXT~ to Stop Spectating")
            if IsControlJustPressed(1, 51) then
                StopSpectatePlayer()
            end
        end
        Citizen.Wait(0)
    end
end)

Citizen.CreateThread(function()
    while true do
        if FrozenPlayer then
            local client_ped = PlayerPedId()
            FreezeEntityPosition(client_ped, true)
            DisableControlAction(0, 24, true) -- disable attack
            DisableControlAction(0, 25, true) -- disable aim
            DisableControlAction(0, 47, true) -- disable weapon
            DisableControlAction(0, 58, true) -- disable weapon
            DisableControlAction(0, 263, true) -- disable melee
            DisableControlAction(0, 264, true) -- disable melee
            DisableControlAction(0, 257, true) -- disable melee
            DisableControlAction(0, 140, true) -- disable melee
            DisableControlAction(0, 141, true) -- disable melee
            DisableControlAction(0, 142, true) -- disable melee
            DisableControlAction(0, 143, true) -- disable melee
            SetPedCanRagdoll(client_ped, false)
            ClearPedBloodDamage(client_ped)
            ResetPedVisibleDamage(client_ped)
            ClearPedLastWeaponDamage(client_ped)
            SetEntityProofs(client_ped, true, true, true, true, true, true, true, true)
            SetEntityCanBeDamaged(client_ped, false)
        elseif not FrozenPlayer or not OMioDioMode or not noclip then
            local client_ped = PlayerPedId()
            SetEntityInvincible(client_ped, false)
            SetPlayerInvincible(client_ped, false)
            FreezeEntityPosition(client_ped, false)
            SetPedCanRagdoll(client_ped, true)
            ClearPedBloodDamage(client_ped)
            ResetPedVisibleDamage(client_ped)
            ClearPedLastWeaponDamage(client_ped)
            SetEntityProofs(client_ped, false, false, false, false, false, false, false, false)
        end
        Citizen.Wait(0)
    end
end)

Citizen.CreateThread(function()
    while true do
        if OMioDioMode and not tvRP.isInTicket() then
            local client_ped = PlayerPedId()
            SetEntityInvincible(client_ped, true)
            SetPlayerInvincible(PlayerId(), true)
            SetPedCanRagdoll(client_ped, false)
            ClearPedBloodDamage(client_ped)
            ResetPedVisibleDamage(client_ped)
            ClearPedLastWeaponDamage(client_ped)
            SetEntityProofs(client_ped, true, true, true, true, true, true, true, true)
            SetEntityCanBeDamaged(client_ped, false)
            SetEntityHealth(client_ped, 200)
            tvRP.drawNativeText("~r~Reminder: You are /staffon'd", 255, 0, 0, 255, true)
        end
        Citizen.Wait(0)
    end
end)

RageUI.CreateWhile(1.0, true, function()
    if RageUI.Visible(RMenu:Get("adminmenu", "main")) then
        RageUI.DrawContent({header = true, glare = false, instructionalButton = false}, function()
            hoveredPlayer = nil
            isPlayerAdmin = true
            if admincfg.buttonsEnabled["adminMenu"][1] and buttons["adminMenu"] then
                RageUI.Button("Admin Stuff", nil, {RightLabel = "→→→"}, true, function(Hovered, Active, Selected)
                end, RMenu:Get("adminmenu", "admin_stuff"))

                if admincfg.buttonsEnabled["developerMenu"][1] and buttons["developerMenu"] then
                    RageUI.Button("~b~Developer Functions", nil, {RightLabel = "→→→"}, true, function(Hovered, Active, Selected)
                    end, RMenu:Get("adminmenu", "devfunctions"))
                end
            end

            RageUI.Button("Settings", nil, {RightLabel = "→→→"}, true, function(Hovered, Active, Selected)
            end, RMenu:Get("SettingsMenu", "MainMenu"))
        end)

    elseif RageUI.Visible(RMenu:Get("adminmenu", "admin_stuff")) then
        RageUI.DrawContent({header = true, glare = false, instructionalButton = false}, function()
            RageUI.Button("All Players", nil, {RightLabel = "→→→"}, true, function(Hovered, Active, Selected)
            end, RMenu:Get("adminmenu", "players"))
        
            RageUI.Button("Nearby Players", nil, {RightLabel = "→→→"}, true, function(Hovered, Active, Selected)
                if Selected then
                    TriggerServerEvent("Nova:GetNearbyPlayers", 250)
                end
            end, RMenu:Get("adminmenu", "closeplayers"))
        
            RageUI.Button("Search Players", nil, {RightLabel = "→→→"}, true, function(Hovered, Active, Selected)
                end, RMenu:Get("adminmenu", "searchoptions"))
        
            RageUI.Button("Admin Functions", nil, {RightLabel = "→→→"}, true, function(Hovered, Active, Selected)
            end, RMenu:Get("adminmenu", "adminfunctions"))
        end)

    elseif RageUI.Visible(RMenu:Get("adminmenu", "players")) then
        RageUI.DrawContent({header = true, glare = false, instructionalButton = false}, function()
            for k, v in pairs(players) do
                local current_perm_id = v[3]
                RageUI.Button(("%s [Temp ID: %s]"):format(v[1], v[2]), ("%s (%s Hours), Perm ID: %s"):format(v[1], v[4], v[3]), {RightLabel = "→"}, true, function(Hovered, Active, Selected)
                    if Selected then
                        SelectedPlayer = players[k]
                        SelectedPerm = v[3]
                        Selected_Temp_ID = v[2]
                        TriggerServerEvent("Nova:CheckPov", SelectedPerm)
                    end
                end, RMenu:Get("adminmenu", "submenu"))
            end
        end)

    elseif RageUI.Visible(RMenu:Get("adminmenu", "closeplayers")) then
        RageUI.DrawContent({header = true, glare = false, instructionalButton = true}, function()
            if next(playersNearby) then
                for i, v in pairs(playersNearby) do
                    RageUI.Button(("%s [Temp ID: %s]"):format(v[1], v[2]), ("(%s Hours) Perm ID: %s"):format(v[1] ,v[4], v[3]), {RightLabel = "→"}, true, function(Hovered, Active, Selected)
                        if Selected then
                            SelectedPlayer = playersNearby[i]
                            SelectedPerm = v[3]
                            Selected_Temp_ID = v[2]
                        end

                        if Active then
                            hoveredPlayer = v[2]
                        end
                    end, RMenu:Get("adminmenu", "submenu"))
                end
            else
                RageUI.Separator("No players nearby!")
            end
        end)

    elseif RageUI.Visible(RMenu:Get("SettingsMenu", "MainMenu")) then
        RageUI.DrawContent({header = true, glare = false, instructionalButton = false}, function()
            RageUI.List("Modify Render Distance", d, dts, "~b~Change Render Distance", {}, true, function(a, b, c, d)
                if c then -- Locals...
                end
                dts = d -- Locals ...
            end)
            
            RageUI.Checkbox("Toggle Compass", nil, compasschecked, {RightLabel = ""}, function(Hovered, Active, Selected, Checked)
                if (Selected) then
                    compasschecked = not compasschecked
                    ExecuteCommand("compass")
                end
            end)

            RageUI.Checkbox("Hitsounds Enabled", nil, exports['Nova-HS']:Are_Hit_Sounds_Enabled(), {RightLabel = ""}, function(Hovered, Active, Selected, Checked)
                if (Selected) then
                    TriggerEvent('Nova:SetHitSounds', Checked)
                end
            end)

            RageUI.Checkbox("Toggle Hud", nil, hudchecked, {RightLabel = ""}, function(Hovered, Active, Selected, Checked)
                if (Selected) then
                    hudchecked = not hudchecked
                    if Checked then
                        ExecuteCommand("showhud")
                    else
                        ExecuteCommand("showhud")
                    end
                end
            end)

            RageUI.Checkbox("Toggle Killfeed", nil, killfeedchecked, {RightLabel = ""}, function(Hovered, Active, Selected, Checked)
                if (Selected) then
                    killfeedchecked = not killfeedchecked
                    if Checked then
                        ExecuteCommand("killfeed")
                    else
                        ExecuteCommand("killfeed")
                    end
                end
            end)

            RageUI.Button("~b~Crosshair Settings", "~b~Change your crosshair settings", {RightLabel = "→→→"}, true, function(Hovered, Active, Selected)
            end, RMenu:Get("SettingsMenu", "crosshairsettings"))
        end)

    elseif RageUI.Visible(RMenu:Get("SettingsMenu", "crosshairsettings")) then
        RageUI.DrawContent({header = true, glare = false, instructionalButton = false}, function()
            RageUI.Checkbox("Enable Crosshair", nil, crosshairchecked, {RightLabel = ""}, function(Hovered, Active, Selected, Checked)
                if (Selected) then
                    crosshairchecked = not crosshairchecked
                    if Checked then
                        ExecuteCommand("cross")
                        notify("~g~Crosshair Enabled!")
                    else
                        ExecuteCommand("cross")
                        notify("~r~Crosshair Disabled!")
                    end
                end
            end)

            RageUI.Button("Edit Crosshair", nil, {RightLabel = "→→→"}, true, function(Hovered, Active, Selected)
                if (Selected) then
                    ExecuteCommand("crosse")
                end
            end)

            RageUI.Button("Reset Crosshair", nil, {RightLabel = "→→→"}, true, function(Hovered, Active, Selected)
                if (Selected) then
                    ExecuteCommand("crossr")
                end
            end)
        end)

    elseif RageUI.Visible(RMenu:Get("adminmenu", "searchoptions")) then
        RageUI.DrawContent({header = true, glare = false, instructionalButton = false}, function()
            foundMatch = false
            RageUI.Button("Search by Name", "", {RightLabel = "→"}, true, function(Hovered, Active, Selected)
            end, RMenu:Get("adminmenu", "searchname"))

            RageUI.Button("Search by Perm ID", "", {RightLabel = "→"}, true, function(Hovered, Active, Selected)
            end, RMenu:Get("adminmenu", "searchpermid"))

            RageUI.Button("Search by Temp ID", "", {RightLabel = "→"}, true, function(Hovered, Active, Selected)
            end, RMenu:Get("adminmenu", "searchtempid"))

            RageUI.Button("Search History", "", {RightLabel = "→"}, true, function(Hovered, Active, Selected)
            end, RMenu:Get("adminmenu", "searchhistory"))
        end)

    elseif RageUI.Visible(RMenu:Get("adminmenu", "adminfunctions")) then
        RageUI.DrawContent({header = true, glare = false, instructionalButton = false}, function()
            if admincfg.buttonsEnabled["kick"][1] and buttons["kick"] then
                RageUI.Button("Kick (No F10)", nil, {RightLabel = "→"}, true, function(Hovered, Active, Selected)
                    if Selected then
                        TriggerServerEvent("Nova:noF10Kick")
                    end
                end, RMenu:Get("adminmenu", "adminfunctions"))
            end

            if admincfg.buttonsEnabled["ban"][1] and buttons["ban"] then
                RageUI.Button("Offline Ban", nil, {RightLabel = "→"}, true, function(Hovered, Active, Selected)
                    if Selected then
                        local uid = GetPlayerServerId(PlayerId())
                        TriggerServerEvent("Nova:offlineban", uid)
                    end
                end)
            end

            if admincfg.buttonsEnabled["unban"][1] and buttons["unban"] then
                RageUI.Button("Unban Player", nil, {RightLabel = "→"}, true, function(Hovered, Active, Selected)
                    if Selected then
                        TriggerServerEvent("Nova:Unban")
                    end
                end)
            end

            if admincfg.buttonsEnabled["removewarn"][1] and buttons["removewarn"] then
                RageUI.Button("Remove Warning", nil, {RightLabel = "→"}, true, function(Hovered, Active, Selected)
                    if Selected then
                        local uid = GetPlayerServerId(PlayerId())
                        TriggerServerEvent("Nova:RemoveWarning", uid, result)
                    end
                end)
            end

            if admincfg.buttonsEnabled["tp2waypoint"][1] and buttons["tp2waypoint"] then
                RageUI.List("Teleport to ", q, s, nil, {}, true, function(x, y, z, N)
                    s = N
                    if z then
                        TriggerServerEvent("Nova:Server:Teleport", vector3(r[s]))
                    end
                end)

                RageUI.Button("Teleport To Waypoint", nil, {RightLabel = "→"}, true, function(Hovered, Active, Selected)
                    if Selected then
                        local WaypointHandle = GetFirstBlipInfoId(8)
                        if DoesBlipExist(WaypointHandle) then
                            local waypointCoords = GetBlipInfoIdCoord(WaypointHandle)
                            for height = 1, 1000 do
                                SetPedCoordsKeepVehicle(
                                    PlayerPedId(),
                                    waypointCoords["x"],
                                    waypointCoords["y"],
                                    height + 0.0
                                )

                                local foundGround, zPos =
                                    GetGroundZFor_3dCoord(
                                    waypointCoords["x"],
                                    waypointCoords["y"],
                                    height + 0.0
                                )

                                if foundGround then
                                    SetPedCoordsKeepVehicle(
                                        PlayerPedId(),
                                        waypointCoords["x"],
                                        waypointCoords["y"],
                                        height + 0.0
                                    )
                                    break
                                end
                                Citizen.Wait(5)
                            end
                        else
                            notify("~r~You do not have a waypoint set")
                        end
                    end
                end)

                RageUI.Button("Teleport To Coords", nil, {RightLabel = "→"}, true, function(Hovered, Active, Selected)
                    if Selected then
                        TriggerServerEvent("Nova:Tp2Coords")
                    end
                end)
            end
            
            if admincfg.buttonsEnabled["developerMenu"][1] and buttons["developerMenu"] then
                RageUI.Button("Anticheat", nil, {RightLabel = "→"}, true, function(Hovered, Active, Selected)
                end, RMenu:Get('anticheat', 'main'))
            end

            if admincfg.buttonsEnabled["getgroups"][1] and buttons["getgroups"] then
                RageUI.Button("Toggle Blips", nil, {RightLabel = "→"}, true, function(Hovered, Active, Selected)
                    if Selected then
                        TriggerServerEvent("Nova:checkBlips")
                    end
                end)
            end
        end)
        
    elseif RageUI.Visible(RMenu:Get("adminmenu", "devfunctions")) then
        RageUI.DrawContent({header = true, glare = false, instructionalButton = false}, function()
            if admincfg.buttonsEnabled["developerMenu"][1] and buttons["developerMenu"] then
                RageUI.Button("Get Coords", nil, {RightLabel = "→"}, true, function(Hovered, Active, Selected)
                    if Selected then
                        TriggerServerEvent("Nova:GetCoords")
                    end
                end)

                RageUI.Button("Get Heading", nil, {RightLabel = "→"}, true, function(Hovered, Active, Selected)
                    if Selected then
                        local client_heading = GetEntityHeading(PlayerPedId())
                        TriggerServerEvent("Nova:GetHeading", client_heading)
                    end
                end)
            end

            if admincfg.buttonsEnabled["spawnGun"][1] and buttons["spawnGun"] then
                RageUI.Button("Spawn Weapon", nil, {RightLabel = "→"}, true, function(Hovered, Active, Selected)
                    if Selected then
                        TriggerServerEvent("Nova:Giveweapon")
                    end
                end)
            end
            
            if admincfg.buttonsEnabled["spawnGun"][1] and buttons["spawnGun"] then
                RageUI.Button("Give Weapon To Perm ID", nil, {RightLabel = "→"}, true, function(Hovered, Active, Selected)
                    if Selected then
                        TriggerServerEvent("Nova:GiveWeaponToPlayer")
                    end
                end)
            end

            if admincfg.buttonsEnabled["spawncar"][1] and buttons["spawncar"] then
                RageUI.Button("Vehicle Spawn List", nil, {RightLabel = "→"}, true, function(Hovered, Active, Selected)
                end, RMenu:Get('adminmenu', 'vehiclelist'))
            end

            if admincfg.buttonsEnabled["addcar"][1] and buttons["addcar"] then
                RageUI.Button("Add Car", nil, {RightLabel = "→"}, true, function(Hovered, Active, Selected)
                    if Selected then
                        TriggerServerEvent("Nova:AddCar")
                    end
                end)
            end

            if admincfg.buttonsEnabled["developerMenu"][1] and buttons["developerMenu"] then
                RageUI.Button("Give Bank Money", nil, {RightLabel = "→"}, true, function(Hovered, Active, Selected)
                    if Selected then
                        TriggerServerEvent("Nova:GiveMoneyMenu")
                    end
                end)
                
                RageUI.Button("Give Cash Money", nil, {RightLabel = "→"}, true, function(Hovered, Active, Selected)
                    if Selected then
                        TriggerServerEvent("Nova:GiveCashMenu")
                    end
                end)
            end
        end)

    elseif RageUI.Visible(RMenu:Get("adminmenu", "vehiclelist")) then
        RageUI.DrawContent({header = true, glare = false, instructionalButton = false}, function()
            for category_type, vehicle_info_tables in pairs(garage_types) do
                RageUI.Button(category_type, nil, {RightLabel = "→→→"}, true, function(Hovered, Active, Selected)
                    if Selected then
                        Vehicle_Selected_Category = category_type
                    end
                end, RMenu:Get("adminmenu", "vehiclelistmain"))
            end
        end)

    elseif RageUI.Visible(RMenu:Get("adminmenu", "vehiclelistmain")) then
        RageUI.DrawContent({header = true, glare = false, instructionalButton = false}, function()
            for category_type, vehicle_info_tables in pairs(garage_types) do
                if category_type == Vehicle_Selected_Category then
                    for spawn_name, model_info in pairs(vehicle_info_tables) do
                        if spawn_name ~= "_config" then
                            local valid_model = false
                            if not Valid_Vehicle_Models[spawn_name] then
                                if IsModelInCdimage(spawn_name) or IsModelValid(spawn_name) then
                                    Valid_Vehicle_Models[spawn_name] = true
                                    valid_model = true
                                end
                            else
                                valid_model = true
                            end
                            
                            if valid_model then
                                RageUI.Button(spawn_name, "" .. model_info[1] .. "", {RightLabel = "→→→"}, true, function(Hovered, Active, Selected)
                                    if Selected then
                                        Car_Dev_Spawn_Vehicle_Function(spawn_name, true) -- True will spawn as upgraded
                                    end
                                end)
                            end
                        end
                    end
                end
            end
        end)

    elseif RageUI.Visible(RMenu:Get("adminmenu", "searchtempid")) then
        RageUI.DrawContent({header = true, glare = false, instructionalButton = false}, function()
            if foundMatch == false then
                searchid = KeyboardInput("Enter Temp ID", "", 10)
                if searchid == nil then
                    searchid = ""
                end
                g = searchid
                h[i] = g
                i = i + 1
            end

            for k, v in pairs(players) do
                foundMatch = true
                if string.find(v[2], searchid) then
                    RageUI.Button(("%s [Temp ID: %s]"):format(v[1], v[2]), ("Name: %s, Perm ID: %s"):format(v[1], v[3]), {RightLabel = "→→→"}, true, function(Hovered, Active, Selected)
                        if Selected then
                            SelectedPlayer = players[k]
                        end
                    end, RMenu:Get("adminmenu", "submenu"))
                end
            end
        end)

    elseif RageUI.Visible(RMenu:Get("adminmenu", "searchpermid")) then
        RageUI.DrawContent({header = true, glare = false, instructionalButton = false}, function()
            if foundMatch == false then
                searchforPermID = KeyboardInput("Enter Perm ID", "", 10)
                if searchforPermID == nil then
                    searchforPermID = ""
                end
                g = searchforPermID
                h[i] = g
                i = i + 1
            end

            for k, v in pairs(players) do
                foundMatch = true
                if string.find(v[3], searchforPermID) then
                    RageUI.Button(("%s [Temp ID: %s]"):format(v[1], v[2]), ("Name: %s, Perm ID: %s"):format(v[1], v[3]), {RightLabel = "→→→"}, true, function(Hovered, Active, Selected)
                        if Selected then
                            SelectedPlayer = players[k]
                        end
                    end, RMenu:Get("adminmenu", "submenu"))
                end
            end
        end)

    elseif RageUI.Visible(RMenu:Get("adminmenu", "searchname")) then
        RageUI.DrawContent({header = true, glare = false, instructionalButton = false}, function()
            if foundMatch == false then
                SearchName = KeyboardInput("Enter Name", "", 10)
                if SearchName == nil then
                    SearchName = ""
                end
                g = SearchName
                h[i] = g
                i = i + 1
            end

            for k, v in pairs(players) do
                foundMatch = true
                if string.find(string.lower(v[1]), string.lower(SearchName)) then
                    RageUI.Button(("%s [Temp ID: %s]"):format(v[1], v[2]), ("Name: %s, Perm ID: %s"):format(v[1], v[3]), {RightLabel = "→→→"}, true, function(Hovered, Active, Selected)
                        if Selected then
                            SelectedPlayer = players[k]
                        end
                    end, RMenu:Get("adminmenu", "submenu"))
                end
            end
        end)

    elseif RageUI.Visible(RMenu:Get("adminmenu", "searchhistory")) then
        RageUI.DrawContent({header = true, glare = false, instructionalButton = false}, function()
            for k, v in pairs(players) do
                if i > 1 then
                    for K = #h, #h - 10, -1 do
                        if h[K] then
                            if tonumber(h[K]) == v[3] then
                                RageUI.Button(("%s [Temp ID: %s]"):format(v[1], v[2]), ("Name: %s, Perm ID: %s"):format(v[1], v[3]), {RightLabel = "→→→"}, true, function(Hovered, Active, Selected)
                                    if Selected then
                                        SelectedPlayer = players[k]
                                    end
                                end, RMenu:Get("adminmenu", "submenu"))
                            end
                        end
                    end
                end
            end
        end)

    elseif RageUI.Visible(RMenu:Get("adminmenu", "submenu")) then
        RageUI.DrawContent({header = true, glare = false, instructionalButton = false}, function()
            hoveredPlayer = nil
            RMenu:Get("adminmenu", "submenu"):SetSubtitle('> ~y~Player must provide Pov on request: ' .. povlist)
            --RageUI.Separator('> ~y~Player must provide POV on request: ' .. povlist)

            if admincfg.buttonsEnabled["spectate"][1] and buttons["spectate"] then
                RageUI.Button("Player Notes", ("Name: %s, Perm ID: %s, Temp ID: %s"):format(SelectedPlayer[1], SelectedPlayer[3], SelectedPlayer[2]), {RightLabel = "→"}, true, function(Hovered, Active, Selected)
                    if Selected then
                        TriggerServerEvent("Nova:getNotes", uid, SelectedPlayer[3])
                    end
                end, RMenu:Get("adminmenu", "notesub"))
            end 

            if admincfg.buttonsEnabled["kick"][1] and buttons["kick"] then
                RageUI.Button( "Kick Player", ("Name: %s, Perm ID: %s, Temp ID: %s"):format(SelectedPlayer[1], SelectedPlayer[3], SelectedPlayer[2]), {RightLabel = "→"}, true, function(Hovered, Active, Selected)
                    if Selected then
                        local uid = GetPlayerServerId(PlayerId())
                        TriggerServerEvent(
                            "Nova:KickPlayer",
                            uid,
                            SelectedPlayer[3],
                            kickReason,
                            SelectedPlayer[2]
                        )
                    end
                end)
            end

            if admincfg.buttonsEnabled["ban"][1] and buttons["ban"] then
                RageUI.Button( "Ban Player", ("Name: %s, Perm ID: %s, Temp ID: %s"):format(SelectedPlayer[1], SelectedPlayer[3], SelectedPlayer[2]), {RightLabel = "→"}, true, function(Hovered, Active, Selected)
                end, RMenu:Get("adminmenu", "bansub"))
            end

            if admincfg.buttonsEnabled["spectate"][1] and buttons["spectate"] then
                RageUI.Button("~b~Spectate Player [Anti-ESP]", ("Name: %s, Perm ID: %s, Temp ID: %s"):format(SelectedPlayer[1], SelectedPlayer[3], SelectedPlayer[2]), {RightLabel = "→"}, true, function(Hovered, Active, Selected)
                    if Selected then
                        if tonumber(SelectedPlayer[2]) == GetPlayerServerId(PlayerId()) then
                            exports.vrp:notify("~r~You can't spectate yourself")
                        else
                            inRedZone = false
                            TriggerServerEvent("Nova:SpectatePlayer", SelectedPlayer[3])
                        end
                    end
                end)
            end

            if admincfg.buttonsEnabled["TP2"][1] and buttons["TP2"] then
                RageUI.Button("Teleport to Player", ("Name: %s, Perm ID: %s, Temp ID: %s"):format(SelectedPlayer[1], SelectedPlayer[3], SelectedPlayer[2]), {RightLabel = "→"}, true, function(Hovered, Active, Selected)
                    if Selected then
                        local newSource = GetPlayerServerId(PlayerId())
                        savedCoords1 = GetEntityCoords(PlayerPedId())
                        TriggerServerEvent("Nova:TeleportToPlayer", newSource, SelectedPlayer[2])
                        inTP2P = true
                        inTP2P2 = true
                    end
                end)
            end

            if admincfg.buttonsEnabled["TP2ME"][1] and buttons["TP2ME"] then
                RageUI.Button("Teleport Player to Me", ("Name: %s, Perm ID: %s, Temp ID: %s"):format(SelectedPlayer[1], SelectedPlayer[3], SelectedPlayer[2]), {RightLabel = "→"}, true, function(Hovered, Active, Selected)
                    if Selected then
                        TriggerServerEvent("Nova:BringPlayer", SelectedPlayer[3])
                    end
                end)
            end

            if admincfg.buttonsEnabled["TP2ME"][1] and buttons["TP2ME"] then
                RageUI.Button("Teleport to Admin Zone", ("Name: %s, Perm ID: %s, Temp ID: %s"):format(SelectedPlayer[1], SelectedPlayer[3], SelectedPlayer[2]), {RightLabel = "→"}, true, function(Hovered, Active, Selected)
                    if Selected then
                        inRedZone = false
                        TriggerServerEvent("Nova:Teleport2AdminIsland", SelectedPlayer[2])
                    end
                end)
            end

            if admincfg.buttonsEnabled["TP2ME"][1] and buttons["TP2ME"] then
                RageUI.Button("Teleport Back from Admin Zone", ("Name: %s, Perm ID: %s, Temp ID: %s"):format(SelectedPlayer[1], SelectedPlayer[3], SelectedPlayer[2]), {RightLabel = "→"}, true, function(Hovered, Active, Selected)
                    if Selected then
                        TriggerServerEvent("Nova:TeleportBackFromAdminZone", SelectedPlayer[2])
                    end
                end)
            end

            if admincfg.buttonsEnabled["TP2ME"][1] and buttons["TP2ME"] then
                RageUI.Button("Teleport to Legion", ("Name: %s, Perm ID: %s, Temp ID: %s"):format(SelectedPlayer[1], SelectedPlayer[3], SelectedPlayer[2]), {RightLabel = "→"}, true, function(Hovered, Active, Selected)
                    if Selected then
                        TriggerServerEvent("Nova:Server:TeleportPlayer", SelectedPlayer[2], vector3(151.61740112305, -1035.05078125, 29.339416503906))
                    end
                end)
            end

            if admincfg.buttonsEnabled["revive"][1] and buttons["revive"] then
                RageUI.Button("Revive", ("Name: %s, Perm ID: %s, Temp ID: %s"):format(SelectedPlayer[1], SelectedPlayer[3], SelectedPlayer[2]), {RightLabel = "→"}, true, function(Hovered, Active, Selected)
                    if Selected then
                        local uid = GetPlayerServerId(PlayerId())
                        TriggerServerEvent("Nova:RevivePlayer", uid, SelectedPlayer[2])
                    end
                end)
            end

            if admincfg.buttonsEnabled["slap"][1] and buttons["slap"] then
                RageUI.Button("Slap Player", ("Name: %s, Perm ID: %s, Temp ID: %s"):format(SelectedPlayer[1], SelectedPlayer[3], SelectedPlayer[2]), {RightLabel = "→"}, true, function(Hovered, Active, Selected)
                    if Selected then
                        local uid = GetPlayerServerId(PlayerId())
                        TriggerServerEvent("Nova:SlapPlayer", uid, SelectedPlayer[2])
                    end
                end)
            end

            if admincfg.buttonsEnabled["FREEZE"][1] and buttons["FREEZE"] then
                RageUI.Button("Freeze", ("Name: %s, Perm ID: %s, Temp ID: %s"):format(SelectedPlayer[1], SelectedPlayer[3], SelectedPlayer[2]), {RightLabel = "→"}, true, function(Hovered, Active, Selected)
                    if Selected then
                        local uid = GetPlayerServerId(PlayerId())
                        isFrozen = not isFrozen
                        TriggerServerEvent("Nova:FreezeSV", uid, SelectedPlayer[2], isFrozen)
                    end
                end)
            end

            if admincfg.buttonsEnabled["showwarn"][1] and buttons["showwarn"] then
                RageUI.Button("Open F10 Warning Log", ("Name: %s, Perm ID: %s, Temp ID: %s"):format(SelectedPlayer[1], SelectedPlayer[3], SelectedPlayer[2]), {RightLabel = "→"}, true, function(Hovered, Active, Selected)
                    if Selected then
                        ExecuteCommand("sw " .. SelectedPlayer[3])
                    end
                end)
            end

            if admincfg.buttonsEnabled["SS"][1] and buttons["SS"] then
                RageUI.Button("Take Screenshot", ("Name: %s, Perm ID: %s, Temp ID: %s"):format(SelectedPlayer[1], SelectedPlayer[3], SelectedPlayer[2]), {RightLabel = "→"}, true, function(Hovered, Active, Selected)
                    if Selected then
                        local uid = GetPlayerServerId(PlayerId())
                        TriggerServerEvent("Nova:RequestScreenshot", uid, SelectedPlayer[2])
                    end
                end)
            end

            if admincfg.buttonsEnabled["forceclockoff"][1] and buttons["forceclockoff"] then
                RageUI.Button("Force Clock Off", ("Name: %s, Perm ID: %s, Temp ID: %s"):format(SelectedPlayer[1], SelectedPlayer[3], SelectedPlayer[2]), {RightLabel = "→→→"}, true, function(Hovered, Active, Selected)
                    if Selected then
                        TriggerServerEvent("Nova:Server:ForceClockOff", SelectedPlayer[2])
                    end
                end)
            end

            if admincfg.buttonsEnabled["getgroups"][1] and buttons["getgroups"] then
                RageUI.Button("See Groups", ("Name: %s, Perm ID: %s, Temp ID: %s"):format(SelectedPlayer[1], SelectedPlayer[3], SelectedPlayer[2]), {RightLabel = "→→→"}, true, function(Hovered, Active, Selected)
                    if Selected then
                        TriggerServerEvent("Nova:GetGroups", SelectedPlayer[3])
                    end
                end, RMenu:Get("adminmenu", "groups"))
            end
        end)

    elseif RageUI.Visible(RMenu:Get("adminmenu", "bansub")) then
        RageUI.DrawContent({header = true, glare = false, instructionalButton = false}, function()
            if admincfg.buttonsEnabled["ban"][1] and buttons["ban"] then
                RageUI.Button("~g~[Custom Ban Message]", nil, {RightLabel = "→"}, true, function(Hovered, Active, Selected)
                    if Selected then
                        local uid = GetPlayerServerId(PlayerId())
                        TriggerServerEvent("Nova:CustomBan", uid, SelectedPlayer[3])
                    end
                end, RMenu:Get("adminmenu", "submenu"))

                for i, p in pairs(warningbankick) do
                    RageUI.Checkbox(p.name, p.desc, p.selected, {RightLabel = ""}, function(Hovered, Active, Selected, Checked)
                        if (Selected) then
                            p.selected = not p.selected
                            if p.selected then
                                banduration = banduration + p.duration
                                banstable[p.name] = {p.name, p.duration}
                                banreasons = banreasons .. "\n" .. p.name
                            end
                        end
                    end)
                end

                RageUI.Button("Create Ban Data", nil, {RightLabel = "→→→"}, true, function(Hovered, Active, Selected)
                    if Selected then
                        bantargetname = SelectedPlayer[1]
                        bantarget = SelectedPlayer[3]
                    end
                end, RMenu:Get("adminmenu", "confirmban"))
            end
        end)

    elseif RageUI.Visible(RMenu:Get("adminmenu", "confirmban")) then
        RageUI.DrawContent({header = true, glare = false, instructionalButton = false}, function()
            RageUI.Separator("~r~You are about to ban " .. bantargetname)
            RageUI.Separator("~w~For the following reason(s):")
            
            for k, v in pairs(banstable) do
                RageUI.Separator(v[1] .. " ~y~| ~w~" .. v[2] .. "hrs")
            end

            if banduration >= 9000 then
                RageUI.Separator("Total Length: Permanent")
            else
                RageUI.Separator("Total Length: " .. banduration .. " hours")
            end

            RageUI.Button("Confirm Ban", nil, {RightLabel = ">>>"}, true, function(Hovered, Active, Selected)
                if Selected then
                    local uid = GetPlayerServerId(PlayerId())
                    TriggerServerEvent(
                        "Nova:BanPlayerConfirm",
                        uid,
                        bantarget,
                        banreasons,
                        banduration,
                        banevidence
                    )
                end
            end)

            RageUI.Button("Cancel Ban", nil, {RightLabel = ">>>"}, true, function(Hovered, Active, Selected)
                if Selected then
                    for i, p in pairs(warningbankick) do
                        if p.selected then
                            p.selected = not p.selected
                        end
                    end
                    banduration = 0
                    banstable = {}
                    banreasons = ""
                end
            end, RMenu:Get("adminmenu", "submenu"))
        end)

    elseif RageUI.Visible(RMenu:Get("adminmenu", "notesub")) then
        RageUI.DrawContent({header = true, glare = false, instructionalButton = false}, function()
            if f == nil then
                RageUI.Separator("~b~Player notes: Loading")
            elseif #f == 0 then
                RageUI.Separator("~b~There are no player notes to display")
            else
                RageUI.Separator("~b~Player Notes:")
                for K = 1, #f do
                    RageUI.Separator(("~g~[ID: %s] ~w~%s - %s [%s]"):format(f[K].note_id, f[K].text, f[K].admin_name, f[K].admin_id))
                end
            end

            if admincfg.buttonsEnabled["warn"][1] and buttons["warn"] then
                RageUI.Button("Add Note", nil, {RightLabel = "→→→"}, true, function(Hovered, Active, Selected)
                    if Selected then
                        TriggerServerEvent("Nova:addNote", uid, SelectedPlayer[2])
                    end
                end)

                RageUI.Button("Remove Note", nil, {RightLabel = "→→→"}, true, function(Hovered, Active, Selected)
                    if Selected then
                        local uid = GetPlayerServerId(PlayerId())
                        TriggerServerEvent("Nova:removeNote", uid, SelectedPlayer[2])
                    end
                end)
            end
        end)

    elseif RageUI.Visible(RMenu:Get("adminmenu", "groups")) then
        RageUI.DrawContent({header = true, glare = false, instructionalButton = false}, function()
            if admincfg.buttonsEnabled["staffGroups"][1] and buttons["staffGroups"] then
                RageUI.Button("Staff Groups", "", {RightLabel = "→→→"}, true, function(Hovered, Active, Selected)
                    if (Selected) then
                    end
                end, RMenu:Get("adminmenu", "staffGroups"))
            end

            if (
                admincfg.buttonsEnabled["mpdGroups"][1] and buttons['mpdGroups'] or
                admincfg.buttonsEnabled["nhsGroups"][1] and buttons['nhsGroups'] or
                admincfg.buttonsEnabled["lfbGroups"][1] and buttons['lfbGroups'] or
                admincfg.buttonsEnabled["hmpGroups"][1] and buttons['hmpGroups'] or
                admincfg.buttonsEnabled["whitelistgroups"][1] and buttons['whitelistgroups'] 
                
            ) then
                RageUI.Button('Faction Groups', '', {RightLabel = "→→→"}, true, function(Hovered, Active, Selected)
                end, RMenu:Get('adminmenu', 'FactionGroups'))
            end

            if admincfg.buttonsEnabled["povGroups"][1] and buttons["povGroups"] then
                RageUI.Button("Pov Groups", "", {RightLabel = "→→→"}, true, function(Hovered, Active, Selected)
                end, RMenu:Get("adminmenu", "PovGroups"))
            end

            if admincfg.buttonsEnabled["licenseGroups"][1] and buttons["licenseGroups"] then
                RageUI.Button("License Groups", "", {RightLabel = "→→→"}, true, function(Hovered, Active, Selected)
                end, RMenu:Get("adminmenu", "licenseGroups"))
            end

            if admincfg.buttonsEnabled["donoGroups"][1] and buttons["donoGroups"] then
                RageUI.Button("Donator Groups", "", {RightLabel = "→→→"}, true, function(Hovered, Active, Selected)
                end, RMenu:Get("adminmenu", "UserGroups"))
            end
        end)

    elseif RageUI.Visible(RMenu:Get("adminmenu", "FactionGroups")) then
        RageUI.DrawContent({header = true, glare = false, instructionalButton = false}, function()
            if admincfg.buttonsEnabled["mpdGroups"][1] and buttons["mpdGroups"] then
                RageUI.Button("MPD Groups", "", {RightLabel = "→→→"}, true, function(Hovered, Active, Selected)
                end, RMenu:Get("adminmenu", "mpdGroups"))
            end

            if admincfg.buttonsEnabled["nhsGroups"][1] and buttons["nhsGroups"] then
                RageUI.Button("NHS Groups", "", {RightLabel = "→→→"}, true, function(Hovered, Active, Selected)
                end, RMenu:Get("adminmenu", "nhsGroups"))
            end

            if admincfg.buttonsEnabled["lfbGroups"][1] and buttons["lfbGroups"] then
                RageUI.Button("LFB Groups", "", {RightLabel = "→→→"}, true, function(Hovered, Active, Selected)
                end, RMenu:Get("adminmenu", "lfbGroups"))
            end
            
            if admincfg.buttonsEnabled["hmpGroups"][1] and buttons["hmpGroups"] then
                RageUI.Button("HMP Groups", "", {RightLabel = "→→→"}, true, function(Hovered, Active, Selected)
                end, RMenu:Get("adminmenu", "hmpGroups"))
            end
            
            if admincfg.buttonsEnabled["whitelistgroups"][1] and buttons["whitelistgroups"] then
                RageUI.Button("Whitelist Groups", "", {RightLabel = "→→→"}, true, function(Hovered, Active, Selected)
                end, RMenu:Get("adminmenu", "whitelistgroups"))
            end
        end)

    elseif RageUI.Visible(RMenu:Get("adminmenu", "staffGroups")) then
        RageUI.DrawContent({header = true, glare = false, instructionalButton = false}, function()
            for k, v in ipairs(getStaffGroupsGroupIds) do
                local current_group = Get_Permission_From_Name(v)
                if searchPlayerGroups[current_group] then
                    RageUI.Button(("~g~%s"):format(v), "~g~User has this group", {RightLabel = "→→→"}, true, function(Hovered, Active, Selected)
                        if (Selected) then
                            selectedGroup = current_group
                            Selected_Menu = "staffGroups"
                        end
                    end, RMenu:Get("adminmenu", "removegroup"))
                else
                    RageUI.Button(("~r~%s"):format(v), "~r~User does not have this group", {RightLabel = "→→→"}, true, function(Hovered, Active, Selected)
                        if (Selected) then
                            selectedGroup = current_group
                            Selected_Menu = "staffGroups"
                        end
                    end, RMenu:Get("adminmenu", "addgroup"))
                end
            end
        end)

    elseif RageUI.Visible(RMenu:Get("adminmenu", "mpdGroups")) then
        RageUI.DrawContent({header = true, glare = false, instructionalButton = false}, function()
            for k, v in ipairs(getmpdGroupsGroupIds) do
                local current_group = Get_Permission_From_Name(v)
                if searchPlayerGroups[current_group] then
                    RageUI.Button(("~g~%s"):format(v), "~g~User has this group", {RightLabel = "→→→"}, true, function(Hovered, Active, Selected)
                        if (Selected) then
                            selectedGroup = current_group
                            Selected_Menu = "mpdGroups"
                        end
                    end, RMenu:Get("adminmenu", "removegroup"))
                else
                    RageUI.Button(("~r~%s"):format(v), "~r~User does not have this group", {RightLabel = "→→→"}, true, function(Hovered, Active, Selected)
                        if (Selected) then
                            selectedGroup = current_group
                            Selected_Menu = "mpdGroups"
                        end
                    end, RMenu:Get("adminmenu", "addgroup"))
                end
            end
        end)

    elseif RageUI.Visible(RMenu:Get("adminmenu", "nhsGroups")) then
        RageUI.DrawContent({header = true, glare = false, instructionalButton = false}, function()
            for k, v in ipairs(getnhsGroupsGroupIds) do
                local current_group = Get_Permission_From_Name(v)
                if searchPlayerGroups[current_group] then
                    RageUI.Button(("~g~%s"):format(v), "~g~User has this group", {RightLabel = "→→→"}, true, function(Hovered, Active, Selected)
                        if (Selected) then
                            selectedGroup = current_group
                            Selected_Menu = "nhsGroups"
                        end
                    end, RMenu:Get("adminmenu", "removegroup"))
                else
                    RageUI.Button(("~r~%s"):format(v), "~r~User does not have this group", {RightLabel = "→→→"}, true, function(Hovered, Active, Selected)
                        if (Selected) then
                            selectedGroup = current_group
                            Selected_Menu = "nhsGroups"
                        end
                    end, RMenu:Get("adminmenu", "addgroup"))
                end
            end
        end)

    elseif RageUI.Visible(RMenu:Get("adminmenu", "lfbGroups")) then
        RageUI.DrawContent({header = true, glare = false, instructionalButton = false}, function()
                for k, v in ipairs(getlfbGroupsGroupIds) do
                    local current_group = Get_Permission_From_Name(v)
                    if searchPlayerGroups[current_group] then
                        RageUI.Button(("~g~%s"):format(v), "~g~User has this group", {RightLabel = "→→→"}, true, function(Hovered, Active, Selected)
                            if (Selected) then
                                selectedGroup = current_group
                                Selected_Menu = "lfbGroups"
                            end
                        end, RMenu:Get("adminmenu", "removegroup"))
                    else
                        RageUI.Button(("~r~%s"):format(v), "~r~User does not have this group", {RightLabel = "→→→"}, true, function(Hovered, Active, Selected)
                            if (Selected) then
                                selectedGroup = current_group
                                Selected_Menu = "lfbGroups"
                            end
                        end, RMenu:Get("adminmenu", "addgroup"))
                    end
                end
            end
        )

    elseif RageUI.Visible(RMenu:Get("adminmenu", "hmpGroups")) then
        RageUI.DrawContent({header = true, glare = false, instructionalButton = false}, function()
            for k, v in ipairs(gethmpGroupsGroupIds) do
                local current_group = Get_Permission_From_Name(v)
                if searchPlayerGroups[current_group] then
                    RageUI.Button(("~g~%s"):format(v), "~g~User has this group", {RightLabel = "→→→"}, true, function(Hovered, Active, Selected)
                        if (Selected) then
                            selectedGroup = current_group
                            Selected_Menu = "hmpGroups"
                        end
                    end, RMenu:Get("adminmenu", "removegroup"))
                else
                    RageUI.Button(("~r~%s"):format(v), "~r~User does not have this group", {RightLabel = "→→→"}, true, function(Hovered, Active, Selected)
                        if (Selected) then
                            selectedGroup = current_group
                            Selected_Menu = "hmpGroups"
                        end
                    end, RMenu:Get("adminmenu", "addgroup"))
                end
            end
        end)

    elseif RageUI.Visible(RMenu:Get("adminmenu", "licenseGroups")) then
        RageUI.DrawContent({header = true, glare = false, instructionalButton = false}, function()
            for k, v in ipairs(getlicenseGroupsGroupIds) do
                local current_group = Get_Permission_From_Name(v)
                if searchPlayerGroups[current_group] then
                    RageUI.Button(("~g~%s"):format(v), "~g~User has this group", {RightLabel = "→→→"}, true, function(Hovered, Active, Selected)
                        if (Selected) then
                            selectedGroup = current_group
                            Selected_Menu = "licenseGroups"
                        end
                    end, RMenu:Get("adminmenu", "removegroup"))
                else
                    RageUI.Button(("~r~%s"):format(v), "~r~User does not have this group", {RightLabel = "→→→"}, true, function(Hovered, Active, Selected)
                        if (Selected) then
                            selectedGroup = current_group
                            Selected_Menu = "licenseGroups"
                        end
                    end, RMenu:Get("adminmenu", "addgroup"))
                end
            end
        end)

    elseif RageUI.Visible(RMenu:Get("adminmenu", "UserGroups")) then
        RageUI.DrawContent({header = true, glare = false, instructionalButton = false}, function()
            for k, v in ipairs(getUserGroupsGroupIds) do
                local current_group = Get_Permission_From_Name(v)
                if searchPlayerGroups[current_group] then
                    RageUI.Button(("~g~%s"):format(v), "~g~User has this group", {RightLabel = "→→→"}, true, function(Hovered, Active, Selected)
                        if (Selected) then
                            selectedGroup = current_group
                            Selected_Menu = "UserGroups"
                        end
                    end, RMenu:Get("adminmenu", "removegroup"))
                else
                    RageUI.Button(("~r~%s"):format(v), "~r~User does not have this group", {RightLabel = "→→→"}, true, function(Hovered, Active, Selected)
                        if (Selected) then
                            selectedGroup = current_group
                            Selected_Menu = "UserGroups"
                        end
                    end, RMenu:Get("adminmenu", "addgroup"))
                end
            end
        end)
        
    elseif RageUI.Visible(RMenu:Get("adminmenu", "whitelistgroups")) then
        RageUI.DrawContent({header = true, glare = false, instructionalButton = false}, function()
            for k, v in ipairs(getWhitelistedGroupsGroupIds) do
                local current_group = Get_Permission_From_Name(v)
                if searchPlayerGroups[current_group] then
                    RageUI.Button(("~g~%s"):format(v), "~g~User has this group", {RightLabel = "→→→"}, true, function(Hovered, Active, Selected)
                        if (Selected) then
                            selectedGroup = current_group
                            Selected_Menu = "whitelistgroups"
                        end
                    end, RMenu:Get("adminmenu", "removegroup"))
                else
                    RageUI.Button(("~r~%s"):format(v), "~r~User does not have this group", {RightLabel = "→→→"}, true, function(Hovered, Active, Selected)
                        if (Selected) then
                            selectedGroup = current_group
                            Selected_Menu = "whitelistgroups"
                        end
                    end, RMenu:Get("adminmenu", "addgroup"))
                end
            end
        end)

    elseif RageUI.Visible(RMenu:Get("adminmenu", "PovGroups")) then
        RageUI.DrawContent({header = true, glare = false, instructionalButton = false}, function()
            for k, v in ipairs(getUserPovGroups) do
                local current_group = Get_Permission_From_Name(v)
                if searchPlayerGroups[current_group] then
                    RageUI.Button(("~g~%s"):format(v), "~g~User has this group", {RightLabel = "→→→"}, true, function(Hovered, Active, Selected)
                        if (Selected) then
                            selectedGroup = current_group
                            Selected_Menu = "PovGroups"
                        end
                    end, RMenu:Get("adminmenu", "removegroup"))
                else
                    RageUI.Button(("~r~%s"):format(v), "~r~User does not have this group", {RightLabel = "→→→"}, true, function(Hovered, Active, Selected)
                        if (Selected) then
                            selectedGroup = current_group
                            Selected_Menu = "PovGroups"
                        end
                    end, RMenu:Get("adminmenu", "addgroup"))
                end
            end
        end)

    elseif RageUI.Visible(RMenu:Get("adminmenu", "addgroup")) then
        RageUI.DrawContent({header = true, glare = false, instructionalButton = false}, function()
            RageUI.Button("Add this group to user", "", {RightLabel = "→→→"}, true, function(Hovered, Active, Selected)
                if (Selected) then
                    TriggerServerEvent("Nova:AddGroup", Selected_Temp_ID, selectedGroup)
                    TriggerServerEvent("Nova:GetGroups", SelectedPerm)

                    if selectedGroup == 'pov' then
                        TriggerServerEvent('Nova:CheckPov', SelectedPerm)
                    end
                end
            end, RMenu:Get("adminmenu", Selected_Menu))
        end)

    elseif RageUI.Visible(RMenu:Get("adminmenu", "removegroup")) then
        RageUI.DrawContent({header = true, glare = false, instructionalButton = false}, function()
            RageUI.Button("Remove user from group", "", {RightLabel = "→→→"}, true, function(Hovered, Active, Selected)
                if (Selected) then
                    TriggerServerEvent("Nova:RemoveGroup", Selected_Temp_ID, selectedGroup)
                    TriggerServerEvent("Nova:GetGroups", SelectedPerm)

                    if selectedGroup == 'pov' then
                        TriggerServerEvent('Nova:CheckPov', SelectedPerm)
                    end
                end
            end, RMenu:Get("adminmenu", Selected_Menu))
        end)

    elseif RageUI.Visible(RMenu:Get('anticheat', 'main')) then
        RageUI.DrawContent({ header = true, glare = false, instructionalButton = false}, function()
            RageUI.Separator("Anticheat Duration: Lifetime", function() end)
            RageUI.Separator("Banned Players: " .. acbannedplayers, function() end)
            RageUI.Separator("Your Name: " .. acadminname, function() end)

            RageUI.Button("Banned Players", nil, {RightLabel = "→"}, true, function(Hovered, Active, Selected)
            end, RMenu:Get('anticheat', 'acbannedplayers'))

            RageUI.Button("Ban Types", nil, {RightLabel = "→"}, true, function(Hovered, Active, Selected)
            end, RMenu:Get('anticheat', 'actypes'))

            RageUI.Button("Manual Ban", nil, {RightLabel = "→"}, true, function(Hovered, Active, Selected)
            end, RMenu:Get('anticheat', 'acmanualbanlist')) 
        end)

    elseif RageUI.Visible(RMenu:Get('anticheat', 'actypes')) then
        RageUI.DrawContent({ header = true, glare = false, instructionalButton = false}, function()
            RageUI.Separator("Anticheat Duration: Lifetime", function() end)
            RageUI.Separator("Banned Players: " .. acbannedplayers, function() end)
            RageUI.Separator("Your Name: " .. acadminname, function() end)

            for i, p in pairs(actypes) do
                RageUI.Button("Type #".. p.type, p.desc, {RightLabel = "→→→"}, true, function(Hovered, Active, Selected)
                end, RMenu:Get('anticheat', 'anticheat'))
            end
        end)

    elseif RageUI.Visible(RMenu:Get('anticheat', 'acbannedplayers')) then
        RageUI.DrawContent({ header = true, glare = false, instructionalButton = false}, function()
            RageUI.Separator("Anticheat Duration: Lifetime", function() end)
            RageUI.Separator("Banned Players: " .. acbannedplayers, function() end)
            RageUI.Separator("Your Name: " .. acadminname, function() end)

            for k, v in pairs(acbannedplayerstable) do
                RageUI.Button("Ban ID: ".. v[1] .." Perm ID: ".. v[2], "Username: " .. v[3] .. " Reason: " .. v[4], {RightLabel = "→"}, true, function(Hovered, Active, Selected)
                    if Selected then
                        SelectedPlayer = acbannedplayerstable[k]
                    end
                end, RMenu:Get('anticheat', 'acbanmenu'))
            end
        end)

    elseif RageUI.Visible(RMenu:Get('anticheat', 'acmanualbanlist')) then
        RageUI.DrawContent({ header = true, glare = false, instructionalButton = false}, function()
            RageUI.Separator("Anticheat Duration: Lifetime", function() end)
            RageUI.Separator("Banned Players: " .. acbannedplayers, function() end)
            RageUI.Separator("Your Name: " .. acadminname, function() end)

            for k, v in pairs(acplayerstable) do
                RageUI.Button(v[1] .." ["..v[2].."]", v[1] .. " PermID: " .. v[3] .. " TempID: " .. v[2], {RightLabel = "→"}, true, function(Hovered, Active, Selected)
                    if Selected then
                        SelectedPlayer = players[k]
                        SelectedPerm = v[3]
                        SelectedName = v[1]
                        SelectedPlayerSource = v[2]
                    end
                end, RMenu:Get('anticheat', 'acmanualban'))
            end
        end)

    elseif RageUI.Visible(RMenu:Get('anticheat', 'acmanualban')) then
        RageUI.DrawContent({ header = true, glare = false, instructionalButton = false}, function()
            RageUI.Separator("Anticheat Duration: Lifetime", function() end)
            RageUI.Separator("Banned Players: " .. acbannedplayers, function() end)
            RageUI.Separator("Your Name: " .. acadminname, function() end)

            for i, p in pairs(actypes) do
                RageUI.Button("Type #" .. p.type, p.desc, {RightLabel = "→→→"}, true, function(Hovered, Active, Selected)
                    if Selected then
                        acbanType = p.type
                    end
                end, RMenu:Get('anticheat', 'confirmacban'))
            end
        end)

    elseif RageUI.Visible(RMenu:Get('anticheat', 'confirmacban')) then
        RageUI.DrawContent({ header = true, glare = false, instructionalButton = false}, function()
            RageUI.Separator("~r~You are about to ban " ..SelectedName)
            RageUI.Separator("~w~For the following reasons:")
            RageUI.Separator('Cheating Type #'..acbanType)
            RageUI.Separator('Duration: Permanent')
            RageUI.Button("Confirm Ban", nil, { RightLabel = ">>>" }, true, function(Hovered, Active, Selected)
                if Selected then
                    TriggerServerEvent("Nova:acBan", SelectedPerm, 'Type #'..acbanType, SelectedName, SelectedPlayerSource)
                    notify('~g~AC Banned ID: '..SelectedPerm)
                end
            end, RMenu:Get('anticheat', 'anticheat'))
            RageUI.Button("Cancel Ban", nil, { RightLabel = ">>>" }, true, function(Hovered, Active, Selected)
            end, RMenu:Get('anticheat', 'anticheat'))
        end)

    elseif RageUI.Visible(RMenu:Get('anticheat', 'acbanmenu')) then
        RageUI.DrawContent({ header = true, glare = false, instructionalButton = false}, function()
            RageUI.Separator("Anticheat Duration: Lifetime", function() end)
            RageUI.Separator("Banned Players: " .. acbannedplayers, function() end)
            RageUI.Separator("Your Name: " .. acadminname, function() end)

            RageUI.Button("Unban Player", "Unban Selected User", {RightLabel = "→→→"}, true, function(Hovered, Active, Selected)
                if Selected then 
                    TriggerServerEvent('Nova:acUnban', SelectedPlayer[2])
                end
            end, RMenu:Get("anticheat", "acbannedplayers"))

            RageUI.Button("Check Warnings", "Show F10 Warning Log", {RightLabel = "→→→"}, true, function(Hovered, Active, Selected)
                if Selected then 
                    ExecuteCommand("sw " .. SelectedPlayer[2])
                end
            end)
        end)
    end
end)