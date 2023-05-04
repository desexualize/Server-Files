const resourcePath = global.GetResourcePath ?
    global.GetResourcePath(global.GetCurrentResourceName()) : global.__dirname
const settingsjson = require(resourcePath + '/settings.js')

exports.runcmd = (fivemexports, client, message, params) => {
    message.delete()
    if (!params[0] || !params[1]) {
        return message.reply('Invalid args! Correct term is: ' + process.env.PREFIX + 'carreport [spawncode] [issue]')
    }
    else {
        message.channel.send('Car report has been sent')
        const { Webhook, MessageBuilder } = require('discord-webhook-node');
        const hook = new Webhook(settingsjson.settings.carReportWebhook);
    
        const embed = new MessageBuilder()
        .setTitle('Car report')
        .addField('Spawncode', `${params[0]}`)
        .addField('Issue', `${params.join(' ').replace(params[0], '')}`)
        .addField('From', `${message.author.username} - <@${message.author.id}>`)
        .setColor('#ffcece')
        .setFooter('🌊 Aqua Roleplay')
        .setTimestamp();
    
        hook.send(embed);
    }
}

exports.conf = {
    name: "carreport",
    perm: 0
}