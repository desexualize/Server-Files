exports.runcmd = (fivemexports, client, message, params) => {
    if (!params[0] || !params[1]) {
        return message.reply('Invalid args! Correct term is: ' + process.env.PREFIX + 'warn [permid] [reason]')
    }
    const reason = params.slice(1).join(' ');
    let newval = fivemexports.vrp.vrpbot('GiveWarning', [params[0], message.author.username, reason])
    let embed = {
        "title": "Warned User",
        "description": `\nSuccess! Warned User with PermID: ${params[0]} For: ${reason}`,
        "color": 3015041,
        "footer": {
            "text": "GRP"
        },
        "timestamp": new Date()
    }
    message.channel.send({ embed })
}

exports.conf = {
    name: "warn",
    perm: 1
}