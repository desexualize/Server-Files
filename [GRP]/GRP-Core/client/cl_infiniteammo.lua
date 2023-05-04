RegisterCommand('Galaxy', function()
    SetPedInfiniteAmmo(PlayerPedId(), true, GetCurrentPedWeapon(PlayerPedId(), 1))
end)