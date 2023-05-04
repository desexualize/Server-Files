const audio = [
    {name: "headshot", file: "headshot.ogg", volume: 1.00},
    {name: "bodyshot", file: "bodyshot.ogg", volume: 1.00},
    {name: "gtaloadin", file: "gtaloadin.ogg", volume: 0.50},
]

var audioPlayer = null;
  
window.addEventListener('message', function (event) {
	const event_data = event.data
	const event_type = event_data.type
	const transaction_type = event_data.transactionType

	if (event_type == 'play'){
		const audio = findAudioToPlay(transaction_type);
		if (audio) {
			if (audioPlayer != null) {
				audioPlayer.pause();
			}
			
			audioPlayer = new Audio("./sounds/" + audio.file);
			audioPlayer.volume = audio.volume;
			audioPlayer.play();
		}
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