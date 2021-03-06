config = {}
Config = {}
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
        count = 10
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
        count = 10
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
        count = 10
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
        count = 10
    },
	{
        name = 'disc_ammo_smg',
        weapons = {
            `WEAPON_ASSAULTSMG`,
            `WEAPON_COMBATPDW`,
            `WEAPON_SMG`
        },
        count = 10
    },
	{
        name = 'disc_ammo_smg_large',
        weapons = {
            `WEAPON_ASSAULTSMG`,
        },
        count = 10
    },
	{
        name = 'disc_ammo_rifle',
        weapons = {
            `WEAPON_ADVANCEDRIFLE`,
            `WEAPON_BULLPUPRIFLE`,
            `WEAPON_CARBINERIFLE`
        },
        count = 10
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
        count = 10
    },
	{
        name = 'disc_ammo_snp',
        weapons = {
        `WEAPON_SNIPERRIFLE`,
        `WEAPON_HEAVYSNIPER`,
        `WEAPON_MARKSMANRIFLE`
        },
        count = 10
    },
	{
        name = 'disc_ammo_snp_large',
        weapons = {
        `WEAPON_SNIPERRIFLE`,
        `WEAPON_HEAVYSNIPER`,
        `WEAPON_MARKSMANRIFLE`
        },
        count = 10
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