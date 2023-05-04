$(function() {

    var zoneContainer = $('.zoneOwner');
    var zoneOwner = $('.zoneTeamText');

    window.addEventListener('message', function(event) {

        var item = event.data;

        if(item.type == "newKill") {
            addKill(item.killer, item.killed, item.weapon, item.killergroup, item.killedgroup, item.container, item.distance);   
        } else if(item.type == "newDeath"){
            newDeath(item.killed, item.group, item.container);
        }
    })
})

function addKill(killer, killed, weapon, killergroup, killedgroup, container, distance) {
    $('<div class="' + container +'"><span class="' + killergroup + '">' + killer + '</span><img src="img/' + weapon + '.webp" class="weapon"><span class="' + killedgroup + '">' + killed + '<span class="distance">' + distance + '</span></div><br class="clear">').appendTo('.kills')
    .css({'margin-right':-$(this).width()+'px'})
    .animate({'margin-right':'0px'}, 'slow')
    .delay(5000)
    .animate({'margin-right':-$(this).width()+'px'}, 'slow')
    .queue(function() { $(this).remove(); });
    //$(".kills").append('<div class="killContainer"><span class="killer">' + killer + '</span><img src="https://wiki.rage.mp/images/1/16/Combat-pistol-icon.png" class="weapon"><span class="killed">' + killed + '</span></div><br class="clear">');
}

function newDeath(killed, group, container) {

    $('<div class="' + container +'"><span class=' + group +'>' + killed + '</span><img src="img/death.webp" class="weapon">').appendTo('.kills')
    .css({'margin-right':-$(this).width()+'px'})
    .animate({'margin-right':'0px'}, 'slow')
    .delay(5000)
    .animate({'margin-right':-$(this).width()+'px'}, 'slow')
    .queue(function() { $(this).remove(); });
    //$(".kills").append('<div class="killContainer"><span class="killer">' + killer + '</span><img src="https://wiki.rage.mp/images/1/16/Combat-pistol-icon.png" class="weapon"><span class="killed">' + killed + '</span></div><br class="clear">');
}