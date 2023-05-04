const resourcePath = global.GetResourcePath ?
    global.GetResourcePath(global.GetCurrentResourceName()) : global.__dirname
const settingsjson = require(resourcePath + '/settings.js')

exports.runcmd = (fivemexports, client, message, params) => {
    message.delete()
    if (!params[0]) {
        return message.reply('Invalid args! Correct term is: ' + process.env.PREFIX + 'hmc [spawn code]')
    }
    fivemexports.ghmattimysql.execute("SELECT * FROM aqua_user_vehicles WHERE vehicle = ?", [params[0].toLowerCase()], (result) => {
        if (result) {
            let embed = {
                "title": "Car Count",
                "description": `\nThere are **${result.length}** ${params[0]}'s in the server.`,
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
    name: "hmc",
    perm: 0
}