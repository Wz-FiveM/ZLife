fx_version 'adamant'
games { 'gta5' };

ui_page {
	'html/ui.html'
}

files {
	'html/ui.html',
	'html/app.js',
	'html/style.css',
	'img/*.png'
}

server_scripts {
    '@mysql-async/lib/MySQL.lua',
	'@zFramework/locale.lua',
	'@async/async.lua',
	'locales/fr.lua',
    "config.lua",
    "server/*.lua",
}

client_scripts {
	'@zFramework/locale.lua',
	'@zCore/cl_function.lua',
	'locales/fr.lua',
    "config.lua",
    "client/*.lua",
}


client_scripts {
	'client/lib/classes/String.lua',
	'client/lib/classes/Blip.lua',
	'client/lib/classes/Marker.lua',
	'client/lib/classes/Scenes.lua',
	'client/lib/classes/Vector.lua',
	'client/lib/classes/Vehicle.lua',
  
	'client/lib/scripts/BlipHandler.lua',
	'client/lib/scripts/MarkerHandler.lua',
	'client/lib/scripts/Networking.lua',
	'client/lib/scripts/Streaming.lua',
	'client/lib/scripts/Teleporter.lua',
	'client/lib/scripts/Notifications.lua',
	'client/lib/scripts/Controls.lua',
	'client/lib/scripts/VehicleProperties.lua',
  }
  
  server_scripts {
	'server/lib/classes/String.lua',  
	'server/lib/classes/Table.lua',  
	'server/lib/classes/Json.lua',  
  
	'server/lib/scripts/Utilities.lua',
	'server/lib/scripts/_.lua',
  }