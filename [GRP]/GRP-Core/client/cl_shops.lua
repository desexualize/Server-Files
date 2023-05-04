RMenu.Add('ShopMenu', 'main', RageUI.CreateMenu("Shops", "Galaxy Shops", 1300, 50))
RMenu.Add("ShopMenu", "confirm", RageUI.CreateSubMenu(RMenu:Get('ShopMenu', 'main',  1300, 50)))

local currentDrop = nil
RageUI.CreateWhile(1.0, RMenu:Get('ShopMenu', 'main'), nil, function()

    RageUI.IsVisible(RMenu:Get('ShopMenu', 'main'), true, false, true, function()

        RageUI.Button("Morphine" , nil, {RightLabel = "£50,000"}, true, function(Hovered, Active, Selected)
            if Selected then
                currentDrop = 'morphine'
            end
        end, RMenu:Get("ShopMenu", "confirm"))

        RageUI.Button("Lockpick" , nil, {RightLabel = "£50,000"}, true, function(Hovered, Active, Selected)
            if Selected then
                currentDrop = 'lockpick'
            end
        end, RMenu:Get("ShopMenu", "confirm"))



    end, function()
       
    end)
end)

RageUI.CreateWhile(1.0, RMenu:Get("ShopMenu", "confirm"), nil, function()
    RageUI.IsVisible(RMenu:Get("ShopMenu", "confirm"), true, false, true, function()  
        RMenu:Get("ShopMenu", "confirm"):SetSubtitle("Are you sure?")
        RageUI.Button("Confirm" , nil, {RightLabel = ""}, true, function(Hovered, Active, Selected)
            if Selected then
                TriggerServerEvent('Galaxy:ShopBuy2', 0, currentDrop)
            end
        end, RMenu:Get("ShopMenu", "main"))
        RageUI.Button("Decline" , nil, {RightLabel = ""}, true, function(Hovered, Active, Selected)
            if Selected then
                
            end
        end, RMenu:Get("ShopMenu", "main"))
       

    end)
end)


coordShop = {
    {128.1410369873, -1286.1120605469, 29.281036376953},
    {-47.522762298584,-1756.85717773438,29.4210109710693},
    {25.7454013824463,-1345.26232910156,29.4970207214355}, 
    {1135.57678222656,-981.78125,46.4157981872559}, 
    {1163.53820800781,-323.541320800781,69.2050552368164}, 
    {374.190032958984,327.506713867188,103.566368103027}, 
    {2555.35766601563,382.16845703125,108.622947692871}, 
    {2676.76733398438,3281.57788085938,55.2411231994629}, 
    {1960.50793457031,3741.84008789063,32.3437385559082},
    {1393.23828125,3605.171875,34.9809303283691}, 
    {1166.18151855469,2709.35327148438,38.15771484375}, 
    {547.987609863281,2669.7568359375,42.1565132141113}, 
    {1698.30737304688,4924.37939453125,42.0636749267578}, 
    {1729.54443359375,6415.76513671875,35.0372200012207}, 
    {-3243.9013671875,1001.40405273438,12.8307056427002}, 
    {-2967.8818359375,390.78662109375,15.0433149337769}, 
    {-3041.17456054688,585.166198730469,7.90893363952637}, 
    {-1820.55725097656,792.770568847656,138.113250732422}, 
    {-1486.76574707031,-379.553985595703,40.163387298584}, 
    {-1223.18127441406,-907.385681152344,12.3263463973999}, 
    {-707.408996582031,-913.681701660156,19.2155857086182},
    {1984.9466552734,3051.6047363281,47.215072631836},
}

isInShops2 = false
currentAmmunition = nil
Citizen.CreateThread(function() 
    while true do
        for i , p in pairs(coordShop) do 
                local v1 = vector3(p[1], p[2], p[3])

                if isInArea(v1, 100.0) then 
                    DrawMarker(2, v1, 0, 0, 0, 0, 0, 0, 0.4, 0.4, 0.4, 94, 255, 0, 150, true, true, 0, 0, 0, 0, 0)
                end
                if isInShops2 == false then
                if isInArea(v1, 1.4) then 
                    alert('Press ~INPUT_VEH_HORN~ to open Shop Menu')
                    if IsControlJustPressed(0, 51) then 
                        currentAmmunition = k
                        RageUI.Visible(RMenu:Get("ShopMenu", "main"), true)
                        isInShops2 = true
                        currentAmmunition = k 
                    end
                end
                end
                if isInArea(v1, 1.4) == false and isInShops2 and k == currentAmmunition then
                    
                   
                    isInShops2 = false
                    currentAmmunition = nil
                end
                
            end
       
        Citizen.Wait(0)
    end
end)


Citizen.CreateThread(function()
    for i , p in pairs(coordShop) do 
        blip = AddBlipForCoord(p[1], p[2], p[3])
        SetBlipSprite(blip, 59)
        SetBlipScale(blip, 0.6)
        SetBlipDisplay(blip, 2)
        SetBlipColour(blip, 2)
        SetBlipAsShortRange(blip, true)
        BeginTextCommandSetBlipName("STRING")
        AddTextComponentString("Shops")
        EndTextCommandSetBlipName(blip)
    end
end)


function isInArea(v, dis) 
    
    if #(GetEntityCoords(PlayerPedId(-1)) - v) <= dis then  
        return true
    else 
        return false
    end
end

function alert(msg) 
    SetTextComponentFormat("STRING")
    AddTextComponentString(msg)
    DisplayHelpTextFromStringLabel(0,0,1,-1)
end



function notify(string)
    SetNotificationTextEntry("STRING")
    AddTextComponentString(string)
    DrawNotification(true, false)
end


