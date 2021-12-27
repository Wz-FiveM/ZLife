$(function() {
    var radio48 = $('#radio48');
    radio48.hide();

    window.addEventListener('message', function(event) {
        var item = event.data;
        if (item !== undefined) {
            if (item.type === "radionui") {
                if (item.displayRadionui === true) {
                    radio48.show();
                } else {
                    radio48.hide();
                }
            } else if (item.type === "radionuiMsg") {
                if (item.radionuiMsgWho == "F1") {
                    $('#msg-f1').text(item.radionuicontent);
                }
                if (item.radionuiMsgWho == "F2") {
                    $('#msg-f2').text(item.radionuicontent);
                }
                if (item.radionuiMsgWho == "bot") {
                    $('#msg-bot').text(item.radionuicontent);
                }
                if (item.radionuiMsgWho == "freq") {
                    $('#msg-ne').text(item.radionuicontent);
                }
                if (item.radionuiMsgWho == "red") {
                    if (item.radionuicontent == "true")
                        $('#msg-ne').addClass("red");
                    else
                        $('#msg-ne').removeClass("red");
                }
            } else if (item.type === "radiosound") {
                if (item.sound && item.volume) {
                    document.getElementById(item.sound).load();
                    document.getElementById(item.sound).volume = item.volume;
                    document.getElementById(item.sound).play();
                }
            }
        }
    })

    window.oncontextmenu = function() {
        $.post("http://48radio/CloseCursorMode", JSON.stringify({}));
    }

    var touche = ["f1", "f2", "top", "bot", "ok", "set", "1", "2", "3", "4", "5", "6", "7", "8", "9", "0", "b1", "b2"];

    for (var i in touche) {
        document.getElementById('bt-' + touche[i]).onclick = function(e) {
            touchId = this.id;
            $.post("http://48radio/ClickTouchRadio", JSON.stringify({ "touch": touchId.substr(3) }));
        }
    }
})