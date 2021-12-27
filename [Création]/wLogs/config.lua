Config = {}

Config.AllLogs = true											-- Enable/Disable All Logs Channel
Config.postal = true  											-- set to false if you want to disable nerest postal (https://forum.cfx.re/t/release-postal-code-map-minimap-new-improved-v1-2/147458)
Config.username = "ZLife Logs" 							-- Bot Username
Config.avatar = "https://via.placeholder.com/30x30"				-- Bot Avatar
Config.communtiyName = "Logs"					-- Icon top of the embed
Config.communtiyLogo = "https://via.placeholder.com/30x30"		-- Icon top of the embed
Config.FooterText = "ZLife"						-- Footer text for the embed
Config.FooterIcon = "https://via.placeholder.com/30x30"			-- Footer icon for the embed


Config.weaponLog = true  			-- set to false to disable the shooting weapon logs
Config.InlineFields = true			-- set to false if you don't want the player details next to each other

Config.playerID = true				-- set to false to disable Player ID in the logs
Config.steamID = true				-- set to false to disable Steam ID in the logs
Config.steamURL = true				-- set to false to disable Steam URL in the logs
Config.discordID = true				-- set to false to disable Discord ID in the logs
Config.license = true				-- set to false to disable license in the logs
Config.IP = false					-- set to false to disable IP in the logs

-- Change color of the default embeds here
-- It used Decimal or Hex color codes. They will both work.
Config.BaseColors ={		-- For more info have a look at the docs: https://docs.prefech.com
	chat = "#A1A1A1",				-- Chat Message
	joins = "#3AF241",				-- Player Connecting
	leaving = "#F23A3A",			-- Player Disconnected
	deaths = "#000000",				-- Shooting a weapon
	shooting = "#2E66F2",			-- Player Died
	resources = "#EBEE3F",			-- Resource Stopped/Started	
}


Config.webhooks = {		-- For more info have a look at the docs: https://docs.prefech.com
	all = "https://discord.com/api/webhooks/858690041034309672/SvZ07kbkZ59ZKT1lP_K1JdMJNj_vSYV0OfDQoLxdkcuUdi7pxH4Ki5J1U_RL9qN9dTvv",		-- All logs will be send to this channel
	chat = "https://discord.com/api/webhooks/858690153434054656/bphenkrseJzqOYtj_mExTvJG-cMFJSGtH7cA2OayS91GrEF1I9wFhkACiLA4AdxdGdT7",		-- Chat Message
	joins = "https://discord.com/api/webhooks/858690153434054656/bphenkrseJzqOYtj_mExTvJG-cMFJSGtH7cA2OayS91GrEF1I9wFhkACiLA4AdxdGdT7",		-- Player Connecting
	leaving = "https://discord.com/api/webhooks/858690153434054656/bphenkrseJzqOYtj_mExTvJG-cMFJSGtH7cA2OayS91GrEF1I9wFhkACiLA4AdxdGdT7",	-- Player Disconnected
	deaths = "https://discord.com/api/webhooks/858690041034309672/SvZ07kbkZ59ZKT1lP_K1JdMJNj_vSYV0OfDQoLxdkcuUdi7pxH4Ki5J1U_RL9qN9dTvv",		-- Shooting a weapon
	shooting = "https://discord.com/api/webhooks/858690041034309672/SvZ07kbkZ59ZKT1lP_K1JdMJNj_vSYV0OfDQoLxdkcuUdi7pxH4Ki5J1U_RL9qN9dTvv",	-- Player Died
	resources = "https://discord.com/api/webhooks/858690041034309672/SvZ07kbkZ59ZKT1lP_K1JdMJNj_vSYV0OfDQoLxdkcuUdi7pxH4Ki5J1U_RL9qN9dTvv",	-- Resource Stopped/Started	
}

Config.TitleIcon = {		-- For more info have a look at the docs: https://docs.prefech.com
	chat = "💬",				-- Chat Message
	joins = "📥",				-- Player Connecting
	leaving = "📤",			-- Player Disconnected
	deaths = "💀",				-- Shooting a weapon
	shooting = "🔫",			-- Player Died
	resources = "🔧",			-- Resource Stopped/Started	
}

Config.Plugins = {
	--["PluginName"] = {color = "#FFFFFF", icon = "🔗", webhook = "https://discord.com/api/webhooks/852176386071986248/6H8lRn34594sRHghcKAqZwqgUnBzax0G2pF1Wafi16spDYI0yJgnXw6hUbnw8noo1FA6"},
	["NameChange"] = {color = "#03fc98", icon = "🔗", webhook = "https://discord.com/api/webhooks/852176386071986248/6H8lRn34594sRHghcKAqZwqgUnBzax0G2pF1Wafi16spDYI0yJgnXw6hUbnw8noo1FA6"},
}


 --Debug shizzels :D
Config.debug = false
Config.versionCheck = "1.3.0"
