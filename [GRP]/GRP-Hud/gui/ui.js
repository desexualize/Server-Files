$(document).ready(function(){
    window.addEventListener('message', function(event) {
        if(event.data.action == "show"){
            $(".container").fadeIn();
            document.getElementById("moneytext").innerHTML = event.data.cash;
            document.getElementById("banktext").innerHTML = event.data.bank;
            document.getElementById("nametext").innerHTML = event.data.name;
            var data = event.data;
            $("#health").css("width", data.health + "%");
            $("#armor").css("width", data.armor + "%");
        } else if(event.data.action == "hide"){
            $(".container").fadeOut();
        }

        positionHud(event.data.topLeftAnchor,event.data.yAnchor)

        function positionHud(topLeftAnchor,yAnchor){
          $( ".hud" ).css( "left", topLeftAnchor + "px" );
          $( ".hud" ).css( "top", yAnchor + "px" );
          }


        function updateClock() {
            var now = new Date(),
                time = (now.getHours()<10?'0':'') + now.getHours() + ':' + (now.getMinutes()<10?'0':'') + now.getMinutes();
        
            document.getElementById("hourtext").innerHTML = [time];
            setTimeout(updateClock, 1000);
          }
          updateClock();
        
    });
});