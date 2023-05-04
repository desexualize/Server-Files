var AsciiTable = require('ascii-table');
const Discord = require('discord.js');
const fs = require('fs');

const resourcePath = global.GetResourcePath ?
    global.GetResourcePath(global.GetCurrentResourceName()) : global.__dirname
const settingsjson = require(resourcePath + '/settings.js')

exports.runcmd = (fivemexports, client, message, params) => {
    message.delete()
    if (!params[0]) {
        return message.reply('Invalid args! Correct term is: ' + process.env.PREFIX + 'lockcar [spawncode]')
    }
    fivemexports.ghmattimysql.execute("UPDATE `aqua_user_vehicles` SET locked = ? WHERE vehicle = ?", [1, params[0]])
    let embed = {
        "title": `Locked Car`,
        "description": `${params[0]} has been set as locked.`,
        "color": settingsjson.settings.botColour,
        "footer": {
            "text": ""
        },
        "timestamp": new Date()
    }
    message.channel.send({ embed })
}

exports.conf = {
    name: "lockcar",
    perm: 6
}