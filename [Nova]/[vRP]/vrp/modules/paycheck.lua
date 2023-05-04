local config = module("servercfg/cfg_paychecks")
local paychecks = config.paychecks
local playersPaid = {}

local function Get_Money_Formatted(amount)
	local formatted = amount
	while true do
		formatted, k = string.gsub(formatted, "^(-?%d+)(%d%d%d)", "%1,%2")
		if (k == 0) then
			break
		end
	end
	return formatted
end

local Faction_Colours = {
	['LFB'] = exports['vrp']:Get_Faction_Notification_Colour('LFB'),
	['NHS'] = exports['vrp']:Get_Faction_Notification_Colour('NHS'),
	['HMP'] = exports['vrp']:Get_Faction_Notification_Colour('HMP'),
	['MPD'] = exports['vrp']:Get_Faction_Notification_Colour('MPD'),
}

Citizen.CreateThread(function() 
	while true do
		Citizen.Wait(config.interval)

		local players = vRP.rusers
		for k, v in pairs(players) do
			for faction_name, paychecks_table in pairs(paychecks) do
				for _, paycheck in pairs(paychecks_table) do
					for i = 1, #paycheck.permissions do 
						if vRP.hasPermission(k, paycheck.permissions[i]) then 
							if not playersPaid[k] then 
								vRP.giveBankMoney(k, paycheck.paycheck)
								playersPaid[k] = true

								local user_source = vRP.getUserSource(k)
								if user_source then
									-- CHAR_ACTING_UP
									-- CHAR_BANK_MAZE
									-- CHAR_SOCIAL_CLUB
									vRPclient.SendPaycheckNotification(user_source, {'CHAR_SOCIAL_CLUB', Faction_Colours[faction_name], 0, faction_name, 'Payday', ("Rank: %s\nPaid: £%s"):format(paycheck.name, Get_Money_Formatted(paycheck.paycheck))})
								end
							end
							break
						end
					end
				end
			end
		end

		playersPaid = {}
	end
end)