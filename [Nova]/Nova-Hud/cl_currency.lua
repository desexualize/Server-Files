------------------------------------------------------------------
--                          Variables
------------------------------------------------------------------

local showHud = true -- Boolean to show / hide HUD
local hunger = 100 -- Init hunger's variable. Set to 100 for development.
local thirst = 100 -- Init thirst's variable. Set to 100 for development.
local showNo = false
local moneyDisplay = 0
local bankMoneyDisplay = 0
local voiceChatProximity = 2
local proximityIdToString = {
    [1] = "Whisper",
    [2] = "Talking",
    [3] = "Shouting"
}
local prox
local Client_Player = PlayerId()
local Client_Ped = PlayerPedId()

local function Set_Voice_Chat_Proximity()
    if voiceChatProximity == 1 then
        prox = 5.01
    elseif voiceChatProximity == 2 then
        prox = 15.01
    elseif voiceChatProximity == 3 then
        prox = 35.01
    end

    NetworkSetTalkerProximity(prox)
    NetworkSetVoiceActive(true)
end
Set_Voice_Chat_Proximity()

local function getMoneyStringFormatted(cashString)
    local i, j, minus, int, fraction = tostring(cashString):find("([-]?)(%d+)([.]?%d*)")
    int = int:reverse():gsub("(%d%d%d)", "%1,")
    return minus .. int:reverse():gsub("^,", "") .. fraction
end

local function updateHungerThirstHUD(cash, bank, proximity, topLeftAnchor, yAnchor)
    SendNUIMessage(
        {
            update = true,
            cash = cash,
            bank = bank,
            proximity = proximityIdToString[proximity],
            topLeftAnchor = topLeftAnchor,
            yAnchor = yAnchor
        }
    )
end

local function showhudUI(flag)
    showHud = flag
    SendNUIMessage({showhud = flag})
end

local Safe_Zone = GetSafeZoneSize()
local Screen_X, Screen_Y = GetActiveScreenResolution()
local Aspect_Ratio = GetAspectRatio(0)

local function getMinimapAnchor()
    SetScriptGfxAlign(string.byte("L"), string.byte("B"))
    local minimapTopX, minimapTopY = GetScriptGfxPosition(-0.0045, 0.002 + (-0.188888))
    ResetScriptGfxAlign()
    local xscale = 1.0 / Screen_X
    local yscale = 1.0 / Screen_Y
    local Minimap = {}
    local width = xscale * (Screen_X / (4 * Aspect_Ratio))
    return {Screen_X * 2 * minimapTopX, (Screen_Y * minimapTopY) + ((width * 0.61) * Screen_Y), width * Screen_X}
end

armourtexr = "~b~Armour: " .. '"' .. GetPedArmour(Client_Ped) .. '"'

local function drawRct(x, y, Width, height, r, g, b, a)
    DrawRect(x + Width / 2, y + height / 2, Width, height, r, g, b, a, 0)
end

local function DrawAdvancedText(x, y, w, h, sc, text, r, g, b, a, font, jus)
    SetTextFont(font)
    SetTextProportional(0)
    SetTextScale(sc, sc)
    SetTextJustification(jus)
    SetTextColour(r, g, b, a)
    SetTextDropShadow(0, 0, 0, 0, 255)
    SetTextEdge(1, 0, 0, 0, 255)
    SetTextDropShadow()
    BeginTextCommandDisplayText("STRING")
    AddTextComponentSubstringPlayerName(text)
    EndTextCommandDisplayText(x - 0.1 + w, y - 0.02 + h)
end

local function GetMinimapAnchor()
    local safezone_x = 1.0 / 20.0
    local safezone_y = 1.0 / 20.0
    local xscale = 1.0 / Screen_X
    local yscale = 1.0 / Screen_Y
    local Minimap = {}
    Minimap.Width = xscale * (Screen_X / (4 * Aspect_Ratio))
    Minimap.height = yscale * (Screen_Y / 5.674)
    Minimap.Left_x = xscale * (Screen_X * (safezone_x * ((math.abs(Safe_Zone - 1.0)) * 10)))
    Minimap.Bottom_y = 1.0 - yscale * (Screen_Y * (safezone_y * ((math.abs(Safe_Zone - 1.0)) * 10)))
    Minimap.right_x = Minimap.Left_x + Minimap.Width
    Minimap.top_y = Minimap.Bottom_y - Minimap.height
    Minimap.x = Minimap.Left_x
    Minimap.y = Minimap.top_y
    Minimap.xunit = xscale
    Minimap.yunit = yscale
    return Minimap
end

local function func_drawhealthui()
    local UI = GetMinimapAnchor()

    local HP = (GetEntityHealth(Client_Ped) - 100) / 100.0
    if HP < 0 then
        HP = 0.0
    elseif HP == 0.98 then
        HP = 1.0
    end

    local Armor = GetPedArmour(Client_Ped) / 100.0
    if Armor > 1.0 then
        Armor = 1.0
    end

    --drawRct(UI.Left_x, UI.Bottom_y - 0.017, UI.Width, 0.028, 0, 0, 0, 255) -- Black background
    drawRct(UI.Left_x + 0.001, UI.Bottom_y - 0.015, UI.Width - 0.002, 0.009, 88, 88, 88, 200) -- HP background
    drawRct(UI.Left_x + 0.001, UI.Bottom_y - 0.015, (UI.Width - 0.002) * HP, 0.009, 86, 215, 64, 200) -- HP bar
    drawRct(UI.Left_x + 0.001, UI.Bottom_y - 0.002, UI.Width - 0.002, 0.009, 88, 88, 88, 200) -- Armor background
    --DrawAdvancedText(0.20, 0.780, 0.005, 0.0028, 0.4, armourtexr,  255, 255, 255, 255, 6, 0)

    if IsPedSwimmingUnderWater(Client_Ped) then
        local Breath = GetPlayerUnderwaterTimeRemaining(PlayerId()) / 10.0
        if Breath >= 0.0 then
            drawRct(UI.Left_x + 0.001, UI.Bottom_y - 0.002, (UI.Width - 0.002) * Breath, 0.009, 243, 214, 102, 200)
        end
    elseif Armor > 0.0 then
        drawRct(UI.Left_x + 0.001, UI.Bottom_y - 0.002, (UI.Width - 0.002) * Armor, 0.009, 60, 79, 255, 200) -- Armor bar
    end
end

RegisterNetEvent("Nova:ToggleMoneyUI")
AddEventHandler("Nova:ToggleMoneyUI", function(flag)
    showhudUI(flag)
end)

RegisterNetEvent('Nova:Client:UpdateFinancial')
AddEventHandler("Nova:Client:UpdateFinancial", function(cash, bank)
    local moneyString = tostring(math.floor(cash))
    moneyDisplay = getMoneyStringFormatted(moneyString)

    local bankString = tostring(math.floor(bank))
    bankMoneyDisplay = getMoneyStringFormatted(bankString)
end)

local page_up_key = 10
local page_down_key = 11

RegisterKeyMapping('increaseproximity', 'increase voice chat proximity', 'keyboard', 'pageup')
RegisterCommand('increaseproximity', function()
    voiceChatProximity = voiceChatProximity + 1
    if voiceChatProximity > 3 then
        voiceChatProximity = 1
    end
    Set_Voice_Chat_Proximity()
end)

RegisterKeyMapping('decreaseproximity', 'decrease voice chat proximity', 'keyboard', 'pagedown')
RegisterCommand('decreaseproximity', function()
    voiceChatProximity = voiceChatProximity - 1
    if voiceChatProximity < 1 then
        voiceChatProximity = 3
    end
    Set_Voice_Chat_Proximity()
end)

Citizen.CreateThread(function()
    while true do
        Safe_Zone = GetSafeZoneSize()
        Screen_X, Screen_Y = GetActiveScreenResolution()
        Aspect_Ratio = GetAspectRatio(0)
        Client_Ped = PlayerPedId()

        if showHud then
            TriggerServerEvent("Nova:Server:UpdateFinancial")
        end

        Citizen.Wait(1000)
    end
end)

Citizen.CreateThread(function()
    while true do
        if showHud then
            local topLeftAnchor = getMinimapAnchor()
            updateHungerThirstHUD(
                "£" .. moneyDisplay,
                "£" .. bankMoneyDisplay,
                voiceChatProximity,
                topLeftAnchor[1] + topLeftAnchor[3],
                topLeftAnchor[2]
            )

            Citizen.Wait(200)
        else
            Citizen.Wait(1000)
        end
    end
end)

Citizen.CreateThread(function()
    local minimap = RequestScaleformMovie("minimap")
    SetBigmapActive(true, false)
    SetBigmapActive(false, false)

    while true do
        BeginScaleformMovieMethod(minimap, "SETUP_HEALTH_ARMOUR")
        ScaleformMovieMethodAddParamInt(3)
        EndScaleformMovieMethod()

        if showHud then
            func_drawhealthui()
        end

        --HideHudComponentThisFrame(9)
        --HideHudComponentThisFrame(7)

        if NetworkIsPlayerTalking(Client_Player) then
            SendNUIMessage({talking = true})
        end

        Citizen.Wait(1)
    end
end)