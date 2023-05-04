const resourcePath = global.GetResourcePath ?
global.GetResourcePath(global.GetCurrentResourceName()) : global.__dirname
const settingsjson = require(resourcePath + '/settings.js')
const Guild_IDs = settingsjson.settings.guilds
const Faction_Colours = settingsjson.settings.faction_colours

exports.runcmd = (fivemexports, client, message, params) => {
    let search_id;

    const first_parameter = params[0];
    if (first_parameter) {
        let member = message.mentions.users.first();
        if (member != undefined) {
            search_id = member.id
        } else if (!parseInt(first_parameter)) {
            return message.reply('Invalid ID received, please use a valid Perm ID / Discord ID')
        } else {
            search_id = first_parameter
        }
    } else {
        search_id = message.author.id
    }

    let faction_type;
    let embed_colour;

    const guild_id = message.guild.id
    if (guild_id == Guild_IDs.nova) {
        faction_type = 'lfb'
        embed_colour = Faction_Colours.lfb
    } else if (guild_id == Guild_IDs.lfb) {
        faction_type = 'lfb'
        embed_colour = Faction_Colours.lfb
    } else if (guild_id == Guild_IDs.nhs) {
        faction_type = 'nhs'
        embed_colour = Faction_Colours.nhs
    } else if (guild_id == Guild_IDs.hmp) {
        faction_type = 'hmp'
        embed_colour = Faction_Colours.hmp
    } else if (guild_id == Guild_IDs.mpd) {
        faction_type = 'mpd'
        embed_colour = Faction_Colours.mpd
    } else {
        faction_type = 'lfb'
        embed_colour = Faction_Colours.lfb
    }

    let embed = {
        "color": embed_colour,
    }

    fivemexports.oxmysql.single(`select * from ${faction_type}_user_hours where user_id = ${search_id} or discord_id = ${search_id}`, [], (result) => {
        if (result) {
            const user_id = result.user_id
            const user_name = result.user_name

            const total_hours = result.total_hours
            const weekly_hours = result.weekly_hours

            const last_clocked_rank = result.last_clocked_rank
            const last_clocked_date = result.last_clocked_date

            embed.title = `${faction_type.toUpperCase()} information for ${user_name} [${user_id}]`
            embed.fields = [
                {
                    name: 'Total hours',
                    value: `${total_hours.toFixed(2)}`,
                    inline: true,
                },
                {
                    name: 'Weekly hours',
                    value: `${weekly_hours.toFixed(2)}`,
                    inline: true,
                },
                {
                    name: 'Last clocked on rank',
                    value: last_clocked_rank,
                    inline: true,
                },
                {
                    name: 'Last clocked on date',
                    value: last_clocked_date,
                    inline: true,
                }
            ]
        } else {
            embed.description = `No ${faction_type.toUpperCase()} info found for (${search_id})`
        }

        message.channel.send({embed})
    })
}

exports.conf = {
    name: "info",
    perm: 0
}