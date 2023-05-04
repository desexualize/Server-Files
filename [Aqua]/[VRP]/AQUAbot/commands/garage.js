var AsciiTable = require('ascii-table');
const Discord = require('discord.js');
const fs = require('fs');
const resourcePath = global.GetResourcePath ?
    global.GetResourcePath(global.GetCurrentResourceName()) : global.__dirname
const settingsjson = require(resourcePath + '/settings.js')

exports.runcmd = (fivemexports, client, message, params) => {
    message.delete()
    fivemexports.ghmattimysql.execute("SELECT * FROM `aqua_user_vehicles` WHERE user_id = ?", [params[0]], (result) => {
        var table = new AsciiTable(`ID ${[params[0]]}'s garage`)
        table.setHeading('Vehicle', 'Rented', 'Locked')
        for (i = 0; i < result.length; i++) {
            table.addRow(result[i].vehicle, result[i].rented, result[i].locked)
        }
        if (result.length == 0){
            return message.reply(`${params[0]} has no vehicles!`)
        }
        message.channel.send('```ascii\n' + table.toString() + '```').catch(err => {
            fs.writeFile(`${client.path}/garage_${params[0]}.txt`, table.toString(), function(err) {
                message.channel.send(`Perm ID ${params[0]}'s garage is to big!, ${message.author}`, { files: [`${client.path}/garage_${params[0]}.txt`] }).then(ss => {
                    fs.unlinkSync(`${client.path}/garage_${params[0]}.txt`)
                })
            });
        })
    });
}

exports.conf = {
    name: "garage",
    perm: 2
}