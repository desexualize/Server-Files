local distanceTolicensetpEntrance = 1000
local licensetpEntranceVector = vector3(-532.15393066406,-229.26022338867,36.701904296875)

RMenu.Add('telport', 'license', RageUI.CreateMenu("", "",GetRageUIMenuWidth(),GetRageUIMenuHeight(),"banners", "dealership"))
RMenu:Get('telport', 'license'):SetSubtitle("~d~ENTER")

function showlicensetpEnter(flag)
    RageUI.Visible(RMenu:Get('telport', 'license'), flag)
end

RageUI.CreateWhile(1.0, RMenu:Get('telport', 'license'), nil, function()
    RageUI.IsVisible(RMenu:Get('telport', 'license'), true, false, true, function()

        RageUI.ButtonWithStyle("Teleport to Dealership", "",{ RightLabel = "→→→" }, true, function(Hovered, Active, Selected)
            if (Hovered) then

            end
            if (Active) then

            end
            if (Selected) then
                SetEntityCoords(PlayerPedId(),-59.700553894043,-1110.3859863281,26.438041687012)
                RageUI.ActuallyCloseAll()
            end
        end)

    end)
end)


Citizen.CreateThread(function()
    while true do 
        if distanceTolicensetpEntrance < 1.5  then 
            showlicensetpEnter(true)
        elseif distanceTolicensetpEntrance < 2.5 then 
            showlicensetpEnter(false)
        end
        DrawMarker(27, licensetpEntranceVector.x, licensetpEntranceVector.y, licensetpEntranceVector.z-1.0, 0, 0, 0, 0, 0, 0, 1.001, 1.0001, 0.5001, 255,255,255, 200, 0, 0, 0, 0)
        Wait(0)
    end
end)

Citizen.CreateThread(function()
    while true do 
        local playerCoords = GetEntityCoords(PlayerPedId())
        distanceTolicensetpEntrance = #(playerCoords-licensetpEntranceVector)
        Wait(100)
    end
end)

Citizen.CreateThread(function()
    local parachuteped = GetHashKey("u_m_m_streetart_01")
    RequestModel(parachuteped)
    while not HasModelLoaded(parachuteped) do
        Wait(0)
    end
    RequestAnimDict("mini@strip_club@idles@bouncer@base")
    while not HasAnimDictLoaded("mini@strip_club@idles@bouncer@base") do
      Wait(1)
    end
  
    local parachuteentity = CreatePed(26,parachuteped,-531.51062011719,-230.337890625,36.702201843262-1.0,10,false,true)
    SetModelAsNoLongerNeeded(parachuteped)     
    SetEntityCanBeDamaged(parachuteentity, 0)
    SetPedAsEnemy(parachuteentity, 0)   
    SetBlockingOfNonTemporaryEvents(parachuteentity, 1)
    SetPedResetFlag(parachuteentity, 249, 1)
    SetPedConfigFlag(parachuteentity, 185, true)
    SetPedConfigFlag(parachuteentity, 108, true)
    SetEntityInvincible(parachuteentity, true)
    SetEntityCanBeDamaged(parachuteentity, false)
    SetPedCanEvasiveDive(parachuteentity, 0)
    SetPedCanRagdollFromPlayerImpact(parachuteentity, 0)
    SetPedConfigFlag(parachuteentity, 208, true)       
    FreezeEntityPosition(parachuteentity, true)
    TaskPlayAnim(parachuteentity,"mini@strip_club@idles@bouncer@base","base", 8.0, 0.0, -1, 1, 0, 0, 0, 0)  while true do
      Citizen.Wait(500)
    end
  end)