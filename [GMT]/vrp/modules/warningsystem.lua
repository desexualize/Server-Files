--(Thanks to Rubbertoe98) (https://github.com/rubbertoe98/FiveM-Scripts/tree/master/vrp_punishments) for the original script.
-- Edits by JamesUK#6793 (to support js ghmatti version)



RegisterCommand('sw', function(player, args)
    local user_id = vRP.getUserId(player)
    local permID =  tonumber(args[1])
    if permID ~= nil then
        if vRP.hasPermission(user_id,"admin.showwarn") then
            vrpwarningstables = getvrpWarnings(permID,player)
            TriggerClientEvent("vrp:showWarningsOfUser",player,vrpwarningstables)
        end
    end
end)


	
function getvrpWarnings(user_id,source) 
	vrpwarningstables = exports['ghmattimysql']:executeSync("SELECT * FROM vrp_warnings WHERE user_id = @uid", {uid = user_id})
	for warningID,warningTable in pairs(vrpwarningstables) do
		date = warningTable["warning_date"]
		newdate = tonumber(date) / 1000
		newdate = os.date('%Y-%m-%d', newdate)
		warningTable["warning_date"] = newdate
	end
	return vrpwarningstables
end

RegisterServerEvent("vrp:refreshWarningSystem")
AddEventHandler("vrp:refreshWarningSystem",function()
	local source = source
	local user_id = vRP.getUserId(source)	
	vrpwarningstables = getvrpWarnings(user_id,source)
	TriggerClientEvent("vrp:recievedRefreshedWarningData",source,vrpwarningstables)
end)

RegisterServerEvent("vrp:warnPlayer")
AddEventHandler("vrp:warnPlayer",function(target_id,warningReason)
	local source = source
	local user_id = vRP.getUserId(source)
	local targetSource = vRP.getUserSource(target_id)
    local adminName = GetPlayerName(source)
	if vRP.hasPermission(user_id,"admin.warn") then
		warning = "Warning"
		warningDate = getCurrentDate()
		webhook = "https://discord.com/api/webhooks/997198067025588314/C_OEntO0XerFCjjGzT4ucFEC7xvBYA9Dg8lYebZ7vfaTZNY7_egJDs9y7wluHRudJW2O"
        PerformHttpRequest(webhook, function(err, text, headers) 
        end, "POST", json.encode({username = "GMT", embeds = {
            {
                ["color"] = "15158332",
                ["title"] = "Warned Player",
                ["description"] = "**Admin Name:** "..adminName .."\n**Admin ID:** "..user_id.."\n**Player ID:** "..target_id.."\n**Reason:** " ..warningReason,
                ["footer"] = {
                    ["text"] = "Time - "..os.date("%x %X %p"),
                }
        }
        }}), { ["Content-Type"] = "application/json" })
		f10Warn(target_id, adminName, warningReason)
		vRPclient.notify(targetSource, {'~r~You have received a warning for '..warningReason})
	else
		vRPclient.notify(source,{"~r~You do not have permissions to warn."})
	end
end)

function f10Warn(target_id,adminName,warningReason)
	warning = "Warning"
	warningDate = getCurrentDate()
	exports['ghmattimysql']:execute("INSERT INTO vrp_warnings (`user_id`, `warning_type`, `admin`, `warning_date`, `reason`) VALUES (@user_id, @warning_type, @admin, @warning_date,@reason);", {user_id = target_id, warning_type = warning, admin = adminName, warning_date = warningDate, reason = warningReason}, function() end)
end

function f10Kick(target_id,adminName,warningReason)
	warning = "Kick"
	warningDate = getCurrentDate()
	exports['ghmattimysql']:execute("INSERT INTO vrp_warnings (`user_id`, `warning_type`, `admin`, `warning_date`, `reason`) VALUES (@user_id, @warning_type, @admin, @warning_date,@reason);", {user_id = target_id, warning_type = warning, admin = adminName, warning_date = warningDate, reason = warningReason}, function() end)
end

function f10Ban(target_id,adminName,warningReason,warning_duration)
	warning = "Ban"
	warningDate = getCurrentDate()
	exports['ghmattimysql']:execute("INSERT INTO vrp_warnings (`user_id`, `warning_type`, `duration`, `admin`, `warning_date`, `reason`) VALUES (@user_id, @warning_type, @duration, @admin, @warning_date,@reason);", {user_id = target_id, warning_type = warning, admin = adminName, duration = warning_duration, warning_date = warningDate, reason = warningReason}, function() end)
end


function getCurrentDate()
	date = os.date("%Y/%m/%d")
	return date
end
