const resourcePath = global.GetResourcePath ?
global.GetResourcePath(global.GetCurrentResourceName()) : global.__dirname
const settingsjson = require(resourcePath + '/settings.js')

exports.runcmd = (fivemexports, client, message, params) => {
    fivemexports.oxmysql.single(`select user_id from vrp_user_ids where identifier = "discord:${message.author.id}"`, [], (result) => {
        let embed = {
            color: settingsjson.settings.botColour
        }

        if (result) {
            embed.title = `User ID for ${message.author.tag}`
            embed.description = `User ID: ${result.user_id}`
        } else {
            embed.description = `No User ID found for ${message.author}`
        }

        message.channel.send({embed})
    })
}

exports.conf = {
    name: "getmyid",
    perm: 0
}