Config = {}
Config.Locale = "fr"
Config.IncludeCash = true
Config.IncludeWeapons = true
Config.IncludeAccounts = true
Config.ExcludeAccountsList = {"bank"}
Config.OpenControl = 37
Config.UseLastVersionESX = false
Config.Cash = "money"
Config.CashLabel = "Cash"
Config.Blackmoney = "black_money"
Config.BlackmoneyLabel = "Argent Sale"

Config.CloseUiItems = {"headbag"}

Config.Color = 2
Config.WeaponColor = 1

Config.Limit = 30000

Config.DefaultWeight = 1

Config.localWeight = {
	AED = 100,
	alive_chicken = 100,
	bandage = 100,
	beer = 100,
	blowpipe = 100,
	bong = 100,
	bread = 125,
	weed = 100,
	carokit = 100,
	carotool = 100,
	chocolate = 100,
	cigarett = 100,
	clip = 100,
	clothe = 100,
	cocacola = 100,
	cocaine = 100,
	coffe = 100,
	coke_pooch = 100,
	copper = 100,
	cupcake = 100,
	cutted_wood = 100,
	diamond = 100,
	essence = 100,
	fabric = 100,
	fish = 100,
	fishbait = 100,
	fishingrod = 100,
	fixkit = 100,
	fixtool = 100,
	gazbottle = 100,
	gold = 100,
	hamajifish = 100,
	hamburger = 100,
	icetea = 100,
	iron = 100,
	leather = 100,
	lighter = 100,
	marijuana = 350,
	marijuana_cigarette = 100,
	medikit = 100,
	meth = 100,
	meth_pooch = 100,
	milk = 100,
	oxygen_mask = 100,
	packaged_chicken = 100,
	packaged_plank = 100,
	petrol = 400,
	petrol_raffin = 100,
	prawn = 100,
	prawnbait = 100,
	sandwich = 100,
	shark = 100,
	slaughtered_chicken = 100,
	squid = 100,
	squidbait = 100,
	stone = 100,
	tequila = 100,
	turtle = 100,
	turtlebait = 100,
	vodka = 100,
	washed_stone = 100,
	water = 100,
	weaponflashlight = 100,
	weapongrip = 100,
	weaponskin = 100,
	weed_pooch = 100,
	whisky = 100,
	wine = 100,
	wood = 100,
	wool = 100,
	worm = 100,
	nothing = 300,
	porkpackage = 300,
	pork = 300,
	rice_pro = 300,
	rice = 300,
	phone = 15000,
	chest_a = 25,
	chest_a = 25,
	nurek = 25,
	honey_b = 25,
	honey_a = 25,
	marijuana = 25,
	cannabis = 25,
	sickle = 25,
	pizza = 25,
	burger = 25,
	pastacarbonara = 25,
	macka = 25,
	cigarett = 25,
	pro_wood = 25,
	wood = 25,
	meth_pooch = 25,
	meth = 25,
	marijuana = 25,
	cannabis = 25,
	wool = 25,
	clothe = 25,
	glass = 25,
	sands = 25,
	bcabbage = 25,
	acabbage = 25,
	gold_t = 25,
	gold_o = 25,
	mushroom = 25,
	mushroom_d = 25,
	mushroom_p = 25,
	oil_b = 25,
	oil_a = 25,
	leather_a = 25,
	meat_a = 25,
	meat_w = 25,
	drill = 25,
	medikit = 25,
	gps = 25,
	fishingrod = 25,
	Cottageleaves_box = 25,
	marijuana = 25,
	cannabis = 25,
	WEAPON_SMG = 50,
	WEAPON_CARBINERIFLE = 3000,
	WEAPON_SPECIALCARBINE = 3000,
	WEAPON_ASSAULTRIFLE = 3000,
	WEAPON_PUMPSHOTGUN = 2000,
	WEAPON_PISTOL = 1000,
	WEAPON_APPISTOL = 1000,
	WEAPON_MACHINEPISTOL = 1500,
	WEAPON_COMBATPISTOL = 1000
}







-- Shops
Config.Shops = {
	{
		Type = "Clothe",
		Pos = {
			vector3(4.47, 6512.19, 30.88),
			vector3(1693.97, 4822.61, 41.06),
			vector3(-1101.15, 2710.81, 18.10),
			vector3(614.23, 2762.70,41.09),
			vector3(1197.1, 2710.13, 37.22),
			vector3(-3170.63, 1043.72, 19.86),
			vector3(-1450.96, -238.13, 48.81),
			vector3(-709.44, -153.78, 36.41),
			vector3(-163.19, -302.04, 38.73),
			vector3(125.78, -223.84, 53.56),
			vector3(-1193.13, -767.93, 16.32),
			vector3(-822.20, -1073.41, 10.33),
			vector3(425.56, -806.41, 28.49),
			vector3(75.36, -1392.80, 28.38)
		},
		Size = 5.0,
		Blip = { display = 73, colour = 32, size = 0.8 },
		Name = "Magasin de v�tement",
		Header = {"shopui_title_midfashion", "shopui_title_midfashion"},
		Notif = "Appuyez sur ~INPUT_CONTEXT~ pour acc�der au ~b~magasin de v�tements~s~.",
		Ped = {
			Model = "s_f_y_shop_mid",
			Pos = {
				vector4(5.42, 6511.09, 30.88, 39.60),
				vector4(1695.63, 4822.66, 41.06, 92.55),
				vector4(-1102.22, 2711.87, 18.10, 218.64),
				vector4(613.02, 2762.66,41.08, 270.95 ),
				vector4(1197.15, 2711.64, 37.22, 179.68 ),
				vector4(-3169.41, 1043.28, 19.86, 69.40),
				vector4(-1448.81, -237.83, 48.81, 51.77),
				vector4(-708.99, -151.57, 36.41, 125.49),
				vector4(-164.98, -303.18, 38.73, 249.92),
				vector4(126.96, -224.31, 53.56,63.40),
				vector4(-1193.83, -766.93, 16.32, 216.69),
				vector4(-822.56, -1072.04,10.33, 211.10),
				vector4(426.97, -806.90, 28.49, 91.80),
				vector4(73.90, -1392.29, 28.38, 274.63),
			},
			Name = "Sabrina",
			Anim = {"random@shop_clothes@mid", "_greeting_a"}
		}
	},
}

Shops = {}
Shops.Clothes = {}
Shops.Clothes.Blacklist = {
	ears_1 = {},
	watches_1 = {},
	bracelets_1 = {},
	torso_1 = {
		m = {
			[6] = true, [8] = true, [10] = true, [11] = true, [57] = true, [58] = true, [59] = true, [60] = true, [61] = true, [62] = true, [63] = true, [64] = true, [65] = true, [66] = true, [67] = true, [68] = true, [69] = true, [70] = true, [71] = true, [72] = true, [73] = true, [74] = true, [75] = true, [76] = true, [77] = true, [78] = true, [79] = true, [80] = true, [81] = true, [82] = true, [84] = true, [85] = true, [86] = true, [87] = true, [88] = true, [89] = true, [90] = true, [91] = true, [92] = true, [93] = true, [94] = true, [96] = true, [97] = true, [101] = true, [102] = true, [103] = true, [104] = true, [105] = true, [106] = true, [107] = true, [108] = true, [109] = true, [110] = true, [112] = true, [115] = true, [116] = true, [117] = true, [118] = true, [119] = true, [120] = true, [121] = true, [122] = true, [123] = true, [126] = true, [127] = true, 
		},
		f = {
			[4] = true, [12] = true, [40] = true, [41] = true, [42] = true, [43] = true, [44] = true, [45] = true, [46] = true, [47] = true, [48] = true, [49] = true, [50] = true, [52] = true, [53] = true, [54] = true, [55] = true, [56] = true, [57] = true, [58] = true, [59] = true, [60] = true, [62] = true, [63] = true, [64] = true, [65] = true, [66] = true, [67] = true, [68] = true, [69] = true, [70] = true, [71] = true, [72] = true, [73] = true, [74] = true, [75] = true, [76] = true, [77] = true, [83] = true, [84] = true, [85] = true, [86] = true, [87] = true, [88] = true, [89] = true, [90] = true, [91] = true, [92] = true, [93] = true, [94] = true, [95] = true, [96] = true, [98] = true, [99] = true, [100] = true, [101] = true, [102] = true, [103] = true, [104] = true,
		},
	},
	tshirt_1 = {
		m = {
			[23] = true, [24] = true, [26] = true, [27] = true, [28] = true, [29] = true, [30] = true, [31] = true, [32] = true, [34] = true, [35] = true, [36] = true, [37] = true, [39] = true, [40] = true, [41] = true, [42] = true, [43] = true, [44] = true, [45] = true, [46] = true, [47] = true, [48] = true, [49] = true, [50] = true, [53] = true, [54] = true, [55] = true, [56] = true, [57] = true, [58] = true, [61] = true, [62] = true, [63] = true, [64] = true, [65] = true, [68] = true, [69] = true, [70] = true, [71] = true, [72] = true, [73] = true, [74] = true, [75] = true, [76] = true, [77] = true,
		},
		f = {
			[4] = true, [12] = true, [16] = true, [17] = true, [18] = true, [19] = true, [20] = true, [21] = true, [22] = true, [23] = true, [24] = true, [25] = true, [26] = true, [27] = true, [28] = true, [29] = true, [30] = true, [31] = true, [32] = true, [33] = true, [34] = true, [35] = true, [36] = true, [37] = true, [38] = true, [39] = true, [40] = true, [41] = true, [42] = true, [43] = true, [44] = true, [45] = true, [46] = true, [47] = true, [48] = true, [51] = true, [52] = true, [53] = true, [54] = true, [55] = true, [56] = true, [57] = true, [60] = true,
		},
	},
	arms = {},
	pants_1 = { 
		m = {
			[2] = true, [5] = true, [6] = true, [10] = true, [11] = true, [15] = true, [26] = true, [32] = true, [35] = true, [36] = true, [41] = true, [43] = true,
		},
		f = {
			[5] = true, [21] = true, [26] = true, [29] = true, [31] = true, [34] = true, [36] = true,
		},
	},
	shoes_1 = {},
	helmet_1 = {
		m = {
			[4] = true, [10] = true, [11] = true, [35] = true, [39] = true, [40] = true, [42] = true, [43] = true, [44] = true, [45] = true, [47] = true, [48] = true, [49] = true, [51] = true, [52] = true, [53] = true, [54] = true, [56] = true, [57] = true, [58] = true, [59] = true, [60] = true, [62] = true, [63] = true, [64] = true, [67] = true,
		},
		f = {
			[3] = true, [4] = true, [9] = true, [11] = true, [12] = true, [24] = true, [29] = true, [30] = true, [32] = true, [33] = true, [34] = true, [35] = true, [36] = true, [37] = true, [38] = true, [39] = true, [40] = true, [42] = true, [44] = true, [45] = true, [46] = true, [47] = true, [49] = true, [50] = true, [51] = true, [54] = true,
		},
	},
	chain_1 = {
		m = {
			[57] = true, [58] = true, [59] = true, [60] = true, [61] = true, [62] = true, [63] = true, [66] = true, [67] = true, [69] = true, [71] = true, [72] = true, [74] = true, [75] = true, [76] = true, [77] = true, [79] = true, [80] = true, [81] = true, [82] = true, [83] = true, [84] = true, [85] = true, [86] = true, [87] = true, [88] = true, [89] = true, [90] = true,
		},
		f = {
			[15] = true, [16] = true,[17] = true,[18] = true,[19] = true,[20] = true,[21] = true,[22] = true,[24] = true,[25] = true,[26] = true,[27] = true,[28] = true,[29] = true,[31] = true,[32] = true,[33] = true,[34] = true,[35] = true,[36] = true,[37] = true,[38] = true,[39] = true,[40] = true,
		},
	},
	bproof_1 = {
		[0] = true, [11] = true, [12] = true, [58] = true, [59] = true, [60] = true, [61] = true,
	},
	decals_1 = {
		m = {
			[9] = true, [23] = true, [24] = true, [26] = true, [27] = true, [28] = true, [29] = true, [30] = true, [31] = true, [32] = true, [34] = true, [35] = true, [36] = true, [37] = true, [39] = true, [40] = true, [41] = true, [42] = true, [43] = true, [44] = true, [45] = true, [10] = true, [11] = true, [12] = true, [13] = true, [14] = true, [15] = true, [16] = true, [17] = true, [18] = true, [19] = true, [20] = true, [21] = true, [22] = true, [33] = true, [25] = true, [38] = true,
		},
		f = {
			[9] = true, [23] = true, [24] = true, [26] = true, [27] = true, [28] = true, [29] = true, [30] = true, [31] = true, [32] = true, [34] = true, [35] = true, [36] = true, [37] = true, [39] = true, [40] = true, [41] = true, [42] = true, [10] = true, [11] = true, [12] = true, [13] = true, [14] = true, [15] = true, [16] = true, [17] = true, [18] = true, [19] = true, [20] = true, [21] = true, [22] = true, [33] = true, [25] = true, [38] = true, [7] = true, [8] = true,
		},
	},
	bags_1 = {
		m = {
			[23] = true, [24] = true, [26] = true, [27] = true, [28] = true, [29] = true, [30] = true, [31] = true, [32] = true, [34] = true, [35] = true, [36] = true, [37] = true, [39] = true, [40] = true, [41] = true, [42] = true, [43] = true, [44] = true, [45] = true, [51] = true, [11] = true, [12] = true, [13] = true, [14] = true, [15] = true, [16] = true, [17] = true, [18] = true, [19] = true, [20] = true, [21] = true, [22] = true, [33] = true, [25] = true, [38] = true, [46] =  true, [47] =  true, [48] =  true, [59] =  true, [50] =  true, [10] = true, [49] = true,
		},
		f = {
			[23] = true, [24] = true, [26] = true, [27] = true, [28] = true, [29] = true, [30] = true, [31] = true, [32] = true, [34] = true, [35] = true, [36] = true, [37] = true, [39] = true, [40] = true, [41] = true, [42] = true, [43] = true, [44] = true, [45] = true, [51] = true, [11] = true, [12] = true, [13] = true, [14] = true, [15] = true, [16] = true, [17] = true, [18] = true, [19] = true, [20] = true, [21] = true, [22] = true, [33] = true, [25] = true, [38] = true, [59] =  true, [50] =  true, [10] = true, [9] = true,
		},
	},
	glasses_1 = {}
}




