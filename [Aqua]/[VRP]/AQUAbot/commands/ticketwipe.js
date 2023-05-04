const resourcePath = global.GetResourcePath ?
    global.GetResourcePath(global.GetCurrentResourceName()) : global.__dirname
const settingsjson = require(resourcePath + '/settings.js')

exports.runcmd = async(fivemexports, client, message, params) => {
    message.delete()
    fivemexports.ghmattimysql.execute("SELECT * FROM `staff_tickets`", (result) => {
        usersCleared = result.length
        var totalTickets = 0
        let embed = {
            "title": "Ticket Wipe Complete",
            "description": `Staff Members Cleared: ${usersCleared}\n\nAdmin: <@${message.author.id}>`,
            "color": settingsjson.settings.botColour,
            "footer": {
                "text": ""
            },
            "timestamp": new Date()
        }
        message.channel.send({ embed })
    })
    fivemexports.ghmattimysql.execute("DELETE FROM `staff_tickets`") 
}

exports.conf = {
    name: "ticketwipe",
    perm: 6
}