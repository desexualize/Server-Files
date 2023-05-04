window.addEventListener("message", function(event) {
    var item = event.data;

    if (item.radioHeader) {
        let radioListElem = document.getElementById("radio-list");
        let listHeader = document.createElement("div");
        listHeader.id = "radio-list-header";
        listHeader.textContent = item.name + " Radio";
        listHeader.style.textDecorationLine = "underline";
        radioListElem.appendChild(listHeader);
    }

    if (item.radioAdd) {
        let listItem = document.createElement("div");
        listItem.id = "radio-list-item-" + item.playerSrc;
        listItem.textContent = item.name + "\uD83D\uDD39";
        listItem.setAttribute("sortOrder", item.sortOrder)
        let radioListElem = document.getElementById("radio-list");
        var didInsert = false;
        for (var i = 0; i < radioListElem.children.length; i++) {
            var child = radioListElem.children[i];
            if (child.getAttribute("sortOrder") > item.sortOrder) {
                radioListElem.insertBefore(listItem, child)
                didInsert = true
                break;
            }
        }
        if (!didInsert) {
            radioListElem.appendChild(listItem);
        }
    }

    if (item.radioTalking) {
        let listItem = document.getElementById("radio-list-item-" + item.playerSrc)
        if (item.isTalking) {
            listItem.className = "talking"
        } else {
            listItem.className = ""
        }
    }

    if (item.radioRemove) {
        let radioListElem = document.getElementById("radio-list");
        let listItem = document.getElementById("radio-list-item-" + item.playerSrc)
        radioListElem.removeChild(listItem);
    }

    if (item.radioClear) {
        let radioListElem = document.getElementById("radio-list");
        while (radioListElem.firstChild) {
            radioListElem.removeChild(radioListElem.firstChild);
        }
    }

    if (item.radioVisibility) {
        if (item.isVisible) {
            document.getElementById("radio-list").style.display = 'block';
        } else {
            document.getElementById("radio-list").style.display = 'none';
        }
    }

    if (item.radioMuted) {
        let listItem = document.getElementById("radio-list-item-" + item.playerSrc)
        listItem.textContent = listItem.textContent.slice(0, -2) + (item.isMuted ? "\uD83D\uDD07" : "\uD83D\uDD39")
    }
});