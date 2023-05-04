exports.runcmd = (fivemexports, client, message, params) => {
    let embed = {
        "title": "Status",
        "description": `\nPlayers: ${GetNumPlayerIndices()}\n\nThe Connect Is: connect ${client.ip}`,
        "color": 3015041,
        "footer": {
            "text": "GRP"
        },
        "timestamp": new Date()
    }
    message.channel.send({ embed })
}

exports.conf = {
    name: "status",
    perm: 0
}