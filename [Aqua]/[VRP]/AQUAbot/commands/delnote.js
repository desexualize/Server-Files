const resourcePath = global.GetResourcePath ?
    global.GetResourcePath(global.GetCurrentResourceName()) : global.__dirname
const settingsjson = require(resourcePath + '/settings.js')


exports.runcmd = (fivemexports, client, message, params) => {
    message.delete()
    if (!params[0]) {
        return message.reply('Invalid args! Correct term is: ' + process.env.PREFIX + 'delnote [note-id]')
    }
    fivemexports.ghmattimysql.execute("DELETE FROM `aqua_user_notes` WHERE note_id = ?", [params[0]], (result) => {
        if (result) {
            let embed = {
                "title": "Deleted Note",
                "description": `**Note ID: **${params[0]}\n\n**Admin:** <@${message.author.id}>`,
                "color": settingsjson.settings.botColour,
                "footer": {
                    "text": ""
                },
                "timestamp": new Date()
            }
            message.channel.send({ embed })
        } else {
            message.reply('No note exists with this ID.')
        }
    });
}

exports.conf = {
    name: "delnote",
    perm: 1
}