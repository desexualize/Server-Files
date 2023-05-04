$(document).ready(function(){
    window.addEventListener('message', function(event){
        if(event.data.crosshair == true){
            $(".crosshair").addClass('fadeIn');
        }

        if(event.data.crosshair == false){
            $(".crosshair").removeClass('fadeIn');
        }
    });

    $(document).keypress(function(e){
        if(e.which == 101){
            $(".crosshair").removeClass('fadeIn').removeClass('active');
        }
    });
});

