local HasAlreadyEnteredMarker = false
local LastZone = nil
local CurrentAction = nil
local CurrentActionMsg = ''
local CurrentActionData = {}
local IsInShopMenu = false
local Categories = {}
local Vehicles = {}
local LastVehicles = {}
local CurrentVehicleData = nil

ESX = nil
local PlayerData = {}

Citizen.CreateThread(function ()
	while ESX == nil do
		TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
		Citizen.Wait(0)
	end

	Citizen.Wait(15000)

	ESX.TriggerServerCallback('esx_vehicleshop:getCategories', function (categories)
		Categories = categories
	end)

	ESX.TriggerServerCallback('esx_vehicleshop:getVehicles', function (vehicles)
		Vehicles = vehicles
	end)

	PlayerData = ESX.GetPlayerData()
	
	if Config.EnablePlayerManagement then
		if ESX.PlayerData.job.name == 'cardealer' then
			Config.Zones.ShopEntering.Type = 1

			if ESX.PlayerData.job.grade_name == 'boss' then
				Config.Zones.BossActions.Type = 1
			end

		else
			Config.Zones.ShopEntering.Type = -1
			Config.Zones.BossActions.Type = -1
		end
	end
end)


RegisterNetEvent('esx:playerLoaded')
AddEventHandler('esx:playerLoaded', function(xPlayer)
	ESX.PlayerData = xPlayer

	if Config.EnablePlayerManagement then
		if ESX.PlayerData.job.name == 'cardealer' then
			Config.Zones.ShopEntering.Type = 1

			if ESX.PlayerData.job.grade_name == 'boss' then
				Config.Zones.BossActions.Type = 1
			end

		else
			Config.Zones.ShopEntering.Type = -1
			Config.Zones.BossActions.Type = -1
		end
	end
end)

RegisterNetEvent('esx_vehicleshop:sendCategories')
AddEventHandler('esx_vehicleshop:sendCategories', function (categories)
	Categories = categories
end)

RegisterNetEvent('esx_vehicleshop:sendVehicles')
AddEventHandler('esx_vehicleshop:sendVehicles', function (vehicles)
	Vehicles = vehicles
end)

function DeleteShopInsideVehicles()
	while #LastVehicles > 0 do
		local vehicle = LastVehicles[1]

		ESX.Game.DeleteVehicle(vehicle)
		table.remove(LastVehicles, 1)
	end
end

function ReturnVehicleProvider()
	ESX.TriggerServerCallback('esx_vehicleshop:getCommercialVehicles', function (vehicles)
		local elements = {}
		local returnPrice
		for i=1, #vehicles, 1 do
			returnPrice = ESX.Math.Round(vehicles[i].price * 0.75)

			table.insert(elements, {
				label = ('%s [<span style="color:orange;">%s</span>]'):format(vehicles[i].name, _U('generic_shopitem', ESX.Math.GroupDigits(returnPrice))),
				value = vehicles[i].name
			})
		end

		ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'return_provider_menu', {
			css = 'autoshop',
			title = _U('return_provider_menu'),
			align = 'top-left',
			elements = elements
		}, function (data, menu)
			TriggerServerEvent('esx_vehicleshop:returnProvider', data.current.value)

			Citizen.Wait(300)
			menu.close()
			ReturnVehicleProvider()
		end, function (data, menu)
			menu.close()
		end)
	end)
end

function OpenShopMenu()
	IsInShopMenu = true

	ESX.UI.Menu.CloseAll()

	local playerPed = PlayerPedId()

	local vehiclesByCategory = {}
	local elements = {}
	local firstVehicleData = nil

	for i=1, #Categories, 1 do
		vehiclesByCategory[Categories[i].name] = {}
	end

	for i=1, #Vehicles, 1 do
		if IsModelInCdimage(GetHashKey(Vehicles[i].model)) then
			table.insert(vehiclesByCategory[Vehicles[i].category], Vehicles[i])
		else
			print(('esx_vehicleshop: vehicle "%s" does not exist'):format(Vehicles[i].model))
		end
	end

	for i=1, #Categories, 1 do
		local category = Categories[i]
		local categoryVehicles = vehiclesByCategory[category.name]
		local options = {}

		for j=1, #categoryVehicles, 1 do
			local vehicle = categoryVehicles[j]

			if i == 1 and j == 1 then
				firstVehicleData = vehicle
			end

			table.insert(options, ('%s <span style="color:green;">%s</span>'):format(vehicle.name, _U('generic_shopitem', ESX.Math.GroupDigits(vehicle.price))))
		end

		table.insert(elements, {
			name = category.name,
			label = category.label,
			value = 0,
			type = 'slider',
			max = #Categories[i],
			options = options
		})
	end

	ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'vehicle_shop', {
		css = 'autoshop',
		title = _U('car_dealer'),
		align = 'top-left',
		elements = elements
	}, function (data, menu)
		local vehicleData = vehiclesByCategory[data.current.name][data.current.value + 1]

		ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'shop_confirm', {
			css = 'autoshop',
			title = _U('buy_vehicle_shop', vehicleData.name, ESX.Math.GroupDigits(vehicleData.price)),
			align = 'top-left',
			elements = {
				{label = _U('no'), value = 'no'},
				{label = _U('yes'), value = 'yes'}
			}
		}, function(data2, menu2)
			if data2.current.value == 'yes' then
				if Config.EnablePlayerManagement then
					ESX.TriggerServerCallback('esx_vehicleshop:buyVehicleSociety', function(hasEnoughMoney)
						if hasEnoughMoney then
							IsInShopMenu = false

							DeleteShopInsideVehicles()

							local playerPed = PlayerPedId()

							CurrentAction = 'shop_menu'
							CurrentActionMsg = _U('shop_menu')
							CurrentActionData = {}

							FreezeEntityPosition(playerPed, false)
							SetEntityVisible(playerPed, true)

							menu2.close()
							menu.close()

							ESX.ShowNotification(_U('vehicle_purchased'))
						else
							ESX.ShowNotification(_U('broke_company'))
						end
					end, 'cardealer', vehicleData.model)
				else
					local playerData = ESX.GetPlayerData()

					if Config.EnableSocietyOwnedVehicles and playerData.job.grade_name == 'boss' then
						ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'shop_confirm_buy_type', {
							css = 'autoshop',
							title = _U('purchase_type'),
							align = 'top-left',
							elements = {
								{label = _U('staff_type'), value = 'personnal'},
								{label = _U('society_type'), value = 'society'}
						}}, function (data3, menu3)

							if data3.current.value == 'personnal' then

								ESX.TriggerServerCallback('esx_vehicleshop:buyVehicle', function(hasEnoughMoney)
									if hasEnoughMoney then
										IsInShopMenu = false

										menu3.close()
										menu2.close()
										menu.close()
										DeleteShopInsideVehicles()

										ESX.Game.SpawnVehicle(vehicleData.model, Config.Zones.ShopOutside.Pos, Config.Zones.ShopOutside.Heading, function (vehicle)
											local plate = GetVehicleNumberPlateText(vehicle)       -- rajout tox
                                            TriggerServerEvent('esx_vehiclelock:givekey', 'no', plate) -- vehicle lock rajou tox
											TaskWarpPedIntoVehicle(playerPed, vehicle, -1)

											local newPlate = GeneratePlate()
											local vehicleProps = ESX.Game.GetVehicleProperties(vehicle)
											vehicleProps.plate = newPlate
											SetVehicleNumberPlateText(vehicle, newPlate)
											local plate = GetVehicleNumberPlateText(vehicle)       -- rajout tox
                                            TriggerServerEvent('esx_vehiclelock:givekey', 'no', plate) -- vehicle lock rajou tox

											if Config.EnableOwnedVehicles then
												TriggerServerEvent('esx_vehicleshop:setVehicleOwned', vehicleProps)
												TriggerServerEvent('esx_vehiclelock:registerkey', vehicleProps.plate, GetPlayerServerId(closestPlayer))
											end

											ESX.ShowNotification(_U('vehicle_purchased'))
										end)

										FreezeEntityPosition(playerPed, false)
										SetEntityVisible(playerPed, true)
									else
										ESX.ShowNotification(_U('not_enough_money'))
									end
								end, vehicleData.model)

							elseif data3.current.value == 'society' then

								ESX.TriggerServerCallback('esx_vehicleshop:buyVehicleSociety', function (hasEnoughMoney)
									if hasEnoughMoney then
										IsInShopMenu = false

										menu3.close()
										menu2.close()
										menu.close()

										DeleteShopInsideVehicles()

										ESX.Game.SpawnVehicle(vehicleData.model, Config.Zones.ShopOutside.Pos, Config.Zones.ShopOutside.Heading, function (vehicle)
											local plate = GetVehicleNumberPlateText(vehicle)       -- rajout tox
                                            TriggerServerEvent('esx_vehiclelock:givekey', 'no', plate) -- vehicle lock rajou tox
											TaskWarpPedIntoVehicle(playerPed, vehicle, -1)

											local newPlate = GeneratePlate()
											local vehicleProps = ESX.Game.GetVehicleProperties(vehicle)
											vehicleProps.plate = newPlate
											SetVehicleNumberPlateText(vehicle, newPlate)
											TriggerServerEvent('esx_vehicleshop:setVehicleOwnedSociety', playerData.job.name, vehicleProps)
											TriggerServerEvent('esx_vehiclelock:givekey', 'no', plate, GetPlayerServerId(closestPlayer))
											ESX.ShowNotification(_U('vehicle_purchased'))
										end)

										FreezeEntityPosition(playerPed, false)
										SetEntityVisible(playerPed, true)
									else
										ESX.ShowNotification(_U('broke_company'))
									end
								end, playerData.job.name, vehicleData.model)

							end
						end, function (data3, menu3)
							menu3.close()
						end)
					else
						ESX.TriggerServerCallback('esx_vehicleshop:buyVehicle', function (hasEnoughMoney)
							if hasEnoughMoney then
								IsInShopMenu = false
								menu2.close()
								menu.close()
								DeleteShopInsideVehicles()

								ESX.Game.SpawnVehicle(vehicleData.model, Config.Zones.ShopOutside.Pos, Config.Zones.ShopOutside.Heading, function (vehicle)
									local plate = GetVehicleNumberPlateText(vehicle)       -- rajout tox
                                    TriggerServerEvent('esx_vehiclelock:givekey', 'no', plate) -- vehicle lock rajou tox
									TaskWarpPedIntoVehicle(playerPed, vehicle, -1)

									local newPlate = GeneratePlate()
									local vehicleProps = ESX.Game.GetVehicleProperties(vehicle)
									vehicleProps.plate = newPlate
									SetVehicleNumberPlateText(vehicle, newPlate)
									local plate = GetVehicleNumberPlateText(vehicle)       -- rajout tox
                                    TriggerServerEvent('esx_vehiclelock:givekey', 'no', plate) -- vehicle lock rajou tox

									if Config.EnableOwnedVehicles then
										TriggerServerEvent('esx_vehicleshop:setVehicleOwned', vehicleProps)
										TriggerServerEvent('esx_vehiclelock:registerkey', vehicleProps.plate, GetPlayerServerId(closestPlayer))
									end

									ESX.ShowNotification(_U('vehicle_purchased'))
								end)

								FreezeEntityPosition(playerPed, false)
								SetEntityVisible(playerPed, true)
							else
								ESX.ShowNotification(_U('not_enough_money'))
							end
						end, vehicleData.model)
					end
				end
			end
		end, function (data2, menu2)
			menu2.close()
		end)
	end, function (data, menu)
		menu.close()
		DeleteShopInsideVehicles()
		local playerPed = PlayerPedId()

		CurrentAction = 'shop_menu'
		CurrentActionMsg = _U('shop_menu')
		CurrentActionData = {}

		FreezeEntityPosition(playerPed, false)
		SetEntityVisible(playerPed, true)
		SetEntityCoords(playerPed, Config.Zones.ShopEntering.Pos.x, Config.Zones.ShopEntering.Pos.y, Config.Zones.ShopEntering.Pos.z)

		IsInShopMenu = false
	end, function (data, menu)
		local vehicleData = vehiclesByCategory[data.current.name][data.current.value + 1]
		local playerPed = PlayerPedId()

		DeleteShopInsideVehicles()
		WaitForVehicleToLoad(vehicleData.model)

		ESX.Game.SpawnLocalVehicle(vehicleData.model, Config.Zones.ShopInside.Pos, Config.Zones.ShopInside.Heading, function (vehicle)
			table.insert(LastVehicles, vehicle)
			FreezeEntityPosition(vehicle, true)
			SetModelAsNoLongerNeeded(vehicleData.model)
		end)
	end)

	DeleteShopInsideVehicles()
	WaitForVehicleToLoad(firstVehicleData.model)

	ESX.Game.SpawnLocalVehicle(firstVehicleData.model, Config.Zones.ShopInside.Pos, Config.Zones.ShopInside.Heading, function (vehicle)
		table.insert(LastVehicles, vehicle)
		FreezeEntityPosition(vehicle, true)
		SetModelAsNoLongerNeeded(firstVehicleData.model)
	end)

end

function WaitForVehicleToLoad(modelHash)
	modelHash = (type(modelHash) == 'number' and modelHash or GetHashKey(modelHash))

	if not HasModelLoaded(modelHash) then
		RequestModel(modelHash)

		BeginTextCommandBusyString('STRING')
		AddTextComponentSubstringPlayerName(_U('shop_awaiting_model'))
		EndTextCommandBusyString(4)

		while not HasModelLoaded(modelHash) do
			Citizen.Wait(1)
			DisableAllControlActions(0)
		end

		RemoveLoadingPrompt()
	end
end

function OpenResellerMenu()
	ESX.UI.Menu.CloseAll()

	ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'reseller', {
		css = 'autoshop',
		title = _U('car_dealer'),
		align = 'top-left',
		elements = {
			--{label = _U('buy_vehicle'), value = 'buy_vehicle'},
			{label = _U('pop_vehicle'), value = 'pop_vehicle'},
			{label = _U('depop_vehicle'), value = 'depop_vehicle'},
			--{label = _U('return_provider'), value = 'return_provider'},
			{label = _U('create_bill'), value = 'create_bill'},
			--{label = _U('get_rented_vehicles'), value = 'get_rented_vehicles'},
			{label = _U('set_vehicle_owner_sell'), value = 'set_vehicle_owner_sell'},
			--{label = _U('set_vehicle_owner_rent'), value = 'set_vehicle_owner_rent'},
			{label = "Passer une annonce", value = 'AnnounceCardealerouvert'},
			--{label = _U('deposit_stock'), value = 'put_stock'},
			--{label = _U('take_stock'), value = 'get_stock'}
		}
	}, function (data, menu)
		local action = data.current.value

		if action == 'buy_vehicle' then
			OpenShopMenu()
		elseif action == 'put_stock' then
			OpenPutStocksMenu()
		elseif action == 'AnnounceCardealerouvert' then 
			menu.close()
			messagecardealernotfinish = true
			local amount = KeyboardInput("Annonce", "", 250)
			if amount ~= nil then
				amount = string.len(amount)
				if amount >= 10 then 
					TriggerServerEvent('clp_cardealer:annoncecardealer',result)  
					messagecardealernotfinish = false
				else
					ESX.ShowNotification("~r~Votre message est trop court.")
				end
			end
		elseif action == 'get_stock' then
			OpenGetStocksMenu()
		elseif action == 'pop_vehicle' then
			OpenPopVehicleMenu()
		elseif action == 'depop_vehicle' then
			DeleteShopInsideVehicles()
		elseif action == 'return_provider' then
			ReturnVehicleProvider()
		elseif action == 'create_bill' then
			menu.close()
			CreateFacture("society_cardealer")
		elseif action == 'get_rented_vehicles' then
			OpenRentedVehiclesMenu()
		elseif action == 'set_vehicle_owner_sell' then

			local closestPlayer, closestDistance = ESX.Game.GetClosestPlayer()

			if closestPlayer == -1 or closestDistance > 3.0 then
				ESX.ShowNotification(_U('no_players'))
			else
				local newPlate = GeneratePlate()
				local vehicleProps = ESX.Game.GetVehicleProperties(LastVehicles[#LastVehicles])
				local model = CurrentVehicleData.model
				vehicleProps.plate = newPlate
				SetVehicleNumberPlateText(LastVehicles[#LastVehicles], newPlate)

				TriggerServerEvent('esx_vehicleshop:sellVehicle', model)
				TriggerServerEvent('esx_vehicleshop:addToList', GetPlayerServerId(closestPlayer), model, newPlate)

				if Config.EnableOwnedVehicles then
					TriggerServerEvent('esx_vehicleshop:setVehicleOwnedPlayerId', GetPlayerServerId(closestPlayer), vehicleProps)
					for i = 1, 10 do
						print(vehicleProps.plate)
						TriggerServerEvent('esx_vehiclelock:registerkey', vehicleProps.plate, GetPlayerServerId(closestPlayer))
                    end
					ESX.ShowNotification(_U('vehicle_set_owned', vehicleProps.plate, GetPlayerName(closestPlayer)))
				else
					ESX.ShowNotification(_U('vehicle_sold_to', vehicleProps.plate, GetPlayerName(closestPlayer)))
				end
			end

		elseif action == 'set_vehicle_owner_sell_society' then

			local closestPlayer, closestDistance = ESX.Game.GetClosestPlayer()

			if closestPlayer == -1 or closestDistance > 3.0 then
				ESX.ShowNotification(_U('no_players'))
			else
				ESX.TriggerServerCallback('esx:getOtherPlayerData', function (xPlayer)

					local newPlate = GeneratePlate()
					local vehicleProps = ESX.Game.GetVehicleProperties(LastVehicles[#LastVehicles])
					local model = CurrentVehicleData.model
					vehicleProps.plate = newPlate
					SetVehicleNumberPlateText(LastVehicles[#LastVehicles], newPlate)
					TriggerServerEvent('esx_vehicleshop:sellVehicle', model)
					TriggerServerEvent('esx_vehicleshop:addToList', GetPlayerServerId(closestPlayer), model, newPlate)

					if Config.EnableSocietyOwnedVehicles then
						TriggerServerEvent('esx_vehicleshop:setVehicleOwnedSociety', xPlayer.job.name, vehicleProps)
						TriggerServerEvent('esx_vehiclelock:registerkey', vehicleProps.plate, GetPlayerServerId(closestPlayer))
						ESX.ShowNotification(_U('vehicle_set_owned', vehicleProps.plate, GetPlayerName(closestPlayer)))
					else
						ESX.ShowNotification(_U('vehicle_sold_to', vehicleProps.plate, GetPlayerName(closestPlayer)))
					end

				end, GetPlayerServerId(closestPlayer))
			end

		elseif action == 'set_vehicle_owner_rent' then

			ESX.UI.Menu.Open('dialog', GetCurrentResourceName(), 'set_vehicle_owner_rent_amount', {
				title = _U('rental_amount')
			}, function (data2, menu2)
				local amount = tonumber(data2.value)

				if amount == nil then
					ESX.ShowNotification(_U('invalid_amount'))
				else
					menu2.close()

					local closestPlayer, closestDistance = ESX.Game.GetClosestPlayer()

					if closestPlayer == -1 or closestDistance > 5.0 then
						ESX.ShowNotification(_U('no_players'))
					else
						local newPlate = 'RENT' .. string.upper(ESX.GetRandomString(4))
						local vehicleProps = ESX.Game.GetVehicleProperties(LastVehicles[#LastVehicles])
						local model = CurrentVehicleData.model
						vehicleProps.plate = newPlate
						SetVehicleNumberPlateText(LastVehicles[#LastVehicles], newPlate)
						TriggerServerEvent('esx_vehicleshop:rentVehicle', model, vehicleProps.plate, GetPlayerName(closestPlayer), CurrentVehicleData.price, amount, GetPlayerServerId(closestPlayer))

						if Config.EnableOwnedVehicles then
							TriggerServerEvent('esx_vehicleshop:setVehicleOwnedPlayerId', GetPlayerServerId(closestPlayer), vehicleProps)
							TriggerServerEvent('esx_vehiclelock:registerkey', vehicleProps.plate, GetPlayerServerId(closestPlayer))
						end

						ESX.ShowNotification(_U('vehicle_set_rented', vehicleProps.plate, GetPlayerName(closestPlayer)))
						TriggerServerEvent('esx_vehicleshop:setVehicleForAllPlayers', vehicleProps, Config.Zones.ShopInside.Pos.x, Config.Zones.ShopInside.Pos.y, Config.Zones.ShopInside.Pos.z, 5.0)
					end
				end
			end, function (data2, menu2)
				menu2.close()
			end)
		end
	end, function (data, menu)
		menu.close()

		CurrentAction = 'reseller_menu'
		CurrentActionMsg = _U('shop_menu')
		CurrentActionData = {}
	end)
end

function Messagecardealer()
	Citizen.CreateThread(function()
    while messagecardealernotfinish do
    		Citizen.Wait(10)
			DisplayOnscreenKeyboard(1, "FMMC_MPM_NA", "", "", "", "", "", 150)
		    while (UpdateOnscreenKeyboard() == 0) do
		        DisableAllControlActions(0);
		       Citizen.Wait(1)
		    end
		    if (GetOnscreenKeyboardResult()) then
		        local result = GetOnscreenKeyboardResult()
		        messagecardealernotfinish = false
		        TriggerServerEvent('clp_cardealer:annoncecardealer',result)   
		    end
		end
	end)
end

function OpenPopVehicleMenu()
	ESX.TriggerServerCallback('esx_vehicleshop:getCommercialVehicles', function (vehicles)
		local elements = {}

		for i=1, #vehicles, 1 do
			table.insert(elements, {
				label = ('%s [MSRP <span style="color:green;">%s</span>]'):format(vehicles[i].name, _U('generic_shopitem', ESX.Math.GroupDigits(vehicles[i].price))),
				value = vehicles[i].name
			})
		end

		ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'commercial_vehicles', {
			css = 'autoshop',
			title = _U('vehicle_dealer'),
			align = 'top-left',
			elements = elements
		}, function (data, menu)
			local model = data.current.value

			DeleteShopInsideVehicles()

			ESX.Game.SpawnVehicle(model, Config.Zones.ShopInside.Pos, Config.Zones.ShopInside.Heading, function (vehicle)
				--local plate = GetVehicleNumberPlateText(vehicles)
				--TriggerServerEvent('esx_vehiclelock:givekey', 'no', plate) -- vehicle lock
				table.insert(LastVehicles, vehicle)


				for i=1, #Vehicles, 1 do
					if model == Vehicles[i].model then
						CurrentVehicleData = Vehicles[i]
						break
					end
				end
			end)
		end, function (data, menu)
			menu.close()
		end)
	end)
end

function OpenRentedVehiclesMenu()
	ESX.TriggerServerCallback('esx_vehicleshop:getRentedVehicles', function (vehicles)
		local elements = {}

		for i=1, #vehicles, 1 do
			table.insert(elements, {
				label = ('%s: %s - <span style="color:orange;">%s</span>'):format(vehicles[i].playerName, vehicles[i].name, vehicles[i].plate),
				value = vehicles[i].name
			})
		end

		ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'rented_vehicles', {
			css = 'autoshop',
			title = _U('rent_vehicle'),
			align = 'top-left',
			elements = elements
		}, nil, function (data, menu)
			menu.close()
		end)
	end)
end

function OpenBossActionsMenu()
	ESX.UI.Menu.CloseAll()

	ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'reseller',{
		css = 'autoshop',
		title = _U('dealer_boss'),
		align = 'top-left',
		elements = {
			{label = _U('boss_actions'), value = 'boss_actions'},
			--{label = _U('boss_sold'), value = 'sold_vehicles'}
	}}, function (data, menu)
		if data.current.value == 'boss_actions' then
			TriggerEvent('esx_society:openBossMenu', 'cardealer', function(data2, menu2)
				menu2.close()
			end)
		elseif data.current.value == 'sold_vehicles' then

			ESX.TriggerServerCallback('esx_vehicleshop:getSoldVehicles', function(customers)
				local elements = {
					head = { _U('customer_client'), _U('customer_model'), _U('customer_plate'), _U('customer_soldby'), _U('customer_date') },
					rows = {}
				}

				for i=1, #customers, 1 do
					table.insert(elements.rows, {
						data = customers[i],
						cols = {
							customers[i].client,
							customers[i].model,
							customers[i].plate,
							customers[i].soldby,
							customers[i].date
						}
					})
				end

				ESX.UI.Menu.Open('list', GetCurrentResourceName(), 'sold_vehicles', elements, function(data2, menu2)

				end, function(data2, menu2)
					menu2.close()
				end)
			end)
		end

	end, function (data, menu)
		menu.close()

		CurrentAction = 'boss_actions_menu'
		CurrentActionMsg = _U('shop_menu')
		CurrentActionData = {}
	end)
end

function OpenGetStocksMenu()
	ESX.TriggerServerCallback('esx_vehicleshop:getStockItems', function (items)
		local elements = {}

		for i=1, #items, 1 do
			table.insert(elements, {
				label = 'x' .. items[i].count .. ' ' .. items[i].label,
				value = items[i].name
			})
		end

		ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'stocks_menu', {
			css = 'autoshop',
			title = _U('dealership_stock'),
			align = 'top-left',
			elements = elements
		}, function (data, menu)
			local itemName = data.current.value

			ESX.UI.Menu.Open('dialog', GetCurrentResourceName(), 'stocks_menu_get_item_count', {
				title = _U('amount')
			}, function (data2, menu2)
				local count = tonumber(data2.value)

				if count == nil then
					ESX.ShowNotification(_U('quantity_invalid'))
				else
					TriggerServerEvent('esx_vehicleshop:getStockItem', itemName, count)
					menu2.close()
					menu.close()
					OpenGetStocksMenu()
				end
			end, function (data2, menu2)
				menu2.close()
			end)

		end, function (data, menu)
			menu.close()
		end)
	end)
end

function OpenPutStocksMenu()
	ESX.TriggerServerCallback('esx_vehicleshop:getPlayerInventory', function (inventory)
		local elements = {}

		for i=1, #inventory.items, 1 do
			local item = inventory.items[i]

			if item.count > 0 then
				table.insert(elements, {
					label = item.label .. ' x' .. item.count,
					type = 'item_standard',
					value = item.name
				})
			end
		end

		ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'stocks_menu', {
			css = 'inventaire',
			title = _U('inventory'),
			align = 'top-left',
			elements = elements
		}, function (data, menu)
			local itemName = data.current.value

			ESX.UI.Menu.Open('dialog', GetCurrentResourceName(), 'stocks_menu_put_item_count', {
				title = _U('amount')
			}, function (data2, menu2)
				local count = tonumber(data2.value)

				if count == nil then
					ESX.ShowNotification(_U('quantity_invalid'))
				else
					TriggerServerEvent('esx_vehicleshop:putStockItems', itemName, count)
					menu2.close()
					menu.close()
					OpenPutStocksMenu()
				end
			end, function (data2, menu2)
				menu2.close()
			end)
		end, function (data, menu)
			menu.close()
		end)
	end)
end

RegisterNetEvent('esx:setJob')
AddEventHandler('esx:setJob', function (job)
	ESX.PlayerData.job = job

	if Config.EnablePlayerManagement then
		if ESX.PlayerData.job.name == 'cardealer' then
			Config.Zones.ShopEntering.Type = 1

			if ESX.PlayerData.job.grade_name == 'boss' then
				Config.Zones.BossActions.Type = 1
			end
		else
			Config.Zones.ShopEntering.Type = -1
			Config.Zones.BossActions.Type = -1
		end
	end
end)

AddEventHandler('esx_vehicleshop:hasEnteredMarker', function (zone)
	if zone == 'ShopEntering' then

		if Config.EnablePlayerManagement then
			if ESX.PlayerData.job ~= nil and ESX.PlayerData.job.name == 'cardealer' then
				CurrentAction = 'reseller_menu'
				CurrentActionMsg = _U('shop_menu')
				CurrentActionData = {}
			end
		else
			CurrentAction = 'shop_menu'
			CurrentActionMsg = _U('shop_menu')
			CurrentActionData = {}
		end

	elseif zone == 'GiveBackVehicle' and Config.EnablePlayerManagement then

		local playerPed = PlayerPedId()

		if IsPedInAnyVehicle(playerPed, false) then
			local vehicle = GetVehiclePedIsIn(playerPed, false)

			CurrentAction = 'give_back_vehicle'
			CurrentActionMsg = _U('vehicle_menu')
			CurrentActionData = {vehicle = vehicle}
		end

	elseif zone == 'ResellVehicle' then

		local playerPed = PlayerPedId()

		if IsPedSittingInAnyVehicle(playerPed) then

			local vehicle = GetVehiclePedIsIn(playerPed, false)
			local vehicleData, model, resellPrice, plate

			if GetPedInVehicleSeat(vehicle, -1) == playerPed then
				for i=1, #Vehicles, 1 do
					if GetHashKey(Vehicles[i].model) == GetEntityModel(vehicle) then
						vehicleData = Vehicles[i]
						break
					end
				end

				resellPrice = ESX.Math.Round(vehicleData.price / 100 * Config.ResellPercentage)
				model = GetEntityModel(vehicle)
				plate = ESX.Math.Trim(GetVehicleNumberPlateText(vehicle))

				CurrentAction = 'resell_vehicle'
				CurrentActionMsg = _U('sell_menu', vehicleData.name, ESX.Math.GroupDigits(resellPrice))

				CurrentActionData = {
					vehicle = vehicle,
					label = vehicleData.name,
					price = resellPrice,
					model = model,
					plate = plate
				}
			end

		end

	elseif zone == 'BossActions' and Config.EnablePlayerManagement and ESX.PlayerData.job ~= nil and ESX.PlayerData.job.name == 'cardealer' and ESX.PlayerData.job.grade_name == 'boss' then

		CurrentAction = 'boss_actions_menu'
		CurrentActionMsg = _U('shop_menu')
		CurrentActionData = {}

	end
end)

AddEventHandler('esx_vehicleshop:hasExitedMarker', function (zone)
	if not IsInShopMenu then
		ESX.UI.Menu.CloseAll()
	end

	CurrentAction = nil
end)

AddEventHandler('onResourceStop', function(resource)
	if resource == GetCurrentResourceName() then
		if IsInShopMenu then
			ESX.UI.Menu.CloseAll()

			DeleteShopInsideVehicles()
			local playerPed = PlayerPedId()

			FreezeEntityPosition(playerPed, false)
			SetEntityVisible(playerPed, true)
			SetEntityCoords(playerPed, Config.Zones.ShopEntering.Pos.x, Config.Zones.ShopEntering.Pos.y, Config.Zones.ShopEntering.Pos.z)
		end
	end
end)

if Config.EnablePlayerManagement then
	RegisterNetEvent('esx_phone:loaded')
	AddEventHandler('esx_phone:loaded', function (phoneNumber, contacts)
		local specialContact = {
			name = _U('dealership'),
			number = 'cardealer',
			base64Icon = 'data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAAAQAAAAEACAMAAABrrFhUAAAAAXNSR0IArs4c6QAAAARnQU1BAACxjwv8YQUAAAMAUExURQAAADMzMzszM0M0M0w0M1Q1M101M2U2M242M3Y3M383Moc4MpA4Mpg5MqE5Mqk6MrI6Mro7Mrw8Mr89M71DML5EO8I+NMU/NcBMLshANctBNs5CN8RULMddKsheKs9YLtBCONZEOdlFOtxGO99HPNhMNsplKM1nKM1uJtRhLddiLt5kMNJwJ9B2JNR/IeNIPeVJPehKPuRQOuhSO+lZOOlhNuloM+p3Lep/KupwMMFORsVYUcplXc1waNJ7delUSepgVexrYe12bdeHH9iIH9qQHd2YG+udH+OEJeuGJ+uOJeuVIuChGeSpF+aqGOykHOysGeeyFeuzFuyzFuq6E+27FO+Cee3CEdaGgdqTjvCNhfKYkvOkngAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAJezdycAAAEAdFJOU////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////wBT9wclAAAACXBIWXMAAA7DAAAOwwHHb6hkAAAAGHRFWHRTb2Z0d2FyZQBwYWludC5uZXQgNC4xLjb9TgnoAAAQGElEQVR4Xt2d+WMUtxXHbS6bEGMPMcQQ04aEUnqYo9xJWvC6kAKmQLM2rdn//9+g0uir2Tl0PElPszP7+cnH7Fj6rPTeG2lmvfKld2azk8lk/36L/cnkZDbDIT3Sp4DZ8QS9dTI57tNDTwJOOu+4j/0TvDQz+QXMSG+7mUn+sZBZQELnNROcKhMZBXx+gS4k8+IzTpmBXAJOnqPxTDzPFRKyCODuvSKPgwwC2EZ+lxf4E4xwCzhBU7PBPQx4BWR88+fwDgNGAbMsM9/Ec8bygE3A5966L3nOlhiZBGSf+l2YggGLgBna1DMsE4FBQH9zvw1HLEgX0Evkt5GeEVIFMFztpJF6rZQm4DNasVDSEkKSgIVN/ibP0ZwoEgQsfPTPSZgH8QIG8vYr4gdBrIABvf2K2EEQKWBQb78ichBECRhE8O8SlQ5iBAQvcffFPhoYQoSAAQ5/TcQ0CBYw0OGvCZ4GoQIGF/3bhGaDQAELvfKhERgIwgQMePrPCQsEQQLwFwYPmksiQMCC1n1iCFgooQtYwLJfPPQFQ7KAUfU/wABVwMj6TzdAFDDY6tcOMR3SBIyw/1QDJAGj7D/RAEXA6Oa/hhIHCAJG23+SAb+AEfefYsArYET1nwlvTegVgBONFnTDik8ATjNi0BEbHgGjuP5147k6dgsYaQHQxF0OOAUMfv2LhnOVzCVg4OufdFwrpS4BePkSgA6ZcAhYggCocQRCu4ClCIAaeyC0CliaAKCwhgGrALxwaUC3OtgELFEAUNjCgEXAklQAdSzVgEUAXrRUoGstzAKWbgJIzJPAKGAJJ4DEOAmMAvCCpQPda2ASsJQTQGKaBAYBS1YC1TGUQwYBOHgpQRdrdAUsaQRUdONgVwAOXVLQyTkdASO4CyiFzhMWbQEj3wbw094oaAtY2hSoaafCloClHwCdIdASgIOWGnQVNAWMeiOUSnPDtCkAh3Dz2MBD/G4BoLOKhgD2AfDo6Zv3v32y89v7929eP3n8AIf3RKMgbghgTQEPn/56hH56OXr/+ll/FhqJoC6AMwU8+RV9o/Ph6SO8ODf1RFAXwDcAnrjGvYMPT3sZB/UhUBeAXyfz+AP6E8HR2z6iIzosqQngugp4g77E8jr/KKhdEdQE4JeJPHiPfhCZHn7EVxVHz3CufKDLgrkAnhz4QA//6as7t653ead+uye/3i4qrt8+qHt4m3sQzIuhuQD8Kg3d///8FT1rc6h+fx3f1tk9mKpfCv79h7s4YybQaW4Buv//uoROdXAIKIrtvUrBdPcazpkHdLomgCUEquR/9Gd0yIBTgFBwoH4vDVy9h7PmoAqDlQD8IomnZdOPfo/emPAIENFAx4Lp7pWcBtDtSgBHCHykWm6b/iVeAcU24qQwcOkmzpwBHQa1AI4qUCXAf6IjZvwCiuKlOubTx+1LP+DU/OhqUAvAj1N4glajG2YoAioD74riBk7ODzoOARwzQNX/t9EJCyQBlYGXRZEtGWAOQADDDMAAQBds0AQUOg7cKopcyQBzAALwwxRIA4AqYBu5YLpTFFcy1USq50oAw36oGgBTdMAKUUCxq477dCi+zpQM1MKQEsBQBakUcKCab4cqoNhTB37aE19fyhIKVS2kBOBHCTxUzd1VrbdDFqCPnJZZJYuBsutcAtQigC8EhgjYwXXBq/K7HMmg7HopgGFHXIVAkbY80AUUd9ShOPZb/mRQ7pWXAvCDBFAFi6zlIUBAgUwgyiFJhmTAKEBdBn1yV4GSEAHX1bE6tfInAy2AYTlc5QC8Vy5CBBSv1ME6srAnA7k8LgUwhADVUhWvnAQJ2FEHz6srZgMyCEgB+DaBx6qhd9BOB0EC9DWBSoUS5mTAJuC1aqivDhaECdCpcG6Wd5GETQCWwgndChOgU+F8CBRXOEOhEsBwKYxdUH4B250hwJoMxCWxEJD+cBDq4E9oootAAYYhwBkK90sB+CYBxMAcAgxDoCi+x99Nh0kAYmAOAcYhwJcMmARgO1Reu/sIFmAcAmzJQApgqwPzCKiGAL4FTMlgJgQc4+sEsCGWR4AeAq0i49KP+ONJHAsBbIUwpRKOEKCHQGetgSMZTIQAfJmCaiGlEo4RoBdIO9fa3+HPp8AiQGfBTAKK2+o13QF2LT0UjkKAXhnZwbdz0pPBOATsqRft4dsa36Qmgy8rDFkQy0H5BGBdwLTekpoMZhwCdCHoXxGMFGCfA4K0ZDBbYbgW1AIovYoTgIUR83pDUjI4WWEoA/ILsOaBkpRkMBmHAOwU2vZdEpLBZIXho0LyCyjUq6yXm/GLJPsr+ILOQzzxMEffGJ5RAF5W3l9p4nd/UU15dP/+3bDhECjg4VvHMwAZBehbRrwcvf1bWG0QJuCZ8xGIjAJwQUTh6I9BGyhBArADaMO7Ny6IFKB3yUjshmTGIAGexyAwH53Ub5YOAHmQhkgW9LwQIkDdBTMCRMFEzgshAt7i/IOnvE2BGAhCBGDpb/iotTlagRgigPwU3KLBGjrplooAAaMJAdVVE+VW4wAB4U8CLozqosG/h0QXoDcAR0FVZ3hvtKUL0Os+o2B+4ewrjOkCIh8GXRDzxSNPYUwW4CmDh0b9nl1nYUwWMJoqSNHYSnTdZEleEBlNEQAa64f2wnifuiQ2oiJA0VpDtwUC8prgiIoA0LrithTGE+Ky+KiKAEX7xm1zYXxC3BgZVREA2tsoxk0k6s7QuIoARXenzlAYz2ibo/Qi4PDwUD/xlYF34vS4YcSPYRehWxgTd4dJHwrx7o6OOzu3XpKbSWX68rYe09f3aI4NO2mdW4uIAvxFwPSgNeVuYfmTh8NWZ3buEAyb7llqF8Y0Ac9wRjsHjdv4FHoBNJ2PhkXkbcJKuXGZulkYCwGEQsBXBHy0LIgHrOa7sNx3sOsVbH6EqV4Yy5uk/LfJPcD5bLwyvP2KXYZQMLXvIXj3i8wNqxXG8jY5fx70FAENz5sbG1v4UuJ/l3xM66Nrq3l2rwHDTTUlVSCQN0r6g4D7c5Gq/m9dOHd6teTM+tf4WfXIQyzz/n+9dgZnX6vO7jNg20+vbjYm3SvsLgJ0qN1cU80Dp8/jrUqcBRj/W+dP4cQlp9Y31c/1c1U2rHftoDAmCXAWAViB3lpH0+acxvuEW7ziQPxrdl9y6rz6jb6L0oL97l1VGJcCfCsCziJAKb6Isd9kTQ2ChIJAXdNuncUJG5xRZ/dsmxrvq1KIQKAemPBcDzqLAGX4QucNUqg26offIignwEXL2U9dlL/1hAFzJlRcvacemfHMAWcRULbwa7SoizJAvruhTanX1n9twO23+aBFiyuUp8acRYCnhaurZ+UB0UNA6t1C7DdxuvTrjoOGC4I5FAHOIqA8u6OFq6tlrIosBsokdg4nMnJOHnELh5uxZkIJBDiLYX0LmBE5vs6jMRZkvopMBHJpewOnsVBmGneilUdY+AUCnLWgazVUzoAtxwSQrIlj9AeCBCJngDG9zDkt++GcA/ZEWBT/gwDnHHDFAJmlPQNADYG4Yki80B5fwQVxkPOay3IlVSL77hXg2hGRIcDzFq2urouDokoBWQQ4I4BERgFXKeDMApUAZxB4YF8PFGPUM0cFcpR6ClYzYvBu4RwORCJwCXAlARkClABPIrReDAkB3hlQzoGohQEhwDsDVBjECwz4kiBJgMgElkEgBBir1CaiiVECXpH0yjyLF7SZvnQUwoKy60qA94OUHvwJN+w1EPPLWQQoRBN38IIgxIVw8wrTSBkEjFiWqSp+KruuBBA+SusGXtYCzXCB67YYCOOrrDWj+G/ZdSXANwckN40flIpmuBiqANVzCKB8nN7dK3hlHTTDxUAFXFY9hwDSFum9a3htDVoMiMVbBiQI+IfqOQRQ5oCgGwhoWSAWYhaIAh3XAogfKfljOxAQmqjWLaIg1AGyFo4BM6ASQH16rh0I/E0sr1ciIVSCenU0FMyASgBxDnQDgediUF0ORuMNMWdwYDDo9lwA/UMlm4HAW6skzICiuICTWImdAaoKElQCyEOgFQg20RIb8Xm6xDPATqml4XDQ6TgBzUDgGQIbOCwSzxD4CocFg07XBYQ8RFwPBO4lIbkakIQzz0ZHAB0C6wJChkAjELiWBLB7kcCmw++p2BQwHwB1AWGfrVsLBPZhir2LJC7iXAaip1cVAhsCwoZAPRDYDHD0377vFJ0B6gOgISDwA8ZrgcDcxjPRI7SJeeclwa6uAiV1AcEfJjEPBJuGWJVwEdRiy3BRdC4husjlcE1dQPhnzNcDQWt5eI3p7VdstASfTcmu9QHQFBD+Gev1iuDieuXg7Fes3Zdsrldl8Znq9og41FIQaAgIDIOS5qXB1oaEJfSZKM+eWFkJ0FlFU0BIMaSxLBYOl3kRJGkKiBgChjWCYdOIAB0BwYlAYlwsHCz1FCBoCYj7ZyOmxcKh0hoAHQFRQ2BMgaA1ADoCYv/bxlgCQe0qQNEREBUHBTfHEQjQyTldAcTHyDrcu4q/MWTKHfEGXQGxQ+D+/e/xVwYMuljDICD+nw79MPRA0CiCFQYBcamwZOCBoJ0CJSYB8ZNg4IEA3WtgFBAbByUDDgTdCCgwCkiYBAMOBKYJYBOQMAmGGwjQtRYWASmTYKCBwDgBrAKSJsEgA4F5AtgFJE2CIQYCdKuDVUDi/2AcWiAwlEAKq4DU/70yrEDwMzrVxS4gMQwMKhDYAoDAISAxDAwpEKBDJlwCkv8V61ACgTUACFwC0qoByTACgaUCUDgFMPwTqgEEAnsAlLgFJAfCAQQCRwCUeAQkB8LFBwJ0xIZPAIOBxQYCdMOKV0DkRkGDBQaC9jZAB6+AqA3TNgsLBM2NUBN+ASwGbn6DFvWLv/8UASwG7n2LNvUJof8kAQzlgOA7tKo/nAWQhiSAx8CNngOBuwDS0ATwGOg3END6TxXAEgd6DQSU+S+hCuAx0F8goPafLoDJQE+BgNz/AAEsNWFPgcBb/80JEMBxXSDoIRCguSSCBDBcHUsyBwLP9W+LMAE86TBvICCmP02ggPRVspKMgYBU/tUIFZC+UlqSLRC41j+NBAsYdCAIm/4lEQKGGwgCp39JjACmacAeCIKHvyRKANM04A0EEcNfEimAKRswBoK/o2GhxApgGgRcgSDy7RfEC+AZBDyBIDT510gQwDMIGAJB/NsvSBLAkw5SA0FU8K9IE8AzD5ICQcLoL0kVEP2ERR3zZzRR6Dz/EEy6gC+z9FBwL24D9XLAwocNBgEsa0URj11xdJ9JAMeCYfBjV/RlPydMAkRCSJ0IQYGA592XsAlIjwX0QMDXfVYBgsSMQAsE6ZG/Dq+A1GBACARMU7+CW4AgZRh4AgHvm1+SQYAYBvHRwBEILnO/+SVZBAjiHZgDQZ7eC3IJEHyOnAvdQPBT2vWOk4wCJFHXSs1AkHq14yGzAMEsXEIVCH5hTPgW8gsoOQlcSr9W/Jxr0rfoSUDJ7Jg0GCbHM7ygD/oUAGazk8mkMyL2J5OTWZ89L/ny5f+yiDXCPYKoAQAAAABJRU5ErkJggg==',
		}

		TriggerEvent('esx_phone:addSpecialContact', specialContact.name, specialContact.number, specialContact.base64Icon)
	end)
end

-- Display markers
Citizen.CreateThread(function()
	while true do		
		attente = 500

		local coords = GetEntityCoords(PlayerPedId())

		for k,v in pairs(Config.Zones) do
			if(v.Type ~= -1 and GetDistanceBetweenCoords(coords, v.Pos.x, v.Pos.y, v.Pos.z, true) < 10) and not IsPedInAnyVehicle(GetPlayerPed(-1), false) then
				attente = 1
				DrawMarker(25, v.Pos.x, v.Pos.y, v.Pos.z, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 1.2, 1.2, 1.0, 0, 121, 255, 100, false, true, 2, false, false, false, false)
			elseif IsPedInAnyVehicle(GetPlayerPed(-1), false) then 
				attente = 2500
			end
		end
		Wait(attente)
	end
end)

-- Enter / Exit marker events
Citizen.CreateThread(function ()
	while true do		
		attente = 500

		local coords = GetEntityCoords(PlayerPedId())
		local isInMarker = false
		local currentZone = nil

		for k,v in pairs(Config.Zones) do
			if(GetDistanceBetweenCoords(coords, v.Pos.x, v.Pos.y, v.Pos.z, true) < v.Size.x) and not IsPedInAnyVehicle(GetPlayerPed(-1), false) then
				attente = 1
				isInMarker = true
				currentZone = k
			elseif IsPedInAnyVehicle(GetPlayerPed(-1), false) then 
				attente = 2500
			end
		end

		if (isInMarker and not HasAlreadyEnteredMarker) or (isInMarker and LastZone ~= currentZone) then
			attente = 1
			HasAlreadyEnteredMarker = true
			LastZone                = currentZone
			TriggerEvent('esx_vehicleshop:hasEnteredMarker', currentZone)
		end

		if not isInMarker and HasAlreadyEnteredMarker then
			attente = 1
			HasAlreadyEnteredMarker = false
			TriggerEvent('esx_vehicleshop:hasExitedMarker', LastZone)
		end
		Wait(attente)
	end
end)

-- Key controls
Citizen.CreateThread(function()
	while true do
		Citizen.Wait(10)

		if CurrentAction == nil then
			Citizen.Wait(500)
		else
			ESX.ShowHelpNotification(CurrentActionMsg)

			if IsControlJustReleased(0, 38) then
				if CurrentAction == 'shop_menu' then
					if Config.LicenseEnable then
						ESX.TriggerServerCallback('esx_license:checkLicense', function(hasDriversLicense)
							if hasDriversLicense then
								OpenShopMenu()
							else
								ESX.ShowNotification(_U('license_missing'))
							end
						end, GetPlayerServerId(PlayerId()), 'drive')
					else
						OpenShopMenu()
					end
				elseif CurrentAction == 'reseller_menu' then
					OpenResellerMenu()
				elseif CurrentAction == 'give_back_vehicle' then
					ESX.TriggerServerCallback('esx_vehicleshop:giveBackVehicle', function(isRentedVehicle)
						if isRentedVehicle then
							ESX.Game.DeleteVehicle(CurrentActionData.vehicle)
							ESX.ShowNotification(_U('delivered'))
						else
							ESX.ShowNotification(_U('not_rental'))
						end
					end, ESX.Math.Trim(GetVehicleNumberPlateText(CurrentActionData.vehicle)))
				elseif CurrentAction == 'resell_vehicle' then
					ESX.TriggerServerCallback('esx_vehicleshop:resellVehicle', function(vehicleSold)
						if vehicleSold then
							ESX.Game.DeleteVehicle(CurrentActionData.vehicle)
							ESX.ShowNotification(_U('vehicle_sold_for', CurrentActionData.label, ESX.Math.GroupDigits(CurrentActionData.price)))
						else
							ESX.ShowNotification(_U('not_yours'))
						end
					end, CurrentActionData.plate, CurrentActionData.model)
				elseif CurrentAction == 'boss_actions_menu' then
					OpenBossActionsMenu()
				end

				CurrentAction = nil
			end
		end
	end
end)

RegisterCommand("givecarkey", function()
	local pPed = GetPlayerPed(-1)
	local pCoords = GetEntityCoords(pPed)
	local pCar = GetClosestVehicle(pCoords, 5.0, 0, 71)
	local pPlate = GetVehicleNumberPlateText(pCar)
	local closestPlayer, closestDistance = ESX.Game.GetClosestPlayer()
	local vehProps = ESX.Game.GetVehicleProperties(pCar)
	local VehName = GetDisplayNameFromVehicleModel(GetEntityModel(pCar))

	print (pPlate)
	print(VehName)
	
	if closestPlayer == -1 or closestDistance > 3.0 then
		ShowAboveRadarMessage(_U('no_players'))
	else
		if pCar then 
			ESX.TriggerServerCallback("clp_vapid:isVehicleValid1", function(valid)
				if valid then
					TriggerServerEvent('esx_vehiclelock:registerkey', pPlate, GetPlayerServerId(closestPlayer))
				else
					ShowAboveRadarMessage("~r~Le véhicule ne vous appartient pas.")
				end
			end, vehProps, VehName)
		else 
			ShowAboveRadarMessage("~r~Aucun véhicule à proximité.")
		end
	end
end)
