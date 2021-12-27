fx_version 'adamant'
games { 'gta5' };


shared_scripts {
	"config/*.lua",
}

client_scripts {
	"RageUI/RMenu.lua",
    "RageUI/menu/RageUI.lua",
    "RageUI/menu/Menu.lua",
    "RageUI/menu/MenuController.lua",

    "RageUI/components/Audio.lua",
    "RageUI/components/Enum.lua",
    "RageUI/components/Keys.lua",
    "RageUI/components/Rectangle.lua",
    "RageUI/components/Sprite.lua",
    "RageUI/components/Text.lua",
    "RageUI/components/Visual.lua",

    "RageUI/menu/elements/ItemsBadge.lua",
    "RageUI/menu/elements/ItemsColour.lua",
    "RageUI/menu/elements/PanelColour.lua",

    "RageUI/menu/items/UIButton.lua",
    "RageUI/menu/items/UICheckBox.lua",
    "RageUI/menu/items/UIList.lua",
    "RageUI/menu/items/UIProgress.lua",
    "RageUI/menu/items/UISeparator.lua",
    "RageUI/menu/items/UISlider.lua",
    "RageUI/menu/items/UISliderHeritage.lua",
    "RageUI/menu/items/UISliderProgress.lua",

    "RageUI/menu/panels/UIButtonPanel.lua",
    "RageUI/menu/panels/UIColourPanel.lua",
    "RageUI/menu/panels/UIGridPanel.lua",
    "RageUI/menu/panels/UIPercentagePanel.lua",
	"RageUI/menu/panels/UIStatisticsPanel.lua",
	
	"RageUI/menu/windows/UIHeritage.lua",
}

server_scripts {
    '@mysql-async/lib/MySQL.lua',
	'@zFramework/locale.lua',
	'locales/fr.lua',
	"config.lua",
	'sv_clippy.lua',
	'sv_anim.lua',
	'sv_gang.lua',
	'sv_interaction.lua',
	'sv_admin.lua',
	'sv_vehiclelock.lua',
	'clotheshop_server.lua',
	'sv_blackjack.lua',
    'sv_barber.lua',
    'sv_shop.lua',
	'sv_tatoo.lua',
	'sv_clothes.lua',
	'sv_society.lua'
}



shared_scripts {
	'shared.lua'
}

client_scripts {
	"garage/*.lua"
}




ui_page "ui/index.html"

files {
	"ui/index.html",
	"ui/assets/clignotant-droite.svg",
	"ui/assets/clignotant-gauche.svg",
	"ui/assets/feu-position.svg",
	"ui/assets/feu-route.svg",
	"ui/assets/fuel.svg",
	"ui/fonts/fonts/Roboto-Bold.ttf",
	"ui/fonts/fonts/Roboto-Regular.ttf",
	"ui/script.js",
	"ui/style.css",
	"ui/debounce.min.js",
	"AllTattoos.json"
}

client_scripts {
	'@zFramework/locale.lua',
	'@zCore/cl_function.lua',
    "pmenu.lua",
    "config.lua",
	'locales/fr.lua',
	'utils/*.lua',
	'utils/*.js',
}

exports {
	'GetFuel',
	'SetFuel'
}
server_scripts {
	"config.lua",
	"server.lua",
	"sv_bill.lua",
	"sv_orga.lua"
}
server_export "IsRolePresent"
server_export "GetRoles"