fx_version 'cerulean'
games { 'gta5' };

name 'RageUI';
description 'RageUI, and a project specially created to replace the NativeUILua-Reloaded library. This library allows to create menus similar to the one of Grand Theft Auto online.'

-- client_scripts {
-- 	"src/RageUI.lua",
-- 	"src/Menu.lua",
-- 	"src/MenuController.lua",
-- 	"src/components/*.lua",
-- 	"src/elements/*.lua",
-- 	"src/items/*.lua",
-- 	"src/panels/*.lua",
-- 	"src/windows/*.lua",
-- 	"Addons/job/police/client/**.lua"
-- }


shared_scripts {
    "Garage/shared/**.lua"
}

client_scripts {
    "RageUI/RMenu.lua",
    "RageUI/menu/RageUI.lua",
    "RageUI/menu/Menu.lua",
    "RageUI/menu/MenuController.lua",

    "RageUI/components/*.lua",

    "RageUI/menu/elements/*.lua",

    "RageUI/menu/items/*.lua",

    "RageUI/menu/panels/*.lua",

    "RageUI/menu/windows/*.lua",
    "Garage/client/**.lua",

}


server_scripts {
    "@mysql-async/lib/MySQL.lua",
    "Garage/server/**.lua"
}
