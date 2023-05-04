const resourcePath = global.GetResourcePath ?
    global.GetResourcePath(global.GetCurrentResourceName()) : global.__dirname
const settingsjson = require(resourcePath + '/settings.js')

exports.runcmd = (fivemexports, client, message, params) => {
    message.delete()
    if (!params[0] || !params[1] || !parseInt(params[1])) {
        return message.reply('Invalid args! Correct term is: ' + process.env.PREFIX + 'ban [permid] [time (hours)] [reason]')
    }
    fivemexports.ghmattimysql.execute("SELECT * FROM `aqua_user_ids` WHERE identifier = ?", ["discord:" + message.author.id], (result) => {
        if (result.length > 0) {
            adminpermid = result[0].user_id
            fivemexports.ghmattimysql.execute("SELECT * FROM `aqua_users` WHERE id = ?", [adminpermid], (result) => {
                if (result) {
                    adminname = result[0].username
                    const reason = params.slice(2).join(' ');
                    if (params[1] == "-1") {
                        let newval = fivemexports.aqua.AQUAbot('banDiscord', [params[0], "perm", `${reason}`, `${adminname}[${adminpermid}] via Discord.`])
                    }
                    else {
                        let newval = fivemexports.aqua.AQUAbot('banDiscord', [params[0], params[1], `${reason}`, `${adminname}[${adminpermid}] via Discord.`])
                    }
                        let embed = {
                            "title": "Banned User",
                            "description": `\nPerm ID: **${params[0]}**\nTime: **${params[1]} hours**\nReason: **${reason}**\n\nAdmin: <@${message.author.id}>`,
                            "color": settingsjson.settings.botColour,
                            "footer": {
                                "text": ``
                            },
                            "timestamp": new Date()
                        }
                        message.channel.send({embed})
                }
            });
        } else {
            message.reply('You do not have a Perm ID linked to your discord.')
        }
    });
}

exports.conf = {
    name: "ban",
    perm: 2
}