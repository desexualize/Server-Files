// Deletes all player inventories, used at the start/end of each month after the purge when that's implemented.
const resourcePath = global.GetResourcePath ?
    global.GetResourcePath(global.GetCurrentResourceName()) : global.__dirname
const settingsjson = require(resourcePath + '/settings.js')

let bootsCleared = 0

exports.runcmd = (fivemexports, client, message, params) => {
    message.delete()
    fivemexports.ghmattimysql.execute("SELECT * FROM aqua_srv_data", (result) => {
        bootsCleared = result.length
        let embed = {
            "title": "Bootwipe Complete",
            "description": `Number of Boots Cleared: ${bootsCleared}\n\nAdmin: <@${message.author.id}>`,
            "color": settingsjson.settings.botColour,
            "footer": {
                "text": ""
            },
            "timestamp": new Date()
        }
        message.channel.send({ embed })
    })
    fivemexports.ghmattimysql.execute("DELETE FROM aqua_srv_data") 
}

exports.conf = {
    name: "bootwipe",
    perm: 6
}