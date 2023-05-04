local cfg = {}

-- define each group with a set of permissions
-- _config property:
--- gtype (optional): used to have only one group with the same gtype per player (example: a job gtype to only have one job)
--- onspawn (optional): function(player) (called when the player spawn with the group)
--- onjoin (optional): function(player) (called when the player join the group)
--- onleave (optional): function(player) (called when the player leave the group)
--- (you have direct access to vRP and vRPclient, the tunnel to client, in the config callbacks)
--  special (optional) -- defines whether user needs special permissions to remove this group.
-- If you have a special group the prefix of the permission is player.manage_groupname An example would be: player.manage_superadmin
--[[
Hi, It's JamesUK#6793 Here. 
	"Nova.adminmenu", 
    "player.kick",
    "player.ban",
	"player.revive",
	"player.slap",
	"player.spectate", 
	"player.tpto", 
	"player.tpbring",
	"player.removeGroups",
	"player.addGroups",
	"player.manage_superadmin",
	"player.manage_saadmin",
	"player.manage_admin",
	"player.manage_mod",
	"player.manage_support",
	"player.manage_trial", 
	"player.propcleanup", 
	"player.pedcleanup", 
	"player.vehcleanup",
	"player.cleanallcleanup",
	"player.shutdownserver",
	"player.addcar",
	"player.tptowaypoint",
	"admin.spawnveh",
	"admin.removewarning",
	"player.addblacklistedprops" -- Allows live updating of blacklisted props only give to trusted staff.
	These are all the perms for the latest RageUI update, many thanks JamesUK.
]]
cfg.groups = {
	["developer"] = {
		'chat.clear',
		'chat.announce',
		"developer.menu",
		"developer.spawncar",
		"developer.spawnweapon",
		"developer.deletecar",
		"developer.fixcar",
		"admin.managecommunitypot",
		"developer.getcoords",
		"developer.getheading",
		"developer.getheading",
		"admin.menu",
		"admin.warn",
		"admin.showwarn",
		"admin.kick",
		'admin.unban',
		"admin.nof10kick",
		"admin.revive",
		"admin.tp2player",
		"developer.tp2coords",
		"admin.summon",
		"admin.freeze",
		"admin.getgroups",
		'admin.forceclockoff',
		"admin.spectate",
		"admin.screenshot",
		"admin.tp2waypoint",
		"admin.tp2coords",
		"admin.removewarn",
		"admin.spawnBmx",
		"admin.idsabovehead",
		"admin.noclip",
		"admin.screenshot",
		"admin.whitelisted",
		"admin.tickets",
	},
	["cardeveloper"] = {
		"cardeveloper.menu",
		"vehicle.delete",
	},
	["founder"] = {
		_config = {
			onjoin = function(player)
				vRPclient.setFounder(player, {true})
			end,
			onspawn = function(player)
				vRPclient.setFounder(player, {true})
			end,
			onleave = function(player)
				vRPclient.setFounder(player, {false})
			end
		},
		'chat.clear',
		'chat.announce',
		"admin.menu",
		"admin.warn",
		"admin.showwarn",
		'admin.unban',
		"admin.ban",
		"admin.kick",
		"admin.nof10kick",
		"admin.revive",
		"admin.managecommunitypot",
		"admin.tp2player",
		"admin.summon",
		"admin.freeze",
		"admin.getgroups",
		'admin.forceclockoff',
		"admin.spectate",
		"admin.screenshot",
		"admin.whitelistgroups",
		"admin.slap",
		"admin.givemoney",
		"admin.tp2waypoint",
		"admin.tp2coords",
		"admin.removewarn",
		"admin.spawnBmx",
		"admin.noclip",
		"staff.mode",
		"admin.vehmenu",
		"admin.spawnGun",
		'admin.spawncar',
		"admin.addcar",
		"admin.idsabovehead",
		"admin.smartsigns",
		"developer.menu",
		"developer.spawncar",
		"developer.spawnweapon",
		"developer.deletecar",
		"developer.fixcar",
		"developer.getcoords",
		"developer.getheading",
		"developer.getheading",
		"developer.tp2coords",
		"developer.givemoney",
		"admin.staffAddGroups",
		"admin.povAddGroups",
		"admin.mpdAddGroups",
		'admin.lfbAddGroups',
		'admin.hmpAddGroups',
		"admin.licenseAddGroups",
		"admin.donoAddGroups",
		"admin.nhsAddGroups",
		"group.add.vipgarage",
		"group.add.founder",
		"group.add.cofounder",
		'group.add.developer',
		"cardeveloper.menu",
		'group.add.cardeveloper',
		"group.add.staffmanager",
		"group.add.commanager",
		"group.add.headadmin",
		"group.add.senioradmin",
		"group.add.administrator",
		"group.add.moderator",
		"group.add.trial",
		'group.add.pov',
		"group.add",
		"group.remove.vipgarage",
		"group.remove.founder",
		"group.remove.cofounder",
		"group.remove.staffmanager",
		"group.remove.commanager",
		"group.remove.headadmin",
		"group.remove.senioradmin",
		"group.remove.administrator",
		"group.remove.moderator",
		"group.remove.trial",
		"group.remove",
		"admin.whitelisted",
		"admin.tickets",
		"vehicle.delete",
	},
	["cofounder"] = {
		'chat.clear',
		'chat.announce',
		"admin.menu",
		"admin.warn",
		"admin.showwarn",
		"admin.ban",
		'admin.unban',
		"admin.kick",
		"admin.nof10kick",
		"admin.revive",
		"admin.tp2player",
		"admin.managecommunitypot",
		"cardeveloper.menu",
		"admin.summon",
		"admin.freeze",
		"admin.getgroups",
		'admin.forceclockoff',
		"admin.spectate",
		"admin.screenshot",
		"admin.whitelistgroups",
		"admin.slap",
		"admin.givemoney",
		"admin.tp2waypoint",
		"admin.tp2coords",
		"admin.removewarn",
		"admin.spawnBmx",
		"admin.noclip",
		"staff.mode",
		"admin.vehmenu",
		"admin.spawnGun",
		'admin.spawncar',
		"admin.addcar",
		"admin.idsabovehead",
		"admin.smartsigns",
		"developer.menu",
		"developer.spawncar",
		"developer.spawnweapon",
		"developer.deletecar",
		"developer.fixcar",
		"developer.getcoords",
		"developer.getheading",
		"developer.getheading",
		"developer.tp2coords",
		"developer.givemoney",
		"admin.staffAddGroups",
		"admin.povAddGroups",
		"admin.licenseAddGroups",
		"admin.donoAddGroups",
		"admin.mpdAddGroups",
		"admin.nhsAddGroups",
		'admin.lfbAddGroups',
		'admin.hmpAddGroups',
		"group.add.vipgarage",
		'group.add.cardeveloper',
		"group.add.staffmanager",
		"group.add.commanager",
		"group.add.headadmin",
		"group.add.senioradmin",
		"group.add.administrator",
		"group.add.moderator",
		"group.add.trial",
		'group.add.pov',
		"group.add",
		"group.remove.vipgarage",
		"group.remove.staffmanager",
		"group.remove.commanager",
		"group.remove.headadmin",
		"group.remove.senioradmin",
		"group.remove.administrator",
		"group.remove.moderator",
		"group.remove.trial",
		"group.remove",
		"admin.whitelisted",
		"admin.tickets",
		"vehicle.delete",
	},
	["staffmanager"] = {
		'chat.clear',
		'chat.announce',
		"admin.menu",
		"admin.warn",
		"admin.showwarn",
		"admin.ban",
		'admin.unban',
		"admin.kick",
		"admin.nof10kick",
		"developer.fixcar",
		"admin.revive",
		"admin.tp2player",
		"admin.summon",
		"admin.managecommunitypot",
		"admin.freeze",
		"admin.getgroups",
		'admin.forceclockoff',
		"admin.whitelistgroups",
		"admin.spectate",
		"admin.screenshot",
		"admin.slap",
		"admin.tp2waypoint",
		"admin.tp2coords",
		"admin.removewarn",
		"admin.spawnBmx",
		"admin.noclip",
		"staff.mode",
		"admin.vehmenu",
		"admin.spawnGun",
		'admin.spawncar',
		"admin.addcar",
		"admin.idsabovehead",
		"admin.smartsigns",
		"admin.staffAddGroups",
		"admin.povAddGroups",
		"admin.mpdAddGroups",
		"admin.licenseAddGroups",
		"admin.donoAddGroups",
		"admin.nhsAddGroups",
		'admin.lfbAddGroups',
		'admin.hmpAddGroups',
		"group.add.vipgarage",
		'group.add.cardeveloper',
		"group.add.commanager",
		"group.add.headadmin",
		"group.add.senioradmin",
		"group.add.administrator",
		"group.add.moderator",
		"group.add.trial",
		'group.add.pov',
		"group.add",
		"group.remove.vipgarage",
		"group.remove.commanager",
		"group.remove.headadmin",
		"group.remove.senioradmin",
		"group.remove.administrator",
		"group.remove.moderator",
		"group.remove.trial",
		"group.remove",
		"admin.whitelisted",
		"admin.tickets",
		"vehicle.delete",
	},
	["commanager"] = {
		"admin.menu",
		"admin.warn",
		"admin.showwarn",
		"admin.ban",
		'admin.unban',
		"admin.kick",
		"admin.nof10kick",
		"admin.revive",
		"admin.managecommunitypot",
		"admin.whitelistgroups",
		"admin.tp2player",
		"admin.summon",
		"admin.freeze",
		"admin.getgroups",
		'admin.forceclockoff',
		"admin.spectate",
		"admin.screenshot",
		"admin.slap",
		"developer.fixcar",
		"admin.tp2waypoint",
		"admin.tp2coords",
		"admin.removewarn",
		"admin.spawnBmx",
		"admin.noclip",
		"staff.mode",
		"admin.vehmenu",
		"admin.spawnGun",
		'admin.spawncar',
		"admin.addcar",
		"admin.idsabovehead",
		"admin.smartsigns",
		"admin.staffAddGroups",
		"admin.povAddGroups",
		"admin.mpdAddGroups",
		"admin.licenseAddGroups",
		"admin.donoAddGroups",
		"admin.nhsAddGroups",
		'admin.lfbAddGroups',
		'admin.hmpAddGroups',
		"group.add.vipgarage",
		'group.add.cardeveloper',
		"group.add.headadmin",
		"group.add.senioradmin",
		"group.add.administrator",
		"group.add.moderator",
		"group.add.trial",
		"group.add",
		"group.remove.vipgarage",
		"group.remove.headadmin",
		"group.remove.senioradmin",
		"group.remove.administrator",
		"group.remove.moderator",
		"group.remove.trial",
		'group.add.pov',
		"group.remove",
		"admin.whitelisted",
		"admin.tickets",
		"vehicle.delete",
	},
	["headadmin"] = {
		"admin.menu",
		"admin.warn",
		"admin.showwarn",
		"admin.ban",
		'admin.unban',
		"admin.kick",
		"admin.managecommunitypot",
		"admin.nof10kick",
		"admin.revive",
		"admin.tp2player",
		"admin.summon",
		"admin.freeze",
		"admin.getgroups",
		"admin.mpdAddGroups",
		"admin.nhsAddGroups",
		'admin.lfbAddGroups',
		'admin.hmpAddGroups',
		"admin.spectate",
		"admin.screenshot",
		"admin.slap",
		"admin.tp2waypoint",
		"admin.tp2coords",
		"admin.removewarn",
		"admin.spawnBmx",
		"developer.fixcar",
		"admin.noclip",
		"staff.mode",
		"admin.vehmenu",
		"admin.spawnGun",
		'admin.spawncar',
		"admin.addcar",
		"admin.idsabovehead",
		"admin.smartsigns",
		"developer.fixcar",
		"admin.staffAddGroups",
		"admin.povAddGroups",
		"admin.licenseAddGroups",
		"admin.donoAddGroups",
		"group.add.vipgarage",
		'group.add.cardeveloper',
		"group.add.senioradmin",
		"group.add.administrator",
		"group.add.moderator",
		"group.add.trial",
		'group.add.pov',
		"group.add",
		"group.remove.vipgarage",
		"group.remove.senioradmin",
		"group.remove.administrator",
		"group.remove.moderator",
		"group.remove.trial",
		"group.remove",
		"admin.whitelisted",
		"admin.tickets",
		"vehicle.delete",
	},
	["senioradmin"] = {
		"admin.menu",
		"admin.warn",
		"admin.showwarn",
		"admin.ban",
		'admin.unban',
		"admin.kick",
		"admin.nof10kick",
		"admin.revive",
		"admin.tp2player",
		"admin.summon",
		"admin.freeze",
		"admin.spectate",
		"admin.screenshot",
		"admin.slap",
		"admin.tp2waypoint",
		"admin.tp2coords",
		"admin.removewarn",
		"admin.spawnBmx",
		"admin.noclip",
		"staff.mode",
		"admin.idsabovehead",
		"vehicle.delete",
		"admin.getgroups",
		'admin.forceclockoff',
		"admin.mpdAddGroups",
		"admin.nhsAddGroups",
		'admin.lfbAddGroups',
		'admin.hmpAddGroups',
		"admin.vehmenu",
		'admin.spawncar',
		"admin.addcar",
		"developer.fixcar",
		"admin.whitelisted",
		"admin.tickets",
	},
	["administrator"] = {
		"admin.menu",
		"admin.warn",
		"admin.showwarn",
		"admin.ban",
		'admin.unban',
		"admin.kick",
		"admin.nof10kick",
		"admin.revive",
		"admin.tp2player",
		"admin.summon",
		"admin.freeze",
		"admin.spectate",
		"admin.screenshot",
		"admin.slap",
		"admin.tp2waypoint",
		"admin.tp2coords",
		"admin.noclip",
		"admin.getgroups",
		'admin.forceclockoff',
		"admin.mpdAddGroups",
		"admin.nhsAddGroups",
		'admin.lfbAddGroups',
		'admin.hmpAddGroups',
		"admin.vehmenu",
		"developer.spawncar",
		"developer.deletecar",
		"developer.fixcar",
		"admin.whitelisted",
		"admin.tickets",
		"admin.spawnBmx",
		"staff.mode",
		"admin.idsabovehead",
		"vehicle.delete",
	},
	["srmoderator"] = {
		"admin.menu",
		"admin.warn",
		"admin.showwarn",
		"admin.ban",
		"admin.kick",
		"admin.nof10kick",
		"admin.revive",
		"admin.tp2player",
		"admin.summon",
		"admin.freeze",
		"admin.screenshot",
		"admin.getgroups",
		"admin.mpdAddGroups",
		"admin.nhsAddGroups",
		'admin.lfbAddGroups',
		'admin.hmpAddGroups',
		"admin.noclip",
		"admin.spectate",
		"admin.whitelisted",
		"admin.tickets",
		"admin.spawnBmx",
		"staff.mode",
		"admin.idsabovehead",
		"vehicle.delete",
	},
	["moderator"] = {
		"admin.menu",
		"admin.warn",
		"admin.showwarn",
		"admin.ban",
		"admin.kick",
		"admin.nof10kick",
		"admin.revive",
		"admin.tp2player",
		"admin.summon",
		"admin.freeze",
		"admin.screenshot",
		"admin.spectate",
		"admin.whitelisted",
		"admin.tickets",
		"admin.spawnBmx",
		"staff.mode",
		"admin.idsabovehead",
		"vehicle.delete",
	},
	["supportteam"] = {
		"admin.menu",
		"admin.ban",
		"admin.warn",
		"admin.showwarn",
		"admin.kick",
		"admin.nof10kick",
		"admin.tp2player",
		"admin.summon",
		"admin.freeze",
		"admin.whitelisted",
		"admin.tickets",
		"admin.spawnBmx",
		"staff.mode",
		"admin.idsabovehead",
		"vehicle.delete",
	},
	["trialstaff"] = {
		"admin.menu",
		"admin.warn",
		"admin.showwarn",
		"admin.kick",
		"admin.nof10kick",
		"admin.tp2player",
		"admin.summon",
		"admin.freeze",
		"admin.whitelisted",
		"admin.tickets",
		"admin.spawnBmx",
		"staff.mode",
		"admin.idsabovehead",
		"vehicle.delete",
	},
	
	--[PD GROUPS]--
	["Commissioner Clocked"] = {
		_config = {
			gtype = "job",
			onjoin = function(player)
				vRPclient.setCop(player, {true})
			end,
			onspawn = function(player)
				vRPclient.setCop(player, {true})
			end,
			onleave = function(player)
				vRPclient.setCop(player, {false})
				TriggerClientEvent("DeleteBlipsALL", player)
			end
		},
		"Chief.cloakroom",
		"police.pc",
		--"police.handcuff",
		"police.putinveh",
		"police.glock",
		"police.getoutveh",
		"police.service",
		"police.drag",
		"police.easy_cuff",
		"commissioner.paycheck",
		"police.easy_fine",
		"police.easy_jail",
		"police.easy_unjail",
		"police.spikes",
		"police.menu",
		"sco.armoury",
		"police.check",
		"police.call",
		"toggle.service",
		"police.freeze",
		"police.wanted",
		"police.seize.weapons",
		"police.seize.items",
		--"police.jail",
		--"police.fine",
		"police.announce",
		--"-police.store_weapons",
		"police.seizable", -- negative permission, police can't seize itself, even if another group add the permission
		"police.vehicle",
		"police.loadshop",
		"emergency.market",
		"emergency.revive",
		"emergency.shop",
		"police.whitelisted",
		"response.armor",
		"com.paycheck",
		"police.menu_interaction",
		"police.perms",
		"police.mission",
		"police.armoury",
		"police.keycard",
		"police.smartsigns",
	},
	["Commissioner"] = {
		"commissioner.clockon",
		"mpd_clockon.menu",
	},
	["Deputy Commissioner Clocked"] = {
		_config = {
			gtype = "job",
			onjoin = function(player)
				vRPclient.setCop(player, {true})
			end,
			onspawn = function(player)
				vRPclient.setCop(player, {true})
			end,
			onleave = function(player)
				vRPclient.setCop(player, {false})
				TriggerClientEvent("DeleteBlipsALL", player)
			end
		},
		"Chief.cloakroom",
		"police.pc",
		--"police.handcuff",
		"police.putinveh",
		"police.getoutveh",
		"deputycommissioner.paycheck",
		"police.service",
		"police.drag",
		"sco.armoury",
		"police.easy_cuff",
		"police.easy_fine",
		"police.easy_jail",
		"police.easy_unjail",
		"police.spikes",
		"police.menu",
		"police.check",
		"toggle.service",
		"police.freeze",
		"police.wanted",
		"police.seize.weapons",
		"police.glock",
		"police.seize.items",
		--"police.jail",
		--"police.fine",
		"police.announce",
		--"-police.store_weapons",
		"police.seizable", -- negative permission, police can't seize itself, even if another group add the permission
		"police.vehicle",
		"police.loadshop",
		"emergency.market",
		"emergency.revive",
		"emergency.shop",
		"police.whitelisted",
		"response.armor",
		"depcom.paycheck",
		"police.menu_interaction",
		"police.perms",
		"police.mission",
		"police.armoury",
		"police.keycard",
		"police.smartsigns",
	},
	["Deputy Commissioner"] = {
		"depcommissioner.clockon",
		"mpd_clockon.menu",
	},
	["Assistant Commissioner Clocked"] = {
		_config = {
			gtype = "job",
			onjoin = function(player)
				vRPclient.setCop(player, {true})
			end,
			onspawn = function(player)
				vRPclient.setCop(player, {true})
			end,
			onleave = function(player)
				vRPclient.setCop(player, {false})
				TriggerClientEvent("DeleteBlipsALL", player)
			end
		},
		"Chief.cloakroom",
		"police.pc",
		--"police.handcuff",
		"police.putinveh",
		"assistantcommissioner.paycheck",
		"police.getoutveh",
		"police.service",
		"police.glock",
		"police.drag",
		"sco.armoury",
		"police.easy_cuff",
		"police.easy_fine",
		"police.easy_jail",
		"police.easy_unjail",
		"police.spikes",
		"police.menu",
		"police.check",
		"toggle.service",
		"police.freeze",
		"police.wanted",
		"police.seize.weapons",
		"police.seize.items",
		--"police.jail",
		--"police.fine",
		"police.announce",
		--"-police.store_weapons",
		"police.seizable", -- negative permission, police can't seize itself, even if another group add the permission
		"police.vehicle",
		"police.loadshop",
		"emergency.market",
		"emergency.revive",
		"emergency.shop",
		"police.whitelisted",
		"response.armor",
		"assistcom.paycheck",
		"police.menu_interaction",
		"police.perms",
		"police.mission",
		"police.armoury",
		"police.keycard",
		"police.smartsigns",
	},
	["Assistant Commissioner"] = {
		"asscommissioner.clockon",
		"mpd_clockon.menu",
	},
	["Deputy Assistant Commissioner Clocked"] = {
		_config = {
			gtype = "job",
			onjoin = function(player)
				vRPclient.setCop(player, {true})
			end,
			onspawn = function(player)
				vRPclient.setCop(player, {true})
			end,
			onleave = function(player)
				vRPclient.setCop(player, {false})
				TriggerClientEvent("DeleteBlipsALL", player)
			end
		},
		"Chief.cloakroom",
		"police.pc",
		--"police.handcuff",
		"police.putinveh",
		"police.getoutveh",
		"assistantdeputycommissioner.paycheck",
		"police.service",
		"police.drag",
		"police.easy_cuff",
		"police.easy_fine",
		"police.easy_jail",
		"police.easy_unjail",
		"police.spikes",
		"sco.armoury",
		"police.menu",
		"police.check",
		"toggle.service",
		"police.glock",
		"police.freeze",
		"police.wanted",
		"police.seize.weapons",
		"police.seize.items",
		--"police.jail",
		--"police.fine",
		"police.announce",
		--"-police.store_weapons",
		"police.seizable", -- negative permission, police can't seize itself, even if another group add the permission
		"police.vehicle",
		"police.loadshop",
		"emergency.market",
		"emergency.revive",
		"emergency.shop",
		"police.whitelisted",
		"response.armor",
		"depassist.paycheck",
		"police.menu_interaction",
		"police.perms",
		"police.mission",
		"police.armoury",
		"police.keycard",
		"police.smartsigns",
	},
	["Deputy Assistant Commissioner"] = {
		"depasscommissioner.clockon",
		"mpd_clockon.menu",
	},
	["Commander Clocked"] = {
		_config = {
			gtype = "job",
			onjoin = function(player)
				vRPclient.setCop(player, {true})
			end,
			onspawn = function(player)
				vRPclient.setCop(player, {true})
			end,
			onleave = function(player)
				vRPclient.setCop(player, {false})
				TriggerClientEvent("DeleteBlipsALL", player)
			end
		},
		"Chief.cloakroom",
		"police.pc",
		--"police.handcuff",
		"police.putinveh",
		"police.getoutveh",
		"police.service",
		"police.drag",
		"sco.armoury",
		"commander.paycheck",
		"police.easy_cuff",
		"police.easy_fine",
		"police.easy_jail",
		"police.glock",
		"police.easy_unjail",
		"police.spikes",
		"police.menu",
		"police.check",
		"toggle.service",
		"police.freeze",
		"police.wanted",
		"police.seize.weapons",
		"police.seize.items",
		--"police.jail",
		--"police.fine",
		"police.announce",
		--"-police.store_weapons",
		"police.seizable", -- negative permission, police can't seize itself, even if another group add the permission
		"police.vehicle",
		"police.loadshop",
		"emergency.market",
		"emergency.revive",
		"emergency.shop",
		"police.whitelisted",
		"response.armor",
		"com.paycheck",
		"police.menu_interaction",
		"police.perms",
		"police.mission",
		"police.armoury",
		"police.keycard",
		"police.smartsigns",
	},
	["Commander"] = {
		"commander.clockon",
		"mpd_clockon.menu",
	},
	["Chief Superintendent Clocked"] = {
		_config = {
			gtype = "job",
			onjoin = function(player)
				vRPclient.setCop(player, {true})
			end,
			onspawn = function(player)
				vRPclient.setCop(player, {true})
			end,
			onleave = function(player)
				vRPclient.setCop(player, {false})
				TriggerClientEvent("DeleteBlipsALL", player)
			end
		},
		"Chief.cloakroom",
		"police.pc",
		--"police.handcuff",
		"police.putinveh",
		"chiefsuperintendent.paycheck",
		"police.getoutveh",
		"police.service",
		"police.drag",
		"police.easy_cuff",
		"police.easy_fine",
		"police.easy_jail",
		"police.easy_unjail",
		"police.spikes",
		"police.menu",
		"police.check",
		"toggle.service",
		"police.freeze",
		"police.wanted",
		"police.seize.weapons",
		"police.seize.items",
		"police.glock",
		--"police.jail",
		--"police.fine",
		--"-police.store_weapons",
		"police.seizable", -- negative permission, police can't seize itself, even if another group add the permission
		"police.vehicle",
		"police.loadshop",
		"emergency.market",
		"emergency.revive",
		"emergency.shop",
		"police.whitelisted",
		"response.armor",
		"chiefsupt.paycheck",
		"police.menu_interaction",
		"police.perms",
		"police.mission",
		"police.armoury",
		"police.keycard",
		"police.smartsigns",
	},
	["Chief Superintendent"] = {
		"chiefsupint.clockon",
		"mpd_clockon.menu",
	},
	["Superintendent Clocked"] = {
		_config = {
			gtype = "job",
			onjoin = function(player)
				vRPclient.setCop(player, {true})
			end,
			onspawn = function(player)
				vRPclient.setCop(player, {true})
			end,
			onleave = function(player)
				vRPclient.setCop(player, {false})
				TriggerClientEvent("DeleteBlipsALL", player)
			end
		},
		"Chief.cloakroom",
		"police.pc",
		--"police.handcuff",
		"police.putinveh",
		"police.getoutveh",
		"police.service",
		"police.drag",
		"police.easy_cuff",
		"police.easy_fine",
		"police.easy_jail",
		"police.easy_unjail",
		"police.spikes",
		"police.menu",
		"police.check",
		"toggle.service",
		"police.freeze",
		"police.glock",
		"police.wanted",
		"superintendent.paycheck",
		"police.seize.weapons",
		"police.seize.items",
		--"police.jail",
		--"police.fine",
		--"-police.store_weapons",
		"police.seizable", -- negative permission, police can't seize itself, even if another group add the permission
		"police.vehicle",
		"police.loadshop",
		"emergency.market",
		"emergency.revive",
		"emergency.shop",
		"police.whitelisted",
		"response.armor",
		"supt.paycheck",
		"police.menu_interaction",
		"police.perms",
		"police.mission",
		"police.armoury",
		"police.keycard",
		"police.smartsigns"
	},
	["Superintendent"] = {
		"superint.clockon",
		"mpd_clockon.menu",
	},
	["Officer of the week Clocked"] = {
		_config = {
			gtype = "job",
			onjoin = function(player)
				vRPclient.setCop(player, {true})
			end,
			onspawn = function(player)
				vRPclient.setCop(player, {true})
			end,
			onleave = function(player)
				vRPclient.setCop(player, {false})
				TriggerClientEvent("DeleteBlipsALL", player)
			end
		},
		"Chief.cloakroom",
		"police.pc",
		--"police.handcuff",
		"police.putinveh",
		"police.getoutveh",
		"police.service",
		"police.drag",
		"police.easy_cuff",
		"police.easy_fine",
		"police.easy_jail",
		"police.easy_unjail",
		"police.spikes",
		"police.menu",
		"police.check",
		"toggle.service",
		"police.freeze",
		"police.glock",
		"police.wanted",
		"police.seize.weapons",
		"police.seize.items",
		--"police.jail",
		--"police.fine",
		--"-police.store_weapons",
		"police.seizable", -- negative permission, police can't seize itself, even if another group add the permission
		"police.vehicle",
		"police.loadshop",
		"emergency.market",
		"emergency.revive",
		"emergency.shop",
		"police.whitelisted",
		"response.armor",
		"officeroftheweek.paycheck",
		"police.menu_interaction",
		"police.perms",
		"police.mission",
		"police.armoury",
		"police.keycard",
		"police.smartsigns",
	},
	["Officer of the week"] = {
		"officeroftheweek.clockon",
		"mpd_clockon.menu",
	},
	["Chief Inspector Clocked"] = {
		_config = {
			gtype = "job",
			onjoin = function(player)
				vRPclient.setCop(player, {true})
			end,
			onspawn = function(player)
				vRPclient.setCop(player, {true})
			end,
			onleave = function(player)
				vRPclient.setCop(player, {false})
				TriggerClientEvent("DeleteBlipsALL", player)
			end
		},
		"Chief.cloakroom",
		"police.pc",
		--"police.handcuff",
		"police.putinveh",
		"police.getoutveh",
		"police.service",
		"chiefinspector.paycheck",
		"police.drag",
		"police.easy_cuff",
		"police.easy_fine",
		"police.easy_jail",
		"police.easy_unjail",
		"police.spikes",
		"police.menu",
		"police.glock",
		"police.check",
		"toggle.service",
		"police.freeze",
		"police.wanted",
		"police.seize.weapons",
		"police.seize.items",
		--"police.jail",
		--"police.fine",
		--"-police.store_weapons",
		"police.seizable", -- negative permission, police can't seize itself, even if another group add the permission
		"police.vehicle",
		"police.loadshop",
		"emergency.market",
		"emergency.revive",
		"emergency.shop",
		"police.whitelisted",
		"response.armor",
		"chiefinspector.paycheck",
		"police.menu_interaction",
		"police.perms",
		"police.mission",
		"police.armoury",
		"police.keycard",
		"police.smartsigns",
	},
	["Chief Inspector"] = {
		"chiefinsp.clockon",
		"mpd_clockon.menu",
	},
	["Inspector Clocked"] = {
		_config = {
			gtype = "job",
			onjoin = function(player)
				vRPclient.setCop(player, {true})
			end,
			onspawn = function(player)
				vRPclient.setCop(player, {true})
			end,
			onleave = function(player)
				vRPclient.setCop(player, {false})
				TriggerClientEvent("DeleteBlipsALL", player)
			end
		},
		"Chief.cloakroom",
		"police.pc",
		--"police.handcuff",
		"police.putinveh",
		"police.getoutveh",
		"police.service",
		"police.drag",
		"police.easy_cuff",
		"police.easy_fine",
		"police.easy_jail",
		"police.easy_unjail",
		"police.spikes",
		"inspector.paycheck",
		"police.menu",
		"police.check",
		"toggle.service",
		"police.freeze",
		"police.glock",
		"police.wanted",
		"police.seize.weapons",
		"police.seize.items",
		--"police.jail",
		--"police.fine",
		--"-police.store_weapons",
		"police.seizable", -- negative permission, police can't seize itself, even if another group add the permission
		"police.vehicle",
		"police.loadshop",
		"emergency.market",
		"emergency.revive",
		"emergency.shop",
		"police.whitelisted",
		"response.armor",
		"inspector.paycheck",
		"police.menu_interaction",
		"police.perms",
		"police.mission",
		"police.armoury",
		"police.keycard",
		"police.smartsigns",
	},
	["Inspector"] = {
		"inspector.clockon",
		"mpd_clockon.menu",
	},
	["Sergeant Clocked"] = {
		_config = {
			gtype = "job",
			onjoin = function(player)
				vRPclient.setCop(player, {true})
			end,
			onspawn = function(player)
				vRPclient.setCop(player, {true})
			end,
			onleave = function(player)
				vRPclient.setCop(player, {false})
				TriggerClientEvent("DeleteBlipsALL", player)
			end
		},
		"Chief.cloakroom",
		"police.pc",
		--"police.handcuff",
		"police.putinveh",
		"police.getoutveh",
		"police.service",
		"police.drag",
		"police.easy_cuff",
		"police.easy_fine",
		"police.easy_jail",
		"sergeant.paycheck",
		"police.easy_unjail",
		"police.glock",
		"police.spikes",
		"police.menu",
		"police.check",
		"toggle.service",
		"police.freeze",
		"police.wanted",
		"police.seize.weapons",
		"police.seize.items",
		--"police.jail",
		--"police.fine",
		--"-police.store_weapons",
		"police.seizable", -- negative permission, police can't seize itself, even if another group add the permission
		"police.vehicle",
		"police.loadshop",
		"emergency.market",
		"emergency.revive",
		"emergency.shop",
		"police.whitelisted",
		"response.armor",
		"sergeant.paycheck",
		"police.menu_interaction",
		"police.perms",
		"police.mission",
		"police.armoury",
		"police.keycard",
		"police.smartsigns",
	},
	["Sergeant"] = {
		"sgt.clockon",
		"mpd_clockon.menu",
	},
	["Special Constable Clocked"] = {
		_config = {
			gtype = "job",
			onjoin = function(player)
				vRPclient.setCop(player, {true})
			end,
			onspawn = function(player)
				vRPclient.setCop(player, {true})
			end,
			onleave = function(player)
				vRPclient.setCop(player, {false})
				TriggerClientEvent("DeleteBlipsALL", player)
			end
		},
		"Chief.cloakroom",
		"police.pc",
		--"police.handcuff",
		"police.putinveh",
		"police.getoutveh",
		"police.service",
		"police.announce",
		"police.drag",
		"police.easy_cuff",
		"police.easy_fine",
		"police.easy_jail",
		"police.easy_unjail",
		"police.glock",
		"faction.drone",
		"police.spikes",
		"police.menu",
		"police.check",
		"toggle.service",
		"police.freeze",
		"police.wanted",
		"police.seize.weapons",
		"police.seize.items",
		--"police.jail",
		--"police.fine",
		--"-police.store_weapons",
		"police.seizable", -- negative permission, police can't seize itself, even if another group add the permission
		"police.vehicle",
		"police.loadshop",
		"emergency.market",
		"emergency.revive",
		"emergency.shop",
		"police.whitelisted",
		"response.armor",
		"spc.paycheck",
		"police.menu_interaction",
		"police.perms",
		"police.mission",
		"police.armoury",
		"police.keycard",
		"police.smartsigns",
	},
	["Special Constable"] = {
		"specialpc.clockon",
		"mpd_clockon.menu",
	},
	["Senior Constable Clocked"] = {
		_config = {
			gtype = "job",
			onjoin = function(player)
				vRPclient.setCop(player, {true})
			end,
			onspawn = function(player)
				vRPclient.setCop(player, {true})
			end,
			onleave = function(player)
				vRPclient.setCop(player, {false})
				TriggerClientEvent("DeleteBlipsALL", player)
			end
		},
		"Chief.cloakroom",
		"police.pc",
		--"police.handcuff",
		"police.putinveh",
		"police.getoutveh",
		"police.service",
		"police.drag",
		"police.easy_cuff",
		"police.easy_fine",
		"police.easy_jail",
		"police.easy_unjail",
		"police.spikes",
		"police.menu",
		"police.check",
		"toggle.service",
		"police.freeze",
		"police.wanted",
		"police.glock",
		"police.seize.weapons",
		"police.seize.items",
		--"police.jail",
		--"police.fine",
		"sc.paycheck",
		--"-police.store_weapons",
		"police.seizable", -- negative permission, police can't seize itself, even if another group add the permission
		"police.vehicle",
		"police.loadshop",
		"emergency.market",
		"emergency.revive",
		"emergency.shop",
		"police.whitelisted",
		"response.armor",
		"seniorconstable.paycheck",
		"police.menu_interaction",
		"police.perms",
		"police.mission",
		"police.armoury",
		"police.keycard",
		"police.smartsigns",
	},
	["Senior Constable"] = {
		"seniorconstable.clockon",
		"mpd_clockon.menu",
	},
	["Police Constable Clocked"] = {
		_config = {
			gtype = "job",
			onjoin = function(player)
				vRPclient.setCop(player, {true})
			end,
			onspawn = function(player)
				vRPclient.setCop(player, {true})
			end,
			onleave = function(player)
				vRPclient.setCop(player, {false})
				TriggerClientEvent("DeleteBlipsALL", player)
			end
		},
		"Chief.cloakroom",
		"police.pc",
		--"police.handcuff",
		"police.putinveh",
		"police.getoutveh",
		"police.service",
		"police.drag",
		"police.easy_cuff",
		"police.easy_fine",
		"police.easy_jail",
		"police.easy_unjail",
		"police.spikes",
		"police.menu",
		"police.check",
		"toggle.service",
		"police.freeze",
		"police.wanted",
		"police.seize.weapons",
		"police.seize.items",
		--"police.jail",
		--"police.fine",
		--"-police.store_weapons",
		"police.seizable", -- negative permission, police can't seize itself, even if another group add the permission
		"police.vehicle",
		"police.loadshop",
		"emergency.market",
		"emergency.revive",
		"emergency.shop",
		"police.whitelisted",
		"police.glock",
		"response.armor",
		"policeconstable.paycheck",
		"police.menu_interaction",
		"police.perms",
		"police.mission",
		"police.armoury",
		"police.keycard",
		"police.smartsigns",
	},
	["Police Constable"] = {
		"pc.clockon",
		"mpd_clockon.menu",
	},
	["PCSO Clocked"] = {
		_config = {
			gtype = "job",
			onjoin = function(player)
				vRPclient.setCop(player, {true})
			end,
			onspawn = function(player)
				vRPclient.setCop(player, {true})
			end,
			onleave = function(player)
				vRPclient.setCop(player, {false})
				TriggerClientEvent("DeleteBlipsALL", player)
			end
		},
		"Chief.cloakroom",
		"police.pc",
		--"police.handcuff",
		"police.putinveh",
		"police.getoutveh",
		"police.service",
		"police.drag",
		"police.easy_cuff",
		"police.easy_fine",
		"police.easy_jail",
		"police.easy_unjail",
		"police.spikes",
		"police.menu",
		"police.check",
		"toggle.service",
		"police.freeze",
		"police.wanted",
		"police.seize.weapons",
		"police.seize.items",
		--"police.jail",
		--"police.fine",
		--"-police.store_weapons",
		"police.seizable", -- negative permission, police can't seize itself, even if another group add the permission
		"police.vehicle",
		"police.loadshop",
		"emergency.market",
		"emergency.revive",
		"emergency.shop",
		"police.whitelisted",
		"police.glock",
		"pcso.armor",
		"pcso.paycheck",
		"police.menu_interaction",
		"police.perms",
		"police.mission",
		"police.armoury",
		"police.keycard",
		"police.smartsigns",
	},
	["PCSO"] = {
		"pcso.clockon",
		"mpd_clockon.menu",
	},
	["SCO-19"] = {
		"sco.armoury",
	},
	['MPD Needs Training Clocked'] = {
		_config = {
			gtype = "job",
			onjoin = function(player)
				vRPclient.setCop(player, {true})
			end,
			onspawn = function(player)
				vRPclient.setCop(player, {true})
			end,
			onleave = function(player)
				vRPclient.setCop(player, {false})
				TriggerClientEvent("DeleteBlipsALL", player)
			end
		},
		"Chief.cloakroom",
		"police.pc",
		--"police.handcuff",
		"police.putinveh",
		"police.getoutveh",
		"police.service",
		"police.drag",
		"police.easy_cuff",
		"police.easy_fine",
		"police.easy_jail",
		"police.easy_unjail",
		"police.spikes",
		"police.menu",
		"police.check",
		"toggle.service",
		"police.freeze",
		"police.wanted",
		"police.seize.weapons",
		"police.seize.items",
		--"police.jail",
		--"police.fine",
		--"-police.store_weapons",
		"police.seizable", -- negative permission, police can't seize itself, even if another group add the permission
		"police.vehicle",
		"police.loadshop",
		"emergency.market",
		"emergency.revive",
		"emergency.shop",
		"police.whitelisted",
		"police.glock",
		"mpd_needs_training.armor",
		"mpd_needs_training.paycheck",
		"police.menu_interaction",
		"police.perms",
		"police.mission",
		"police.armoury",
		"police.keycard",
		"police.smartsigns",
	},
	['MPD Needs Training'] = {
		"mpd_needs_training.clockon",
		"mpd_clockon.menu",
	},
	['MPD Suspended'] = {
		_config = {
			onjoin = function(player)
				vRPclient.Set_MPD_Suspended(player, {true})
				TriggerEvent('Nova:Server:DutyMenu:ClockOff', 'MPD', player)
			end,
			onspawn = function(player)
				vRPclient.Set_MPD_Suspended(player, {true})
			end,
			onleave = function(player)
				vRPclient.Set_MPD_Suspended(player, {false})
			end
		},
		"mpd_clockon.menu",
	},

	["Chief Medical Director Clocked"] = {
		_config = {
			gtype = "job",
			onjoin = function(player)
				vRPclient.setNHS(player, {true})
			end,
			onspawn = function(player)
				vRPclient.setNHS(player, {true})
			end,
			onleave = function(player)
				vRPclient.setNHS(player, {false})
				TriggerClientEvent("DeleteBlipsALL", player)
			end
		},
		"nhs.cloakroom",
		"nhs.drag",
		"nhs.menu",
		"nhs.check",
		"nhs.announce",
		"emergency.revive",
		"cmd.paycheck",
	},
	["Chief Medical Director"] = {
		"cmd.clockon",
		"nhs_clockon.menu",
	},
	["Deputy Medical Director Clocked"] = {
		_config = {
			gtype = "job",
			onjoin = function(player)
				vRPclient.setNHS(player, {true})
			end,
			onspawn = function(player)
				vRPclient.setNHS(player, {true})
			end,
			onleave = function(player)
				vRPclient.setNHS(player, {false})
				TriggerClientEvent("DeleteBlipsALL", player)
			end
		},
		"nhs.cloakroom",
		"nhs.drag",
		"nhs.menu",
		"nhs.check",
		"nhs.announce",
		"emergency.revive",
		"dmd.paycheck",
	},
	["Deputy Medical Director"] = {
		"dmd.clockon",
		"nhs_clockon.menu",
	},
	["Assistant Medical Director Clocked"] = {
		_config = {
			gtype = "job",
			onjoin = function(player)
				vRPclient.setNHS(player, {true})
			end,
			onspawn = function(player)
				vRPclient.setNHS(player, {true})
			end,
			onleave = function(player)
				vRPclient.setNHS(player, {false})
				TriggerClientEvent("DeleteBlipsALL", player)
			end
		},
		"nhs.cloakroom",
		"nhs.drag",
		"nhs.menu",
		"nhs.check",
		"nhs.announce",
		"emergency.revive",
		"amd.paycheck",
	},
	["Assistant Medical Director"] = {
		"amd.clockon",
		"nhs_clockon.menu",
	},
	["Captain Clocked"] = {
		_config = {
			gtype = "job",
			onjoin = function(player)
				vRPclient.setNHS(player, {true})
			end,
			onspawn = function(player)
				vRPclient.setNHS(player, {true})
			end,
			onleave = function(player)
				vRPclient.setNHS(player, {false})
				TriggerClientEvent("DeleteBlipsALL", player)
			end
		},
		"nhs.cloakroom",
		"nhs.drag",
		"nhs.menu",
		"nhs.check",
		"emergency.revive",
		"captain.paycheck",
	},
	["Captain"] = {
		"captain.clockon",
		"nhs_clockon.menu",
	},
	["Specialist Clocked"] = {
		_config = {
			gtype = "job",
			onjoin = function(player)
				vRPclient.setNHS(player, {true})
			end,
			onspawn = function(player)
				vRPclient.setNHS(player, {true})
			end,
			onleave = function(player)
				vRPclient.setNHS(player, {false})
				TriggerClientEvent("DeleteBlipsALL", player)
			end
		},
		"nhs.cloakroom",
		"nhs.drag",
		"nhs.menu",
		"nhs.check",
		"emergency.revive",
		"specialist.paycheck",
	},
	["Specialist"] = {
		"specialist.clockon",
		"nhs_clockon.menu",
	},
	["Medic of the week Clocked"] = {
		_config = {
			gtype = "job",
			onjoin = function(player)
				vRPclient.setNHS(player, {true})
			end,
			onspawn = function(player)
				vRPclient.setNHS(player, {true})
			end,
			onleave = function(player)
				vRPclient.setNHS(player, {false})
				TriggerClientEvent("DeleteBlipsALL", player)
			end
		},
		"nhs.cloakroom",
		"nhs.drag",
		"nhs.menu",
		"nhs.check",
		"emergency.revive",
		"medicoftheweek.paycheck",
	},
	["Medic of the week"] = {
		"medicoftheweek.clockon",
		"nhs_clockon.menu",
	},
	["Senior Doctor Clocked"] = {
		_config = {
			gtype = "job",
			onjoin = function(player)
				vRPclient.setNHS(player, {true})
			end,
			onspawn = function(player)
				vRPclient.setNHS(player, {true})
			end,
			onleave = function(player)
				vRPclient.setNHS(player, {false})
				TriggerClientEvent("DeleteBlipsALL", player)
			end
		},
		"nhs.cloakroom",
		"nhs.drag",
		"nhs.menu",
		"nhs.check",
		"emergency.revive",
		"sd.paycheck",
	},
	["Senior Doctor"] = {
		"sd.clockon",
		"nhs_clockon.menu",
	},
	["Doctor Clocked"] = {
		_config = {
			gtype = "job",
			onjoin = function(player)
				vRPclient.setNHS(player, {true})
			end,
			onspawn = function(player)
				vRPclient.setNHS(player, {true})
			end,
			onleave = function(player)
				vRPclient.setNHS(player, {false})
				TriggerClientEvent("DeleteBlipsALL", player)
			end
		},
		"nhs.cloakroom",
		"nhs.drag",
		"nhs.menu",
		"nhs.check",
		"emergency.revive",
		"doctor.paycheck",
	},
	["Doctor"] = {
		"doctor.clockon",
		"nhs_clockon.menu",
	},
	["Junior Doctor Clocked"] = {
		_config = {
			gtype = "job",
			onjoin = function(player)
				vRPclient.setNHS(player, {true})
			end,
			onspawn = function(player)
				vRPclient.setNHS(player, {true})
			end,
			onleave = function(player)
				vRPclient.setNHS(player, {false})
				TriggerClientEvent("DeleteBlipsALL", player)
			end
		},
		"nhs.cloakroom",
		"nhs.drag",
		"nhs.menu",
		"nhs.check",
		"emergency.revive",
		"juniordoctor.paycheck",
	},
	["Junior Doctor"] = {
		"juniordoctor.clockon",
		"nhs_clockon.menu",
	},
	["Critical Care Paramedic Clocked"] = {
		_config = {
			gtype = "job",
			onjoin = function(player)
				vRPclient.setNHS(player, {true})
			end,
			onspawn = function(player)
				vRPclient.setNHS(player, {true})
			end,
			onleave = function(player)
				vRPclient.setNHS(player, {false})
				TriggerClientEvent("DeleteBlipsALL", player)
			end
		},
		"nhs.cloakroom",
		"nhs.drag",
		"nhs.menu",
		"nhs.check",
		"emergency.revive",
		"ccp.paycheck",
	},
	["Critical Care Paramedic"] = {
		"ccp.clockon",
		"nhs_clockon.menu",
	},
	["Paramedic Clocked"] = {
		_config = {
			gtype = "job",
			onjoin = function(player)
				vRPclient.setNHS(player, {true})
			end,
			onspawn = function(player)
				vRPclient.setNHS(player, {true})
			end,
			onleave = function(player)
				vRPclient.setNHS(player, {false})
				TriggerClientEvent("DeleteBlipsALL", player)
			end
		},
		"nhs.cloakroom",
		"nhs.drag",
		"nhs.menu",
		"nhs.check",
		"emergency.revive",
		"paramedic.paycheck",
	},
	["Paramedic"] = {
		"paramedic.clockon",
		"nhs_clockon.menu",
	},
	["Trainee Paramedic Clocked"] = {
		_config = {
			gtype = "job",
			onjoin = function(player)
				vRPclient.setNHS(player, {true})
			end,
			onspawn = function(player)
				vRPclient.setNHS(player, {true})
			end,
			onleave = function(player)
				vRPclient.setNHS(player, {false})
				TriggerClientEvent("DeleteBlipsALL", player)
			end
		},
		"nhs.cloakroom",
		"nhs.drag",
		"nhs.menu",
		"nhs.check",
		"emergency.revive",
		"trainee.paycheck",
	},
	["Trainee Paramedic"] = {
		"trainee.clockon",
		"nhs_clockon.menu",
	},
	['NHS Needs Training Clocked'] = {
		_config = {
			gtype = "job",
			onjoin = function(player)
				vRPclient.setNHS(player, {true})
			end,
			onspawn = function(player)
				vRPclient.setNHS(player, {true})
			end,
			onleave = function(player)
				vRPclient.setNHS(player, {false})
				TriggerClientEvent("DeleteBlipsALL", player)
			end
		},
		"nhs.cloakroom",
		"nhs.drag",
		"nhs.menu",
		"nhs.check",
		"emergency.revive",
		"nhs_needs_training.paycheck",
	},
	['NHS Needs Training'] = {
		"nhs_needs_training.clockon",
		"nhs_clockon.menu",
	},
	['NHS Suspended'] = {
		_config = {
			onjoin = function(player)
				vRPclient.Set_NHS_Suspended(player, {true})
				TriggerEvent('Nova:Server:DutyMenu:ClockOff', 'NHS', player)
			end,
			onspawn = function(player)
				vRPclient.Set_NHS_Suspended(player, {true})
			end,
			onleave = function(player)
				vRPclient.Set_NHS_Suspended(player, {false})
			end
		},
		"nhs_clockon.menu",
	},
	
	["Governor Clocked"] = {
		_config = {
			gtype = "job",
			onjoin = function(player)
				vRPclient.setHMP(player, {true})
			end,
			onspawn = function(player)
				vRPclient.setHMP(player, {true})
			end,
			onleave = function(player)
				vRPclient.setHMP(player, {false})
				TriggerClientEvent("DeleteBlipsALL", player)
			end
		},
		"hmp.cloakroom",
		"hmp.announce",
		"hmp.drag",
		"hmp.menu",
		"hmp.check",
		"emergency.revive",
		"gov.paycheck",
	},
	["Governor"] = {
		"gov.clockon",
		"hmp_clockon.menu",
	},
	["Deputy Governor Clocked"] = {
		_config = {
			gtype = "job",
			onjoin = function(player)
				vRPclient.setHMP(player, {true})
			end,
			onspawn = function(player)
				vRPclient.setHMP(player, {true})
			end,
			onleave = function(player)
				vRPclient.setHMP(player, {false})
				TriggerClientEvent("DeleteBlipsALL", player)
			end
		},
		"hmp.cloakroom",
		"hmp.announce",
		"hmp.drag",
		"hmp.menu",
		"hmp.check",
		"emergency.revive",
		"depgov.paycheck",
	},
	["Deputy Governor"] = {
		"depgov.clockon",
		"hmp_clockon.menu",
	},
	["Assistant Governor Clocked"] = {
		_config = {
			gtype = "job",
			onjoin = function(player)
				vRPclient.setHMP(player, {true})
			end,
			onspawn = function(player)
				vRPclient.setHMP(player, {true})
			end,
			onleave = function(player)
				vRPclient.setHMP(player, {false})
				TriggerClientEvent("DeleteBlipsALL", player)
			end
		},
		"hmp.cloakroom",
		"hmp.announce",
		"hmp.drag",
		"hmp.menu",
		"hmp.check",
		"emergency.revive",
		"assistantgovernor.paycheck",
	},
	["Assistant Governor"] = {
		"assistantgovernor.clockon",
		"hmp_clockon.menu",
	},
	["Custodial Supervisor Clocked"] = {
		_config = {
			gtype = "job",
			onjoin = function(player)
				vRPclient.setHMP(player, {true})
			end,
			onspawn = function(player)
				vRPclient.setHMP(player, {true})
			end,
			onleave = function(player)
				vRPclient.setHMP(player, {false})
				TriggerClientEvent("DeleteBlipsALL", player)
			end
		},
		"hmp.cloakroom",
		"hmp.drag",
		"hmp.menu",
		"hmp.check",
		"emergency.revive",
		"custodialsupervisor.paycheck",
	},
	["Custodial Supervisor"] = {
		"custodialsupervisor.clockon",
		"hmp_clockon.menu",
	},
	["Custodial Officer Clocked"] = {
		_config = {
			gtype = "job",
			onjoin = function(player)
				vRPclient.setHMP(player, {true})
			end,
			onspawn = function(player)
				vRPclient.setNHS(player, {true})
			end,
			onleave = function(player)
				vRPclient.setHMP(player, {false})
				TriggerClientEvent("DeleteBlipsALL", player)
			end
		},
		"hmp.cloakroom",
		"hmp.drag",
		"hmp.menu",
		"hmp.check",
		"emergency.revive",
		"custodialofficer.paycheck",
	},
	["Custodial Officer"] = {
		"custodialofficer.clockon",
		"hmp_clockon.menu",
	},
	["Honourable Guard Clocked"] = {
		_config = {
			gtype = "job",
			onjoin = function(player)
				vRPclient.setHMP(player, {true})
			end,
			onspawn = function(player)
				vRPclient.setHMP(player, {true})
			end,
			onleave = function(player)
				vRPclient.setHMP(player, {false})
				TriggerClientEvent("DeleteBlipsALL", player)
			end
		},
		"hmp.cloakroom",
		"hmp.drag",
		"hmp.menu",
		"hmp.check",
		"emergency.revive",
		"hguard.paycheck",
	},
	["Honourable Guard"] = {
		"hguard.clockon",
		"hmp_clockon.menu",
	},
	["Guard of the week Clocked"] = {
		_config = {
			gtype = "job",
			onjoin = function(player)
				vRPclient.setHMP(player, {true})
			end,
			onspawn = function(player)
				vRPclient.setHMP(player, {true})
			end,
			onleave = function(player)
				vRPclient.setHMP(player, {false})
				TriggerClientEvent("DeleteBlipsALL", player)
			end
		},
		"hmp.cloakroom",
		"hmp.drag",
		"hmp.menu",
		"hmp.check",
		"emergency.revive",
		"guardoftheweek.paycheck",
	},
	["Guard of the week"] = {
		"guardoftheweek.clockon",
		"hmp_clockon.menu",
	},
	["Supervising Officer Clocked"] = {
		_config = {
			gtype = "job",
			onjoin = function(player)
				vRPclient.setHMP(player, {true})
			end,
			onspawn = function(player)
				vRPclient.setHMP(player, {true})
			end,
			onleave = function(player)
				vRPclient.setHMP(player, {false})
				TriggerClientEvent("DeleteBlipsALL", player)
			end
		},
		"hmp.cloakroom",
		"hmp.drag",
		"hmp.menu",
		"hmp.check",
		"emergency.revive",
		"sofficer.paycheck",
	},
	["Supervising Officer"] = {
		"sofficer.clockon",
		"hmp_clockon.menu",
	},
	["Principal Officer Clocked"] = {
		_config = {
			gtype = "job",
			onjoin = function(player)
				vRPclient.setHMP(player, {true})
			end,
			onspawn = function(player)
				vRPclient.setHMP(player, {true})
			end,
			onleave = function(player)
				vRPclient.setHMP(player, {false})
				TriggerClientEvent("DeleteBlipsALL", player)
			end
		},
		"hmp.cloakroom",
		"hmp.drag",
		"hmp.menu",
		"hmp.check",
		"emergency.revive",
		"principal.paycheck",
	},
	["Principal Officer"] = {
		"principal.clockon",
		"hmp_clockon.menu",
	},
	["Specialist Officer Clocked"] = {
		_config = {
			gtype = "job",
			onjoin = function(player)
				vRPclient.setHMP(player, {true})
			end,
			onspawn = function(player)
				vRPclient.setHMP(player, {true})
			end,
			onleave = function(player)
				vRPclient.setHMP(player, {false})
				TriggerClientEvent("DeleteBlipsALL", player)
			end
		},
		"hmp.cloakroom",
		"hmp.drag",
		"hmp.menu",
		"hmp.check",
		"emergency.revive",
		"specialist.paycheck",
	},
	["Specialist Officer"] = {
		"specialistofficer.clockon",
		"hmp_clockon.menu",
	},
	["Senior Officer Clocked"] = {
		_config = {
			gtype = "job",
			onjoin = function(player)
				vRPclient.setHMP(player, {true})
			end,
			onspawn = function(player)
				vRPclient.setHMP(player, {true})
			end,
			onleave = function(player)
				vRPclient.setHMP(player, {false})
				TriggerClientEvent("DeleteBlipsALL", player)
			end
		},
		"hmp.cloakroom",
		"hmp.drag",
		"hmp.menu",
		"hmp.check",
		"emergency.revive",
		"so.paycheck",
	},
	["Senior Officer"] = {
		"so.clockon",
		"hmp_clockon.menu",
	},
	["Prison Officer Clocked"] = {
		_config = {
			gtype = "job",
			onjoin = function(player)
				vRPclient.setHMP(player, {true})
			end,
			onspawn = function(player)
				vRPclient.setHMP(player, {true})
			end,
			onleave = function(player)
				vRPclient.setHMP(player, {false})
				TriggerClientEvent("DeleteBlipsALL", player)
			end
		},
		"hmp.cloakroom",
		"hmp.drag",
		"hmp.menu",
		"hmp.check",
		"emergency.revive",
		"prisonofficer.paycheck",
	},
	["Prison Officer"] = {
		"prisonofficer.clockon",
		"hmp_clockon.menu",
	},
	["Trainee Prison Officer Clocked"] = {
		_config = {
			gtype = "job",
			onjoin = function(player)
				vRPclient.setHMP(player, {true})
			end,
			onspawn = function(player)
				vRPclient.setHMP(player, {true})
			end,
			onleave = function(player)
				vRPclient.setHMP(player, {false})
				TriggerClientEvent("DeleteBlipsALL", player)
			end
		},
		"hmp.cloakroom",
		"hmp.drag",
		"hmp.menu",
		"hmp.check",
		"emergency.revive",
		"tpo.paycheck",
	},
	["Trainee Prison Officer"] = {
		"tpo.clockon",
		"hmp_clockon.menu",
	},
	['HMP Needs Training Clocked'] = {
		_config = {
			gtype = "job",
			onjoin = function(player)
				vRPclient.setHMP(player, {true})
			end,
			onspawn = function(player)
				vRPclient.setHMP(player, {true})
			end,
			onleave = function(player)
				vRPclient.setHMP(player, {false})
				TriggerClientEvent("DeleteBlipsALL", player)
			end
		},
		"hmp.cloakroom",
		"hmp.drag",
		"hmp.menu",
		"hmp.check",
		"emergency.revive",
		"hmp_needs_training.paycheck",
	},
	['HMP Needs Training'] = {
		"hmp_needs_training.clockon",
		"hmp_clockon.menu",
	},
	['HMP Suspended'] = {
		_config = {
			onjoin = function(player)
				vRPclient.Set_HMP_Suspended(player, {true})
				TriggerEvent('Nova:Server:DutyMenu:ClockOff', 'HMP', player)
			end,
			onspawn = function(player)
				vRPclient.Set_HMP_Suspended(player, {true})
			end,
			onleave = function(player)
				vRPclient.Set_HMP_Suspended(player, {false})
			end
		},
		"hmp_clockon.menu",
	},

	-- LFB
	["Chief Fire Command Clocked"] = {
		_config = {
			gtype = "job",
			onjoin = function(player)
				vRPclient.setLFB(player, {true})
			end,
			onspawn = function(player)
				vRPclient.setLFB(player, {true})
			end,
			onleave = function(player)
				vRPclient.setLFB(player, {false})
				TriggerClientEvent("DeleteBlipsALL", player)
			end
		},
		"lfb.cloakroom",
		"lfb.drag",
		"lfb.announce",
		"lfb.menu",
		"lfb.check",
		"lfb.revive",
		"chieffirecommand.paycheck",
	},
	["Chief Fire Command"] = {
		"chieffirecommand.clockon",
		"lfb_clockon.menu",
	},
	["Divisional Command Clocked"] = {
		_config = {
			gtype = "job",
			onjoin = function(player)
				vRPclient.setLFB(player, {true})
			end,
			onspawn = function(player)
				vRPclient.setLFB(player, {true})
			end,
			onleave = function(player)
				vRPclient.setLFB(player, {false})
				TriggerClientEvent("DeleteBlipsALL", player)
			end
		},
		"lfb.cloakroom",
		"lfb.drag",
		"lfb.menu",
		"lfb.check",
		"lfb.revive",
		"divisionalcommand.paycheck",
	},
	["Divisional Command"] = {
		"divisionalcommand.clockon",
		"lfb_clockon.menu",
	},
	["Sector Command Clocked"] = {
		_config = {
			gtype = "job",
			onjoin = function(player)
				vRPclient.setLFB(player, {true})
			end,
			onspawn = function(player)
				vRPclient.setLFB(player, {true})
			end,
			onleave = function(player)
				vRPclient.setLFB(player, {false})
				TriggerClientEvent("DeleteBlipsALL", player)
			end
		},
		"lfb.cloakroom",
		"lfb.drag",
		"lfb.menu",
		"lfb.check",
		"lfb.revive",
		"sectorcommand.paycheck",
	},
	["Sector Command"] = {
		"sectorcommand.clockon",
		"lfb_clockon.menu",
	},
	['Honourable Firefighter Clocked'] = {
		_config = {
			gtype = "job",
			onjoin = function(player)
				vRPclient.setLFB(player, {true})
			end,
			onspawn = function(player)
				vRPclient.setLFB(player, {true})
			end,
			onleave = function(player)
				vRPclient.setLFB(player, {false})
				TriggerClientEvent("DeleteBlipsALL", player)
			end
		},
		"lfb.cloakroom",
		"lfb.drag",
		"lfb.menu",
		"lfb.check",
		"lfb.revive",
		"honourablefirefighter.paycheck",
	},
	['Honourable Firefighter'] = {
		'honourablefirefighter.clockon',
		'lfb_clockon.menu',
	},
	['Firefighter of the week Clocked'] = {
		_config = {
			gtype = "job",
			onjoin = function(player)
				vRPclient.setLFB(player, {true})
			end,
			onspawn = function(player)
				vRPclient.setLFB(player, {true})
			end,
			onleave = function(player)
				vRPclient.setLFB(player, {false})
				TriggerClientEvent("DeleteBlipsALL", player)
			end
		},
		"lfb.cloakroom",
		"lfb.drag",
		"lfb.menu",
		"lfb.check",
		"lfb.revive",
		"firefighteroftheweek.paycheck",
	},
	['Firefighter of the week'] = {
		'firefighteroftheweek.clockon',
		'lfb_clockon.menu',
	},
	["Leading Firefighter Clocked"] = {
		_config = {
			gtype = "job",
			onjoin = function(player)
				vRPclient.setLFB(player, {true})
			end,
			onspawn = function(player)
				vRPclient.setLFB(player, {true})
			end,
			onleave = function(player)
				vRPclient.setLFB(player, {false})
				TriggerClientEvent("DeleteBlipsALL", player)
			end
		},
		"lfb.cloakroom",
		"lfb.drag",
		"lfb.menu",
		"lfb.check",
		"lfb.revive",
		"leadingfirefighter.paycheck",
	},
	["Leading Firefighter"] = {
		"leadingfirefighter.clockon",
		"lfb_clockon.menu",
	},
	["Specialist Firefighter Clocked"] = {
		_config = {
			gtype = "job",
			onjoin = function(player)
				vRPclient.setLFB(player, {true})
			end,
			onspawn = function(player)
				vRPclient.setLFB(player, {true})
			end,
			onleave = function(player)
				vRPclient.setLFB(player, {false})
				TriggerClientEvent("DeleteBlipsALL", player)
			end
		},
		"lfb.cloakroom",
		"lfb.drag",
		"lfb.menu",
		"lfb.check",
		"lfb.revive",
		"specialistfirefighter.paycheck",
	},
	["Specialist Firefighter"] = {
		"specialistfirefighter.clockon",
		"lfb_clockon.menu",
	},
	["Advanced Firefighter Clocked"] = {
		_config = {
			gtype = "job",
			onjoin = function(player)
				vRPclient.setLFB(player, {true})
			end,
			onspawn = function(player)
				vRPclient.setLFB(player, {true})
			end,
			onleave = function(player)
				vRPclient.setLFB(player, {false})
				TriggerClientEvent("DeleteBlipsALL", player)
			end
		},
		"lfb.cloakroom",
		"lfb.drag",
		"lfb.menu",
		"lfb.check",
		"lfb.revive",
		"advancedfirefighter.paycheck",
	},
	["Advanced Firefighter"] = {
		"advancedfirefighter.clockon",
		"lfb_clockon.menu",
	},
	["Senior Firefighter Clocked"] = {
		_config = {
			gtype = "job",
			onjoin = function(player)
				vRPclient.setLFB(player, {true})
			end,
			onspawn = function(player)
				vRPclient.setLFB(player, {true})
			end,
			onleave = function(player)
				vRPclient.setLFB(player, {false})
				TriggerClientEvent("DeleteBlipsALL", player)
			end
		},
		"lfb.cloakroom",
		"lfb.drag",
		"lfb.menu",
		"lfb.check",
		"lfb.revive",
		"seniorfirefighter.paycheck",
	},
	["Senior Firefighter"] = {
		"seniorfirefighter.clockon",
		"lfb_clockon.menu",
	},
	["Firefighter Clocked"] = {
		_config = {
			gtype = "job",
			onjoin = function(player)
				vRPclient.setLFB(player, {true})
			end,
			onspawn = function(player)
				vRPclient.setLFB(player, {true})
			end,
			onleave = function(player)
				vRPclient.setLFB(player, {false})
				TriggerClientEvent("DeleteBlipsALL", player)
			end
		},
		"lfb.cloakroom",
		"lfb.drag",
		"lfb.menu",
		"lfb.check",
		"lfb.revive",
		"firefighter.paycheck",
	},
	["Firefighter"] = {
		"firefighter.clockon",
		"lfb_clockon.menu",
	},
	["Junior Firefighter Clocked"] = {
		_config = {
			gtype = "job",
			onjoin = function(player)
				vRPclient.setLFB(player, {true})
			end,
			onspawn = function(player)
				vRPclient.setLFB(player, {true})
			end,
			onleave = function(player)
				vRPclient.setLFB(player, {false})
				TriggerClientEvent("DeleteBlipsALL", player)
			end
		},
		"lfb.cloakroom",
		"lfb.drag",
		"lfb.menu",
		"lfb.check",
		"lfb.revive",
		"juniorfirefighter.paycheck",
	},
	["Junior Firefighter"] = {
		"juniorfirefighter.clockon",
		"lfb_clockon.menu",
	},
	["Provisional Firefighter Clocked"] = {
		_config = {
			gtype = "job",
			onjoin = function(player)
				vRPclient.setLFB(player, {true})
			end,
			onspawn = function(player)
				vRPclient.setLFB(player, {true})
			end,
			onleave = function(player)
				vRPclient.setLFB(player, {false})
				TriggerClientEvent("DeleteBlipsALL", player)
			end
		},
		"lfb.cloakroom",
		"lfb.drag",
		"lfb.menu",
		"lfb.check",
		"lfb.revive",
		"provisionalfirefighter.paycheck",
	},
	["Provisional Firefighter"] = {
		"provisionalfirefighter.clockon",
		"lfb_clockon.menu",
	},
	['LFB Needs Training Clocked'] = {
		_config = {
			gtype = "job",
			onjoin = function(player)
				vRPclient.setLFB(player, {true})
			end,
			onspawn = function(player)
				vRPclient.setLFB(player, {true})
			end,
			onleave = function(player)
				vRPclient.setLFB(player, {false})
				TriggerClientEvent("DeleteBlipsALL", player)
			end
		},
		"lfb.cloakroom",
		"lfb.drag",
		"lfb.menu",
		"lfb.check",
		"lfb.revive",
		"lfb_needs_training.paycheck",
	},
	['LFB Needs Training'] = {
		'lfb_needs_training.clockon',
		'lfb_clockon.menu',
	},
	['LFB Suspended'] = {
		_config = {
			onjoin = function(player)
				vRPclient.Set_LFB_Suspended(player, {true})
				TriggerEvent('Nova:Server:DutyMenu:ClockOff', 'LFB', player)
			end,onspawn = function(player)
				vRPclient.Set_LFB_Suspended(player, {true})
			end,
			onleave = function(player)
				vRPclient.Set_LFB_Suspended(player, {false})
			end
		},
		"lfb_clockon.menu",
	},

	["VIP"] = {
		"vip.perm",
	},

	["Grind"] = {
		"grind.perm",
	},

	["staffon"] = {
		"staffon.perm",
	},

	["Rebel"] = {
		"rebel.guns",
	},

	["Gang"] = {
		"gang.guns",
	},

	["Highroller"] = {
		"high.roller",
	},

	["Scrap Job"] = {
		"scrap.job",
	},

	["Weed"] = {
		"weed.job",
	},

	["Diamond"] = {
		"diamond.job",
	},

	["Iron"] = {
		"iron.job",
	},

	["Heroin"] = {
		"heroin.job",
	},

	["LSD"] = {
		"lsd.job",
	},
	["Drone Trained"] = {
		"police.drone",
		"nhs.drone",
		"lfb.drone",
		"hmp.drone",
	},

	["pov"] = {}
}

cfg.users = {
	[1] = {
		"founder",
		"cofounder",
		"developer",
	}
}
-- group selectors
-- _config
--- x,y,z, blipid, blipcolor, permissions (optional)

cfg.selectors = {}

cfg.Job_Groups = {
	['Legal'] = {
		'Diamond',
		'Iron',
		'Scrap Job',
		
	},

	['Illegal'] = {
		'Rebel',
		'LSD',
		'Heroin',
		'Gang',
		'Weed',
	},
}

return cfg
