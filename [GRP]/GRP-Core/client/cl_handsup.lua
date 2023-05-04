local handsup = false
CreateThread(function()
    RequestAnimDict('mp_arresting')
    RequestAnimDict('random@arrests')
    RequestAnimDict('missminuteman_1ig_2')

    while true do
        if IsControlPressed(1, 323) then
            DisablePlayerFiring(GetPlayerPed(-1), true)

            DisableControlAction(0, 22, true)
            DisableControlAction(0, 25, true)

            if not IsEntityDead(GetPlayerPed(-1)) then
                if not handsup then
                    handsup = true
              
                    TaskPlayAnim(GetPlayerPed(-1), 'missminuteman_1ig_2', 'handsup_enter', 7.0, 1.0, -1, 50, 0, false, false, false)
                end
            end
        end


        if IsControlReleased(1, 323) and handsup then
            handsup = false

            CreateThread(function()
                local enableFiring = false

                CreateThread(function()
                    Wait(1000)

                    enableFiring = true
                end)

                while not enableFiring do
                    DisablePlayerFiring(GetPlayerPed(-1), true)

                    Wait(1)
                end
            end)

            DisableControlAction(0, 21, true)
            DisableControlAction(0, 137, true)

            ClearPedTasks(GetPlayerPed(-1))
        end

        Wait(1)
    end
end)
