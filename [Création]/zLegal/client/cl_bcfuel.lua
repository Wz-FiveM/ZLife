
local GUI = {}
GUI.Time = 0
local HasAlreadyEnteredMarker = false
local LastZone = nil
local CurrentAction = nil
local CurrentActionMsg = ''
local CurrentActionData = {}
local OnJob = false
local jobonlybcfuel = false
local enservice = false


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

function OpenbcfuelActionsMenu()

	local elements = {
		{label = 'Tenue de travail', value = 'cloakroom_bcfuel'},
		{label = 'Tenue civil', value = 'cloakroom2_bcfuel'},
		{label = 'Déposer Stock', value = 'put_stock_bcfuel'},
		{label = 'Prendre Stock', value = 'get_stock_bcfuel'}
	}

	ESX.UI.Menu.CloseAll()

	ESX.UI.Menu.Open(
		'default', GetCurrentResourceName(), 'bcfuel_actions',
		{
			css = 'entreprise',
			title = 'Globe Oil',
			elements = elements
		},
		function(data, menu)
			if data.current.value == 'cloakroom_bcfuel' then
--[[ 				if isNight() then 
					ESX.ShowNotification("~r~Vous ne pouvez pas travailler de nuit.")
				else ]]
					jobonlybcfuel = true
					ESX.TriggerServerCallback('esx_skin:getPlayerSkin', function(skin, jobSkin)
						if skin.sex == 0 then
							local clothesSkin = {
								['tshirt_1'] = 15, ['tshirt_2'] = 0,
								['torso_1'] = 312, ['torso_2'] = 0,
								['decals_1'] = 0,  ['decals_2'] = 0,
								['mask_1'] = 0, ['mask_2'] = 0,
								['arms'] = 42,
								['pants_1'] = 106, ['pants_2'] = 7,
								['shoes_1'] = 35, ['shoes_2'] = 0,
								['helmet_1'] = 0, ['helmet_2'] = 2,
								['chain_1'] = 0, ['chain_2'] = 0,
								['bproof_1'] = 0,  ['bproof_2'] = 0,
								['bags_1'] = 0, ['bags_2'] = 0
							}
							TriggerEvent('skinchanger:loadClothes', skin, clothesSkin)
						else
							local clothesSkin = {
								['tshirt_1'] = 15, ['tshirt_2'] = 0,
								['torso_1'] = 330, ['torso_2'] = 0,
								['decals_1'] = 0, ['decals_2'] = 0,
								['mask_1'] = 0, ['mask_2'] = 0,
								['arms'] = 42,
								['pants_1'] = 105, ['pants_2'] = 1,
								['shoes_1'] = 38, ['shoes_2'] = 0,
								['helmet_1'] = 0, ['helmet_2'] = 2,
								['watches_1'] = 7, ['watches_2'] = 0,
								['bags_1'] = 0, ['bags_2'] = 0,
								['bproof_1'] = 0, ['bproof_2'] = 0
							}
							TriggerEvent('skinchanger:loadClothes', skin, clothesSkin)
						end
					end)
				end
			--[[ end ]]

			if data.current.value == 'cloakroom2_bcfuel' then
				jobonlybcfuel = false
				ESX.TriggerServerCallback('esx_skin:getPlayerSkin', function(skin, jobSkin)
    				TriggerEvent('skinchanger:loadSkin', skin)
				end)
			end

			if data.current.value == 'put_stock_bcfuel' then
    			OpenPutStocksbcfuelMenu()
			end	

			if data.current.value == 'get_stock_bcfuel' then
				OpenGetStocksbcfuelMenu()
			end	

		end,
		function(data, menu)
			menu.close()
			CurrentAction = 'bcfuel_actions_menu'
			CurrentActionMsg = 'Appuyez sur ~INPUT_CONTEXT~ pour ~g~discuter'
			CurrentActionData = {}
		end
	)
end

function OpenbcfuelVehiclesMenu()

	local elements = {
		{label = 'Sortir Véhicule', value = 'vehicle_bcfuel_list'}
	}

	ESX.UI.Menu.CloseAll()

	ESX.UI.Menu.Open(
		'default', GetCurrentResourceName(), 'bcfuel_vehicles',
		{
			css = 'entreprise',
			title = 'Globe Oil',
			elements = elements
		},
		function(data, menu)
			local grade = ESX.PlayerData.job.grade_name
			if data.current.value == 'vehicle_bcfuel_list' then
				local elements = {
					{label = 'Camion', value = 'mixer2'}
				}

				ESX.UI.Menu.CloseAll()

				ESX.UI.Menu.Open(
					'default', GetCurrentResourceName(), 'spawn_bcfuel_vehicle',
					{
						css = 'entreprise',
						title = 'Véhicule de service',
						elements = elements
					},
					function(data, menu)
						for i=1, #elements, 1 do		
							--[[ if isNight() then 
								ESX.ShowNotification("~r~Vous ne pouvez pas travailler de nuit.")	
							else	 ]]	
								if jobonlybcfuel then 		
									local playerPed = GetPlayerPed(-1)
									local coords = Config.Zones7.VehicleSpawnbcfuelPoint.Pos
									local platenum = math.random(100, 900)
									if not IsAnyVehicleNearPoint(Config.Zones7.VehicleSpawnbcfuelPoint.Pos.x, Config.Zones7.VehicleSpawnbcfuelPoint.Pos.y,Config.Zones7.VehicleSpawnbcfuelPoint.Pos.z ,5.0) then 
									ESX.Game.SpawnVehicle(data.current.value, coords,13.505489349365, function(vehicle)
										--(vehicle, "GLOBEOIL" .. platenum)
										TaskWarpPedIntoVehicle(playerPed, vehicle, -1)
										SetVehicleDoorsLocked(vehicle, 1)
										SetVehicleDoorsLockedForAllPlayers(vehicle, false)
										SetEntityAsMissionEntity(vehicle,true,true)
										SetVehicleHasBeenOwnedByPlayer(vehicle,true)
										local plate = GetVehicleNumberPlateText(vehicle)
										TriggerServerEvent('esx_vehiclelock:givekey', 'no', plate) -- vehicle lock
									end)
								else 
									ESX.ShowNotification("~r~Il y a déjà un véhicule sur la zone d'apparition.")
								end
							else 
								ESX.ShowNotification("~r~Vous n'êtes pas en service.")
						end
					--[[ end ]]
						end						
						menu.close()
					end,
					function(data, menu)
						menu.close()
						OpenbcfuelVehiclesMenu()
					end
				)
			end	

		end,
		function(data, menu)
			menu.close()
			CurrentAction = 'bcfuel_vehicles_menu'
			CurrentActionMsg = 'Appuyez sur ~INPUT_CONTEXT~ pour ~g~ouvrir le garage.'
			CurrentActionData = {}
		end
	)
end

local function selectbcfuelmenu(Ped, Select)
	if Select == 1 then 
		messagebcfuelnotfinish = true
		local amount = KeyboardInput("Annonce", "", 250)
		if amount ~= nil then
			amount = string.len(amount)
			if amount >= 10 then 
				TriggerServerEvent('clp_bcfuel:annoncebcfuel',result)    
				messagebcfuelnotfinish = false
			else
				ESX.ShowNotification("~r~Votre message est trop court.")
			end
		end
	elseif Select == 2 then 
		CreateFacture("society_bcfuel")
	end
end


local MenuBcFuel={
    onSelected=selectbcfuelmenu,
    params={close=true},
    menu={
        {
            {name="Passer une annonce",icon="fab fa-affiliatetheme"},
            {name="Faire une facture",icon="fas fa-file-invoice-dollar"}
        }
    }
}

function OpenGetStocksbcfuelMenu()

	ESX.TriggerServerCallback('clp_bcfuel:getStockItemsbcfuel', function(items)

		print(json.encode(items))

		local elements = {}

		for i=1, #items, 1 do
			if items[i].count > 0 then
				table.insert(elements, {label = 'x' .. items[i].count .. ' ' .. items[i].label, value = items[i].name})
			end
		end

	  ESX.UI.Menu.Open(
	    'default', GetCurrentResourceName(), 'stocks_bcfuel_menu',
	    {
	    	css = 'entreprise',
		    title = 'GlobeOil Stock',
		    elements = elements
	    },
	    function(data, menu)

	    	local itemName = data.current.value

				ESX.UI.Menu.Open(
					'dialog', GetCurrentResourceName(), 'stocks_menu_get_item_count_bcfuel',
					{
						title = 'Quantité'
					},
					function(data2, menu2)

						local count = tonumber(data2.value)

						if count == nil then
							ESX.ShowNotification('Quantité invalide')
						else
						menu2.close()
				    	menu.close()
							TriggerServerEvent('clp_bcfuel:getStockItembcfuel', itemName, count)
							Citizen.Wait(1000)
							OpenGetStocksbcfuelMenu()
						end

					end,
					function(data2, menu2)
						menu2.close()
					end
				)

	    end,
	    function(data, menu)
	    	menu.close()
	    end
	  )

	end)

end

function OpenPutStocksbcfuelMenu()

	ESX.TriggerServerCallback('clp_jobs:getPlayerInventory', function(inventory)
	
			local elements = {}
	
			for i=1, #inventory.items, 1 do
	
				local item = inventory.items[i]
	
				if item.count > 0 then
					table.insert(elements, {label = item.label .. ' x' .. item.count, type = 'item_standard', value = item.name})
				end
	
			end
	
			ESX.UI.Menu.Open(
				'default', GetCurrentResourceName(), 'stocks_menu_bcfuel',
				{
					css = 'entreprise',
					title = 'Inventaire',
					 elements = elements
				},
				function(data, menu)
	
					local itemName = data.current.value
	
					ESX.UI.Menu.Open(
						'dialog', GetCurrentResourceName(), 'stocks_menu_put_item_count_bcfuel',
						{
							title = 'Quantité'
						},
						function(data2, menu2)
	
							local count = tonumber(data2.value)
	
							if count == nil then
								ESX.ShowNotification('Quantité invalide')
							else
							menu2.close()
							menu.close()
	
							TriggerServerEvent('clp_bcfuel:putStockItemsbcfuel', itemName, count)
							Citizen.Wait(1000)
							OpenPutStocksbcfuelMenu()
							end
	
						end,
						function(data2, menu2)
							menu2.close()
						end
					)
	
				end,
				function(data, menu)
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

local poscircuitbcfuel = {
	{x = 345.56,  y = 3408.4,  z = 36.64},
	{x = 2906.68,  y = 4346.36,  z = 50.28},
	{x = 1719.48,  y = 4758.52,  z = 41.96}
}

Citizen.CreateThread(function()
    for k in pairs(poscircuitbcfuel) do
		local blip = AddBlipForCoord(poscircuitbcfuel[k].x, poscircuitbcfuel[k].y, poscircuitbcfuel[k].z)
		SetBlipSprite(blip, 1)
		SetBlipAsShortRange(blip, true)
		SetBlipScale(blip, 0.6)
		SetBlipColour(blip, 19)
		BeginTextCommandSetBlipName("STRING")
		AddTextComponentString("Circuit Globe Oil")
		EndTextCommandSetBlipName(blip)
    end
end)

AddEventHandler('clp_bcfuel:hasEnteredMarkerbcfuel', function(zone)

	if zone == 'bcfuelActions' then
		CurrentAction = 'bcfuel_actions_menu'
		CurrentActionMsg = 'Appuyez sur ~INPUT_CONTEXT~ pour ~g~discuter'
		CurrentActionData = {}
	elseif zone == 'Harvestbcfuel' and jobonlybcfuel then
		CurrentAction = 'bcfuel_harvest_menu'
		CurrentActionMsg = "Appuyez sur ~INPUT_CONTEXT~ pour ~g~commencer"
		CurrentActionData = {}
	elseif zone == 'Harvestbcfuel2' and jobonlybcfuel then
		CurrentAction = 'bcfuel_harvest_menu'
		CurrentActionMsg = "Appuyez sur ~INPUT_CONTEXT~ pour ~g~commencer"
		CurrentActionData = {}
	elseif zone == 'bcfuelCraft' and jobonlybcfuel then
		CurrentAction = 'bcfuel_craft_menu'
		CurrentActionMsg = "Appuyez sur ~INPUT_CONTEXT~ pour ~g~commencer"
		CurrentActionData = {}
	elseif zone == 'bcfuelSellFarm' and jobonlybcfuel then
		CurrentAction = 'bcfuel_sell_menu2'
		CurrentActionMsg = "Appuyez sur ~INPUT_CONTEXT~ pour ~g~commencer"
		CurrentActionData = {zone = zone}
	elseif zone == 'bcfuelSellFarm2' and jobonlybcfuel then
		CurrentAction = 'bcfuel_sell_menu2'
		CurrentActionMsg = "Appuyez sur ~INPUT_CONTEXT~ pour ~g~commencer"
		CurrentActionData = {zone = zone}
	elseif zone == 'VehicleSpawnbcfuelMenu' then
		CurrentAction = 'bcfuel_vehicles_menu'
		CurrentActionMsg = 'Appuyez sur ~INPUT_CONTEXT~ pour ~g~ouvrir le garage.'
		CurrentActionData = {}
	elseif zone == 'VehiclebcfuelDeleter' then
		local playerPed = GetPlayerPed(-1)
		if IsPedInAnyVehicle(playerPed,  false) then
			CurrentAction = 'delete_bcfuel_vehicle'
			CurrentActionMsg = 'Appuyez sur ~INPUT_CONTEXT~ pour ~r~ranger le véhicule.'
			CurrentActionData = {}
		end
	elseif zone == 'BossActionsbcfuel' and ESX.PlayerData.job.grade_name == 'boss' then
		CurrentAction = 'boss_bcfuel_actions_menu'
		CurrentActionMsg = 'Appuyez sur ~INPUT_CONTEXT~ pour accéder au menu ~g~patron.'
		CurrentActionData = {}
	end

end)

AddEventHandler('clp_bcfuel:hasExitedMarkerbcfuel', function(zone)

	if zone == 'bcfuelCraft' then
		TriggerServerEvent('clp_bcfuel:stopCraftbcfuel')
		TriggerServerEvent('clp_bcfuel:stopCraftbcfuel2')
		ESX.DrawMissionText("~r~Vous avez quitté la zone.", 3800)
	elseif zone == 'Harvestbcfuel' then
		TriggerServerEvent('clp_bcfuel:stopHarvestbcfuel')
		ESX.DrawMissionText("~r~Vous avez quitté la zone.", 3800)
	elseif zone == 'Harvestbcfuel2' then
		TriggerServerEvent('clp_bcfuel:stopHarvestbcfuel')
		ESX.DrawMissionText("~r~Vous avez quitté la zone.", 3800)
	elseif zone == 'bcfuelSellFarm' then
		TriggerServerEvent('clp_bcfuel:stopSellbcfuel')
		ESX.DrawMissionText("~r~Vous avez quitté la zone.", 3800)
	elseif zone == 'bcfuelSellFarm2' then
		TriggerServerEvent('clp_bcfuel:stopSellbcfuel2')
		ESX.DrawMissionText("~r~Vous avez quitté la zone.", 3800)
	end

	CurrentAction = nil
	ESX.UI.Menu.CloseAll()
end)

-- Display markers
Citizen.CreateThread(function()
    while true do
        attente = 500
		if ESX.PlayerData.job ~= nil and ESX.PlayerData.job.name == 'bcfuel' then

			local coords = GetEntityCoords(GetPlayerPed(-1))
			
			for k,v in pairs(Config.Zones7) do
				if(v.Type ~= -1 and GetDistanceBetweenCoords(coords, v.Pos.x, v.Pos.y, v.Pos.z, true) < 10) and not IsPedInAnyVehicle(GetPlayerPed(-1), false) then
					attente = 1
					DrawMarker(v.Type, v.Pos.x, v.Pos.y, v.Pos.z, 0.0, 0.0, 0.0, 0, 0.0, 0.0, v.Size.x, v.Size.y, v.Size.z,0, 121, 255, 100, false, true, 2, false, false, false, false)
				elseif IsPedInAnyVehicle(GetPlayerPed(-1), false) then 
					attente = 2500
				end
			end
		end
		Wait(attente)
	end
end)

-- Enter / Exit marker events
Citizen.CreateThread(function()
	while true do
		local attente = 500
		if ESX.PlayerData.job ~= nil and ESX.PlayerData.job.name == 'bcfuel' then
			local coords = GetEntityCoords(GetPlayerPed(-1))
			local isInMarker = false
			local currentZone = nil
			for k,v in pairs(Config.Zones7) do
				if(GetDistanceBetweenCoords(coords, v.Pos.x, v.Pos.y, v.Pos.z, true) < 5.5) then
					attente = 1
					isInMarker = true
					currentZone = k
				end
			end
			if (isInMarker and not HasAlreadyEnteredMarker) or (isInMarker and LastZone ~= currentZone) then
				attente = 1
				HasAlreadyEnteredMarker = true
				LastZone = currentZone
				TriggerEvent('clp_bcfuel:hasEnteredMarkerbcfuel', currentZone)
			end
			if not isInMarker and HasAlreadyEnteredMarker then
				attente = 1
				HasAlreadyEnteredMarker = false
				TriggerEvent('clp_bcfuel:hasExitedMarkerbcfuel', LastZone)
			end
		end
		Wait(attente)
	end
end)



-- Key Controls
Citizen.CreateThread(function()
	while true do
		local attente = 500

		if CurrentAction ~= nil then
            SetTextComponentFormat('STRING')
            AddTextComponentString(CurrentActionMsg)
			DisplayHelpTextFromStringLabel(0, 0, false, -1)
			attente = 5
            if IsControlJustReleased(0, 38) and ESX.PlayerData.job ~= nil and ESX.PlayerData.job.name == 'bcfuel' then

                if CurrentAction == 'bcfuel_actions_menu' then
                	OpenbcfuelActionsMenu()
                elseif CurrentAction == 'bcfuel_harvest_menu' and not IsPedSittingInAnyVehicle(GetPlayerPed(-1)) then
					TriggerServerEvent('clp_bcfuel:startHarvestbcfuel')
					Citizen.Wait(5000)
				elseif CurrentAction == 'boss_bcfuel_actions_menu' then
                	OpenBossbcfuelActionsMenu()
                elseif CurrentAction == 'bcfuel_craft_menu' and not IsPedSittingInAnyVehicle(GetPlayerPed(-1)) then
					TriggerServerEvent('clp_bcfuel:startCraftbcfuel2')
					Citizen.Wait(5000)
				elseif CurrentAction == 'bcfuel_sell_menu' and not IsPedSittingInAnyVehicle(GetPlayerPed(-1)) then
					TriggerServerEvent('clp_bcfuel:startSellbcfuel', CurrentActionData.zone)
					Citizen.Wait(5000)
				elseif CurrentAction == 'bcfuel_sell_menu2' and not IsPedSittingInAnyVehicle(GetPlayerPed(-1)) then
					TriggerServerEvent('clp_bcfuel:startSellbcfuel2', CurrentActionData.zone)
					Citizen.Wait(5000)
                elseif CurrentAction == 'bcfuel_vehicles_menu' then
                	OpenbcfuelVehiclesMenu()
                elseif CurrentAction == 'delete_bcfuel_vehicle' then
                    local playerPed = GetPlayerPed(-1)
                    local vehicle = GetVehiclePedIsIn(playerPed,  false)
                    local hash = GetEntityModel(vehicle)
                    local plate = GetVehicleNumberPlateText(vehicle)
					if hash == GetHashKey('mixer2') then
                        if Config.MaxInService ~= -1 then
                          TriggerServerEvent('esx_service:disableService', 'bcfuel')
                        end
                        DeleteVehicle(vehicle)
                        	TriggerServerEvent('esx_vehiclelock:deletekeyjobs', 'no', plate) --vehicle lock
                    else
                        ESX.ShowNotification('Vous ne pouvez ranger que des ~b~véhicules bcfuel~s~.')
                    end
				end
                CurrentAction = nil               
            end
		end


		if ESX.PlayerData.job ~= nil and ESX.PlayerData.job.name == 'bcfuel' then
			RegisterControlKey("bcfuelnmenu","Ouvrir le menu bcfuel","F6",function()
				if ESX.PlayerData.job ~= nil and ESX.PlayerData.job.name == 'bcfuel' then
					if jobonlybcfuel then 	
						CreateRoue(MenuBcFuel)
					else
						ShowAboveRadarMessage("~r~Vous n'avez pas votre tenue de service.")
					end
				end
			end)
		end
		Wait(attente)
    end
end)

function OpenBossbcfuelActionsMenu()

	local elements = {
		{label = 'Déposer Stock', value = 'put_stock_bcfuel'},
		{label = 'Prendre Stock', value = 'get_stock_bcfuel'},
		{label = '---------------', value = nil},
		{label = 'Action Patron', value = 'boss_bcfuel_actions'}
	}

	ESX.UI.Menu.CloseAll()

	ESX.UI.Menu.Open(
		'default', GetCurrentResourceName(), 'boss_actions_bcfuel',
		{
			css = 'entreprise',
			title = 'Boss',
			elements = elements
		},
		function(data, menu)

			if data.current.value == 'put_stock_bcfuel' then
				OpenPutStocksbcfuelMenu()
			elseif data.current.value == 'get_stock_bcfuel' then
				OpenGetStocksbcfuelMenu()
			elseif data.current.value == 'boss_bcfuel_actions' then
				TriggerEvent('esx_society:openBossMenu', 'bcfuel', function(data, menu)
					menu.close()
				end)
			end

		end,
		function(data, menu)
			menu.close()
			CurrentAction = 'boss_bcfuel_actions_menu'
			CurrentActionMsg = 'Appuyez sur ~INPUT_CONTEXT~ pour accéder au menu ~g~patron.'
			CurrentActionData = {}
		end
	)
end