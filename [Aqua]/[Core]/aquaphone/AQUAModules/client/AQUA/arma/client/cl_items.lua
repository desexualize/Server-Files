local a=false
local b=false
RegisterNetEvent("ARMA:applyMorphine")
AddEventHandler("ARMA:applyMorphine",function()
    if not a then 
        a=true
        local c="mp_suicide"
        local d="pill"
        tARMA.loadAnimDict(c)
        TaskPlayAnim(tARMA.getPlayerPed(),c,d,2.0,2.0,2500,48,1,9,false,false,false)
        Wait(2500)
        local e=0
        while e<=100 do 
            if GetEntityHealth(PlayerPedId())<=200 and GetEntityHealth(PlayerPedId())>102 then 
                tARMA.varyHealth(1)
            end
            e=e+1
            Wait(250)
        end
        a=false 
    else 
        tARMA.notify("~r~Fuck, I don't feel too good...")
        local c="mp_suicide"
        local d="pill"
        tARMA.loadAnimDict(c)
        TaskPlayAnim(tARMA.getPlayerPed(),c,d,2.0,2.0,2500,48,1,9,false,false,false)
        Wait(2500)
        tARMA.playScreenEffect("DrugsMichaelAliensFight",30)
        local e=0
        while e<=100 do 
            if GetEntityHealth(PlayerPedId())>102 then 
                tARMA.varyHealth(-2)
            end
            e=e+1
            Wait(250)
        end 
    end 
end)
RegisterNetEvent("ARMA:eatTaco")
AddEventHandler("ARMA:eatTaco",function()
    if not b then 
        b=true
        local f={{"mp_player_inteat@burger","mp_player_int_eat_burger_enter",1},{"mp_player_inteat@burger","mp_player_int_eat_burger",1},{"mp_player_inteat@burger","mp_player_int_eat_burger_fp",1},{"mp_player_inteat@burger","mp_player_int_eat_exit_burger",1}}
        tARMA.playAnim(true,f,false)
        Wait(2500)
        local e=0
        while e<=25 do 
            if GetEntityHealth(PlayerPedId())<=200 and GetEntityHealth(PlayerPedId())>102 then 
                tARMA.varyHealth(1)
            end
            e=e+1
            Wait(125)
        end
        b=false 
    else 
        tARMA.notify("~r~You dropped the taco on the floor trying to stuff it in your mouth!")
    end 
end)