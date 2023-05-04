const resourcePath = global.GetResourcePath ?
    global.GetResourcePath(global.GetCurrentResourceName()) : global.__dirname
const settingsjson = require(resourcePath + '/settings.js')

exports.runcmd = (fivemexports, client, message, params) => {
    message.delete()
    if (!params[0] || !parseInt(params[0]) || !params[1]) {
        return message.reply('Invalid args! Correct term is: ' + process.env.PREFIX + 'delcar [permid] [spawn code]')
    }
    fivemexports.ghmattimysql.execute("DELETE FROM aqua_user_vehicles WHERE user_id = ? AND vehicle = ?", [params[0], params[1]], (result) => {
        if (result) {
            let embed = {
                "title": "Removed Car Successfully!",
                "description": `\nPerm ID: **${params[0]}**\nSpawn Code: **${params[1]}**\n\nAdmin: <@${message.author.id}>`,
                "color": settingsjson.settings.botColour,
                "footer": {
                    "text": ""
                },
                "timestamp": new Date()
            }
            message.channel.send({ embed })
        } else {
            let embed = {
                "title": "Failed To Remove Car!",
                "description": `\nPerm ID: **${params[0]}**\nSpawn Code: **${params[1]}**\n\nAdmin: <@${message.author.id}>`,
                "color": settingsjson.settings.botColour,
                "footer": {
                    "text": ""
                },
                "timestamp": new Date()
            }
            message.channel.send({ embed })
        }
    })
}

exports.conf = {
    name: "delcar",
    perm: 5
}