window.addEventListener("load", function() {
    errdiv = document.createElement("div");

    //init dynamic menu
    var ogrpMenu = new Menu();
    var wprompt = new WPrompt();
    var requestmgr = new RequestManager();
    var announcemgr = new AnnounceManager();

    wprompt.onClose = function() {
        $.post("https://vrp/prompt", JSON.stringify({ act: "close", result: wprompt.result.substring(0, 1000) }));
    };

    requestmgr.onResponse = function(id, ok) {
        $.post("https://vrp/request", JSON.stringify({ act: "response", id: id, ok: ok }));
    };

    ogrpMenu.onClose = function() {
        $.post("https://vrp/menu", JSON.stringify({ act: "close", id: ogrpMenu.id }));
    };

    ogrpMenu.onValid = function(choice, mod) {
        $.post("https://vrp/menu", JSON.stringify({ act: "valid", id: ogrpMenu.id, choice: choice, mod: mod }));
    };

    //request config
    $.post("https://vrp/cfg", "");

    //var current_menu = dynamic_menu;
    var pbars = {}
    var divs = {}

    //progress bar ticks (25fps)
    setInterval(function() {
        for (var k in pbars) {
            pbars[k].frame(1 / 25.0 * 1000);
        }

    }, 1 / 25.0 * 1000);



    // const doc = document;
    // window.addEventListener('message', function(event) {
       
    //        if (event.data.Deathscreen == false) {
    //             doc.getElementById('Deathscreen');
    //         }
    //        else if (event.data.Deathscreen == true) {
    //             doc.getElementById('Deathscreen').style.display = 'none';
    //         }
       
    // })



    //MESSAGES
    window.addEventListener("message", function(event) { //lua actions
        var data = event.data;

        if (data.act == "cfg") {
            cfg = data.cfg
        } else if (data.act == "open_menu") { //OPEN DYNAMIC MENU
            ogrpMenu.open(data);
            ogrpMenu.id = data.menudata.id;
        } else if (data.act == "close_menu") { //CLOSE MENU
            //current_menu.close();
        // } else if (event.data.action == true) {
        //     console.log('true')
        //     document.getElementById('Deathscreen');
        // } else if (event.data.action == false) {
        //     console.log('false')
        //     document.getElementById('Deathscreen').style.display = 'none';
        
        // PROGRESS BAR
         } else if (data.act == "set_pbar") {
            
            var pbar = pbars[data.pbar.name];
            if (pbar)
                pbar.removeDom();

            pbars[data.pbar.name] = new ProgressBar(data.pbar);
            pbars[data.pbar.name].addDom();
        } else if (data.act == "set_pbar_val") {
            var pbar = pbars[data.name];
            if (pbar)
                pbar.setValue(data.value);
        } else if (data.act == "set_pbar_text") {
            var pbar = pbars[data.name];
            if (pbar)
                pbar.setText(data.text);
        } else if (data.act == "remove_pbar") {
            var pbar = pbars[data.name]
            if (pbar) {
                pbar.removeDom();
                delete pbars[data.name];
            }
        }
        // PROMPT
        else if (data.act == "prompt") {
            wprompt.open(data.title, data.text);
        }
        // REQUEST
        else if (data.act == "request") {
            requestmgr.addRequest(data.id, data.text, data.time);
        }
        // ANNOUNCE
        else if (data.act == "announce") {
            announcemgr.addAnnounce(data.background, data.content);
        }
        // DIV
        else if (data.act == "set_div") {
            var div = divs[data.name];
            if (div)
                div.removeDom();

            divs[data.name] = new Div(data)
            divs[data.name].addDom();
        } else if (data.act == "set_div_css") {
            var div = divs[data.name];
            if (div)
                div.setCss(data.css);
        } else if (data.act == "set_div_content") {
            var div = divs[data.name];
            if (div)
                div.setContent(data.content);
        } else if (data.act == "div_execjs") {
            var div = divs[data.name];
            if (div)
                div.executeJS(data.js);
        } else if (data.act == "remove_div") {
            var div = divs[data.name];
            if (div)
                div.removeDom();

            delete divs[data.name];
        }
        // CONTROLS
        else if (data.act == "event") { //EVENTS
            if (data.event == "UP") {
                if (ogrpMenu.opened) {
                    ogrpMenu.moveUp();
                }
            } else if (data.event == "DOWN") {
                if (ogrpMenu.opened) {
                    ogrpMenu.moveDown();
                }
            } else if (data.event == "LEFT") {
                ogrpMenu.valid(-1);
            } else if (data.event == "RIGHT") {
                ogrpMenu.valid(1);
            } else if (data.event == "SELECT") {
                ogrpMenu.valid(0);
            } else if (data.event == "CANCEL") {
                if (wprompt.opened)
                    wprompt.close();
                else
                    ogrpMenu.close(data);
            } else if (data.event == "=") {
                requestmgr.respond(true);
            } else if (data.event == "-") {
                requestmgr.respond(false);
            }
        }
    });
});


var player;
function DoMusic(song) {
    var vid = song
    if (player) {
        player.loadVideoById(vid,(song == 1 ? 50 : 1));
        player.playVideo();
    } else {
        player = new YT.Player('player', {
            videoId: song,
            loop: true,
            events: {
                onReady: function (e) {
                    e.target.playVideo();
                }
            }
        });
    }
}

// DJ Music:

window.addEventListener("message", function(event){ 
    if(event.data.type == "djPlay"){
        djMusic(event.data.song, event.data.volume)
    };
    if(event.data.type == "djStop"){
        djStop()
    };
    if(event.data.type == "djVolume"){
        djVolume(event.data.volume)
    };
    if(event.data.type == "djSkipAhead"){
        djSkipAhead()
    };
    if(event.data.type == "djSkipBack"){
        djSkipBack()
    };
    if(event.data.type == "requestProgress"){
        djRequestProgress()
    };
    if(event.data.type == "skipTo"){
        djSkipTo(event.data.time)
    };
});

function djMusic(song, volume) {
    console.log($("#dj"))
    // $("#dj").tubeplayer("cue", song);
    // $("#dj").tubeplayer("play");
    try {
        var vid = song
        var skip = false
        if (player){
            player.stopVideo();
        }
        if (player) {
            player.loadVideoById(vid,(song == 1 ? 50 : 1));
            player.seekTo(-30);
            player.playVideo();
        } else {
            player = new YT.Player('player', {
                videoId: song,
                loop: false,
                events: {
                    onReady: function (e) {
                        e.target.playVideo();
                        e.target.setVolume(volume);
                        if (skip)
                        {
                            e.target.seekTo(50);
                        }
                    }
                }
            });
        }
    }
    catch(err){
        console.log(err)
    }
}

function djStop() {
    try {
        if (player){
            player.stopVideo();
    
        }
    }
    catch(err){

    }
    
}

function djSkipAhead() {
    try {
        if (player){
            var time = player.getCurrentTime();
            player.seekTo(time + 2, true);
        }
    }
    catch(err){

    }
    
}

function djSkipBack() {
    try {
        if (player){
            var time = player.getCurrentTime();
            if (!((time - 2) < 0)) {
                player.seekTo(time - 2, true);
            }
        }
    }
    catch(err){

    }
    
}

function onPlayerReady(event) {
    player = event.target;
}

function djVolume(volume){
    try {
        if (player){
            player.setVolume(volume)
        }
    }
    catch(err){

    }
}

function djRequestProgress(){
    try {
        if (player){
            var time = player.getCurrentTime();
            $.post('http://vrp/returnProgress', JSON.stringify({
                progress: time})
            );
        }
    }
    catch(err){

    }
}

function djSkipTo(time){
    try {
        if (player){
            player.seekTo(time, true);
        }
    }
    catch(err){

    }
}