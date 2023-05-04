spawn = {}

spawn.freeze = true -- [Freeze when Menu is Opened]
spawn.close = false -- [When Pressing Back Space it closes menu and unfreezes player]
spawn.marker = true -- [A marker of the location where you can open the menu]
spawn.chatmessage = true -- [When going to a spawn point a chat massage will be displayed saying 'Spawned in at [Location]!']

spawn.coords = vector3(-2043.7160644531,-1031.4356689453,11.98070526123) -- [Coordinate of were you pull out the menu]
 
spawn.options = {

    {name = "St Thomas Hospital", location = vector3(362.8176574707,-591.65472412109,28.673826217651)},
    {name = "Sandy Shores", location = vector3(1839.7781982422,3672.0986328125,34.276706695557)},
    {name = "Paleto Hospital", location = vector3(-243.4533996582,6327.1806640625,32.426231384277)},
    {name = "Rebel Diner", location = vector3(1574.0743408203,6463.3959960938,24.827054977417)},
    {name = "~y~[VIP Island]", location = vector3(-2164.7561035156,5187.9262695312,15.631214141846)},
    
    
    -- [Copy and Paste Line to add new Location / Option]
}