fx_version 'adamant'
games { 'gta5' }

server_scripts {
  "@mysql-async/lib/MySQL.lua",
  "@zFramework/locale.lua",
  "locales/en.lua",
  "locales/cs.lua",
  "locales/fr.lua",
  "config.lua",
  "server/classes/c_trunk.lua",
  "server/trunk.lua",
  "server/esx_trunk-sv.lua"
}

client_scripts {
  "@zFramework/locale.lua",
  "locales/fr.lua",
  "config.lua",
  "client/*.lua"
}
