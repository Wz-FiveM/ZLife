-- Resources:
-- **********
-- IPL list:			https://wiki.gt-mp.net/index.php/Online_Interiors_and_locations
-- Props list:			https://wiki.gt-mp.net/index.php/InteriorPropList
-- Interior ID list : 	https://wiki.gt-mp.net/index.php/InteriorIDList

fx_version 'bodacious'
game 'gta5'

author 'Bob_74'
description 'Load and customize your map'
version '2.0.9a'

client_scripts {
	"lib/common.lua"
	, "lib/observers/*.lua"
	, "client.lua"

	-- GTA V
	, "gtav/*.lua"

	-- GTA Online
	, "gta_online/*.lua"

	-- DLC High Life
	, "dlc_high_life/*.lua"

	-- DLC Heists
	, "dlc_heists/*.lua"

	-- DLC Executives & Other Criminals
	, "dlc_executive/*.lua"

	-- DLC Finance & Felony
	, "dlc_finance/*.lua"

	-- DLC Bikers
	, "dlc_bikers/*.lua"

	-- DLC Import/Export
	, "dlc_import/*.lua"

	-- DLC Gunrunning
	, "dlc_gunrunning/*.lua"

	-- DLC Smuggler's Run
	, "dlc_smuggler/*.lua"

	-- DLC Doomsday Heist
	, "dlc_doomsday/*.lua"

	-- DLC After Hours
	, "dlc_afterhours/*.lua"
}
