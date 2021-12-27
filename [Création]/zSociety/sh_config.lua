zSocietyCFG = {

    --[[ Script  ]]

    Language = "fr",

    ESX = "esx:getSharedObject",
    AddonAccount = "esx_addonaccount:getSharedAccount",
    BlackMoney = "black_money",

    --[[ Menu  ]]

    Title = "Society",

    SubTitle = "Boss Menu",

    ColorMenu = {10, 10, 10},

    Banner = {
        Display = true,
        Texture = nil,
        Name = nil,
    },

    Marker = {
        Type = 1,
        Scale = {0.5, 0.5, 0.5},
        Color = {0, 150, 200},
    },

    --[[ Zone ]]

    Zone = {

       --[[  EXEMPLE
        {
            pos = vector3(0.0, 0.0, 0.0),
            name = "jobname",
            label = "Label Of Job",
            salary_max = 1200,
            options = {
                money = true, 
                wash = false, 
                employees = true, 
                grades = true
            },
        }, 
        ]]

        {
            pos = vector3(-709.5930, -903.917, 19.215),
            name = "ltds",
            label = "LTD SUD",
            salary_max = 5000,
            options = {
                money = true, 
                wash = false, 
                employees = true, 
                grades = true
            },
        },

        {
            pos = vector3(-1113.260, -832.9622, 34.3610),
            name = "police",
            label = "Los Santos Police Departement",
            salary_max = 5000,
            options = {
                money = true, 
                wash = false, 
                employees = true, 
                grades = true
            },
            -- blip = {
            --     label = "Commissariat", 
            --     id = 137, 
            --     color = 38,
            --     scale = 0.7
            -- },
        },

        {
            pos = vector3(97.51, -1304.14, 29.25),
            name = "unicorn",
            label = "Vanilla Unicorn",
            percent = 50,
            salary_max = 2500,
            options = {
                money = true, 
                wash = false, 
                employees = true, 
                grades = true
            },
            -- blip = {
            --     label = "Vanilla Unicorn", 
            --     id = 121, 
            --     color = 8,
            --     scale = 0.7
            -- },
        },



        {
            pos = vector3(327.155, -595.77130, 28.791),
            name = "ambulance",
            label = "Hopital",
            percent = 50,
            salary_max = 2500,
            options = {
                money = true, 
                wash = false, 
                employees = true, 
                grades = true
            },
            -- blip = {
            --     label = "Vanilla Unicorn", 
            --     id = 121, 
            --     color = 8,
            --     scale = 0.7
            -- },
        },

        {
            pos = vector3(-809.937, -208.3066, 37.12600),
            name = 'cardealer',
            label = "Concessionnaire",
            percent = 50,
            salary_max = 1500,
            options = {
                money = true, 
                wash = false, 
                employees = true, 
                grades = true
            },
        },

        {
            pos = vector3(814.3919, -93.476, 80.59899),
            name = 'tabac',
            label = "Tabac",
            percent = 50,
            salary_max = 250,
            options = {
                money = true, 
                wash = false, 
                employees = true, 
                grades = true
            },
        },

        {
            pos = vector3(-339.112, -157.4463, 44.587),
            name = 'lscustoms',
            label = "Ls Customs",
            percent = 50,
            salary_max = 500,
            options = {
                money = true, 
                wash = false, 
                employees = true, 
                grades = true
            },
        },

        {
            pos = vector3(138.0091, -1704.222, 29.2916),
            name = 'barber',
            label = "Barber Shop",
            percent = 50,
            salary_max = 100,
            options = {
                money = true, 
                wash = false, 
                employees = true, 
                grades = true
            },
        },

        {
            pos = vector3(-1150.658, -1425.5560, 4.9544),
            name = 'tattoo',
            label = 'Tattoo',
            percent = 50,
            salary_max = 100,
            options = {
                money = true, 
                wash = false, 
                employees = true, 
                grades = true
            },
        },

        {
            pos = vector3(-1619.479, -3010.988, -75.205),
            name = 'galaxy',
            label = 'Galaxy',
            percent = 50,
            salary_max = 100,
            options = {
                money = true, 
                wash = false, 
                employees = true, 
                grades = true
            },
        },

        {
            pos = vector3(1959.7866, 3748.855, 32.343),
            name = 'ltdn',
            label = 'Galaxy',
            percent = 50,
            salary_max = 100,
            options = {
                money = true, 
                wash = false, 
                employees = true, 
                grades = true
            },
        },
        
    },
}