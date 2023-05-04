const audio = [
    { name: "zipper", file: "zipper.ogg", volume: 0.30 },
    { name: "apple", file: "apple.ogg", volume: 0.20 },
    { name: "handcuff", file: "handcuff.ogg", volume: 0.20 },
    { name: "playHandcuff", file: "handcuff.ogg", volume: 0.3},
    { name: "money", file: "money.ogg", volume: 0.20 },
    { name: "radioon", file: "radioon.ogg", volume: 0.20 },
    { name: "radiooff", file: "radiooff.ogg", volume: 0.20 },
    { name: "gtaloadin", file: "gtaloadin.ogg", volume: 0.20 },
    { name: "drill", file: "drill.ogg", volume: 0.20 },
    { name: "alarm", file: "alarm.ogg", volume: 0.40 },
    { name:"unlimitedpower", file:"unlimitedpower.ogg", volume: 0.60},
    { name:"wrathofgod", file: "wrathofgod.webm", volume: 0.60},
    {name:"playRingTone", file:"ringtone.ogg", volume: 0.3},
    {name:"hangup", file:"hangup.ogg", volume: 0.3},
    {name:"iphone_ping", file:"iphone_ping.ogg", volume: 0.2},
    {name:"breathalyser", file:"breathalyser.ogg", volume: 0.2},
    {name:"car_alarm", file:"caralarm.webm", volume: 0.1},
    {name:"taser", file:"taser.ogg", volume: 0.1},
    {name:"reactivate", file:"reactivate.ogg", volume: 0.15},
    {name:"arcsound", file:"arcsound.ogg", volume: 0.15},
    {name:"metronome", file:"metronome.ogg", volume: 0.15},
    {name:"safeToTouch", file:"safeToTouch.ogg", volume: 0.15},
    {name:"shockAdvisedCharging", file:"shockAdvisedCharging.ogg", volume: 0.35},
    {name:"threeBeeps", file:"threeBeeps.ogg", volume: 0.15},
    {name:"checkPatientAlarm", file:"checkPatientAlarm.ogg", volume: 0.15},
    {name:"analysingHeartRythm", file:"analysingHeartRythm.ogg", volume: 0.15},
    {name:"pushToShock", file:"pushToShock.ogg", volume: 0.25},
    {name:"carryOutShock", file:"carryOutShock.ogg", volume: 0.25},  
    {name:"headshot", file:"rustheadshotsound.ogg", volume: 1.00},
    {name:"bodyshot", file:"rusthitmarkersound.ogg", volume: 1.00},
    {name:"airbag", file:"airbag.ogg", volume: 0.15},
    {name:"herewegoagain", file:"herewegoagain.ogg", volume: 0.3},
    {name:"elevatormusic", file:"elevatormusic.ogg", volume: 0},
    {name:"tubearriving", file:"tubearriving.ogg", volume: 0.3},
    {name:"tubeleaving", file:"tubeleaving.ogg", volume: 0.3},
    {name:"questcomplete", file:"questcomplete.ogg", volume: 0.3},
    {name:"playMoney", file:"money.ogg", volume: 0.3},
    {name:"playHandcuff", file:"handcuff.ogg", volume: 0.3},
    {name:"playRadioOn", file:"radioon.ogg", volume: 0.1},
    {name:"playRadioOff", file:"radiooff.ogg", volume: 0.1},
    {name:"playRussianRoulette", file:"roulette.ogg", volume: 0.2},
    {name:"playSaw", file:"saw.ogg", volume: 0.3},
    {name:"emptygun", file:"emptygun.ogg", volume: 0.2},
    {name:"playDead", file:"dead.ogg", volume: 0.3},
    {name:"playRingTone", file:"ringtone.ogg", volume: 0.3},
    {name:"playCasinoWin", file:"casino_win.ogg", volume: 0.4},
    {name:"playCasinoLose", file:"casino_lose.ogg", volume: 0.3},
    {name:"knockedtfout", file:"knockedtfout.ogg", volume: 0.9},
    {name:"seatbelt", file:"chime.ogg", volume: 0.3},
    {name:"ring", file:"ring.ogg", volume: 0.3},
    {name:"zipper", file:"zipper.ogg", volume: 0.3},
    {name:"knifeArch", file:"knifearch.ogg", volume: 0.3},
    {name:"jackpotroll", file:"jackpotroll.ogg", volume: 0.3},
    {name:"hangup", file:"hangup.ogg", volume: 0.3},
    {name:"iphone_ping", file:"iphone_ping.ogg", volume: 0.2},
    {name:"breathalyser", file:"breathalyser.ogg", volume: 0.2},
    {name:"car_alarm", file:"caralarm.webm", volume: 0.1},
    {name:"taser", file:"taser.ogg", volume: 0.1},
    {name:"reactivate", file:"reactivate.ogg", volume: 0.15},
    {name:"arcsound", file:"arcsound.ogg", volume: 0.15},
    {name:"metronome", file:"metronome.ogg", volume: 0.15},
    {name:"safeToTouch", file:"safeToTouch.ogg", volume: 0.15},
    {name:"shockAdvisedCharging", file:"shockAdvisedCharging.ogg", volume: 0.35},
    {name:"threeBeeps", file:"threeBeeps.ogg", volume: 0.15},
    {name:"checkPatientAlarm", file:"checkPatientAlarm.ogg", volume: 0.15},
    {name:"analysingHeartRythm", file:"analysingHeartRythm.ogg", volume: 0.15},
    {name:"pushToShock", file:"pushToShock.ogg", volume: 0.25},
    {name:"carryOutShock", file:"carryOutShock.ogg", volume: 0.25},
    {name:"callanambulance", file:"callanambulance.webm", volume: 1.00},
    {name:"headshot", file:"rustheadshotsound.ogg", volume: 1.00},
    {name:"bodyshot", file:"rusthitmarkersound.ogg", volume: 1.00},
    {name:"airbag", file:"airbag.ogg", volume: 0.15},
    {name:"hackingSuccess", file:"hackingSuccess.ogg", volume: 0.35},
    {name:"hackingFail", file:"hackingFail.ogg", volume: 0.35},
    {name:"hackingIntro", file:"hackingIntro.ogg", volume: 0.35},
    // Driving Test - dvsa
    {name:"askShowMeQuestion", file:"askShowMeQuestion.ogg", volume: 0.50},
    {name:"closeCall", file:"closeCall.ogg", volume: 0.50},
    {name:"completePaperwork", file:"completePaperwork.ogg", volume: 0.50},
    {name:"controlledStop", file:"controlledStop.ogg", volume: 0.50},
    {name:"driveToTopFloor", file:"driveToTopFloor.ogg", volume: 0.50},
    {name:"emergencyStopIntroduction", file:"emergencyStopIntroduction.ogg", volume: 0.50},
    {name:"initialMoveOff", file:"initialMoveOff.ogg", volume: 0.50},
    {name:"leavingMotorwayTurningRight", file:"leavingMotorwayTurningRight.ogg", volume: 0.50},
    {name:"minorFaults", file:"minorFaults.ogg", volume: 0.50},
    {name:"motorwayExplained", file:"motorwayExplained.ogg", volume: 0.50},
    {name:"moveOffWhenReady", file:"moveOffWhenReady.ogg", volume: 0.50},
    {name:"newDestinationSet", file:"newDestinationSet.ogg", volume: 0.50},
    {name:"nowReversePark", file:"nowReversePark.ogg", volume: 0.50},
    {name:"operateHorn", file:"operateHorn.ogg", volume: 0.50},
    {name:"operateMainBeamHeadlights", file:"operateMainBeamHeadlights.ogg", volume: 0.50},
    {name:"parkUpAtWaypoint", file:"parkUpAtWaypoint.ogg", volume: 0.50},
    {name:"policePursuitContinue", file:"policePursuitContinue.ogg", volume: 0.50},
    {name:"reverseParkComplete", file:"reverseParkComplete.ogg", volume: 0.50},
    {name:"seriousFaults", file:"seriousFaults.ogg", volume: 0.50},
    {name:"slowDownOrTermination", file:"slowDownOrTermination.ogg", volume: 0.50},
    {name:"stopNowMessage", file:"stopNowMessage.ogg", volume: 0.50},
    {name:"stopSign", file:"stopSign.ogg", volume: 0.50},
    {name:"straightOver", file:"straightOver.ogg", volume: 0.50},
    {name:"textExplained", file:"textExplained.ogg", volume: 0.50},
    {name:"testFailed", file:"testFailed.ogg", volume: 0.50},
    {name:"testFailesGoodbye", file:"testFailesGoodbye.ogg", volume: 0.50},
    {name:"testPassed", file:"testPassed.ogg", volume: 0.50},
    {name:"testPassedGoodbye", file:"testPassedGoodbye.ogg", volume: 0.50},
    {name:"turningRightJunction", file:"turningRightJunction.ogg", volume: 0.50},
    {name:"welcome", file:"welcome.ogg", volume: 0.50},
    {name:"continueToFollow", file:"continueToFollow.ogg", volume: 0.50},
    {name:"testExplained", file:"testExplained.ogg", volume: 0.50},
    {name:"fan", file:"fan.ogg", volume: 0.20},
    {name:"spreader", file:"spreader.ogg", volume: 0.10},
    {name:"br-gas", file:"br-gas.ogg", volume: 0.3},
    {name:"whatawonderfulworld", file:"whatawonderfulworld.webm", volume: 0.3},
    {name:"fortnite_death", file:"fortnite_death.webm", volume: 0.3},
    {name:"roblox_death", file:"roblox_death.webm", volume: 0.3},
    {name:"minecraft_death", file:"minecraft_death.webm", volume: 0.3},
    {name:"pacman_death", file:"pacman_death.webm", volume: 0.3},
    {name:"mario_death", file:"mario_death.webm", volume: 0.3},
    {name:"csgo_death", file:"csgo_death.webm", volume: 0.3},
    {name:"MPCT_AKAA_01", file:"MPCT_AKAA_01.webm", volume: 0.3}, //Johnny on the spot!
    {name:"MPCT_AKAA_02", file:"MPCT_AKAA_02.webm", volume: 0.3},
    {name:"MPCT_AKAA_03", file:"MPCT_AKAA_03.webm", volume: 0.3},
    {name:"MPCT_AKAA_04", file:"MPCT_AKAA_04.webm", volume: 0.3},
    {name:"MPCT_AKAA_05", file:"MPCT_AKAA_05.webm", volume: 0.3},
    {name:"MPCT_ALAA_01", file:"MPCT_ALAA_01.webm", volume: 0.3}, //Cant bring car
    {name:"MPCT_ALAA_02", file:"MPCT_ALAA_02.webm", volume: 0.3},
    {name:"MPCT_ALAA_03", file:"MPCT_ALAA_03.webm", volume: 0.3},
    {name:"MPCT_ALAA_04", file:"MPCT_ALAA_04.webm", volume: 0.3},
    {name:"MPCT_ALAA_05", file:"MPCT_ALAA_05.webm", volume: 0.3},
    {name:"shave", file:"shave.webm", volume: 1.0},
]

var audioPlayer = null;
    var bankAudioPlayer = null;
    // Listen for NUI Messages.
    window.addEventListener('message', function (event) {
      // Check for playSound transaction
      if (event.data.PayloadType == "Panic") {
        var Panics = [];
        if (!Panics[event.data.Payload]) {
          Panics[event.data.Payload] = new Audio("./sounds/panic.mp3");
          Panics[event.data.Payload].volume = 0.08;
          Panics[event.data.Payload].play();
          Panics[event.data.Payload].addEventListener("ended", function () {
            Panics[event.data.Payload] = null;
          });
        }
        }
        if (findAudioToPlay(event.data.transactionType)) {
            let audio = findAudioToPlay(event.data.transactionType)
            if (audioPlayer != null) {
                audioPlayer.pause();
            }
            audioPlayer = new Audio("./sounds/" + audio.file);
            audioPlayer.volume = audio.volume;
			audioPlayer.play().then(null).catch((e) => {
              //console.log("caught a fat e" + e);
            })
        }

      if (event.data.transactionType == "bankalarm") {

        if (bankAudioPlayer != null) {
          bankAudioPlayer.pause();
        }

        bankAudioPlayer = new Audio("./sounds/bankalarm.ogg");
        bankAudioPlayer.volume = 0.4;
        bankAudioPlayer.play();
      }
      if (event.data.openNUI == true) {
        $(".headbag").css("display", "block");
      }
      if (event.data.openNUI == false) {
        $(".headbag").css("display", "none");
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