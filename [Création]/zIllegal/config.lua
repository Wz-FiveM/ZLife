Config = {}
Translation = {}

Config.maxCap = 9999999999

Config.Reward = {
	["meth"] = math.random(1,10),
	["coke"] = math.random(2,10),
	["weed"] = math.random(3,10),
}

Config.BlipJackingTime = 10

Config.BlipJackingRadius = 50.0

Config.ZoneSize     = {x = 7.0, y = 7.0, z = 3.0}

Config.RequiredCopsSelldrugs  = 1

Config.RequiredCopsCoke  = 0
Config.RequiredCopsMeth  = 0
Config.RequiredCopsWeed  = 0
Config.RequiredCopsTerre = 0

Config.TimeToFarm    = 1 * 850
Config.TimeToProcess = 1 * 10000
Config.TimeToSell    = 3 * 850

Config.Locales = 'fr'

Config.Zones = {
	MethField =			{x = -1467.52,  y = 5416.12,  z = 23.64,		sprite = 499,	color = 26},
    AntigelField =		{x = -230.76,  y = 3651.92,  z = 51.76,		sprite = 501,	color = 40},
    
    CokeField =			{x = 2854.88,  y = 4708.88,  z = 47.28,		sprite = 501,	color = 40},
	AcideField =		{x = -1108.68,  y = 2723.8,  z = 18.8,		sprite = 501,	color = 40},

	WeedField =		    {x = -2222.158, y = -365.9263, z = 13.32121,		sprite = 496,	color = 52}
}

-- Config.Shopkeeper = 416176080
Config.Locale = 'fr'

-- Config.Shops = {
--     {shopkeeper = "a_m_y_downtown_01", coords = vector3(24.03, -1345.63, 29.5-0.98), heading = 266.0,  cops = 2,timrob = 380, blip = true, name = 'Apu', cooldown = {hour = 0, minute = 30, second = 0}, robbed = false},
--     {shopkeeper = "a_m_m_stlat_02", coords = vector3(1164.94, -323.76, 68.2-0.98), heading = 100.0,  cops = 2,timrob = 415, blip = true, name = 'Apu', cooldown = {hour = 0, minute = 30, second = 0}, robbed = false},
--     {shopkeeper = "a_m_m_socenlat_01", coords = vector3(372.85, 328.10, 102.56-0.98), heading = 266.0,  cops = 2,timrob = 405, blip = true, name = 'Apu', cooldown = {hour = 0, minute = 30, second = 0}, robbed = false},
--     {shopkeeper = "g_m_y_azteca_01", coords = vector3(1134.24, -983.14, 45.41-0.98), heading = 266.0,  cops = 2,timrob = 405, blip = true, name = 'Apu', cooldown = {hour = 0, minute = 30, second = 0}, robbed = false},
--     {shopkeeper = "a_f_o_indian_01", coords = vector3(-1221.40, -908.02, 11.32-0.98), heading = 40.0,  cops = 2,timrob = 200, blip = true, name = 'Apu', cooldown = {hour = 0, minute = 30, second = 0}, robbed = false},
--     {shopkeeper = "a_m_m_afriamer_01", coords = vector3(-47.39, -1758.72, 28.42-0.98), heading = 40.0,  cops = 2,timrob = 390, blip = true, name = 'Apu', cooldown = {hour = 0, minute = 30, second = 0}, robbed = false},
--     {shopkeeper = "a_m_o_beach_01", coords = vector3(1728.62, 6416.81, 34.03-0.98), heading = 240.0,  cops = 2,timrob = 725, blip = true, name = 'Apu', cooldown = {hour = 0, minute = 30, second = 0}, robbed = false},
--     {shopkeeper = "a_m_o_ktown_01", coords = vector3(1696.92, 4923.68, 42.08-0.98), heading = 324.10,  cops = 2,timrob = 550, blip = true, name = 'Apu', cooldown = {hour = 0, minute = 30, second = 0}, robbed = false},
--     {shopkeeper = "a_m_y_epsilon_02", coords = vector3(161.92, 6642.96, 31.72-0.98), heading = 226.04,  cops = 2,timrob = 735, blip = true, name = 'Apu', cooldown = {hour = 0, minute = 30, second = 0}, robbed = false},
-- 	{shopkeeper = "a_m_y_mexthug_01", coords = vector3(-2966.37, 391.57, 15.04-0.98), heading = 100.0,  cops = 2,timrob = 420, blip = true, name = 'Apu', cooldown = {hour = 0, minute = 30, second = 0}, robbed = false},
-- 	{shopkeeper = "ig_lifeinvad_02", coords = vector3(-1486.64,-377.6, 40.16-0.98), heading = 140.12,  cops = 2,timrob = 260, blip = true, name = 'Apu', cooldown = {hour = 0, minute = 30, second = 0}, robbed = false},
-- 	{shopkeeper = "s_f_y_sweatshop_01", coords = vector3(-1820.52, 794.6,138.08-0.98), heading = 131.01,  cops = 2,timrob = 415, blip = true, name = 'Apu', cooldown = {hour = 0, minute = 30, second = 0}, robbed = false},
-- 	{shopkeeper = "s_f_y_shop_low", coords = vector3(1165.48, 2710.8, 38.16-0.98), heading = 177.55,  cops = 2,timrob = 650, blip = true, name = 'Apu', cooldown = {hour = 0, minute = 30, second = 0}, robbed = false},
--     {shopkeeper = "s_m_m_ammucountry", coords = vector3(2676.52, 3280.24, 55.24-0.98), heading = 330.22,  cops = 2,timrob = 625, blip = true, name = 'Apu', cooldown = {hour = 0, minute = 30, second = 0}, robbed = false},
--     {shopkeeper = "s_m_o_busker_01", coords = vector3(549.32, 2669.44, 42.16-0.98), heading = 96.15,  cops = 2,timrob = 650, blip = true, name = 'Apu', cooldown = {hour = 0, minute = 30, second = 0}, robbed = false},
--     {shopkeeper = "ig_car3guy1", coords = vector3(-3040.76, 584.0, 7.92-0.98), heading = 16.46,  cops = 2,timrob = 435, blip = true, name = 'Apu', cooldown = {hour = 0, minute = 30, second = 0}, robbed = false},
--     {shopkeeper = "ig_drfriedlander", coords = vector3(-3244.2, 1000.2, 12.84-0.98), heading = 354.17,  cops = 2,timrob = 485, blip = true, name = 'Apu', cooldown = {hour = 0, minute = 30, second = 0}, robbed = false},
--     {shopkeeper = "ig_jimmyboston_02", coords = vector3(2555.36, 380.84, 108.64-0.98), heading = 356.28,  cops = 2,timrob = 560, blip = true, name = 'Apu', cooldown = {hour = 0, minute = 30, second = 0}, robbed = false},
-- 	{shopkeeper = "ig_old_man2", coords = vector3(1392.28, 3606.2, 35.0-0.98), heading = 196.87,  cops = 2,timrob = 650, blip = true, name = 'Apu', cooldown = {hour = 0, minute = 30, second = 0}, robbed = false}
-- }
-- Translation = {
--     ['fr'] = {
--         ['shopkeeper'] = 'Vendeur',
--         ['robbed'] = 'Je viens de me faire braquer et je n\'ai plus d\'argent restant',
--         ['cashrecieved'] = 'Vous avez recu :',
--         ['currency'] = '$',
--         ['scared'] = 'Peur:',
--         ['no_cops'] = 'Je viens de me faire braquer et je n\'ai plus d\'argent restant',
--         ['cop_msg'] = 'Une personne est entreint de Braquer Apu !',
--         ['set_waypoint'] = 'Mettre un point vers le magasin',
--         ['hide_box'] = 'Refuser l\'appel',
--         ['robbery'] = 'Braquage en cours',
--         ['walked_too_far'] = 'Vous etes partis trop loin du magasin'
--     }
-- }

Config.chance = {1, 10} -- chance thad you get when you have bad weapons

Config.timeinterval = 8000 --- time between every non accepted robbery minimom 5000

Config.PedAccuracy = 10 -- [ 0-100, 100 being perfectly accurate ]

Config.Shops = {
    {shopkeeper = "a_m_y_downtown_01", coords = vector3(24.03, -1345.63, 29.5-0.98), heading = 266.0,  cops = 2,timrob = 380, blip = true, name = 'Apu', cooldown = {hour = 0, minute = 30, second = 0}, robbed = false},
    {shopkeeper = "a_m_m_stlat_02", coords = vector3(1164.94, -323.76, 68.2-0.98), heading = 100.0,  cops = 2,timrob = 415, blip = true, name = 'Apu', cooldown = {hour = 0, minute = 30, second = 0}, robbed = false},
    {shopkeeper = "a_m_m_socenlat_01", coords = vector3(372.85, 328.10, 102.56-0.98), heading = 266.0,  cops = 0,timrob = 405, blip = true, name = 'Apu', cooldown = {hour = 0, minute = 30, second = 0}, robbed = false},
    {shopkeeper = "g_m_y_azteca_01", coords = vector3(1134.24, -983.14, 45.41-0.98), heading = 266.0,  cops = 2,timrob = 405, blip = true, name = 'Apu', cooldown = {hour = 0, minute = 30, second = 0}, robbed = false},
    {shopkeeper = "a_f_o_indian_01", coords = vector3(-1221.40, -908.02, 11.32-0.98), heading = 40.0,  cops = 2,timrob = 200, blip = true, name = 'Apu', cooldown = {hour = 0, minute = 30, second = 0}, robbed = false},
    {shopkeeper = "a_m_m_afriamer_01", coords = vector3(-47.39, -1758.72, 28.42-0.98), heading = 40.0,  cops = 2,timrob = 390, blip = true, name = 'Apu', cooldown = {hour = 0, minute = 30, second = 0}, robbed = false},
    {shopkeeper = "a_m_o_beach_01", coords = vector3(1728.62, 6416.81, 34.03-0.98), heading = 240.0,  cops = 2,timrob = 725, blip = true, name = 'Apu', cooldown = {hour = 0, minute = 30, second = 0}, robbed = false},
    {shopkeeper = "a_m_o_ktown_01", coords = vector3(1696.92, 4923.68, 42.08-0.98), heading = 324.10,  cops = 2,timrob = 550, blip = true, name = 'Apu', cooldown = {hour = 0, minute = 30, second = 0}, robbed = false},
    {shopkeeper = "a_m_y_epsilon_02", coords = vector3(161.92, 6642.96, 31.72-0.98), heading = 226.04,  cops = 2,timrob = 735, blip = true, name = 'Apu', cooldown = {hour = 0, minute = 30, second = 0}, robbed = false},
	{shopkeeper = "a_m_y_mexthug_01", coords = vector3(-2966.37, 391.57, 15.04-0.98), heading = 100.0,  cops = 2,timrob = 420, blip = true, name = 'Apu', cooldown = {hour = 0, minute = 30, second = 0}, robbed = false},
	{shopkeeper = "ig_lifeinvad_02", coords = vector3(-1486.64,-377.6, 40.16-0.98), heading = 140.12,  cops = 2,timrob = 260, blip = true, name = 'Apu', cooldown = {hour = 0, minute = 30, second = 0}, robbed = false},
	{shopkeeper = "s_f_y_sweatshop_01", coords = vector3(-1820.52, 794.6,138.08-0.98), heading = 131.01,  cops = 2,timrob = 415, blip = true, name = 'Apu', cooldown = {hour = 0, minute = 30, second = 0}, robbed = false},
	{shopkeeper = "s_f_y_shop_low", coords = vector3(1165.48, 2710.8, 38.16-0.98), heading = 177.55,  cops = 2,timrob = 650, blip = true, name = 'Apu', cooldown = {hour = 0, minute = 30, second = 0}, robbed = false},
    {shopkeeper = "s_m_m_ammucountry", coords = vector3(2676.52, 3280.24, 55.24-0.98), heading = 330.22,  cops = 2,timrob = 625, blip = true, name = 'Apu', cooldown = {hour = 0, minute = 30, second = 0}, robbed = false},
    {shopkeeper = "s_m_o_busker_01", coords = vector3(549.32, 2669.44, 42.16-0.98), heading = 96.15,  cops = 2,timrob = 650, blip = true, name = 'Apu', cooldown = {hour = 0, minute = 30, second = 0}, robbed = false},
    {shopkeeper = "ig_car3guy1", coords = vector3(-3040.76, 584.0, 7.92-0.98), heading = 16.46,  cops = 2,timrob = 435, blip = true, name = 'Apu', cooldown = {hour = 0, minute = 30, second = 0}, robbed = false},
    {shopkeeper = "ig_drfriedlander", coords = vector3(-3244.2, 1000.2, 12.84-0.98), heading = 354.17,  cops = 2,timrob = 485, blip = true, name = 'Apu', cooldown = {hour = 0, minute = 30, second = 0}, robbed = false},
    {shopkeeper = "ig_jimmyboston_02", coords = vector3(2555.36, 380.84, 108.64-0.98), heading = 356.28,  cops = 2,timrob = 560, blip = true, name = 'Apu', cooldown = {hour = 0, minute = 30, second = 0}, robbed = false},
	{shopkeeper = "ig_old_man2", coords = vector3(1392.28, 3606.2, 35.0-0.98), heading = 196.87,  cops = 2,timrob = 650, blip = true, name = 'Apu', cooldown = {hour = 0, minute = 30, second = 0}, robbed = false}
}

Config.DirtyMoney = false    
Config.GCPhone = false            
Config.progressBars = true        
Config.CopsNeeded = 0             
Config.MinMoney = 100         
Config.MaxMoney = 500            
Config.RobWaitTime = 5             
Config.AddItemsPerctent = 20     
Config.AddItemsMax = 5            
Config.CoolDownTime = 30            

Config.PoliceNotify = 99     
Config.AlwaysNotifyonDeath = true 
Config.MustUseVoice = false


Config.giveableItems = {
    'icetea',
    'hamburger'
}

Config.RequiredCopsRob = 0
Config.RequiredCopsSell = 0

Stores = {
	["jewelry"] = {
		position = { ['x'] = -629.99, ['y'] = -236.542, ['z'] = 38.05 },       
		reward = math.random(10000,23500),
		nameofstore = "Bijouterie",
		lastrobbed = 0
	}
}


Config.UseESX = true

-- What should the price of jerry cans be?
Config.JerryCanCost = 20
Config.RefillCost = 25 -- If it is missing half of it capacity, this amount will be divided in half, and so on.

-- Fuel decor - No need to change this, just leave it.
Config.FuelDecor = "_FUEL_LEVEL"

-- What keys are disabled while you're fueling.
Config.DisableKeys = {0, 22, 23, 24, 29, 30, 31, 37, 44, 56, 82, 140, 166, 167, 168, 170, 288, 289, 311, 323}

-- Want to use the HUD? Turn this to true.
Config.EnableHUD = false

-- Configure blips here. Turn both to false to disable blips all together.
Config.ShowNearestGasStationOnly = true
Config.ShowAllGasStations = false

-- Configure the strings as you wish here.

-- For change languagues of notifications, look source/fuel_client.lua.
Config.Strings = {
	JerryCanEmpty = "Bidon d'essence rempli",
	PurchaseJerryCan = "Appuyez sur ~g~E ~w~pour acheter un bidon d'essence à ~g~$" .. Config.JerryCanCost,
	CancelFuelingPump = "Appuyez sur ~INPUT_CONTEXT~ pour ~r~arrêter",
	CancelFuelingJerryCan = "Appuvez sur ~g~E ~w~pour annuler le plein",
	NotEnoughCash = "Vous n'avez pas assez d'argent",
	RefillJerryCan = "Appuyez sur ~g~E ~w~ pour remplir votre bidon d'essence pour ",
	NotEnoughCashJerryCan = "Vous n'avez pas assez d'argent pour un bidon d'essence",
	JerryCanFull = "Le bidon d'essence est plein",
	TotalCost = "Prix",
}

if not Config.UseESX then
	Config.Strings.PurchaseJerryCan = "Appuyez sur ~g~E ~w~pour acheter un bidon d'essence"
	Config.Strings.RefillJerryCan = "Appuyez sur ~g~E ~w~ pour remplir le bidon d'essence"
end

Config.PumpModels = {
	[-2007231801] = true,
	[1339433404] = true,
	[1694452750] = true,
	[1933174915] = true,
	[-462817101] = true,
	[-469694731] = true,
	[-164877493] = true
}

-- Blacklist certain vehicles. Use names or hashes. https://wiki.gtanet.work/index.php?title=Vehicle_Models
Config.Blacklist = {
	--"Adder",
	--276773164
}

-- Do you want the HUD removed from showing in blacklisted vehicles?
Config.RemoveHUDForBlacklistedVehicle = true

-- Class multipliers. If you want SUVs to use less fuel, you can change it to anything under 1.0, and vise versa.
Config.Classes = {
	[0] = 0.7, -- Compacts
	[1] = 0.7, -- Sedans
	[2] = 0.7, -- SUVs
	[3] = 0.7, -- Coupes
	[4] = 0.7, -- Muscle
	[5] = 0.7, -- Sports Classics
	[6] = 0.7, -- Sports
	[7] = 0.7, -- Super
	[8] = 0.5, -- Motorcycles
	[9] = 0.7, -- Off-road
	[10] = 0.3, -- Industrial
	[11] = 0.4, -- Utility
	[12] = 0.6, -- Vans
	[13] = 0.0, -- Cycles
	[14] = 0.5, -- Boats
	[15] = 0.3, -- Helicopters
	[16] = 0.3, -- Planes
	[17] = 0.5, -- Service
	[18] = 0.5, -- Emergency
	[19] = 0.5, -- Military
	[20] = 0.5, -- Commercial
	[21] = 0.0, -- Trains
}

-- The left part is at percentage RPM, and the right is how much fuel (divided by 10) you want to remove from the tank every second
Config.FuelUsage = {
	[1.0] = 0.3,
	[0.9] = 0.3,
	[0.8] = 0.3,
	[0.7] = 0.3,
	[0.6] = 0.3,
	[0.5] = 0.3,
	[0.4] = 0.3,
	[0.3] = 0.3,
	[0.2] = 0.2,
	[0.1] = 0.1,
	[0.0] = 0.0,
}
Config.GasStations = {
	vector3(49.4187, 2778.793, 58.043),
	vector3(263.894, 2606.463, 44.983),
	vector3(1039.958, 2671.134, 39.550),
	vector3(1207.260, 2660.175, 37.899),
	vector3(2539.685, 2594.192, 37.944),
	vector3(2679.858, 3263.946, 55.240),
	vector3(2005.055, 3773.887, 32.403),
	vector3(1687.156, 4929.392, 42.078),
	vector3(1701.314, 6416.028, 32.763),
	vector3(179.857, 6602.839, 31.868),
	vector3(-94.4619, 6419.594, 31.489),
	vector3(-2554.996, 2334.40, 33.078),
	vector3(-1800.375, 803.661, 138.651),
	vector3(-1437.622, -276.747, 46.207),
	vector3(-2096.243, -320.286, 13.168),
	vector3(-724.619, -935.1631, 19.213),
	vector3(-526.019, -1211.003, 18.184),
	vector3(-70.2148, -1761.792, 29.534),
	vector3(265.648, -1261.309, 29.292),
	vector3(819.653, -1028.846, 26.403),
	vector3(1208.951, -1402.567,35.224),
	vector3(1181.381, -330.847, 69.316),
	vector3(620.843, 269.100, 103.089),
	vector3(2581.321, 362.039, 108.468),
	vector3(176.631, -1562.025, 29.263),
	vector3(176.631, -1562.025, 29.263),
	vector3(-319.292, -1471.715, 30.549),
	vector3(1784.324, 3330.55, 41.253)
}

peds = {
    {
        id = "dealer",
        legal = false,
        ped = GetHashKey("s_m_y_dealer_01"),
        coords = vector3(891.6, -2538.2, 28.44),
        heading = 172.99,
    },
    {
        id = "lamar",
        legal = false,
        ped = GetHashKey("s_m_y_dealer_01"),
        coords = vector3(414.44, 343.92, 102.44),
        heading = 172.99,
    },
    {
        id = "marchandise",
        legal = false,
        ped = GetHashKey("s_m_y_dealer_01"),
        coords = vector3(-444.96, 1598.36, 358.2),
        heading = 172.99,
    },
    {
        id = "braquo",
        legal = false,
        ped = GetHashKey("s_m_y_robber_01"),
        coords = vector3(1520.76, 6317.68, 24.08),
        heading = 89.5,
    },
    {
        id = "securoserv",
        legal = false,
        ped = GetHashKey("s_m_y_robber_01"),
        coords = vector3(592.56, -3270.84, 25.6),
        heading = 89.5,
    },
}

mission = {
    {
        ped = "lamar",
        id = 1,
        type = "voleVehiculeLamar",
        Titre = "Voler le véhicule une Faction Donk (~r~1000$~s~)",
        Desc = "Nous avons trouvé un véhicule rare qui se revend bien en pièces détachés. Attention, c'est un mafieu !",
        LongText = "Je t'es indiqué le lieu, je te laisse y aller. Dépêche !",
        vehicule = GetHashKey("faction3"),
        possibleSpawn = {
            {pos = vector3(-1569.72, -1038.6, 13.0-0.95),heading = 254.60,},
            {pos = vector3(1733.68, 4635.08, 43.24-0.95),heading = 297.07,},
            {pos = vector3(487.44, -1334.0, 29.32-0.95),heading = 26.34,},
            {pos = vector3(895.48, 3575.4, 33.48-0.95),heading = 91.39,},
            {pos = vector3(871.56, 2868.48, 56.88-0.95),heading = 205.54,},
        },
        stop = vector3(209.32, 376.16, 107.04),
        prix = 1000,
    },
    {
        ped = "lamar",
        id = 2,
        type = "voleVehiculeLamar",
        Titre = "Voler le véhicule une Virgo (~r~1000$~s~)",
        Desc = "Hum il me semble avoir un camion déposé quelque part, je te laisse aller le chercher mais fais attention !",
        LongText = "Je t'es indiqué le lieu, je te laisse y aller. Dépêche !",
        vehicule = GetHashKey("virgo2"),
        possibleSpawn = {
            {pos = vector3(-1569.72, -1038.6, 13.0-0.95),heading = 254.60,},
            {pos = vector3(1733.68, 4635.08, 43.24-0.95),heading = 297.07,},
            {pos = vector3(487.44, -1334.0, 29.32-0.95),heading = 26.34,},
            {pos = vector3(895.48, 3575.4, 33.48-0.95),heading = 91.39,},
            {pos = vector3(871.56, 2868.48, 56.88-0.95),heading = 205.54,},
        },
        stop = vector3(204.72, 377.2, 107.24),
        prix = 1000,
    },

    {
        ped = "dealer",
        id = 3,
        type = "voleVehicule",
        Titre = "Voler le véhicule une Windsor (~r~1500$~s~)",
        Desc = "Nous avons trouvé un véhicule type 'Windsor' de luxe, nous aimerons que tu la ramène.",
        LongText = "Je t'es indiqué le lieu, je te laisse y aller. Dépêche !",
        vehicule = GetHashKey("windsor"),
        possibleSpawn = {
            {pos = vector3(-1665.8, 391.76, 89.2-0.95),heading = 15.18,},
            {pos = vector3(-218.4, 6381.0, 31.6-0.95),heading = 43.42,},
            {pos = vector3(215.52, 758.36, 204.64-0.95),heading = 48.62,},
            {pos = vector3(1835.8, 3908.48, 33.16-0.95),heading = 195.40,},
            {pos = vector3(-3196.96, 1160.28, 9.64-0.95),heading = 248.81,},
        },
        stop = vector3(1088.32, -2289.4, 30.16),
        prix = 1500,
    },
    {
        ped = "dealer",
        id = 4,
        type = "voleVehicule",
        Titre = "Voler le véhicule un Mesa (~r~1500$~s~)",
        Desc = "Nous avons trouvé un véhicule type 'Mesa', nous aimerons que tu la ramène.",
        LongText = "Je t'es indiqué le lieu, je te laisse y aller. Dépêche !",
        vehicule = GetHashKey("mesa"),
        possibleSpawn = {
            {pos = vector3(-1665.8, 391.76, 89.2-0.95),heading = 15.18,},
            {pos = vector3(-218.4, 6381.0, 31.6-0.95),heading = 43.42,},
            {pos = vector3(215.52, 758.36, 204.64-0.95),heading = 48.62,},
            {pos = vector3(1835.8, 3908.48, 33.16-0.95),heading = 195.40,},
            {pos = vector3(-3196.96, 1160.28, 9.64-0.95),heading = 248.81,},
        },
        stop = vector3(1087.64, -2300.56, 30.16),
        prix = 1500,
    },

    {
        ped = "marchandise",
        id = 5,
        type = "voleMarchandise",
        Titre = "Ramener une cargaison de drogues",
        Desc = "Un camion rempli de drogues est stationné depuis plusieurs jours, je t'engage pour aller le récupérer !",
        LongText = "Le lieu t'a été donné, vas récupéré le camion et méfie toi !",
        vehicule = GetHashKey("mule3"),
        possibleSpawn = {
            {pos = vector3(1233.48, -3330.8, 5.72-0.95),heading = 181.67,},
            {pos = vector3(-1131.32, -2225.4, 13.2-0.95),heading = 332.96,},
            {pos = vector3(-1575.0, 5166.84, 19.56-0.95),heading = 149.09,},
            {pos = vector3(-194.68, 6536.08, 11.08-0.95),heading = 41.25,},
            {pos = vector3(3695.76, 4557.4, 25.48-0.95),heading = 183.09,},
        },
        stop = vector3(373.2, 787.92, 186.88),
        prix = 1500,
    },

    {
        ped = "braquo",
        id = 6,
        type = "braquo",
        Titre = "Mission Bugstars",
        Desc = "On vas organiser un petit braquage mais qui necessite une préparation et un assez gros dangé !",
        LongText = "Vas chercher le véhicule.",
        pedWalk = vector3(885.32, -1656.045, 29.28),
        vehicule = GetHashKey("burrito2"),
        spawnVeh = vector3(1541.28, 6335.72, 24.08-0.50),
        headingStart = 58.24,
        stopVehicule = vector3(1396.56, 3595.36, 34.92-0.30),
        headingStop = 110.86,
        ChangementDeTenu = vector3(1399.96, 3596.68, 34.88-0.40),
        possibleVole = {
            {pos = vector3(1390.72, 3608.56, 35.0),heading = 17.97,},
            {pos = vector3(1388.92, 3603.72, 35.0),heading = 105.61,},
            {pos = vector3(1389.2, 3602.2, 35.0),heading = 110.18,},
            {pos = vector3(1390.68, 3601.12, 35.0),heading = 110.05,},
            {pos = vector3(1395.96, 3601.88, 35.0),heading = 198.47,},
            {pos = vector3(1398.52, 3602.72, 35.0),heading = 197.99,},
            {pos = vector3(1397.12, 3607.36, 35.0),heading = 21.72,},
            {pos = vector3(1399.0, 3605.52, 35.0),heading = 294.20,},
            {pos = vector3(1396.08, 3604.4, 35.0),heading = 196.30,}, 
        },
        Caisse = {
            {pos = vector3(1392.88, 3606.4, 35.0),heading = 199.87,},
            {pos = vector3(1391.24, 3605.84, 35.0),heading = 200.4,},
        },
        stop = vector3(-93.72, 2809.64, 53.32),
        prix = 100,
    },

    {
        ped = "securoserv",
        id = 7,
        type = "voleSecuroserv",
        Titre = "Vol/Transport SecuroServ",
        Desc = "Le SecuroServ vas te donner deux véhicules à voler et à tranporter, mission à haut risque !",
    },
}
