local Player_Spawned_Event = AddEventHandler('playerSpawned', function()
    ShutdownLoadingScreenNui()
    SetBigmapActive(false, false)
    Remove_Spawn_Event_Function()
end)

function Remove_Spawn_Event_Function()
    RemoveEventHandler(Player_Spawned_Event)
end