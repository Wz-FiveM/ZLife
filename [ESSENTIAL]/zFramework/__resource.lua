resource_manifest_version '44febabe-d386-4d18-afbe-5e627f4af937'

description 'ES Extended'

version '1.1.2'

server_scripts {
	'@async/async.lua',
	'@mysql-async/lib/MySQL.lua',
	'locale.lua',
	'locales/fr.lua',

	'config.lua',
	'config.weapons.lua',

	'server/common.lua',
	'server/classes/player.lua',
	'server/functions.lua',
	'server/paycheck.lua',
	'server/main.lua',
	'server/commands.lua',

	'common/modules/math.lua',
	'common/modules/table.lua',
	'common/functions.lua'
}

client_scripts {
	'locale.lua',

	'locales/fr.lua',

	'config.lua',
	'config.weapons.lua',

	'client/common.lua',
	'client/entityiter.lua',
	'client/functions.lua',
	'client/wrapper.lua',
	'client/main.lua',

	'client/modules/scaleform.lua',
	'client/modules/streaming.lua',

	'common/modules/math.lua',
	'common/modules/table.lua',
	'common/functions.lua'
}

exports {
	'getSharedObject'
}

server_exports {
	'getSharedObject'
}
