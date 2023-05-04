const audio = [
    { name: "headshot", file: "headshot.ogg", volume: 1.00 },
    { name: "bodyshot", file: "bodyshot.ogg", volume: 1.00 },
    { name: "zipper", file: "zipper.ogg", volume: 0.30 },
    { name: "herewegoagain", file: "herewegoagain.ogg", volume: 0.50 },
    { name: "newplayer", file: "newplayer.ogg", volume: 0.75 },
    { name: "license", file: "license.ogg", volume: 0.75 },
    { name: "newcar", file: "newcar.ogg", volume: 0.75 },
    { name: "newhouse", file: "newhouse.ogg", volume: 0.75 },
    { name: "repairready", file: "repairready.ogg", volume: 0.75 },
    { name: "purchaselicense", file: "purchaselicense.ogg", volume: 0.75 },
    { name: "plopsound", file: "plopsound.ogg", volume: 0.25 },
    { name: "apple", file: "apple.ogg", volume: 0.20 },
    { name: "handcuff", file: "handcuff.ogg", volume: 0.20 },
    { name: "money", file: "money.ogg", volume: 0.20 },
    { name: "dead", file: "dead.ogg", volume: 0.20 },
    { name: "casino_win", file: "casino_win.ogg", volume: 0.40 },
    { name: "casino_lose", file: "casino_lose.ogg", volume: 0.40 },
    { name: "iphone_ping", file: "iphone_ping.ogg", volume: 0.20 },
    { name: "hangup", file: "hangup.ogg", volume: 0.20 },
    { name: "ringtone", file: "ringtone.ogg", volume: 0.20 },
    { name: "radioon", file: "radioon.ogg", volume: 0.20 },
    { name: "radiooff", file: "radiooff.ogg", volume: 0.20 },
    { name: "purge", file: "purge.ogg", volume: 0.20 },
    { name: "gtaloadin", file: "gtaloadin.ogg", volume: 0.20 },
    { name: "drill", file: "drill.ogg", volume: 0.20 },
    { name: "alarm", file: "alarm.ogg", volume: 0.40 },
    { name: "starter", file: "starter.ogg", volume: 0.40 },
    { name: "supplydrop", file: "supplydrop.ogg", volume: 0.40 },
    { name: "minecraft", file: "minecraft.ogg", volume: 1.00},
    { name: "cod", file: "cod.ogg", volume: 0.75 },
    { name: "codheadshot", file: "codheadshot.ogg", volume: 0.75 },
    { name: "fortnite", file: "fortnite.ogg", volume: 0.75 },
    { name: "fortniteheadshot", file: "fortniteheadshot.ogg", volume: 0.75 },
    { name: "rust", file: "rust.ogg", volume: 1.00 },
    { name: "rustheadshot", file: "rustheadshot.ogg", volume: 1.00 },
    { name: "yeet", file: "yeet.ogg", volume: 1.00 },
    { name: "uwu", file: "uwu.ogg", volume: 1.00 },
    { name: "turtle", file: "turtle.ogg", volume: 1.00 },
    { name: "gun", file: "gun.ogg", volume: 1.00 },
    {name:"questcomplete", file:"questcomplete.ogg", volume: 0.3},
    { name: "scream", file: "scream.ogg", volume: 1.00 },
    { name: "ringtone", file: "ringtone.ogg", volume: 1.00 },
    { name: "fortnite_death", file: "fortnite_death.webm", volume: 0.3},
    { name: "roblox_death", file: "roblox_death.webm", volume: 0.3},
    { name: "minecraft_death", file: "minecraft_death.webm", volume: 0.3},
    { name: "pacman_death", file: "pacman_death.webm", volume: 0.3},
    { name: "mario_death", file: "mario_death.webm", volume: 0.3},
    { name: "csgo_death", file: "csgo_death.webm", volume: 0.3},
    {name:"tubearriving", file:"tubearriving.ogg", volume: 0.3},
    {name:"tubeleaving", file:"tubeleaving.ogg", volume: 0.3},
    {name:"ring", file:"ring.ogg", volume: 0.3},
]

var audioPlayer = null;
  
window.addEventListener('message', function (event) {
    if (findAudioToPlay(event.data.transactionType)) {
      let audio = findAudioToPlay(event.data.transactionType)
      if (audioPlayer != null) {
        audioPlayer.pause();
      }
      audioPlayer = new Audio("./sounds/" + audio.file);
      audioPlayer.volume = audio.volume;
      audioPlayer.play();
    }
});
  
function findAudioToPlay(name) {
    for (a of audio) {
      if (a.name == name) {
        return a
      }
    }
    return false
}