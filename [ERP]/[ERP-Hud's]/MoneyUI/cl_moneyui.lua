------------------------------------------------------------------
--                          Variables
------------------------------------------------------------------

local showHud = true                          -- Boolean to show / hide HUD
local hunger = 100                              -- Init hunger's variable. Set to 100 for development. 
local thirst = 100                              -- Init thirst's variable. Set to 100 for development. 
local showNo = false
local moneyDisplay = 0
local bankMoneyDisplay = 0
local voiceChatProximity = 2
proximityIdToString = {
    [1] = "Whisper",
    [2] = "Talking",
    [3] = "Shouting",
}
prox = 35.01

function setProximity(vprox)
    if vprox == 1 then
        prox = 5.01
    elseif vprox == 2 then
        prox = 15.01
    elseif vprox == 3 then
        prox = 35.01
    end
end

function getMoneyStringFormatted(cashString)
	local i, j, minus, int, fraction = tostring(cashString):find('([-]?)(%d+)([.]?%d*)')
	int = int:reverse():gsub("(%d%d%d)", "%1,")
	return minus .. int:reverse():gsub("^,", "") .. fraction 
end

function updateHungerThirstHUD(cash, bank, proximity, topLeftAnchor,yAnchor)
  SendNUIMessage({
    update = true,
    cash = cash,
    bank = bank,
    proximity = proximityIdToString[proximity],
    topLeftAnchor = topLeftAnchor,
    yAnchor = yAnchor,
  })
end

function showhudUI(flag)
    SendNUIMessage({
        showhud = flag
    })
end

RegisterNetEvent("ERP-Client:UI:Toggle")
AddEventHandler("ERP-Client:UI:Toggle", function(toggle)
    showhudUI(toggle)
end)

function getMinimapAnchor()
    SetScriptGfxAlign(string.byte('L'), string.byte('B'))
    local minimapTopX, minimapTopY = GetScriptGfxPosition(-0.0045, 0.002 + (-0.188888))
    ResetScriptGfxAlign()
    local w, h = GetActiveScreenResolution()
    local aspect_ratio = GetAspectRatio(0)
    local xscale = 1.0 / w
    local yscale = 1.0 / h
    local Minimap = {}
    local width = xscale * (w / (4 * aspect_ratio))
    return { w * 2 * minimapTopX, (h * minimapTopY)+((width*0.61)*h), width * w}
end

RegisterNetEvent("cash:setDisplayMoney")
AddEventHandler("cash:setDisplayMoney",function(value)
	local moneyString = tostring(math.floor(value))
	moneyDisplay = getMoneyStringFormatted(moneyString)
end)

RegisterNetEvent("bank:setDisplayBankMoney")
AddEventHandler("bank:setDisplayBankMoney",function(value)
	local moneyString = tostring(math.floor(value))
	bankMoneyDisplay = getMoneyStringFormatted(moneyString)
end)

Citizen.CreateThread(function()
    while true do
        if showHud then
            TriggerServerEvent('update:bank')
            TriggerServerEvent('update:cash')
        end
        Citizen.Wait(500)
    end
end)

Citizen.CreateThread(function()
    while true do
        if showHud then
            local topLeftAnchor = getMinimapAnchor()
            updateHungerThirstHUD("£" .. moneyDisplay, "£" .. bankMoneyDisplay,voiceChatProximity,topLeftAnchor[1]+topLeftAnchor[3],topLeftAnchor[2])
        end
        Citizen.Wait(500)
    end
end)

Citizen.CreateThread(function()
    while true do
        NetworkSetTalkerProximity(prox)
        NetworkSetVoiceActive(true)
        HideHudComponentThisFrame(9)
        HideHudComponentThisFrame(7)
        if NetworkIsPlayerTalking(PlayerId()) then
            SendNUIMessage({
                talking = true
            })
        end
		Wait(60)
    end
end)

Citizen.CreateThread(function()
	voiceChatProximity = 2
	while true do
		if IsControlPressed(0, 10) then
			if voiceChatProximity ~= 3 then
				voiceChatProximity = voiceChatProximity + 1
				setProximity(voiceChatProximity)
				Wait(250)
			end
		end
		if IsControlPressed(0, 11) then
			if voiceChatProximity ~= 1 then
				voiceChatProximity = voiceChatProximity - 1
				setProximity(voiceChatProximity)
				Wait(250)
			end
		end
		Wait(0)
	end	
end)
