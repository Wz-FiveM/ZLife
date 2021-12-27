var type = "normal";
var disabled = false;
var disabledFunction = null;
var ownerHouse = null;
var Hotbar = [false, false, false, false, false]
isShowingContainer = true;

window.addEventListener("message", function(event) {
    if (event.data.action == "display") {
        type = event.data.type
        msgShown = event.data.dataTest
        disabled = false;

        if (type === "normal") {
            $("#noSecondInventoryMessage").hide();
            if (isShowingContainer) {
                $("#otherInventory").show();
                $("#iwacontenair").show();
                $(".info-div").show();
                /*  $(".stats").hide(); */
            } else {
                $("#otherInventory").hide();
                $("#iwacontenair").hide();
                $(".info-div").hide();
                /*  $(".stats").hide(); */
            };
        } else if (type === "trunk") {
            $("#noSecondInventoryMessage").hide();
            document.getElementById("iwacontenair").textContent = msgShown;
            $(".inventory").show();
            if (isShowingContainer) {
                $("#otherInventory").show();
                $("#iwacontenair").show();
                $(".info-div").show();
                /* $(".stats").hide(); */
            } else {
                $("#otherInventory").hide();
                $("#iwacontenair").hide();
                $(".info-div").hide();
                /* $(".stats").hide(); */
            };
        } else if (type === "shop") {
            $("#otherInventory").show();
        } else if (type === "property") {
            $(".info-div").hide();
            $("#otherInventory").show();
            ownerHouse = event.data.owner;
        } else if (type === "glovebox") {
            $(".info-div").show();
            $("#otherInventory").show();
        } else if (type === "player") {
            $(".info-div").show();
            $("#otherInventory").show();
            $("#playerInventory").show();
            $("#iwacontenair").show();
            $("#showcontainer").show();
            document.getElementById("iwacontenair").textContent = "Inventaire du joueur";
        }

        $(".ui").fadeIn();
    } else if (event.data.action == "hide") {
        $("#dialog").dialog("close");
        $(".ui").fadeOut();
        $(".item").remove();
    } else if (event.data.action == "setItems") {
        inventorySetup(event.data.itemList, event.data.fastItems);
        $(".info-div2").html(event.data.text);

        $('.item').draggable({
            helper: 'clone',
            appendTo: 'body',
            zIndex: 99999,
            revert: 'invalid',
            start: function(event, ui) {
                if (disabled) {
                    return false;
                }

                $(this).css('background-image', 'none');
                itemData = $(this).data("item");
                itemInventory = $(this).data("inventory");
            },
            stop: function() {
                itemData = $(this).data("item");

                if (itemData !== undefined && itemData.name !== undefined) {
                    $(this).css('background-image', 'url(\'img/items/' + itemData.name + '.png\'');
                }
            }
        });
    } else if (event.data.action == "setClothesInventoryItems") {
        clothesInventorySetup(event.data.itemList);
        $(".info-div2").html(event.data.text);

        $('.item').draggable({
            helper: 'clone',
            appendTo: 'body',
            zIndex: 99999,
            revert: 'invalid',
        })
    } else if (event.data.action == "setSecondInventoryItems") {
        secondInventorySetup(event.data.itemList);
        $('.item').draggable({
            helper: 'clone',
            appendTo: 'body',
            zIndex: 99999,
            revert: 'invalid',
        })
    } else if (event.data.action == "setVehiclesInventoryItems") {
        vehiclesInventorySetup(event.data.itemList);
        $(".info-div2").html(event.data.text);

        $('.item').draggable({
            helper: 'clone',
            appendTo: 'body',
            zIndex: 99999,
            revert: 'invalid',
        })
    } else if (event.data.action == "setShopInventoryItems") {
        shopInventorySetup(event.data.itemList)
    } else if (event.data.action == "setInfoText") {
        $(".info-div").html(event.data.text);
    } else if (event.data.action == "nearPlayers") {
        $.post("http://zProperty/GiveItem", JSON.stringify({
            item: event.data.item,
            number: parseInt($("#count").val())
        }));
    }
});

function closeInventory() {
    $.post("http://zProperty/NUIFocusOff", JSON.stringify({}));
}

function inventorySetup(items, fastItems) {
    $("#playerInventory").html("");
    $.each(items, function(index, item) {
        count = setCount(item);

        $("#playerInventory").append('<div class="slot"><div id="item-' + index + '" class="item" style = "background-image: url(\'img/items/' + item.name + '.png\')">' +
            '<div class="item-count">' + count + '</div> <div class="item-name">' + item.label + '</div> </div ><div class="item-name-bg"></div></div>');
        $('#item-' + index).data('item', item);
        $('#item-' + index).data('inventory', "main");
    });
    $("#playerInventoryFastItems").html("");
    var i;
    for (i = 1; i < 6; i++) {
        $("#playerInventoryFastItems").append('<div class="slotFast"><div id="itemFast-' + i + '" class="item" >' +
            '<div class="keybind">' + i + '</div><div class="item-count"></div> <div class="item-name"></div> </div ><div class="item-name-bg"></div></div>');
    }

    Hotbar = [false, false, false, false, false]
}

function secondInventorySetup(items) {
    $("#otherInventory").html("");
    $.each(items, function(index, item) {
        count = setCount(item);

        $("#otherInventory").append('<div class="slotfix"><div id="itemOther-' + index + '" class="item" style = "background-image: url(\'img/items/' + item.name + '.png\')">' +
            '<div class="item-count">' + count + '</div> <div class="item-name">' + item.label + '</div> </div ><div class="item-name-bg"></div></div>');
        $('#itemOther-' + index).data('item', item);
        $('#itemOther-' + index).data('inventory', "second");
    });
}

function clothesInventorySetup(items) {
    $("#playerInventory").html("");
    $.each(items, function(index, item) {
        count = setCount(item);

        $("#playerInventory").append('<div class="slot"><div id="item-' + index + '" class="item" style = "background-image: url(\'img/items/' + item.name + '.png\')">' +
            '<div class="item-count">' + count + '</div> <div class="item-name">' + item.label + '</div> </div ><div class="item-name-bg"></div></div>');
        $('#item-' + index).data('item', item);
        $('#item-' + index).data('inventory', "main");
    });
}

function vehiclesInventorySetup(items) {
    $("#playerInventory").html("");
    $.each(items, function(index, item) {
        count = setCount(item);

        $("#playerInventory").append('<div class="slot"><div id="item-' + index + '" class="item" style = "background-image: url(\'img/items/' + item.name + '.png\')">' +
            '<div class="item-count">' + count + '</div> <div class="item-name">' + item.label + '</div> </div ><div class="item-name-bg"></div></div>');
        $('#item-' + index).data('item', item);
        $('#item-' + index).data('inventory', "main");
    });
}

function shopInventorySetup(items) {
    $("#otherInventory").html("");
    $.each(items, function(index, item) {
        //count = setCount(item)
        cost = setCost(item);

        $("#otherInventory").append('<div class="slotfix"><div id="itemOther-' + index + '" class="item" style = "background-image: url(\'img/items/' + item.name + '.png\')">' +
            '<div class="item-count">' + cost + '</div> <div class="item-name">' + item.label + '</div> </div ><div class="item-name-bg"></div></div>');
        $('#itemOther-' + index).data('item', item);
        $('#itemOther-' + index).data('inventory', "second");
    });
}

function Interval(time) {
    var timer = false;
    this.start = function() {
        if (this.isRunning()) {
            clearInterval(timer);
            timer = false;
        }

        timer = setInterval(function() {
            disabled = false;
        }, time);
    };
    this.stop = function() {
        clearInterval(timer);
        timer = false;
    };
    this.isRunning = function() {
        return timer !== false;
    };
}

function disableInventory(ms) {
    disabled = true;

    if (disabledFunction === null) {
        disabledFunction = new Interval(ms);
        disabledFunction.start();
    } else {
        if (disabledFunction.isRunning()) {
            disabledFunction.stop();
        }

        disabledFunction.start();
    }
}

function setCount(item) {
    count = item.count

    if (item.limit > 0) {
        count = item.count
    }

    if (item.type === "item_weapon") {
        if (count == 0) {
            count = "";
        } else {
            count = '<img src="img/bullet.png" class="ammoIcon"> ' + item.count;
        }
    }

    if (item.type === "item_account" || item.type === "item_money") {
        count = formatMoney(item.count);
    }

    return count;
}

function setCost(item) {
    cost = item.price

    if (item.price == 0) {
        cost = "Grátis"
    }
    if (item.price > 0) {
        cost = "€" + item.price
    }
    return cost;
}

function formatMoney(n, c, d, t) {
    var c = isNaN(c = Math.abs(c)) ? 2 : c,
        d = d == undefined ? "." : d,
        t = t == undefined ? "," : t,
        s = n < 0 ? "-" : "",
        i = String(parseInt(n = Math.abs(Number(n) || 0).toFixed(c))),
        j = (j = i.length) > 3 ? j % 3 : 0;

    return s + (j ? i.substr(0, j) + t : "") + i.substr(j).replace(/(\d{3})(?=\d)/g, "$1" + t);
};


$(document).ready(function() {
    $("#count").focus(function() {
        $(this).val("")
    }).blur(function() {
        if ($(this).val() == "") {
            $(this).val("1")
        }
    });

    $("body").on("keyup", function(key) {
        if (Config.closeKeys.includes(key.which)) {
            closeInventory();
        }
    });

    $(document).mousedown(function(event) {

        if (event.which != 3) return

        itemData = $(event.target).data("item");

        if (itemData == undefined || itemData.usable == undefined) {
            return;
        }

        itemInventory = $(event.target).data("inventory");

        if (itemInventory == "second") {
            $.post("http://zProperty/TakeFromChest", JSON.stringify({
                item: itemData,
                number: Math.floor((itemData.count / 2)),
            }));
        } else {
            $(event.target).effect("pulsate", "slow");
        }

    });


    $(document).mousedown(function(event) {

        if (event.which != 2) return

        itemData = $(event.target).data("item");

        if (itemData == undefined || itemData.usable == undefined) {
            return;
        }

        itemInventory = $(event.target).data("inventory");

        $(event.target).effect("shake", "up");
        if (itemInventory == "main") {
            $.post("http://zProperty/PutIntoChest", JSON.stringify({
                item: itemData,
                number: itemData.count,
            }));
        } else {
            $.post("http://zProperty/TakeFromChest", JSON.stringify({
                item: itemData,
                number: itemData.count,
            }));
        }
    });

    $('#playerInventory').droppable({
        drop: function(event, ui) {
            itemData = ui.draggable.data("item");
            itemInventory = ui.draggable.data("inventory");

            if (type === "Chest") {
                disableInventory(500);
                $.post("http://zProperty/TakeFromChest", JSON.stringify({
                    item: itemData,
                    number: parseInt($("#count").val())
                }));
                if (itemData.type === "item_weapon") {
                    disableInventory(500);
                    Hotbar[itemData.slot - 1] = false;
                    $.post("http://zProperty/TakeFromFast", JSON.stringify({
                        item: itemData
                    }));
                }
            }
        }
    });

    $('#otherInventory').droppable({
        drop: function(event, ui) {
            itemData = ui.draggable.data("item");
            itemInventory = ui.draggable.data("inventory");

            if (type === "Chest" && itemInventory === "main") {
                disableInventory(500);
                $.post("http://zProperty/PutIntoChest", JSON.stringify({
                    item: itemData,
                    number: parseInt($("#count").val())
                }));
                if (itemData.type === "item_weapon") {
                    disableInventory(500);
                    Hotbar[itemData.slot - 1] = false;
                    $.post("http://zProperty/PutIntoFast", JSON.stringify({
                        item: itemData
                    }));
                }
            }
        }
    });
    $("#count").on("keypress keyup blur", function(event) {
        $(this).val($(this).val().replace(/[^\d].+/, ""));
        if ((event.which < 48 || event.which > 57)) {
            event.preventDefault();
        }
    });
});

$.widget('ui.dialog', $.ui.dialog, {
    options: {
        // Determine if clicking outside the dialog shall close it
        clickOutside: false,
        // Element (id or class) that triggers the dialog opening 
        clickOutsideTrigger: ''
    },
    open: function() {
        var clickOutsideTriggerEl = $(this.options.clickOutsideTrigger),
            that = this;
        if (this.options.clickOutside) {
            // Add document wide click handler for the current dialog namespace
            $(document).on('click.ui.dialogClickOutside' + that.eventNamespace, function(event) {
                var $target = $(event.target);
                if ($target.closest($(clickOutsideTriggerEl)).length === 0 &&
                    $target.closest($(that.uiDialog)).length === 0) {
                    that.close();
                }
            });
        }
        // Invoke parent open method
        this._super();
    },
    close: function() {
        // Remove document wide click handler for the current dialog
        $(document).off('click.ui.dialogClickOutside' + this.eventNamespace);
        // Invoke parent close method 
        this._super();
    },
});