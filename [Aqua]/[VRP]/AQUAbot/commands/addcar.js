const resourcePath = global.GetResourcePath ?
    global.GetResourcePath(global.GetCurrentResourceName()) : global.__dirname
const settingsjson = require(resourcePath + '/settings.js')

exports.runcmd = (fivemexports, client, message, params) => {
    message.delete()
    if (!params[0] || !parseInt(params[0]) || !params[1]) {
        return message.reply('Invalid args! Correct term is: ' + process.env.PREFIX + 'addcar [permid] [spawn code]')
    }
    fivemexports.ghmattimysql.execute("INSERT INTO aqua_user_vehicles (user_id, vehicle) VALUES(?, ?)", [params[0], params[1]], (result) => {
        if (result) {
            let embed = {
                "title": "Added Car",
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
                "title": "Failed to add Car",
                "description": `\nPerm ID **${params[0]}** already owns **${params[1]}**`,
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
    name: "addcar",
    perm: 5
}