RegisterServerEvent("PoliceMenu:ClockOn")
AddEventHandler('PoliceMenu:ClockOn', function(policerank)
    local user_id = vRP.getUserId(source)
    local coords = GetEntityCoords(GetPlayerPed(source))
    local comparison = vector3(441.87026977539,-981.13433837891,30.689609527588)

    if policerank == "Commissioner Clocked" then
        policeperm = "commissioner.clockon"
        policename = "Commissioner"
    elseif policerank == "Deputy Commissioner Clocked" then
        policeperm = "depcommissioner.clockon"
        policename = "Deputy Commissioner"
    elseif policerank == "Assistant Commissioner Clocked" then
        policeperm = "asscommissioner.clockon"
        policename = "Assistant Commissioner"
    elseif policerank == "Deputy Assistant Commissioner Clocked" then
        policeperm = "depasscommissioner.clockon"
        policename = "Deputy Assistant Commissioner"
    elseif policerank == "Commander Clocked" then
        policeperm = "commander.clockon"
        policename = "Commander"
    elseif policerank == "Chief Superintendent Clocked" then
        policeperm = "chiefsupint.clockon"
        policename = "Chief Superintendent"
    elseif policerank == "Superintendent Clocked" then
        policeperm = "superint.clockon"
        policename = "Superintendent"
    elseif policerank == "Chief Inspector Clocked" then
        policeperm = "chiefinsp.clockon"
        policename = "Chief Inspector"
    elseif policerank == "Inspector Clocked" then
        policeperm = "inspector.clockon"
        policename = "Inspector"
    elseif policerank == "Sergeant Clocked" then
        policeperm = "sgt.clockon"
        policename = "Sergeant"
    elseif policerank == "Special Police Constable Clocked" then
        policeperm = "specialpc.clockon"
        policename = "Special Police Constable"
    elseif policerank == "Senior Police Constable Clocked" then
        policeperm = "srpc.clockon"
        policename = "Senior Police Constable"
    elseif policerank == "Police Constable Clocked" then
        policeperm = "pc.clockon"
        policename = "Police Constable"
    elseif policerank == "PCSO Clocked" then
        policeperm = "pcso.clockon"
        policename = "PCSO"
    end

    if user_id ~= nil and vRP.hasPermission(user_id, policeperm) and not vRP.hasGroup(user_id,policerank) then
        vRP.addUserGroup(user_id,policerank)
        vRPclient.notify(source,{"~b~You have clocked on as a "..policename})
    elseif user_id == nil then
        vRPclient.notify(source,{"~r~You are a nil User ID, please relog."})
    elseif not vRP.hasPermission(user_id, policeperm) then
        vRPclient.notify(source,{"~r~Hey! You aren't allowed to clock on as that rank."})
    elseif not vRP.hasPermission(user_id, "clockon.menu") then
        vRPclient.notify(source,{"~r~You have been reported to admins since you are trying to clock on through a mod menu"})
    elseif vRP.hasGroup(user_id,policerank) then
        vRPclient.notify(source,{"~r~You are already clocked on!"})
    end
    if #(coords - comparison) > 20 then
        print(GetPlayerName(source).." is a cheating scum, he's trying to clock on as Police!")
        return
    end
end)

RegisterServerEvent("PoliceMenu:CheckPermissions")
AddEventHandler('PoliceMenu:CheckPermissions', function()
    local user_id = vRP.getUserId(source)
    local coords = GetEntityCoords(GetPlayerPed(source))
    local comparison = vector3(441.87026977539,-981.13433837891,30.689609527588)
    if #(coords - comparison) > 20 then
        print(GetPlayerName(source).." is a cheating scum, he's trying to clock on as Police!")
        return
    end
    if vRP.hasPermission(user_id, "clockon.menu") then
        TriggerClientEvent('PoliceDuty:Allowed', source, true)
    else
        TriggerClientEvent('PoliceDuty:Allowed', source, false)
    end
end)

RegisterServerEvent("PoliceMenu:ClockOff")
AddEventHandler('PoliceMenu:ClockOff', function()
    local user_id = vRP.getUserId(source)
    local coords = GetEntityCoords(GetPlayerPed(source))
    local comparison = vector3(441.87026977539,-981.13433837891,30.689609527588)

    if user_id == nil then
        vRPclient.notify(source,{"~r~You are a nil User ID, please relog."})
    elseif user_id ~= nil and vRP.hasGroup(user_id, "Commissioner Clocked") then
        vRP.removeUserGroup(user_id,"Commissioner Clocked")
        vRPclient.notify(source,{"You have clocked off"})
    elseif user_id ~= nil and vRP.hasGroup(user_id, "Deputy Commissioner Clocked") then
        vRP.removeUserGroup(user_id,"Deputy Commissioner Clocked")
        vRPclient.notify(source,{"You have clocked off"})
    elseif user_id ~= nil and vRP.hasGroup(user_id, "Assistant Commissioner Clocked") then
        vRP.removeUserGroup(user_id,"Assistant Commissioner Clocked")
        vRPclient.notify(source,{"You have clocked off"})
    elseif user_id ~= nil and vRP.hasGroup(user_id, "Deputy Assistant Commissioner Clocked") then
        vRP.removeUserGroup(user_id,"Deputy Assistant Commissioner Clocked")
        vRPclient.notify(source,{"You have clocked off"})
    elseif user_id ~= nil and vRP.hasGroup(user_id, "Commander Clocked") then
        vRP.removeUserGroup(user_id,"Commander Clocked")
        vRPclient.notify(source,{"You have clocked off"})
    elseif user_id ~= nil and vRP.hasGroup(user_id, "Chief Superintendent Clocked") then
        vRP.removeUserGroup(user_id,"Chief Superintendent Clocked")
        vRPclient.notify(source,{"You have clocked off"})
    elseif user_id ~= nil and vRP.hasGroup(user_id, "Superintendent Clocked") then
        vRP.removeUserGroup(user_id,"Superintendent Clocked")
        vRPclient.notify(source,{"You have clocked off"})
    elseif user_id ~= nil and vRP.hasGroup(user_id, "Chief Inspector Clocked") then
        vRP.removeUserGroup(user_id,"Chief Inspector Clocked")
        vRPclient.notify(source,{"You have clocked off"})
    elseif user_id ~= nil and vRP.hasGroup(user_id, "Inspector Clocked") then
        vRP.removeUserGroup(user_id,"Inspector Clocked")
        vRPclient.notify(source,{"You have clocked off"})
    elseif user_id ~= nil and vRP.hasGroup(user_id, "Sergeant Clocked") then
        vRP.removeUserGroup(user_id,"Sergeant Clocked")
        vRPclient.notify(source,{"You have clocked off"})
    elseif user_id ~= nil and vRP.hasGroup(user_id, "Special Police Constable Clocked") then
        vRP.removeUserGroup(user_id,"Special Police Constable Clocked")
        vRPclient.notify(source,{"You have clocked off"})
    elseif user_id ~= nil and vRP.hasGroup(user_id, "Senior Police Constable Clocked") then
        vRP.removeUserGroup(user_id,"Senior Police Constable Clocked")
        vRPclient.notify(source,{"You have clocked off"})
    elseif user_id ~= nil and vRP.hasGroup(user_id, "Police Constable Clocked") then
        vRP.removeUserGroup(user_id,"Police Constable Clocked")
        vRPclient.notify(source,{"You have clocked off"})
    elseif user_id ~= nil and vRP.hasGroup(user_id, "PCSO Clocked") then
        vRP.removeUserGroup(user_id,"PCSO Clocked")
        vRPclient.notify(source,{"You have clocked off"})
    end
    if #(coords - comparison) > 20 then
        print(GetPlayerName(source).." is a cheating scum, he's trying to clock off as Police!")
        return
    end
end)