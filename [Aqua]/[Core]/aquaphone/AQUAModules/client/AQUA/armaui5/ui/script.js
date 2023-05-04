$(document).ready(function(){
    var vehicleItems = [
        {
            id   : 'lock',
            title: 'Lock Car',
            icon: '#carLock'
        },
        {
            id   : 'openBoot',
            title: 'Open Boot',
            icon: '#openBoot'
        },
        {
            id   : 'cleanCar',
            title: 'Clean Car',
            icon: '#cleanCar'
        },
        {
            id   : 'lockpick',
            title: 'Lockpick',
            icon: '#lockpick'
        },
        {
            id   : 'repair',
            title: 'Repair',
            icon: '#repair'
        },
        {
            id   : 'openHood',
            title: 'Open Hood',
            icon: '#openHood'
        },
        {
            id   : 'searchvehicle',
            title: 'Search Vehicle',
            icon : '#searchVehicle'
        },
    ];
    var vehicleItemsPolice = [
        {
            id   : 'lock',
            title: 'Lock Car',
            icon: '#carLock'
        },
        {
            id   : 'openBoot',
            title: 'Open Boot',
            icon: '#openBoot'
        },
        {
            id   : 'cleanCar',
            title: 'Clean Car',
            icon: '#cleanCar'
        },
        {
            id   : 'lockpick',
            title: 'Lockpick',
            icon: '#lockpick'
        },
        {
            id   : 'repair',
            title: 'Repair',
            icon: '#repair'
        },
        {
            id   : 'openHood',
            title: 'Open Hood',
            icon: '#openHood'
        },
        {
            id   : 'police',
            title: 'MET Police',
            icon: '#metPolice', //was #more
            items: [
                {
                    id   : 'searchvehicle',
                    title: 'Search Vehicle',
                    icon : '#searchVehicle'
                },
                {
                    id   : 'impoundVehicle',
                    title: 'Impound Vehicle',
                    icon : '#searchVehicle'
                },
                {
                    id   : 'askDriverId',
                    title: 'Ask Driver ID',
                    icon : '#askId'
                },
            ]
        },
    ];

    var pedItems = [
        {
            id   : 'askId',
            title: 'Ask ID',
            icon: '#askId'
        },
        {
            id   : 'giveCash',
            title: 'Give Cash',
            icon: '#giveMoney'
        },
        {
            id   : 'search',
            title: 'Search Player',
            icon: '#searchPerson'
        },
        {
            id   : 'robPerson',
            title: 'Rob Person',
            icon: '#robPlayer'
        },
        {
            id   : 'revive',
            title: 'CPR',
            icon: '#cpr'
        },
    ];

    var pedItemsPolice = [
        {
            id   : 'askId',
            title: 'Ask ID',
            icon: '#askId'
        },
        {
            id   : 'giveCash',
            title: 'Give Cash',
            icon: '#giveMoney'
        },
        {
            id   : 'search',
            title: 'Search Player',
            icon: '#searchPerson'
        },
        {
            id   : 'robPerson',
            title: 'Rob Person',
            icon: '#robPlayer'
        },
        {
            id   : 'revive',
            title: 'CPR',
            icon: '#cpr'
        },
        {
            id   : 'police',
            title: 'MET Police',
            icon: '#metPolice', //was #more
            items: [
                {
                    id   : 'handcuff',
                    title: 'Handcuff',
                    icon: '#handcuff'
                },
                {
                    id   : 'drag',
                    title: 'Drag',
                    icon: '#drag'
                },
                {
                    id   : 'putincar',
                    title: 'Put in car',
                    icon: '#putInVehicle'
                },
                {
                    id   : 'gunshottest',
                    title: 'GSR Test',
                    icon : '#seizeWeapons'
                },
                {
                    id   : 'jail',
                    title: 'Jail',
                    icon : '#jail'
                },
                // {
                //     id   : 'requesttransport',
                //     title: 'Transport',
                //     icon : '#putInVehicle'
                // },
                {
                    id   : 'seizeweapons',
                    title: 'Seize Weapons',
                    icon : '#seizeWeapons'
                },
                {
                    id   : 'seizeillegals',
                    title: 'Seize Illegals',
                    icon : '#seizeIllegal'
                },
            ]
        },
    ];

    var vehicleMenu = undefined
    var pedMenu = undefined

    window.addEventListener('message', function(event){
        if(event.data.crosshair == true){
            $(".crosshair").addClass('fadeIn');
        }

        if(event.data.crosshair == false){
            $(".crosshair").removeClass('fadeIn');
        }

        if(event.data.openMenu == true){
            if(event.data.type == "ped"){
                if (event.data.police == true) {
                    pedMenu = new RadialMenu({
                        parent      : document.getElementById("centerRadial"),
                        size        : 500,
                        closeOnClick: true,
                        menuItems   : pedItemsPolice,
                        onClick     : function (item) {
                            $.post('http://armaui5/radialClick', JSON.stringify({
                                itemid: item.id,
                                entity: event.data.entityId
                            }));
                        }
                    });
                }else{
                    pedMenu = new RadialMenu({
                        parent      : document.getElementById("centerRadial"),
                        size        : 500,
                        closeOnClick: true,
                        menuItems   : pedItems,
                        onClick     : function (item) {
                            $.post('http://armaui5/radialClick', JSON.stringify({
                                itemid: item.id,
                                entity: event.data.entityId
                            }));
                        }
                    });
                }
                pedMenu.open();

            }else if(event.data.type == "vehicle"){
                if (event.data.police == true) {
                    vehicleMenu = new RadialMenu({
                        parent      : document.getElementById("centerRadial"),
                        size        : 500,
                        closeOnClick: true,
                        menuItems   : vehicleItemsPolice,
                        onClick     : function (item) {
                            $.post('http://armaui5/radialClick', JSON.stringify({
                                itemid: item.id,
                                entity: event.data.entityId
                            }));
                        }
                    });
                }else{
                    vehicleMenu = new RadialMenu({
                        parent      : document.getElementById("centerRadial"),
                        size        : 500,
                        closeOnClick: true,
                        menuItems   : vehicleItems,
                        onClick     : function (item) {
                            $.post('http://armaui5/radialClick', JSON.stringify({
                                itemid: item.id,
                                entity: event.data.entityId
                            }));
                        }
                    });
                }
                vehicleMenu.open();
            }
        }
        if(event.data.closeMenu == true){
            $(".crosshair").removeClass('fadeIn').removeClass('active');
            $(".menu").removeClass('fadeIn');
            $.post('http://armaui5/disablenuifocus', JSON.stringify({
                nuifocus: false
            }));
            if (vehicleMenu != undefined) {
                vehicleMenu.close();
            }
            if (pedMenu != undefined) {
                pedMenu.close();
            }
            vehicleMenu = undefined
            pedMenu = undefined
            document.getElementById("centerRadial").innerHTML = "";
        }
    });

    $(document).keypress(function(e){
        if(e.which == 101){
            $(".crosshair").removeClass('fadeIn').removeClass('active');
            $(".menu").removeClass('fadeIn');
            $.post('http://armaui5/disablenuifocus', JSON.stringify({
                nuifocus: false
            }));
            if (vehicleMenu != undefined) {
                vehicleMenu.close();
            }
            if (pedMenu != undefined) {
                pedMenu.close();
            }
            vehicleMenu = undefined
            pedMenu = undefined
            document.getElementById("centerRadial").innerHTML = "";
        }
    });
});

