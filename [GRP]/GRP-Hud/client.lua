local cashDisplay = 0
local bankDisplay = 0
local permDisplay = 0

function getMoneyStringFormatted(cashString)
	local i, j, minus, int, fraction = tostring(cashString):find('([-]?)(%d+)([.]?%d*)')
	int = int:reverse():gsub("(%d%d%d)", "%1,")
	return minus .. int:reverse():gsub("^,", "") .. fraction 
end

RegisterNetEvent("Galaxy:CashBankClient")
AddEventHandler("Galaxy:CashBankClient",function(bank,cash,userid)
	local cashString = tostring(math.floor(cash))
  local bankString = tostring(math.floor(bank))
	cashDisplay = getMoneyStringFormatted(cashString)
  bankDisplay = getMoneyStringFormatted(bankString)
  permDisplay = userid
end)

local playername = "Player"
local armour = "100"
local healt = "200"
local showhud = true
Citizen.CreateThread(function()
    while true do
        Citizen.Wait(1000)
        local topLeftAnchor = getMinimapAnchor()
        if showhud then
    
          SendNUIMessage({
              action = "show",
              armor = armour,
              health = healt,
              cash = "£"..cashDisplay,
              bank = "£"..bankDisplay,
              name = permDisplay.." | "..playername,
              topLeftAnchor = topLeftAnchor[1]+topLeftAnchor[3],
              yAnchor = topLeftAnchor[2],
          })
          DisplayRadar(true)
        elseif not showhud then 
          SendNUIMessage({
            action = "hide",
            armor = armour,
            health = healt,
            cash = "£"..cashDisplay,
            bank = "£"..bankDisplay,
            name = playername,
            topLeftAnchor = topLeftAnchor[1]+topLeftAnchor[3],
            yAnchor = topLeftAnchor[2],
            
        })
        DisplayRadar(false)
        end
    end
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

local function GetMinimapAnchor()
  local safezone = GetSafeZoneSize()
  local safezone_x = 1.0 / 20.0
  local safezone_y = 1.0 / 20.0
  local aspect_ratio = GetAspectRatio(0)
  local res_x, res_y = GetActiveScreenResolution()
  local xscale = 1.0 / res_x
  local yscale = 1.0 / res_y
  local Minimap = {}
  Minimap.Width = xscale * (res_x / (4 * aspect_ratio))
  Minimap.height = yscale * (res_y / 5.674)
  Minimap.Left_x = xscale * (res_x * (safezone_x * ((math.abs(safezone - 1.0)) * 10)))
  Minimap.Bottom_y = 1.0 - yscale * (res_y * (safezone_y * ((math.abs(safezone - 1.0)) * 10)))
  Minimap.right_x = Minimap.Left_x + Minimap.Width
  Minimap.top_y = Minimap.Bottom_y - Minimap.height
  Minimap.x = Minimap.Left_x
  Minimap.y = Minimap.top_y
  Minimap.xunit = xscale
  Minimap.yunit = yscale
  return Minimap
end


RegisterCommand('showhud',function()
  if showhud then
    showhud = false
  elseif not showhud then
    showhud = true
  end
end)

RegisterNetEvent("Galaxy:ReturnShowHUD")
AddEventHandler("Galaxy:ReturnShowHUD",function()
  if showhud then
    showhud = false
  elseif not showhud then
    showhud = true
  end
end)

Citizen.CreateThread(function()
  local minimap = RequestScaleformMovie("minimap")
  SetBigmapActive(true, false)
  Wait(0)
  SetBigmapActive(false, false)
  while true do
      Wait(0)
      BeginScaleformMovieMethod(minimap, "SETUP_HEALTH_ARMOUR")
      ScaleformMovieMethodAddParamInt(3)
      EndScaleformMovieMethod()
  end
end)

RegisterNetEvent("Galaxy:ReturnShowHUD")
AddEventHandler("Galaxy:ReturnShowHUD",function()
  if showhud then
    showhud = false
  elseif not showhud then
    showhud = true
  end
end)

Citizen.CreateThread(function()
  while true do
      TriggerServerEvent('Galaxy:BankCash')
      playername = GetPlayerName(PlayerId())
      armour = GetPedArmour(GetPlayerPed(-1))
      healt = (GetEntityHealth(GetPlayerPed(-1))-100)
      Citizen.Wait(600)
  end
end)

