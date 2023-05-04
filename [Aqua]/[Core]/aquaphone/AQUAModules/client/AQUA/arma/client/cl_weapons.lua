local a = module("arma-weapons", "cfg/weapons")
Citizen.CreateThread(function()
    for b,c in pairs(a.weapons)do 
        AddTextEntry(b,c.name)
    end 
end)

local aZ = false
function tARMA.giveWeapons(d,e)
    local f=PlayerPedId()
    if e then 
        RemoveAllPedWeapons(f,true)
    end
    aZ = true
    for g,h in pairs(d)do
        local i=GetHashKey(g)
        local j=h.ammo or 0
        tARMA.allowWeapon(g)
        GiveWeaponToPed(f,i,j,false)
        local k=h.attachments or{}
        for l,m in pairs(k)do 
            GiveWeaponComponentToPed(f,g,m)
        end 
    end
    Wait(100) 
    aZ = false
end
function tARMA.isPlayerArmed()
	local f = PlayerPedId()
	for b, c in pairs(a.weapons) do
		if HasPedGotWeapon(f, c.hash) then
			return true
		end
	end
	return false
end

function tARMA.hasWeapon(hash)
	if HasPedGotWeapon(PlayerPedId(), string.upper(hash)) then
        return true
    end
    return false
end

function tARMA.getWeapons()
    local f=PlayerPedId()
    local n={}
    local d={}
    for b,c in pairs(a.weapons)do 
        if HasPedGotWeapon(f,c.hash)then
            local h={}
            local o=GetPedAmmoTypeFromWeapon(f,c.hash)
            if n[o]==nil then 
                n[o]=true
                h.ammo=GetAmmoInPedWeapon(f,c.hash)
            else 
                h.ammo=0 
            end
            --h.attachments=tARMA.getAllWeaponAttachments(b)
            d[b]=h 
        end 
    end
    return d 
end
function tARMA.removeAllWeapons()
    RemoveAllPedWeapons(tARMA.getPlayerPed())
end
local s=GetGameTimer()
RegisterCommand("storecurrentweapon",function()
    if s+3000<GetGameTimer()then 
        s=GetGameTimer()
        if HasPedGotWeapon(PlayerPedId(),'WEAPON_PISTOL50')or HasPedGotWeapon(PlayerPedId(),'WEAPON_MACHINEPISTOL')then 
        else 
            local l,i=GetCurrentPedWeapon(PlayerPedId())
            local g=a.weaponHashToModels[i]
            TriggerServerEvent("ARMA:forceStoreSingleWeapon",g)
        end 
    else 
        tARMA.notify("~r~Store weapons cooldown, please wait.")
    end 
end)

AddEventHandler('onResourceStop',function(t)
    if t==GetCurrentResourceName()then 
        RemoveAllPedWeapons(PlayerPedId(),true)
    end 
end)

local X = {
    GetHashKey("WEAPON_UNARMED"),
    GetHashKey("WEAPON_PETROLCAN"),
    GetHashKey("WEAPON_SNOWBALL"),
}
Citizen.CreateThread(function()
    while true do
        local l,i = GetCurrentPedWeapon(PlayerPedId())
        local ammo = GetAmmoInPedWeapon(PlayerPedId(), i)
        Citizen.Wait(100)
        local k = GetSelectedPedWeapon(PlayerPedId())
        if GetAmmoInPedWeapon(PlayerPedId(), i) > ammo and not aZ then
            if not table.has(X, k) then
                for k,v in pairs(a.weapons) do
                    if i == GetHashKey(k) then
                        TriggerServerEvent('ARMA:acType17', v.name)
                        Wait(60000)
                    end
                end
            end
        end
        Wait(0)
    end
end)