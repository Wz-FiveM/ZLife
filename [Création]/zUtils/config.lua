Config					= {}
config					= {}
Cfg = {}

Cfg.radius = 5.0


Config.Percentage		= 100
Config.MarkerSizeBlan   = {x = 3.0, y = 3.0, z = 3.0}
Config.Menu				= true
Config.Bonus			= {min = 0, max = 0}

Config.ZonesBlan = {
	{x = 2811.04,  y = 5983.2,  z = 350.92, percent = 60}
}

Config.Timer = 1

-- Set if show alert when player use gun

-- Set if show when player do carjacking
Config.CarJackingAlert = true

-- In seconds
Config.BlipJackingTime = 20

-- Blip radius, in float value!
Config.BlipJackingRadius = 50.0

-- Show notification when cops steal too?
Config.ShowCopsMisbehave = true

-- Jobs in this table are considered as cops
Config.WhitelistedCops = {
	'police',
	'sheriff'
}

config.chance = 0 -- chance de ser desbloqueado em porcentagem

config.blacklist = { -- veículos que sempre serão bloqueados quando gerados naturalmente
  "T20",
  "police",
  "police2",
  "police3",
  "sheriff",
  "sheriff3",
  "sheriff2",
  "riot",
  "fbi",
  "hwaycar2",
  "hwaycar3",
  "hwaycar10",
  "hwaycar",
  "polf430",
  "policeb",
  "police7",
  "RHINO"
}

Config.SpeedCamRange = 17
Config.KmhFine = 10

Config.DrawDistance = 30.0
Config.MaxErrors = 5
Config.SpeedMultiplier = 3.6
Config.Locale = 'fr'

Config.Prices = {
	dmv = 100,
	drive = 425,
	drive_bike = 245,
	drive_truck = 560
}

Config.VehicleModels = {
	drive = 'warrener',
	drive_bike = 'double',
	drive_truck = 'mule3'
}

Config.SpeedLimits = {
	residence = 80,
	town = 80,
	freeway = 80
}

Config.Zones = {

	DMVSchool = {
		Pos = {x = -776.88,  y = -244.44,  z = 37.12},
		Size = {x = 1.5, y = 1.5, z = 1.0},
		Color = {r = 204, g = 204, b = 0},
		Type = -1
	},

	VehicleSpawnPoint = {
		Pos = {x = -768.2,  y = -245.52,  z = 37.24-0.95, h = 202.30087280273},
		Size = {x = 1.5, y = 1.5, z = 1.0},
		Color = {r = 204, g = 204, b = 0},
		Type = -1
	}

}

Config.CheckPoints = {

	{
		Pos = {x = -719.72,  y = -238.4,  z = 36.96-0.98},
		Action = function(playerPed, vehicle, setCurrentZoneType)
			ESX.DrawMissionText(_U('go_next_point'), 5000)
			PlaySoundFrontend(-1, "Object_Dropped_Remote", "GTAO_FM_Events_Soundset", 0)
		end
	},

	{
		Pos = {x = -643.36,  y = -326.44,  z = 34.8-0.98},
		Action = function(playerPed, vehicle, setCurrentZoneType)
			ESX.DrawMissionText(_U('go_next_point'), 5000)
			PlaySoundFrontend(-1, "Object_Dropped_Remote", "GTAO_FM_Events_Soundset", 0)
		end
	},

	{
		Pos = {x = -564.6,  y = -303.72,  z = 35.2-0.98},
		Action = function(playerPed, vehicle, setCurrentZoneType)
			ESX.DrawMissionText(_U('go_next_point'), 5000)
			PlaySoundFrontend(-1, "Object_Dropped_Remote", "GTAO_FM_Events_Soundset", 0)
		end
	},

	{
		Pos = {x = -615.68,  y = -193.48,  z = 37.68-0.98},
		Action = function(playerPed, vehicle, setCurrentZoneType)
			ESX.DrawMissionText(_U('go_next_point'), 5000)
			PlaySoundFrontend(-1, "Object_Dropped_Remote", "GTAO_FM_Events_Soundset", 0)
		end
	},

	{
		Pos = {x = -525.76,  y = -143.4,  z = 38.56-0.98},
		Action = function(playerPed, vehicle, setCurrentZoneType)
			ESX.DrawMissionText(_U('go_next_point'), 5000)
			PlaySoundFrontend(-1, "Object_Dropped_Remote", "GTAO_FM_Events_Soundset", 0)
		end
	},

	{
		Pos = {x = -545.88,  y = -61.72,  z = 41.76-0.98},
		Action = function(playerPed, vehicle, setCurrentZoneType)
			ESX.DrawMissionText(_U('go_next_point'), 5000)
			PlaySoundFrontend(-1, "Object_Dropped_Remote", "GTAO_FM_Events_Soundset", 0)
		end
	},

	{
		Pos = {x = -702.44,  y = -18.12,  z = 37.92-0.98},
		Action = function(playerPed, vehicle, setCurrentZoneType)
			ESX.DrawMissionText(_U('go_next_point'), 5000)
			PlaySoundFrontend(-1, "Object_Dropped_Remote", "GTAO_FM_Events_Soundset", 0)
		end
	},

	{
		Pos = {x = -636.96,  y = -168.92,  z = 37.68-0.98},
		Action = function(playerPed, vehicle, setCurrentZoneType)
			ESX.DrawMissionText(_U('go_next_point'), 5000)
			PlaySoundFrontend(-1, "Object_Dropped_Remote", "GTAO_FM_Events_Soundset", 0)
		end
	},

	{
		Pos = {x = -684.96,  y = -211.76,  z = 37.16-0.98},
		Action = function(playerPed, vehicle, setCurrentZoneType)
			ESX.DrawMissionText(_U('go_next_point'), 5000)
			PlaySoundFrontend(-1, "Object_Dropped_Remote", "GTAO_FM_Events_Soundset", 0)
		end
	},

	{
		Pos = {x = -763.76,  y = -241.92,  z = 37.24-0.98},
		Action = function(playerPed, vehicle, setCurrentZoneType)
			ESX.Game.DeleteVehicle(vehicle)
			PlaySoundFrontend(-1, "BASE_JUMP_PASSED", "HUD_AWARDS", 0)
		end
	}

}