------------------------------------------------------------------
--                          Variables
------------------------------------------------------------------

local showHud = true                          -- Boolean to show / hide HUD
local hunger = 100                              -- Init hunger's variable. Set to 100 for development. 
local thirst = 100                              -- Init thirst's variable. Set to 100 for development. 
local showNo = false
local moneyDisplay = 0





function getMoneyStringFormatted(chipsString)
	local i, j, minus, int, fraction = tostring(chipsString):find('([-]?)(%d+)([.]?%d*)')
	int = int:reverse():gsub("(%d%d%d)", "%1,")
	return minus .. int:reverse():gsub("^,", "") .. fraction 
end

function updateHungerThirstHUD(chips,topLeftAnchor,yAnchor)
  SendNUIMessage({
    update = true,
    chips = chips,

    topLeftAnchor = topLeftAnchor,
    yAnchor = yAnchor,
  })
end

function showhudUI(flag)
    SendNUIMessage({
        showhud = flag
    })
end

RegisterNetEvent("ERP-Client:UI2:Toggle")
AddEventHandler("ERP-Client:UI2:Toggle", function(toggle)
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

RegisterNetEvent("chips:setDisplayMoney")
AddEventHandler("chips:setDisplayMoney",function(value)
	local moneyString = tostring(math.floor(value))
	moneyDisplay = getMoneyStringFormatted(moneyString)
end)



Citizen.CreateThread(function()
    while true do
        if showHud then
            TriggerServerEvent('update:chips')
        end
        Citizen.Wait(500)
    end
end)

Citizen.CreateThread(function()
    while true do
        if showHud then
            local topLeftAnchor = getMinimapAnchor()
            updateHungerThirstHUD("" .. moneyDisplay,topLeftAnchor[1]+topLeftAnchor[3],topLeftAnchor[2])
        end
        Citizen.Wait(500)
    end
end)



