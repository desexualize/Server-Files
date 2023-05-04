var rList = new Object();

Object.size = function(obj) {
    var size = 0,
      key;
    for (key in obj) 
    {
      if (obj.hasOwnProperty(key)) size++;
    }
    return size;
};

$(document).ready(function(){
    let shown = false;
    let currentPlaytime = 0;
    let currentSessionTime = 0;
    var claimedList = new Object();

    $(document).on('keyup', function(e) 
    {
        if (e.key == "Escape") 
            Exit();
    });

    function Exit() 
    {
        $("body").fadeOut();
        shown = false;

        $.post(`https://${GetParentResourceName()}/exit`, JSON.stringify({}));
    }
    
    window.addEventListener('message', function(event) 
    {
        var data = event.data;
        
        if (data.type == "rewards") 
        {
            document.getElementById("container").innerHTML = "";
            
            let exitBtn = document.createElement("button");
            exitBtn.id = "exit-button";
            exitBtn.innerHTML = `<i class="fas fa-times-circle"></i>`
            exitBtn.onclick = function() { Exit() }
            document.getElementById("container").appendChild(exitBtn);

            var playTime = document.createElement('p');
            document.getElementById("container").appendChild(playTime);
            playTime.textContent = "→ Total play time: " + FormatTime(currentPlaytime) + " | Session: " + FormatTime(currentSessionTime);
            playTime.id = "desc";
            playTime.className = "playtime";
            for (let i = 0; i < data.rwds.length; i++) 
            {
                rList[i] = new Object();

                for (let j = 0; j < data.rwds[i].length; j++) 
                {
                    if (data.rwds[i][j][0] == "Label") rList[i]["Label"] = data.rwds[i][j][1]
                    if (data.rwds[i][j][0] == "Description") rList[i]["Description"] = data.rwds[i][j][1]
                    if (data.rwds[i][j][0] == "PlaytimeInSecondsNeeded") rList[i]["PlaytimeInSecondsNeeded"] = data.rwds[i][j][1]
                    if (data.rwds[i][j][0] == "UsingTotalPlaytime") rList[i]["UsingTotalPlaytime"] = data.rwds[i][j][1]
                    if (data.rwds[i][j][0] == "UniqueID") rList[i]["UniqueID"] = data.rwds[i][j][1]
                    if (data.rwds[i][j][0] == "ClaimableMultipleTimes") rList[i]["ClaimableMultipleTimes"] = data.rwds[i][j][1]
                }
            }

            for (let i = 0; i < Object.size(rList); i++) 
            {
                var innerDiv = document.createElement('div');
                innerDiv.className = 'card';
                document.getElementById("container").appendChild(innerDiv);
                innerDiv.id = "card-" + i.toString();
                innerDiv.innerHTML = `
                <p id="reward-title">${rList[i]["Label"]}</p>
                <p id="desc">${rList[i]["Description"]}</p>`;
                
                let btn = document.createElement("button");
                btn.className = "button";

                let alreadyClaimed = false;
                for (let j = 1; j < Object.size(claimedList); j++) 
                {
                    if (claimedList[j] == rList[i]["UniqueID"]) 
                    {
                        alreadyClaimed = true;
                    }
                }

                if (!alreadyClaimed)
                {
                    if (parseInt(rList[i]["PlaytimeInSecondsNeeded"], 10) <= (rList[i]["UsingTotalPlaytime"] === "true" ? currentPlaytime : currentSessionTime)) 
                    {
                        btn.textContent = `CLAIM ✔`;
                        btn.id = "claimable"
                        btn.onclick = function() 
                        {
                            if (currentPlaytime >= parseInt(rList[i]["PlaytimeInSecondsNeeded"], 10)) 
                            {
                                Exit()
                                $.post(`https://${GetParentResourceName()}/claim`, JSON.stringify({ _uniqueID: rList[i]["UniqueID"] }))
                            }
                        };
                    }
                    else 
                    {
                        let neededTime = FormatMathTime(rList[i]["PlaytimeInSecondsNeeded"], (rList[i]["UsingTotalPlaytime"] === "true" ? currentPlaytime : currentSessionTime))
                        btn.textContent = "Claimable in " + neededTime;
                        btn.onclick = function() 
                        {
                            $.post(`https://${GetParentResourceName()}/notavailable`, JSON.stringify({ neededTime: neededTime }))
                        };
                    }
                }
                else
                {
                    if (rList[i]["ClaimableMultipleTimes"] === "true") btn.textContent = `ALREADY CLAIMED IN THIS SESSION`;
                    else btn.textContent = `CLAIMED`;

                    btn.id = "claimed";
                }

                document.getElementById("card-" + i.toString()).appendChild(btn);
            }
        }
        else if (data.type == "menu") 
        {
            if (!shown) 
            {
                $("body").fadeIn();
                shown = true
            } 
            else 
            {
                $("body").fadeOut();
                shown = false
            }
        }
        else if (data.type == "playtime") 
        {
            currentPlaytime = data._playtime
            currentSessionTime = data.sessionplaytime
            if (document.getElementsByClassName("playtime")[0] !== undefined)
                document.getElementsByClassName("playtime")[0].textContent = "→ Total play time: " + FormatTime(currentPlaytime) + " | Session: " + FormatTime(currentSessionTime);
        }
        else if (data.type == "claimed") 
        {
            claimedList = data.claimed
        }
    });

    function FormatTime(secs) {
        let vMinutes = Math.floor(secs/60)
        let vRemainingSeconds = secs % 60
        let vHours = Math.floor(vMinutes/60)
        let vRemainingMinutes = vMinutes % 60
        let vDays = Math.floor(vHours/24)
        let vRemainingHours = vHours % 24

        if (vDays > 0)
            return vDays + "d " + vRemainingHours + "h " + vRemainingMinutes + "min " + Math.floor(vRemainingSeconds) + "s"
        else if (vRemainingHours > 0)
            return vRemainingHours + "h " + vRemainingMinutes +"min " + Math.floor(vRemainingSeconds) + "s"
        else if (vRemainingMinutes > 0)
            return vRemainingMinutes + "min "+ Math.floor(vRemainingSeconds) + "s"
        else 
            return Math.floor(vRemainingSeconds) + "s"
    }

    function FormatMathTime(neededDataSeconds, currentSeconds) {
        // needed seconds dd hh mm ss calculation
        let neededDataMinutes = Math.floor(neededDataSeconds/60)
        let neededDataRemainingSeconds = neededDataSeconds % 60
        let neededDataHours = Math.floor(neededDataMinutes/60)
        let neededDataRemainingMinutes = neededDataMinutes % 60
        let neededDataDays = Math.floor(neededDataHours/24)
        let neededDataRemainingHours = neededDataHours % 24

        // Current seconds dd hh mm ss calculation
        let currentMinutes = Math.floor(currentSeconds/60)
        let currentRemainingSeconds = currentSeconds % 60
        let currentHours = Math.floor(currentMinutes/60)
        let currentRemainingMinutes = currentMinutes % 60
        let currentDays = Math.floor(currentHours/24)
        let currentRemainingHours = currentHours % 24

        var diff = Math.abs(new Date(0, 0, neededDataDays, neededDataRemainingHours, neededDataRemainingMinutes, neededDataRemainingSeconds) - new Date(0, 0, currentDays, currentRemainingHours, currentRemainingMinutes, currentRemainingSeconds));
        return FormatTime(diff / 1000)
    }
});