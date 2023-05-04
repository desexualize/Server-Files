const resourcePath = global.GetResourcePath ?
    global.GetResourcePath(global.GetCurrentResourceName()) : global.__dirname
const settingsjson = require(resourcePath + '/settings.js')

exports.runcmd = (fivemexports, client, message, params) => {
    message.delete()
    if (!params[0]) {
        return message.reply('Invalid args! Correct term is: ' + process.env.PREFIX + 'groups [permid]')
    }
    fivemexports.ghmattimysql.execute("SELECT * FROM `aqua_user_data` WHERE user_id = ?", [params[0]], (result) => {
        if (result.length > 0) {
            obj = JSON.parse(result[0].dvalue).groups
            let embed = {
                "title": `**User Groups** ${params[0]}`,
                "description": `**Success**! Groups have been fetched for User ID: ***${params[0]}***`,
                "color": settingsjson.settings.botColour,
                "fields": [
                    {
                        name: '**Perm ID:**',
                        value: `${params[0]}`,
                    },
                    {
                        name: '**Groups:**',
                        value: `${(JSON.stringify(Object.keys(obj)).replace(/"/g, '').replace('[', '').replace(']', '')).replace(/,/g, ', ')}`,
                    }
                ],
                "footer": {
                    "text": ""
                },
                "timestamp": new Date()
            }
            message.channel.send({ embed })
        } else {
            message.reply('No groups for this user.')
        }
    });
}

exports.conf = {
    name: "groups",
    perm: 3
}