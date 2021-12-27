Config = {}
Config.DrawDistance = 15.0
Config.MarkerColor = {r = 102, g = 204, b = 102}
Config.EnablePlayerManagement = true -- enables the actual car dealer job. You'll need esx_addonaccount, esx_billing and esx_society
Config.EnableOwnedVehicles = true
Config.EnableSocietyOwnedVehicles = false -- use with EnablePlayerManagement disabled, or else it wont have any effects
Config.ResellPercentage = 50
Config.Locale = 'fr'
Config.LicenseEnable = false -- require people to own drivers license when buying vehicles? Only applies if EnablePlayerManagement is disabled. Requires esx_license

-- looks like this: 'LLL NNN'
-- The maximum plate length is 8 chars (including spaces & symbols), don't go past it!
Config.PlateLetters = 3
Config.PlateNumbers = 3
Config.PlateUseSpace = true

Config.Zones = {
	ShopEntering = {
		Pos = {x = -54.0,  y = 68.08,  z = 171.96},
		Size = { x = 1.2, y = 1.2, z = 0.6 },
		Type = 0
	},
	ShopInside = {
		Pos =  {x = -76.24,  y = 75.08,  z = 171.92-0.95},
		Size = { x = 1.5, y = 1.5, z = 1.0 },
		Heading = 241.78137207031,
		Type = -1
	},
	ShopOutside = {
		Pos = {x = -65.68,  y = 81.48,  z = 171.56-0.95},
		Size = { x = 1.5, y = 1.5, z = 1.0 },
		Heading = 63.883480072021,
		Type = -1
	},
	BossActions = {
		Pos = { x = -53.2,  y = 73.68,  z = 71.92-0.98},
		Size = { x = 1.0, y = 1.0, z = 0.5 },
		Type = 0
	},
--[[ 	GiveBackVehicle = {
		Pos = { x = -971.11, y = -2107.30, z = 8.35 },
		Size = { x = 3.0, y = 3.0, z = 1.0 },
		Type = (Config.EnablePlayerManagement and 1 or -1)
	},
	ResellVehicle = {
		Pos = { x = -986.60, y = -2053.61, z = 8.40 },
		Size = { x = 3.0, y = 3.0, z = 1.0 },
		Type = 1
	} ]]
}