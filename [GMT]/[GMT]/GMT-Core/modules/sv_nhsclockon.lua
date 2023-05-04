RegisterServerEvent("NHSMenu:ClockOn")
AddEventHandler('NHSMenu:ClockOn', function(nhsrank)
    local user_id = vRP.getUserId(source)
    local coords = GetEntityCoords(GetPlayerPed(source))
    local comparison = vector3(311.38034057617,-594.16644287109,43.284099578857)

    if nhsrank == "Head Chief Medical Officer Clocked" then
        nhsperm = "hcmo.clockon"
        nhsrankname = "Head Chief Medical Officer"
    elseif nhsrank == "Assistant Chief Medical Officer Clocked" then
        nhsperm = "acmo.clockon"
        nhsrankname = "Assistant Chief Medical Officer"
    elseif nhsrank == "Deputy Chief Medical Officer Clocked" then
        nhsperm = "dcmo.clockon"
        nhsrankname = "Deputy Chief Medical Officer"
    elseif nhsrank == "Captain Clocked" then
        nhsperm = "capt.clockon"
        nhsrankname = "Captain"
    elseif nhsrank == "Consultant Clocked" then
        nhsperm = "consultant.clockon"
        nhsrankname = "Consultant"
    elseif nhsrank == "Specialist Clocked" then
        nhsperm = "specialist.clockon"
        nhsrankname = "Specialist"
    elseif nhsrank == "Senior Doctor Clocked" then
        nhsperm = "srdoctor.clockon"
        nhsrankname = "Senior Doctor"
    elseif nhsrank == "Junior Doctor Clocked" then
        nhsperm = "jrdoctor.clockon"
        nhsrankname = "Junior Doctor"
    elseif nhsrank == "Critical Care Paramedic Clocked" then
        nhsperm = "ccp.clockon"
        nhsrankname = "Critical Care Paramedic"
    elseif nhsrank == "Paramedic Clocked" then
        nhsperm = "paramedic.clockon"
        nhsrankname = "Paramedic"
    elseif nhsrank == "Trainee Paramedic Clocked" then
        nhsperm = "tparamedic.clockon"
        nhsrankname = "Trainee Paramedic"
    end

    if user_id ~= nil and vRP.hasPermission(user_id, nhsperm) and not vRP.hasGroup(user_id,nhsrank) then
        vRP.addUserGroup(user_id,nhsrank)
        vRPclient.notify(source,{"~g~You have clocked on as a "..nhsrankname})
    elseif user_id == nil then
        vRPclient.notify(source,{"~r~You are a nil User ID, please relog."})
    elseif not vRP.hasPermission(user_id, nhsperm) then
        vRPclient.notify(source,{"~r~Hey! You aren't allowed to clock on as that rank."})
    elseif not vRP.hasPermission(user_id, "clockon.menu") then
        vRPclient.notify(source,{"~r~You have been reported to admins since you are trying to clock on through a mod menu"})
    elseif vRP.hasGroup(user_id,nhsrank) then
        vRPclient.notify(source,{"~r~You are already clocked on!"})
    end
    if #(coords - comparison) > 20 then
        print(GetPlayerName(source).." is a cheating scum, he's trying to clock on as NHS!")
        return
    end
end)

RegisterServerEvent("NHSMenu:CheckPermissions")
AddEventHandler('NHSMenu:CheckPermissions', function()
    local user_id = vRP.getUserId(source)
    local coords = GetEntityCoords(GetPlayerPed(source))
    local comparison = vector3(311.38034057617,-594.16644287109,43.284099578857)
    if #(coords - comparison) > 20 then
        print(GetPlayerName(source).." is a cheating scum, he's trying to clock on as NHS!")
        return
    end
    if vRP.hasPermission(user_id, "clockon.nhs") then
        TriggerClientEvent('NHSDuty:Allowed', source, true)
    else
        TriggerClientEvent('NHSDuty:Allowed', source, false)
    end
end)

RegisterServerEvent("NHSMenu:ClockOff")
AddEventHandler('NHSMenu:ClockOff', function()
    local user_id = vRP.getUserId(source)
    local coords = GetEntityCoords(GetPlayerPed(source))
    local comparison = vector3(311.38034057617,-594.16644287109,43.284099578857)

    if user_id == nil then
        vRPclient.notify(source,{"~r~You are a nil User ID, please relog."})
    elseif user_id ~= nil and vRP.hasGroup(user_id, "Head Chief Medical Officer Clocked") then
        vRP.removeUserGroup(user_id,"Head Chief Medical Officer Clocked")
        vRPclient.notify(source,{"You have clocked off"})
    elseif user_id ~= nil and vRP.hasGroup(user_id, "Assistant Chief Medical Officer Clocked") then
        vRP.removeUserGroup(user_id,"Assistant Chief Medical Officer Clocked")
        vRPclient.notify(source,{"You have clocked off"})
    elseif user_id ~= nil and vRP.hasGroup(user_id, "Deputy Chief Medical Officer Clocked") then
        vRP.removeUserGroup(user_id,"Deputy Chief Medical Officer Clocked")
        vRPclient.notify(source,{"You have clocked off"})
    elseif user_id ~= nil and vRP.hasGroup(user_id, "Captain Clocked") then
        vRP.removeUserGroup(user_id,"Captain Clocked")
        vRPclient.notify(source,{"You have clocked off"})
    elseif user_id ~= nil and vRP.hasGroup(user_id, "Consultant Clocked") then
        vRP.removeUserGroup(user_id,"Consultant Clocked")
        vRPclient.notify(source,{"You have clocked off"})
    elseif user_id ~= nil and vRP.hasGroup(user_id, "Specialist Clocked") then
        vRP.removeUserGroup(user_id,"Specialist Clocked")
        vRPclient.notify(source,{"You have clocked off"})
    elseif user_id ~= nil and vRP.hasGroup(user_id, "Senior Doctor Clocked") then
        vRP.removeUserGroup(user_id,"Senior Doctor Clocked")
        vRPclient.notify(source,{"You have clocked off"})
    elseif user_id ~= nil and vRP.hasGroup(user_id, "Junior Doctor Clocked") then
        vRP.removeUserGroup(user_id,"Junior Doctor Clocked")
        vRPclient.notify(source,{"You have clocked off"})
    elseif user_id ~= nil and vRP.hasGroup(user_id, "Critical Care Paramedic Clocked") then
        vRP.removeUserGroup(user_id,"Critical Care Paramedic Clocked")
        vRPclient.notify(source,{"You have clocked off"})
    elseif user_id ~= nil and vRP.hasGroup(user_id, "Paramedic Clocked") then
        vRP.removeUserGroup(user_id,"Paramedic Clocked")
        vRPclient.notify(source,{"You have clocked off"})
    elseif user_id ~= nil and vRP.hasGroup(user_id, "Trainee Paramedic Clocked") then
        vRP.removeUserGroup(user_id,"Trainee Paramedic Clocked")
        vRPclient.notify(source,{"You have clocked off"})
    end
    if #(coords - comparison) > 20 then
        print(GetPlayerName(source).." is a cheating scum, he's trying to clock off as NHS!")
        return
    end
end)