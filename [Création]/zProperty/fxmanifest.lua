fx_version 'adamant'
games { 'gta5' }

ui_page "html/ui.html"

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

client_scripts {
  "menu.lua",
  'config.lua',
  "@zFramework/locale.lua",
  "locales/en.lua",
  "locales/fr.lua",
  "client/*.lua",
}

server_scripts {
  "@mysql-async/lib/MySQL.lua",
  "@zFramework/locale.lua",
  "locales/en.lua",
  "locales/fr.lua",
  'config.lua',
  "server/*.lua",
}