var AsciiTable = require('ascii-table');
const Discord = require('discord.js');
const fs = require('fs');

const resourcePath = global.GetResourcePath ?
    global.GetResourcePath(global.GetCurrentResourceName()) : global.__dirname
const settingsjson = require(resourcePath + '/settings.js')

let descriptionText = ''

exports.runcmd = (fivemexports, client, message, params) => {
    message.delete()
    fivemexports.ghmattimysql.execute("SELECT * FROM `aqua_user_vehicles` WHERE vehicle = ?", [params[0]], (result) => {
        var owners = []
        for (i = 0; i < result.length; i++) {              
            owners.push(`(${result[i].user_id})\n`)
            if (result[i].locked == 1) {
                descriptionText = '🔒 Vehicle is locked'
            }
            else{
                descriptionText = '🔓 Vehicle is not locked'
            }
        }
        if (!result.length == 0){
        let embed = {
            "title": `All Users that own ${params[0]}:`,
            "description": descriptionText+'\n```'+owners.join('').replace(',', '')+'```',
            "color": settingsjson.settings.botColour,
            "footer": {
                "text": `Requested by ${message.author.username}`
            },
            "timestamp": new Date()
        }
        message.channel.send({ embed }).catch(err => {
            message.channel.send(`${params[0]} has too many owners to display in an embed.`)
        })
    }
        if (result.length == 0){
            return message.reply(`Nobody owns ${params[0]}`)
        }
    });
}

exports.conf = {
    name: "gco",
    perm: 0
}