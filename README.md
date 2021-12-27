set es_enableCustomData 1 
set mysql_connection_string "user=root;database=offline"
endpoint_add_tcp "0.0.0.0:30120"
endpoint_add_udp "0.0.0.0:30120"
sv_maxclients 48
sets Développeur "DEV"

sv_scriptHookAllowed 0

add_ace resource.essentialmode command.sets allow
add_ace resource.essentialmode command.add_ace allow
add_ace resource.essentialmode command.add_principal allow

ensure mapmanager
ensure spawnmanager
ensure sessionmanager
ensure fivem
ensure hardcap
ensure yarn
ensure webpack
ensure chat
ensure mysql-async
ensure esplugin_mysql
ensure essentialmode
ensure zFramework
ensure async
ensure zAdmin
ensure hayesauto
ensure zProperty
ensure zHayes

ensure esx_menu_default
ensure zCore
ensure chat
ensure gcphone

ensure zStream
ensure zClothes
ensure zDivers
ensure zEsx
ensure zIllegal
ensure zJobs
ensure zMenu
ensure zPmenu
ensure cardealer

ensure zInventaire
ensure zCarinventory

ensure hospitalmap
ensure luxuryautoshop
ensure vespucci

ensure mumble-voip
ensure 48radio


# Set your server's hostname
set temp_convar "hey world!"


# Add system admins

add_ace group.admin command allow # allow all commands
add_ace group.admin command.quit deny # but don't allow quit
add_principal identifier.fivem:1 group.admin # add the admin to the group


onesync_enabled true
sv_endpointprivacy true
sv_hostname "Dev"
set steam_webApiKey 
sv_licenseKey 
sets locale "fr-FR"
