// Total warnings, kicks, bans, banned players
const resourcePath = global.GetResourcePath ?
    global.GetResourcePath(global.GetCurrentResourceName()) : global.__dirname
const settingsjson = require(resourcePath + '/settings.js')

let bannedPlayers = 0
let totalBans = 0
let totalKicks = 0
let totalWarns = 0

exports.runcmd = (fivemexports, client, message, params) => {
    message.delete()
    fivemexports.ghmattimysql.execute("SELECT * FROM aqua_users WHERE banned = 1", (bannedPlayers) => {
    fivemexports.ghmattimysql.execute("SELECT * FROM aqua_warnings WHERE warning_type = 'Ban'", (totalBans) => {
    fivemexports.ghmattimysql.execute("SELECT * FROM aqua_warnings WHERE warning_type = 'Kick'", (totalKicks) => {
    let embed = {
        "title": "Punishment Statistics",
        "description": `**Banned Players:** ${bannedPlayers.length}\n**Total Bans:** ${totalBans.length}\n**Total Kicks:** ${totalKicks.length}\n**Total Punishments:** ${totalBans.length+totalKicks.length}\n\n**Admin:** <@${message.author.id}>`,
        "color": settingsjson.settings.botColour,
        "footer": {
            "text": ""
        },
        "timestamp": new Date()
    }
    message.channel.send({ embed })
    }) }) })
}

exports.conf = {
    name: "punishments",
    perm: 6
}