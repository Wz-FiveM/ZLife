Ped = setmetatable({}, Ped)
local registeredPeds = {}
local spawnedPeds = {}
function Ped:Add(Model, Pos, Anim,cb)
    local has, pos, bl, anim, mode, dist = Model, Pos, nil, Anim, nil, 4.5
    RegisterLocalPed({ Model = has, Pos = pos, data3D = { dist }, Anim = anim},cb)
end
function RegisterLocalPed(a, cb)
    a.cb = cb
    registeredPeds[#registeredPeds + 1] = a
end

local function CreateLocalPed(a)
    RequestAndWaitModel(a.Model)
    local ped = CreatePed(4, a.Model, a.Pos.x, a.Pos.y, a.Pos.z, a.Pos.a or 0.0, false, false)
    FreezeEntityPosition(ped, true)
    SetBlockingOfNonTemporaryEvents(ped, true)
    SetPedRandomComponentVariation(ped, true)
    if a.Struct then
        setPlayerSkin(a.Struct, { ped = ped })
    else
        SetPedRandomProps(ped)
        SetPedRandomComponentVariation(ped, true)
    end
    SetPedFleeAttributes(ped, 0, 0)
    SetPedKeepTask(ped, true)
    TaskSetBlockingOfNonTemporaryEvents(ped, true)
    SetEntityInvincible(ped, true)
    PlaceObjectOnGroundProperly(ped)
    SetModelAsNoLongerNeeded(ped)

    if a.cb then
        a.cb(ped, a.stuff)
    end
    return ped
end
Citizen.CreateThread(function()
    while true do
        Citizen.Wait(1000)
        local Player = GetPlayerPed(-1)
        local coords = GetEntityCoords(GetPlayerPed(-1))
        for k, v in pairs(registeredPeds) do
            local playerClose = GetDistanceBetween3DCoords(coords.x, coords.y, coords.z, v.Pos.x, v.Pos.y, v.Pos.z, true) < 25
            if not spawnedPeds[k] and playerClose then
                spawnedPeds[k] = CreateLocalPed(v)
                DrawText3D(v.Pos.x, v.Pos.y, v.Pos.z + 1.9, v.Anim, 5)
            elseif spawnedPeds[k] and not playerClose then
                DeleteEntity(spawnedPeds[k])
                spawnedPeds[k] = nil
            end
        end
    end
end)
Citizen.CreateThread(function()
    while true do
        local attente = 1000
        local Player = GetPlayerPed(-1)
        local coords = GetEntityCoords(GetPlayerPed(-1))
        for k, v in pairs(registeredPeds) do
            local playerClose = GetDistanceBetween3DCoords(coords.x, coords.y, coords.z, v.Pos.x, v.Pos.y, v.Pos.z, true) < 7
            if playerClose and v.Anim ~= nil then
                attente = 1
                DrawText3D(v.Pos.x, v.Pos.y, v.Pos.z + 1.9, v.Anim, 5)
            end
        end
        Wait(attente)
    end
end)
function InitPed()
    Ped:Add("mp_m_weapexp_01",{x=-661.84,y=-933.6,z=21.84-0.98,a=181.56},"Adel",nil)
    Ped:Add("s_f_y_cop_01",{x = -1097.485, y = -839.852, z = 19.0015-0.98,a=123.107},"Margot",nil)
    Ped:Add("s_f_y_hooker_02",{x=-1598.52,y=-3015.76,z=-78.2-0.98,a=324.07},nil)
    Ped:Add("s_f_y_hooker_03",{x=-1596.24,  y = -3007.88,  z = -78.2-0.98,a=191.93},nil)
    Ped:Add("a_m_m_genfat_02",{x=2747.8,y=3472.76,z=55.68-0.98,a=247.45},"Gregory",nil)
    Ped:Add("s_m_m_highsec_02",{x=-555.48,y=-618.68,z=34.68-0.98,a=183.31},"Ayhan",nil)
    Ped:Add("a_m_m_hillbilly_01",{x=911.04,y=3644.52,z=32.68-0.98,a=184.49},"Lulu",nil)
    Ped:Add("s_m_m_trucker_01",{x=-1459.32,y=-413.56,z=35.76-0.98,a=166.00},"Bernard",nil)
    Ped:Add("s_m_m_trucker_01",{x=1692.6,y=3761.52,z=34.72-0.98,a=225.91},"Claude",nil)
    Ped:Add("s_f_y_ranger_01",{x=1852.96,y=3689.0,z=34.2-0.98,a=211.14},"Fiona",nil)
    Ped:Add("s_m_m_gaffer_01",{x=1407.72,y=3619.28,z=34.88-0.98,a=292.69},"Darene",nil)
    Ped:Add("mp_f_chbar_01",{x=-776.92,y=-244.28,z=37.12-0.98,a=204.87},"Handye",nil)
    Ped:Add("s_f_y_clubbar_01",{x=1705.28,y=3780.32,z=33.74,a=217.07},"Julie",nil)
    Ped:Add("mp_m_g_vagfun_01",{x=-828.6,  y = -1085.92,  z = 11.12-0.98,a=210.75},"Carrlos",nil)
    Ped:Add("mp_m_counterfeit_01",{x=1760.51,y=3293.06,z=41.13-0.98,a=340.85},"Brandon",nil)
    Ped:Add("s_m_m_hairdress_01",{x=-815.86, y=-183.75, z=36.56,a=132.08},"Abdel",nil)
    Ped:Add("s_m_m_lathandy_01",{x=1737.92,y=3709.0,z=34.12-0.98,a=26.78},"Hector",nil)
    Ped:Add("s_m_m_lathandy_01",{x=-1604.76,  y = 5256.68,  z = 2.08-0.98,a=295.06},"Ernesto",nil)
    Ped:Add("s_m_m_lathandy_01",{x=2141.44,  y = 4788.96,  z = 40.96-0.98,a=117.19},"Emilio",nil)
    Ped:Add("s_m_m_lathandy_01",{x=-753.52,  y = -1512.24,  z = 5.0-0.98,a=26.93},"Adelio",nil)
    Ped:Add("ig_siemonyetarian",{x=891.64,y=-2538.08,z=28.44-0.98,a=177.49},"Siméon",nil)
    Ped:Add("s_m_y_pestcont_01",{x=1520.92,y=6317.76,z=24.08-0.98,a=151.28},"Clyde",nil)
    Ped:Add("s_m_m_strpreach_01",{x=-122.72,y=6389.48,z=32.16-0.98,a=46.21},"Jackson",nil)
    Ped:Add("s_m_m_highsec_01",{x=1690.04,y=3581.6,z=35.64-0.98,a=214.43},"Fares",nil)
    Ped:Add("mp_m_forgery_01",{x=-458.16,y=-2266.12,z=8.52-0.98,a=272.22},"Mendosa",nil)
    Ped:Add("csb_jackhowitzer",{x=-200.28,y=6234.64,z=31.52-0.98,a=229.71},"Loris",nil)
    Ped:Add("csb_roccopelosi",{x=-444.6,y=1598.6,z=358.16-0.98,a=57.28},"Lopez",nil)
    Ped:Add("ig_lamardavis",{x=414.4,y=343.88,z=102.44-0.98,a=344.94},"Lamar",nil)
    Ped:Add("a_m_y_genstreet_01",{x=592.56,y=-3270.84,z=25.6-0.98,a=2.58},"Jordan",nil)
    Ped:Add("s_f_y_scrubs_01",{x=311.635, y=-594.122, z=43.284-0.98,a=337.699},"Clarisse",nil)
    Ped:Add("mp_m_waremech_01",{x=-352.125, y = -128.050, z = 39.021-0.98, a = 261.710},"Xero",nil)
    Ped:Add("csb_maude",{x=1399.364, y=-603.8837, z=74.485-0.98,a=234.96},"Bishops",nil)
    Ped:Add("csb_jackhowitzer",{x=1726.76,  y = 4682.36,  z = 43.64-0.98,a=1.73},"Duggan",nil)
    Ped:Add("csb_hugh",{x=180.0,  y = 2793.28,  z = 45.64-0.98,a=279.43},"Christopher",nil)
    Ped:Add("s_m_m_autoshop_01",{x=1410.96,  y = 3614.68,  z = 34.92-0.98,a=291.53},"Donovan",nil)
    Ped:Add("s_m_m_lathandy_01",{x=-689.12,  y = -945.52,  z = 20.44-0.98,a=186.00},"Donovon",nil)
    Ped:Add("s_m_m_lifeinvad_01",{x=1074.24,  y = -2010.16,  z = 32.08-0.98,a=320.52},"Patrice",nil)
    Ped:Add("s_f_y_scrubs_01",{x=308.370, y= -595.513, z= 43.284 -0.98,a=69.277},"Arissa",nil)
    Ped:Add("ig_denise",{x = -702.953, y = -916.805, z = 19.214-0.98,a=181.3156},"Badyboom",nil)
    Ped:Add("a_f_m_skidrow_01",{x=579.2,  y = 2677.8,  z = 41.84-0.98,a=10.34},"Skidrow",nil)
    Ped:Add("a_f_o_indian_01",{x=82.08,  y = -219.88,  z = 54.64-0.98,a=347.08},"Gabi",nil)
    Ped:Add("g_m_y_armgoon_02",{x=-621.24,  y = -1640.36,  z = 25.96-0.98,a=155.74},"Goon",nil)
    Ped:Add("g_m_m_armgoon_01",{x=-618.24,  y = -1645.44,  z = 25.84-0.98,a=63.95},"Goon Bis",nil)
    Ped:Add("u_m_y_mani",{x=477.6915, y=-1885.677, z=26.0947-0.98, a=202.17},"Alberto",nil)
    Ped:Add("s_m_m_gaffer_01",{x=335, y = 925, z = 202.50, a = 41.5},"Jack",nil)
    Ped:Add("s_m_m_gardener_01", {x = 858.0, y = -2433.76, z = 27.07, a = 175.72}, "Jack", nil)
    Ped:Add("s_m_m_dockwork_01", {x = -120.3, y = -1026.89, z = 26.27, a = 165}, "Bob", nil)
    Ped:Add("s_m_m_gardener_01", {x = 333.0894, y = 923.494, z = 203.44879-0.98, a = 41.634}, "Bob", nil)
    Ped:Add("s_m_m_lathandy_01", {x = 160.447, y = 2281.51440, z = 94.02985-0.98, a = 256.2566},"James", nil)
    Ped:Add("s_m_m_gardener_01", {x = 843.349, y = 2192.40649, z = 52.290-0.98, a = 332.7160}, "Ethan", nil)
end

InitPed()