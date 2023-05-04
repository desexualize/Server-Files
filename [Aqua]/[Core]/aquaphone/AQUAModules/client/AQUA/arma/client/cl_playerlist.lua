local a = false
SetNuiFocus(false, false)
function func_playerlistControl()
    if IsUsingKeyboard(2) then
        if IsControlJustPressed(0, 212) then
            a = not a
            TriggerServerEvent("ARMA:getPlayerListData")
            Wait(100)
            sendFullPlayerListData()
            SetNuiFocus(true, true)
            SendNUIMessage({showPlayerList = true})
        end
    end
end
tARMA.createThreadOnTick(func_playerlistControl)
RegisterNUICallback("closeARMAPlayerList",function(j, k)
    SetNuiFocus(false, false)
end)
AddEventHandler("ARMA:onClientSpawn",function(h, l)
    if l then
        TriggerServerEvent("ARMA:getPlayerListData")
    end
end)

RegisterNetEvent("ARMA:gotFullPlayerListData",function(staff, police, nhs, lfb, hmp, civillians)
    sortedPlayersStaff = staff
    sortedPlayersPolice = police
    sortedPlayersNHS = nhs
    sortedPlayersLFB = lfb
    sortedPlayersHMP = hmp
    sortedPlayersCivillians = civillians
end)
local u,v,x
RegisterNetEvent("ARMA:playerListMetaUpdate",function(t)
    u, v, x = table.unpack(t)
    SendNUIMessage({wipeFooterPlayerList = true})
    SendNUIMessage({appendToFooterPlayerList = '<span class="foot">Server #1 | </span>'})
    SendNUIMessage({appendToFooterPlayerList = '<span class="foot" style="color: rgb(0, 255, 20);">Server uptime ' ..tostring(u) .. "</span>"})
    SendNUIMessage({appendToFooterPlayerList = '<span class="foot">  |  Number of players ' ..tostring(v) .. "/" .. tostring(x).."</span>"})
end)

function getLength(tbl)
    local getN = 0
    for n in pairs(tbl) do 
      getN = getN + 1 
    end
    return getN
  end

function sendFullPlayerListData()
    local H = getLength(sortedPlayersStaff)
    local I = getLength(sortedPlayersPolice)
    local J = getLength(sortedPlayersNHS)
    local K = getLength(sortedPlayersLFB)
    local L = getLength(sortedPlayersHMP)
    local M = getLength(sortedPlayersCivillians)
    SendNUIMessage({wipePlayerList = true})
    SendNUIMessage({clearServerMetaData = true})
    SendNUIMessage({setServerMetaData = '<img src="playerlist_images/arma.png" align="top" width="20px",height="20px"><span class="staff">' ..tostring(H) .. "</span>"})
    SendNUIMessage({setServerMetaData = '<img src="playerlist_images/nhs.png" align="top" width="20",height="20"><span class="nhs">' ..tostring(J) .. "</span>"})
    SendNUIMessage({setServerMetaData = '<img src="playerlist_images/lfb.png" align="top" width="20",height="20"><span class="lfb">' ..tostring(K) .. "</span>"})
    SendNUIMessage({setServerMetaData = '<img src="playerlist_images/met.png" align="top"  width="24",height="24"><span class="police">' ..tostring(I) .. "</span>"})
    SendNUIMessage({setServerMetaData = '<img src="playerlist_images/hmp.png" align="top"  width="24",height="24"><span class="hmp">' ..tostring(L) .. "</span>"})
    SendNUIMessage({setServerMetaData = '<img src="playerlist_images/danny.png" align="top" width="20",height="20"><span class="aa">' ..tostring(M) .. "</span>"})
    SendNUIMessage({wipeFooterPlayerList = true})
    SendNUIMessage({appendToFooterPlayerList = '<span class="foot">Server #1 | </span>'})
    SendNUIMessage({appendToFooterPlayerList = '<span class="foot" style="color: rgb(0, 255, 20);">Server uptime ' ..tostring(u) .. "</span>"})
    SendNUIMessage({appendToFooterPlayerList = '<span class="foot">  |  Number of players ' ..tostring(v) .. "/" .. tostring(x).."</span>"})
    if H >= 1 then
        SendNUIMessage({appendToContentPlayerList = '<span id="playerlist_seperator_staff">Staff</span>'})
    end
    for S, T in pairs(sortedPlayersStaff) do
        SendNUIMessage({appendToContentPlayerList = '<span class="username">' ..tostring(sortedPlayersStaff[S].name) ..'</span><span class="job">' ..tostring(sortedPlayersStaff[S].rank) .. '</span><span class="playtime">' .. tostring(sortedPlayersStaff[S].hours) .. "hrs</span><br/>"})
    end
    if I >= 1 then
        SendNUIMessage({appendToContentPlayerList = '<span id="playerlist_seperator_police">MET Police</span>'})
    end
    for S, T in pairs(sortedPlayersPolice) do
        SendNUIMessage({appendToContentPlayerList = '<span class="username">' ..tostring(sortedPlayersPolice[S].name) ..'</span><span class="job">' ..tostring(sortedPlayersPolice[S].rank) .. '</span><span class="playtime">' .. tostring(sortedPlayersPolice[S].hours) .. "hrs</span><br/>"})
    end
    if J >= 1 then
        SendNUIMessage({appendToContentPlayerList = '<span id="playerlist_seperator_nhs">NHS</span>'})
    end
    for S, T in pairs(sortedPlayersNHS) do
        SendNUIMessage({appendToContentPlayerList = '<span class="username">' ..tostring(sortedPlayersNHS[S].name) ..'</span><span class="job">' ..tostring(sortedPlayersNHS[S].rank) .. '</span><span class="playtime">' .. tostring(sortedPlayersNHS[S].hours) .. "hrs</span><br/>"})
    end
    if K >= 1 then
        SendNUIMessage({appendToContentPlayerList = '<span id="playerlist_seperator_lfb">LFB</span>'})
    end
    for S, T in pairs(sortedPlayersLFB) do
        SendNUIMessage({appendToContentPlayerList = '<span class="username">' ..tostring(sortedPlayersLFB[S].name) ..'</span><span class="job">' ..tostring(sortedPlayersLFB[S].rank) .. '</span><span class="playtime">' .. tostring(sortedPlayersLFB[S].hours) .. "hrs</span><br/>"})
    end
    if L >= 1 then
        SendNUIMessage({appendToContentPlayerList = '<span id="playerlist_seperator_hmp">HMP</span>'})
    end
    for S, T in pairs(sortedPlayersHMP) do
        SendNUIMessage({appendToContentPlayerList = '<span class="username">' ..tostring(sortedPlayersHMP[S].name) ..'</span><span class="job">' ..tostring(sortedPlayersHMP[S].rank) .. '</span><span class="playtime">' .. tostring(sortedPlayersHMP[S].hours) .. "hrs</span><br/>"})
    end
    if M >= 1 then
        SendNUIMessage({appendToContentPlayerList = '<span id="playerlist_seperator_civs">Civilians</span>'})
    end
    for S, T in pairs(sortedPlayersCivillians) do
        SendNUIMessage({appendToContentPlayerList = '<span class="username">' ..tostring(sortedPlayersCivillians[S].name) ..'</span><span class="job">' ..tostring(sortedPlayersCivillians[S].rank) .. '</span><span class="playtime">' .. tostring(sortedPlayersCivillians[S].hours) .. "hrs</span><br/>"})
    end
end

Citizen.CreateThread(function()
    while true do
        Wait(5000)
        if u ~= nil and v ~= nil and x ~= nil then
            SetDiscordAppId(970724996223746149)
            SetDiscordRichPresenceAsset('mainlogo') 
            SetDiscordRichPresenceAssetText("discord.gg/armarp") 
            SetDiscordRichPresenceAssetSmall('mainlogo')
            SetDiscordRichPresenceAssetSmallText('ARMA')
            SetRichPresence("[ID:" .. tostring(tARMA.getUserId()) .. "] | " .. tostring(v) .. "/" .. tostring(x))
        end
        Wait(15000)
    end
end)