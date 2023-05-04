--(Thanks to Rubbertoe98) (https://github.com/rubbertoe98/FiveM-Scripts/tree/master/AQUA_punishments) for the original script.
-- Edits by JamesUK#6793 (to support js ghmatti version)



RegisterCommand('sw', function(player, args)
    local user_id = AQUA.getUserId(player)
    local permID =  tonumber(args[1])
    if permID ~= nil then
        if AQUA.hasPermission(user_id,"admin.showwarn") then
            AQUAwarningstables = getAQUAWarnings(permID,player)
            TriggerClientEvent("AQUA:showWarningsOfUser",player,AQUAwarningstables)
        end
    end
end)


	
function getAQUAWarnings(user_id,source) 
	AQUAwarningstables = exports['ghmattimysql']:executeSync("SELECT * FROM AQUA_warnings WHERE user_id = @uid", {uid = user_id})
	for warningID,warningTable in pairs(AQUAwarningstables) do
		date = warningTable["warning_date"]
		newdate = tonumber(date) / 1000
		newdate = os.date('%Y-%m-%d', newdate)
		warningTable["warning_date"] = newdate
	end
	return AQUAwarningstables
end

RegisterServerEvent("AQUA:refreshWarningSystem")
AddEventHandler("AQUA:refreshWarningSystem",function()
	local source = source
	local user_id = AQUA.getUserId(source)	
	AQUAwarningstables = getAQUAWarnings(user_id,source)
	TriggerClientEvent("AQUA:recievedRefreshedWarningData",source,AQUAwarningstables)
end)

RegisterServerEvent("AQUA:warnPlayer")
AddEventHandler("AQUA:warnPlayer",function(target_id,warningReason)
	local source = source
	local user_id = AQUA.getUserId(source)
	local targetSource = AQUA.getUserSource(target_id)
    local adminName = GetPlayerName(source)
	if AQUA.hasPermission(user_id,"admin.warn") then
		warning = "Warning"
		warningDate = getCurrentDate()
		webhook = "https://discord.com/api/webhooks/1059087106661683220/6janA_VFhtldtlIUeQMESlMJ4Z9RC951ibdP8PSzeDLq1D9HXDFyOM_zOMSz2NHyhYk4"
        PerformHttpRequest(webhook, function(err, text, headers) 
        end, "POST", json.encode({username = "AQUA", embeds = {
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
		AQUAclient.notify(targetSource, {'~d~You have received a warning for '..warningReason})
	else
		AQUAclient.notify(source,{"~d~You do not have permissions to warn."})
	end
end)

function f10Warn(target_id,adminName,warningReason)
	warning = "Warning"
	warningDate = getCurrentDate()
	exports['ghmattimysql']:execute("INSERT INTO AQUA_warnings (`user_id`, `warning_type`, `admin`, `warning_date`, `reason`) VALUES (@user_id, @warning_type, @admin, @warning_date,@reason);", {user_id = target_id, warning_type = warning, admin = adminName, warning_date = warningDate, reason = warningReason}, function() end)
end

function f10Kick(target_id,adminName,warningReason)
	warning = "Kick"
	warningDate = getCurrentDate()
	exports['ghmattimysql']:execute("INSERT INTO AQUA_warnings (`user_id`, `warning_type`, `admin`, `warning_date`, `reason`) VALUES (@user_id, @warning_type, @admin, @warning_date,@reason);", {user_id = target_id, warning_type = warning, admin = adminName, warning_date = warningDate, reason = warningReason}, function() end)
end

function f10Ban(target_id,adminName,warningReason,warning_duration)
	warning = "Ban"
	warningDate = getCurrentDate()
	exports['ghmattimysql']:execute("INSERT INTO AQUA_warnings (`user_id`, `warning_type`, `duration`, `admin`, `warning_date`, `reason`) VALUES (@user_id, @warning_type, @duration, @admin, @warning_date,@reason);", {user_id = target_id, warning_type = warning, admin = adminName, duration = warning_duration, warning_date = warningDate, reason = warningReason}, function() end)
end


function getCurrentDate()
	date = os.date("%Y/%m/%d")
	return date
end
