Jobs = {}

config = {

	-- repopulate the map with vehicles that were lost when the server rebooted
	populateOnReboot = false, 
  
	-- how close a player needs to get to a deleted persistent vehicle before it is respawned
	respawnDistance = 400, -- 300+
  
	-- don't respawn a vehicle if it gets deleted after it is destroyed
	forgetOnDestroyed = true, -- not working due to onesync bug!! 
  
   -- enable debugging to see server console messages; can be toggled with server command: pv-toggle-debugging
	debug = false, 
}
  -- This experimental feature increases the total number of vehicles you can spawn on the map at any one time. 
  -- It works by removing vehicles no one is close to. Persistent vehicles will then respawn when someone is closeby.
  -- this will remove distance, which is an added benefit as it will remove ghost vehicles.
config.entityManagement = false
  
  -- the distance a player needs to be from the config.respawnDistance for a vehicle's entity to be deleted 
local deletionDistance = 100 -- (100-1000)
  
config.entityManagementDistance = config.respawnDistance + deletionDistance -- must be equal more than 350!

Config = {}
Config.DrawDistance = 15.0
Config.MaxInService = -1
Config.EnablePlayerManagement = true
Config.MaxInService = -1
Config.Locale = 'fr'

-- Militaire
Config.MarkerType = 1
Config.MarkerSize = { x = 1.5, y = 1.5, z = 0.5 }
Config.MarkerColor = { r = 50, g = 50, b = 204 }
Config.EnableArmoryManagement = true
Config.EnableESXIdentity = true -- enable if you're using esx_identity
Config.EnableNonFreemodePeds = false -- turn this on if you want custom peds
Config.EnableLicenses = true -- enable if you're using esx_license
Config.EnableHandcuffTimer = false -- enable handcuff timer? will unrestrain player after the time ends
Config.HandcuffTimer = 10 * 60000 -- 10 mins
Config.EnableJobBlip = false -- enable blips for colleagues, requires esx_society

Config.DrawDistance = 100
Config.MarkerSize             = {x = 1.6, y = 1.6, z = 1.0}
Config.MarkerSizeEnter        = {x = 1.0, y = 1.0, z = 0.6}
Config.MarkerColor            = {r = 0, g = 121, b = 255}
Config.MarkerColorExit        = {r = 255, g = 131, b = 0}
Config.RoomMenuMarkerColor    = {r = 102, g = 204, b = 102}
Config.MarkerSizeCofre        = {x = 1.0, y = 1.0, z = 0.6}
Config.MarkerSizeExit         = {x = 1.0, y = 1.0, z = 0.6}
Config.MarkerType = 25

Config.RentModifier = 5 -- rent price: <property price> / <rent modifier> (rounded)
Config.SellModifier = 2   -- sell price: <property price> / <sell modifier> (rounded)

Config.Properties = {}

Config.EnablePlayerManagementP = false -- If set to true you use esx_realestateagentjob
Config.Locale = 'fr'

Config.ShowPoundSpacer2 = false -- If true it shows Spacer 2 in the List | Don't use if spacer3 is set to true.
Config.ShowPoundSpacer3 = false -- If true it shows Spacer 3 in the List | Don't use if Spacer2 is set to true.
Config.UseVehicleNamesLua = false -- Must setup a vehicle_names.lua for Custom Addon Vehicles.

-- Avocat
Config.Zones = {
	AvocatActions = {
		Pos = {x = -1904.84, y = -570.815, z = 18.2},
		Size = {x = 1.0, y = 1.0, z = 1.5},
		Color = {r = 0, g = 0, b = 250},
		Type = 25
	},
	BossActionsAvocat = {
		Pos = {x = -1912.25, y = -570.21, z = 18.2},
		Size = {x = 1.0, y = 1.0, z = 1.5},
		Color = {r = 0, g = 0, b = 250},
		Type = 25
	},
	VehicleSpawnAvocatMenu = {
		Pos = {x = -1905.19, y =  -560.64, z = 11.5},
		Size = {x = 1.0, y = 1.0, z = 1.0},
		Color = {r = 0, g = 0, b = 250},
		Type = 36
	},
	VehicleSpawnPointAvocat = {
		Pos = {x = -1900.479, y = -560.6, z = 11.79},
		Size = {x = 1.5, y = 1.5, z = 1.0},
		Type = -1
	},
	VehicleDeleterAvocat = {
		Pos = {x = -1901.83, y = -562.74, z = 11.5},
		Size = {x = 1.5, y = 1.5, z = 1.5},
		Color = {r = 240, g = 0, b = 0},
		Type = 36
	}
}

-- Journalist
Config.Zones2 = {
	JournalistActions = {
		Pos = {x = -593.98, y = -914.17, z = 28.16-0.98},
		Size = {x = 1.5, y = 1.5, z = 1.5},
		Color = {r = 204, g = 150, b = 0},
		Type = 25
	},
	BossActionsJournalist = {
		Pos = {x = -583.58, y = -928.89, z = 28.16-0.98},
		Size = {x = 1.5, y = 1.5, z = 1.5},
		Color = {r = 0, g = 240, b = 0},
		Type = 25
	},
	VehicleSpawnJournalistMenu = {
		Pos = {x = -537.23, y = -886.54, z = 25.21},
		Size = {x = 1.0, y = 1.0, z = 1.0},
		Color = {r = 0, g = 240, b = 0},
		Type = 36
	},
	VehicleSpawnPointJournalist = {
		Pos = {x = -544.03, y = -892.61, z = 24.66},
		Size = {x = 1.5, y = 1.5, z = 1.0},
		Type = -1
	},
	VehicleDeleterJournalist = {
		Pos = {x = -532.4,  y = -888.76,  z = 24.96},
		Size = {x = 1.5, y = 1.5, z = 1.5},
		Color = {r = 240, g = 0, b = 0},
		Type = 36
	},
	HelicoSpawnJournalistMenu = {
		Pos = {x = -575.23, y = -927.91, z = 500.83},
		Size = {x = 1.0, y = 1.0, z = 1.0},
		Color = {r = 0, g = 240, b = 0},
		Type = -1
	},
	HelicoSpawnPointJournalist = {
		Pos = {x = -583.53, y = -930.75, z = 36.83},
		Size = {x = 1.5, y = 1.5, z = 1.0},
		Type = -1
	},
	HelicoDeleterJournalist = {
		Pos = {x = -583.53, y = -930.75, z = 36.83},
		Size = {x = 10.0, y = 10.0, z = 10.0},
		Color = {r = 240, g = 0, b = 0},
		Type = -1
	}
}

-- Taxi
Config.EnableTaxiSocietyOwnedVehicles = false
Config.NPCTaxiJobEarnings = {min = 50, max = 150}
Config.MinimumTaxiDistance = 1000 -- Minimum NPC job destination distance from the pickup in GTA units, a higher number prevents nearby destinations.

Config.AuthorizedTaxiVehicles = {
	{	model = 'taxi',
		label = 'Taxi'
	}
}

Config.Zones3 = {
	VehicleTaxiSpawner = {
		Pos = {x = 893.24, y = -146.51, z = 76.9},
		Size = {x = 1.0, y = 1.0, z = 1.0},
		Color = {r = 0, g = 255, b = 0},
		Type = 36, Rotate = true
	},
	VehicleSpawnTaxiPoint = {
		Pos = {x = 897.51, y = -152.4, z = 76.56-0.98},
		Size = {x = 1.5, y = 1.5, z = 1.0},
		Type = -1, Rotate = false,
		Heading = 327.33
	},
	VehicleTaxiDeleter = {
		Pos = {x = 897.51, y = -152.4, z = 76.56},
		Size = {x = 1.5, y = 1.5, z = 1.0},
		Color = {r = 255, g = 0, b = 0},
		Type = 36, Rotate = true
	},
	TaxiActions = {
		Pos = {x = 909.6,  y = -152.64,  z = 74.16-0.98},
		Size = {x = 1.5, y = 1.5, z = 1.0},
		Color = {r = 204, g = 204, b = 0},
		Type = 25, Rotate = true
	},
	CloakroomTaxi = {
		Pos = {x = 905.05, y = -149.54, z = 74.17-0.98},
		Size = {x = 1.5, y = 1.5, z = 1.0},
		Color = {r = 204, g = 204, b = 0},
		Type = 25, Rotate = true
	}
}


Config.Zones99 = {

	LtdActions = {
		Pos = {x = -510.72,  y = -1001.72,  z = 23.56-0.98},
		Size = {x = 1.0, y = 1.0, z = 1.5},
		Color = {r = 0, g = 255, b = 255},
		Type = 25
	},

	HarvestLtd = {
		Pos = {x = 669.732, y = -2672.826, z = 6.108},
		Size = {x = 1.0, y = 1.0, z = 2.5},
		Color = {r = 230, g = 20, b = 255},
		Type = -1
	},

	LtdCraft2 = {
		Pos = {x = 502.1887, y = -609.6935, z = 24.7511},
		Size = {x = 1.0, y = 1.0, z = 2.5},
		Color = {r = 230, g = 20, b = 255},
		Type = -1
	},

	LtdSellFarm = {
		Pos = {x = 2680.9055, y = 3508.19702, z = 53.3034},
		Size = {x = 1.0, y = 1.0, z = 1.0},
		Color = {r = 240, g = 0, b = 0},
		Type = -1
	},

	VehicleSpawnLtdPoint = {
		Pos = {x = -502.16,  y = -991.92,  z = 23.56-0.95},
		Size = {x = 1.5, y = 1.5, z = 1.0},
		Type = -1
	},

	VehicleLtdDeleter = {
		Pos = {x = -502.12,  y = -995.32,  z = 23.56},
		Size = {x = 1.5, y = 1.5, z = 1.5},
		Color = {r = 240, g = 0, b = 0},
		Type = 36
	}
}

Config.JobTaxiLocations = {
	vector3(293.5, -590.2, 42.7),
	vector3(253.4, -375.9, 44.1),
	vector3(120.8, -300.4, 45.1),
	vector3(-38.4, -381.6, 38.3),
	vector3(-107.4, -614.4, 35.7),
	vector3(-252.3, -856.5, 30.6),
	vector3(-236.1, -988.4, 28.8),
	vector3(-277.0, -1061.2, 25.7),
	vector3(-576.5, -999.0, 21.8),
	vector3(-602.8, -952.6, 21.6),
	vector3(-790.7, -961.9, 14.9),
	vector3(-912.6, -864.8, 15.0),
	vector3(-1069.8, -792.5, 18.8),
	vector3(-1306.9, -854.1, 15.1),
	vector3(-1468.5, -681.4, 26.2),
	vector3(-1380.9, -452.7, 34.1),
	vector3(-1326.3, -394.8, 36.1),
	vector3(-1383.7, -270.0, 42.5),
	vector3(-1679.6, -457.3, 39.4),
	vector3(-1812.5, -416.9, 43.7),
	vector3(-2043.6, -268.3, 23.0),
	vector3(-2186.4, -421.6, 12.7),
	vector3(-1862.1, -586.5, 11.2),
	vector3(-1859.5, -617.6, 10.9),
	vector3(-1635.0, -988.3, 12.6),
	vector3(-1284.0, -1154.2, 5.3),
	vector3(-1126.5, -1338.1, 4.6),
	vector3(-867.9, -1159.7, 5.0),
	vector3(-847.5, -1141.4, 6.3),
	vector3(-722.6, -1144.6, 10.2),
	vector3(-575.5, -318.4, 34.5),
	vector3(-592.3, -224.9, 36.1),
	vector3(-559.6, -162.9, 37.8),
	vector3(-535.0, -65.7, 40.6),
	vector3(-758.2, -36.7, 37.3),
	vector3(-1375.9, 21.0, 53.2),
	vector3(-1320.3, -128.0, 48.1),
	vector3(-1285.7, 294.3, 64.5),
	vector3(-1245.7, 386.5, 75.1),
	vector3(-760.4, 285.0, 85.1),
	vector3(-626.8, 254.1, 81.1),
	vector3(-563.6, 268.0, 82.5),
	vector3(-486.8, 272.0, 82.8),
	vector3(88.3, 250.9, 108.2),
	vector3(234.1, 344.7, 105.0),
	vector3(435.0, 96.7, 99.2),
	vector3(482.6, -142.5, 58.2),
	vector3(762.7, -786.5, 25.9),
	vector3(809.1, -1290.8, 25.8),
	vector3(490.8, -1751.4, 28.1),
	vector3(432.4, -1856.1, 27.0),
	vector3(164.3, -1734.5, 28.9),
	vector3(-57.7, -1501.4, 31.1),
	vector3(52.2, -1566.7, 29.0),
	vector3(310.2, -1376.8, 31.4),
	vector3(182.0, -1332.8, 28.9),
	vector3(-74.6, -1100.6, 25.7),
	vector3(-887.0, -2187.5, 8.1),
	vector3(-749.6, -2296.6, 12.5),
	vector3(-1064.8, -2560.7, 19.7),
	vector3(-1033.4, -2730.2, 19.7),
	vector3(-1018.7, -2732.0, 13.3),
	vector3(797.4, -174.4, 72.7),
	vector3(508.2, -117.9, 60.8),
	vector3(159.5, -27.6, 67.4),
	vector3(-36.4, -106.9, 57.0),
	vector3(-355.8, -270.4, 33.0),
	vector3(-831.2, -76.9, 37.3),
	vector3(-1038.7, -214.6, 37.0),
	vector3(1918.4, 3691.4, 32.3),
	vector3(1820.2, 3697.1, 33.5),
	vector3(1619.3, 3827.2, 34.5),
	vector3(1418.6, 3602.2, 34.5),
	vector3(1944.9, 3856.3, 31.7),
	vector3(2285.3, 3839.4, 34.0),
	vector3(2760.9, 3387.8, 55.7),
	vector3(1952.8, 2627.7, 45.4),
	vector3(1051.4, 474.8, 93.7),
	vector3(866.4, 17.6, 78.7),
	vector3(319.0, 167.4, 103.3),
	vector3(88.8, 254.1, 108.2),
	vector3(-44.9, 70.4, 72.4),
	vector3(-115.5, 84.3, 70.8),
	vector3(-384.8, 226.9, 83.5),
	vector3(-578.7, 139.1, 61.3),
	vector3(-651.3, -584.9, 34.1),
	vector3(-571.8, -1195.6, 17.9),
	vector3(-1513.3, -670.0, 28.4),
	vector3(-1297.5, -654.9, 26.1),
	vector3(-1645.5, 144.6, 61.7),
	vector3(-1160.6, 744.4, 154.6),
	vector3(-798.1, 831.7, 204.4)
}

-- Palace
Config.Zones4 = {
	PalaceActions = {
		Pos = {x = -449.14, y = 269.15, z = 83.02-0.98},
		Size = {x = 1.0, y = 1.0, z = 1.5},
		Color = {r = 150, g = 0, b = 150},
		Type = 25
	},

	BossActionsPalace = {
		Pos = {x = -431.81, y = 280.32, z = 83.02-0.98},
		Size = {x = 1.0, y = 1.0, z = 1.5},
		Color = {r = 150, g = 0, b = 150},
		Type = 25
	},
	VehicleSpawnPalaceMenu = {
		Pos = {x = -428.55, y = 294.16, z = 83.23-0.98},
		Size = {x = 1.0, y = 1.0, z = 1.0},
		Color = {r = 150, g = 0, b = 150},
		Type = 25
	},
	VehicleSpawnPointPalace = {
		Pos = {x = -420.94, y = 293.31, z = 83.23-0.98},
		Size = {x = 1.5, y = 1.5, z = 1.0},
		Type = -1
	},
	VehicleDeleterPalace = {
		Pos = {x = -424.0, y = 293.6, z = 83.23-0.98},
		Size = {x = 1.2, y = 1.2, z = 1.2},
		Color = {r = 240, g = 0, b = 0},
		Type = 25
	},
	VehicleDeleterPalace2 = {
		Pos = {x = -433.6, y = 300.53, z = 83.22-0.98},
		Size = {x = 2.0, y = 2.0, z = 2.0},
		Color = {r = 240, g = 0, b = 0},
		Type = 25
	}
}

Config.TeleportZonesPalace = {
	EnterBuilding = {
	    Pos = {x = 0.0, y = 0.0, z = 600.0},
	    Size = {x = 1.0, y = 1.0, z = 1.5},
	    Color = {r = 150, g = 0, b = 150},
	    Marker = 25,
	    Blip = false,
	    Name = "The Palace: Entrée",
	    Type = "teleport",
	    Hint = "Appuyez sur ~INPUT_PICKUP~ pour ~p~entrer dans The Palace.",
	    Teleport = {x = -1569.3714, y = -3017.1933, z = -74.4062},
 	},

  ExitBuilding = {
	    Pos = {x = 0.0, y = 0.0, z = 600.0},
	    Size = {x = 1.0, y = 1.0, z = 1.5},
	    Color = {r = 150, g = 0, b = 150},
	    Marker = 25,
	    Blip = false,
	    Name = "The Palace: Sortie",
	    Type = "teleport",
	    Hint = "Appuyez sur ~INPUT_PICKUP~ pour ~r~sortir du The Palace.",
	    Teleport = {x = -430.1980, y = 261.8168, z = 83.0045},
  	}
}


Config.ZoneLTD = {

	ltdsActions = {
		Pos = {x = -708.04,  y = -903.72,  z = 19.2-0.98},
		Size = {x = 1.3, y = 1.3, z = 1.5},
		Color = {r = 153, g = 0, b = 0},
		Type = 25
	},
	BossActionsltds = {
		Pos = {x = -709.48,  y = -905.08,  z = 19.2-0.98},
		Size = {x = 1.0, y = 1.0, z = 1.5},
		Color = {r = 153, g = 0, b = 0},
		Type = 25
	}
}

-- Daymson
Config.Zones5 = {

	DaymsonActions = {
		Pos = {x = 2473.53, y = 4092.42, z = 38.2-0.98},
		Size = {x = 1.5, y = 1.5, z = 1.5},
		Color = {r = 0, g = 0, b = 250},
		Type = 25
	},

	BossActionsDaymson = {
		Pos = {x = 2468.93, y = 4089.38, z = 37.99-0.98},
		Size = {x = 1.3, y = 1.3, z = 1.5},
		Color = {r = 0, g = 0, b = 250},
		Type = 25
	},

	HarvestDaymson = {
		Pos = {x = 2521.32, y = 4124.4, z = 38.63-0.98},
		Size = {x = 5.0, y = 5.0, z = 2.5},
		Color = {r = 0, g = 240, b = 0},
		Type = -1
	},

	DaymsonCraft = {
		Pos = { x = 1917.69, y = 3742.32, z = 32.58-0.98 },
		Size = {x = 5.0, y = 5.0, z = 2.5},
		Color = {r = 204, g = 204, b = 0},
		Type = -1
	},

	DaymsonSellFarm = {
		Pos = {x = 248.423, y = 156.194, z = 104.176},
		Size = {x = 5.0, y = 5.0, z = 1.0},
		Color = {r = 0, g = 240, b = 0},
		Type = -1
	},

	VehicleSpawnDaymsonMenu = {
		Pos = {x = 2471.77, y =  4110.64, z = 38.06},
		Size = {x = 1.5, y = 1.5, z = 1.0},
		Color = {r = 0, g = 240, b = 0},
		Type = 36
	},

	VehicleSpawnDaymsonPoint = {
		Pos = {x = 2484.04,  y = 4112.56,  z = 38.08-0.98},
		Size = {x = 1.5, y = 1.5, z = 1.0},
		Type = -1
	},

	VehicleDaymsonDeleter = {
		Pos = {x = 2466.17, y = 4101.44, z = 38.06},
		Size = {x = 1.5, y = 1.5, z = 1.0},
		Color = {r = 240, g = 0, b = 0},
		Type = 36
	}
}

-- Tabac
Config.Zones6 = {

	TabacActions = {
		Pos = {x = 2340.8,  y = 3126.48,  z = 48.2-0.98},
		Size = {x = 1.5, y = 1.5, z = 2.0},
		Color = {r = 250, g = 0, b = 0},
		Type = 25
	},

	BossActionsTabac = {
		Pos = {x = 2355.96,  y = 3144.44,  z = 48.2-0.98},
		Size = {x = 1.0, y = 1.0, z = 2.5},
		Color = {r = 230, g = 0, b = 0},
		Type = 25
	},

	HarvestTabac = {
		Pos = {x = 325.04,  y = 6654.64,  z = 28.92},
		Size = {x = 10.0, y = 10.0, z = 2.0},
		Color = {r = 230, g = 20, b = 255},
		Type = -1
	},

	TabacCraft = {
		Pos = {x = 2350.96,  y = 3118.2,  z = 48.2-0.98},
		Size = {x = 1.0, y = 1.0, z = 2.0},
		Color = {r = 230, g = 0, b = 0},
		Type = 25
	},

	TabacCraft2 = {
		Pos = {x = 1702.84,  y = 4917.24,  z = 42.24},
		Size = {x = 1.0, y = 1.0, z = 2.0},
		Color = {r = 230, g = 20, b = 50},
		Type = -1
	},

	TabacSellFarm = {
		Pos = {x = -702.94, y = -917.06, z = 19.21},
		Size = {x = 1.0, y = 1.0, z = 1.0},
		Color = {r = 240, g = 0, b = 0},
		Type = -1
	},

	TabacSellFarm2 = {
		Pos = {x = -1469.64, y = -366.57, z = 40.2},
		Size = {x = 1.0, y = 1.0, z = 1.0},
		Color = {r = 240, g = 0, b = 0},
		Type = -1
	},

	VehicleSpawnTabacMenu = {
		Pos = {x = 2361.96,  y = 3122.64,  z = 48.2},
		Size = {x = 1.5, y = 1.5, z = 1.0},
		Color = {r = 0, g = 255, b = 0},
		Type = 36
	},

	VehicleSpawnTabacPoint = {
		Pos = {x = 2371.88,  y = 3113.56,  z = 48.08},
		Size = {x = 1.5, y = 1.5, z = 1.5},
		Type = -1
	},

	VehicleTabacDeleter = {
		Pos = {x = 2363.32,  y = 3114.0,  z = 48.36},
		Size = {x = 1.5, y = 1.5, z = 1.5},
		Color = {r = 240, g = 0, b = 0},
		Type = 36
	}
}

-- bcfuel
Config.Zones7 = {

	bcfuelActions = {
		Pos = {x = 252.4,  y = 2596.36,  z = 44.88-0.98},
		Size = {x = 1.0, y = 1.0, z = 1.5},
		Color = {r = 113, g = 0, b = 127},
		Type = 25
	},
	BossActionsbcfuel = {
		Pos = {x = 263.0,  y = 2592.4,  z = 44.96-0.98},
		Size = {x = 1.0, y = 1.0, z = 1.5},
		Color = {r = 113, g = 0, b = 127},
		Type = 25
	},
	Harvestbcfuel = {
		Pos = {x = 345.56,  y = 3408.4,  z = 36.64},
		Size = {x = 6.0, y = 6.0, z = 6.5},
		Color = {r = 113, g = 0, b = 127},
		Type = -1
	},
	bcfuelCraft = {
		Pos = {x = 2906.68,  y = 4346.36,  z = 50.28},
		Size = {x = 5.0, y = 5.0, z = 2.5},
		Color = {r = 113, g = 0, b = 127},
		Type = -1
	},
	bcfuelSellFarm2 = {
		Pos = {x = 1719.48,  y = 4758.52,  z = 41.96},
		Size = {x = 3.0, y = 3.0, z = 1.0},
		Color = {r = 240, g = 0, b = 0},
		Type = -1
	},
	VehicleSpawnbcfuelMenu = {
		Pos = {x = 217.52,  y = 2603.52,  z = 45.84},
		Size = {x = 1.0, y = 1.0, z = 1.0},
		Color = {r = 0, g = 250, b = 0},
		Type = 36
	},
	VehicleSpawnbcfuelPoint = {
		Pos = {x = 216.6,  y = 2607.84,  z = 46.28-0.50},
		Size = {x = 1.5, y = 1.5, z = 1.0},
		Type = -1
	},
	VehiclebcfuelDeleter = {
		Pos = {x = 260.8,  y = 2577.84,  z = 45.08-0.98},
		Size = {x = 2.0, y = 2.0, z = 1.5},
		Color = {r = 240, g = 0, b = 0},
		Type = 25
	}
}

-- Unicorn
Config.Zones8 = {

	-- BossActionsUnicorn = {
	-- 	Pos = { x = 97.4517, y = -1303.594, z = 29.255-0.98},
	-- 	Size = {x = 1.0, y = 1.0, z = 1.5},
	-- 	Color = {r = 113, g = 0, b = 127},
	-- 	Type = 25
	-- },
	HarvestUnicorn = {
		Pos = {x = 1835.11, y = 5042.02, z = 57.25},
		Size = {x = 5.0, y = 5.0, z = 2.5},
		Color = {r = 113, g = 0, b = 127},
		Type = -1
	},
	UnicornCraft = {
		Pos = {x = 130.04,  y = -1278.71,  z = 29.2-0.98},
		Size = {x = 1.5, y = 1.5, z = 2.5},
		Color = {r = 113, g = 0, b = 127},
		Type = 25
	}
}

Config.ZonesTaxi = {

	taxiActions = {
		Pos = {x = 895.08,  y = -171.76,  z = 74.68-0.98},
		Size = {x = 1.3, y = 1.3, z = 1.5},
		Color = {r = 242, g = 255, b = 0},
		Type = 25
	},
	BossActionstaxi = {
		Pos = {x = 902.32,  y = -161.8,  z = 78.16-0.98},
		Size = {x = 1.0, y = 1.0, z = 1.5},
		Color = {r = 113, g = 0, b = 127},
		Type = 25
	},
	VehicleSpawntaxiMenu = {
		Pos = {x = 893.0,  y = -156.32,  z = 76.96},
		Size = {x = 1.0, y = 1.0, z = 0.7},
		Color = {r = 0, g = 250, b = 0},
		Type = 36
	},
	VehicleSpawntaxiPoint = {
		Pos = {x = 902.28,  y = -144.04,  z = 76.6-0.50},
		Size = {x = 1.5, y = 1.5, z = 1.5},
		Type = -1
	},
	VehicletaxiDeleter = {
		Pos = {x = 897.32,  y = -152.48,  z = 76.68},
		Size = {x = 1.0, y = 1.0, z = 0.7},
		Color = {r = 240, g = 0, b = 0},
		Type = 36
	}
}

Config.ZonesImmo = {

	ImmoActions = {
		Pos = {x = -197.24,  y = -572.52,  z = 40.48-0.98},
		Size = {x = 1.3, y = 1.3, z = 1.5},
		Color = {r = 125, g = 125, b = 125},
		Type = 25
	},
	BossActionsImmo = {
		Pos = {x = -182.96,  y = -564.48,  z = 40.48-0.98},
		Size = {x = 1.0, y = 1.0, z = 1.5},
		Color = {r = 113, g = 0, b = 127},
		Type = 25
	},
}

Config.TeleportZonesUnicorn = {
	EnterBuilding = {
	    Pos = {x = 132.93, y = -1293.71, z = 28.3},
	    Size = {x = 1.0, y = 1.0, z = 1.5},
	    Color = {r = 150, g = 0, b = 150},
	    Marker = 25,
	    Blip = false,
	    Name = "Bars: Entrée",
	    Type = "teleport",
	    Hint = "Appuyez sur ~INPUT_PICKUP~ pour ~p~entrer dans le bar",
	    Teleport = {x = 132.53, y = -1287.45, z = 28.3},
 	},

  ExitBuilding = {
	    Pos = {x = 132.53, y = -1287.45, z = 28.3},
	    Size = {x = 1.0, y = 1.0, z = 1.5},
	    Color = {r = 150, g = 0, b = 150},
	    Marker = 25,
	    Blip = false,
	    Name = "Bars: Sortie",
	    Type = "teleport",
	    Hint = "Appuyez sur ~INPUT_PICKUP~ pour ~r~sortir du bar",
	    Teleport = {x = 132.93, y = -1293.71, z = 28.3},
  	}
}

-- Carpenter
Config.Zones9 = {

	CarpenterActions = {
		Pos = {x = -510.72,  y = -1001.72,  z = 23.56-0.98},
		Size = {x = 1.0, y = 1.0, z = 1.5},
		Color = {r = 0, g = 255, b = 255},
		Type = 25
	},

	HarvestCarpenter = {
		Pos = {x = -1409.44,  y = -458.36,  z = 34.48},
		Size = {x = 1.0, y = 1.0, z = 2.5},
		Color = {r = 230, g = 20, b = 255},
		Type = -1
	},

	CarpenterCraft2 = {
		Pos = {x = -120.68,  y = -1030.44,  z = 27.32},
		Size = {x = 1.0, y = 1.0, z = 2.5},
		Color = {r = 230, g = 20, b = 255},
		Type = -1
	},

	CarpenterSellFarm = {
		Pos = {x = 138.72,  y = -379.0,  z = 43.24},
		Size = {x = 1.0, y = 1.0, z = 1.0},
		Color = {r = 240, g = 0, b = 0},
		Type = -1
	},

	VehicleSpawnCarpenterPoint = {
		Pos = {x = -502.16,  y = -991.92,  z = 23.56-0.95},
		Size = {x = 1.5, y = 1.5, z = 1.0},
		Type = -1
	},

	VehicleCarpenterDeleter = {
		Pos = {x = -502.12,  y = -995.32,  z = 23.56},
		Size = {x = 1.5, y = 1.5, z = 1.5},
		Color = {r = 240, g = 0, b = 0},
		Type = 36
	}
}

--zone tabac
Config.ZonesTabac = {

	TabacActions = {
		Pos = {x = 795.72,  y = -77.72,  z = 80.59-0.98},
		Size = {x = 1.0, y = 1.0, z = 1.5},
		Color = {r = 0, g = 255, b = 255},
		Type = 25
	},

	HarvestTabac = {
		Pos = {x = -105.3956, y = 1910.014, z = 196.946},
		Size = {x = 1.0, y = 1.0, z = 2.5},
		Color = {r = 230, g = 20, b = 255},
		Type = -1
	},

	TabacCraft2 = {
		Pos = {x = 202.8612, y = 2460.7333, z = 55.706},
		Size = {x = 1.0, y = 1.0, z = 2.5},
		Color = {r = 230, g = 20, b = 255},
		Type = -1
	},

	TabacSellFarm = {
		Pos = {x = -566.436, y = 302.389, z = 83.13495},
		Size = {x = 1.0, y = 1.0, z = 1.0},
		Color = {r = 240, g = 0, b = 0},
		Type = -1
	},

	VehicleSpawnTabacPoint = {
		Pos = {x = -502.16,  y = -991.92,  z = 23.56-0.95},
		Size = {x = 1.5, y = 1.5, z = 1.0},
		Type = -1
	},

	VehicleTabacDeleter = {
		Pos = {x = -502.12,  y = -995.32,  z = 23.56},
		Size = {x = 1.5, y = 1.5, z = 1.5},
		Color = {r = 240, g = 0, b = 0},
		Type = 36
	}
}


Config.Zones0 = {

	DentoActions = {
		Pos = {x = -175.423, y = 295.5282, z = 93.763-0.98},
		Size = {x = 1.0, y = 1.0, z = 1.5},
		Color = {r = 0, g = 255, b = 255},
		Type = 25
	},

	HarvestDento = {
		Pos = {x = 1521.388, y = 3913.2375, z = 31.289},
		Size = {x = 1.0, y = 1.0, z = 2.5},
		Color = {r = 230, g = 20, b = 255},
		Type = -1
	},

	DentoCraft2 = {
		Pos = {x = -175.105, y = 310.2263, z = 97.990},
		Size = {x = 1.0, y = 1.0, z = 2.5},
		Color = {r = 230, g = 20, b = 255},
		Type = -1
	},

	DentoSellFarm = {
		Pos = {x = -3164.260, y = 1113.380, z = 20.7888},
		Size = {x = 1.0, y = 1.0, z = 1.0},
		Color = {r = 240, g = 0, b = 0},
		Type = -1
	},

	VehicleSpawnDentoPoint = {
		Pos = {x = -184.347, y = 287.021, z = 94.6490-0.95, h = 178.0},
		Size = {x = 1.5, y = 1.5, z = 1.0},
		Type = -1
	},

	VehicleDentoDeleter = {
		Pos = {x = -184.347, y = 287.021, z = 94.6490},
		Size = {x = 1.5, y = 1.5, z = 1.5},
		Color = {r = 240, g = 0, b = 0},
		Type = 36
	}
}

-- Skiver
Config.ZonesSkiver = {

	SkiverActions = {
		Pos = {x = 2545.08,  y = 2591.92,  z = 37.96-0.98},
		Size = {x = 1.0, y = 1.0, z = 1.5},
		Color = {r = 230, g = 20, b = 255},
		Type = 25
	},

	HarvestSkiver = {
		Pos = {x = 2677.16, y = 2863.8, z = 36.6},
		Size = {x = 1.0, y = 1.0, z = 2.5},
		Color = {r = 230, g = 20, b = 255},
		Type = -1
	},

	SkiverCraft2 = {
		Pos = {x = 286.68, y = 2843.84, z = 44.72},
		Size = {x = 1.0, y = 1.0, z = 2.5},
		Color = {r = 230, g = 20, b = 255},
		Type = -1
	},

	SkiverSellFarm = {
		Pos = {x = 464.4,  y = 3565.48,  z = 33.24},
		Size = {x = 1.0, y = 1.0, z = 1.0},
		Color = {r = 240, g = 0, b = 0},
		Type = -1
	},

	VehicleSpawnSkiverMenu = {
		Pos = {x = 2547.32,  y = 2580.64,  z = 37.96},
		Size = {x = 1.0, y = 1.0, z = 1.0},
		Color = {r = 230, g = 20, b = 255},
		Type = 36
	},

	VehicleSpawnSkiverPoint = {
		Pos = {x = 2540.68,  y = 2586.28,  z = 37.96},
		Size = {x = 1.5, y = 1.5, z = 1.0},
		Type = -1
	},

	VehicleSkiverDeleter = {
		Pos = {x = 2531.36,  y = 2617.4,  z = 37.96},
		Size = {x = 1.5, y = 1.5, z = 1.5},
		Color = {r = 240, g = 0, b = 0},
		Type = 36
	}
}

-- Bacars
Config.Zones10 = {
	BacarsActions = {
		Pos = {x = -206.56, y = -1341.66, z = 34.89-0.98},
		Size = {x = 1.0, y = 1.0, z = 1.5},
		Color = {r = 0, g = 0, b = 250},
		Type = 25
	},
	BossActionsBacars = {
		Pos = {x = -206.66, y = -1331.5, z = 34.89-0.98},
		Size = {x = 1.0, y = 1.0, z = 1.5},
		Color = {r = 0, g = 0, b = 250},
		Type = 25
	},
	VehicleSpawnBacarsMenu = {
		Pos = {x = -186.83, y =  -1321.57, z = 31.3},
		Size = {x = 1.0, y = 1.0, z = 1.0},
		Color = {r = 0, g = 0, b = 250},
		Type = 36
	},
	VehicleSpawnPointBacars= {
		Pos = {x = -182.93, y = -1320.01, z = 31.29},
		Size = {x = 1.5, y = 1.5, z = 1.0},
		Type = -1
	},
	VehicleDeleterBacars = {
		Pos = {x = -186.0, y = -1318.82, z = 31.29},
		Size = {x = 1.5, y = 1.5, z = 1.5},
		Color = {r = 240, g = 0, b = 0},
		Type = 36
	}
}

Config.TeleportZonesBacars = {
	EnterBuilding = {
	  Pos = {x = -1898.46, y = -572.459, z = 11.25},
	  Size = {x = 1.0, y = 1.0, z = 1.5},
	  Color = {r = 0, g = 0, b = 250},
	  Marker = 23,
	  Blip = false,
	  Name = "Bacars: Entrée",
	  Type = "teleport",
	  Hint = "Appuyez sur ~INPUT_PICKUP~ pour ~b~entrer dans le Towing.",
	  Teleport = {x = -1902.19, y = -572.53, z = 19.09},
	},
	ExitBuilding = {
	  Pos = {x = -1902.19, y = -572.53, z = 18.25},
	  Size = {x = 1.0, y = 1.0, z = 1.5},
	  Color = {r = 0, g = 0, b = 250},
	  Marker = 23,
	  Blip = false,
	  Name = "Bacars: Sortie",
	  Type = "teleport",
	  Hint = "Appuyez sur ~INPUT_PICKUP~ pour ~r~sortir du Towing.",
	  Teleport = {x = -1898.46, y = -572.459, z = 11.84},
	}
 }
 
 --- Militaire
Config.MilitaireStations = {

	MILI = {

		Blip = {
			Coords = vector3(-2358.22, 3249.59, 101.45),
			Sprite = 78,
			Display = 4,
			Scale = 0.7,
			Colour = 16
		},

		Cloakrooms = {
			vector3(-2363.07, 3246.34, 92.9)
		},

		Armories = {
			vector3(-2357.84, 3243.19, 92.9)
		},

		Vehicles = {
			{
				Spawner = vector3(-1835.34, 2953.89, 32.81),
				InsideShop = vector3(-1841.08, 2982.74, 32.81),
				SpawnPoints = {
					{ coords = vector3(-1846.46, 2985.65, 32.81), heading = 90.0, radius = 6.0 },
					{ coords = vector3(-1853.62, 2989.91, 32.81), heading = 90.0, radius = 6.0 },
					{ coords = vector3(-1866.89, 2997.07, 32.81), heading = 90.0, radius = 6.0 },
					{ coords = vector3(-1880.81, 3004.22, 32.81), heading = 90.0, radius = 6.0 }
				}
			},

			{
				Spawner = vector3(-2165.62, 3250.47, 32.81),
				InsideShop = vector3(-2136.86, 3255.89, 32.81),
				SpawnPoints = {
					{ coords = vector3(-2147.53, 3240.45, 32.81), heading = 276.1, radius = 6.0 },
					{ coords = vector3(-2152.14, 3232.2, 32.81), heading = 302.5, radius = 6.0 }
				}
			}
		},

		Helicopters = {
			{
				Spawner = vector3(-1847.65, 2791.62, 32.81),
				InsideShop = vector3(-1859.67, 2795.52, 32.81),
				SpawnPoints = {
					{ coords = vector3(-1877.02, 2805.48, 32.81), heading = 92.6, radius = 10.0 }
				}
			}
		},

	}

}

Config.AuthorizedWeaponsMilitaire = {
	recrue = {
		{ weapon = 'WEAPON_APPISTOL', components = { 0, 0, 100, 400, nil }, price = 1500 },
		{ weapon = 'WEAPON_CARBINERIFLE', components = { 0, 600, 1000, 1400, 1800, nil }, price = 5000 },
		{ weapon = 'WEAPON_NIGHTSTICK', price = 0 },
		{ weapon = 'WEAPON_STUNGUN', price = 500 },
		{ weapon = 'WEAPON_FLASHLIGHT', price = 80 }
	},

	caporal = {
		{ weapon = 'WEAPON_APPISTOL', components = { 0, 0, 100, 400, nil }, price = 1500 },
		{ weapon = 'WEAPON_CARBINERIFLE', components = { 0, 600, 1000, 1400, 1800, nil }, price = 5000 },
		{ weapon = 'WEAPON_NIGHTSTICK', price = 0 },
		{ weapon = 'WEAPON_SNIPERRIFLE', price = 7500 },
		{ weapon = 'WEAPON_STUNGUN', price = 500 },
		{ weapon = 'WEAPON_FLASHLIGHT', price = 0 }
	},

	sergent = {
		{ weapon = 'WEAPON_APPISTOL', components = { 0, 0, 100, 400, nil }, price = 1500 },
		{ weapon = 'WEAPON_CARBINERIFLE', components = { 0, 600, 1000, 1400, 1800, nil }, price = 5000 },
		{ weapon = 'WEAPON_PUMPSHOTGUN', components = { 200, 600, nil }, price = 7000 },
		{ weapon = 'WEAPON_NIGHTSTICK', price = 0 },
		{ weapon = 'WEAPON_MG', price = 10000 },
		{ weapon = 'WEAPON_SNIPERRIFLE', price = 7500 },
		{ weapon = 'WEAPON_STUNGUN', price = 500 },
		{ weapon = 'WEAPON_FLASHLIGHT', price = 0 }
	},

	lieutenant = {
		{ weapon = 'WEAPON_APPISTOL', components = { 0, 0, 100, 400, nil }, price = 1500 },
		{ weapon = 'WEAPON_CARBINERIFLE', components = { 0, 600, 1000, 1400, 1800, nil }, price = 5000 },
		{ weapon = 'WEAPON_PUMPSHOTGUN', components = { 200, 600, nil }, price = 7000 },
		{ weapon = 'WEAPON_NIGHTSTICK', price = 0 },
		{ weapon = 'WEAPON_COMBATMG', price = 15000 },
		{ weapon = 'WEAPON_MG', price = 10000 },
		{ weapon = 'WEAPON_SNIPERRIFLE', price = 7500 },
		{ weapon = 'WEAPON_STUNGUN', price = 500 },
		{ weapon = 'WEAPON_FLASHLIGHT', price = 0 }
	},

	major = {
		{ weapon = 'WEAPON_APPISTOL', components = { 0, 0, 100, 400, nil }, price = 1500 },
		{ weapon = 'WEAPON_CARBINERIFLE', components = { 0, 600, 1000, 1400, 1800, nil }, price = 5000 },
		{ weapon = 'WEAPON_PUMPSHOTGUN', components = { 200, 600, nil }, price = 7000 },
		{ weapon = 'WEAPON_NIGHTSTICK', price = 0 },
		{ weapon = 'WEAPON_COMBATMG', price = 15000 },
		{ weapon = 'WEAPON_MG', price = 10000 },
		{ weapon = 'WEAPON_SNIPERRIFLE', price = 7500 },
		{ weapon = 'WEAPON_STUNGUN', price = 500 },
		{ weapon = 'WEAPON_FLASHLIGHT', price = 0 }
	},

	colonel = {
		{ weapon = 'WEAPON_APPISTOL', components = { 0, 0, 100, 400, nil }, price = 1500 },
		{ weapon = 'WEAPON_CARBINERIFLE', components = { 0, 600, 1000, 1400, 1800, nil }, price = 5000 },
		{ weapon = 'WEAPON_PUMPSHOTGUN', components = { 200, 600, nil }, price = 7000 },
		{ weapon = 'WEAPON_NIGHTSTICK', price = 0 },
		{ weapon = 'WEAPON_MG', price = 10000 },
		{ weapon = 'WEAPON_COMBATMG', price = 15000 },
		{ weapon = 'WEAPON_HEAVYSNIPER', price = 20000 },
		{ weapon = 'WEAPON_STUNGUN', price = 500 },
		{ weapon = 'WEAPON_FLASHLIGHT', price = 0 }
	},

	boss = {
		{ weapon = 'WEAPON_APPISTOL', components = { 0, 0, 100, 400, nil }, price = 1500 },
		{ weapon = 'WEAPON_CARBINERIFLE', components = { 0, 600, 1000, 1400, 1800, nil }, price = 5000 },
		{ weapon = 'WEAPON_PUMPSHOTGUN', components = { 200, 600, nil }, price = 7000 },
		{ weapon = 'WEAPON_NIGHTSTICK', price = 0 },
		{ weapon = 'WEAPON_MG', price = 10000 },
		{ weapon = 'WEAPON_COMBATMG', price = 15000 },
		{ weapon = 'WEAPON_HEAVYSNIPER', price = 20000 },
		{ weapon = 'WEAPON_STUNGUN', price = 500 },
		{ weapon = 'WEAPON_FLASHLIGHT', price = 0 }
	}
}

Config.AuthorizedVehiclesMilitaire = {
	Shared = {
		{ model = 'crusader', label = 'Jeep Militar', price = 5000 },
		{ model = 'barracks', label = 'Camion Barracas', price = 10000 },	
		{ model = 'rhino', label = 'Tank', price = 150000 },
		{ model = 'apc', label = 'Tank APC', price = 100000 },
		{ model = 'kuruma2', label = 'Voiture Blindée', price = 100000 },
	},

	recrue = {

	},

	caporal = {

	},

	sergent = {

	},

	lieutenant = {

	},

	major = {
	},

	colonel = {

	},

	boss = {

	}
}

Config.MarkerEms                     = { type = 25, x = 1.5, y = 1.5, z = 0.5, r = 102, g = 0, b = 102, a = 100, rotate = false }

Config.AuthorizedHelicoptersMilitaire = {
	recrue = {},

	caporal = {
		{ model = 'cargobob', label = 'CargoBob', livery = 0, price = 100000 }
	},

	sergent = {
		{ model = 'cargobob', label = 'CargoBob', livery = 0, price = 100000 }
	},

	lieutenant = {
		{ model = 'cargobob', label = 'CargoBob', livery = 0, price = 100000 }
	},

	major = {
		{ model = 'cargobob', label = 'CargoBob', livery = 0, price = 100000 }
	},

	colonel = {
		{ model = 'cargobob', label = 'CargoBob', livery = 0, price = 100000 }
	},

	boss = {
		{ model = 'valkyrie', label = 'Valkyrie', price = 5000 },
		{ model = 'cargobob', label = 'CargoBob', livery = 0, price = 100000 },
		{ model = 'titan', label = 'Titan', price = 150000 },
		{ model = 'lazer', label = 'Avion Lazer', price = 500000 },
		{ model = 'hydra', label = 'Avion Hydra', price = 500000 },
		{ model = 'buzzard2', label = 'Militaire Buzzard', livery = 0, price = 150000 }
	}
}

-- CHECK SKINCHANGER CLIENT MAIN.LUA for matching elements

Config.UniformsMilitaire = {
	recrue_wear = {
		male = {
			['tshirt_1'] = 15, ['tshirt_2'] = 0,
			['torso_1'] = 220, ['torso_2'] = 5,
			['decals_1'] = 0, ['decals_2'] = 0,
			['arms'] = 11,
			['pants_1'] = 97, ['pants_2'] = 20,
			['shoes_1'] = 35, ['shoes_2'] = 0,
			['helmet_1'] = -1, ['helmet_2'] = 0,
			['chain_1'] = 0, ['chain_2'] = 0
		},
		female = {
			['tshirt_1'] = 161, ['tshirt_2'] = 8,
			['torso_1'] = 230, ['torso_2'] = 5,
			['decals_1'] = 0, ['decals_2'] = 0,
			['arms'] = 31,
			['pants_1'] = 89, ['pants_2'] = 5,
			['shoes_1'] = 36, ['shoes_2'] = 0,
			['helmet_1'] = -1, ['helmet_2'] = 0,
			['chain_1'] = 83, ['chain_2'] = 0
		}
	},
	caporal_wear = {
		male = {
			['tshirt_1'] = 15, ['tshirt_2'] = 0,
			['torso_1'] = 220, ['torso_2'] = 5,
			['decals_1'] = 0, ['decals_2'] = 0,
			['arms'] = 11,
			['pants_1'] = 97, ['pants_2'] = 20,
			['shoes_1'] = 35, ['shoes_2'] = 0,
			['helmet_1'] = -1, ['helmet_2'] = 0,
			['chain_1'] = 0, ['chain_2'] = 0
		},
		female = {
			['tshirt_1'] = 161, ['tshirt_2'] = 8,
			['torso_1'] = 230, ['torso_2'] = 5,
			['decals_1'] = 0, ['decals_2'] = 0,
			['arms'] = 31,
			['pants_1'] = 89, ['pants_2'] = 5,
			['shoes_1'] = 36, ['shoes_2'] = 0,
			['helmet_1'] = -1, ['helmet_2'] = 0,
			['chain_1'] = 83, ['chain_2'] = 0
		}
	},
	sergent_wear = {
		male = {
			['tshirt_1'] = 15, ['tshirt_2'] = 0,
			['torso_1'] = 220, ['torso_2'] = 5,
			['decals_1'] = 0, ['decals_2'] = 0,
			['arms'] = 11,
			['pants_1'] = 97, ['pants_2'] = 20,
			['shoes_1'] = 35, ['shoes_2'] = 0,
			['helmet_1'] = -1, ['helmet_2'] = 0,
			['chain_1'] = 0, ['chain_2'] = 0
		},
		female = {
			['tshirt_1'] = 161, ['tshirt_2'] = 8,
			['torso_1'] = 230, ['torso_2'] = 5,
			['decals_1'] = 0, ['decals_2'] = 0,
			['arms'] = 31,
			['pants_1'] = 89, ['pants_2'] = 5,
			['shoes_1'] = 36, ['shoes_2'] = 0,
			['helmet_1'] = -1, ['helmet_2'] = 0,
			['chain_1'] = 83, ['chain_2'] = 0
		}
	},
	lieutenant_wear = {
		male = {
			['tshirt_1'] = 15, ['tshirt_2'] = 0,
			['torso_1'] = 220, ['torso_2'] = 5,
			['decals_1'] = 0, ['decals_2'] = 0,
			['arms'] = 11,
			['pants_1'] = 97, ['pants_2'] = 20,
			['shoes_1'] = 35, ['shoes_2'] = 0,
			['helmet_1'] = -1, ['helmet_2'] = 0,
			['chain_1'] = 0, ['chain_2'] = 0
		},
		female = {
			['tshirt_1'] = 161, ['tshirt_2'] = 8,
			['torso_1'] = 230, ['torso_2'] = 5,
			['decals_1'] = 0, ['decals_2'] = 0,
			['arms'] = 31,
			['pants_1'] = 89, ['pants_2'] = 5,
			['shoes_1'] = 36, ['shoes_2'] = 0,
			['helmet_1'] = -1, ['helmet_2'] = 0,
			['chain_1'] = 83, ['chain_2'] = 0
		}
	},
	major_wear = { -- currently the same as intendent_wear
		male = {
			['tshirt_1'] = 15, ['tshirt_2'] = 0,
			['torso_1'] = 220, ['torso_2'] = 5,
			['decals_1'] = 0, ['decals_2'] = 0,
			['arms'] = 11,
			['pants_1'] = 97, ['pants_2'] = 20,
			['shoes_1'] = 35, ['shoes_2'] = 0,
			['helmet_1'] = -1, ['helmet_2'] = 0,
			['chain_1'] = 0, ['chain_2'] = 0
		},
		female = {
			['tshirt_1'] = 161, ['tshirt_2'] = 8,
			['torso_1'] = 230, ['torso_2'] = 5,
			['decals_1'] = 0, ['decals_2'] = 0,
			['arms'] = 31,
			['pants_1'] = 89, ['pants_2'] = 5,
			['shoes_1'] = 36, ['shoes_2'] = 0,
			['helmet_1'] = -1, ['helmet_2'] = 0,
			['chain_1'] = 83, ['chain_2'] = 0
		}
	},
	colonel_wear = {
		male = {
			['tshirt_1'] = 15, ['tshirt_2'] = 0,
			['torso_1'] = 220, ['torso_2'] = 5,
			['decals_1'] = 0, ['decals_2'] = 0,
			['arms'] = 11,
			['pants_1'] = 97, ['pants_2'] = 20,
			['shoes_1'] = 35, ['shoes_2'] = 0,
			['helmet_1'] = -1, ['helmet_2'] = 0,
			['chain_1'] = 0, ['chain_2'] = 0
		},
		female = {
			['tshirt_1'] = 161, ['tshirt_2'] = 8,
			['torso_1'] = 230, ['torso_2'] = 5,
			['decals_1'] = 0, ['decals_2'] = 0,
			['arms'] = 31,
			['pants_1'] = 89, ['pants_2'] = 5,
			['shoes_1'] = 36, ['shoes_2'] = 0,
			['helmet_1'] = -1, ['helmet_2'] = 0,
			['chain_1'] = 83, ['chain_2'] = 0
		}
	},
	boss_wear = { -- currently the same as chef_wear
		male = {
			['tshirt_1'] = 15, ['tshirt_2'] = 0,
			['torso_1'] = 220, ['torso_2'] = 5,
			['decals_1'] = 0, ['decals_2'] = 0,
			['arms'] = 11,
			['pants_1'] = 97, ['pants_2'] = 20,
			['shoes_1'] = 35, ['shoes_2'] = 0,
			['helmet_1'] = -1, ['helmet_2'] = 0,
			['chain_1'] = 0, ['chain_2'] = 0
		},
		female = {
			['tshirt_1'] = 161, ['tshirt_2'] = 8,
			['torso_1'] = 230, ['torso_2'] = 5,
			['decals_1'] = 0, ['decals_2'] = 0,
			['arms'] = 31,
			['pants_1'] = 89, ['pants_2'] = 5,
			['shoes_1'] = 36, ['shoes_2'] = 0,
			['helmet_1'] = -1, ['helmet_2'] = 0,
			['chain_1'] = 83, ['chain_2'] = 0
		}
	},
	bullet_wear = {
		male = {
			['bproof_1'] = 0, ['bproof_2'] = 0
		},
		female = {
			['bproof_1'] = 0, ['bproof_2'] = 0
		}
	}
}

Config.NPCSpawnDistance           = 500.0
Config.NPCNextToDistance          = 25.0
Config.NPCJobEarnings             = { min = 250, max = 380 }

Config.Vehicles = {
	'adder',
	'asea',
	'asterope',
	'banshee',
	'buffalo'
}

Config.ZonesLsCus = {

	Garage = {
		Pos   = {x = -1417.108, y = -447.240, z = 35.9096-0.98},
		Size  = {x = 1.5, y = 1.5, z = 1.0},
		Color = {r = 0, g = 0, b = 200},
		Type  = 25
	},

	-- Craft = {
	-- 	Pos   = {x = -227.84,  y = -1327.36,  z = 30.88-0.98},
	-- 	Size  = { x = 1.5, y = 1.5, z = 1.0 },
	-- 	Color = {r = 0, g = 0, b = 200},
	-- 	Type  = 25
	-- },

	VehicleSpawnPoint = {		
		Pos   = {x = -192.9352, y = -1320.6768, z = 30.913+0.98, h = 92.15},
		Size  = {x = 1.5, y = 1.5, z = 1.0},
		Type  = -1
	},

	VehicleDeleter = {
		Pos   = {x = -192.9352, y = -1320.6768, z = 30.913-0.98, h = 283.15},
		Size  = {x = 1.5, y = 1.5, z = 1.1},
		Color = {r = 255, g = 0, b = 0},
		Type  = 36
	},


	VehicleDelivery = {
		Pos   = {x = -182.839080,  y = -1316.861328,  z = 31.295957565},
		Size  = {x = 20.0, y = 20.0, z = 3.0},
		Color = {r = 204, g = 204, b = 0},
		Type  = -1
	}
}

Config.Towables = {
	vector3(-2480.9, -212.0, 17.4),
	vector3(-2723.4, 13.2, 15.1),
	vector3(-3169.6, 976.2, 15.0),
	vector3(-3139.8, 1078.7, 20.2),
	vector3(-1656.9, -246.2, 54.5),
	vector3(-1586.7, -647.6, 29.4),
	vector3(-1036.1, -491.1, 36.2),
	vector3(-1029.2, -475.5, 36.4),
	vector3(75.2, 164.9, 104.7),
	vector3(-534.6, -756.7, 31.6),
	vector3(487.2, -30.8, 88.9),
	vector3(-772.2, -1281.8, 4.6),
	vector3(-663.8, -1207.0, 10.2),
	vector3(719.1, -767.8, 24.9),
	vector3(-971.0, -2410.4, 13.3),
	vector3(-1067.5, -2571.4, 13.2),
	vector3(-619.2, -2207.3, 5.6),
	vector3(1192.1, -1336.9, 35.1),
	vector3(-432.8, -2166.1, 9.9),
	vector3(-451.8, -2269.3, 7.2),
	vector3(939.3, -2197.5, 30.5),
	vector3(-556.1, -1794.7, 22.0),
	vector3(591.7, -2628.2, 5.6),
	vector3(1654.5, -2535.8, 74.5),
	vector3(1642.6, -2413.3, 93.1),
	vector3(1371.3, -2549.5, 47.6),
	vector3(383.8, -1652.9, 37.3),
	vector3(27.2, -1030.9, 29.4),
	vector3(229.3, -365.9, 43.8),
	vector3(-85.8, -51.7, 61.1),
	vector3(-4.6, -670.3, 31.9),
	vector3(-111.9, 92.0, 71.1),
	vector3(-314.3, -698.2, 32.5),
	vector3(-366.9, 115.5, 65.6),
	vector3(-592.1, 138.2, 60.1),
	vector3(-1613.9, 18.8, 61.8),
	vector3(-1709.8, 55.1, 65.7),
	vector3(-521.9, -266.8, 34.9),
	vector3(-451.1, -333.5, 34.0),
	vector3(322.4, -1900.5, 25.8)
}

for k,v in ipairs(Config.Towables) do
	Config.ZonesLsCus['Towable' .. k] = {
		Pos   = v,
		Size  = { x = 1.5, y = 1.5, z = 1.0 },
		Color = { r = 204, g = 204, b = 0 },
		Type  = -1
	}
end

Config.ReviveReward               = 150  -- revive reward, set to 0 if you don't want it enabled
Config.AntiCombatLog              = false -- enable anti-combat logging?
Config.LoadIpl                    = false -- disable if you're using fivem-ipl or other IPL loaders

Config.Locale                     = 'fr'

local second = 1000
local minute = 60 * second

Config.EarlyRespawnTimer          = 8 * minute  -- Time til respawn is available
Config.BleedoutTimer              = 0 * minute -- Time til the player bleeds out

Config.EnablePlayerManagement     = true

Config.RemoveWeaponsAfterRPDeath  = false
Config.RemoveCashAfterRPDeath     = false
Config.RemoveItemsAfterRPDeath    = false

-- Let the player pay for respawning early, only if he can afford it.
Config.EarlyRespawnFine           = true
Config.EarlyRespawnFineAmount     = 500

Config.RespawnPoint = { coords = vector3(315.34, -580.97, 43.58), heading = 154.2287902832 }

Config.Hospitals = {

	CentralLosSantos = {

		Blip = {
			coords = vector3(343.91, -586.01, 28.79-0.98),
			sprite = 61,
			scale  = 0.9,
			color  = 2
		},

		AmbulanceActions = {
			vector3(306.892, -601.8544, 43.284-0.98),
			vector3(1839.36, 3689.2, 34.28-0.98)
		},

		Pharmacies = {
			vector3(306.892, -601.8544, 43.284-0.98),
			vector3(1836.64, 3691.0, 34.28-0.98)
		},

		HospitalInteriorInside1 = {
			Pos	= { x = 364.6, y = -583.0, z = 43.28 },
			Type = -1
		},
	}
}



Config.MarkerSizeLspd                 = { x = 1.0, y = 1.0, z = 0.6 }
Config.MarkerColorlspd                = { r = 0, g = 121, b = 255 }

Config.EnablePlayerManagementLspd     = true
Config.EnableArmoryManagementLspd     = true
Config.EnableESXIdentity          = true -- enable if you're using esx_identity
Config.EnableNonFreemodePeds      = false -- turn this on if you want custom peds
Config.EnableLicenses             = false -- enable if you're using esx_license

Config.EnableHandcuffTimer        = true -- enable handcuff timer? will unrestrain player after the time ends
Config.HandcuffTimer              = 10 * 60000 -- 10 mins

Config.EnableJobBlipLspd              = false -- enable blips for colleagues, requires esx_society

Config.WhitelistedCops = {
	'police'
}

Config.ZonesDuty = {

	PoliceDuty = {
	  Pos   = { x = -1096.88,  y = -829.0,  z = 26.84-0.98 },
	  Size  = { x = 2.5, y = 2.5, z = 1.5 },
	  Color = { r = 0, g = 255, b = 0 },  
	  Type  = 25,
	},
  
	AmbulanceDuty = {
	  Pos = { x = 338.33,  y = -585.96,  z = 28.79-0.98 },
	  Size = { x = 2.5, y = 2.5, z = 1.5 },
	  Color = { r = 0, g = 255, b = 0 },
	  Type = 25,
	},

	SheriffDuty = {
		Pos = { x = 1854.52,  y = 3693.04,  z = 34.2-0.92 },
		Size = { x = 2.5, y = 2.5, z = 1.5 },
		Color = { r = 0, g = 255, b = 0 },
		Type = 25,
	  },
  }
  
  Config.PoliceStations = {

	LSPD = {

		Cloakrooms = {
			vector3(-1098.36889, -831.822, 14.282-0.90)
		},

		Cloakroomsshe = {
			vector3(1858.84, 3695.12, 34.24-0.94)
		},

		Armories = {
			vector3(-1098.796, -826.07060, 14.2829-0.90),
			vector3(471.4, -1005.48, 34.2-0.90),
			vector3(1861.16, 3689.68, 34.24-0.90)
		},

		Vehicles = {
			{
				Spawner = vector3(0, 0, -0000),
				InsideShop = vector3(228.5, -993.5, -99.5),
				SpawnPoints = {
					{ coords = vector3(440.92, -982.28, 25.72), heading = 87.63, radius = 6.0 },
					{ coords = vector3(426.4, -982.08, 25.72), heading = 267.60, radius = 6.0 },
					{ coords = vector3(426.48, -976.4, 25.72), heading = 270.85, radius = 6.0 },
					{ coords = vector3(441.4, -988.0, 25.72), heading = 88.16, radius = 6.0 }
				}
			}
		},

		Helicopters = {
			{
				Spawner = vector3(463.72, -982.52, 43.68),
				InsideShop = vector3(477.0, -1106.4, 43.0),
				SpawnPoints = {
					{ coords = vector3(449.24, -981.36, 43.68), heading = 88.53, radius = 10.0 }
				}
			}
		},

		BossActions = {
			vector3(471.72, -1005.6, 30.68-0.98)
		}

	}

}





Config.Uniforms = {
	manche_longe = {
		male = {
            ['tshirt_1'] = 18,  ['tshirt_2'] = 0,
            ['torso_1'] = 19,  ['torso_2'] = 8,
            ['decals_1'] =0,   ['decals_2'] = 0,
            ['arms'] = 14,       ['arms_2'] = 0,
            ['pants_1'] = 17,   ['pants_2'] = 0,
            ['shoes_1'] = 32,   ['shoes_2'] = 0,
            --['bags_1'] = 10,   ['bags_2'] = 0
		},
		female = {
            ['tshirt_1'] = 34, ['tshirt_2'] = 0,
            ['torso_1'] = 144,['torso_2'] = 9,
            ['decals_1'] = 0,  ['decals_2'] = 0,
            ['mask_1'] = 0, ['mask_2'] = 0,
            ['arms'] = 36,
            ['pants_1'] = 68, ['pants_2'] = 9,
            ['shoes_1'] = 47, ['shoes_2'] = 9,
            ['helmet_1'] = 71, ['helmet_2'] = 3,
            ['bags_1'] = 0, ['bags_2'] = 0,
            ['bproof_1'] = 0, ['bproof_2']  = 0
		}
	},
	
	bullet_wear = {
		male = {
			['bproof_1'] = 53,  ['bproof_2'] = 3
		},
		female = {
			['bproof_1'] = 53,  ['bproof_2'] = 3
		}
	},
	
	bullet_wear = {
		male = {
			['bproof_1'] = 53,  ['bproof_2'] = 3
		},
		female = {
			['bproof_1'] = 53,  ['bproof_2'] = 3
		}
	},

	manche_courte = {
		male = {
            ['tshirt_1'] = 18,  ['tshirt_2'] = 0,
            ['torso_1'] = 17,  ['torso_2'] = 8,
            ['decals_1'] =0,   ['decals_2'] = 0,
            ['arms'] = 11,       ['arms_2'] = 0,
            ['pants_1'] = 17,   ['pants_2'] = 0,
            ['shoes_1'] = 32,   ['shoes_2'] = 0,
            --['bags_1'] = 10,   ['bags_2'] = 0
		},
		female = {
            ['tshirt_1'] = 34, ['tshirt_2'] = 0,
            ['torso_1'] = 144,['torso_2'] = 9,
            ['decals_1'] = 0,  ['decals_2'] = 0,
            ['mask_1'] = 0, ['mask_2'] = 0,
            ['arms'] = 36,
            ['pants_1'] = 68, ['pants_2'] = 9,
            ['shoes_1'] = 47, ['shoes_2'] = 9,
            ['helmet_1'] = 71, ['helmet_2'] = 3,
            ['bags_1'] = 0, ['bags_2'] = 0,
            ['bproof_1'] = 0, ['bproof_2']  = 0
		}
	},

	moto = {
		male = {
            ['tshirt_1'] = 21,  ['tshirt_2'] = 0,
            ['torso_1'] = 48,  ['torso_2'] = 0,
            ['decals_1'] =0,   ['decals_2'] = 0,
            ['arms'] = 20,       ['arms_2'] = 0,
            ['pants_1'] = 24,   ['pants_2'] = 1,
            ['shoes_1'] = 33,   ['shoes_2'] = 0,
            ['bags_1'] = 10,   ['bags_2'] = 0,
		},
		female = {
            ['tshirt_1'] = 34, ['tshirt_2'] = 0,
            ['torso_1'] = 144,['torso_2'] = 9,
            ['decals_1'] = 0,  ['decals_2'] = 0,
            ['mask_1'] = 0, ['mask_2'] = 0,
            ['arms'] = 36,
            ['pants_1'] = 68, ['pants_2'] = 9,
            ['shoes_1'] = 47, ['shoes_2'] = 9,
            ['helmet_1'] = 71, ['helmet_2'] = 3,
            ['bags_1'] = 0, ['bags_2'] = 0,
            ['bproof_1'] = 0, ['bproof_2']  = 0
		}
	},

    velo = {
		male = {
            ['tshirt_1'] = 20,  ['tshirt_2'] = 0,
            ['torso_1'] = 42,   ['torso_2'] = 2,
            ['arms'] = 0,      ['arms_2'] = 0,
            ['pants_1'] = 12,   ['pants_2'] = 0,
            ['shoes_1'] = 61,   ['shoes_2'] = 0,
            ['helmet_1'] = 25,  ['helmet_2'] = 0,
            ['bags_1'] = 0, ['bags_2'] = 0
		},
		female = {
            ['tshirt_1'] = 34, ['tshirt_2'] = 0,
            ['torso_1'] = 144,['torso_2'] = 9,
            ['decals_1'] = 0,  ['decals_2'] = 0,
            ['mask_1'] = 0, ['mask_2'] = 0,
            ['arms'] = 36,
            ['pants_1'] = 68, ['pants_2'] = 9,
            ['shoes_1'] = 47, ['shoes_2'] = 9,
            ['helmet_1'] = 71, ['helmet_2'] = 3,
            ['bags_1'] = 0, ['bags_2'] = 0,
            ['bproof_1'] = 0, ['bproof_2']  = 0
		}
	},

    ceremonie = {
		male = {
            ['tshirt_1'] = 18,  ['tshirt_2'] = 0,
            ['torso_1'] = 19,  ['torso_2'] = 8,
            ['decals_1'] =0,   ['decals_2'] = 0,
            ['arms'] = 75,       ['arms_2'] = 0,
            ['pants_1'] = 17,   ['pants_2'] = 0,
            ['shoes_1'] = 32,   ['shoes_2'] = 0,
		},
		female = {
            ['tshirt_1'] = 34, ['tshirt_2'] = 0,
            ['torso_1'] = 144,['torso_2'] = 9,
            ['decals_1'] = 0,  ['decals_2'] = 0,
            ['mask_1'] = 0, ['mask_2'] = 0,
            ['arms'] = 36,
            ['pants_1'] = 68, ['pants_2'] = 9,
            ['shoes_1'] = 47, ['shoes_2'] = 9,
            ['helmet_1'] = 71, ['helmet_2'] = 3,
            ['bags_1'] = 0, ['bags_2'] = 0,
            ['bproof_1'] = 0, ['bproof_2']  = 0
		}
	}
}


Jobs.JobsFarm = {
    {name = "McGil", job = false, global = { pos = vector3(855.97, -2430, 75), blips = {display = 566, colour = 25, size = 0.7}}, actions = {
        --{pos = vector3(), action = "boss_menu", grade = "boss"},
        {pos = vector3(331, 921, 203), size = 8.0, action = "farm", itemwin = "bois", countwin = 1, countrequired = 1, notif = "Appuyez sur ~INPUT_CONTEXT~ pour ~b~commencer~s~.", anim = {"melee@hatchet@streamed_core", "plyr_front_takedown"}, time = 2500, message =  {name = "Récolte de bois en cours", r = 0, g = 122, b = 201}, blips = {
            display = 47, colour = 25, size = 0.5
        }, name = "Liaison McGill", peds = {model = "s_m_m_gaffer_01", pos = vector3(335, 925, 202.50), heading = 41.5, name = "Jack", anim = {"anim@heists@heist_corona@single_team", "single_team_loop_boss"}}},

        {
			pos = vector3(-121.48, -1031.14, 27), 
			size = 8.0, 
			action = "farm", 
			itemRequired = "bois", 
			itemwin = "planche", 
			countwin = 1, 
			countrequired = 1, 
			notif = "Appuyez sur ~INPUT_CONTEXT~ pour ~b~commencer~s~.", 
			anim = {"WORLD_HUMAN_HAMMERING"}, 
			time = 2500, 
			message =  {
				name = "Découpage de planches en cours", 
				r = 0, 
				g = 122,
				b = 201
			}, 
			blips = {
            	display = 47, colour = 25, size = 0.5
        	}, name = "Liaison McGill", 
			peds = {model = "s_m_m_dockwork_01", pos = vector3(-120.3, -1026.89, 26.27), heading = 165, name = "Bob", anim = {"anim@heists@heist_corona@single_team", "single_team_loop_boss"}}
		},

        {
			pos = vector3(503.01, -621.99, 24), 
			size = 5.0, 
			action = "farm", 
			sell = true, 
			money = 50, 
			itemRequired = "planche", 
			countrequired = 1, 
			notif = "Appuyez sur ~INPUT_CONTEXT~ pour ~b~commencer~s~.", 
			anim = {'pickup_object', 'putdown_low'}, 
			time = 2500, 
			message =  {
				name = "Vente de planches en cours", 
				r = 0, 
				g = 148, 
				b = 98
			}, 
			blips = {
            	display = 47, colour = 25, size = 0.5
        	}, name = "Liaison McGill", 
			peds = {
				model = "a_m_m_farmer_01", 
				pos = vector3(502.52, -631.76, 23.80), 
				heading = 12, 
				name = "Bryan", 
				anim = {"anim@amb@business@coc@coc_unpack_cut_left@", "coke_cut_v5_coccutter"}
			}
		},

        {pos = vector3(858, -2433, 28), size = 3.0, action = "vehicle", notif = "Appuyez sur ~INPUT_CONTEXT~ pour ~b~sortir un véhicule~s~.",
		 name = "Véhicules McGill", peds = {
            model = "s_m_m_gardener_01", pos = vector3(858.0, -2433.76, 27.07), heading = 175.72, name = "William", anim = {"anim@heists@heist_corona@single_team", "single_team_loop_boss"}
        }, vehicle = {
            model = "Bison2", pos = vector3(853, -2437, 27), heading = 175.72, 
        }},
        {pos = vector3(842, -2432, 27), size = 3.0, action = "delvehicle", notif = "Appuyez sur ~INPUT_CONTEXT~ pour ~r~ranger un véhicule~s~.",  name = "Véhicules McGill", peds = {
            model = "ig_floyd", pos = vector3(837, -2431, 27), heading = 267.65, name = "Stewart", anim = {"anim@heists@heist_corona@single_team", "single_team_loop_boss"}
        }, vehicle = {
            model = "Bison2", pos = vector3(837, -2431, 26), heading = 267.65, 
        }},
    } },
	{name = "Rob's Liquor", job = false, global = { pos = vector3(826.61, 2197.33, 52), blips = {display = 650, colour = 5, size = 0.7}}, actions = {
        --{pos = vector3(), action = "boss_menu", grade = "boss"},
        {pos = vector3(162, 2285, 94), size = 8.0, action = "farm", itemwin = "levure", countwin = 1, countrequired = 1, notif = "Appuyez sur ~INPUT_CONTEXT~ pour ~b~commencer~s~.", anim = {"anim@mp_snowball", "pickup_snowball"}, time = 2500, message =  {name = "Récolte de levure en cours", r = 0, g = 122, b = 201}, blips = {
            display = 164, colour = 5, size = 0.5
        }, name = "Liaison Rob's Liquor", peds = {model = "s_m_m_lathandy_01", pos = vector3(160, 2280, 93), heading = 338, name = "James", anim = {"anim@heists@heist_corona@single_team", "single_team_loop_boss"}}},

        {
			pos = vector3(366, 3407, 36), 
			size = 8.0, 
			action = "farm", 
			itemRequired = "levure", 
			itemwin = "ambiere", 
			countwin = 1, 
			countrequired = 1, 
			notif = "Appuyez sur ~INPUT_CONTEXT~ pour ~b~commencer~s~.", 
			anim = {"anim@mp_snowball", "pickup_snowball"}, 
			time = 2500, 
			message =  {
				name = "Fermentation de la bière",
				r = 0, 
				g = 122,
				b = 201
			}, 
			blips = {
            	display = 164, colour = 5, size = 0.5
        	}, name = "Liaison Rob's Liquor", 
			peds = {model = "s_m_m_migrant_01", pos = vector3(360, 3402, 36), heading = 294, name = "Tom", anim = {"anim@heists@heist_corona@single_team", "single_team_loop_boss"}}
		},

        {
			pos = vector3(-2955, 385, 15), 
			size = 5.0, 
			action = "farm", 
			sell = true, 
			money = 50, 
			itemRequired = "ambiere", 
			countrequired = 1, 
			notif = "Appuyez sur ~INPUT_CONTEXT~ pour ~b~commencer~s~.", 
			anim = {'pickup_object', 'putdown_low'}, 
			time = 2500, 
			message =  {
				name = "Vente de Bière en cours", 
				r = 0, 
				g = 148, 
				b = 98
			}, 
			blips = {
            	display = 164, colour = 5, size = 0.5
        	}, name = "Liaison Rob's Liquor", 
			peds = {
				model = "s_m_m_strvend_01", 
				pos = vector3(-2953.97, 379.26, 14.05), 
				heading = 350.05, 
				name = "Léo", 
				anim = {"anim@heists@heist_corona@single_team", "single_team_loop_boss"}
			}
		},

        {pos = vector3(843.8, 2193.05, 51.20), size = 3.0, action = "vehicle", notif = "Appuyez sur ~INPUT_CONTEXT~ pour ~b~sortir un véhicule~s~.",
		 name = "Véhicules Rob's Liquor", peds = {
            model = "s_m_m_gardener_01", pos = vector3(843.8, 2193.05, 51.20), heading = 331.52, name = "Ethan", anim = {"anim@heists@heist_corona@single_team", "single_team_loop_boss"}
        }, vehicle = {
            model = "Pounder", pos = vector3(843, 2205, 51), heading = 0.63, 
        }},
        {pos = vector3(823, 2193, 52), size = 3.0, action = "delvehicle", notif = "Appuyez sur ~INPUT_CONTEXT~ pour ~r~ranger un véhicule~s~.",  name = "Véhicules Rob's Liquor", peds = {
            model = "ig_floyd", pos = vector3(822, 2189, 51.20), heading = 337, name = "Stewart", anim = {"anim@heists@heist_corona@single_team", "single_team_loop_boss"}
        }, vehicle = {
            model = "Pounder" 
        }},
    } },
}