fx_version 'adamant'
games { 'gta5' }

version "1.0"

ui_page "html/ui.html"


shared_scripts {
  "configarme.lua"
}

client_scripts {
  "@zFramework/locale.lua",
  "client/*.lua",
  "locales/en.lua",
  "locales/fr.lua",
  "config.lua",
  --"shopsmanagers/cl_shopmanagers.lua",
  "pmenu.lua"
}

server_scripts {
  "@mysql-async/lib/MySQL.lua",
  "@zFramework/locale.lua",
  "server/main.lua",
  "locales/en.lua",
  "locales/fr.lua",
  "config.lua",
  --"shopsmanagers/sv_shopmanagers.lua"
}

files {
  "html/ui.html",
  "html/css/ui.css",
  "html/css/jquery-ui.css",
  "html/js/inventory.js",
  "html/js/config.js",
  -- JS LOCALES
  "html/locales/cs.js",
  "html/locales/en.js",
  "html/locales/fr.js",
  -- IMAGES
  "html/img/bullet.png",
  "html/img/logo.png",
  -- ICONS
  'html/img/items/*.png',
  'html/img/*.png'
}
