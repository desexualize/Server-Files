const resourcePath = global.GetResourcePath ?
    global.GetResourcePath(global.GetCurrentResourceName()) : global.__dirname
const settingsjson = require(resourcePath + '/settings.js')

exports.runcmd = (fivemexports, client, message, params) => {
    message.delete()
    if (!params[0] || !params[1]) {
        return message.reply('Invalid args! Correct term is: ' + process.env.PREFIX + 'embed [title] [description]')
    }
    else {
        let embed = {
            "title": `${params[0]}`,
            "description": `${params.join(' ').replace(params[0], '')}`,
            "color": settingsjson.settings.botColour,
            "footer": {
                "text": "AQUA Management"
            },
            "timestamp": new Date()
        }
        message.channel.send( { embed })
    }
}

exports.conf = {
    name: "embed",
    perm: 5
}