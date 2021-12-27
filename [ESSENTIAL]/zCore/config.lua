Config = {}
config = {}
Config.Locale = 'fr'
Config.EnableESXIdentity = false
Config.MaxSalary = 1000

local Keys = {
	["ESC"] = 322, ["F1"] = 288, ["F2"] = 289, ["F3"] = 170, ["F5"] = 166, ["F6"] = 167, ["F7"] = 168, ["F8"] = 169, ["F9"] = 56, ["F10"] = 57,
	["~"] = 243, ["1"] = 157, ["2"] = 158, ["3"] = 160, ["4"] = 164, ["5"] = 165, ["6"] = 159, ["7"] = 161, ["8"] = 162, ["9"] = 163, ["-"] = 84, ["="] = 83, ["BACKSPACE"] = 177,
	["TAB"] = 37, ["Q"] = 44, ["W"] = 32, ["E"] = 38, ["R"] = 45, ["T"] = 245, ["Y"] = 246, ["U"] = 303, ["P"] = 199, ["["] = 39, ["]"] = 40, ["ENTER"] = 18,
	["CAPS"] = 137, ["A"] = 34, ["S"] = 8, ["D"] = 9, ["F"] = 23, ["G"] = 47, ["H"] = 74, ["K"] = 311, ["L"] = 182,
	["LEFTSHIFT"] = 21, ["Z"] = 20, ["X"] = 73, ["C"] = 26, ["V"] = 0, ["B"] = 29, ["N"] = 249, ["M"] = 244, [","] = 82, ["."] = 81,
	["LEFTCTRL"] = 36, ["LEFTALT"] = 19, ["SPACE"] = 22, ["RIGHTCTRL"] = 70,
	["HOME"] = 213, ["PAGEUP"] = 10, ["PAGEDOWN"] = 11, ["DELETE"] = 178,
	["LEFT"] = 174, ["RIGHT"] = 175, ["TOP"] = 27, ["DOWN"] = 173,
	["NENTER"] = 201, ["N4"] = 108, ["N5"] = 60, ["N6"] = 107, ["N+"] = 96, ["N-"] = 97, ["N7"] = 117, ["N8"] = 61, ["N9"] = 118
}

ConfigTat = {}

Config.Price = 55
Config.Pricemask = 15

Config.DrawDistance = 100.0
Config.MarkerSize   = {x = 2.5, y = 2.5, z = 1.0}
Config.MarkerColor  = {r = 102, g = 102, b = 204}
Config.MarkerType   = -1

Config.DrawDistance = 100.0
Config.SizeA   = {x = 1.0, y = 1.0, z = 1.0}
Config.Color  = {r = 0, g = 125, b = 8}
Config.TypeA   = 25


Config.ShopsBlipsA = {
	Ears = {
		Pos = nil,
		Blip = nil
	},
	Mask = {
		Pos = { 
			{x = -1338.16,  y = -1277.68,  z = 4.88},
			{x = 1705.37,   y = 3780.29, z = 33.76},
		},
		Blip = { sprite = 362, color = 2 }
	},
	Helmet = {
		Pos = nil,
		Blip = nil
	},
	Glasses = {
		Pos = nil,
		Blip = nil
	}
}


Config.ZonesA = {
	Ears = {
		Pos = {
			{x= 80.374,	 y= -1389.493,	z= 28.406},
			{x = -714.16,  y = -147.92,  z = 37.4-0.98},
			{x = -164.36,  y = -310.52,  z = 39.72-0.98},
			{x= 420.787,	y= -809.654,	 z= 28.611},
			{x= -817.070,   y= -1075.965,	z= 10.448},
			{x = -1446.64,  y = -232.0,  z = 49.8-0.98},
			{x= -0.756,	 y= 6513.685,	 z= 30.997},
			{x= 123.431,	y= -208.060,	 z= 53.677},
			{x= 1689.648,   y= 4818.805,	 z= 41.183},
			{x= 622.806,	y= 2749.221,	 z= 41.208},
			{x= 1200.085,   y= 2705.428,	 z= 37.342},
			{x= -1199.959,  y= -782.534,	 z= 16.452},
			{x= -3171.867,  y= 1059.632,	 z= 19.983},
			{x= -1095.670,  y= 2709.245,	 z= 18.227},
		}
		
	},
	
	Mask = {
		Pos = {
			{x = -1338.16,  y = -1277.68,  z = 4.88-0.98},
			{x = 1706.12,  y = 3779.28,  z = 34.76-0.98},
		}
	},
	
	Helmet = {
		Pos = {
			{x= 81.576,	 y= -1400.602,	z= 28.406},
			{x= -705.845,   y= -159.015,	 z= 36.535},
			{x= -161.349,   y= -295.774,	 z= 38.853},
			{x= 419.319,	y= -800.647,	 z= 28.611},
			{x= -824.362,   y= -1081.741,	z= 10.448},
			{x= -1454.888,  y= -242.911,	 z= 48.931},
			{x= 4.770,	  y= 6520.935,	 z= 30.997},
			{x= 121.071,	y= -223.266,	 z= 53.377},
			{x= 1687.318,   y= 4827.685,	 z= 41.183},
			{x= 613.971,	y= 2749.978,	 z= 41.208},
			{x= 1189.513,   y= 2703.947,	 z= 37.342},
			{x= -1204.025,  y= -774.439,	 z= 16.452},
			{x= -3164.280,  y= 1054.705,	 z= 19.983},
			{x= -1103.125,  y= 2700.599,	 z= 18.227},
		}
	},
	
	Glasses = {
		Pos = {
			{x= 75.287,	 y= -1391.131,	z= 28.406},
			{x= -713.102,   y= -160.116,	 z= 36.535},
			{x= -156.171,   y= -300.547,	 z= 38.853},
			{x= 425.478,	y= -807.866,	 z= 28.611},
			{x= -820.853,   y= -1072.940,	z= 10.448},
			{x= -1458.052,  y= -236.783,	 z= 48.918},
			{x= 3.587,	  y= 6511.585,	 z= 30.997},
			{x= 131.335,	y= -212.336,	 z= 53.677},
			{x= 1694.936,   y= 4820.837,	 z= 41.183},
			{x= 613.972,	y= 2768.814,	 z= 41.208},
			{x= 1198.678,   y= 2711.011,	 z= 37.342},
			{x= -1188.227,  y= -764.594,	 z= 16.452},
			{x= -3173.192,  y= 1038.228,	 z= 19.983},
			{x= -1100.494,  y= 2712.481,	 z= 18.227},
		}
	}
}

-- Config.ShopsC = {
--     {x = -1193.16, y = -767.98, z = 17.32},
--     {x = -822.42, y = -1073.55, z = 11.33},
--     {x = 75.34, y = -1393.00, z = 29.38},
--     --{x = -709.86, y = -153.1, z = 37.42},
--     {x = -163.37, y = -302.73, z = 39.73},
--     {x = 425.59, y = -806.15, z = 29.49},
--     {x = -1450.42, y = -237.66, z = 49.81},
--     {x = 4.87, y = 6512.46, z = 31.88},
--     {x = 125.77, y = -223.9, z = 54.56},
--     {x = 1693.92, y = 4822.82, z = 42.06},
--     {x = 614.19, y = 2762.79, z = 42.09},
--     {x = 1196.61, y = 2710.25, z = 38.22},
--     {x = -3170.54, y = 1043.68, z = 20.86},
--     {x = -1101.48, y = 2710.57, z = 19.11}
-- }

-- Config.ZonesC = {}

-- for i=1, #Config.ShopsC, 1 do

-- 	Config.ZonesC['Shop_' .. i] = {
-- 	 	Pos   = Config.ShopsC[i],
-- 	 	Size  = Config.MarkerSize,
-- 	 	Color = Config.MarkerColor,
-- 	 	Type  = Config.MarkerType
--   }

-- end

ConfigTat.TextToOpenMenu = "Appuyez sur ~INPUT_CONTEXT~ pour ~g~accéder au catalogue"
ConfigTat.TextGoBackIntoMenu = "< Retour"
ConfigTat.KeyToOpenMenu = Keys["E"]
ConfigTat.MoneySymbol = "$"


Config.DrawDistanceConcess = 15.0
Config.MarkerColorConcess = {r = 102, g = 204, b = 102}
Config.EnablePlayerManagementConcess = true 
Config.EnableOwnedVehiclesConcess = false
Config.EnableSocietyOwnedVehiclesConcessConcess = false 
Config.ResellPercentage = 50
Config.LicenseEnable = false 

Config.PlateLetters = 3
Config.PlateNumbers = 3
Config.PlateUseSpace = true

Config.ZonesConcess = {
	ShopEntering = {
		Pos = {x = -31.0,  y = -1106.6,  z = 26.44-0.98},
		Size = { x = 1.2, y = 1.2, z = 0.6 },
		Type = 0
	},
	ShopInside = {
		Pos =  {x = -45.32,  y = -1097.8,  z = 26.44-0.95 },
		Size = { x = 1.5, y = 1.5, z = 1.0 },
		Heading = 248.367,
		Type = -1
	},
	ShopOutside = {
		Pos =  {x = -45.32,  y = -1097.8,  z = 26.44-0.95 },
		Size = { x = 1.5, y = 1.5, z = 1.0 },
		Heading = 248.367,
		Type = -1
	},
	BossActions = {
		Pos = { x = -32.08,  y = -1114.32,  z = 26.44-0.98},
		Size = { x = 1.0, y = 1.0, z = 0.5 },
		Type = 0
	},
--[[ 	GiveBackVehicle = {
		Pos = { x = -38.4,  y = -1100.12,  z = 26.44 },
		Size = { x = 3.0, y = 3.0, z = 1.0 },
		Type = (Config.EnablePlayerManagementConcess and 1 or -1)
	},
	ResellVehicle = {
		Pos = { x = -986.60, y = -2053.61, z = 8.40 },
		Size = { x = 3.0, y = 3.0, z = 1.0 },
		Type = 1
	} ]]
}

pedList1 = {
    'g_m_m_armboss_01',
    'g_m_m_armgoon_01',
    'g_m_y_armgoon_02',
    'ig_lestercrest_2',
    'g_m_m_armlieut_01',
    'g_m_m_chiboss_01',
    'g_m_m_chigoon_01',
    'g_m_m_chigoon_02',
    'ig_hao',
    'g_m_m_korboss_01',
    'g_m_y_korean_01',
    'g_m_y_korean_02',
    'g_m_y_korlieut_01',
    'a_m_m_ktown_01',
    'a_m_o_ktown_01',
    'a_m_y_ktown_01',
    'a_m_y_ktown_02',
    'g_m_y_azteca_01',
    'g_m_y_ballaeast_01',
    'g_m_y_ballaorig_01',
    'g_m_y_ballasout_01',
    'csb_ballasog',
    'csb_grove_str_dlr',
    'ig_g',
    'g_m_y_famca_01',
    'g_m_y_famdnf_01',
    'g_m_y_famfor_01',
    'ig_ramp_gang',
    's_m_y_dealer_01',
    'ig_claypain',
    'ig_clay',
    'g_m_y_lost_01',
    'g_m_y_lost_02',
    'g_m_y_lost_03',
    'a_m_m_mexcntry_01',
    'a_m_m_mexlabor_01',
    'g_m_m_mexboss_01',
    'g_m_m_mexboss_02',
    'g_m_y_mexgang_01',
    'g_m_y_mexgoon_01',
    'g_m_y_mexgoon_02',
    'g_m_y_mexgoon_03',
    'csb_ortega',
    'g_m_y_pologoon_01',
    'g_m_y_pologoon_02',
    'g_m_y_salvaboss_01',
    'g_m_y_salvagoon_01',
    'g_m_y_salvagoon_02',
    'g_m_y_salvagoon_03',
    'g_m_y_strpunk_01',
    'g_m_importexport_01',
    'g_m_y_strpunk_02',
    'a_m_m_indian_01',
    'a_m_y_indian_01',
    'a_m_m_tramp_01',
    'a_m_m_trampbeac_01',
    'a_m_o_soucent_01',
    'a_m_o_soucent_02',
    'a_m_m_salton_03',
    'a_m_o_soucent_03',
    'a_m_o_tramp_01',
    'a_m_m_acult_01',
    'a_m_o_acult_01',
    'a_m_o_acult_02',
    'a_m_y_acult_01',
    'a_m_y_acult_02',
    'ig_old_man1a',
    'ig_old_man2',
    'a_m_o_genstreet_01',
    'a_m_m_salton_02',
    'ig_ramp_hic',
    'csb_cletus',
    'ig_oneil',
    'a_m_y_salton_01',
    'a_m_m_hillbilly_01',
    'a_m_m_hillbilly_02',
    'a_m_m_afriamer_01',
    'a_m_m_farmer_01',
    'a_m_m_fatlatin_01',
    'a_m_m_genfat_01',
    'a_m_m_genfat_02',
    'a_m_m_polynesian_01',
    'a_m_y_downtown_01',
    'a_m_y_hippy_01',
    'u_m_y_hippie_01',
    'a_f_y_hippie_01',
    'a_f_m_ktown_01',
    'a_f_m_ktown_02',
    'a_f_o_ktown_01',
    'g_f_importexport_01',
    'g_f_y_ballas_01',
    'g_f_y_families_01',
    'g_f_y_lost_01',
    'g_f_y_vagos_01',
    's_m_y_clown_01',
    's_f_y_hooker_01',
    's_f_y_hooker_02',
    's_f_y_hooker_03',
    'csb_stripper_01',
    'csb_stripper_02',
    's_f_y_stripper_01',
    's_f_y_stripper_02',
    's_f_y_stripperlite',
    'a_f_y_topless_01',
    'u_m_m_streetart_01',
    'u_m_y_abner',
    's_f_y_airhostess_01',
    's_m_y_airworker',
    'u_m_m_aldinapoli',
    's_m_y_ammucity_01',
    'csb_anita',
    'csb_anton',
    'u_m_y_antonb',
    's_m_m_armoured_02',
    's_m_y_armymech_01',
    'ig_ashley',
    's_m_y_autopsy_01',
    's_m_m_autoshop_01',
    's_m_m_autoshop_02',
    'u_m_y_babyd',
    'ig_bankman',
    'u_m_m_bankman',
    's_m_y_barman_01',
    's_f_m_fembarber',
    'ig_barry',
    's_f_y_bartender_01',
    'u_m_y_baygor',
    's_f_y_baywatch_01',
    's_m_y_baywatch_01',
    'a_f_m_beach_01',
    'a_f_y_beach_01',
    'a_m_m_beach_01',
    'a_m_m_beach_02',
    'a_m_o_beach_01',
    'a_m_y_beach_01',
    'a_m_y_beach_02',
    'a_m_y_beach_03',
    'a_m_y_beachvesp_01',
    'a_m_y_beachvesp_02',
    'ig_bestmen',
    'ig_beverly',
    'a_f_m_bevhills_01',
    'a_f_m_bevhills_02',
    'a_f_y_bevhills_01',
    'a_f_y_bevhills_02',
    'a_f_y_bevhills_03',
    'a_f_y_bevhills_04',
    'a_m_m_bevhills_01',
    'a_m_m_bevhills_02',
    'a_m_y_bevhills_01',
    'a_m_y_bevhills_02',
    'u_m_m_bikehire_01',
    'u_f_y_bikerchic',
    's_m_y_blackops_01',
    's_m_y_blackops_02',
    'a_f_m_bodybuild_01',
    's_m_m_bouncer_01',
    'ig_brad',
    'a_m_y_breakdance_01',
    'csb_bride',
    'ig_bride',
    'csb_burgerdrug',
    'u_m_y_burgerdrug_01',
    's_m_y_busboy_01',
    'a_m_y_busicas_01',
    'a_f_m_business_02',
    'a_f_y_business_01',
    'a_f_y_business_02',
    'a_f_y_business_03',
    'a_f_y_business_04',
    'a_m_m_business_01',
    'a_m_y_business_01',
    'a_m_y_business_02',
    'a_m_y_business_03',
    's_m_o_busker_01',
    'csb_car3guy1',
    'ig_car3guy1',
    'csb_car3guy2',
    'ig_car3guy2',
    'ig_casey',
    'csb_chef',
    'ig_chef',
    's_m_y_chef_01',
    's_m_m_chemsec_01',
    'g_m_m_chemwork_01',
    'ig_chengsr',
    'csb_chin_goon',
    'u_m_y_chip',
    's_m_m_ciasec_01',
    'mp_m_claude_01',
    's_m_m_cntrybar_01',
    'u_f_y_comjane',
    's_m_y_construct_01',
    's_m_y_construct_02',
    'u_f_m_corpse_01',
    'u_f_y_corpse_01',
    'u_f_y_corpse_02',
    'csb_customer',
    'a_m_y_cyclist_01',
    'u_m_y_cyclist_01',
    'ig_dale',
    'csb_denise_friend',
    's_m_y_devinsec_01',
    'a_m_y_dhill_01',
    's_m_m_dockwork_01',
    's_m_y_dockwork_01',
    's_m_m_doctor_01',
    's_m_y_doorman_01',
    'a_f_m_downtown_01',
    'ig_dreyfuss',
    'ig_russiandrunk',
    's_m_y_dwservice_01',
    's_m_y_dwservice_02',
    'a_f_m_eastsa_01',
    'a_f_m_eastsa_02',
    'a_f_y_eastsa_01',
    'a_f_y_eastsa_02',
    'a_f_y_eastsa_03',
    'a_m_m_eastsa_01',
    'a_m_m_eastsa_02',
    'a_m_y_eastsa_01',
    'a_m_y_eastsa_02',
    'a_f_y_epsilon_01',
    'a_m_y_epsilon_01',
    'a_m_y_epsilon_02',
    'mp_m_exarmy_01',
    's_f_y_factory_01',
    's_m_y_factory_01',
    'a_f_m_fatbla_01',
    'a_f_m_fatcult_01',
    'a_f_m_fatwhite_01',
    'u_m_m_fibarchitect',
    'u_m_y_fibmugger_01',
    's_m_m_fiboffice_01',
    's_m_m_fiboffice_02',
    'mp_m_fibsec_01',
    'u_m_m_filmdirector',
    'u_m_o_finguru_01',
    's_m_y_fireman_01',
    'a_f_y_fitness_01',
    'a_f_y_fitness_02',
    'csb_fos_rep',
    'csb_g',
    's_m_m_gaffer_01',
    'csb_ramp_gang',
    's_m_y_garbage',
    's_m_m_gardener_01',
    'a_m_y_gay_01',
    'a_m_y_gay_02',
    'a_f_y_genhot_01',
    'a_f_o_genstreet_01',
    'a_m_y_genstreet_01',
    'a_m_y_genstreet_02',
    's_m_m_gentransport',
    'u_m_m_glenstank_01',
    'a_f_y_golfer_01',
    'a_m_m_golfer_01',
    'a_m_y_golfer_01',
    'u_m_m_griff_01',
    's_m_y_grip_01',
    'csb_groom',
    'ig_groom',
    'u_m_y_guido_01',
    'u_m_y_gunvend_01',
    's_m_m_hairdress_01',
    'csb_hao',
    'ig_hao',
    'a_m_m_hasjew_01',
    'a_m_y_hasjew_01',
    'csb_ramp_hic',
    's_m_m_highsec_01',
    's_m_m_highsec_02',
    'a_f_y_hiker_01',
    'a_m_y_hiker_01',
    'csb_ramp_hipster',
    'ig_ramp_hipster',
    'u_f_y_hotposh_01',
    'csb_hugh',
    'ig_hunter',
    's_m_y_hwaycop_01',
    'csb_imran',
    'a_f_o_indian_01',
    'a_f_y_indian_01',
    'ig_janet',
    'csb_janitor',
    's_m_m_janitor',    
    'u_m_m_jesus_01',
    'a_m_y_jetski_01',
    'ig_jewelass',  
    'u_f_y_jewelass_01',
    'u_m_m_jewelsec_01',
    'u_m_m_jewelthief', 
    'ig_jimmyboston',
    'ig_joeminuteman',
    'ig_johnnyklebitz',
    'ig_josef',
    'ig_josh',
    'a_f_y_juggalo_01',
    'a_m_y_juggalo_01',
    'u_m_y_justin',
    'ig_kerrymcintosh',
    'a_m_m_ktown_01',
    'a_m_o_ktown_01',
    'a_m_y_ktown_01',
    'a_m_y_ktown_02',
    's_m_m_lathandy_01',
    'a_m_y_latino_01',
    'ig_lazlow',
    'ig_lifeinvad_01',
    'ig_lifeinvad_02',
    's_m_m_lifeinvad_01',
    's_m_m_linecook',
    's_m_m_lsmetro_01',
    'ig_magenta',
    's_f_m_maid_01',
    'a_m_m_malibu_01',
    'u_m_y_mani',
    'ig_manuel',
    's_m_m_mariachi_01',
    'csb_ramp_marine',
    's_m_m_marine_01',
    's_m_m_marine_02',
    's_m_y_marine_01',
    's_m_y_marine_02',
    's_m_y_marine_03',
    'u_m_m_markfost',
    'mp_m_marston_01',
    'ig_maryann',
    'csb_maude',
    'ig_maude',
    'a_m_y_methhead_01',
    'csb_ramp_mex',
    'ig_ramp_mex',
    'a_m_y_mexthug_01',
    's_f_y_migrant_01',
    's_m_m_migrant_01',
    'u_m_y_militarybum',
    's_m_y_mime',
    'u_f_m_miranda',
    'u_f_y_mistress',
    'mp_f_misty_01',
    'ig_molly',
    'a_m_y_motox_01',
    'a_m_y_motox_02',
    'u_f_o_moviestar',
    's_f_y_movprem_01',
    's_m_m_movprem_01',
    's_m_m_movspace_01',
    'ig_mrs_thornhill',
    'ig_mrsphillips',
    'a_m_y_musclbeac_01',
    'a_m_y_musclbeac_02',
    'csb_mweather',
    'ig_natalia',
    'ig_nigel',
    'a_m_m_og_boss_01',
    'csb_oscar',
    'a_m_m_paparazzi_01',
    'u_m_y_paparazzi',
    'ig_paper',
    's_m_m_paramedic_01',
    'u_m_y_party_01',
    'u_m_m_partytarget',
    'ig_patricia',
    's_m_y_pestcont_01',
    's_m_m_pilot_01',
    's_m_m_pilot_02',
    's_m_y_pilot_01',
    'u_m_y_pogo_01',
    'a_m_y_polynesian_01',
    'u_f_y_poppymich',
    'csb_porndudes',
    's_m_m_postal_01',
    's_m_m_postal_02',
    'ig_priest',
    'u_f_y_princess',
    's_m_m_prisguard_01',
    's_m_y_prismuscl_01',
    's_m_y_prisoner_01',
    'u_m_y_proldriver_01',
    'a_f_m_prolhost_01',
    'a_m_m_prolhost_01',
    'u_f_o_prolhost_01',
    'csb_prologuedriver',
    'csb_prolsec',
    'ig_prolsec_02',
    'u_m_m_prolsec_01',
    'u_f_m_promourn_01',
    'u_m_m_promourn_01',
    'mp_g_m_pros_01',
    's_f_y_ranger_01',
    's_m_y_ranger_01',
    'csb_reporter',
    'u_m_m_rivalpap',
    'a_m_y_roadcyc_01',
    's_m_y_robber_01',
    'csb_roccopelosi',
    'ig_roccopelosi',
    'u_m_y_rsranger_01',
    'a_f_y_runner_01',
    'a_m_y_runner_01',
    'a_m_y_runner_02',
    'a_f_y_rurmeth_01',
    'a_m_m_rurmeth_01',
    'a_f_m_salton_01',
    'a_f_o_salton_01',
    'a_m_m_salton_01',
    'a_m_m_salton_04',
    'a_m_o_salton_01',
    'u_m_y_sbike',
    'a_f_y_scdressy_01',
    's_m_m_scientist_01',
    'csb_screen_writer',
    'ig_screen_writer',
    's_f_y_scrubs_01',
    's_m_m_security_01',
    's_f_m_shop_high',
    's_f_y_shop_low',
    's_m_y_shop_mask',
    's_f_y_shop_mid',
    'a_f_y_skater_01',
    'a_m_m_skater_01',
    'a_m_y_skater_01',
    'a_m_y_skater_02',
    'a_f_m_skidrow_01',
    'a_m_m_skidrow_01',
    's_m_m_snowcop_01',
    'a_m_m_socenlat_01',
    'a_f_m_soucent_01',
    'a_f_m_soucent_02',
    'a_f_o_soucent_01',
    'a_f_o_soucent_02',
    'a_f_y_soucent_01',
    'a_f_y_soucent_02',
    'a_f_y_soucent_03',
    'a_m_m_soucent_01',
    'a_m_m_soucent_02',
    'a_m_m_soucent_03',
    'a_m_m_soucent_04',
    'a_m_y_soucent_01',
    'a_m_y_soucent_02',
    'a_m_y_soucent_03',
    'a_m_y_soucent_04',
    'a_f_m_soucentmc_01',
    'u_m_m_spyactor',
    'u_f_y_spyactress',
    'u_m_y_staggrm_01',
    'a_m_y_stbla_01',
    'a_m_y_stbla_02',
    'a_m_m_stlat_02',
    'a_m_y_stlat_01',
    'cs_stretch',
    's_m_m_strperf_01',
    's_m_m_strpreach_01',
    's_m_m_strvend_01',
    's_m_y_strvend_01',
    'a_m_y_stwhi_01',
    'a_m_y_stwhi_02',
    'a_m_y_sunbathe_01',
    'a_m_y_surfer_01',
    's_m_y_swat_01',
    's_f_m_sweatshop_01',
    's_f_y_sweatshop_01',
    'ig_talina',
    'ig_tanisha',
    'u_m_o_taphillbilly',
    'u_m_y_tattoo_01',
    'a_f_y_tennis_01',
    'a_m_m_tennis_01',
    'ig_terry',
    'ig_tomepsilon',
    'csb_tonya',
    'ig_tonya',
    'a_f_m_tourist_01',
    'a_f_y_tourist_01',
    'a_f_y_tourist_02',
    'a_m_m_tourist_01',
    'csb_trafficwarden',
    'ig_trafficwarden',
    'a_f_m_tramp_01',
    'u_m_o_tramp_01',
    'a_f_m_trampbeac_01',
    's_m_m_trucker_01',
    'ig_tylerdix',
    's_m_m_ups_01',
    's_m_m_ups_02',
    's_m_y_uscg_01',
    's_m_y_valet_01',
    'a_m_y_vindouche_01',
    'a_f_y_vinewood_01',
    'a_f_y_vinewood_02',
    'a_f_y_vinewood_03',
    'a_f_y_vinewood_04',
    'a_m_y_vinewood_01',
    'a_m_y_vinewood_02',
    'a_m_y_vinewood_03',
    'a_m_y_vinewood_04',
    's_m_y_waiter_01',
    'u_m_m_willyfist',
    's_m_y_winclean_01',
    's_m_y_xmech_01',
    'a_f_y_yoga_01',
    'a_m_y_yoga_01',
    'ig_zimbor',
    'u_m_y_prisoner_01',
    'mp_f_boatstaff_01',
    'mp_m_boatstaff_01',
    'ig_chef2',
    'csb_chef2',
    'csb_agent',
    'ig_benny',
    's_m_y_blackops_03',
    's_m_m_ccrew_01',
    'u_m_m_doa_01',
    'u_f_m_drowned_01',
    'u_m_m_edtoh',
    'mp_f_execpa_01',
    'mp_m_execpa_01',
    's_m_m_fibsec_01',
    'u_m_o_filmnoir',
    'mp_f_helistaff_01',
    'csb_jackhowitzer',
    'csb_money',
    'ig_money',
    'csb_paige',
    'ig_paige',
    'csb_popov',
    'ig_popov',
    'csb_rashcosvki',
    'ig_rashcosvki',
    'csb_undercover',
    'mp_m_g_vagfun_01',
    'csb_vagspeak',
    'ig_vagspeak',
    'mp_f_chbar_01',
    'mp_f_cocaine_01',
    'mp_f_counterfeit_01',
    'mp_f_forgery_01',
    'mp_f_meth_01',
    'mp_f_weed_01',
    'ig_malc',
    'mp_m_cocaine_01',
    'mp_m_counterfeit_01',
    'mp_m_forgery_01',
    'mp_m_meth_01',
    'mp_m_weed_01',
    's_m_y_xmech_02_mp',
    'mp_f_cardesign_01',
    'csb_avon',
    'csb_bogdan',
    'csb_mrs_r',
    'ig_avon',
    'ig_lestercrest_2',
    'mp_f_execpa_02',
    'mp_m_avongoon',
    'mp_m_bogdangoon',
    'mp_m_securoguard_01',
    'mp_m_waremech_01',
    'mp_m_weapexp_01',
    'mp_m_weapwork_01',
    'u_m_y_corpse_01',
    'u_m_y_juggernaut_01',
    'u_m_y_smugmech_01',
    'ig_bankmann',
    'LioMessiCiv',
    'JokerSuicideSquad',
    'HarleySS',
    'therock(jeans)',
    'mp_m_niko_01',
    'mp_m_famdd_01',
}

config = {}
Config.Locale = 'fr'
Config.EnableESXIdentity = false
Config.MaxSalary = 1000

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

Config.RequiredCopsSelldrugs  = 0

Config.RequiredCopsCoke  = 0
Config.RequiredCopsMeth  = 0
Config.RequiredCopsWeed  = 0
Config.RequiredCopsTerre = 0

Config.TimeToFarm    = 1 * 850
Config.TimeToProcess = 1 * 10000
Config.TimeToSell    = 3 * 850

Config.Locales = 'fr'

Config.Zones = {
	CokeField =			{x = -314.08,  y = 2995.8,  z = 23.96,		sprite = 501,	color = 40},
	AcideField =		{x = 419.36,  y = 62.4,  z = 97.96,		sprite = 501,	color = 40},

	MethField =			{x = -113.24,  y = 6367.16,  z = 31.48,		sprite = 499,	color = 26},
    AntigelField =		{x = 2760.32,  y = 1487.0,  z = 24.52,		sprite = 501,	color = 40},
    
    CokeField =			{x = -314.08,  y = 2995.8,  z = 23.96,		sprite = 501,	color = 40},
	AcideField =		{x = 419.36,  y = 62.4,  z = 97.96,		sprite = 501,	color = 40},

	WeedField =		    {x = 1003.2,  y = -2411.44,  z = 30.52,		sprite = 496,	color = 52}
}

Config.Shopkeeper = 416176080
Config.Locale = 'fr'

Config.Shops = {
    {coords = vector3(24.03, -1345.63, 29.5-0.98), heading = 266.0,  cops = 2, blip = true, name = 'Apu', cooldown = {hour = 0, minute = 30, second = 0}, robbed = false},
    {coords = vector3(1164.94, -323.76, 68.2-0.98), heading = 100.0,  cops = 2, blip = true, name = 'Apu', cooldown = {hour = 0, minute = 30, second = 0}, robbed = false},
    {coords = vector3(372.85, 328.10, 102.56-0.98), heading = 266.0,  cops = 2, blip = true, name = 'Apu', cooldown = {hour = 0, minute = 30, second = 0}, robbed = false},
    {coords = vector3(1134.24, -983.14, 45.41-0.98), heading = 266.0,  cops = 2, blip = true, name = 'Apu', cooldown = {hour = 0, minute = 30, second = 0}, robbed = false},
    {coords = vector3(-1221.40, -908.02, 11.32-0.98), heading = 40.0,  cops = 2, blip = true, name = 'Apu', cooldown = {hour = 0, minute = 30, second = 0}, robbed = false},
    {coords = vector3(-47.39, -1758.72, 28.42-0.98), heading = 40.0,  cops = 2, blip = true, name = 'Apu', cooldown = {hour = 0, minute = 30, second = 0}, robbed = false},
    {coords = vector3(1728.62, 6416.81, 34.03-0.98), heading = 240.0,  cops = 2, blip = true, name = 'Apu', cooldown = {hour = 0, minute = 30, second = 0}, robbed = false},
    --{coords = vector3(1984.41, 3054.70, 46.21-0.98), heading = 290.0,  cops = 2, blip = true, name = 'Apu', cooldown = {hour = 0, minute = 30, second = 0}, robbed = false},
    {coords = vector3(1696.92, 4923.68, 42.08-0.98), heading = 324.10,  cops = 2, blip = true, name = 'Apu', cooldown = {hour = 0, minute = 30, second = 0}, robbed = false},
    {coords = vector3(162.16, 6636.64, 31.56-0.98), heading = 135.19,  cops = 2, blip = true, name = 'Apu', cooldown = {hour = 0, minute = 30, second = 0}, robbed = false},
	{coords = vector3(-2966.37, 391.57, 15.04-0.98), heading = 100.0,  cops = 2, blip = true, name = 'Apu', cooldown = {hour = 0, minute = 30, second = 0}, robbed = false},
	{coords = vector3(-1486.64,-377.6, 40.16-0.98), heading = 140.12,  cops = 2, blip = true, name = 'Apu', cooldown = {hour = 0, minute = 30, second = 0}, robbed = false},
	{coords = vector3(-1820.52, 794.6,138.08-0.98), heading = 131.01,  cops = 2, blip = true, name = 'Apu', cooldown = {hour = 0, minute = 30, second = 0}, robbed = false}
}

Translation = {
    ['fr'] = {
        ['shopkeeper'] = 'Vendeur',
        ['robbed'] = 'Je viens de me faire braquer et je n\'ai plus d\'argent restant',
        ['cashrecieved'] = 'Vous avez recu :',
        ['currency'] = '$',
        ['scared'] = 'Peur:',
        ['no_cops'] = 'Je viens de me faire braquer et je n\'ai plus d\'argent restant',
        ['cop_msg'] = 'Une personne est entreint de Braquer Apu !',
        ['set_waypoint'] = 'Mettre un point vers le magasin',
        ['hide_box'] = 'Refuser l\'appel',
        ['robbery'] = 'Braquage en cours',
        ['walked_too_far'] = 'Vous etes partis trop loin du magasin'
    }
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

config.Vehicles = {
    'police',
    'newvic',
    '11caprice',
    'lspd1',
    'lspd2',
    'lspd3',
    'fbi3',
    '1200RTP',
    '16explorer',
    '16taurus',
    '18charger',
    '19durango',
    'pitbull',
    'so3',
    'so2',
    'so4',
    'so1',
    'so5',
    'so13',
    'police2',
    'police3',
    'police4',
    'fbi',
    'fbi2',
    'riot2',
    'policet',
    'sheriff',
    'sheriff2',
    'riot',
    'pranger',
    'polschafter3',
    'lapd',
    'lapd2',
    'lapd3',
    'lapd4',
    'lapd5',
    'lapd6',
    '14charger',
    'newvic',
    '16explorer',
    'county12',
    'county13',
    'county2',
    'county17',
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
  
  
  Config.EnableInventoryHUD = false
  Config.ReloadTime = 1000 --ms
  
  Config.Ammo = {
      {
          name = 'disc_ammo_pistol',
          weapons = {
              `WEAPON_PISTOL`,
              `WEAPON_SNSPISTOL`,
              `WEAPON_REVOLVER`,
              `WEAPON_FLAREGUN`,
              `WEAPON_FIREWORK`,
              `WEAPON_VINTAGEPISTOL`
          },
          count = 1
      },
      {
          name = 'flare',
          weapons = {
              `WEAPON_FLAREGUN`
          },
          count = 1
      },
      {
          name = 'disc_ammo_pistol_large',
          weapons = {
              `WEAPON_APPISTOL`,
              `WEAPON_COMBATPISTOL`,
              `WEAPON_HEAVYPISTOL`,
              `WEAPON_MARKSMANPISTOL`,
              `WEAPON_PISTOL50`,
              `WEAPON_MICROSMG`,
              `WEAPON_MINISMG`,
              `WEAPON_MACHINEPISTOL`
          },
          count = 1
      },
      {
          name = 'disc_ammo_shotgun',
          weapons = {
          `WEAPON_MUSKET`,
          `WEAPON_DBSHOTGUN`,
          `WEAPON_HEAVYSHOTGUN`,
          `WEAPON_PUMPSHOTGUN`,
          `WEAPON_SAWNOFFSHOTGUN`,
          `WEAPON_ASSAULTSHOTGUN`,
          `WEAPON_AUTOSHOTGUN`,
          `WEAPON_BULLPUPSHOTGUN`
          },
          count = 1
      },
      {
          name = 'disc_ammo_shotgun_large',
          weapons = {
          `WEAPON_MUSKET`,
          `WEAPON_DBSHOTGUN`,
          `WEAPON_HEAVYSHOTGUN`,
          `WEAPON_PUMPSHOTGUN`,
          `WEAPON_SAWNOFFSHOTGUN`,
          `WEAPON_ASSAULTSHOTGUN`,
          `WEAPON_AUTOSHOTGUN`,
          `WEAPON_BULLPUPSHOTGUN`
          },
          count = 1
      },
      {
          name = 'disc_ammo_smg',
          weapons = {
              `WEAPON_ASSAULTSMG`,
              `WEAPON_COMBATPDW`,
              `WEAPON_SMG`
          },
          count = 1
      },
      {
          name = 'disc_ammo_smg_large',
          weapons = {
              `WEAPON_ASSAULTSMG`,
          },
          count = 1
      },
      {
          name = 'disc_ammo_rifle',
          weapons = {
              `WEAPON_ADVANCEDRIFLE`,
              `WEAPON_BULLPUPRIFLE`,
              `WEAPON_CARBINERIFLE`
          },
          count = 1
      },
      {
          name = 'disc_ammo_rifle_large',
          weapons = {
          `WEAPON_ASSAULTRIFLE`,
          `WEAPON_COMPACTRIFLE`,
          `WEAPON_MG`,
          `WEAPON_COMBATMG`,
          `WEAPON_GUSENBERG`,
          `WEAPON_SPECIALCARBINE`
          },
          count = 1
      },
      {
          name = 'disc_ammo_snp',
          weapons = {
          `WEAPON_SNIPERRIFLE`,
          `WEAPON_HEAVYSNIPER`,
          `WEAPON_MARKSMANRIFLE`
          },
          count = 1
      },
      {
          name = 'disc_ammo_snp_large',
          weapons = {
          `WEAPON_SNIPERRIFLE`,
          `WEAPON_HEAVYSNIPER`,
          `WEAPON_MARKSMANRIFLE`
          },
          count = 1
      }
  }
  
  Config.Zones = {
      posfarm =   {x = 1509.76,  y = 1791.24,  z = 108.92,		sprite = 501,	color = 40},
      posfarm2 =	{x = -6.28,  y = 6486.84,  z = 31.48,	sprite = 478,	color = 40}
  }
  -------------------------------------------------------------
  ------ SET TO FALSE UNLESS YOU KNOW WHAT YOU'RE DOING -------
  -------------------------------------------------------------
  
  Config.EnableDev = true
  
  -- UNLESS YOU HAVE A BETTER WAY, I ADVICE YOU TO JUST EDIT THE SERVER SIDE
  Config.GetPlayerMoney = function(action)
      TriggerServerEvent("atm:handlingMoney", action)
  end
  
  Config.MoneyLevel = { ---DO NOT TOUCH TO THE KEY ENTRIES | "MAX" IS IF YOU ANT TO BE ABLE TO DEPOSIT ALL THE CASH
      [1] = 10, 
      [2] = 100,
      [3] = 1000,
      [5] = 5000,
      [6] = 10000,
      [7] = "max"
      
  }
  
  Config.ATM = {
      [0] = { -- Withdraw
          action = function(amount)
              -- UNLESS YOU HAVE A BETTER WAY, I ADVICE YOU TO JUST EDIT THE SERVER SIDE
              TriggerServerEvent("atm:handlingMoney", "withdraw", amount)
  
          end
      },
      [1] = { -- Deposit
          action = function(amount)
              -- UNLESS YOU HAVE A BETTER WAY, I ADVICE YOU TO JUST EDIT THE SERVER SIDE
              TriggerServerEvent("atm:handlingMoney", "deposit", amount)
  
          end
      },
  
  }
  
  Config.ATMBlip = {
      vector3(527.7776,-160.6609,56.13671),
      vector3(285.3485,142.9751,103.1623),
      vector3(-846.6537,-341.509,37.6685),
      vector3(-847.204,-340.4291,37.6793),
      vector3(-720.6288,-415.5243,33.97996),
      vector3(-1410.736,-98.92789,51.39701),
      vector3(-1410.183,-100.6454,51.39652),
      vector3(-712.9357,-818.4827,22.74066),
      vector3(-710.0828,-818.4756,22.73634),
      vector3(-660.6763,-854.4882,23.45663),
      vector3(-594.6144,-1160.852,21.33351),
      vector3(-596.1251,-1160.85,21.3336),
      vector3(-821.8936,-1081.555,10.13664),
      vector3(156.1886,6643.2,30.59372),
      vector3(173.8246,6638.217,30.59372),
      vector3(-282.7141,6226.43,30.49648),
      vector3(-95.87029,6457.462,30.47394),
      vector3(-97.63721,6455.732,30.46793),
      vector3(-132.6663,6366.876,30.47258),
      vector3(-386.4596,6046.411,30.47399),
      vector3(24.5933,-945.543,28.33305),
      vector3(5.686035,-919.9551,28.48088),
      vector3(296.1756,-896.2318,28.29015),
      vector3(296.8775,-894.3196,28.26148),
      vector3(1137.811,-468.8625,65.69865),
      vector3(1167.06,-455.6541,65.81857),
      vector3(1077.779,-776.9664,57.25652),
      vector3(289.53,-1256.788,28.44057),
      vector3(289.2679,-1282.32,28.65519),
      vector3(-1569.84,-547.0309,33.93216),
      vector3(-1570.765,-547.7035,33.93216),
      vector3(-1305.708,-706.6881,24.31447),
      vector3(-2071.928,-317.2862,12.31808),
      vector3(-2295.853,357.9348,173.6014),
      vector3(-2295.069,356.2556,173.6014),
      vector3(-2294.3,354.6056,173.6014),
      vector3(2558.324,350.988,107.5975),
  
      vector3(-1044.466,-2739.641,8.12406),
      vector3(-1091.887,2709.053,17.91941),
      vector3(-3144.887,1127.811,19.83804),
      vector3(1822.971,3682.577,33.26745),
      vector3(228.0324,337.8501,104.5013),
      vector3(158.7965,234.7452,105.6433),
      vector3(-57.17029,-92.37918,56.75069),
      vector3(357.1284,174.0836,102.0597),
      vector3(-1415.48,-212.3324,45.49542),
      vector3(-1430.663,-211.3587,45.47162),
      vector3(-1282.098,-210.5599,41.43031),
      vector3(-1286.704,-213.7827,41.43031),
      vector3(-1289.742,-227.165,41.43031),
      vector3(-1285.136,-223.9422,41.43031),
      vector3(-1110.228,-1691.154,3.378483),
      vector3(2564,2584.553,37.06807),
      vector3(1171.523,2703.139,37.1477),
      vector3(1172.457,2703.139,37.1477),
      vector3(1687.395,4815.9,41.00647),
      vector3(1700.694,6426.762,31.63297),
  
      vector3(89.81339,2.880325,67.35214),
      vector3(-867.013,-187.9928,36.88218),
      vector3(-867.9745,-186.3419,36.88218),
      vector3(-617.8035,-708.8591,29.04321),
      vector3(-617.8035,-706.8521,29.04321),
      vector3(-614.5187,-705.5981,30.224),
      vector3(-611.8581,-705.5981,30.224),
      vector3(-537.8052,-854.9357,28.27543),
      vector3(-526.7791,-1223.374,17.45272),
      vector3(-165.5844,234.7659,93.92897),
      vector3(-165.5844,232.6955,93.92897),
      vector3(-301.6573,-829.5886,31.41977),
      vector3(-303.2257,-829.3121,31.41977),
      vector3(-204.0193,-861.0091,29.27133),
      vector3(118.6416,-883.5695,30.13945),
      vector3(112.4761,-819.808,30.33955),
      vector3(111.3886,-774.8401,30.43766),
      vector3(114.5474,-775.9721,30.41736),
      vector3(-256.6386,-715.8898,32.7883),
      vector3(-259.2767,-723.2652,32.70155),
      vector3(-254.5219,-692.8869,32.57825),
      vector3(-27.89034,-724.1089,43.22287),
      vector3(-30.09957,-723.2863,43.22287),
      vector3(-1315.416,-834.431,15.95233),
      vector3(-1314.466,-835.6913,15.95233),
      vector3(-2956.848,487.2158,14.478),
      vector3(-2958.977,487.3071,14.478),
      vector3(-2974.586,380.1269,14),
      vector3(-3043.835,594.1639,6.732796),
      vector3(-3241.455,997.9085,11.54837),
  
      vector3(147.4731,-1036.218,28.36778),
      vector3(145.8392,-1035.625,28.36778),
      vector3(-1205.378,-326.5286,36.85104),
      vector3(-1206.142,-325.0316,36.85104),
      
  }

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

pedList = {
    --Gang Male
    'g_m_importexport_01',
    'g_m_m_armboss_01',
    'g_m_m_armgoon_01',
    'g_m_m_armlieut_01',
    'g_m_m_chemwork_01',
    'g_m_m_chiboss_01',
    'g_m_m_chicold_01',
    'g_m_m_chigoon_01',
    'g_m_m_chigoon_02',
    'g_m_m_korboss_01',
    'g_m_m_mexboss_01',
    'g_m_m_mexboss_02',
    'g_m_y_armgoon_02',
    'g_m_y_azteca_01',
    'g_m_y_ballaeast_01',
    'g_m_y_ballaorig_01',
    'g_m_y_ballasout_01',
    'g_m_y_famca_01',
    'g_m_y_famdnf_01',
    'g_m_y_famfor_01',
    'g_m_y_korean_01',
    'g_m_y_korean_02',
    'g_m_y_korlieut_01',
    'g_m_y_lost_01',
    'g_m_y_lost_02',
    'g_m_y_lost_03',
    'g_m_y_mexgang_01',
    'g_m_y_mexgoon_01',
    'g_m_y_mexgoon_02',
    'g_m_y_mexgoon_03',
    'g_m_y_pologoon_01',
    'g_m_y_pologoon_02',
    'g_m_y_salvaboss_01',
    'g_m_y_salvagoon_01',
    'g_m_y_salvagoon_02',
    'g_m_y_salvagoon_03',
    'g_m_y_strpunk_01',
    'g_m_y_strpunk_02',
    --Gang Female
    'g_f_importexport_01',
    'g_f_y_ballas_01',
    'g_f_y_families_01',
    'g_f_y_lost_01',
    'g_f_y_vagos_01',
    --Multiplayer
    'mp_f_bennymech_01',
    'mp_f_boatstaff_01',
    'mp_f_cardesign_01',
    'mp_f_chbar_01',
    'mp_f_counterfeit_01',
    'mp_f_forgery_01',
    'mp_f_helistaff_01',
    'mp_f_weed_01',
    'mp_g_m_pros_01',
    'mp_m_boatstaff_01',
    'mp_m_counterfeit_01',
    'mp_m_exarmy_01',
    'mp_m_forgery_01',
    'mp_m_g_vagfun_01',
    'mp_m_waremech_01',
    'mp_m_weapexp_01',
    'mp_m_weapwork_01',
    'mp_m_weed_01',
    --Scenario female
    's_f_m_fembarber',
    's_f_m_maid_01',
    's_f_m_sweatshop_01',
    's_f_y_airhostess_01',
    's_f_y_bartender_01',
    's_f_y_clubbar_01',
    's_f_y_hooker_01',
    's_f_y_hooker_02',
    's_f_y_hooker_03',
    's_f_y_migrant_01',
    's_f_y_movprem_01',
    's_f_y_scrubs_01',
    's_f_y_shop_low',
    's_f_y_shop_mid',
    's_f_y_stripper_01',
    's_f_y_stripper_02',
    's_f_y_sweatshop_01',
    's_f_y_casino_01',
    --Scenario male
    's_m_m_ammucountry',
    's_m_m_autoshop_01',
    's_m_m_autoshop_02',
    's_m_m_bouncer_01',
    's_m_m_ccrew_01',
    's_m_m_cntrybar_01',
    's_m_m_dockwork_01',
    's_m_m_doctor_01',
    's_m_m_fiboffice_01',
    's_m_m_fiboffice_02',
    's_m_m_gaffer_01',
    's_m_m_gardener_01',
    's_m_m_gentransport',
    's_m_m_hairdress_01',
    's_m_m_highsec_01',
    's_m_m_highsec_02',
    's_m_m_janitor',
    's_m_m_lathandy_01',
    's_m_m_lifeinvad_01',
    's_m_m_linecook',
    's_m_m_lsmetro_01',
    's_m_m_mariachi_01',
    's_m_m_migrant_01',
    's_m_m_movprem_01',
    's_m_m_paramedic_01',
    's_m_m_postal_01',
    's_m_m_postal_02',
    's_m_m_scientist_01',
    's_m_m_strpreach_01',
    's_m_m_strvend_01',
    's_m_m_trucker_01',
    's_m_m_ups_01',
    's_m_m_ups_02',
    's_m_o_busker_01',
    's_m_y_airworker',
    's_m_y_ammucity_01',
    's_m_y_armymech_01',
    's_m_y_autopsy_01',
    's_m_y_barman_01',
    's_m_y_busboy_01',
    's_m_y_chef_01',
    's_m_y_clown_01',
    's_m_y_clubbar_01',
    's_m_y_construct_01',
    's_m_y_construct_02',
    's_m_y_dealer_01',
    's_m_y_devinsec_01',
    's_m_y_dockwork_01',
    's_m_y_doorman_01',
    's_m_y_dwservice_01',
    's_m_y_dwservice_02',
    's_m_y_garbage',
    's_m_y_grip_01',
    's_m_y_mime',
    's_m_y_prismuscl_01',
    's_m_y_prisoner_01',
    's_m_y_robber_01',
    's_m_y_shop_mask',
    's_m_y_strvend_01',
    's_m_y_valet_01',
    's_m_y_waiter_01',
    's_m_y_waretech_01',
    's_m_y_winclean_01',
    's_m_y_xmech_02',
    --Story
    'ig_abigail',
    'ig_ashley',
    'ig_avon',
    'ig_bankman',
    'ig_barry',
    'ig_benny',
    'ig_bestmen',
    'ig_beverly',
    'ig_bride',
    'ig_car3guy1',
    'ig_car3guy2',
    'ig_chengsr',
    'ig_clay',
    'ig_claypain',
    'ig_cletus',
    'ig_dale',
    'ig_dix',
    'ig_djblamadon',
    'ig_djblamrupert',
    'ig_djblamryans',
    'ig_djdixmanager',
    'ig_djgeneric_01',
    'ig_djsolfotios',
    'ig_djsoljakob',
    'ig_djsolmanager',
    'ig_djsolmike',
    'ig_djsolrobt',
    'ig_djtalaurelia',
    'ig_djtalignazio',
    'ig_dreyfuss',
    'ig_englishdave',
    'ig_fbisuit_01',
    'ig_g',
    'ig_groom',
    'ig_hao',
    'ig_janet',
    'ig_jewelass',
    'ig_jimmyboston',
    'ig_jimmyboston_02',
    'ig_joeminuteman',
    'ig_josef',
    'ig_josh',
    'ig_kerrymcintosh',
    'ig_kerrymcintosh_02',
    'ig_lacey_jones_02',
    'ig_lazlow_2',
    'ig_lestercrest_2',
    'ig_lifeinvad_01',
    'ig_lifeinvad_02',
    'ig_magenta',
    'ig_malc',
    'ig_manuel',
    'ig_marnie',
    'ig_maryann',
    'ig_maude',
    'ig_money',
    'ig_mrs_thornhill',
    'ig_mrsphillips',
    'ig_natalia',
    'ig_nigel',
    'ig_old_man1a',
    'ig_old_man2',
    'ig_oneil',
    'ig_ortega',
    'ig_paige',
    'ig_paper',
    'ig_popov',
    'ig_priest',
    'csb_ramp_gang',
    'ig_ramp_hic',
    'ig_ramp_hipster',
    'ig_ramp_mex',
    'ig_rashcosvki',
    'ig_roccopelosi',
    'ig_russiandrunk',
    'ig_sacha',
    'ig_screen_writer',
    'ig_sol',
    'ig_talcc',
    'ig_talina',
    'ig_talmm',
    'ig_tanisha',
    'ig_terry',
    'ig_tomepsilon',
    'ig_tonya',
    'ig_tonyprince',
    'ig_tylerdix',
    'ig_tylerdix_02',
    'ig_vagspeak',
    'ig_zimbor',
    --Story scenario female
    'u_f_m_miranda',
    'u_f_m_miranda_02',
    'u_f_m_promourn_01',
    'u_f_o_moviestar',
    'u_f_o_prolhost_01',
    'u_f_y_bikerchic',
    'u_f_y_comjane',
    'u_f_y_danceburl_01',
    'u_f_y_dancelthr_01',
    'u_f_y_dancerave_01',
    'u_f_y_hotposh_01',
    'u_f_y_jewelass_01',
    'u_f_y_mistress',
    'u_f_y_poppymich',
    'u_f_y_poppymich_02',
    'u_f_y_princess',
    'u_f_y_spyactress',
    --Story scenario male
    'u_m_m_aldinapoli',
    'u_m_m_bankman',
    'u_m_m_bikehire_01',
    'u_m_m_doa_01',
    'u_m_m_edtoh',
    'u_m_m_fibarchitect',
    'u_m_m_filmdirector',
    'u_m_m_glenstank_01',
    'u_m_m_griff_01',
    'u_m_m_jesus_01',
    'u_m_m_jewelsec_01',
    'u_m_m_jewelthief',
    'u_m_m_markfost',
    'u_m_m_partytarget',
    'u_m_m_promourn_01',
    'u_m_m_rivalpap',
    'u_m_m_spyactor',
    'u_m_m_willyfist',
    'u_m_o_finguru_01',
    'u_m_o_taphillbilly',
    'u_m_o_tramp_01',
    'u_m_y_abner',
    'u_m_y_antonb',
    'u_m_y_baygor',
    'u_m_y_burgerdrug_01',
    'u_m_y_chip',
    'u_m_y_cyclist_01',
    'u_m_y_babyd',
    'u_m_y_danceburl_01',
    'u_m_y_dancelthr_01',
    'u_m_y_dancerave_01',
    'u_m_y_fibmugger_01',
    'u_m_y_guido_01',
    'u_m_y_gunvend_01',
    'u_m_y_hippie_01',
    'u_m_y_imporage',
    'u_m_y_justin',
    'u_m_y_mani',
    'u_m_y_militarybum',
    'u_m_y_paparazzi',
    'u_m_y_party_01',
    'u_m_y_prisoner_01',
    'u_m_y_sbike',
    'u_m_y_smugmech_01',
    'u_m_y_staggrm_01',
    'u_m_y_tattoo_01',
    --Cutscene
    'csb_grove_str_dlr',
    'csb_hugh',
    'csb_imran',
    'csb_jackhowitzer',
    'csb_janitor',
    'csb_mrs_r',
    'csb_oscar',
    'csb_porndudes',
    'csb_undercover',
    --Ambient female
    'a_f_m_beach_01',
    'a_f_m_bevhills_01',
    'a_f_m_bevhills_02',
    'a_f_m_business_02',
    'a_f_m_downtown_01',
    'a_f_m_eastsa_01',
    'a_f_m_eastsa_02',
    'a_f_m_fatbla_01',
    'a_f_m_fatcult_01',
    'a_f_m_fatwhite_01',
    'a_f_m_ktown_01',
    'a_f_m_ktown_02',
    'a_f_m_prolhost_01',
    'a_f_m_salton_01',
    'a_f_m_skidrow_01',
    'a_f_m_soucent_01',
    'a_f_m_soucent_02',
    'a_f_m_soucentmc_01',
    'a_f_m_tourist_01',
    'a_f_m_tramp_01',
    'a_f_m_trampbeac_01',
    'a_f_o_genstreet_01',
    'a_f_o_indian_01',
    'a_f_o_ktown_01',
    'a_f_o_salton_01',
    'a_f_o_soucent_01',
    'a_f_o_soucent_02',
    'a_f_y_beach_01',
    'a_f_y_bevhills_01',
    'a_f_y_bevhills_02',
    'a_f_y_bevhills_03',
    'a_f_y_bevhills_04',
    'a_f_y_business_01',
    'a_f_y_business_02',
    'a_f_y_business_03',
    'a_f_y_business_04',
    'a_f_y_clubcust_01',
    'a_f_y_clubcust_02',
    'a_f_y_clubcust_03',
    'a_f_y_eastsa_01',
    'a_f_y_eastsa_02',
    'a_f_y_eastsa_03',
    'a_f_y_epsilon_01',
    'a_f_y_femaleagent',
    'a_f_y_fitness_01',
    'a_f_y_fitness_02',
    'a_f_y_genhot_01',
    'a_f_y_golfer_01',
    'a_f_y_hiker_01',
    'a_f_y_hippie_01',
    'a_f_y_hipster_01',
    'a_f_y_hipster_02',
    'a_f_y_hipster_03',
    'a_f_y_hipster_04',
    'a_f_y_indian_01',
    'a_f_y_juggalo_01',
    'a_f_y_runner_01',
    'a_f_y_rurmeth_01',
    'a_f_y_scdressy_01',
    'a_f_y_skater_01',
    'a_f_y_soucent_01',
    'a_f_y_soucent_02',
    'a_f_y_soucent_03',
    'a_f_y_tennis_01',
    'a_f_y_topless_01',
    'a_f_y_tourist_01',
    'a_f_y_tourist_02',
    'a_f_y_vinewood_01',
    'a_f_y_vinewood_02',
    'a_f_y_vinewood_03',
    'a_f_y_vinewood_04',
    'a_f_y_yoga_01',
    'a_m_m_acult_01',
    'a_m_m_afriamer_01',
    'a_m_m_beach_01',
    'a_m_m_beach_02',
    'a_m_m_bevhills_01',
    'a_m_m_bevhills_02',
    'a_m_m_business_01',
    'a_m_m_eastsa_01',
    'a_m_m_eastsa_02',
    'a_m_m_farmer_01',
    'a_m_m_fatlatin_01',
    'a_m_m_genfat_01',
    'a_m_m_genfat_02',
    'a_m_m_golfer_01',
    'a_m_m_hasjew_01',
    'a_m_m_hillbilly_01',
    'a_m_m_hillbilly_02',
    'a_m_m_indian_01',
    'a_m_m_ktown_01',
    'a_m_m_malibu_01',
    'a_m_m_mexcntry_01',
    'a_m_m_mexlabor_01',
    'a_m_m_og_boss_01',
    'a_m_m_paparazzi_01',
    'a_m_m_polynesian_01',
    'a_m_m_prolhost_01',
    'a_m_m_rurmeth_01',
    'a_m_m_salton_01',
    'a_m_m_salton_02',
    'a_m_m_salton_03',
    'a_m_m_salton_04',
    'a_m_m_skater_01',
    'a_m_m_skidrow_01',
    'a_m_m_socenlat_01',
    'a_m_m_soucent_01',
    'a_m_m_soucent_02',
    'a_m_m_soucent_03',
    'a_m_m_soucent_04',
    'a_m_m_stlat_02',
    'a_m_m_tennis_01',
    'a_m_m_tourist_01',
    'a_m_m_tramp_01',
    'a_m_m_trampbeac_01',
    'a_m_m_tranvest_01',
    'a_m_m_tranvest_02',
    'a_m_o_acult_01',
    'a_m_o_acult_02',
    'a_m_o_beach_01',
    'a_m_o_genstreet_01',
    'a_m_o_ktown_01',
    'a_m_o_salton_01',
    'a_m_o_soucent_01',
    'a_m_o_soucent_02',
    'a_m_o_soucent_03',
    'a_m_o_tramp_01',
    'a_m_y_acult_01',
    'a_m_y_acult_02',
    'a_m_y_beach_01',
    'a_m_y_beach_02',
    'a_m_y_beach_03',
    'a_m_y_beachvesp_01',
    'a_m_y_beachvesp_02',
    'a_m_y_bevhills_01',
    'a_m_y_bevhills_02',
    'a_m_y_breakdance_01',
    'a_m_y_busicas_01',
    'a_m_y_business_01',
    'a_m_y_business_02',
    'a_m_y_business_03',
    'a_m_y_clubcust_01',
    'a_m_y_clubcust_02',
    'a_m_y_clubcust_03',
    'a_m_y_cyclist_01',
    'a_m_y_dhill_01',
    'a_m_y_downtown_01',
    'a_m_y_eastsa_01',
    'a_m_y_eastsa_02',
    'a_m_y_epsilon_01',
    'a_m_y_epsilon_02',
    'a_m_y_gay_01',
    'a_m_y_gay_02',
    'a_m_y_genstreet_01',
    'a_m_y_genstreet_02',
    'a_m_y_golfer_01',
    'a_m_y_hasjew_01',
    'a_m_y_hiker_01',
    'a_m_y_hippy_01',
    'a_m_y_hipster_01',
    'a_m_y_hipster_02',
    'a_m_y_hipster_03',
    'a_m_y_indian_01',
    'a_m_y_jetski_01',
    'a_m_y_juggalo_01',
    'a_m_y_ktown_01',
    'a_m_y_ktown_02',
    'a_m_y_latino_01',
    'a_m_y_methhead_01',
    'a_m_y_mexthug_01',
    'a_m_y_motox_01',
    'a_m_y_motox_02',
    'a_m_y_musclbeac_01',
    'a_m_y_musclbeac_02',
    'a_m_y_polynesian_01',
    'a_m_y_roadcyc_01',
    'a_m_y_runner_01',
    'a_m_y_runner_02',
    'a_m_y_salton_01',
    'a_m_y_skater_01',
    'a_m_y_skater_02',
    'a_m_y_soucent_01',
    'a_m_y_soucent_02',
    'a_m_y_soucent_03',
    'a_m_y_soucent_04',
    'a_m_y_stbla_01',
    'a_m_y_stbla_02',
    'a_m_y_stlat_01',
    'a_m_y_stwhi_01',
    'a_m_y_stwhi_02',
    'a_m_y_sunbathe_01',
    'a_m_y_surfer_01',
    'a_m_y_vindouche_01',
    'a_m_y_vinewood_01',
    'a_m_y_vinewood_02',
    'a_m_y_vinewood_03',
    'a_m_y_vinewood_04',
    'a_m_y_yoga_01',
    'ig_lamardavis',
    'ig_ballasog',
    'ig_denise',
    'ig_g',
    'ig_stretch',
    'cs_jimmydisanto',
    'cs_jimmyboston',
    'ig_taocheng',
    'ig_wade',
    'u_m_o_dean',
    'u_m_y_gabriel',
    'u_m_y_croupthief_01',
    'u_m_y_caleb',
    'u_m_m_curtis',
    'u_m_m_vince',
    'u_m_m_blane',
    'ig_vincent',
    'ig_tomcasino',
    'ig_zimbor',
    'player_one',
    's_m_y_westsec_01',
    's_m_y_casino_01',
    'csb_brucie2',
    'csb_avery',
    'cs_siemonyetarian',
}
