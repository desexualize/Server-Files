$(function() {

    var zoneContainer = $('.zoneOwner');
    var zoneOwner = $('.zoneTeamText');

    window.addEventListener('message', function(event) {

        var item = event.data;

        if(item.type == "newKill") {
            addKill(item.killer, item.killed, item.weapon, item.distance, item.style, item.killerGroup, item.killedGroup);   
        } else if(item.type == "newDeath"){
            newDeath(item.killed, item.style, item.killedGroup);  
        }
    })
})

function addKill(killer, killed, weapon, distance, style, killerGroup, killedGroup) {
    $('<div class="' + style + '"><span class="' + killerGroup + '">' + killer + '</span><img src="img/' + weapon + '.webp" class="weapon"><span class="' + killedGroup + '">' + killed + '</span><span class="distance"> <strong>(' + distance + 'm)</strong> </span></div></div><br class="clear">').appendTo('.kills')
    .css({'margin-right':-$(this).width()+'px'})
    .animate({'margin-right':'0px'}, 'slow')
    .delay(5000)
    .animate({'margin-right':-$(this).width()+'px'}, 'slow')
    .queue(function() { $(this).remove(); });
    //$(".kills").append('<div class="killContainer"><span class="killer">' + killer + '</span><img src="https://wiki.rage.mp/images/1/16/Combat-pistol-icon.png" class="weapon"><span class="killed">' + killed + '</span></div><br class="clear">');
}

function newDeath(killed, style, killedGroup) {
    $('<div class="' + style + '"><span class="' + killedGroup + '">' + killed + '</span><img src="img/death.webp" class="weapon"><span class="' + killedGroup + '">' + killed + '</span></div><br class="clear">').appendTo('.kills')
    .css({'margin-right':-$(this).width()+'px'})
    .animate({'margin-right':'0px'}, 'slow')
    .delay(5000)
    .animate({'margin-right':-$(this).width()+'px'}, 'slow')
    .queue(function() { $(this).remove(); });
    //$(".kills").append('<div class="killContainer"><span class="killer">' + killer + '</span><img src="https://wiki.rage.mp/images/1/16/Combat-pistol-icon.png" class="weapon"><span class="killed">' + killed + '</span></div><br class="clear">');
}