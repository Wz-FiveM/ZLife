$(document).ready(function() {
    var metaMenu;
    var lastMenu;
    window.addEventListener('message', function(event) {
        const item = event.data;
        if (item.menu) {
            CreateMenu(item.menu, item.params);
            $("#app").css("display", "block");
            $("#app").fadeIn(400);
        }
    });

    function onSelected(data, forceClose) {
        $.post('http://zIllegal/menuOnSelected', JSON.stringify([data, forceClose]));
    }

    function CreateMenu(menuData, menuParams) {
        if (metaMenu) metaMenu = null;

        metaMenu = new Menu();
        var menus = [];
        lastMenu = 0;

        for (let i = menuData.length - 1; i >= 0; i--) {
            const menu = menuData[i];
            menus[i] = [{
                name: 'Fermer',
                icon: 'fas fa-sign-out-alt',
                cb: function() {
                    metaMenu.hideMenu();
                    if (i == 0) {
                        onSelected();
                        $("#app").css("display", "none");
                    } else
                        metaMenu.showMenu(menus[lastMenu]);
                }
            }];

            for (let k = menu.length - 1; k >= 0; k--) {
                let varMenu = menu[k];
                const buttonMenu = {
                    name: varMenu.name || "Aucun",
                    icon: varMenu.icon ? varMenu.icon : (menuParams.icons && menuParams.icons[i]),
                    cb: function() {
                        if (typeof varMenu.cb === "number" && menus[varMenu.cb]) {
                            metaMenu.hideMenu();
                            metaMenu.showMenu(menus[varMenu.cb]);
                            lastMenu = i;
                        } else if (varMenu.cb == "close" || (menuParams && menuParams.close)) {
                            onSelected([i + 1, k + 1], true);
                            metaMenu.hideMenu();
                            $("#app").css("display", "none");
                            return;
                        }
                        onSelected([i + 1, k + 1]);
                    }
                };

                if (varMenu.key) {
                    buttonMenu["keyup"] = function(current, key) {
                        alert('test');
                    }
                }
                menus[i].push(buttonMenu);
            }
        }

        metaMenu.showMenu(menus[0]);
    }

    const allowedKeys = [90, 83, 81, 68, 65, 32, 16];
    document.onkeydown = function(data) {
        if (data.which && allowedKeys.includes(data.which)) {
            $.post('http://zIllegal/menuKeyPress', JSON.stringify({ id: 1, key: data.which }));
        }
    };

    document.onkeyup = function(data) {
        if (data.which && allowedKeys.includes(data.which)) {
            $.post('http://zIllegal/menuKeyPress', JSON.stringify({ id: 2, key: data.which }));
        }
    };
});