ESX = nil;
PlayerData = {}
Citizen.CreateThread(function()
    while ESX == nil do
        TriggerEvent('esx:getSharedObject', function(a)
            ESX = a
        end)
        Citizen.Wait(0)
    end
    while ESX.GetPlayerData().job == nil do
        Citizen.Wait(10)
    end
    PlayerData = ESX.GetPlayerData()
end)
RegisterNetEvent('esx:playerLoaded')
AddEventHandler('esx:playerLoaded', function(b)
    ESX.PlayerData = b
end)
RegisterNetEvent('esx:setJob')
AddEventHandler('esx:setJob', function(c)
    ESX.PlayerData.job = c
end)







local GUI = {}
GUI.Time = 0
local HasAlreadyEnteredMarker = false
local LastZone = nil
local CurrentAction = nil
local CurrentActionMsg = ''
local CurrentActionData = {}
local OnJob = false
local BlipsImmo = {}
local JobBlipsImmo = {}
local JobBlipsImmo2 = {}
local Blips2Immo = {}
local JobBlips2Immo = {}

ESX = nil
local PlayerData = {}

Citizen.CreateThread(function()
	while ESX == nil do
		TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
		Citizen.Wait(0)
	end

	while ESX.GetPlayerData().job == nil do
		Citizen.Wait(100)
	end

	ESX.PlayerData = ESX.GetPlayerData()
end)





function OpenGetStocksImmoMenu()

	ESX.TriggerServerCallback('clp_Immo:getStockItemsImmo', function(items)

		print(json.encode(items))

		local elements = {}

		for i=1, #items, 1 do
			if items[i].count > 0 then
				table.insert(elements, {label = 'x' .. items[i].count .. ' ' .. items[i].label, value = items[i].name})
			end
		end

	  ESX.UI.Menu.Open(
	    'default', GetCurrentResourceName(), 'stocks_Immo_menu',
	    {
	    	css = 'Immo',
		    title = 'Immo Stock',
		    elements = elements
	    },
	    function(data, menu)

	    	local itemName = data.current.value

			local amount = KeyboardInput("Quantité", "", "", 8)
			if amount ~= nil then
				amount = tonumber(amount)
				if type(amount) == 'number' then
					TriggerServerEvent('clp_Immo:getStockItemImmo', itemName, amount)
				end
				OpenGetStocksImmoMenu()
			end

	    end,
	    function(data, menu)
	    	menu.close()
	    end
	  )

	end)
end

function OpenPutStocksImmoMenu()

	ESX.TriggerServerCallback('clp_jobs:getPlayerInventory', function(inventory)
	
			local elements = {}
	
			for i=1, #inventory.items, 1 do
	
				local item = inventory.items[i]
	
				if item.count > 0 then
					table.insert(elements, {label = item.label .. ' x' .. item.count, type = 'item_standard', value = item.name})
				end
	
			end
	
			ESX.UI.Menu.Open(
				'default', GetCurrentResourceName(), 'stocks_menu_Immo',
				{
					css = 'Immo',
					title = 'Inventaire',
					elements = elements
				},function(data, menu)
				local itemName = data.current.value

			local amount = KeyboardInput("Quantité", "", "", 8)
			if amount ~= nil then
				amount = tonumber(amount)
				if type(amount) == 'number' then
					TriggerServerEvent('clp_Immo:putStockItemsImmo', itemName, amount)
				end
				OpenPutStocksImmoMenu()
			end
		end,function(data, menu)
					menu.close()
				end
			)
	
		end)
	
	end

RegisterNetEvent('esx:playerLoaded')
AddEventHandler('esx:playerLoaded', function(xPlayer)
	ESX.PlayerData = xPlayer
end)

RegisterNetEvent('esx:setJob')
AddEventHandler('esx:setJob', function(job)
	ESX.PlayerData.job = job
end)












local d = ''
local e = ''
local f = ''
local g = ''
local h = ''
local i = ''
local j = ''
local k = ''
local l = ''
local m = ''
local n = ''
local o = ''
local p = ''
local l = 0;
local q = false;
NotifIdLocaPropriete = false;
local q = true;
local r = false;
function openapercui()
    r = not r;
    if not r then
        q = true
    elseif r then
        q = false
    end
end
local s = {"Appartement", "Appartement 2", "Appartement 3", "Local", "Lester", "Michael", "Franklin", "Franklin 2",
           "Caravane", "Trevor 2", "Middle", "Modern", "High", "High 2", "High 3", "Villa", "Villa 2", "Ranche",
           "Motel", "Entrepot (grand)", "Entrepot (moyen)", "Entrepot (petit)", "Garage warehouse", "Biker ClubHouse",
           "Biker ClubHouse 1", "Biker ClubHouse 2", "Grand garage", "Garage appartement", "Garage 2 places",
           "Garage 5 places", "Garage 10 places", "Document office", "Garage avion", "CEO Offices", "Retour"
        }
local ds = {"~g~Valider la propriété", "~r~Annuler la propriété"} 
local t = {
    Base = {
        Header = {"commonmenu", "interaction_bgd"},
        Color = {color_black},
        HeaderColor = {3, 198, 255},
        Title = "Création de propriétées"
    },
    Data = {
        currentMenu = "Création",
        ""
    },
    Events = {
        onSelected = function(self, u, v, w, x, y, z, A, B, C)
            local C = v.slidenum;
            local v = v.name;
            local D = v.unkCheckbox;
            local E = GetEntityCoords(PlayerPedId())
            local F, G = GetStreetNameAtCoord(E.x, E.y, E.z, Citizen.ResultAsInteger(), Citizen.ResultAsInteger())
            local H = GetPlayerPed(-1)
            local I = GetEntityCoords(H)
            if v == "Placer une entrée" then
                local J = {
                    x = I.x,
                    y = I.y,
                    z = I.z - 0.92
                }
                local K = {
                    x = I.x,
                    y = I.y,
                    z = I.z - 0.98
                }
                m = json.encode(J)
                h = json.encode(K)
                PedPosition = I;
                DrawMarker(1, I.x, I.y, I.z - 1, 0.0, 0.0, 0.0, 0, 0.0, 0.0, 1.0, 1.5, 2.0, 150, 255, 255, 100, false,
                    true, 2, false, false, false, false)
                if NotifIdLocaPropriete then
                    RemoveNotification(NotifIdLocaPropriete)
                end
                NotifIdLocaPropriete = ShowAboveRadarMessage(
                                           'Position de la porte : ~b~' .. J.x .. ' , ' .. J.y .. ' , ' .. J.z)
            elseif v == "Placer un garage" then
                local L = {
                    x = I.x,
                    y = I.y,
                    z = I.z - 0.95
                }
                p = json.encode(L)
                DrawMarker(1, I.x, I.y, I.z - 1, 0.0, 0.0, 0.0, 0, 0.0, 0.0, 1.0, 1.5, 2.0, 150, 255, 255, 100, false,
                    true, 2, false, false, false, false)
                if NotifIdLocaPropriete then
                    RemoveNotification(NotifIdLocaPropriete)
                end
                NotifIdLocaPropriete = ShowAboveRadarMessage(
                                           'Position du garage :~b~ ' .. L.x .. ' , ' .. L.y .. ' , ' .. L.z)
            elseif v == "Aperçu" then
                openapercui()
            elseif C == 1 and v == "Propriétées" then
                if not q then
                    Cam('Appartement')
                end
                i = '[]'
                k = '{"x":265.88,"y":-999.4,"z":-99.98}'
                g = '{"x":266.0773,"y":-1007.3900,"z":-101.006}'
                e = '{"x":266.0773,"y":-1007.3900,"z":-102.006}'
                o = 1;
                j = 1;
                isGateway = 0;
                ShowAboveRadarMessage("Propriétée : ~b~Appartement")
            elseif C == 2 and v == "Propriétées" then
                if not q then
                    Cam('Appartement2')
                end
                i = '[]'
                k = '{"x":350.76,"y":-993.84,"z":-100.18}'
                g = '{"x":346.48,"y":-1011.04,"z":-99.2}'
                e = '{"x":346.52,"y":-1012.96,"z":-100.18}'
                o = 1;
                j = 1;
                isGateway = 0;
                ShowAboveRadarMessage("Propriétée : ~b~Appartement 2")
            elseif C == 3 and v == "Propriétées" then
                if not q then
                    Cam('Appartement3')
                end
                i = '[]'
                k = '{"x":-1905.12,"y":-571.08,"z":18.10}'
                g = '{"x":-1902.36,"y":-572.72,"z":19.08}'
                e = '{"x":-1902.36,"y":-572.72,"z":18.10}'
                o = 1;
                j = 1;
                isGateway = 0;
                ShowAboveRadarMessage("Propriétée : ~b~Appartement 3")
            elseif C == 4 and v == "Propriétées" then
                if not q then
                    Cam('Local')
                end
                i = '[]'
                k = '{"x":247.08,"y":371.0,"z":104.75}'
                g = '{"x":242.2,"y":361.4,"z":105.72}'
                e = '{"x":242.2,"y":361.4,"z":104.74}'
                o = 1;
                j = 1;
                isGateway = 0;
                ShowAboveRadarMessage("Propriétée : ~b~Local")
            elseif C == 5 and v == "Propriétées" then
                if not q then
                    Cam('Lester')
                end
                i = '[]'
                k = '{"x":1272.36,"y":-1712.0,"z":53.80}'
                g = '{"x":1269.96,"y":-1709.76,"z":54.76}'
                e = '{"x":1269.12,"y":-1711.16,"z":53.84}'
                o = 1;
                j = 1;
                isGateway = 0;
                ShowAboveRadarMessage("Propriétée : ~b~Lester")
            elseif C == 6 and v == "Propriétées" then
                if not q then
                    Cam('Michael')
                end
                i = '[]'
                k = '{"x":-811.76,"y":175.12,"z":75.78}'
                g = '{"x":-815.64,"y":178.6,"z":72.16}'
                e = '{"x":-815.64,"y":178.6,"z":71.18}'
                o = 1;
                j = 1;
                isGateway = 0;
                ShowAboveRadarMessage("Propriétée : ~b~Michael")
            elseif C == 7 and v == "Propriétées" then
                if not q then
                    Cam('Franklin')
                end
                i = '[]'
                k = '{"x":-16.72,"y":-1430.4,"z":30.15}'
                g = '{"x":-14.4,"y":-1429.44,"z":31.12}'
                e = '{"x":-14.52,"y":-1427.48,"z":30.13}'
                o = 1;
                j = 1;
                isGateway = 0;
                ShowAboveRadarMessage("Propriétée : ~b~Franklin")
            elseif C == 8 and v == "Propriétées" then
                if not q then
                    Cam('Franklin2')
                end
                i = '[]'
                k = '{"x":9.24,"y":528.44,"z":169.66}'
                g = '{"x":7.76,"y":538.44,"z":176.04}'
                e = '{"x":7.76,"y":538.44,"z":175.06}'
                o = 1;
                j = 1;
                isGateway = 0;
                ShowAboveRadarMessage("Propriétée : ~b~Franklin 2")
            elseif C == 9 and v == "Propriétées" then
                if not q then
                    Cam('Caravane')
                end
                i = '[]'
                k = '{"x":1969.48,"y":3814.96,"z":32.46}'
                g = '{"x":1973.44,"y":3818.64,"z":33.44}'
                e = '{"x":1973.0,"y":3816.44,"z":32.49}'
                o = 1;
                j = 1;
                isGateway = 0;
                ShowAboveRadarMessage("Propriétée : ~b~Caravane")
            elseif C == 10 and v == "Propriétées" then
                if not q then
                    Cam('Trevor2')
                end
                i = '[]'
                k = '{"x":-1150.0,"y":-1513.4,"z":9.66}'
                g = '{"x":-1150.68,"y":-1520.84,"z":10.64}'
                e = '{"x":-1150.68,"y":-1520.84,"z":9.66}'
                o = 1;
                j = 1;
                isGateway = 0;
                ShowAboveRadarMessage("Propriétée : ~b~Trevor 2")
            elseif C == 11 and v == "Propriétées" then
                if not q then
                    Cam('Middle')
                end
                i = '[]'
                k = '{"x":-622.4,"y":54.44,"z":96.63}'
                g = '{"x":-612.16,"y":59.06,"z":97.2}'
                e = '{"x":-603.4308,"y":58.9184,"z":97.2001}'
                o = 1;
                j = 1;
                isGateway = 0;
                ShowAboveRadarMessage("Propriétée : ~b~Middle")
            elseif C == 12 and v == "Propriétées" then
                if not q then
                    Cam('Modern')
                end
                i = '["apa_v_mp_h_01_a"]'
                k = '{"x":-796.32,"y":326.44,"z":186.35}'
                g = '{"x":-785.13,"y":315.79,"z":187.91}'
                e = '{"x":-786.87,"y":315.7497,"z":186.91}'
                o = 1;
                j = 1;
                isGateway = 0;
                ShowAboveRadarMessage("Propriétée : ~b~Modern")
            elseif C == 13 and v == "Propriétées" then
                if not q then
                    Cam('High')
                end
                i = '[]'
                k = '{"x":-1456.72,"y":-530.84,"z":55.95}'
                g = '{"x":-1459.17,"y":-520.58,"z":54.929}'
                e = '{"x":-1451.6394,"y":-523.5562,"z":55.9290}'
                o = 1;
                j = 1;
                isGateway = 0;
                ShowAboveRadarMessage("Propriétée : ~b~High")
            elseif C == 14 and v == "Propriétées" then
                if not q then
                    Cam('High2')
                end
                i = '[]'
                k = '{"x":-764.68,"y":331.32,"z":195.10}'
                g = '{"x":-779.2,"y":339.28,"z":196.68}'
                e = '{"x":-774.0,"y":342.0,"z":195.70}'
                o = 1;
                j = 1;
                isGateway = 0;
                ShowAboveRadarMessage("Propriétée : ~b~High 2")
            elseif C == 15 and v == "Propriétées" then
                if not q then
                    Cam('High3')
                end
                i = '[]'
                k = '{"x":-26.48,"y":-588.8,"z":89.14}'
                g = '{"x":-18.96,"y":-581.72,"z":90.12}'
                e = '{"x":-17.72,"y":-589.04,"z":89.14}'
                o = 1;
                j = 1;
                isGateway = 0;
                ShowAboveRadarMessage("Propriétée : ~b~High 3")
            elseif C == 16 and v == "Propriétées" then
                if not q then
                    Cam('Villa')
                end
                i = '[]'
                k = '{"x":-679.96,"y":588.2,"z":136.79}'
                g = '{"x":-680.6088,"y":590.5321,"z":145.39}'
                e = '{"x":-681.6273,"y":591.9663,"z":144.39}'
                o = 1;
                j = 1;
                isGateway = 0;
                ShowAboveRadarMessage("Propriétée : ~b~Villa")
            elseif C == 17 and v == "Propriétées" then
                if not q then
                    Cam('Villa2')
                end
                i = '[]'
                k = '{"x":377.24,"y":430.2,"z":137.34}'
                g = '{"x":373.36,"y":422.04,"z":145.92}'
                e = '{"x":373.48,"y":423.6,"z":144.64}'
                o = 1;
                j = 1;
                isGateway = 0;
                ShowAboveRadarMessage("Propriétée : ~b~Villa 2")
            elseif C == 18 and v == "Propriétées" then
                if not q then
                    Cam('Ranche')
                end
                i = '[]'
                k = '{"x":1402.52,"y":1153.44,"z":113.34}'
                g = '{"x":1396.76,"y":1141.8,"z":114.32}'
                e = '{"x":1396.76,"y":1141.8,"z":113.34}'
                o = 1;
                j = 1;
                isGateway = 0;
                ShowAboveRadarMessage("Propriétée : ~b~Ranche")
            elseif C == 19 and v == "Propriétées" then
                if not q then
                    Cam('Motel')
                end
                i = '["hei_hw1_blimp_interior_v_motel_mp_milo_"]'
                k = '{"x":151.8,"y":-1001.2,"z":-99.95}'
                g = '{"x":151.45,"y":-1007.57,"z":-98.9999}'
                e = '{"x":151.3258,"y":-1007.7642,"z":-99.95}'
                o = 1;
                j = 1;
                isGateway = 0;
                ShowAboveRadarMessage("Propriétée : ~b~Motel")
            elseif C == 20 and v == "Propriétées" then
                if not q then
                    Cam('Entrepot1')
                end
                i = '[]'
                k = '{"x":994.84,"y":-3097.0,"z":-39.95}'
                g = '{"x":997.56,"y":-3091.88,"z":-38.9998}'
                e = '{"x":997.56,"y":-3091.88,"z":-39.9998}'
                o = 1;
                j = 1;
                isGateway = 0;
                ShowAboveRadarMessage("Propriétée : ~b~Entrepot (grand)")
            elseif C == 21 and v == "Propriétées" then
                if not q then
                    Cam('Entrepot2')
                end
                i = '[]'
                k = '{"x":1053.24,"y":-3095.84,"z":-39.9999}'
                g = '{"x":1048.24,"y":-3097.08,"z":-38.9999}'
                e = '{"x":1048.24,"y":-3097.08,"z":-39.9999}'
                o = 1;
                j = 1;
                isGateway = 0;
                ShowAboveRadarMessage("Propriétée : ~b~Entrepot (moyen)")
            elseif C == 22 and v == "Propriétées" then
                if not q then
                    Cam('Entrepot3')
                end
                i = '[]'
                k = '{"x":1100.52,"y":-3101.4,"z":-39.9999}'
                g = '{"x":1087.72,"y":-3099.32,"z":-38.9999}'
                e = '{"x":1087.72,"y":-3099.32,"z":-39.9999}'
                o = 1;
                j = 1;
                isGateway = 0;
                ShowAboveRadarMessage("Propriétée : ~b~Entrepot (petit)")
            elseif C == 23 and v == "Propriétées" then
                if not q then
                    Cam('Entrepot4')
                end
                i = '[]'
                k = '{"x":965.0,"y":-3003.28,"z":-40.64}'
                g = '{"x":1004.72,"y":-2997.56,"z":-39.64}'
                e = '{"x":1004.72,"y":-2997.56,"z":-40.64}'
                o = 1;
                j = 1;
                isGateway = 0;
                ShowAboveRadarMessage("Propriétée : ~b~Garage warehouse")
            elseif C == 24 and v == "Propriétées" then
                if not q then
                    Cam('Biker1')
                end
                i = '[]'
                k = '{"x":977.12,"y":-104.08,"z":73.86}'
                g = '{"x":973.52,"y":-101.92,"z":74.84}'
                e = '{"x":973.52,"y":-101.92,"z":73.86}'
                o = 1;
                j = 1;
                isGateway = 0;
                ShowAboveRadarMessage("Propriétée : ~b~Biker")
            elseif C == 25 and v == "Propriétées" then
                if not q then
                    Cam('Entrepot5')
                end
                i = '[]'
                k = '{"x":1121.92,"y":-3162.44,"z":-37.85}'
                g = '{"x":1121.0,"y":-3152.76,"z":-37.08}'
                e = '{"x":1121.0,"y":-3152.76,"z":-37.08}'
                o = 1;
                j = 1;
                isGateway = 0;
                ShowAboveRadarMessage("Propriétée : ~b~Biker 1")
            elseif C == 26 and v == "Propriétées" then
                if not q then
                    Cam('Entrepot6')
                end
                i = '[]'
                k = '{"x":1008.6,"y":-3171.0,"z":-39.86}'
                g = '{"x":996.92,"y":-3158.16,"z":-38.92}'
                e = '{"x":996.92,"y":-3158.16,"z":-39.86}'
                o = 1;
                j = 1;
                isGateway = 0;
                ShowAboveRadarMessage("Propriétée : ~b~Biker 2")
            elseif C == 27 and v == "Propriétées" then
                if not q then
                    Cam('Entrepot7')
                end
                i = '[]'
                k = '{"x":785.8,"y":-2998.96,"z":-39.98}'
                g = '{"x":794.2,"y":-2992.24,"z":-39.0}'
                e = '{"x":794.2,"y":-2992.24,"z":-40.0}'
                o = 1;
                j = 1;
                isGateway = 0;
                ShowAboveRadarMessage("Propriétée : ~b~Grand garage")
            elseif C == 28 and v == "Propriétées" then
                if not q then
                    Cam('Entrepot8')
                end
                i = '[]'
                k = '{"x":722.08,"y":-2998.48,"z":-39.98}'
                g = '{"x":721.32,"y":-2987.52,"z":-39.0}'
                e = '{"x":721.32,"y":-2987.52,"z":-40.0}'
                o = 1;
                j = 1;
                isGateway = 0;
                ShowAboveRadarMessage("Propriétée : ~b~Garage appartement")
            elseif C == 29 and v == "Propriétées" then
                if not q then
                    Cam('Garage2place')
                end
                i = '[]'
                k = '{"x":177.0,"y":-1000.72,"z":-99.98}'
                g = '{"x":178.96,"y":-1005.56,"z":-99.0}'
                e = '{"x":179.04,"y":-1000.36,"z":-99.98}'
                o = 1;
                j = 1;
                isGateway = 0;
                ShowAboveRadarMessage("Propriétée : ~b~Garage 2 places")
            elseif C == 30 and v == "Propriétées" then
                if not q then
                    Cam('Garage5place')
                end
                i = '[]'
                k = '{"x":205.64,"y":-995.32,"z":-99.98}'
                g = '{"x":206.96,"y":-999.16,"z":-99.0}'
                e = '{"x":212.16,"y":-999.08,"z":-99.98}'
                o = 1;
                j = 1;
                isGateway = 0;
                ShowAboveRadarMessage("Propriétée : ~b~Garage 5 places")
            elseif C == 31 and v == "Propriétées" then
                if not q then
                    Cam('Garage10place')
                end
                i = '[]'
                k = '{"x":234.48,"y":-976.88,"z":-99.98}'
                g = '{"x":238.28,"y":-1004.8,"z":-99.0}'
                e = '{"x":240.4,"y":-1004.96,"z":-99.98}'
                o = 1;
                j = 1;
                isGateway = 0;
                ShowAboveRadarMessage("Propriétée : ~b~Garage 5 places")
            elseif C == 32 and v == "Propriétées" then
                if not q then
                    Cam('Entrepot9')
                end
                i = '[]'
                k = '{"x":1162.8,"y":-3191.48,"z":-39.98}'
                g = '{"x":1173.68,"y":-3196.64,"z":-39.0}'
                e = '{"x":1173.68,"y":-3196.64,"z":-40.0}'
                o = 1;
                j = 1;
                isGateway = 0;
                ShowAboveRadarMessage("Propriétée : ~b~Document office")
            elseif C == 33 and v == "Propriétées" then
                if not q then
                    Cam('Entrepot10')
                end
                i = '[]'
                k = '{"x":-1234.76,"y":-3045.48,"z":-49.46}'
                g = '{"x":-1238.72,"y":-3069.84,"z":-48.48}'
                e = '{"x":-1238.72,"y":-3069.84,"z":-49.48}'
                o = 1;
                j = 1;
                isGateway = 0;
                ShowAboveRadarMessage("Propriétée : ~b~Garage avion")
            elseif C == 34 and v == "Propriétées" then
                if not q then
                    Cam('Entrepot11')
                end
                i = '[]'
                k = '{"x":-139.04,"y":-634.16,"z":167.84}'
                g = '{"x":-137.0,"y":-624.2,"z":168.84}'
                e = '{"x":-137.0,"y":-624.2,"z":167.84}'
                o = 1;
                j = 1;
                isGateway = 0;
                ShowAboveRadarMessage("Propriétée : ~b~CEO Offices")
            elseif C == 35 and v == "Propriétées" then
                Destroy()
            elseif v == "Entrer un nom" then
                --d = OpenKeyboard('name')
                local ds = math.random(1,9999)
                local x,y,z = table.unpack(GetOffsetFromEntityInWorldCoords(PlayerPedId(), 0.0, 0.0, 0.0))
                d = ""..GetStreetNameFromHashKey(GetStreetNameAtCoord(x,y,z)).." "..ds..""
                print(d)
            elseif v == "Entrer un prix" then
                l = OpenKeyboard('price')
            elseif C == 1 and v == "Fin de la propriété" then
                local ds = math.random(1,9999)
                local x,y,z = table.unpack(GetOffsetFromEntityInWorldCoords(PlayerPedId(), 0.0, 0.0, 0.0))
                d = ""..GetStreetNameFromHashKey(GetStreetNameAtCoord(x,y,z)).." "..ds..""
                Wait(50)
                if tonumber(l) == nil or tonumber(l) == 0 then
                    ShowAboveRadarMessage('~r~Vous n\'avez aucun prix assingné.')
                else
                    if d == '' then
                        ShowAboveRadarMessage('~r~Vous n\'avez aucun nom assingné.')
                    else
                        TriggerServerEvent('clp:creaproperty', d, d, m, e, g, h, i, o, j, isGateway, k, p, l)
                        Destroy()
                    end
                end
            elseif C == 2 and v == "Fin de la propriété" then
                Citizen.Wait(50)
                Destroy()
                if NotifIdLocaPropriete then
                    RemoveNotification(NotifIdLocaPropriete)
                end
                NotifIdLocaPropriete = ShowAboveRadarMessage('~r~Création de la propriétée annulé.')
            end
        end
    },
    Menu = {
        ["Création"] = {
            b = {{
                name = "Placer une entrée",
                ask = ">",
                askX = true
            }, {
                name = "Placer un garage",
                ask = ">",
                askX = true
            }, {
                name = "Aperçu",
                checkbox = false
            }, {
                name = "Propriétées",
                slidemax = s
            }, {
                name = "Entrer un prix",
                ask = ">",
                askX = true
            },
            {
                name = "Fin de la propriété",
                slidemax = ds
            },}
        }
    }
}
local function M(N)
    local O = string.gsub(N, "%s+", "")
    return O
end
function OpenKeyboard(P)
    DisplayOnscreenKeyboard(1, "FMMC_MPM_NA", "", "", "", "", "", 20)
    while UpdateOnscreenKeyboard() == 0 do
        DisableAllControlActions(0)
        Citizen.Wait(1)
    end
    if GetOnscreenKeyboardResult() then
        local B = GetOnscreenKeyboardResult()
        if B == nil then
            ShowAboveRadarMessage('~r~Saisis invalide.')
            return
        end
        if P == 'name' then
            return M(B)
        elseif P == 'price' then
            B = tonumber(GetOnscreenKeyboardResult())
            if tonumber(B) == nil then
                ShowAboveRadarMessage("~r~Entrer un prix.")
                return
            end
            return tonumber(B)
        else
            return B
        end
    end
end
function Cam(P)
    if P == 'Appartement' then
        cam = CreateCam('DEFAULT_SCRIPTED_CAMERA', true)
        SetFocusArea(265.6078, -995.8491, -99.0086, 0.0, 0.0, 0.0)
        SetCamCoord(cam, 265.9317, -999.4464, -99.0086)
        SetCamActive(cam, true)
        SetCamRot(cam, 0.0, 0.0, 87.69)
        RenderScriptCams(true, false, 0, true, true)
        FreezeEntityPosition(GetPlayerPed(-1), true)
    elseif P == 'Appartement2' then
        cam = CreateCam('DEFAULT_SCRIPTED_CAMERA', true)
        SetFocusArea(337.92, -992.96, -99.2, 0.0, 0.0, 0.0)
        SetCamCoord(cam, 337.92, -992.96, -99.2)
        SetCamActive(cam, true)
        SetCamRot(cam, 0.0, 0.0, 216.5517578125)
        RenderScriptCams(true, false, 0, true, true)
        FreezeEntityPosition(GetPlayerPed(-1), true)
    elseif P == 'Appartement3' then
        cam = CreateCam('DEFAULT_SCRIPTED_CAMERA', true)
        SetFocusArea(-1902.2, -572.6, 19.08, 0.0, 0.0, 0.0)
        SetCamCoord(cam, -1902.2, -572.6, 19.08)
        SetCamActive(cam, true)
        SetCamRot(cam, 0.0, 0.0, 95.19)
        RenderScriptCams(true, false, 0, true, true)
        FreezeEntityPosition(GetPlayerPed(-1), true)
    elseif P == 'Local' then
        cam = CreateCam('DEFAULT_SCRIPTED_CAMERA', true)
        SetFocusArea(242.16, 361.32, 105.72, 0.0, 0.0, 0.0)
        SetCamCoord(cam, 242.16, 361.32, 105.72)
        SetCamActive(cam, true)
        SetCamRot(cam, 0.0, 0.0, 341.49716186523)
        RenderScriptCams(true, false, 0, true, true)
        FreezeEntityPosition(GetPlayerPed(-1), true)
    elseif P == 'Lester' then
        cam = CreateCam('DEFAULT_SCRIPTED_CAMERA', true)
        SetFocusArea(1274.64, -1715.28, 54.76, 0.0, 0.0, 0.0)
        SetCamCoord(cam, 1274.64, -1715.28, 54.76)
        SetCamActive(cam, true)
        SetCamRot(cam, 0.0, 0.0, 359.52987670898)
        RenderScriptCams(true, false, 0, true, true)
        FreezeEntityPosition(GetPlayerPed(-1), true)
    elseif P == 'Michael' then
        cam = CreateCam('DEFAULT_SCRIPTED_CAMERA', true)
        SetFocusArea(-804.4, 168.4, 72.84, 0.0, 0.0, 0.0)
        SetCamCoord(cam, -804.4, 168.4, 72.98)
        SetCamActive(cam, true)
        SetCamRot(cam, 0.0, 0.0, 341.1)
        RenderScriptCams(true, false, 0, true, true)
        FreezeEntityPosition(GetPlayerPed(-1), true)
    elseif P == 'Franklin' then
        cam = CreateCam('DEFAULT_SCRIPTED_CAMERA', true)
        SetFocusArea(-14.52, -1427.48, 31.12, 0.0, 0.0, 0.0)
        SetCamCoord(cam, -14.52, -1427.48, 31.12)
        SetCamActive(cam, true)
        SetCamRot(cam, 0.0, 0.0, 195.59)
        RenderScriptCams(true, false, 0, true, true)
        FreezeEntityPosition(GetPlayerPed(-1), true)
    elseif P == 'Franklin2' then
        cam = CreateCam('DEFAULT_SCRIPTED_CAMERA', true)
        SetFocusArea(-10.0, 517.88, 174.64, 0.0, 0.0, 0.0)
        SetCamCoord(cam, -10.0, 517.88, 174.80)
        SetCamActive(cam, true)
        SetCamRot(cam, 0.0, 0.0, 303.71)
        RenderScriptCams(true, false, 0, true, true)
        FreezeEntityPosition(GetPlayerPed(-1), true)
    elseif P == 'Caravane' then
        cam = CreateCam('DEFAULT_SCRIPTED_CAMERA', true)
        SetFocusArea(1977.68, 3820.44, 33.52, 0.0, 0.0, 0.0)
        SetCamCoord(cam, 1977.68, 3820.44, 33.52)
        SetCamActive(cam, true)
        SetCamRot(cam, 0.0, 0.0, 109.33277893066)
        RenderScriptCams(true, false, 0, true, true)
        FreezeEntityPosition(GetPlayerPed(-1), true)
    elseif P == 'Trevor2' then
        cam = CreateCam('DEFAULT_SCRIPTED_CAMERA', true)
        SetFocusArea(-1148.28, -1516.32, 10.64, 0.0, 0.0, 0.0)
        SetCamCoord(cam, -1148.28, -1516.32, 10.64)
        SetCamActive(cam, true)
        SetCamRot(cam, 0.0, 0.0, 105.88)
        RenderScriptCams(true, false, 0, true, true)
        FreezeEntityPosition(GetPlayerPed(-1), true)
    elseif P == 'Middle' then
        cam = CreateCam('DEFAULT_SCRIPTED_CAMERA', true)
        SetFocusArea(-616.8566, 59.3575, 98.2000, 0.0, 0.0, 0.0)
        SetCamCoord(cam, -616.8566, 59.3575, 98.2000)
        SetCamActive(cam, true)
        SetCamRot(cam, 0.0, 0.0, 195.59)
        RenderScriptCams(true, false, 0, true, true)
        FreezeEntityPosition(GetPlayerPed(-1), true)
    elseif P == 'Modern' then
        cam = CreateCam('DEFAULT_SCRIPTED_CAMERA', true)
        SetFocusArea(-788.3881, 320.2430, 187.3132, 0.0, 0.0, 0.0)
        SetCamCoord(cam, -788.3881, 320.2430, 187.3132)
        SetCamActive(cam, true)
        SetCamRot(cam, 0.0, 0.0, 355.81)
        RenderScriptCams(true, false, 0, true, true)
        FreezeEntityPosition(GetPlayerPed(-1), true)
    elseif P == 'High' then
        cam = CreateCam('DEFAULT_SCRIPTED_CAMERA', true)
        SetFocusArea(-1459.1700, -520.5855, 56.9247, 0.0, 0.0, 0.0)
        SetCamCoord(cam, -1459.1700, -520.5855, 56.9247)
        SetCamActive(cam, true)
        SetCamRot(cam, 0.0, 0.0, 150.2664)
        RenderScriptCams(true, false, 0, true, true)
        FreezeEntityPosition(GetPlayerPed(-1), true)
    elseif P == 'High2' then
        cam = CreateCam('DEFAULT_SCRIPTED_CAMERA', true)
        SetFocusArea(-774.68, 338.04, 196.08, 0.0, 0.0, 0.0)
        SetCamCoord(cam, -774.68, 338.04, 196.08)
        SetCamActive(cam, true)
        SetCamRot(cam, 0.0, 0.0, 188.61555480957)
        RenderScriptCams(true, false, 0, true, true)
        FreezeEntityPosition(GetPlayerPed(-1), true)
    elseif P == 'High3' then
        cam = CreateCam('DEFAULT_SCRIPTED_CAMERA', true)
        SetFocusArea(-19.32, -581.76, 90.12, 0.0, 0.0, 0.0)
        SetCamCoord(cam, -19.32, -581.76, 90.12)
        SetCamActive(cam, true)
        SetCamRot(cam, 0.0, 0.0, 87.455551147461)
        RenderScriptCams(true, false, 0, true, true)
        FreezeEntityPosition(GetPlayerPed(-1), true)
    elseif P == 'Villa' then
        cam = CreateCam('DEFAULT_SCRIPTED_CAMERA', true)
        SetFocusArea(-681.56, 591.68, 145.4, 0.0, 0.0, 0.0)
        SetCamCoord(cam, -681.56, 591.68, 145.4)
        SetCamActive(cam, true)
        SetCamRot(cam, 0.0, 0.0, 239.20706176758)
        RenderScriptCams(true, false, 0, true, true)
        FreezeEntityPosition(GetPlayerPed(-1), true)
    elseif P == 'Villa2' then
        cam = CreateCam('DEFAULT_SCRIPTED_CAMERA', true)
        SetFocusArea(373.48, 423.6, 145.92, 0.0, 0.0, 0.0)
        SetCamCoord(cam, 373.48, 423.6, 145.92)
        SetCamActive(cam, true)
        SetCamRot(cam, 0.0, 0.0, 167.20260620117)
        RenderScriptCams(true, false, 0, true, true)
        FreezeEntityPosition(GetPlayerPed(-1), true)
    elseif P == 'Ranche' then
        cam = CreateCam('DEFAULT_SCRIPTED_CAMERA', true)
        SetFocusArea(1400.4, 1129.2, 114.32, 0.0, 0.0, 0.0)
        SetCamCoord(cam, 1400.4, 1129.2, 114.33)
        SetCamActive(cam, true)
        SetCamRot(cam, 0.0, 0.0, 22.903076171875)
        RenderScriptCams(true, false, 0, true, true)
        FreezeEntityPosition(GetPlayerPed(-1), true)
    elseif P == 'Motel' then
        cam = CreateCam('DEFAULT_SCRIPTED_CAMERA', true)
        SetFocusArea(151.0994, -1007.8073, -98.9999, 0.0, 0.0, 0.0)
        SetCamCoord(cam, 151.0994, -1007.8073, -98.9999)
        SetCamActive(cam, true)
        SetCamRot(cam, 0.0, 0.0, 337.79)
        RenderScriptCams(true, false, 0, true, true)
        FreezeEntityPosition(GetPlayerPed(-1), true)
    elseif P == 'Biker1' then
        cam = CreateCam('DEFAULT_SCRIPTED_CAMERA', true)
        SetFocusArea(991.76, -97.24, 75.36, 0.0, 0.0, 0.0)
        SetCamCoord(cam, 991.76, -97.24, 75.36)
        SetCamActive(cam, true)
        SetCamRot(cam, 0.0, 0.0, 87.130172729492)
        RenderScriptCams(true, false, 0, true, true)
        FreezeEntityPosition(GetPlayerPed(-1), true)
    elseif P == 'Entrepot1' then
        cam = CreateCam('DEFAULT_SCRIPTED_CAMERA', true)
        SetFocusArea(1026.8707, -3099.8710, -38.9998, 0.0, 0.0, 0.0)
        SetCamCoord(cam, 1026.8707, -3099.8710, -38.9998)
        SetCamActive(cam, true)
        SetCamRot(cam, 0.0, 0.0, 88.76)
        RenderScriptCams(true, false, 0, true, true)
        FreezeEntityPosition(GetPlayerPed(-1), true)
    elseif P == 'Entrepot2' then
        cam = CreateCam('DEFAULT_SCRIPTED_CAMERA', true)
        SetFocusArea(1072.8447, -3100.0390, -38.9999, 0.0, 0.0, 0.0)
        SetCamCoord(cam, 1072.8447, -3100.0390, -38.9999)
        SetCamActive(cam, true)
        SetCamRot(cam, 0.0, 0.0, 91.85)
        RenderScriptCams(true, false, 0, true, true)
        FreezeEntityPosition(GetPlayerPed(-1), true)
    elseif P == 'Entrepot3' then
        cam = CreateCam('DEFAULT_SCRIPTED_CAMERA', true)
        SetFocusArea(1104.7231, -3100.0690, -38.9999, 0.0, 0.0, 0.0)
        SetCamCoord(cam, 1104.7231, -3100.0690, -38.9999)
        SetCamActive(cam, true)
        SetCamRot(cam, 0.0, 0.0, 85.68)
        RenderScriptCams(true, false, 0, true, true)
        FreezeEntityPosition(GetPlayerPed(-1), true)
    elseif P == 'Entrepot4' then
        cam = CreateCam('DEFAULT_SCRIPTED_CAMERA', true)
        SetFocusArea(1003.48, -2989.44, -39.64, 0.0, 0.0, 0.0)
        SetCamCoord(cam, 1003.48, -2989.44, -39.64)
        SetCamActive(cam, true)
        SetCamRot(cam, 0.0, 0.0, 127.9984588623)
        RenderScriptCams(true, false, 0, true, true)
        FreezeEntityPosition(GetPlayerPed(-1), true)
    elseif P == 'Entrepot5' then
        cam = CreateCam('DEFAULT_SCRIPTED_CAMERA', true)
        SetFocusArea(1124.76, -3143.36, -37.08, 0.0, 0.0, 0.0)
        SetCamCoord(cam, 1124.76, -3143.36, -37.08)
        SetCamActive(cam, true)
        SetCamRot(cam, 0.0, 0.0, 139.55853271484)
        RenderScriptCams(true, false, 0, true, true)
        FreezeEntityPosition(GetPlayerPed(-1), true)
    elseif P == 'Entrepot6' then
        cam = CreateCam('DEFAULT_SCRIPTED_CAMERA', true)
        SetFocusArea(997.04, -3152.56, -38.92, 0.0, 0.0, 0.0)
        SetCamCoord(cam, 997.04, -3152.56, -38.92)
        SetCamActive(cam, true)
        SetCamRot(cam, 0.0, 0.0, 221.91441345215)
        RenderScriptCams(true, false, 0, true, true)
        FreezeEntityPosition(GetPlayerPed(-1), true)
    elseif P == 'Entrepot7' then
        cam = CreateCam('DEFAULT_SCRIPTED_CAMERA', true)
        SetFocusArea(797.6, -3019.56, -39.0, 0.0, 0.0, 0.0)
        SetCamCoord(cam, 797.6, -3019.56, -39.0)
        SetCamActive(cam, true)
        SetCamRot(cam, 0.0, 0.0, 23.69630241394)
        RenderScriptCams(true, false, 0, true, true)
        FreezeEntityPosition(GetPlayerPed(-1), true)
    elseif P == 'Entrepot8' then
        cam = CreateCam('DEFAULT_SCRIPTED_CAMERA', true)
        SetFocusArea(738.4, -3001.84, -39.0, 0.0, 0.0, 0.0)
        SetCamCoord(cam, 738.4, -3001.84, -39.0)
        SetCamActive(cam, true)
        SetCamRot(cam, 0.0, 0.0, 44.443988800049)
        RenderScriptCams(true, false, 0, true, true)
        FreezeEntityPosition(GetPlayerPed(-1), true)
    elseif P == 'Garage2place' then
        cam = CreateCam('DEFAULT_SCRIPTED_CAMERA', true)
        SetFocusArea(177.52, -1007.88, -99.0, 0.0, 0.0, 0.0)
        SetCamCoord(cam, 177.52, -1007.88, -99.0)
        SetCamActive(cam, true)
        SetCamRot(cam, 0.0, 0.0, 42.600162506104)
        RenderScriptCams(true, false, 0, true, true)
        FreezeEntityPosition(GetPlayerPed(-1), true)
    elseif P == 'Garage5place' then
        cam = CreateCam('DEFAULT_SCRIPTED_CAMERA', true)
        SetFocusArea(190.84, -1007.56, -99.0, 0.0, 0.0, 0.0)
        SetCamCoord(cam, 190.84, -1007.56, -99.0)
        SetCamActive(cam, true)
        SetCamRot(cam, 0.0, 0.0, 308.6360168457)
        RenderScriptCams(true, false, 0, true, true)
        FreezeEntityPosition(GetPlayerPed(-1), true)
    elseif P == 'Garage10place' then
        cam = CreateCam('DEFAULT_SCRIPTED_CAMERA', true)
        SetFocusArea(220.88, -1006.64, -99.0, 0.0, 0.0, 0.0)
        SetCamCoord(cam, 220.88, -1006.64, -99.0)
        SetCamActive(cam, true)
        SetCamRot(cam, 0.0, 0.0, 336.69290161133)
        RenderScriptCams(true, false, 0, true, true)
        FreezeEntityPosition(GetPlayerPed(-1), true)
    elseif P == 'Entrepot9' then
        cam = CreateCam('DEFAULT_SCRIPTED_CAMERA', true)
        SetFocusArea(1172.84, -3198.8, -39.0, 0.0, 0.0, 0.0)
        SetCamCoord(cam, 1172.84, -3198.8, -39.0)
        SetCamActive(cam, true)
        SetCamRot(cam, 0.0, 0.0, 65.168258666992)
        RenderScriptCams(true, false, 0, true, true)
        FreezeEntityPosition(GetPlayerPed(-1), true)
    elseif P == 'Entrepot10' then
        cam = CreateCam('DEFAULT_SCRIPTED_CAMERA', true)
        SetFocusArea(-1284.48, -2961.88, -48.48, 0.0, 0.0, 0.0)
        SetCamCoord(cam, -1284.48, -2961.88, -48.48)
        SetCamActive(cam, true)
        SetCamRot(cam, 0.0, 0.0, 210.1911315918)
        RenderScriptCams(true, false, 0, true, true)
        FreezeEntityPosition(GetPlayerPed(-1), true)
    elseif P == 'Entrepot11' then
        cam = CreateCam('DEFAULT_SCRIPTED_CAMERA', true)
        SetFocusArea(-124.0, -644.16, 168.84, 0.0, 0.0, 0.0)
        SetCamCoord(cam, -124.0, -644.16, 168.84)
        SetCamActive(cam, true)
        SetCamRot(cam, 0.0, 0.0, 77.549339294434)
        RenderScriptCams(true, false, 0, true, true)
        FreezeEntityPosition(GetPlayerPed(-1), true)
    end
end
function Destroy()
    cam = CreateCam('DEFAULT_SCRIPTED_CAMERA', false)
    SetCamActive(cam, false)
    FreezeEntityPosition(GetPlayerPed(-1), false)
    RenderScriptCams(false, false, 0, false, false)
    SetFocusEntity(PlayerPedId())
end
-- RegisterControlKey("openproperty", "Ouvrir le menu agent immo", "F6", function()
--     if ESX.PlayerData.job ~= nil and ESX.PlayerData.job.name == 'realestateagent' then
--         CreateMenu(t)
--     end
-- end)









local function selectImmomenu(Ped, Select)
	if Select == 1 then 
		messageImmonotfinish = true
		local codecb = KeyboardInput("Veuiller saisir votre Blase","",25)
        codebk = tostring(codecb)
		local text = KeyboardInput("Veuiller saisir votre Message","",255)
        textbk = tostring(text)
		TriggerServerEvent('clp_Immo:annonceImmo', codebk, textbk)  
		messageImmonotfinish = false
	elseif Select == 2 then 
		ExecuteCommand("fac solo")
	elseif Select == 3 then 
		ExecuteCommand("creation")
	elseif Select == 4 then 
		ExecuteCommand("opengrage")
	elseif Select == 5 then 
		ExecuteCommand("clients")
	end
end

local MenuImmo ={
    onSelected=selectImmomenu,
    params={close=true},
    menu={
        {
            {name="Passer une annonce",icon="fab fa-affiliatetheme"},
            {name="Faire une facture",icon="fas fa-file-invoice-dollar"},
			{name="Créer une propriété",icon="fas fa-building"},
			{name="Créer un garage",icon="fas fa-building"},
			{name="Clients",icon="fas fa-users"}
        }
    }
}


local interval = 5000

-- Key Controls
Citizen.CreateThread(function()
    while true do
        if ESX.PlayerData.job ~= nil and ESX.PlayerData.job.name == 'realestateagent' then
            interval = 0
            if IsControlJustReleased(1, 167) then
                CreateRoue(MenuImmo)
            end	
        else
            interval = 5000
        end
        Wait(interval)
    end
end)

