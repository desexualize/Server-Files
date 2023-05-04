insideDiamondCasino = false
AddEventHandler("ARMA:onClientSpawn",function(a, b)
    if b then
        local c = vector3(1121.7922363281, 239.42251586914, -50.440742492676)
        local d = function(e)
            insideDiamondCasino = true
            tARMA.setCanAnim(false)
            tARMA.overrideTime(12, 0, 0)
            TriggerEvent("ARMA:enteredDiamondCasino")
            TriggerServerEvent('ARMA:getChips')
        end
        local f = function(e)
            insideDiamondCasino = false
            tARMA.setCanAnim(true)
            tARMA.cancelOverrideTimeWeather()
            TriggerEvent("ARMA:exitedDiamondCasino")
        end
        local g = function(e)
        end
        tARMA.createArea("diamondcasino", c, 100.0, 20, d, f, g, {})
    end
end)
