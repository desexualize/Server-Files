const resourcePath = global.GetResourcePath ?
    global.GetResourcePath(global.GetCurrentResourceName()) : global.__dirname
const settingsjson = require(resourcePath + '/settings.js')

exports.runcmd = (fivemexports, client, message, params) => {
    message.delete()
    if (!params[0] || !parseInt(params[0]) || !params[1]) {
        return message.reply('Invalid args! Correct term is: ' + process.env.PREFIX + 'setmoney [permid] [amount]')
    }
    fivemexports.aqua.AQUAbot('getUserSource', [parseInt(params[0])], function(d) {
        let newval = fivemexports.aqua.AQUAbot('kick', [d, `${message.author.username} is adding tokens to your account. (credits: f)`])
        fivemexports.ghmattimysql.execute("UPDATE `aqua_user_moneys` SET bank = ? WHERE user_id = ?", [params[1], params[0]], (result) => {
            if (result) {
                let embed = {
                    "title": "Set Money",
                    "description": `\nPerm ID: **${params[0]}**\nAmount: **${params[1]}**\n\nAdmin: <@${message.author.id}>`,
                    "color": settingsjson.settings.botColour,
                    "footer": {
                        "text": ""
                    },
                    "timestamp": new Date()
                }
                message.channel.send({ embed })
            } else {
                let embed = {
                    "title": "Failed to set Money",
                    "description": `\nPerm ID: **${params[0]}**\nAmount: **${params[1]}**`,
                    "color": settingsjson.settings.botColour,
                    "footer": {
                        "text": ""
                    },
                    "timestamp": new Date()
                }
                message.channel.send({ embed })
            }
        })
    })
}

exports.conf = {
    name: "setmoney",
    perm: 5
}