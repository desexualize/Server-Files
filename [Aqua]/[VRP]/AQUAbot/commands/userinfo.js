const resourcePath = global.GetResourcePath ?
    global.GetResourcePath(global.GetCurrentResourceName()) : global.__dirname
const settingsjson = require(resourcePath + '/settings.js')

exports.runcmd = async(fivemexports, client, message, params) => {
    message.delete()
    if (!params[0] && !parseInt(params[0])) {
        return message.reply('Invalid args! Correct term is: ' + process.env.PREFIX + 'userinfo [permid]')
    }
    
    let bank = undefined;
    let bandata = "";
    let discord = "";
    let povlisttrue = "";
    var lastlogin = [];
    let time = "";
    let date = "";

    fivemexports.ghmattimysql.execute("SELECT * FROM `aqua_user_ids` WHERE user_id = ?", [params[0]], (discordid) => {
        if (discordid.length > 0) {
            for (i = 0; i < discordid.length; i++) {
                if (discordid[i].identifier.includes('discord')) {
                    discord = `<@${discordid[i].identifier.split(":")[1]}>`;
                }
            }
        }
        fivemexports.ghmattimysql.execute("SELECT * FROM aqua_user_moneys WHERE user_id = ?", [params[0]], (result) => {
            if (result) {
                bank = result[0].bank
                wallet = result[0].wallet
                fivemexports.ghmattimysql.execute("SELECT * FROM `aqua_users` WHERE id = ?", [params[0]], (userdata) => {
                    if (userdata) {
                        if (userdata[0].banned == 1) {
                            if (userdata[0].bantime == "perm"){
                                bandata = `Banned: True\n\nReason(s): ${userdata[0].banreason}\n\nAdmin: ${userdata[0].banadmin}\n\nBan Expires: Never`
                            }
                            else {
                                bandata = `Banned: True\n\nReason(s): ${userdata[0].banreason}\n\nAdmin: ${userdata[0].banadmin}\n\nBan Expires: ${new Date(userdata[0].bantime * 1000)}`
                            }
                        }
                        fivemexports.ghmattimysql.execute("SELECT * FROM `aqua_user_data` WHERE user_id = ?", [params[0]], (result) => {
                            if (result.length > 0) {
                                obj = JSON.parse(result[0].dvalue).groups
                                groups = (JSON.stringify(Object.keys(obj)).replace(/"/g, '').replace('[', '').replace(']', '')).replace(/,/g, ', ')
                                hours = JSON.stringify(JSON.parse(result[0].dvalue).PlayerTime/60) 
                                if (groups.includes('pov')) {
                                    povlisttrue = '**User is on POV List.**'
                                }
                            } 
                        fivemexports.ghmattimysql.execute("SELECT * FROM `aqua_users` WHERE id = ?", [params[0]], (result) => {
                            if (result) {
                                lastlogin = result[0].last_login.split(" ")
                                time = lastlogin[0]
                                date = lastlogin[1]
                            }
                        let embed = {
                            "title": "User Info",
                            "description": `${povlisttrue}\n\n**Perm ID: **${params[0]}**\nBalance: **${bank}**\nDiscord:** ${discord}\n**Last Login: **${date} at ${time}\n**Hours:** ${Math.round(hours)}\n\n${bandata}`,
                            "color": settingsjson.settings.botColour,
                            "footer": {
                                "text": ""
                            },
                            "timestamp": new Date()
                        }
                        message.channel.send({ embed })
                        })
                    })
                    }
                })
            }
        })
    })
}

exports.conf = {
    name: "userinfo",
    perm: 1
}