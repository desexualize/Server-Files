var AsciiTable = require('ascii-table');
const resourcePath = global.GetResourcePath ?
    global.GetResourcePath(global.GetCurrentResourceName()) : global.__dirname
const settingsjson = require(resourcePath + '/settings.js')

exports.runcmd = (fivemexports, client, message, params) => {
    message.delete()
    fivemexports.ghmattimysql.execute("SELECT * FROM staff_tickets ORDER BY ticketcount DESC", [], (result) => {
        var tickets = []
        if (result) {
            for (i = 0; i < result.length; i++) {
                if (i < 10) {
                    tickets.push(`\n${result[i].username}(${result[i].userid}) - ${result[i].ticketcount}`)
                }
            }
            let embed = {
                "title": `Ticket Leaderboard`,
                "description": '```'+tickets.join('').replace(',', '')+'```',
                "color": settingsjson.settings.botColour,
                "footer": {
                    "text": ""
                },
                "timestamp": new Date()
            }
            message.channel.send({embed})
        }
    })
}

exports.conf = {
    name: "ticketlb",
    perm: 1
}