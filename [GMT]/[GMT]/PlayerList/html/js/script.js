const doc = document;
var isOpen = false 
window.addEventListener('load', () => {
    this.addEventListener('message', e => {
        if (e.data.action == 'openScoreboard') {
            doc.getElementById('wrapper').style.display = 'flex';
        }
        if (e.data.action == 'updatePlayers') {
            updateScoreboard(e.data.players, e.data.maxPlayers, e.data.runTime);
        }
        if (e.data.action == 'close') {
            doc.getElementById('wrapper').style.display = 'none';
        }
    })
})


const updateScoreboard = (players, maxPlayers, staffOnline) => {
    const permids = doc.getElementById('cont-permids');
    const names = doc.getElementById('cont-names');
    const hours = doc.getElementById('cont-hours');
    const employment = doc.getElementById('cont-job');

    for (let i=doc.getElementsByClassName('currentData').length - 1; i >= 0; i--) {
        doc.getElementsByClassName('currentData')[i].remove()
    }

    players.forEach(player => {
        if (!doc.getElementById(player.playersName)) {
            const UserID = doc.createElement('span');
            const name = doc.createElement('span');
            const time = doc.createElement('span');
            const job = doc.createElement('span');

            UserID.textContent = player.UserID;
            time.textContent = player.playersTime;
            name.textContent = player.playersName;
            job.textContent = player.playersJob;

            name.id = player.UserID;
            UserID.classList.add('currentData', players.indexOf(player));
            time.classList.add('currentData', players.indexOf(player));
            name.classList.add('currentData',players.indexOf(player));
            job.classList.add('currentData',players.indexOf(player));

            names.appendChild(name);
            permids.appendChild(UserID)
            hours.appendChild(time);
            employment.appendChild(job);
        }
    });

    doc.getElementById('players').textContent = maxPlayers;
    doc.getElementById('staff').textContent = staffOnline;
}


document.onkeyup = function (data) {
    if (data.which == 36 && isOpen) {
        $.post('https://PlayerList/exit', JSON.stringify({}));
        isOpen = false 
    }
};

document.onkeydown = function (data) {
    if (data.which == 36 && !isOpen) {
        isOpen = true 
    }
}

