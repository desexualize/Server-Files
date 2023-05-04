prefix = '^1[AQUA]^7 '

AQUATips = 
{ 
    prefix.."You can view your Licenses by pressing (F6)",
    prefix.."The redzones located on the map are KOS",
    prefix.."You can point with (B)",
    prefix.."You can access your inventory with (L)",
    prefix.."You can lock your vehicle using (,)",    
    prefix.."Use /ooc or // to ask out of character questions",
    prefix.."To call an admin, type /calladmin",
    prefix.."You can lock your car with the comma key",
    prefix.."If you are experiencing texture loss set your Texture Quality to Normal in graphics settings!",
    prefix.."Press (F10) to see your past punishments",
    prefix.."For vehicle functions press (M)",
    prefix.."If you need support with anything do /calladmin",
    prefix.."To support AQUA, head over to the #store channel in the discord",
}


Citizen.CreateThread(function()
    Wait(100000)
    while true do
        math.randomseed(GetGameTimer())
        num = math.random(1,#AQUATips)
        TriggerEvent('chatMessage',"", {255, 51, 51}, "" .. AQUATips[num], "ooc")
        Wait(600000)
    end
end)
