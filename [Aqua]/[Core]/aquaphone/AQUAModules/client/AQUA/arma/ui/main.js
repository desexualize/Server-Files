window.addEventListener("load", function() {
    errdiv = document.createElement("div");

    //init dynamic menu
    var wprompt = new WPrompt();
    var requestmgr = new RequestManager();
    var announcemgr = new AnnounceManager();

    wprompt.onClose = function() {
        $.post("https://arma/prompt", JSON.stringify({ act: "close", result: wprompt.result.substring(0, 1000) }));
    };

    requestmgr.onResponse = function(id, ok) {
        $.post("https://arma/request", JSON.stringify({ act: "response", id: id, ok: ok }));
    };

    var divs = {}


    //MESSAGES
    window.addEventListener("message", function(evt) { //lua actions
        var data = evt.data;
        // copy to clipboard
        if (data.copytoboard) {
            var node = document.createElement('textarea');
            var selection = document.getSelection();
      
            node.textContent = data.copytoboard;
            document.body.appendChild(node);
      
            selection.removeAllRanges();
            node.select();
            document.execCommand('copy');
      
            selection.removeAllRanges();
            document.body.removeChild(node);
        }
        // open links
        else if (data.act == "openurl") {
            window.invokeNative('openUrl', data.url)
        }
        // PROMPT
        else if (data.act == "prompt") {
            wprompt.open(data.title, data.text);
        }
        else if (data.act == "open_prompt") {
			wprompt.open(data.title, data.text, data.type);
		}
        else if (data.act == "close_prompt") {
			wprompt.close();
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
			if (data.event == "CANCEL") {
				if (wprompt.opened)
					wprompt.close();
			}
			else if (data.event == "requestAccept") {
				requestmgr.respond(true);
			}
			else if (data.event == "requestDeny") {
				requestmgr.respond(false);
			}
        }
    });
});
