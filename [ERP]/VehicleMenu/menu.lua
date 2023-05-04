-----------------------------------------------------------
----             Vehicle Options menu                  ----
----             Made by Tamir112#5345                 ----
----        For more scripts and updates Join:         ----
----              discord.gg/bDPaRDeBKJ                ----
----                                                   ----
-----------------------------------------------------------


-- default keybind is F3, to choose a different one get the ID you want from https://docs.fivem.net/docs/game-references/controls/
-- To disable the keybind set it to 360
local keybind = 170
local command = "carmenu" -- if you ever want to change the command



-- DO NOT EDIT BELOW THIS IF YOU DO NOT KNOW WHAT YOU ARE DOING !! -- 
-- DO NOT EDIT BELOW THIS IF YOU DO NOT KNOW WHAT YOU ARE DOING !! -- 
-- DO NOT EDIT BELOW THIS IF YOU DO NOT KNOW WHAT YOU ARE DOING !! -- 
-- DO NOT EDIT BELOW THIS IF YOU DO NOT KNOW WHAT YOU ARE DOING !! -- 

local cooldown = false

Citizen.CreateThread(function ()
  while true do
       Citizen.Wait(0)
       if cooldown == true then
       Citizen.Wait(5000)
cooldown = false
       end
  end
end)

_menuPool = NativeUI.CreatePool()
mainMenu = NativeUI.CreateMenu("", "~b~Vehicle options menu", 1430, 0)
_menuPool:Add(mainMenu)
mainMenu.SetMenuWidthOffset(50);

function seatrs(menu)
  local seats = _menuPool:AddSubMenu(menu, "Vehicle seats", "Change vehicle seats",1420,0)
  local ped = GetPlayerPed(-1)
  local veh = GetVehiclePedIsIn(ped)
  local hash = GetEntityModel(veh)
  local max = GetVehicleModelNumberOfSeats(hash)


  if max >= 4 then
local dr = NativeUI.CreateItem("Driver Seat", "move into the Driver seat")
local pass = NativeUI.CreateItem("Passanger Seat", "move into the Passanger seat")
local rl = NativeUI.CreateItem("Rear left seat", "move into the Rear left seat")
local rr = NativeUI.CreateItem("Rear right seat", "move into the Rear right seat")
seats:AddItem(dr)
seats:AddItem(pass)
seats:AddItem(rl)
seats:AddItem(rr)

  
seats.OnItemSelect = function(sender, item, index)
  if item == dr then
  TaskWarpPedIntoVehicle(ped, veh, -1)
end
if item == pass then
  TaskWarpPedIntoVehicle(ped, veh, 0)

end
if item == rl then
  TaskWarpPedIntoVehicle(ped, veh, 1)
end
if item == rr then
  TaskWarpPedIntoVehicle(ped, veh, 2)
end
end

else if max < 4 then
  local dr = NativeUI.CreateItem("Driver Seat", "move into the Driver seat")
  local pass = NativeUI.CreateItem("Passanger Seat", "move into the Passanger seat")
  seats:AddItem(dr)
  seats:AddItem(pass)
  seats.OnItemSelect = function(sender, item, index)
        if item == dr then
      TaskWarpPedIntoVehicle(ped, veh, -1)
    end
    if item == pass then
    TaskWarpPedIntoVehicle(ped, veh, 0)
    print("test")

  end
end
end
end
end


function doors(menu)
  local doors = _menuPool:AddSubMenu(menu, "Door options","Manage the vehicles doors",1420,0)
local frontleft = NativeUI.CreateItem("Front Left Door", "Open Front Left Door")
local frontright = NativeUI.CreateItem("Front Right Door", "Open Front Right Door")
local backLeft = NativeUI.CreateItem("Back Left Door", "Open Back Left Door")
local backright = NativeUI.CreateItem("Back Right Door", "Open Back Right Door")
local trunk = NativeUI.CreateItem("Trunk", "Open trunk")
local hood = NativeUI.CreateItem("Hood", "Open hood")


doors:AddItem(frontleft)
doors:AddItem(frontright)
doors:AddItem(backLeft)
doors:AddItem(backright)
doors:AddItem(trunk)
doors:AddItem(hood)




doors.OnItemSelect = function(sender, item, index)

if item == frontleft then
local ped = GetPlayerPed(-1)
local veh = GetVehiclePedIsIn(ped, false)
local isopen = GetVehicleDoorAngleRatio(veh,0)


if isopen  == 0 then
SetVehicleDoorOpen(veh, 0, false, false )
else 
  SetVehicleDoorShut(veh, 0, false)
end
end

if item == frontright then
  local ped = GetPlayerPed(-1)
  local veh = GetVehiclePedIsIn(ped, false)
  local isopen = GetVehicleDoorAngleRatio(veh,1)
  
  
  if isopen  == 0 then
  SetVehicleDoorOpen(veh, 1, false, false )
  else 
  SetVehicleDoorShut(veh, 1, false)
  end
  end
  if item == backLeft then
    local ped = GetPlayerPed(-1)
    local veh = GetVehiclePedIsIn(ped, false)
    local isopen = GetVehicleDoorAngleRatio(veh,2)
    
    
    if isopen  == 0 then
    SetVehicleDoorOpen(veh, 2, false, false )
    else 
    SetVehicleDoorShut(veh, 2, false)
    end
    end

    if item == backright then
      local ped = GetPlayerPed(-1)
      local veh = GetVehiclePedIsIn(ped, false)
      local isopen = GetVehicleDoorAngleRatio(veh,3)
      
      
      if isopen  == 0 then
      SetVehicleDoorOpen(veh, 3, false, false )
      else 
      SetVehicleDoorShut(veh, 3, false)
      end
      end
  
if item == trunk then
  local ped = GetPlayerPed(-1)
  local veh = GetVehiclePedIsIn(ped, false)
  local isopen = GetVehicleDoorAngleRatio(veh,5)
  
  
  if isopen  == 0 then
  SetVehicleDoorOpen(veh, 5, false, false )
  else 
  SetVehicleDoorShut(veh, 5, false)
  end
  end

  if item == hood then
    local ped = GetPlayerPed(-1)
    local veh = GetVehiclePedIsIn(ped, false)
    local isopen = GetVehicleDoorAngleRatio(veh,4)
    
    
    if isopen  == 0 then
    SetVehicleDoorOpen(veh, 4, false, false )
    else 
    SetVehicleDoorShut(veh, 4, false)
    end
    end
  

end
end



function windows(menu)
local windows = _menuPool:AddSubMenu(menu, "Window options","Manage vehicles windows",1420,0)
local frontup = NativeUI.CreateItem("Front Windows Down", "Roll Down The Front Windows")
local frontdown = NativeUI.CreateItem("Front Windows Up", "Roll Up The Front Windows")
local backtup = NativeUI.CreateItem("Back Windows Down", "Roll Down The Back Windows")
local backdown = NativeUI.CreateItem("Back Windows Up", "Roll Up The Back Windows")


windows:AddItem(frontup)
windows:AddItem(frontdown)
windows:AddItem(backtup)
windows:AddItem(backdown)
windows.OnItemSelect = function(sender, item, index)

if item == frontup then
  local ped = GetPlayerPed(-1)
  local veh = GetVehiclePedIsIn(ped, false)
  RollDownWindow(veh, 0)
  RollDownWindow(veh,1)
  ShowNotification("~g~Front Windows Rolled Down")
end

if item == frontdown then
  local ped = GetPlayerPed(-1)
  local veh = GetVehiclePedIsIn(ped, false)
  RollUpWindow(veh, 0)
  RollUpWindow(veh, 1)
  ShowNotification("~r~Front Windows Rolled Up")
end

if item == backdown then
  local ped = GetPlayerPed(-1)
  local veh = GetVehiclePedIsIn(ped, false)
  RollUpWindow(veh, 2)
  RollUpWindow(veh, 3)
  ShowNotification("~r~Back Windows Rolled Up")
end

if item == backtup then
  local ped = GetPlayerPed(-1)
  local veh = GetVehiclePedIsIn(ped, false)
  RollDownWindow(veh, 2)
  RollDownWindow(veh, 3)
  ShowNotification("~g~Back Windows Rolled Down")
end
end
end

function Extras(menu)
  local extras = _menuPool:AddSubMenu(menu, "Vehicle Extras","Manage the vehicles extras",1420,0)
  local AvailableExtras = {['VehicleExtras'] = {}}
  local Items = {['Vehicle'] = {}}
  local Vehicle = GetVehiclePedIsIn(PlayerPedId(), false)
  local GotVehicleExtras = false
  for ExtraID = 0, 20 do
          if DoesExtraExist(Vehicle, ExtraID) then
                  AvailableExtras.VehicleExtras[ExtraID] = (IsVehicleExtraTurnedOn(Vehicle, ExtraID) == 1)
                  GotVehicleExtras = true
          end
  end
  if GotVehicleExtras then

          for Key, Value in pairs(AvailableExtras.VehicleExtras) do
                  local ExtraItem = NativeUI.CreateCheckboxItem('Extra ' .. Key, AvailableExtras.VehicleExtras[Key],"Enable or Disable Extras")
                  extras:AddItem(ExtraItem)
                  Items.Vehicle[Key] = ExtraItem
          end
          extras.OnCheckboxChange = function(Sender, Item, Checked)
                  for Key, Value in pairs(Items.Vehicle) do
                          if Item == Value then
                                  AvailableExtras.VehicleExtras[Key] = Checked
                                  if AvailableExtras.VehicleExtras[Key] then
                                          SetVehicleExtra(Vehicle, Key, 0)
                                  else
                                          SetVehicleExtra(Vehicle, Key, 1)
                                  end
                          end
                  end
          end
        else 
          local ExtraItem = NativeUI.CreateItem("This vehicle has no extras to add :(","")
          extras:AddItem(ExtraItem)
end
end


function liverys(menu)
  local livery = _menuPool:AddSubMenu(menu, "Liverys","Change your livery",1420,0)
local veh = GetVehiclePedIsIn(GetPlayerPed(-1))
local liverycount = GetVehicleLiveryCount(veh)
if liverycount > 0 then
  local liverys2 = {}
  local s = 1
  for i=1, liverycount do
table.insert(liverys2, s, i )
end
 local liverys = NativeUI.CreateListItem("Livery number",liverys2, 1 )

 livery:AddItem(liverys)

 livery.OnListChange = function(sender, item, index)
  if item == liverys then
    liv = item:IndexToItem(index)
  SetVehicleLivery(veh, liv)
  end
  end

else
  local non = NativeUI.CreateItem("This vehicle has no liverys to choose from :(","")
  livery:AddItem(non)
end


end


function licenses(menu)
local license = _menuPool:AddSubMenu(menu, "Manage License Plate", "manage your vehicles license plate", 1420 , 0)
local change = NativeUI.CreateItem("Random license plate", "Stole a vehicle? set a different license.")
local set = NativeUI.CreateItem("Customize your license plate", "set a custom license plate of your choise")
local let = {
"K",
"L",
"Q",
"R",
"Z",
"N"
}

license:AddItem(change)
license:AddItem(set)
license.OnItemSelect = function(sender, item, index)
  if item == change  then
    if cooldown == false then
    local ped = GetPlayerPed(-1)
    local veh = GetVehiclePedIsIn(ped, false)
a = math.random(1, 9)
b = math.random(1, 9)
c = math.random(1, 9)
d = math.random(1, 9)
e = math.random(1, 9)



test1 = math.random(1, 6)
test = math.random(1, 6)
test2 = math.random(1, 6)
local plate =  a..b..let[test]..c..let[test1]..d..e..let[test2]

    SetVehicleNumberPlateText(veh, plate)
    ShowNotification("~g~License plate change to "..plate)
    cooldown = true
 
else do 
  ShowNotification("~r~Please wait 5 seconds before using this command again")
end
end
end
if item == set then
  local ped = GetPlayerPed(-1)
  local veh = GetVehiclePedIsIn(ped, false)
  DisplayOnscreenKeyboard(1, "", "", "", "", "", "", 30)
  while (UpdateOnscreenKeyboard() == 0) do
      DisableAllControlActions(0);
      Wait(0);
  end
  if (GetOnscreenKeyboardResult()) then
       local plate = GetOnscreenKeyboardResult() 
       set:RightLabel(plate)  
       SetVehicleNumberPlateText(veh, plate)
       ShowNotification("~g~License plate change to "..plate)
    end
end
end
end
  _menuPool:RefreshIndex() 


  
  
   Citizen.CreateThread(function()
      while true do
          Citizen.Wait(0)
          _menuPool:MouseControlsEnabled (false)
          _menuPool:MouseEdgeEnabled (false)
          _menuPool:ControlDisablingEnabled(false)
          _menuPool:ProcessMenus()
         if IsControlJustPressed(1, keybind) then
          if IsPedInAnyVehicle(GetPlayerPed(-1), false) then
            mainMenu:Clear()
            
doors(mainMenu)
windows(mainMenu)
liverys(mainMenu)
Extras(mainMenu)
licenses(mainMenu)
seatrs(mainMenu)
              mainMenu:Visible(not mainMenu:Visible())
             
          
        else 
          ShowNotification("~r~You need to be in a vehicle to use this menu")
      end
    end
    end
  end) 



RegisterCommand(command, function()
  Citizen.Wait(0)
  _menuPool:MouseControlsEnabled (false)
  _menuPool:MouseEdgeEnabled (false)
  _menuPool:ControlDisablingEnabled(false)
  _menuPool:ProcessMenus()
  if IsPedInAnyVehicle(GetPlayerPed(-1), false) then
    mainMenu:Clear()
    doors(mainMenu)
    windows(mainMenu)
    liverys(mainMenu)
    Extras(mainMenu)
    licenses(mainMenu)
seatrs(mainMenu)

      mainMenu:Visible(not mainMenu:Visible())
     
  
else 
  ShowNotification("~r~You need to be in a vehicle to use this menu")
end
end
)


---------------------------------------------------




  function ShowNotification(text)
    SetNotificationTextEntry("STRING")
    AddTextComponentString(text)
    DrawNotification(false, false)
end




