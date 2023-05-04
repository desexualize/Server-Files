const resourcePath = global.GetResourcePath ?
    global.GetResourcePath(global.GetCurrentResourceName()) : global.__dirname
const settingsjson = require(resourcePath + '/settings.js')

exports.runcmd = async(fivemexports, client, message, params) => {
    message.delete()
    if (!params[0] && !parseInt(params[0])) {
        return message.reply('Invalid args! Correct term is: ' + process.env.PREFIX + 'tickets [permid]')
    }
    fivemexports.ghmattimysql.execute("SELECT * FROM `staff_tickets` WHERE userid = ?", [params[0]], (result) => {
        if (result.length > 0) {
            ticketcount = result[0].ticketcount
            let embed = {
                "title": "Ticket Count",
                "description": `\nPerm ID: **${params[0]}**\nTicket Count: **${ticketcount}**`,
                "color": settingsjson.settings.botColour,
                "footer": {
                    "text": ""
                },
                "timestamp": new Date()
            }
            message.channel.send({ embed })
        }
        if (result.length == 0){
            return message.reply(`${params[0]} has taken no tickets since the last reset.`)
        }
    })
}

exports.conf = {
    name: "tickets",
    perm: 1
}