const MainPage = {
    name:"main-page",
    template: ``,
    data: function() {
        return {
            vehicle : {
                model: "",
                colour: "",
                plate: "",
            },
            person: {
                sex: "",
                name: "",
                general_desc: "",
                hair_colour: ""
            },
            reason: ""
        }
    },    
    methods: {
        addAttentionDrawn() {
            const type = pnc.selectedADType;
            const reason = pnc.AD.reason;
            switch(type) {
                case "veh" : 
                    const vehicle = pnc.AD.vehicle;
                    $.post('http://arma/addattentiondrawn', JSON.stringify({
                        data: `Vehicle Model: ${vehicle.model}. Colour: ${vehicle.colour}. Plate: ${vehicle.plate} | ${reason}`, //Vehicle Model: GTR. Colour: Black. Plate: TOPDEV : Firearms
                        type: "Vehicle",
                        reason: reason,
                        AD: vehicle
                    }));
                    break;
                case "person":
                    const person = pnc.AD.person;
                    $.post('http://arma/addattentiondrawn', JSON.stringify({
                        data: `Sex: ${person.sex}. Name: ${person.name}. Description: ${person.general_desc} Hair Colour: ${person.hair_colour} | ${reason}`, //Vehicle Model: GTR. Colour: Black. Plate: TOPDEV : Firearms
                        type: "Person",
                        reason: reason,
                        AD: person
                    }));
                    break;               
                default:
                    break
            }
        }
    },
};