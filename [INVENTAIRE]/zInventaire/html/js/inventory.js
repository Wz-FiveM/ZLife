var type = "normal";
var disabled = false;
var disabledFunction = null;
var ownerHouse = null;

window.addEventListener("message", function(event) {
    var vetbtn = document.getElementById("showvet");
    var itemsbtn = document.getElementById("showitems");

    vetbtn.onclick = function() {
        $.post("https://zInventaire/ShowClothes");
        $("#otherInventory").hide();
        $(".info-div").hide();
    };
    itemsbtn.onclick = function() {
        $.post("https://zInventaire/ShowItems");
        $("#noSecondInventoryMessage").hide();
        $("#otherInventory").show();
        $(".info-div").show();
    };

    if (event.data.action == "display") {
        type = event.data.type
        disabled = false;

        if (type === "normal") {
            $(".info-div").hide();
            $("#noSecondInventoryMessage").hide();
            $("#otherInventory").hide();
        } else if (type === "trunk") {
            $(".info-div").show();
            $("#otherInventory").show();
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
        }

        $(".ui").fadeIn();
    } else if (event.data.action == "hide") {
        $("#dialog").dialog("close");
        $(".ui").fadeOut();
        $(".item").remove();
        //$("#otherInventory").html("<div id=\"noSecondInventoryMessage\"></div>");
        //$("#noSecondInventoryMessage").html(invLocale.secondInventoryNotAvailable);
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

                if (itemInventory == "second") {
                    $("#drop").addClass("disabled");
                    $("#give").addClass("disabled");
                }

                if (itemInventory == "second" || !itemData.usable) {
                    $("#use").addClass("disabled");
                }
            },
            stop: function() {
                itemData = $(this).data("item");

                if (itemData !== undefined && itemData.name !== undefined) {
                    $(this).css('background-image', 'url(\'img/items/' + itemData.name + '.png\'');
                    $("#drop").removeClass("disabled");
                    $("#use").removeClass("disabled");
                    $("#give").removeClass("disabled");
                }
            }
        });
    } else if (event.data.action == "setSecondInventoryItems") {
        secondInventorySetup(event.data.itemList);
    } else if (event.data.action == "setShopInventoryItems") {
        shopInventorySetup(event.data.itemList)
    } else if (event.data.action == "setInfoText") {
        $(".info-div").html(event.data.text);
    } else if (event.data.action == "nearPlayers") {
        $("#nearPlayers").html("");

        $.each(event.data.players, function(index, player) {
            $("#nearPlayers").append('<button class="nearbyPlayerButton" data-player="' + player.player + '">' + player.label + ' (' + player.player + ')</button>');
        });

        $("#dialog").dialog("open");

        $(".nearbyPlayerButton").click(function() {
            $("#dialog").dialog("close");
            player = $(this).data("player");
            $.post("http://zInventaire/GiveItem", JSON.stringify({
                player: player,
                item: event.data.item,
                number: parseInt($("#count").val())
            }));
        });
    }
});

function closeInventory() {
    $.post("http://zInventaire/NUIFocusOff", JSON.stringify({}));
}

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
            $(".info-div").hide();
            $("#noSecondInventoryMessage").hide();
            $("#otherInventory").hide();
        } else if (type === "trunk") {
            $("#noSecondInventoryMessage").hide();
            $(".inventory").show();
            if (isShowingContainer) {
                $("#otherInventory").show();
                $(".info-div").show();
            } else {
                $("#otherInventory").hide();
                $(".info-div").hide();
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

                if (itemInventory == "second") {
                    $("#drop").addClass("disabled");
                    $("#give").addClass("disabled");
                }

                if (itemInventory == "second" || !itemData.usable) {
                    $("#use").addClass("disabled");
                }
            },
            stop: function() {
                itemData = $(this).data("item");

                if (itemData !== undefined && itemData.name !== undefined) {
                    $(this).css('background-image', 'url(\'img/items/' + itemData.name + '.png\'');
                    $("#drop").removeClass("disabled");
                    $("#use").removeClass("disabled");
                    $("#give").removeClass("disabled");
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
    } else if (event.data.action == "setShopInventoryItems") {
        shopInventorySetup(event.data.itemList)
    } else if (event.data.action == "setInfoText") {
        $(".info-div").html(event.data.text);
    } else if (event.data.action == "nearPlayers") {
        $.post("http://zInventaire/GiveItem", JSON.stringify({
            item: event.data.item,
            number: parseInt($("#count").val())
        }));
    }
});

function closeInventory() {
    $.post("http://zInventaire/NUIFocusOff", JSON.stringify({}));
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
        $("#playerInventoryFastItems").append('<div class="slotFast"><div id="itemFast-' + i + '" class="item" >' + '<div class="keybind">' + i + '</div><div class="item-count"></div> <div class="item-name"></div> </div ><div class="item-name-bg"></div></div>');
    }

    Hotbar = [false, false, false, false, false]

    $.each(fastItems, function(index, item) {
        count = setCount(item);
        Hotbar[index] = true
        $('#itemFast-' + item.slot).css("background-image", 'url(\'img/items/' + item.name + '.png\')');
        $('#itemFast-' + item.slot).html('<div class="keybind">' + item.slot + '</div><div class="item-count">' + count + '</div> <div class="item-name">' + item.label + '</div> <div class="item-name-bg"></div>');
        $('#itemFast-' + item.slot).data('item', item);
        $('#itemFast-' + item.slot).data('inventory', "fast");
    });
    makeDraggables()

}

function makeDraggables() {
    $('#itemFast-1').droppable({
        drop: function(event, ui) {
            itemData = ui.draggable.data("item");
            itemInventory = ui.draggable.data("inventory");

            if (type === "normal") {
                disableInventory(500);
                $.post("http://zInventaire/PutIntoFast", JSON.stringify({
                    item: itemData,
                    slot: 1
                }));
            }
        }
    });
    $('#itemFast-2').droppable({
        drop: function(event, ui) {
            itemData = ui.draggable.data("item");
            itemInventory = ui.draggable.data("inventory");

            if (type === "normal") {
                disableInventory(500);
                $.post("http://zInventaire/PutIntoFast", JSON.stringify({
                    item: itemData,
                    slot: 2
                }));
            }
        }
    });
    $('#itemFast-3').droppable({
        drop: function(event, ui) {
            itemData = ui.draggable.data("item");
            itemInventory = ui.draggable.data("inventory");

            if (type === "normal") {
                disableInventory(500);
                $.post("http://zInventaire/PutIntoFast", JSON.stringify({
                    item: itemData,
                    slot: 3
                }));
            }
        }
    });
    $('#itemFast-4').droppable({
        drop: function(event, ui) {
            itemData = ui.draggable.data("item");
            itemInventory = ui.draggable.data("inventory");

            if (type === "normal") {
                disableInventory(500);
                $.post("http://zInventaire/PutIntoFast", JSON.stringify({
                    item: itemData,
                    slot: 4
                }));
            }
        }
    });
    $('#itemFast-5').droppable({
        drop: function(event, ui) {
            itemData = ui.draggable.data("item");
            itemInventory = ui.draggable.data("inventory");

            if (type === "normal") {
                disableInventory(500);
                $.post("http://zInventaire/PutIntoFast", JSON.stringify({
                    item: itemData,
                    slot: 5
                }));
            }
        }
    });
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

        if (type === "normal" && itemInventory === "main") {
            if (itemData.type === "item_weapon") {
                if (itemInventory === "main" || itemInventory === "fast") {

                    $(event.target).fadeIn(50)
                    setTimeout(function() {
                        for (i = 0; i < 5; i++) {
                            if (Hotbar[i] == false) {
                                $('#itemFast-' + itemData.slot).slideUp("slow", function() {});
                                Hotbar[i] = true
                                $.post("https://zInventaire/PutIntoFast", JSON.stringify({
                                    item: itemData,
                                    slot: i + 1
                                }));
                                break;
                            }
                        }
                    }, 150);
                    $(event.target).fadeOut(50)
                    $(event.target).fadeTo()


                } else {
                    Hotbar[itemData.slot - 1] = false;
                    $.post("https://zInventaire/TakeFromFast", JSON.stringify({
                        item: itemData
                    }));
                }

            } else {
                if (itemData.usable) {
                    /*  $(event.target).effect("slide", "slow"); */
                    $(event.target).fadeIn(50)
                    setTimeout(function() {
                        $.post("https://zInventaire/UseItem", JSON.stringify({
                            item: itemData
                        }));
                    }, 100);
                    $(event.target).fadeOut(50)
                    $(event.target).fadeTo()
                } else {
                    $(event.target).effect("pulsate", "slow");
                }
            }

        } else {
            $(event.target).effect("pulsate", "slow");
        }

    });

    $('#use').droppable({
        hoverClass: 'hoverControl',
        drop: function(event, ui) {
            itemData = ui.draggable.data("item");

            if (itemData == undefined || itemData.usable == undefined) {
                return;
            }

            itemInventory = ui.draggable.data("inventory");

            if (itemData.usable) {
                /* disableInventory(300); */
                $.post("http://zInventaire/UseItem", JSON.stringify({
                    item: itemData
                }));
            }
        }
    });

    $('#give').droppable({
        hoverClass: 'hoverControl',
        drop: function(event, ui) {
            itemData = ui.draggable.data("item");

            if (itemData == undefined) {
                return;
            }

            itemInventory = ui.draggable.data("inventory");


            /*  if (itemData.canRemove) { */
            /* disableInventory(300); */
            $.post("http://zInventaire/GetNearPlayers", JSON.stringify({
                item: itemData
            }));
            /* } */
        }
    });


    $(document).mousedown(function(event) {

        if (event.which != 2) return

        itemData = $(event.target).data("item");

        if (itemData == undefined || itemData.usable == undefined) {
            return;
        }

        itemInventory = $(event.target).data("inventory");

        if (itemInventory == undefined || itemInventory == "second") {
            return;
        }

        if (type === "normal" && itemInventory === "main") {
            /* if (itemData.canRemove) { */
            $.post("http://zInventaire/DropItem", JSON.stringify({
                item: itemData,
                number: parseInt($("#count").val())
            }));
            /* } */

        } else {
            $(event.target).effect("pulsate", "slow");
        }

    });

    $('#drop').droppable({
        hoverClass: 'hoverControl',
        drop: function(event, ui) {
            itemData = ui.draggable.data("item");

            if (itemData == undefined) {
                return;
            }

            itemInventory = ui.draggable.data("inventory");

            if (itemInventory == undefined || itemInventory == "second") {
                return;
            }

            /* if (itemData.canRemove) { */
            /* disableInventory(300); */
            $.post("http://zInventaire/DropItem", JSON.stringify({
                item: itemData,
                number: parseInt($("#count").val())
            }));
            /* } */
        }
    });

    $('#playerInventory').droppable({
        drop: function(event, ui) {
            itemData = ui.draggable.data("item");
            itemInventory = ui.draggable.data("inventory");

            if (type === "trunk" && itemInventory === "second") {
                disableInventory(500);
                $.post("http://zInventaire/TakeFromTrunk", JSON.stringify({
                    item: itemData,
                    number: parseInt($("#count").val())
                }));
            } else if (type === "property" && itemInventory === "second") {
                disableInventory(500);
                $.post("http://zInventaire/TakeFromProperty", JSON.stringify({
                    item: itemData,
                    number: parseInt($("#count").val()),
                    owner: ownerHouse
                }));
            } else if (type === "player" && itemInventory === "second") {
                disableInventory(500);
                $.post("http://zInventaire/TakeFromPlayer", JSON.stringify({
                    item: itemData,
                    number: parseInt($("#count").val())
                }));
            } else if (type === "normal" && itemInventory === "fast") {
                disableInventory(500);
                Hotbar[itemData.slot - 1] = false;
                $.post("http://zInventaire/TakeFromFast", JSON.stringify({
                    item: itemData
                }));
            } else if (type === "glovebox" && itemInventory === "second") {
                disableInventory(500);
                $.post("http://zInventaire/TakeFromGlovebox", JSON.stringify({
                    item: itemData,
                    number: parseInt($("#count").val())
                }));
            } else if (type === "shop" && itemInventory === "second") {
                disableInventory(500);
                $.post("http://zInventaire/TakeFromShop", JSON.stringify({
                    item: itemData,
                    number: parseInt($("#count").val())
                }));
            } else if (type === "disc-property" && itemInventory === "second") {
                disableInventory(500);
                $.post("http://zInventaire/TakeFromDiscProperty", JSON.stringify({
                    item: itemData,
                    number: parseInt($("#count").val())
                }));

            }
        }
    });

    $('#otherInventory').droppable({
        drop: function(event, ui) {
            itemData = ui.draggable.data("item");
            itemInventory = ui.draggable.data("inventory");

            if (type === "trunk" && itemInventory === "main") {
                disableInventory(500);
                $.post("http://zInventaire/PutIntoTrunk", JSON.stringify({
                    item: itemData,
                    number: parseInt($("#count").val())
                }));
            } else if (type === "property" && itemInventory === "main") {
                disableInventory(500);
                $.post("http://zInventaire/PutIntoProperty", JSON.stringify({
                    item: itemData,
                    number: parseInt($("#count").val()),
                    owner: ownerHouse
                }));
            } else if (type === "glovebox" && itemInventory === "main") {
                disableInventory(500);
                $.post("http://zInventaire/PutIntoGlovebox", JSON.stringify({
                    item: itemData,
                    number: parseInt($("#count").val())
                }));
            } else if (type === "disc-property" && itemInventory === "main") {
                disableInventory(500);
                $.post("http://zInventaire/PutIntoDiscProperty", JSON.stringify({
                    item: itemData,
                    number: parseInt($("#count").val())
                }));
            } else if (type === "player" && itemInventory === "main") {
                disableInventory(500);
                $.post("http://zInventaire/PutIntoPlayer", JSON.stringify({
                    item: itemData,
                    number: parseInt($("#count").val())
                }));
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

function makeDraggables() {
    $('#itemFast-1').droppable({
        drop: function(event, ui) {
            itemData = ui.draggable.data("item");
            itemInventory = ui.draggable.data("inventory");

            if (type === "normal" && (itemInventory === "main" || itemInventory === "fast")) {
                disableInventory(500);
                $.post("http://zInventaire/PutIntoFast", JSON.stringify({
                    item: itemData,
                    slot: 1
                }));
            }
        }
    });
    $('#itemFast-2').droppable({
        drop: function(event, ui) {
            itemData = ui.draggable.data("item");
            itemInventory = ui.draggable.data("inventory");

            if (type === "normal" && (itemInventory === "main" || itemInventory === "fast")) {
                disableInventory(500);
                $.post("http://zInventaire/PutIntoFast", JSON.stringify({
                    item: itemData,
                    slot: 2
                }));
            }
        }
    });
    $('#itemFast-3').droppable({
        drop: function(event, ui) {
            itemData = ui.draggable.data("item");
            itemInventory = ui.draggable.data("inventory");

            if (type === "normal" && (itemInventory === "main" || itemInventory === "fast")) {
                disableInventory(500);
                $.post("http://zInventaire/PutIntoFast", JSON.stringify({
                    item: itemData,
                    slot: 3
                }));
            }
        }
    });
    $('#itemFast-4').droppable({
        drop: function(event, ui) {
            itemData = ui.draggable.data("item");
            itemInventory = ui.draggable.data("inventory");

            if (type === "normal" && (itemInventory === "main" || itemInventory === "fast")) {
                disableInventory(500);
                $.post("http://zInventaire/PutIntoFast", JSON.stringify({
                    item: itemData,
                    slot: 4
                }));
            }
        }
    });
    $('#itemFast-5').droppable({
        drop: function(event, ui) {
            itemData = ui.draggable.data("item");
            itemInventory = ui.draggable.data("inventory");

            if (type === "normal" && (itemInventory === "main" || itemInventory === "fast")) {
                disableInventory(500);
                $.post("http://zInventaire/PutIntoFast", JSON.stringify({
                    item: itemData,
                    slot: 5
                }));
            }
        }
    });
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

    return s + (j ? i.substr(0, j) + t : "") + i.substr(j).replace(/(\d{3})(?=\d)/g, "1" + t);
};

function itemDescriptionOn(obj) {
    itemData = $(obj).data("item");
    if (itemData.label !== undefined) {
        var element = $("<div class='item-desc-info'><p><span id='item-name'>" + itemData.label + "</span></p><hr class='item-hr'><p><span id='item-desc'>" + itemData.description + "</span></p><p><span id='item-amount'><span class='strong'>Hoeveelheid</span>: " + itemData.amount + "</span></p><p><span id='item-weight'><span class='strong'>Gewicht p.st.</span>: " + (itemData.weight / 1000).toFixed(2) + " kg</span></p></div>").fadeIn(200);
        $("#item-information").html("");
        $("#item-information").append(element);
        setTimeout(function() {
            $(element).fadeOut(100, function() { $(this).remove(); });
        }, 3500);
    }
}

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

    $('#use').droppable({
        hoverClass: 'hoverControl',
        drop: function(event, ui) {
            itemData = ui.draggable.data("item");

            if (itemData == undefined || itemData.usable == undefined) {
                return;
            }

            itemInventory = ui.draggable.data("inventory");

            if (itemInventory == undefined || itemInventory == "second") {
                return;
            }

            if (itemData.usable) {
                /* disableInventory(300); */
                $.post("http://zInventaire/UseItem", JSON.stringify({
                    item: itemData
                }));
            }
        }
    });

    $('#give').droppable({
        hoverClass: 'hoverControl',
        drop: function(event, ui) {
            itemData = ui.draggable.data("item");

            if (itemData == undefined) {
                return;
            }

            itemInventory = ui.draggable.data("inventory");

            if (itemInventory == undefined || itemInventory == "second") {
                return;
            }


            /* disableInventory(300); */
            $.post("http://zInventaire/GetNearPlayers", JSON.stringify({
                item: itemData
            }));

        }
    });

    $('#drop').droppable({
        hoverClass: 'hoverControl',
        drop: function(event, ui) {
            itemData = ui.draggable.data("item");

            if (itemData == undefined) {
                return;
            }

            itemInventory = ui.draggable.data("inventory");

            if (itemInventory == undefined || itemInventory == "second") {
                return;
            }


            /* disableInventory(300); */
            $.post("http://zInventaire/DropItem", JSON.stringify({
                item: itemData,
                number: parseInt($("#count").val())
            }));

        }
    });

    $('#playerInventory').droppable({
        drop: function(event, ui) {
            itemData = ui.draggable.data("item");
            itemInventory = ui.draggable.data("inventory");

            if (type === "trunk" && itemInventory === "second") {
                disableInventory(500);
                $.post("http://zInventaire/TakeFromTrunk", JSON.stringify({
                    item: itemData,
                    number: parseInt($("#count").val())
                }));
            } else if (type === "property" && itemInventory === "second") {
                disableInventory(500);
                $.post("http://zInventaire/TakeFromProperty", JSON.stringify({
                    item: itemData,
                    number: parseInt($("#count").val()),
                    owner: ownerHouse
                }));
            } else if (type === "player" && itemInventory === "second") {
                disableInventory(500);
                $.post("http://zInventaire/TakeFromPlayer", JSON.stringify({
                    item: itemData,
                    number: parseInt($("#count").val())
                }));
            } else if (type === "normal" && itemInventory === "fast") {
                disableInventory(500);
                $.post("http://zInventaire/TakeFromFast", JSON.stringify({
                    item: itemData
                }));
            } else if (type === "glovebox" && itemInventory === "second") {
                disableInventory(500);
                $.post("http://zInventaire/TakeFromGlovebox", JSON.stringify({
                    item: itemData,
                    number: parseInt($("#count").val())
                }));
            } else if (type === "shop" && itemInventory === "second") {
                disableInventory(500);
                $.post("http://zInventaire/TakeFromShop", JSON.stringify({
                    item: itemData,
                    number: parseInt($("#count").val())
                }));
            } else if (type === "disc-property" && itemInventory === "second") {
                disableInventory(500);
                $.post("http://zInventaire/TakeFromDiscProperty", JSON.stringify({
                    item: itemData,
                    number: parseInt($("#count").val())
                }));

            }
        }
    });

    $('#otherInventory').droppable({
        drop: function(event, ui) {
            itemData = ui.draggable.data("item");
            itemInventory = ui.draggable.data("inventory");

            if (type === "trunk" && itemInventory === "main") {
                disableInventory(500);
                $.post("http://zInventaire/PutIntoTrunk", JSON.stringify({
                    item: itemData,
                    number: parseInt($("#count").val())
                }));
            } else if (type === "property" && itemInventory === "main") {
                disableInventory(500);
                $.post("http://zInventaire/PutIntoProperty", JSON.stringify({
                    item: itemData,
                    number: parseInt($("#count").val()),
                    owner: ownerHouse
                }));
            } else if (type === "glovebox" && itemInventory === "main") {
                disableInventory(500);
                $.post("http://zInventaire/PutIntoGlovebox", JSON.stringify({
                    item: itemData,
                    number: parseInt($("#count").val())
                }));
            } else if (type === "disc-property" && itemInventory === "main") {
                disableInventory(500);
                $.post("http://zInventaire/PutIntoDiscProperty", JSON.stringify({
                    item: itemData,
                    number: parseInt($("#count").val())
                }));
            } else if (type === "player" && itemInventory === "main") {
                disableInventory(500);
                $.post("http://zInventaire/PutIntoPlayer", JSON.stringify({
                    item: itemData,
                    number: parseInt($("#count").val())
                }));
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