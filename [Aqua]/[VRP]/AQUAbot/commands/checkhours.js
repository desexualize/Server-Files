const resourcePath = global.GetResourcePath ?
    global.GetResourcePath(global.GetCurrentResourceName()) : global.__dirname
const settingsjson = require(resourcePath + '/settings.js')

exports.runcmd = (fivemexports, client, message, params) => {
    message.delete()
    if (!params[0]) {
        return message.reply('Invalid args! Correct term is: ' + process.env.PREFIX + 'ch [permid]')
    }
    fivemexports.ghmattimysql.execute("SELECT * FROM `aqua_user_data` WHERE user_id = ?", [params[0]], (result) => {
        if (result.length > 0) {
            hours = JSON.stringify(JSON.parse(result[0].dvalue).PlayerTime/60)
            let embed = {
                "description": `**${Math.round(hours)}** hours`,
                "color": settingsjson.settings.botColour,
            }
            message.channel.send({ embed })
        } else {
            message.reply('No groups for this user.')
        }
    });
}

exports.conf = {
    name: "ch",
    perm: 1
}