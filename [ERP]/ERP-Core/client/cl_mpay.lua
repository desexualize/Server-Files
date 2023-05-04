RMenu.Add('MPayMenu', 'main', RageUI.CreateMenu("", "~w~MPay Menu", 1300, 100, "mpay", "mpay"))
RMenu.Add('MPayMenu', 'confirmation', RageUI.CreateSubMenu(RMenu:Get('MPayMenu','main'), "", "~w~MPay Confirmation Menu", nil, nil))

local MPayAmount = 0
local finalMPayAmount = 0
local playerID = 0
local finalPlayerID = 0
local enteredMoney = false 
local enteredID = false

RageUI.CreateWhile(1.0, RMenu:Get('MPayMenu', 'main'), nil, function()
    RageUI.IsVisible(RMenu:Get('MPayMenu', 'main'), true, false, true,function()

        RageUI.Button("Transaction Amount - ~g~[ £" .. MPayAmount .. " ]", nil, { RightLabel = "→→→" }, true, function(Hovered, Active, Selected)
            if Selected then

                getAmount2()
                if MPayAmount == tostring(tonumber(MPayAmount)) then
                    notify("~g~You have placed a Transaction of: ~w~£" .. MPayAmount .. "~g~.")
                    enteredMoney = true
                    finalMPayAmount = MPayAmount
                else
                    notify("~r~The value you entered is not a number!")
                end
                
            end
        end)

        RageUI.Button("Receivers perm ID - ~g~[ " .. finalPlayerID .. " ]", nil, { RightLabel = "→→→" }, true, function(Hovered, Active, Selected)
            if Selected then

                getPermID()
                if playerID  == tostring(tonumber(playerID)) then
                    notify("~g~You have added ID ~w~" .. playerID .. " ~g~to your transaction!")
                    enteredID = true
                    finalPlayerID = playerID
                else
                    notify("~r~The value you entered is not a number!")
                end
                
            end
        end)


        if enteredID == true and enteredMoney == true then
            RageUI.Button("~g~[Confirm MPay Transaction]", "~g~Receivers ID: ~w~" .. playerID .. ", ~g~Transaction Amount: ~w~£" .. MPayAmount, { RightLabel = "→→→" }, true, function(Hovered, Active, Selected)
                if Selected then 
                
                end
            end, RMenu:Get('MPayMenu','confirmation'))
        end
    end)
        

    RageUI.IsVisible(RMenu:Get('MPayMenu', 'confirmation'), true, false, true, function()

        RageUI.Button("~g~Yes, I confirm this Transaction!", nil, { RightLabel = "→→→" }, true, function(Hovered, Active, Selected)
            if Selected then

                -- notify("~g~You confirmed a Transaction, to the ID: ~w~" .. playerID .. " ~g~for ~w~£" .. MPayAmount)
                TriggerServerEvent("ERP:SendPayment", finalPlayerID, finalMPayAmount)
                RageUI.Visible(RMenu:Get("MPayMenu", "confirmation"), false)    

                enteredID = false 
                enteredMoney = false

                finalPlayerID = 0
                finalMPayAmount = 0
                MPayAmount = 0
          
            end
        end)

        RageUI.Button("~r~No, I don't confirm this Transaction!", nil, { RightLabel = "→→→" }, true, function(Hovered, Active, Selected)
            if Selected then

               notify("~r~You have cancelled this Transaction!") 
               RageUI.Visible(RMenu:Get("MPayMenu", "confirmation"), false)    

               enteredID = false 
               enteredMoney = false

               finalPlayerID = 0
               finalMPayAmount = 0
                
            end
        end)


    end)
        
end, function()

end)

RegisterCommand("mpay", function()
    RageUI.Visible(RMenu:Get("MPayMenu", "main"), true)      
    inMPayMenu = true
end)

RegisterKeyMapping("mpay", "Mpay Menu", "keyboard", "kf")
                
function getAmount2()
    
	AddTextEntry('FMMC_KEY_TIP8', "Enter the Amount you would like to send!")
	DisplayOnscreenKeyboard(1, "FMMC_KEY_TIP8", "Enter Amount (Blank to Cancel)", "", "", "", "", 30)
    while (UpdateOnscreenKeyboard() == 0) do
        DisableAllControlActions(0);
        Wait(0);
    end
    if (GetOnscreenKeyboardResult()) then
        local result = GetOnscreenKeyboardResult()
		if result then
            MPayAmount = result
			return result
		end
    end
	return false

end

function getPermID()
    
	AddTextEntry('FMMC_KEY_TIP8', "Enter the receivers perm ID!")
	DisplayOnscreenKeyboard(1, "FMMC_KEY_TIP8", "Enter Amount (Blank to Cancel)", "", "", "", "", 30)
    while (UpdateOnscreenKeyboard() == 0) do
        DisableAllControlActions(0);
        Wait(0);
    end
    if (GetOnscreenKeyboardResult()) then
        local resultID = GetOnscreenKeyboardResult()
		if  resultID then
            playerID = resultID
			return resultID
		end
    end
	return false

end

function notify(string)
    SetNotificationTextEntry("STRING")
    AddTextComponentString(string)
    DrawNotification(true, false)
end

RegisterCommand("mpay", function()
    RageUI.Visible(RMenu:Get("MPayMenu", "main"), true)      
    inMPayMenu = true
end)
























