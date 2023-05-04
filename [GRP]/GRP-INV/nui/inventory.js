let ItemSelected = undefined;
let personalInv = false;
let invType = undefined;

function ClearPersonalInventory() {
    $('.ItemTable').each(function(i, obj) {
        if (!$(this).hasClass("ExampleTable")) {
            $(this).remove();
        }
    });
    $(ItemSelected).removeClass('ItemSelected')
    ItemSelected = undefined;
}

function ClearSecondaryInventory() {
    $('.ItemSecondTable').each(function(i, obj) {
        if (!$(this).hasClass("ExampleSecondTable")) {
            $(this).remove();
        }
    });
    $(ItemSelected).removeClass('ItemSelected')
    ItemSelected = undefined;
    $('#ndInventoryText').show();
}

$(document).ready(function() {
    $('#UseBtn').click(function() {
        if (personalInv) {
            $.post(`https://${GetParentResourceName()}/UseBtn`, JSON.stringify({ invType: 'Plr', itemId: $(ItemSelected).attr('id') }));
        } else {
            $.post(`https://${GetParentResourceName()}/UseBtn`, JSON.stringify({ invType: 'notpersonalinv' }));
        }
    })
    $('#DropBtn').click(function() {
        if (personalInv) {
            $.post(`https://${GetParentResourceName()}/TrashBtn`, JSON.stringify({ invType: 'Plr', itemId: $(ItemSelected).attr('id') }));
        } else {
            $.post(`https://${GetParentResourceName()}/TrashBtn`, JSON.stringify({ invType: 'notpersonalinv' }));
        }
    })
    $('#GiveBtn').click(function() {
        if (personalInv) {
            $.post(`https://${GetParentResourceName()}/GiveBtn`, JSON.stringify({ invType: 'Plr', itemId: $(ItemSelected).attr('id') }));
        } else {
            $.post(`https://${GetParentResourceName()}/GiveBtn`, JSON.stringify({ invType: 'notpersonalinv' }));
        }
    })
    $('#MoveBtn').click(function() {
        if (personalInv) {
            $.post(`https://${GetParentResourceName()}/MoveBtn`, JSON.stringify({ invType: 'Plr', itemId: $(ItemSelected).attr('id') }));
        } else {
            $.post(`https://${GetParentResourceName()}/MoveBtn`, JSON.stringify({ invType: invType, itemId: $(ItemSelected).attr('id') }));
        }
    })
    $('#MoveXBtn').click(function() {
        if (personalInv) {
            $.post(`https://${GetParentResourceName()}/MoveXBtn`, JSON.stringify({ invType: 'Plr', itemId: $(ItemSelected).attr('id') }));
        } else {
            $.post(`https://${GetParentResourceName()}/MoveXBtn`, JSON.stringify({ invType: invType, itemId: $(ItemSelected).attr('id') }));
        }
    })
    $('#MoveAllBtn').click(function() {
        if (personalInv) {
            $.post(`https://${GetParentResourceName()}/MoveAllBtn`, JSON.stringify({ invType: 'Plr', itemId: $(ItemSelected).attr('id') }));
        } else {
            $.post(`https://${GetParentResourceName()}/MoveAllBtn`, JSON.stringify({ invType: invType, itemId: $(ItemSelected).attr('id') }));
        }
    })
})

window.addEventListener('message', function(event) {
    var msg = event.data;
    if (msg.action == "InventoryDisplay" && msg.showInv) {
        $('#MainInventoryContainer').show();
        $('#ndInventoryText').show();
    } else if (msg.action == "InventoryDisplay" && !msg.showInv) {
        $('#MainInventoryContainer').hide();
        invType = undefined;
        ClearPersonalInventory();
        ClearSecondaryInventory();
        $('#PersonalInventoryWeight').text(`0.00/0.00KG`)
        $('#SecondInventoryWeight').text(`0.00/0.00KG`)
    }
    if (msg.action == "loadItems") {
        ClearPersonalInventory();
        for (var key in msg.items) {
            let newItem = $('.ExampleTable').clone().appendTo("#PersonalInventoryTable");
            $(newItem).find(".ItemName").text(msg.items[key].ItemName)
            $(newItem).find(".ItemQuantity").text(msg.items[key].amount)
            $(newItem).find(".ItemKG").text((msg.items[key].Weight * msg.items[key].amount).toFixed(2) + "KG")
            $(newItem).removeClass('ExampleTable')
            $(newItem).show();
            $(newItem).attr("id", key)
        }
        $('#PersonalInventoryWeight').text(`${(msg.CurrentKG).toFixed(2)}/${msg.MaxKG}KG`)
        $('.ItemTable').each(function(i, obj) {
            if (!$(this).hasClass("ExampleTable")) {
                $(this).click(function() {
                    if (!ItemSelected) {
                        $(this).addClass('ItemSelected')
                        ItemSelected = $(this)
                        personalInv = true;
                    } else {
                        $(ItemSelected).removeClass('ItemSelected')
                        ItemSelected = $(this)
                        $(this).addClass('ItemSelected')
                        personalInv = true;
                    }
                })
            }
        });
    }
    if (msg.action == "loadSecondaryItems") {
        invType = msg.invType
        ClearSecondaryInventory();
        for (var key in msg.items) {
            let newItem = $('.ExampleSecondTable').clone().appendTo("#SecondaryInventoryTable");
            $(newItem).find(".ItemName").text(msg.items[key].ItemName)
            $(newItem).find(".ItemQuantity").text(msg.items[key].amount)
            $(newItem).find(".ItemKG").text((msg.items[key].Weight * msg.items[key].amount).toFixed(2) + "KG")
            $(newItem).removeClass('ExampleSecondTable')
            $(newItem).show();
            $(newItem).attr("id", key)
        }
        $('#SecondInventoryWeight').text(`WEIGHT: ${(msg.CurrentKG).toFixed(2)}/${msg.MaxKG}KG`)
        $('.ItemSecondTable').each(function(i, obj) {
            if (!$(this).hasClass("ExampleSecondTable")) {
                $(this).click(function() {
                    if (!ItemSelected) {
                        $(this).addClass('ItemSelected')
                        ItemSelected = $(this)
                        personalInv = false;
                    } else {
                        $(ItemSelected).removeClass('ItemSelected')
                        ItemSelected = $(this)
                        $(this).addClass('ItemSelected')
                        personalInv = false;
                    }
                })
            }
        });
        $('#ndInventoryText').hide();
    }
});