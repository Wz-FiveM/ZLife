local OwnedProperties, Blips, CurrentActionData = {}, {}, {}
local CurrentProperty, CurrentPropertyOwner, LastProperty, LastPart, CurrentAction, CurrentActionMsg
local firstSpawn, hasChest, hasAlreadyEnteredMarker = true, false, false
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

	PlayerLoaded = true
	ESX.PlayerData = ESX.GetPlayerData()
end)


RegisterNetEvent('esx:playerLoaded')
AddEventHandler('esx:playerLoaded', function(xPlayer)
	ESX.TriggerServerCallback('esx_property:getProperties', function(properties)
		Config.Properties = properties
	end)

	ESX.TriggerServerCallback('esx_property:getOwnedProperties', function(result)
		for k,v in ipairs(result) do
			SetPropertyOwned(v.name, true, v.rented)
		end
	end)
end)

-- only used when script is restarting mid-session
RegisterNetEvent('esx_property:sendProperties')
AddEventHandler('esx_property:sendProperties', function(properties)
	Config.Properties = properties

	ESX.TriggerServerCallback('esx_property:getOwnedProperties', function(result)
		for k,v in ipairs(result) do
			SetPropertyOwned(v.name, true, v.rented)
		end
	end)
end)

function GetProperties()
	return Config.Properties
end

function GetProperty(name)
	for i=1, #Config.Properties, 1 do
		if Config.Properties[i].name == name then
			return Config.Properties[i]
		end
	end
end

function GetGateway(property)
	for i=1, #Config.Properties, 1 do
		local property2 = Config.Properties[i]

		if property2.isGateway and property2.name == property.gateway then
			return property2
		end
	end
end

function GetGatewayProperties(property)
	local properties = {}

	for i=1, #Config.Properties, 1 do
		if Config.Properties[i].gateway == property.name then
			table.insert(properties, Config.Properties[i])
		end
	end

	return properties
end

local propertyentername = nil

function EnterProperty(name, owner)
	local property       = GetProperty(name)
	local playerPed      = PlayerPedId()
	CurrentProperty      = property
	CurrentPropertyOwner = owner

	local f6qbO = LocalPlayer()
	local kk = f6qbO.Ped;

	for i=1, #Config.Properties, 1 do
		if Config.Properties[i].name ~= name then
			Config.Properties[i].disabled = true
		end
	end

	TriggerServerEvent('esx_property:saveLastProperty', name)

	Citizen.CreateThread(function()
		DoScreenFadeOut(50)

		while not IsScreenFadedOut() do
			Citizen.Wait(0)
		end

		for i=1, #property.ipls, 1 do
			RequestIpl(property.ipls[i])

			while not IsIplActive(property.ipls[i]) do
				Citizen.Wait(0)
			end
		end

		propertyentername = property.name
		setEntCoords(vector3(property.inside.x, property.inside.y, property.inside.z), kk, true)
		NetworkSetVoiceChannel(propertyentername)
		DoScreenFadeIn(50)
		drawCenterText(property.label, 2500)
	end)

end

function ExitProperty(name)
	local property  = GetProperty(name)
	local playerPed = PlayerPedId()
	local outside   = nil
	CurrentProperty = nil
	local f6qbO = LocalPlayer()
	local kk = f6qbO.Ped;

	if property.isSingle then
		outside = property.outside
	else
		outside = GetGateway(property).outside
	end

	TriggerServerEvent('esx_property:deleteLastProperty')

	Citizen.CreateThread(function()
		DoScreenFadeOut(50)

		while not IsScreenFadedOut() do
			Citizen.Wait(0)
		end

		NetworkClearVoiceChannel()
		setEntCoords(vector3(outside.x, outside.y, outside.z), kk, true)


		for i=1, #property.ipls, 1 do
			RemoveIpl(property.ipls[i])
		end

		for i=1, #Config.Properties, 1 do
			Config.Properties[i].disabled = false
		end

		DoScreenFadeIn(50)
		propertyentername = nil
	end)
end

function SetPropertyOwned(name, owned, rented)
	local property     = GetProperty(name)
	local entering     = nil
	local enteringName = nil

	if property.isSingle then
		entering     = property.entering
		enteringName = property.name
		garage = property.garage
	else
		local gateway = GetGateway(property)
		entering      = gateway.entering
		enteringName  = gateway.name
		garage = property.garage
	end

	if owned then
		OwnedProperties[name] = rented
		RemoveBlip(Blips[enteringName])

		Blips[enteringName] = AddBlipForCoord(entering.x, entering.y, entering.z)
		SetBlipSprite(Blips[enteringName], 357)
		SetBlipAsShortRange(Blips[enteringName], true)
		SetBlipDisplay(Blips[enteringName], 2)
		SetBlipScale  (Blips[enteringName], 0.7)
		SetBlipColour(Blips[enteringName],25)

		BeginTextCommandSetBlipName("STRING")
		AddTextComponentSubstringPlayerName("Votre propriété")
		EndTextCommandSetBlipName(Blips[enteringName])

		BlipsGarage = AddBlipForCoord(garage.x, garage.y, garage.z)
		SetBlipSprite(BlipsGarage, 357)
		SetBlipAsShortRange(BlipsGarage, true)
		SetBlipDisplay(BlipsGarage, 2)
		SetBlipScale  (BlipsGarage, 0.65)
		SetBlipColour(BlipsGarage, 67)

		BeginTextCommandSetBlipName("STRING")
		AddTextComponentSubstringPlayerName("Garage")
		EndTextCommandSetBlipName(BlipsGarage)
	else
		OwnedProperties[name] = nil
		local found = false

		for k,v in pairs(OwnedProperties) do
			local _property = GetProperty(k)
			local _gateway  = GetGateway(_property)

			if _gateway then
				if _gateway.name == enteringName then
					found = true
					break
				end
			end
		end

		if not found then
			RemoveBlip(Blips[enteringName])
			RemoveBlip(BlipsGarage)
		end
	end
end

function PropertyIsOwned(property)
	return OwnedProperties[property.name] ~= nil
end

function OpenPropertyMenu(property)
	local elements = {}

	if PropertyIsOwned(property) then
		table.insert(elements, {label = "Ouvrir la porte", value = 'enter'})
		table.insert(elements, {label = "Donner les clés de la propriété", value = 'give_property1'})

		-- add move out
		if not Config.EnablePlayerManagementP then
			local leaveLabel = "Rendre les clés"

			if not OwnedProperties[property.name] then
				leaveLabel = 'Vendre la propriétée pour : <span style="color:green;">'..ESX.Math.GroupDigits(ESX.Math.Round(property.price / Config.SellModifier))..'$</span>'
			end

			table.insert(elements, {label = leaveLabel, value = 'leave'})
		end
	else

		table.insert(elements, {label = "Visiter la propriété", value = 'visit'})

		if ESX.PlayerData.job and ESX.PlayerData.job.name == 'realestateagent' then 
			table.insert(elements, {label = "Donner les clés de la propriété", value = 'give_property'})
			table.insert(elements, {label = "Donner la location de la propriétée", value = 'give_rent'})
			table.insert(elements, {label = "Acheter pour soi même", value = 'enterinvbuy'})
			table.insert(elements, {label = "Supprimer la propriété", value = 'sup_property'})
		end
	end

	ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'property', {
		css    = 'propriete',
		title    = property.label,
		align    = 'top-left',
		elements = elements
	}, function(data, menu)
		menu.close()

		if data.current.value == 'enter' then
			TriggerEvent('instance:create', 'property', {property = property.name, owner = ESX.GetPlayerData().identifier})
		elseif data.current.value == 'leave' then
			TriggerServerEvent('esx_property:removeOwnedProperty', property.name)
		elseif data.current.value == 'buy' then
			TriggerServerEvent('esx_property:buyProperty', property.name)
		elseif data.current.value == 'enterinvbuy' then 
			TriggerServerEvent('esx_property:buyProperty', property.name)
		elseif data.current.value == 'rent' then
			TriggerServerEvent('esx_property:rentProperty', property.name)
		elseif data.current.value == 'visit' then
			TriggerEvent('instance:create', 'property', {property = property.name, owner = ESX.GetPlayerData().identifier})
		elseif data.current.value == 'give_rent' then
			local closestPlayer, closestDistance = ESX.Game.GetClosestPlayer()
			if closestPlayer == -1 or closestDistance > 3.0 then
				ESX.ShowNotification("~b~Distance\n~w~Rapprochez-vous.")
			else
				TriggerServerEvent('givepropertykey:rent', GetPlayerServerId(closestPlayer), property.name, property.price)
			end
		elseif data.current.value == 'give_property' then
			local closestPlayer, closestDistance = ESX.Game.GetClosestPlayer()
			if closestPlayer == -1 or closestDistance > 3.0 then
				ESX.ShowNotification("~b~Distance\n~w~Rapprochez-vous.")
			else
				TriggerServerEvent('givepropertykey:sell', GetPlayerServerId(closestPlayer), property.name, property.price)
			end
		elseif data.current.value == 'give_property1' then
			local closestPlayer, closestDistance = ESX.Game.GetClosestPlayer()
			if closestPlayer == -1 or closestDistance > 3.0 then
				ESX.ShowNotification("~b~Distance\n~w~Rapprochez-vous.")
			else
				TriggerServerEvent('givepropertykey:sell1', GetPlayerServerId(closestPlayer), property.name, property.price)
			end
		elseif data.current.value == 'sup_property' then
			TriggerServerEvent('c_property:delprpopertyname', property.name)
		end
	end, function(data, menu)
		menu.close()

		CurrentAction     = 'property_menu'
		CurrentActionMsg  = "Appuyez sur ~INPUT_CONTEXT~ pour ~b~intéragir avec la propriété"
		CurrentActionData = {property = property}
	end)
end

function OpenGatewayMenu(property)
	if Config.EnablePlayerManagementP then
		OpenGatewayOwnedPropertiesMenu(gatewayProperties)
	else
		ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'gateway', {
			css    = 'propriete',
			title    = property.name,
			align    = 'top-left',
			elements = {
				{label = "Propriétée",    value = 'owned_properties'},
				{label = "Propriétées disponibles", value = 'available_properties'}
		}}, function(data, menu)
			if data.current.value == 'owned_properties' then
				OpenGatewayOwnedPropertiesMenu(property)
			elseif data.current.value == 'available_properties' then
				OpenGatewayAvailablePropertiesMenu(property)
			end
		end, function(data, menu)
			menu.close()

			CurrentAction     = 'gateway_menu'
			CurrentActionMsg  = "Appuyez sur ~INPUT_CONTEXT~ pour ~b~intéragir avec la propriété"
			CurrentActionData = {property = property}
		end)
	end
end

function OpenGatewayOwnedPropertiesMenu(property)
	local gatewayProperties = GetGatewayProperties(property)
	local elements = {}

	for i=1, #gatewayProperties, 1 do
		if PropertyIsOwned(gatewayProperties[i]) then
			table.insert(elements, {
				label = gatewayProperties[i].label,
				value = gatewayProperties[i].name
			})
		end
	end

	ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'gateway_owned_properties', {
		css    = 'propriete',
		title    = property.name .. ' - ' .. "Propriétée",
		align    = 'top-left',
		elements = elements
	}, function(data, menu)
		menu.close()
		local elements = {{label = "Ouvrir la porte", value = 'enter'}}

		if not Config.EnablePlayerManagementP then
			table.insert(elements, {label = "Sortir", value = 'leave'})
		end

		ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'gateway_owned_properties_actions', {
			css    = 'propriete',
			title    = data.current.label,
			align    = 'top-left',
			elements = elements
		}, function(data2, menu2)
			menu2.close()

			if data2.current.value == 'enter' then
				TriggerEvent('instance:create', 'property', {property = data.current.value, owner = ESX.GetPlayerData().identifier})
				ESX.UI.Menu.CloseAll()
			elseif data2.current.value == 'leave' then
				TriggerServerEvent('esx_property:removeOwnedProperty', data.current.value)
			end
		end, function(data2, menu2)
			menu2.close()
		end)
	end, function(data, menu)
		menu.close()
	end)
end

function OpenGatewayAvailablePropertiesMenu(property)
	local gatewayProperties = GetGatewayProperties(property)
	local elements = {}

	for i=1, #gatewayProperties, 1 do
		if not PropertyIsOwned(gatewayProperties[i]) then
			table.insert(elements, {
				label = gatewayProperties[i].label,
				value = gatewayProperties[i].name,
				buyPrice = gatewayProperties[i].price,
				rentPrice = ESX.Math.Round(gatewayProperties[i].price / Config.RentModifier)
			})
		end
	end

	ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'gateway_available_properties', {
		css    = 'propriete',
		title    = property.name .. ' - ' .. "Propriétées disponibles",
		align    = 'top-left',
		elements = elements
	}, function(data, menu)
		ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'gateway_available_properties_actions', {
			css    = 'propriete',
			title    = property.label .. ' - ' .. "Propriétées disponibles",
			align    = 'top-left',
			elements = {
				{label = 'Acheter la propriétée : <span style="color:green;">'..ESX.Math.GroupDigits(data.current.buyPrice)..'$</span>', value = 'buy'},
				{label = 'Louer la propriétée : <span style="color:green;">'..ESX.Math.GroupDigits(data.current.rentPrice)..'$', value = 'rent'}
		}}, function(data2, menu2)
			menu.close()
			menu2.close()

			if data2.current.value == 'buy' then
				TriggerServerEvent('esx_property:buyProperty', data.current.value)
			elseif data2.current.value == 'rent' then
				TriggerServerEvent('esx_property:rentProperty', data.current.value)
			end
		end, function(data2, menu2)
			menu2.close()
		end)
	end, function(data, menu)
		menu.close()
	end)
end

function OpenPropertyInventoryMenu(property, owner)
    ESX.TriggerServerCallback("esx_property:getPropertyInventory", function(inventory)
        TriggerEvent("c_inventaire:openPropertyInventory", inventory)
    end, owner)
end

function OpenRoomMenu(property, owner)
	local entering = nil
	local elements = {{label = "Inviter une personne",  value = 'invite_player'}}

	if property.isSingle then
		entering = property.entering
	else
		entering = GetGateway(property).entering
	end

	if CurrentPropertyOwner == owner then
		--table.insert(elements, {label = "Garde robe", value = 'player_dressing'})
		--table.insert(elements, {label = "Supprimer des tenues", value = 'remove_cloth'})
	end

	table.insert(elements, {label = "Vos objets", value = 'player_inventory'})

	ESX.UI.Menu.CloseAll()

	ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'room', {
		css    = 'propriete',
		title    = property.label,
		align    = 'top-left',
		elements = elements
	}, function(data, menu)

		if data.current.value == 'invite_player' then

			local playersInArea = ESX.Game.GetPlayersInArea(entering, 10.0)
			local elements      = {}

			for i=1, #playersInArea, 1 do
				if playersInArea[i] ~= PlayerId() then
					table.insert(elements, {label = GetPlayerName(playersInArea[i]), value = playersInArea[i]})
				end
			end

			ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'room_invite', {
				css    = 'propriete',
				title    = property.label .. ' - ' .. 'Inviter',
				align    = 'top-left',
				elements = elements,
			}, function(data2, menu2)
				TriggerEvent('instance:invite', 'property', GetPlayerServerId(data2.current.value), {property = property.name, owner = owner})
				ESX.ShowNotification('Vous avez invité ~b~'..GetPlayerName(data2.current.value)..'~s~.')
			end, function(data2, menu2)
				menu2.close()
			end)

		elseif data.current.value == 'player_dressing' then

			ESX.TriggerServerCallback('esx_property:getPlayerDressing', function(dressing)
				local elements = {}

				for i=1, #dressing, 1 do
					table.insert(elements, {
						label = dressing[i],
						value = i
					})
				end

				ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'player_dressing', {
					css    = 'propriete',
					title    = property.label .. ' - ' .. 'Garde robe',
					align    = 'top-left',
					elements = elements
				}, function(data2, menu2)
					TriggerEvent('skinchanger:getSkin', function(skin)
						ESX.TriggerServerCallback('esx_property:getPlayerOutfit', function(clothes)
							TriggerEvent('skinchanger:loadClothes', skin, clothes)
							TriggerEvent('esx_skin:setLastSkin', skin)

							TriggerEvent('skinchanger:getSkin', function(skin)
								TriggerServerEvent('esx_skin:save', skin)
							end)
						end, data2.current.value)
					end)
				end, function(data2, menu2)
					menu2.close()
				end)
			end)

		elseif data.current.value == 'remove_cloth' then

			ESX.TriggerServerCallback('esx_property:getPlayerDressing', function(dressing)
				local elements = {}

				for i=1, #dressing, 1 do
					table.insert(elements, {
						label = dressing[i],
						value = i
					})
				end

				ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'remove_cloth', {
					css    = 'propriete',
					title    = property.label .. ' - ' .. 'Supprimer des tenues',
					align    = 'top-left',
					elements = elements
				}, function(data2, menu2)
					menu2.close()
					TriggerServerEvent('esx_property:removeOutfit', data2.current.value)
					ESX.ShowNotification("~r~Vous venez de supprimer cette tenue.")
				end, function(data2, menu2)
					menu2.close()
				end)
			end)

		elseif data.current.value == 'room_inventory' then
			print(property)
        elseif data.current.value == 'player_inventory' then
            menu.close()
            OpenPropertyInventoryMenu(property, owner)
		end

	end, function(data, menu)
		menu.close()

		CurrentAction     = 'room_menu'
		CurrentActionMsg  = "Appuyez sur ~INPUT_CONTEXT~ pour ~b~intéragir avec la propriété"
		CurrentActionData = {property = property, owner = owner}
	end)
end
-- Garage Menu 


local GarageData = {}

function RecupGarageId(id)
    TriggerServerEvent("cPublicGarage:GetVehicles", id)
end


RegisterNetEvent("cPublicGarage:GetVehicles")
AddEventHandler("cPublicGarage:GetVehicles", function(data)
    GarageData = data
end)
local ActuelIdGarage = ""

function OpenGarageProperty(property, owner)
	local ActuelIdGarage = property.name

	local elements = {}
	local owned = PropertyIsOwned(property)

	if owned == true then 
		if CurrentPropertyOwner == owner  then
			local playerPed = GetPlayerPed(-1)
    		local vehicle = GetVehiclePedIsIn(playerPed, false)
			local engineHealth = GetVehicleEngineHealth(vehicle)
			if IsPedInAnyVehicle(GetPlayerPed(-1), false) then 
				RangerVeh(ActuelIdGarage)
			end
			ActuelIdGarage = property.name
			RecupGarageId(ActuelIdGarage, engineHealth)
			RageUI.Visible(RMenu:Get('pGarage', 'main'), not RageUI.Visible(RMenu:Get('pGarage', 'main')))
		end
	else
        ESX.ShowNotification("~r~Vous n'avez pas accès à ce garage. ~s~(~b~"..property.name.."~s~)")		
	end
end

function OpenListVehiculeGarage(zone, plate, name)

    local elements = {}
    local garage =  {}

    ESX.TriggerServerCallback('esx_property:getVehiclesInGarage', function(vehicles)

	    for i=1,#vehicles,1 do
	       if vehicles[i].zone ~= nil then       
		        plate = vehicles[i].plate     
		        hashVeh = vehicles[i].vehicle.model
		        local vehName = GetDisplayNameFromVehicleModel(hashVeh)
		        vehPropertie = vehicles[i].vehicle
	        
	            table.insert(elements, {label = vehName, value = vehicles[i].vehicle, zone =  vehicles[i].zone, hash = hashVeh})
	        end   
	    end  

	    ESX.UI.Menu.CloseAll()

	      ESX.UI.Menu.Open(
	        'default', GetCurrentResourceName(), 'spawn_vehicle',
	        {
	          title    = ''..name..'',
	          align    = 'top-left',
	          elements = elements,
	        },
	        function(data, menu)

	            if(data.current.value)then	        
		            if IsPedOnFoot(PlayerPedId()) then 
		                if not IsAnyVehicleNearPoint(zone.x, zone.y, zone.z, 5.0) then
			                ESX.Game.SpawnVehicle(hashVeh,
			                  {
			                    x = zone.x,
			                    y = zone.y,
			                    z = zone.z,
			                  }, zone.h,
			                  function(hashVeh)                    
			                    ESX.Game.SetVehicleProperties(hashVeh, vehPropertie)
			                    TaskWarpPedIntoVehicle(GetPlayerPed(-1), hashVeh, -1)
			                    TriggerServerEvent('esx_property:DelParking',plate)
			                    ESX.UI.Menu.CloseAll()
			                  end
			                )               
		                else 
		                   ESX.ShowNotification('Vous ne pouvez pas sortir le véhicule du garage.\n~r~Il y a un véhicule devant l\'entrée.')
		                end
		            else 
		              ESX.ShowNotification('~r~Vous ne devez pas être en véhicule.')  
		            end          
	            end
	        end,
	        
	        function(data, menu)
	          menu.close()
	        end
	    )    
    end, name) 
end

AddEventHandler('instance:loaded', function()
	TriggerEvent('instance:registerType', 'property', function(instance)
		EnterProperty(instance.data.property, instance.data.owner)
	end, function(instance)
		ExitProperty(instance.data.property)
	end)
end)

AddEventHandler('playerSpawned', function()
	if firstSpawn then
		Citizen.CreateThread(function()
			while not ESX.IsPlayerLoaded() do
				Citizen.Wait(0)
			end

			ESX.TriggerServerCallback('esx_property:getLastProperty', function(propertyName)
				if propertyName then
					if propertyName ~= '' then
						local property = GetProperty(propertyName)

						for i=1, #property.ipls, 1 do
							RequestIpl(property.ipls[i])

							while not IsIplActive(property.ipls[i]) do
								Citizen.Wait(0)
							end
						end

						TriggerEvent('instance:create', 'property', {property = propertyName, owner = ESX.GetPlayerData().identifier})
					end
				end
			end)
		end)

		firstSpawn = false
	end
end)

AddEventHandler('esx_property:getProperties', function(cb)
	cb(GetProperties())
end)

AddEventHandler('esx_property:getProperty', function(name, cb)
	cb(GetProperty(name))
end)

AddEventHandler('esx_property:getGateway', function(property, cb)
	cb(GetGateway(property))
end)

RegisterNetEvent('esx_property:setPropertyOwned')
AddEventHandler('esx_property:setPropertyOwned', function(name, owned, rented)
	SetPropertyOwned(name, owned, rented)
end)

RegisterNetEvent('instance:onCreate')
AddEventHandler('instance:onCreate', function(instance)
	if instance.type == 'property' then
		TriggerEvent('instance:enter', instance)
	end
end)

RegisterNetEvent('instance:onEnter')
AddEventHandler('instance:onEnter', function(instance)
	if instance.type == 'property' then
		local property = GetProperty(instance.data.property)
		local isHost   = GetPlayerFromServerId(instance.host) == PlayerId()
		local isOwned  = false

		if PropertyIsOwned(property) == true then
			isOwned = true
		end

		if isOwned or not isHost then
			hasChest = true
		else
			hasChest = false
		end
	end
end)

RegisterNetEvent('instance:onPlayerLeft')
AddEventHandler('instance:onPlayerLeft', function(instance, player)
	if player == instance.host then
		TriggerEvent('instance:leave')
	end
end)

AddEventHandler('esx_property:hasEnteredMarker', function(name, part)
	local property = GetProperty(name)

	if part == 'entering' then
		if property.isSingle then
			CurrentAction     = 'property_menu'
			CurrentActionMsg  = "Appuyez sur ~INPUT_CONTEXT~ pour ~b~intéragir avec la propriété"
			CurrentActionData = {property = property}
		else
			CurrentAction     = 'gateway_menu'
			CurrentActionMsg  = "Appuyez sur ~INPUT_CONTEXT~ pour ~b~intéragir avec la propriété"
			CurrentActionData = {property = property}
		end
	elseif part == 'exit' then
		CurrentAction     = 'room_exit'
		CurrentActionMsg  = "Appuyez sur ~INPUT_CONTEXT~ pour sortir de ~g~la propriété~w~."
		CurrentActionData = {propertyName = name}
	elseif part == 'roomMenu' then
		CurrentAction     = 'room_menu'
		CurrentActionMsg  = "Appuyez sur ~INPUT_CONTEXT~ pour ~b~intéragir avec la propriété"
		CurrentActionData = {property = property, owner = CurrentPropertyOwner}
	elseif part == 'garage' then
	    CurrentAction     = 'garage'
		CurrentActionMsg  = 'Appuyez sur ~INPUT_CONTEXT~ pour ~b~intéragir avec le garage. (~s~'..property.name..'~b~)'
	    CurrentActionData = {property = property,  owner = CurrentPropertyOwner}
	end
end)

AddEventHandler('esx_property:hasExitedMarker', function(name, part)
	ESX.UI.Menu.CloseAll()
	CurrentAction = nil
end)

-- Enter / Exit marker events & Draw markers
Citizen.CreateThread(function()
	while true do
		local attente = 500

		local coords = GetEntityCoords(PlayerPedId())
		local isInMarker, letSleep = false, true
		local currentProperty, currentPart

		for i=1, #Config.Properties, 1 do
			local property = Config.Properties[i]

			-- Entering
			if property.entering and not property.disabled then
				local distance = GetDistanceBetweenCoords(coords, property.entering.x, property.entering.y, property.entering.z, true)

				if distance < 7 then
					attente = 1	
					DrawMarker(25, property.entering.x, property.entering.y, property.entering.z-0.06, 0.0, 0.0, 0.0, 0, 0.0, 0.0, 1.0, 1.0, 0.6, Config.MarkerColor.r, Config.MarkerColor.g, Config.MarkerColor.b, 100, false, true, 2, false, false, false, false)
					letSleep = false
				end

				if distance < Config.MarkerSize.x then
					attente = 1	
					isInMarker      = true
					currentProperty = property.name
					currentPart     = 'entering'
				end
			end

			-- Exit
			if property.exit and not property.disabled then
				local distance = GetDistanceBetweenCoords(coords, property.exit.x, property.exit.y, property.exit.z, true)

				if distance < 7 then
					attente = 1	
					DrawMarker(25, property.exit.x, property.exit.y, property.exit.z, 0.0, 0.0, 0.0, 0, 0.0, 0.0, 1.0, 1.0, 0.6, Config.MarkerColorExit.r, Config.MarkerColorExit.g, Config.MarkerColorExit.b, 100, false, true, 2, false, false, false, false)
      				letSleep = false
				end

				if distance < Config.MarkerSize.x then
					attente = 1	
					isInMarker      = true
					currentProperty = property.name
					currentPart     = 'exit'
				end
			end

			-- Room menu
			if property.roomMenu and hasChest and not property.disabled then
				local distance = GetDistanceBetweenCoords(coords, property.roomMenu.x, property.roomMenu.y, property.roomMenu.z, true)

				if distance < 7 then
					attente = 1	
					DrawMarker(25, property.roomMenu.x, property.roomMenu.y, property.roomMenu.z, 0.0, 0.0, 0.0, 0, 0.0, 0.0, 1.0, 1.0, 0.6, Config.MarkerColor.r, Config.MarkerColor.g, Config.MarkerColor.b, 100, false, true, 2, false, false, false, false)
      				letSleep = false
				end

				if distance < Config.MarkerSize.x then
					attente = 1	
					isInMarker      = true
					currentProperty = property.name
					currentPart     = 'roomMenu'
				end
			end
						-- garage menu
			if property.garage ~= nil and not property.disabled then 
			    local distance = GetDistanceBetweenCoords(coords, property.garage.x, property.garage.y, property.garage.z, true)
				if distance < 7 then
					attente = 1	
					DrawMarker(25, property.garage.x, property.garage.y, property.garage.z, 0.0, 0.0, 0.0, 0, 0.0, 0.0, 1.0, 1.0, 0.6, Config.MarkerColor.r, Config.MarkerColor.g, Config.MarkerColor.b, 100, false, true, 2, false, false, false, false)
					letSleep = false 
				end 
				
		        if IsPedInAnyVehicle(GetPlayerPed(-1), false) then
					if distance < 7 then
						attente = 1	
						isInMarker      = true
						currentProperty = property.name
						currentPart     = 'garage'
					end
				elseif not IsPedInAnyVehicle(GetPlayerPed(-1), false) then
					if distance < 1.5 then
						attente = 1	
						isInMarker      = true
						currentProperty = property.name
						currentPart     = 'garage'
					end
				end	
		    end 
		end

		if isInMarker and not hasAlreadyEnteredMarker or (isInMarker and (LastProperty ~= currentProperty or LastPart ~= currentPart) ) then
			attente = 1	
			hasAlreadyEnteredMarker = true
			LastProperty            = currentProperty
			LastPart                = currentPart

			TriggerEvent('esx_property:hasEnteredMarker', currentProperty, currentPart)
		end

		if not isInMarker and hasAlreadyEnteredMarker then
			attente = 1	
			hasAlreadyEnteredMarker = false
			TriggerEvent('esx_property:hasExitedMarker', LastProperty, LastPart)
		end

		if letSleep then
			Citizen.Wait(500)
		end
		Wait(attente)
	end
end)

-- Key controls
Citizen.CreateThread(function()
	while true do
		local attente = 500

		if CurrentAction then
			attente = 1
			ESX.ShowHelpNotification(CurrentActionMsg)

			if IsControlJustReleased(0, 38) then
				if CurrentAction == 'property_menu' then
					OpenPropertyMenu(CurrentActionData.property)
				elseif CurrentAction == 'gateway_menu' then
					if Config.EnablePlayerManagementP then
						OpenGatewayOwnedPropertiesMenu(CurrentActionData.property)
					else
						OpenGatewayMenu(CurrentActionData.property)
					end
				elseif CurrentAction == 'room_menu' then
					--OpenRoomMenu(CurrentActionData.property, CurrentActionData.owner)
					OpenPropertyInventoryMenu(CurrentActionData.property, CurrentActionData.owner)
				elseif CurrentAction == 'room_exit' then
					TriggerEvent('instance:leave')
				elseif CurrentAction == 'garage' then
		            OpenGarageProperty(CurrentActionData.property, CurrentActionData.owner)
				end

				CurrentAction = nil
			end
		else
			Citizen.Wait(500)
		end
		Wait(attente)
	end
end)

RegisterCommand('givepropertykey', function()
	local closestPlayer, closestDistance = GetClosestPlayerPed()
 	if propertyentername ~= nil then 
		if closestPlayer ~= -1 and closestDistance <= 2.5 then 
			TriggerServerEvent('clp_property:GiveKeys', GetPlayerServerId(closestPlayer), propertyentername)
		else
			ESX.ShowNotification("~b~Distance\n~w~Rapprochez-vous.")
		end
	else
		ShowAboveRadarMessage("~r~Vous n'êtes dans aucunne propriété.")
	end
end)

RegisterCommand('removepropertykey', function()
	local closestPlayer, closestDistance = GetClosestPlayerPed()
 	if propertyentername ~= nil then 
		if closestPlayer ~= -1 and closestDistance <= 2.5 then 
			TriggerServerEvent('clp_property:remov0ekeys', GetPlayerServerId(closestPlayer), propertyentername)
		else
			ESX.ShowNotification("~b~Distance\n~w~Rapprochez-vous.")
		end
	else
		ShowAboveRadarMessage("~r~Vous n'êtes dans aucunne propriété.")
	end
end)