ESX = nil

TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

function GetProperty(name)
	for i=1, #Config.Properties, 1 do
		if Config.Properties[i].name == name then
			return Config.Properties[i]
		end
	end
end

function SetPropertyOwned(name, price, rented, owner)
	MySQL.Async.execute('INSERT INTO owned_properties (name, price, rented, owner) VALUES (@name, @price, @rented, @owner)', {
		['@name']   = name,
		['@price']  = price,
		['@rented'] = (rented and 1 or 0),
		['@owner']  = owner
	}, function(rowsChanged)
		local xPlayer = ESX.GetPlayerFromIdentifier(owner)

		if xPlayer then
			TriggerClientEvent('esx_property:setPropertyOwned', xPlayer.source, name, true, rented)
			if rented then

				TriggerClientEvent('esx:showNotification', xPlayer.source, "~g~Vous avez loué la propriétée : ~b~"..name.." ~g~pour ~b~"..ESX.Math.GroupDigits(price).."$~g~.")
			else
				TriggerClientEvent('esx:showNotification', xPlayer.source, "~g~Vous avez acheté la propriétée : ~b~"..name.." ~g~pour ~b~"..ESX.Math.GroupDigits(price).."$~g~.")
			end
		end
	end)
end

function RemoveOwnedProperty(name, owner, noPay)
	MySQL.Async.fetchAll('SELECT id, rented, price FROM owned_properties WHERE name = @name AND owner = @owner', {
		['@name']  = name,
		['@owner'] = owner
	}, function(result)
		if result[1] then
			MySQL.Async.execute('DELETE FROM owned_properties WHERE id = @id', {
				['@id'] = result[1].id
			}, function(rowsChanged)
				local xPlayer = ESX.GetPlayerFromIdentifier(owner)

				if xPlayer then
					TriggerClientEvent('esx_property:setPropertyOwned', xPlayer.source, name, false)

					if not noPay then
						if result[1].rented == 1 then
							TriggerClientEvent('esx:showNotification', xPlayer.source, "~r~Vous venez de stopper la location de la propriétée : ~b~"..name.."~r~.")
						else
							local sellPrice = ESX.Math.Round(result[1].price / Config.SellModifier)

							TriggerClientEvent('esx:showNotification', xPlayer.source, "~r~Vous venez de vendre la propriétée : ~b~"..name.." ~r~pour : ~b~"..ESX.Math.GroupDigits(sellPrice).."~r~.")
							xPlayer.addAccountMoney('bank', sellPrice)
						end
					end
				end
			end)
		end
	end)
end


MySQL.ready(function()
	Citizen.Wait(500)

	MySQL.Async.fetchAll('SELECT * FROM properties', {}, function(properties)

		for i=1, #properties, 1 do
			local entering  = nil
			local exit      = nil
			local inside    = nil
			local outside   = nil
			local isSingle  = nil
			local isRoom    = nil
			local isGateway = nil
			local roomMenu  = nil
			local garage    = nil 

			if properties[i].entering then
				entering = json.decode(properties[i].entering)
			end

			if properties[i].exit then
				exit = json.decode(properties[i].exit)
			end

			if properties[i].inside then
				inside = json.decode(properties[i].inside)
			end

			if properties[i].outside then
				outside = json.decode(properties[i].outside)
			end

			if properties[i].is_single == 0 then
				isSingle = false
			else
				isSingle = true
			end

			if properties[i].is_room == 0 then
				isRoom = false
			else
				isRoom = true
			end

			if properties[i].is_gateway == 0 then
				isGateway = false
			else
				isGateway = true
			end

			if properties[i].room_menu then
				roomMenu = json.decode(properties[i].room_menu)
			end

			if properties[i].garage ~= nil then
		       garage = json.decode(properties[i].garage)
		    end


			table.insert(Config.Properties, {
				name      = properties[i].name,
				label     = properties[i].label,
				entering  = entering,
				exit      = exit,
				inside    = inside,
				outside   = outside,
				ipls      = json.decode(properties[i].ipls),
				gateway   = properties[i].gateway,
				isSingle  = isSingle,
				isRoom    = isRoom,
				isGateway = isGateway,
				roomMenu  = roomMenu,
				garage    = garage,
				price     = properties[i].price
			})
		end

		TriggerClientEvent('esx_property:sendProperties', -1, Config.Properties)
	end)
end)


RegisterNetEvent('c_property:delprpopertyname')
AddEventHandler('c_property:delprpopertyname', function(property)
	MySQL.Async.fetchAll('SELECT name FROM properties WHERE name = @name', {
		['@name'] = property
	}, function(result)
		if result[1] then
			MySQL.Async.execute('DELETE FROM properties WHERE name = @name', {
				['@name'] = property
			}, function(rowsChanged)

			end)
		end
	end)
end)

RegisterServerEvent('givepropertykey:sell')
AddEventHandler('givepropertykey:sell', function(target, property, price)
	local xPlayer, xTarget = ESX.GetPlayerFromId(source), ESX.GetPlayerFromId(target)

	if xPlayer.job.name ~= 'realestateagent' then
		return
	end

	TriggerEvent('esx_addonaccount:getSharedAccount', 'society_realestateagent', function(account)
		account.addMoney(price)
	end)
	TriggerEvent('esx_property:setPropertyOwned', property, price, false, xTarget.identifier)
end)

RegisterServerEvent('givepropertykey:sell1')
AddEventHandler('givepropertykey:sell1', function(target, property, price)
	local xPlayer, xTarget = ESX.GetPlayerFromId(source), ESX.GetPlayerFromId(target)

	TriggerEvent('esx_addonaccount:getSharedAccount', 'society_realestateagent', function(account)
		account.addMoney(price)
	end)
	TriggerEvent('esx_property:setPropertyOwned', property, price, false, xTarget.identifier)
end)

RegisterServerEvent('givepropertykey:rent')
AddEventHandler('givepropertykey:rent', function(target, property, price)
	local xPlayer, xTarget = ESX.GetPlayerFromId(source), ESX.GetPlayerFromId(target)

	if xPlayer.job.name ~= 'realestateagent' then
		return
	end

	TriggerEvent('esx_addonaccount:getSharedAccount', 'society_realestateagent', function(account)
		account.addMoney(price)
	end)

	TriggerEvent('esx_property:setPropertyOwned', property, price, true, xTarget.identifier)
end)

RegisterNetEvent('c_property:relaodproperties')
AddEventHandler('c_property:relaodproperties', function()
	--print('Refresh des propriétées')
	Citizen.Wait(500)

	MySQL.Async.fetchAll('SELECT * FROM properties', {}, function(properties)

		for i=1, #properties, 1 do
			local entering  = nil
			local exit      = nil
			local inside    = nil
			local outside   = nil
			local isSingle  = nil
			local isRoom    = nil
			local isGateway = nil
			local roomMenu  = nil
			local garage    = nil 

			if properties[i].entering then
				entering = json.decode(properties[i].entering)
			end

			if properties[i].exit then
				exit = json.decode(properties[i].exit)
			end

			if properties[i].inside then
				inside = json.decode(properties[i].inside)
			end

			if properties[i].outside then
				outside = json.decode(properties[i].outside)
			end

			if properties[i].is_single == 0 then
				isSingle = false
			else
				isSingle = true
			end

			if properties[i].is_room == 0 then
				isRoom = false
			else
				isRoom = true
			end

			if properties[i].is_gateway == 0 then
				isGateway = false
			else
				isGateway = true
			end

			if properties[i].room_menu then
				roomMenu = json.decode(properties[i].room_menu)
			end

			if properties[i].garage ~= nil then
		       garage = json.decode(properties[i].garage)
		    end


			table.insert(Config.Properties, {
				name      = properties[i].name,
				label     = properties[i].label,
				entering  = entering,
				exit      = exit,
				inside    = inside,
				outside   = outside,
				ipls      = json.decode(properties[i].ipls),
				gateway   = properties[i].gateway,
				isSingle  = isSingle,
				isRoom    = isRoom,
				isGateway = isGateway,
				roomMenu  = roomMenu,
				garage    = garage,
				price     = properties[i].price
			})
		end

		TriggerClientEvent('esx_property:sendProperties', -1, Config.Properties)
	end)
end)

ESX.RegisterServerCallback('esx_property:getProperties', function(source, cb)
	cb(Config.Properties)
end)

AddEventHandler('esx_ownedproperty:getOwnedProperties', function(cb)
	MySQL.Async.fetchAll('SELECT * FROM owned_properties', {}, function(result)
		local properties = {}

		for i=1, #result, 1 do
			table.insert(properties, {
				id     = result[i].id,
				name   = result[i].name,
				label  = GetProperty(result[i].name).label,
				price  = result[i].price,
				rented = (result[i].rented == 1 and true or false),
				owner  = result[i].owner
			})
		end

		cb(properties)
	end)
end)

AddEventHandler('esx_property:setPropertyOwned', function(name, price, rented, owner)
	SetPropertyOwned(name, price, rented, owner)
end)
  

AddEventHandler('esx_property:removeOwnedProperty', function(name, owner)
	RemoveOwnedProperty(name, owner)
end)

RegisterNetEvent('esx_property:rentProperty')
AddEventHandler('esx_property:rentProperty', function(propertyName)
	local xPlayer  = ESX.GetPlayerFromId(source)
	local property = GetProperty(propertyName)
	local rent     = ESX.Math.Round(property.price / Config.RentModifier)

	if rent <= xPlayer.getMoney() then
		xPlayer.removeMoney(rent)
		SetPropertyOwned(propertyName, rent, true, xPlayer.identifier)
		local societyAccount = nil
		TriggerEvent('esx_addonaccount:getSharedAccount', 'society_realestateagent', function(account)
			societyAccount = account
		end)
		societyAccount.addMoney(rent)
	else
		TriggerClientEvent('esx:showNotification', xPlayer.source, "~r~Vous n\'avez pas assez d\'argent.")
	end
	--SetPropertyOwned(propertyName, rent, true, xPlayer.identifier)
end)

RegisterNetEvent('esx_property:buyProperty')
AddEventHandler('esx_property:buyProperty', function(propertyName)
	local xPlayer  = ESX.GetPlayerFromId(source)
	local property = GetProperty(propertyName)
	

	if property.price <= xPlayer.getMoney() then
		local societyAccount = nil
		TriggerEvent('esx_addonaccount:getSharedAccount', 'society_realestateagent', function(account)
			societyAccount = account
		end)
		societyAccount.addMoney(property.price)

		xPlayer.removeMoney(property.price)
		SetPropertyOwned(propertyName, property.price, false, xPlayer.identifier)
	else
		TriggerClientEvent('esx:showNotification', xPlayer.source, "~r~Vous n\'avez pas assez d\'argent.")
	end
end)

RegisterNetEvent('esx_property:removeOwnedProperty')
AddEventHandler('esx_property:removeOwnedProperty', function(propertyName)
	local xPlayer = ESX.GetPlayerFromId(source)
	RemoveOwnedProperty(propertyName, xPlayer.identifier)
end)

AddEventHandler('esx_property:removeOwnedPropertyIdentifier', function(propertyName, identifier)
	RemoveOwnedProperty(propertyName, identifier)
end)

RegisterNetEvent('esx_property:saveLastProperty')
AddEventHandler('esx_property:saveLastProperty', function(property)
	local xPlayer = ESX.GetPlayerFromId(source)

	MySQL.Async.execute('UPDATE users SET last_property = @last_property WHERE identifier = @identifier', {
		['@last_property'] = property,
		['@identifier']    = xPlayer.identifier
	})
end)

RegisterNetEvent('esx_property:deleteLastProperty')
AddEventHandler('esx_property:deleteLastProperty', function()
	local xPlayer = ESX.GetPlayerFromId(source)

	MySQL.Async.execute('UPDATE users SET last_property = NULL WHERE identifier = @identifier', {
		['@identifier'] = xPlayer.identifier
	})
end)

RegisterNetEvent('esx_property:getItem')
AddEventHandler('esx_property:getItem', function(owner, type, item, count)
	local xPlayer = ESX.GetPlayerFromId(source)
	local xPlayerOwner = ESX.GetPlayerFromIdentifier(owner)
	local sourceItem = xPlayer.getInventoryItem(item)

	if type == "item_weapon" then return end
	
	if type == 'item_standard' then
		TriggerEvent('esx_addoninventory:getInventory', 'property', xPlayerOwner.identifier, function(inventory)
			local inventoryItem = inventory.getItem(item)
			local sourceItem = xPlayer.getInventoryItem(item)

			-- is there enough in the property?
			if count > 0 and inventoryItem.count >= count then

				if sourceItem.limit ~= -1 and (sourceItem.count + count) > sourceItem.limit then
					TriggerClientEvent('esx:showNotification', xPlayer.source, "~r~Vous n'avez plus de place dans votre inventaire.")
				else
					inventory.removeItem(item, count)
					xPlayer.addInventoryItem(item, count)
					TriggerClientEvent('esx:showNotification', xPlayer.source, 'Vous avez retiré ~g~' .. count .. ' ' .. inventoryItem.label..'~s~ du coffre.')
				end
			else
				TriggerClientEvent('esx:showNotification', xPlayer.source, "il n\'a pas assez de ~r~cet objet~s~ dans votre coffre!")
			end
		end)
	elseif type == 'item_account' then
		TriggerEvent('esx_addonaccount:getAccount', 'property_' .. item, xPlayerOwner.identifier, function(account)
			if account.money >= count then
				account.removeMoney(count)
				xPlayer.addAccountMoney(item, count)
			else
				TriggerClientEvent('esx:showNotification', xPlayer.source, "~r~Montant invalide")
			end
		end)

	end
end)

RegisterNetEvent('esx_property:putItem')
AddEventHandler('esx_property:putItem', function(owner, type, item, count)
	local xPlayer = ESX.GetPlayerFromId(source)
	local xPlayerOwner = ESX.GetPlayerFromIdentifier(owner)

	if type == "item_weapon" then return end

	if type == 'item_standard' then
		local playerItemCount = xPlayer.getInventoryItem(item).count

		if playerItemCount >= count and count > 0 then
			TriggerEvent('esx_addoninventory:getInventory', 'property', xPlayerOwner.identifier, function(inventory)
				xPlayer.removeInventoryItem(item, count)
				inventory.addItem(item, count)
				TriggerClientEvent('esx:showNotification', xPlayer.source, 'Vous avez ajouté ~g~' .. count .. ' ' .. inventory.getItem(item).label..'~s~ dans le coffre.')
			end)
		else
			TriggerClientEvent('esx:showNotification', xPlayer.source, "~r~Montant invalide")
		end
	elseif type == 'item_account' then
		if xPlayer.getAccount(item).money >= count and count > 0 then
			xPlayer.removeAccountMoney(item, count)

			TriggerEvent('esx_addonaccount:getAccount', 'property_' .. item, xPlayerOwner.identifier, function(account)
				account.addMoney(count)
			end)
		else
			TriggerClientEvent('esx:showNotification', xPlayer.source, "~r~Montant invalide")
		end
	end
end)

ESX.RegisterServerCallback('esx_property:getOwnedProperties', function(source, cb)
	local xPlayer = ESX.GetPlayerFromId(source)

	MySQL.Async.fetchAll('SELECT name, rented FROM owned_properties WHERE owner = @owner', {
		['@owner'] = xPlayer.identifier
	}, function(result)
		cb(result)
	end)
end)

ESX.RegisterServerCallback('esx_property:getLastProperty', function(source, cb)
	local xPlayer = ESX.GetPlayerFromId(source)

	MySQL.Async.fetchAll('SELECT last_property FROM users WHERE identifier = @identifier', {
		['@identifier'] = xPlayer.identifier
	}, function(users)
		cb(users[1].last_property)
	end)
end)

ESX.RegisterServerCallback('esx_property:getPropertyInventory', function(source, cb, owner)
	local xPlayer    = ESX.GetPlayerFromIdentifier(owner)
	local blackMoney = 0
	local items      = {}
	local weapons    = {}

	TriggerEvent('esx_addonaccount:getAccount', 'property_black_money', xPlayer.identifier, function(account)
		blackMoney = account.money
	end)

	TriggerEvent('esx_addoninventory:getInventory', 'property', xPlayer.identifier, function(inventory)
		items = inventory.items
	end)

	TriggerEvent('esx_datastore:getDataStore', 'property', xPlayer.identifier, function(store)
		weapons = store.get('weapons') or {}
	end)

	cb({
		blackMoney = blackMoney,
		items      = items,
		weapons    = weapons
	})
end)

ESX.RegisterServerCallback('esx_property:getPlayerInventory', function(source, cb)
	local xPlayer    = ESX.GetPlayerFromId(source)
	local blackMoney = xPlayer.getAccount('black_money').money
	local items      = xPlayer.inventory

	cb({
		blackMoney = blackMoney,
		items      = items,
		weapons    = xPlayer.getLoadout()
	})
end)

ESX.RegisterServerCallback('esx_property:getPlayerDressing', function(source, cb)
	local xPlayer  = ESX.GetPlayerFromId(source)

	TriggerEvent('esx_datastore:getDataStore', 'property', xPlayer.identifier, function(store)
		local count  = store.count('dressing')
		local labels = {}

		for i=1, count, 1 do
			local entry = store.get('dressing', i)
			table.insert(labels, entry.label)
		end

		cb(labels)
	end)
end)

ESX.RegisterServerCallback('esx_property:getPlayerOutfit', function(source, cb, num)
	local xPlayer  = ESX.GetPlayerFromId(source)

	TriggerEvent('esx_datastore:getDataStore', 'property', xPlayer.identifier, function(store)
		local outfit = store.get('dressing', num)
		cb(outfit.skin)
	end)
end)

RegisterNetEvent('esx_property:removeOutfit')
AddEventHandler('esx_property:removeOutfit', function(label)
	local xPlayer = ESX.GetPlayerFromId(source)

	TriggerEvent('esx_datastore:getDataStore', 'property', xPlayer.identifier, function(store)
		local dressing = store.get('dressing') or {}

		table.remove(dressing, label)
		store.set('dressing', dressing)
	end)
end)

function payRent(d, h, m)
	local tasks, timeStart = {}, os.clock()
	--print('[esx_property] [^2INFO^7] Paying rent cron job started')

	MySQL.Async.fetchAll('SELECT * FROM owned_properties WHERE rented = 1', {}, function(result)
		for k,v in ipairs(result) do
			table.insert(tasks, function(cb)
				local xPlayer = ESX.GetPlayerFromIdentifier(v.owner)

				if xPlayer then
					if xPlayer.getAccount('bank').money >= v.price then
						xPlayer.removeAccountMoney('bank', v.price)
						TriggerClientEvent('esx:showNotification', xPlayer.source, "~g~Vous avez payé votre location ~b~%s$~s~ pour ~b~%s$~g~.", ESX.Math.GroupDigits(v.price), GetProperty(v.name).label)
					else
						TriggerClientEvent('esx:showNotification', xPlayer.source, "~r~Vous avez été expulsé de la propriétée ~b~%s~s~ ~r~pour ne pas avoir payé le loyer à ~b~%s$~r~.", GetProperty(v.name).label, ESX.Math.GroupDigits(v.price))
						RemoveOwnedProperty(v.name, v.owner, true)
					end
				else
					MySQL.Async.fetchScalar('SELECT accounts FROM users WHERE identifier = @identifier', {
						['@identifier'] = v.owner
					}, function(accounts)
						if accounts then
							local playerAccounts = json.decode(accounts)

							if playerAccounts and playerAccounts.bank then
								if playerAccounts.bank >= v.price then
									playerAccounts.bank = playerAccounts.bank - v.price

									MySQL.Async.execute('UPDATE users SET accounts = @accounts WHERE identifier = @identifier', {
										['@identifier'] = v.owner,
										['@accounts'] = json.encode(playerAccounts)
									})
								else
									RemoveOwnedProperty(v.name, v.owner, true)
								end
							end
						end
					end)
				end

				TriggerEvent('esx_addonaccount:getSharedAccount', 'society_realestateagent', function(account)
					account.addMoney(v.price)
				end)

				cb()
			end)
		end

		Async.parallelLimit(tasks, 5, function(results) end)

		local elapsedTime = os.clock() - timeStart
		--print(('[esx_property] [^2INFO^7] Paying rent cron job took %s seconds'):format(elapsedTime))
	end)
end

TriggerEvent('cron:runAt', 22, 0, payRent)



-- Garage 

RegisterServerEvent('esx_property:setParking')
AddEventHandler('esx_property:setParking', function(plate, name, zone, vehicleProps)
  local _source = source
  local xPlayer  = ESX.GetPlayerFromId(_source)
  
  if vehicleProps ~= false then

    MySQL.Async.fetchAll("SELECT plate FROM owned_vehicles WHERE owner=@identifier AND plate =@plate",
      {
        ['@identifier'] = xPlayer.identifier,
        ['@plate'] = plate
      }, 
      function(result)
        if result[1] ~= nil then 
          --print(result[1].plate)
          Insert(_source, plate, name, zone, vehicleProps)
        else 
          TriggerClientEvent('esx:showNotification', xPlayer.source, 'Ce véhicule n\'est pas le votre')  
        end 
      end
    )
  end   
end)

function Insert(source, plate, name, zone, vehicleProps)
  
  local xPlayer  = ESX.GetPlayerFromId(source)

  MySQL.Async.execute('INSERT INTO `user_parkings` (identifier, plate, name, zone, vehicle) VALUES (@identifier, @plate, @name, @zone, @vehicle)',
  {
    ['@identifier'] = xPlayer.identifier,
    ['@plate']     = plate,
    ['@name']      = name,
    ['@zone']      = json.encode(zone),
    ['@vehicle']   = json.encode(vehicleProps)
  }, function(rowsChanged)
		TriggerClientEvent('esx:showNotification', xPlayer.source, '~g~Vous avez rangé votre véhicule.')
    UpdateState(plate)
  end)
end

function UpdateState(plate)

  MySQL.Sync.execute("UPDATE owned_vehicles SET garageperso=true WHERE plate= @plate",
    {
     ['@plate'] = plate
    }
  )
end

ESX.RegisterServerCallback('esx_property:getVehiclesInGarage', function(source, cb, name)
  local xPlayer  = ESX.GetPlayerFromId(source)

  MySQL.Async.fetchAll('SELECT * FROM `user_parkings` WHERE `identifier` = @identifier AND name = @name',
  {
    ['@identifier'] = xPlayer.identifier,
    ['@name']     = name
  }, function(result)

    local vehicles = {}

    for i=1, #result, 1 do
      table.insert(vehicles, {
        zone    = json.decode(result[i].zone),
        plate = result[i].plate,
        vehicle = json.decode(result[i].vehicle)
      })
    end

    cb(vehicles)
  end)
end)

RegisterServerEvent('esx_property:DelParking')
AddEventHandler('esx_property:DelParking', function(plate)
  local _source = source
  local xPlayer  = ESX.GetPlayerFromId(_source)

  MySQL.Async.execute('DELETE FROM `user_parkings` WHERE `identifier` = @identifier AND `plate` = @plate',
  {
    ['@identifier'] = xPlayer.identifier,
    ['@plate']     = plate,
  }, function(rowsChanged)
     UpdateStateOtherGarage(plate)
  end)
end)

function UpdateStateOtherGarage(plate)

  MySQL.Sync.execute("UPDATE owned_vehicles SET garageperso=false, state=false WHERE plate= @plate",
    {
     ['@plate'] = plate
    }
  )

end

RegisterServerEvent('clp:creaproperty')
AddEventHandler('clp:creaproperty', function(name, label, entering, exit, inside, outside, ipl, isSingle, isRoom, isGateway, roommenu, garage, price)
    local x_source = source

    MySQL.Async.fetchAll("SELECT name FROM properties WHERE name = @name", {

   	   ['@name'] = name,

    }, 
    function(result)
        if result[1] ~= nil then 
       	   TriggerClientEvent('esx:showNotification', x_source, '~r~Ce nom éxiste déja.')
		   else 
			TriggerEvent('c_property:relaodproperties')
       	   Insert(x_source, name, label, entering, exit, inside, outside, ipl, isSingle, isRoom, isGateway, roommenu, garage, price)   
        end 
    end)
end)

function Insert(x_source, name, label, entering, exit, inside, outside, ipl, isSingle, isRoom, isGateway, roommenu, garage, price)
    MySQL.Async.execute('INSERT INTO properties (name, label ,entering ,`exit`,inside,outside,ipls,is_single,is_room,is_gateway,room_menu,garage,price) VALUES (@name,@label,@entering,@exit,@inside,@outside,@ipls,@isSingle,@isRoom,@isGateway,@roommenu,@garage,@price)',
		{
			['@name'] = name,
			['@label'] = label,
			['@entering'] = entering,
			['@exit'] = exit,
			['@inside'] = inside,
			['@outside'] = outside,
			['@ipls'] = ipl,
			['@isSingle'] = isSingle,
			['@isRoom'] = isRoom,
			['@isGateway'] = isGateway,
			['@roommenu'] = roommenu,
			['@garage'] = garage,
			['@price'] = price,

		}, 
		function (rowsChanged)
			TriggerClientEvent('esx:showNotification', x_source, "~g~Propriétée enregistrée.\n~s~Nom : ~b~"..name.."\n~s~Prix : ~b~"..price.."$~s~.")
		end
	)
end

RegisterServerEvent('clp_property:GiveKeys')
AddEventHandler('clp_property:GiveKeys', function(target, property)
	local _source = source
	local xPlayer = nil
	local toplate = plate
	xPlayertarget = ESX.GetPlayerFromId(target)
	xPlayer = ESX.GetPlayerFromId(_source)
	TriggerClientEvent('esx:showNotification', target, "~g~La propriété : ~b~"..property.."~g~ vous a été attribué.")
    MySQL.Async.execute('INSERT INTO owned_properties (name, price, rented, owner) VALUES (@name, @price, @rented, @owner)', {
		['@name'] = property,
		['@price']  = 1,
		['@rented'] = 1,
		['@owner']  = xPlayertarget.identifier
	})
	TriggerClientEvent('esx_property:sendProperties', -1, Config.Properties)
end)

RegisterServerEvent('clp_property:remov0ekeys')
AddEventHandler('clp_property:remov0ekeys', function(target, property)
	local _source = source
	local xPlayer = nil
	local toplate = plate
	xPlayertarget = ESX.GetPlayerFromId(target)
	xPlayer = ESX.GetPlayerFromId(_source)
	TriggerClientEvent('esx:showNotification', target, "~r~La propriété : ~b~"..property.."~r~ vous a été retiré.")
	TriggerClientEvent('esx_property:sendProperties', -1, Config.Properties)
	TriggerEvent('esx_property:removeOwnedPropertyIdentifier',property ,xPlayertarget.identifier)
end)
