var AsciiTable = require('ascii-table');
const Discord = require('discord.js');
const fs = require('fs');

const resourcePath = global.GetResourcePath ?
    global.GetResourcePath(global.GetCurrentResourceName()) : global.__dirname
const settingsjson = require(resourcePath + '/settings.js')

exports.runcmd = (fivemexports, client, message, params) => {
    message.delete()
    if (!params[0]) {
        return message.reply('Invalid args! Correct term is: ' + process.env.PREFIX + 'delcardb [spawncode]')
    }
    fivemexports.ghmattimysql.execute("DELETE FROM `aqua_user_vehicles` WHERE vehicle = ?", [params[0]])
    let embed = {
        "title": `Database Update`,
        "description": `${params[0]} has been deleted from the database.`,
        "color": settingsjson.settings.botColour,
        "footer": {
            "text": ""
        },
        "timestamp": new Date()
    }
    message.channel.send({ embed })
}

exports.conf = {
    name: "delcardb",
    perm: 6
}