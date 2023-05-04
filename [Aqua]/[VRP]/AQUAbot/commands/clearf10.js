const resourcePath = global.GetResourcePath ?
    global.GetResourcePath(global.GetCurrentResourceName()) : global.__dirname
const settingsjson = require(resourcePath + '/settings.js')

exports.runcmd = (fivemexports, client, message, params) => {
    message.delete()
    if (!params[0] || !parseInt(params[0])) {
        return message.reply('Invalid args! Correct term is: ' + process.env.PREFIX + 'clearf10 [perm id]')
    }
    fivemexports['ghmattimysql'].execute("DELETE FROM aqua_warnings WHERE user_id = ?", [parseInt(params[0])])
    let embed = {
        "title": "Cleared Warnings",
        "description": `\nPerm ID: **${params[0]}**\n\nAdmin: <@${message.author.id}>`,
        "color": settingsjson.settings.botColour,
        "footer": {
            "text": ""
        },
        "timestamp": new Date()
    }
    message.channel.send({ embed })
}

exports.conf = {
    name: "clearf10",
    perm: 4
}