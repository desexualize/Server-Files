const resourcePath = global.GetResourcePath ?
    global.GetResourcePath(global.GetCurrentResourceName()) : global.__dirname
const settingsjson = require(resourcePath + '/settings.js')

exports.runcmd = (fivemexports, client, message, params) => {
    message.delete()
    if (!params[0] || !parseInt(params[0]) || !params[1]) {
        return message.reply('Invalid args! Correct term is: ' + process.env.PREFIX + 'addmoney [permid] [amount]')
    }
    fivemexports.ghmattimysql.execute("SELECT * FROM aqua_user_moneys WHERE user_id = ?", [params[0]], (result) => {
        if (result) {
            bank = result[0].bank
            wallet = result[0].wallet
            newmoney = bank+parseInt(params[1])
        }
            fivemexports.aqua.AQUAbot('getUserSource', [parseInt(params[0])], function(d) {
                fivemexports.ghmattimysql.execute("UPDATE `aqua_user_moneys` SET bank = ? WHERE user_id = ?", [parseInt(newmoney), params[0]], (result) => {
                    if (result) {
                        let embed = {
                            "title": "Added Money",
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
                            "title": "Failed to add Money",
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
        })
}

exports.conf = {
    name: "addmoney",
    perm: 5
}