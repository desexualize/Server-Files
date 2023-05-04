$(document).ready(function(){
    window.addEventListener("message", function(event){
    if(event.data.update == true){
        positionHud(event.data.topLeftAnchor,event.data.yAnchor)
        setMoney(event.data.chips,'#chips-text');

    }
    if(event.data.talking == true){
    } else {
    }
    if(event.data.showhud == false){
        document.getElementById('chips-text').style.display = "none";
        document.getElementById('bighudfam').style.display = "none";
    }
    if(event.data.showhud == true){
        document.getElementById('chips-text').style.display = "block";
        document.getElementById('bighudfam').style.display = "block";      
    }
    });

    function setMoney(amount, element){
        $(element).text(amount);
    }
    function positionHud(topLeftAnchor,yAnchor){
        $( ".hud" ).css( "left", topLeftAnchor + "px" );
        $( ".hud" ).css( "top", yAnchor + "px" );
    }



});