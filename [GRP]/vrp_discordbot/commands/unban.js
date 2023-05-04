exports.runcmd = (fivemexports, client, message, params) => {
    if (!params[0]) {
        return message.reply('Invalid args! Correct term is: ' + process.env.PREFIX + 'unban [permid]')
    }
    const reason = params.slice(1).join(' ');
    let newval = fivemexports.vrp.vrpbot('setBanned', [params[0], false])
    let embed = {
        "title": "Unbanned User",
        "description": `\nSuccess! Unbanned User with PermID: ${params[0]}`,
        "color": 3015041,
        "footer": {
            "text": "GRP"
        },
        "timestamp": new Date()
    }
    message.channel.send({ embed })
}

exports.conf = {
    name: "unban",
    perm: 2
}