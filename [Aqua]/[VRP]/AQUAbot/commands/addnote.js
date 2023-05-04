const resourcePath = global.GetResourcePath ?
    global.GetResourcePath(global.GetCurrentResourceName()) : global.__dirname
const settingsjson = require(resourcePath + '/settings.js')

let adminpermid
let adminname
let text

exports.runcmd = (fivemexports, client, message, params) => {
    message.delete()
    if (!params[0]) {
        return message.reply('Invalid args! Correct term is: ' + process.env.PREFIX + 'addnote [permid] [text]')
    }
    fivemexports.ghmattimysql.execute("SELECT * FROM `aqua_user_ids` WHERE identifier = ?", ["discord:" + message.author.id], (result) => {
        if (result.length > 0) {
            adminpermid = result[0].user_id
            fivemexports.ghmattimysql.execute("SELECT * FROM `aqua_users` WHERE id = ?", [adminpermid], (result) => {
                if (result) {
                    adminname = result[0].username
                    fivemexports.ghmattimysql.execute("INSERT INTO `aqua_user_notes` (user_id, text, admin_name, admin_id) VALUES(?,?,?,?) ", [params[0], [params.join(' ').replace(params[0], '')], adminname, adminpermid], (result) => {
                        if (result) {
                            let embed = {
                                "title": "Added Note",
                                "description": `\n**Perm ID: **${params[0]}**\nNote: **${params.join(' ').replace(params[0], '')}\n\n**Admin:** <@${message.author.id}>`,
                                "color": settingsjson.settings.botColour,
                                "footer": {
                                    "text": ""
                                },
                                "timestamp": new Date()
                            }
                            message.channel.send({ embed })
                        }
                    });
                }
            });
        } else {
            message.reply('You do not have a Perm ID linked to your discord.')
        }
    });
}

exports.conf = {
    name: "addnote",
    perm: 1
}