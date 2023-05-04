const Discord = require('discord.js');
const client = new Discord.Client();
const path = require('path')
const resourcePath = global.GetResourcePath ?
global.GetResourcePath(global.GetCurrentResourceName()) : global.__dirname
require('dotenv').config({ path: path.join(resourcePath, './.env') })
const fs = require('fs');
const settingsjson = require(resourcePath + '/settings.js')
const Settings = settingsjson.settings

const Guild_IDs = Settings.guilds
const nova_groups_file = require(resourcePath + '/nova_groups.js')
const Nova_Groups = nova_groups_file.nova_groups

const synced_roles_file = require(resourcePath + '/synced_roles.js')
const Synced_Guild_Roles = synced_roles_file.synced_roles

client.path = resourcePath
client.ip = Settings.ip

if (process.env.TOKEN == "" || process.env.TOKEN == "TOKEN") {
    console.log(`Error! No Token Provided you forgot to edit the .env`);
    throw new Error('Whoops!')
}

client.on('ready', () => {
    console.log(`Logged in as ${client.user.tag}! Players: ${GetNumPlayerIndices()} / ${GetConvarInt("sv_maxclients", 60)}`);
    console.log(`Your Prefix Is ${process.env.PREFIX}`)
    init()
});

const Status_Update_Interval_Seconds = 15 // Make sure this is seconds if changed

let Players_Since_Release = 0
let Online_Staff = 0
let Online_LFB = 0
let Online_NHS = 0
let Online_HMP = 0
let Online_MPD = 0

if (Settings.StatusEnabled) {
    setInterval(() => {
        const nova_guild = client.guilds.get(Settings.GuildID)
        if (!nova_guild) {
            return console.log(`Status is enabled but not configured correctly and will not work as intended`)
        }
        
        let channel = nova_guild.channels.get(Settings.StatusChannel);
        if (!channel) {
            return console.log(`Status channel is not available / cannot be found`)
        }

        client.user.setActivity(`${GetNumPlayerIndices()} / ${GetConvarInt("sv_maxclients", 64)} players`, {type: 'WATCHING'});

        let settingsjsons = require(resourcePath + '/params.json')
        let totalSeconds = (client.uptime / 1000);

        totalSeconds %= 86400;
        let hours = Math.floor(totalSeconds / 3600);

        totalSeconds %= 3600;
        let minutes = Math.floor(totalSeconds / 60);

        let uptime_message;
        if (hours != 0) {
            uptime_message = `${hours}.${minutes} Hours`;
        } else{
            if (minutes == 1){
                uptime_message = `${minutes} Minute`
            } else {
                uptime_message = `${minutes} Minutes`
            }
        }

        exports.oxmysql.single("select count(user_id) from vrp_user_data", (result) => {
            if (result){
                Players_Since_Release = result['count(user_id)']
            }
        });

        exports.vrp.Get_Users_By_Permission('admin.menu', function(result) {
            if (result) {
                Online_Staff = result.length
            }
        })

        exports.vrp.Get_Users_By_Permission('lfb.menu', function(result) {
            if (result) {
                Online_LFB = result.length
            }
        })

        exports.vrp.Get_Users_By_Permission('nhs.menu', function(result) {
            if (result) {
                Online_NHS = result.length
            }
        })

        exports.vrp.Get_Users_By_Permission('hmp.menu', function(result) {
            if (result) {
                Online_HMP = result.length
            }
        })

        exports.vrp.Get_Users_By_Permission('police.menu', function(result) {
            if (result){
                Online_MPD = result.length
            }
        })

        /*
        fivemexports.oxmysql.execute("SELECT * FROM vrp_users WHERE banned = 1", (result) => {
            bannedPlayers = result.length
        })
        */

        channel.fetchMessage(settingsjsons.messageid).then(msg => {
            let status_embed = {
                "title": `${GetConvar('sv_hostname', 'Nova UK')} - Server Status`,
                "color": Settings.botColour,
                "timestamp": new Date(),
                "footer": {"text": `⚙️ ${GetConvar('sv_hostname', 'Nova UK')}`},
                "fields": [
                    {
                        "name": "✅ Uptime:",
                        "value": uptime_message,
                        "inline": true
                    },
                    {
                        "name": "👀 Players Online:",
                        "value": `${GetNumPlayerIndices()} / ${GetConvarInt("sv_maxclients", 64)}`,
                        "inline": true
                    },
                    {
                        "name": "💂 Staff Online:",
                        "value": `${Online_Staff}`,
                        "inline": true
                    },
                    {
                        "name": "🧯 LFB Online:",
                        "value": `${Online_LFB}`,
                        "inline": true
                    },
                    {
                        "name": "💉 NHS Online:",
                        "value": `${Online_NHS}`,
                        "inline": true
                    },
                    {
                        "name": "💂🏽 HMP Online:",
                        "value": `${Online_HMP}`,
                        "inline": true
                    },
                    {
                        "name": "👮 MPD Online:",
                        "value": `${Online_MPD}`,
                        "inline": true
                    },
                    {
                        "name": "🌎 Players Since Release:",
                        "value": `${Players_Since_Release}`,
                        "inline": true
                    },
                    {
                        "name": "💻 How do I connect?",
                        "value": `\`F8 -> ${client.ip}\``,
                        "inline": true
                    }
                ]
            }
            msg.edit({embed: status_embed})

        }).catch(err => {
            channel.send('Status Page JamesUK#6793 Starting..').then(id => {
                settingsjsons.messageid = id.id
                fs.writeFile(`${resourcePath}/params.json`, JSON.stringify(settingsjsons), function(err) {});
                return
            })
        })

    }, Status_Update_Interval_Seconds * 1000);
}

/*
    WAIT BEFORE YOU REMOVE THE CREDITS THINK ABOUT ALL THE HARDWORK THAT HAS GONE INTO THIS! 

    DEVELOPERS EVERY DAY HAVE THEIR WORK STOLEN OR CLAIMED BY OTHERS.

    IT'S TIME FOR CHANGE. PEOPLE WILL JUST STOP RELEASING THINGS IF YOU STEAL THEIR WORK. 

    - JamesUK#6793

*/


client.commands = new Discord.Collection();

const init = async() => {
    fs.readdir(resourcePath + '/commands/', (err, files) => {
        if (err) console.error(err);
        console.log(`Loading a total of ${files.length} commands.`);
        files.forEach(f => {
            let command = require(`${resourcePath}/commands/${f}`);
            client.commands.set(command.conf.name, command);
        });
    });
}

client.getPerms = function(msg) {

    let settings = Settings
    let Guild_IDs = settings.guilds 
    let msg_guild_id = msg.guild.id

    if (msg_guild_id == Guild_IDs.nova){
        let lvl1 = msg.guild.roles.find(r => r.name === settings.Level1Perm);
        let lvl2 = msg.guild.roles.find(r => r.name === settings.Level2Perm);
        let lvl3 = msg.guild.roles.find(r => r.name === settings.Level3Perm);
        let lvl4 = msg.guild.roles.find(r => r.name === settings.Level4Perm);
        let lvl5 = msg.guild.roles.find(r => r.name === settings.Level5Perm);
        let lvl6 = msg.guild.roles.find(r => r.name === settings.Level6Perm);
        if (!lvl1 || !lvl2 || !lvl3 || !lvl4 || !lvl5 || !lvl6) {
            console.log(`Your permissions are not setup correctly and the bot will not function as intended.\nStatus: Level 1 Perm is: ${lvl1}, Level 2 Perm is: ${lvl2}, Level 3 Perm is ${lvl3}, Level 4 Perm is ${lvl4}, Level 5 Perm is ${lvl5}, Level 6 Perm is ${lvl6}`)
        }


        // hot fix for Discord role caching 
        const guild = client.guilds.get(msg.guild.id);
        if (guild.members.has(msg.author.id)) {
            guild.members.delete(msg.author.id);
        }
        const member = guild.members.get(msg.author.id);
        // hot fix for Discord role caching 

        let level = 0;
        if (msg.member.roles.has(lvl6.id)) {
            level = 6;
        } else if (msg.member.roles.has(lvl5.id)) {
            level = 5;
        } else if (msg.member.roles.has(lvl4.id)) {
            level = 4;
        } else if (msg.member.roles.has(lvl3.id)) {
            level = 3;
        } else if (msg.member.roles.has(lvl2.id)) {
            level = 2;
        } else if (msg.member.roles.has(lvl1.id)) {
            level = 1;
        }
        return level
    }
}

client.on('message', (message) => {
    if (!message.author.bot){
        if (message.channel.name.includes('auction-')){
            if (message.channel.name == '│auction-room'){
                return
            }
            else{
                if (!message.content.includes('.bid')){
                    if (message.content.includes('.auction')){}
                    else if (message.content.includes('.houseauction')){}
                    else if (message.content.includes('.embed')){}
                    else{
                        message.delete()
                        return
                    }
                }
            }
        }
    }
    let client = message.client;
    if (message.author.bot) return;
    if (!message.content.startsWith(process.env.PREFIX)) return;
    let command = message.content.split(' ')[0].slice(process.env.PREFIX.length).toLowerCase();
    let params = message.content.split(' ').slice(1);
    let cmd;
    let permissions = client.getPerms(message)
    if (client.commands.has(command)) {
        cmd = client.commands.get(command);
    }
    if (cmd) {
        if (message.channel.name.includes('bot') || message.channel.name.includes('auction') || cmd.conf.name == 'houseauction' || cmd.conf.name == 'embed' || cmd.conf.name == 'rulechange' || cmd.conf.name == 'auction') {
            if (permissions < cmd.conf.perm) return;
            try {
                cmd.runcmd(exports, client, message, params, permissions);
            } catch (err) {
                let embed = {
                    "title": "Error Occured!",
                    "description": "\nAn error occured. Contact JamesUK#6793 in vRP with the code:\n\n```" + err.message + "\n```",
                    "color": 13632027
                }
                message.channel.send({ embed })
            }
        }
    }
});

client.on('guildMemberUpdate', (before, after) => {
    const before_roles = before.roles
    const after_roles = after.roles
    if (before_roles == after_roles) {
        return;
    }

    const guild_id = after.guild.id
    var guild_groups;

    if (guild_id == Guild_IDs.nova) {
        guild_groups = Nova_Groups.nova
    } else if (guild_id == Guild_IDs.lfb) {
        guild_groups = Nova_Groups.lfb
    } else if (guild_id == Guild_IDs.nhs) {
        guild_groups = Nova_Groups.nhs
    } else if (guild_id == Guild_IDs.hmp) {
        guild_groups = Nova_Groups.hmp
    } else if (guild_id == Guild_IDs.mpd) {
        guild_groups = Nova_Groups.mpd
    } else {
        return;
    }

    const user_info = exports['Discord-Groups'].Get_User_Source(after.id)
    if (!user_info){ // User is not in the server
        return;
    }
    const user_source = user_info.user_source
    const user_id = user_info.user_id

    var before_role_ids = []
    var after_role_ids = []

    before_roles.forEach(role => before_role_ids.push(role.id))
    after_roles.forEach(role => after_role_ids.push(role.id))

    for(role_id in guild_groups){
        const group_name = guild_groups[role_id]

        if (!before_role_ids.includes(role_id) && after_role_ids.includes(role_id)) { // If does not have before but has after: add group
            if (guild_id == Guild_IDs.nova) {
                exports.vrp.Add_User_Group(user_id, group_name)
            } else {
                exports.vrp.Admin_Add_Group(user_source, group_name, user_id)
            }
        } else if (before_role_ids.includes(role_id) && !after_role_ids.includes(role_id)) { // If Has before but not after: remove group
            if (guild_id == Guild_IDs.nova) {
                exports.vrp.Remove_User_Group(user_id, group_name)
            } else {
                exports.vrp.Admin_Remove_Group(user_source, group_name, user_id)
            }
        }
    }
})

client.on('guildMemberAdd', (member) => {
    const joined_guild_id = member.guild.id
    if (joined_guild_id == Guild_IDs.nova) {
        return
    }

    var guild_roles
    if (joined_guild_id == Guild_IDs.lfb){
        guild_roles = Synced_Guild_Roles.lfb
    } else if (joined_guild_id == Guild_IDs.nhs) {
        guild_roles = Synced_Guild_Roles.nhs
    } else if (joined_guild_id == Guild_IDs.hmp) {
        guild_roles = Synced_Guild_Roles.hmp
    } else if (joined_guild_id == Guild_IDs.mpd) {
        guild_roles = Synced_Guild_Roles.mpd
    } else {
        return;
    }

    const nova_guild = client.guilds.get(Settings.GuildID)
    if (!nova_guild){
        return
    }

    const nova_guild_members = nova_guild.members
    const nova_member = nova_guild_members.get(`${member.id}`)
    if (!nova_member){
        return;
    }

    var nova_member_role_ids = []
    nova_member.roles.forEach(role => nova_member_role_ids.push(role.id))
    
    const nova_roles = Synced_Guild_Roles.nova
    for(role_name in nova_roles){
        const role_id = nova_roles[role_name]
        if (nova_member_role_ids.includes(role_id)) {
            const guild_role_id = guild_roles[role_name]
            if (guild_role_id){
                member.addRole(guild_role_id)
            }
        }
    }
})

client.login(process.env.TOKEN)