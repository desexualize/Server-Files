const resourcePath = global.GetResourcePath ?
    global.GetResourcePath(global.GetCurrentResourceName()) : global.__dirname
const settingsjson = require(resourcePath + '/settings.js')

exports.runcmd = (fivemexports, client, message, params) => {
    message.delete()
    if (!params[0]) {
        return message.reply('Invalid args! Correct term is: ' + process.env.PREFIX + 'boot [permid] [spawncode]')
    }
    fivemexports.ghmattimysql.execute("SELECT * FROM `aqua_srv_data` WHERE dkey = ?", [`chest:u1veh_${params[1]}|${params[0]}`], (result) => {
        if (result.length > 0) {
            obj = JSON.parse(result[0].dvalue)
            let embed = {
                "title": `**User Boot** ${params[0]}`,
                "description": `**Success**! Boot of ***${params[1]}*** has been fetched for User ID: ***${params[0]}***`,
                "color": settingsjson.settings.botColour,
                "fields": [
                    {
                        name: '**Perm ID:**',
                        value: `${params[0]}`,
                    },
                    {
                        name: '**Boot:**',
                        value: `${(JSON.stringify(obj).replace(/"/g, '').replace('[', '').replace(']', '').replace(/,/g, ', ').replaceAll('wbody|', '').replaceAll(':{amount:', '(').replaceAll('},', '),').replace('}}', ')').replace('{',''))}`,
                    }
                ],
                "footer": {
                    "text": ""
                },
                "timestamp": new Date()
            }
            message.channel.send({ embed })
        } else {
            message.reply('No boot for this car.')
        }
    });
}

exports.conf = {
    name: "boot",
    perm: 6
}