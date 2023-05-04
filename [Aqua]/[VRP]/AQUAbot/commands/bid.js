const Discord = require('discord.js');
const fs = require('fs');
const resourcePath = global.GetResourcePath ?
    global.GetResourcePath(global.GetCurrentResourceName()) : global.__dirname
const settingsjson = require(resourcePath + '/settings.js')

let prevbids = require(resourcePath + '/prevbid.json')

let minBid = settingsjson.settings.minBid
let prevBid = prevbids.prevbid

exports.runcmd = (fivemexports, client, message, params) => {
    message.delete()
    let user = message.author
    if (!params[0]) {return}
    if (message.channel.name.includes('auction-room')){return} 
    if (params[0] < minBid) { let embed = {"title": `Unsuccessful Auction Bid`,"description": `Minimum bid is £${minBid}, ${user}.`,"color": settingsjson.settings.botColour,"timestamp": new Date()}; message.channel.send({embed}).then(msg => msg.delete(5000)); return}
    fivemexports.ghmattimysql.execute("SELECT * FROM `aqua_user_ids` WHERE identifier = ?", ["discord:" + user.id], (result) => {
        if (result.length > 0) {
            fivemexports.ghmattimysql.execute("SELECT * FROM aqua_user_moneys WHERE user_id = ?", [result[0].user_id], (result) => {
                if (result) { bank = result[0].bank
                    if (message.channel.name.includes('auction')) {
                        if (bank > params[0]) {
                            if (params[0] >= prevbids.prevbid+parseInt(minBid)){
                                let embed = {
                                    "title": `Successful Auction Bid`,
                                    "description": `${message.author} has bid £${params[0].replace(/(\d)(?=(\d{3})+(?!\d))/g, '$1,')} on the auction.`,
                                    "color": settingsjson.settings.botColour,
                                    "timestamp": new Date()
                                }; 
                                message.channel.send({embed})
                                prevbids.prevbid = parseInt(params[0])
                                prevbids.prevbidder = user.id
                                fs.writeFile(`${resourcePath}/prevbid.json`, JSON.stringify(prevbids), function(err) {});
                            }
                            else {
                                let embed = {
                                    "title": `Unsuccessful Auction Bid`,
                                    "description": `You must bid at least £${(prevbids.prevbid+parseInt(minBid)).toString().replace(/(\d)(?=(\d{3})+(?!\d))/g, '$1,')}, ${user}.`,
                                    "color": settingsjson.settings.botColour,
                                    "timestamp": new Date()
                                }; 
                                message.channel.send({embed}).then(msg => msg.delete(5000));
                            }
                        }
                        else {
                            let embed = {
                                "title": `Unsuccessful Auction Bid`,
                                "description": `You do not have £${params[0].replace(/(\d)(?=(\d{3})+(?!\d))/g, '$1,')}, ${user}.`,
                                "color": settingsjson.settings.botColour,
                                "timestamp": new Date()
                            };
                            message.channel.send({embed}).then(msg => msg.delete(5000));
                        }
                    }
                }
            })
        } else { message.reply('You do not have a Perm ID linked to your Discord account.') }
    });
}

exports.conf = {
    name: "bid",
    perm: 0
}