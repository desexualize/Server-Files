var news;
const formatter = new Intl.NumberFormat('en-US', {
    style: 'currency',
    currency: 'GBP',
    minimumFractionDigits: 0
})
let pnc;
const routes = [
  {"path":"main.page.html", component: MainPage},
  {"path":"nav.component.html", component: PersonSearchNav},
  {"path":"personlookup.page.html", component: PersonLookup},
];


document.addEventListener("DOMContentLoaded", async function () {
    //register components
    try {
        for(let route of routes) {
            await RegisterVueComponent(route.component, route.path)
        }
        RegisterVue()
    } catch (error) {
        console.log(error)
        RegisterVue()
    }
});

async function RegisterVueComponent(component, path) {
    const response = await fetch("nui://arma/ui/pnc/components/"+path);
    component.template = await response.text();
    Vue.component(component.name, component);
}

function RegisterVue() {
    pnc = new Vue({
        el: "#pnccontainer",
        data: {
            page: "main",
            personFirstName: "",
            personLastName: "",
            plate: "",
            plateSearchErr: "",
            goldcommand: false,
            fto: false,
            news: [
                // {id: 1, title: "News", desc: "test 123 test 123", author: "Arthur", date: "07/1/12"}
            ],
            attention_drawn: [],
            fines: fines,
            searchedPersons:[],
            selectedPerson:{
                firstname: "",
                lastname: "",
                age: "",
                id: "",
                vehicles:[],
                homes: [],
                active: false,
                otherprevs: [],
                notes: "",
                phone: "",
                points: "",
                licence: "",
                warning_markers: [
                    // {type:"FI", reason: "Registered shotgun certificate holder. This is a very long string to test what is looks like you know. Heaton?"},
                    // {type:"IF", reason: "Known to dress up as a female."},
                ]
            },
            selectedfine:{
                title: "",
                subfines:[]
            },
            selectedfines:[],
            selectedpoints:[],
            personPages:[
                "fines",
                "ad",
                "new-fines",
                "oldfines",
                "dvsa"
            ],
            newFine:{
                amount: 0,
                fines:[],
                notes: "",

            },
            finePageMsg: "",
            clock: "",
            officer:{
                id: "",
                name: "",
            },
            ADInput: "",
            searchedVehicle: {
                colour: "",
                name: "",
                plate: "",
                owner: {
                    firstname: "",
                    lastname: "",
                    user_id: "",
                    age: ""
                },
                notes: "",
                vehicle: "",
                ownerhaslicense: false,
                plateImage: ""

            },
            vehicleSearchSavedNotifaction: "",
            formatter: formatter,
            JSON: JSON,
            selectedOldFine: {
                officer_name: "",
                officer_id: "",
                amount: "",
                charges: [],
                notes: ""
            },
            selectedAd: {
                ad: "",
                index: -1,
                table_index: 0,
            },
            searchPersonPageMessage: "",
            selectedWarningMarkerType: "FI",
            warningMarkerReason: "",
            enteredAccessCode: "",
            selectedADType: "veh",
            AD: {
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
            },
            points: points,
            shouldDisplayDeleteButton: false,
            removeADText: "Remove Selected Attention Drawn",
            askedIfSure: false
        },
        methods: {
            addMarker() {
                if(!this.doesPlayerHaveWarningMarkerOfType(this.selectedWarningMarkerType)) {
                    $.post('https://arma/addmarker', JSON.stringify({
                        id: this.selectedPerson.id,
                        type: this.selectedWarningMarkerType,
                        reason: this.warningMarkerReason
                    }));
                    this.selectedPerson.warning_markers.push({type: this.selectedWarningMarkerType, reason: this.warningMarkerReason})
                }
            },
            wipeAllMarkers() {
                $.post('https://arma/wipeallmarkers', JSON.stringify({
                    code: this.enteredAccessCode
                }));
            },
            doesPlayerHaveWarningMarkerOfType(type) {
                for(let marker of this.selectedPerson.warning_markers) {
                    if(marker.type == type) {
                        return true
                    }
                    return false
                }
            },
            selectPoint(point) {
                this.selectedpoints.push(point)
            },
            removePoint(index) {
                this.selectedpoints.splice(index, 1);
            },
            addPoint() {
                $.post('https://arma/addpoint', JSON.stringify({
                    points: this.selectedpoints,
                    id: this.selectedPerson.id
                }));
            },
            switchPage(page) {
                if(this.personPages.includes(page)){
                    if (this.selectedPerson.id){
                        this.page = page
                    }else{
                        console.log("[ARMA PNC] Person needs to be selected to enter this page")
                    }
                }else {
                    this.page = page;
                }
            },
            closePNC() {
                $.post('https://arma/exit', JSON.stringify({}));
            },
            searchPerson(){
                let first = this.personFirstName;
                let last = this.personLastName;
                if (first == "" || last == "") {
                    console.log("[ARMA PNC] Full name needs to be provided")
                }else{
                    $.post('https://arma/personsearch', JSON.stringify({
                        firstname: first,
                        lastname: last
                    }));
                }
            },
            searchPlate(){
                if(this.plate == ""){
                    this.plateSearchErr = "Please enter a plate"
                    return
                }
                $.post("https://arma/platesearch", JSON.stringify({
                    plate: this.plate
                }))
            },
            selectPerson(person){
                for(p of this.searchedPersons){
                    p.isActive = false
                }

                person.isActive = true
                this.selectedPerson.firstname = person.fName
                this.selectedPerson.lastname = person.lName
                this.selectedPerson.age = person.age
                this.selectedPerson.id = person.id
                this.selectedPerson.vehicles = person.vehicles
                this.selectedPerson.homes = person.home
                this.selectedPerson.otherprevs = person.warrants
                this.selectedPerson.phone = person.phone
                this.selectedPerson.notes = person.notes
                this.selectedPerson.points = person.points
                this.selectedPerson.licence = person.licence
                this.selectedPerson.warning_markers = person.warning_markers
            },
            selectFine(fine){
                this.selectedfine.title = fine.title
                this.selectedfine.subfines = fine.subcats
            },
            addFine(fine){
                if(this.newFine.fines.includes({fine: fine.main, amount: fine.amount})){
                    return;
                }
                this.newFine.fines.push({fine: fine.main, amount: fine.amount})
                this.newFine.suggestedAmount = this.newFine.suggestedAmount + fine.amount
                // this.newFine.amount = this.newFine.amount + fine.amount
            },
            removeFine(index){
                this.newFine.fines.splice(index, 1);
            },
            submitFine() {
                if (this.newFine.fines.length == 0 || this.newFine.amount == 0) {
                    return;
                }
                $.post('https://arma/submitfine', JSON.stringify({
                    charges: this.newFine.fines,
                    amount: this.newFine.amount,
                    notes: this.newFine.notes,
                    user_id: this.selectedPerson.id
                }));
            },
            verifyFine(bool, msg){

                if(bool) {
                    this.newFine.amount = 0
                    this.newFine.fines = []
                    this.newFine.notes = ""
                    this.finePageMsg = "Fine sent successfully"
                }else {
                    this.newFine.amount = 0
                    this.newFine.fines = []
                    this.newFine.notes = ""
                    this.finePageMsg = `Error sending fine(${msg})`
                }

            },
            addAD(){

                if (this.ADInput.length === 0) {
                    return console.log("Attention Drawn Field can not be empty")
                }else {
                    $.post('https://arma/addattentiondrawn', JSON.stringify({
                        ad: this.ADInput
                    }));
                }

            },
            removeAD(index, ad) {
                if(this.askedIfSure) {
                    this.attention_drawn.splice(this.selectedAd.index, 1);
                    $.post('https://arma/removeattentiondrawn', JSON.stringify({
                        ad: this.selectedAd.index
                    }));
                    this.shouldDisplayDeleteButton = false
                    this.removeADText = "Remove Selected Attention Drawn"
                    this.askedIfSure = false
                } else {
                    this.removeADText = "Are you sure you want to do this?";
                    this.askedIfSure = true
                }
            },
            selectAD(ad, index, i) {
                console.log(ad)
                this.selectedAd.index = index;
                this.selectedAd.ad = ad;
                this.selectedAd.table_index = i
                this.shouldDisplayDeleteButton = true
            },
            saveNotes() {
                $.post('https://arma/savenotes', JSON.stringify({
                    notes: this.searchedVehicle.notes,
                    user_id: this.searchedVehicle.owner.user_id,
                    vehicle: this.searchedVehicle.vehicle
                }));
                this.vehicleSearchSavedNotifaction = "Note saved successfully"
            },
            selectOldFine(fine) {
                // console.log(fine.extra_notes)
                this.selectedOldFine.officer_name = fine.officer_name;
                this.selectedOldFine.officer_id = fine.officer_id;
                this.selectedOldFine.amount = fine.amount;
                this.selectedOldFine.charges = JSON.parse(fine.description);
                this.selectedOldFine.notes = fine.extra_notes
            },
            getPlateImage(plate) {
                $.get(`https://api.arthur.gg/cmgimage/plate?plate=${plate}`)
                return `https://api.arthur.gg/cmgimage/plate?plate=${plate}`
            },
            getTaxDisc(name, plate, id) {
                $.get(`https://api.arthur.gg/cmgimage/tax?plate=${plate}&name=${name}&id=${id}`)
                return `https://api.arthur.gg/cmgimage/tax?plate=${plate}&name=${name}&id=${id}`
            },
            savePersonNotes() {
                $.post("https://arma/savepersonnotes", JSON.stringify({
                    user_id: this.selectedPerson.id,
                    notes: this.selectedPerson.notes
                }))
            },
            GetWarrant() {
                $.post("https://arma/generatewarrant", JSON.stringify({}))
            }
            },


        computed: {

        },

    });
}


function show(bool){
    if(bool){
        $("#pnccontainer").show();
        $("#userbuttons").hide();
        $("#otherbox").hide();
        $("#fines-sub").hide()
        $("#gcbtn").hide()
        $("#notesshit").hide()
        $("#prevshit").hide()
    }else{
        $("#pnccontainer").hide();
        $("#userbuttons").hide();
        $("#otherbox").hide();
        $("#fines-sub").hide()
        $("#gcbtn").hide()
        $("#notesshit").hide()
        $("#prevshit").hide()
    }
}


function clearAllPersonData(){
    pnc.searchedPersons = []
    // pnc.personFirstName = "",
    // pnc.personLastName = "",
    pnc.selectedPerson.firstname = "",
    pnc.selectedPerson.lastname = "",
    pnc.selectedPerson.age = "",
    pnc.selectedPerson.id = "",
    pnc.selectedPerson.phone = "",
    pnc.selectedPerson.vehicles = []
    pnc.selectedOldFine.officer_name = ""
    pnc.selectedOldFine.officer_id = "";
    pnc.selectedOldFine.amount = 0;
    pnc.selectedOldFine.charges = [];
    pnc.searchedVehicle.name = ""
    pnc.searchedVehicle.plate = ""
    pnc.searchedVehicle.colour = ""
    pnc.searchedVehicle.owner.user_id = ""
    pnc.searchedVehicle.owner.firstname = ""
    pnc.searchedVehicle.owner.lastname = ""
    pnc.searchedVehicle.owner.age = ""
    pnc.searchedVehicle.notes = ""
    pnc.searchedVehicle.vehicle = ""
    pnc.searchedVehicle.ownerhaslicense = "",
    pnc.selectedPerson.warning_markers = {}
    pnc.AD = {
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
}

function clearSelectedPerson(){
    pnc.selectedPerson.firstname = "",
    pnc.selectedPerson.lastname = "",
    pnc.selectedPerson.age = "",
    pnc.selectedPerson.id = "",
    pnc.selectedPerson.vehicles = []
}

class CCTV {
    cameraLabel = ""
    camerasOpen = false
    cameraBoxLabel = ""
    OpenCameras(box, label) {
        this.cameraLabel = label;
        this.cameraBoxLabel = box;
        this.camerasOpen = true;
        let cElem = document.getElementById("Camera_Container");
        cElem.style.width = "100%";
        cElem.style.height = "100%";
        document.getElementById("Camera_Label").innerText = this.cameraLabel;
        document.getElementById("Camera_Label2").innerText = this.cameraBoxLabel;
        $("#Camera_Container").show();
    }
    CloseCameras() {
        this.camerasOpen = false;
        let cElem = document.getElementById("Camera_Container");
        cElem.style.width = "0%";
        cElem.style.height = "0%";
        $("#Camera_Container").hide();
    }
    UpdateCameraLabel(label) {
        this.cameraLabel = label;
    }
}

const cctv = new CCTV();



document.onreadystatechange = () => {
    if (document.readyState === "complete") {
        cctv.CloseCameras();
        window.addEventListener('message', function(event) {
            let item = event.data
            if (item.type === "ui") {
                if (item.status == true) {
                    updateClock()
                    pnc.news = item.news
                    pnc.attention_drawn = []
                    pnc.attention_drawn = item.ad
                    pnc.goldcommand = item.gc
                    pnc.officer.id = item.id
                    pnc.officer.name = item.name
                    if(pnc.page != "main"){
                        pnc.page = "main"
                    }
                    show(true)
                } else {
                    pnc.goldcommand = false
                    show(false)
                }
            } else if(item.type == "addPersons"){
                clearAllPersonData()
                clearSelectedPerson()
                pnc.searchPersonPageMessage = ""
                for(u of item.user){
                    //console.log(JSON.stringify(u))
                    pnc.searchedPersons.push({fName: u.firstname, warning_markers: u.warning_markers, points:u.points, licence: u.licence, lName:u.lastname, id: u.user_id, age: u.age, notes: u.notes, vehicles: u.vehicles, warrants: u.warrants, home: u.playerhome, phone: u.phone, isActive: false})
                }

            }  else if (item.type == "verifyFine"){
                pnc.verifyFine(item.sentornah, item.msg)
            } else if (item.type == "displaySearchedVehicle") {
                this.console.log(item.vehicle)
                pnc.searchedVehicle.name = item.vehicle[0].name
                pnc.searchedVehicle.plate = item.vehicle[0].plate
                // pnc.searchedVehicle.colour = item.vehicle[0].colour
                pnc.searchedVehicle.owner.user_id = item.vehicle[0].owner.user_id
                pnc.searchedVehicle.owner.firstname = item.vehicle[0].owner.firstname
                pnc.searchedVehicle.owner.lastname = item.vehicle[0].owner.name
                pnc.searchedVehicle.owner.age = item.vehicle[0].owner.age
                pnc.searchedVehicle.notes = item.vehicle[0].notes
                pnc.searchedVehicle.vehicle = item.vehicle[0].vehicle
                pnc.searchedVehicle.ownerhaslicense = item.vehicle[0].owner_has_license

            } else if (item.type == "updateAttentionDrawn") {
                pnc.attention_drawn = item.ad
            } else if (item.type == "NoPersonsFound") {
                pnc.searchPersonPageMessage = "Nothing found for that search"
            } else if (item.type == "setNameFields") {
                pnc.personFirstName = item.fname
                pnc.personLastName = item.lname
            } else if (item.type == "noveh") {
                pnc.plateSearchErr = item.message
            }
            if (event.data.type == "enablecam") {
                cctv.OpenCameras(event.data.box, event.data.label);
            } else if (event.data.type == "disablecam") {
                cctv.CloseCameras();
            } else if (event.data.type == "updatecam") {
                cctv.UpdateCameraLabel(event.data.label);
            }
        })
    }
};

function updateClock(){
    let TodayDate = new Date();
    let min = TodayDate.getMinutes();
    if(min < 10){
        min = `0${min}`
    }
    let hour = TodayDate.getHours();
    pnc.clock = `${hour}:${min}`
}

setInterval(updateClock, 10000)

document.onkeydown = function (data) {
    if (data.which == 118 || data.which == 27) {
        clearAllPersonData()
        pnc.closePNC()
        return
    }
};



