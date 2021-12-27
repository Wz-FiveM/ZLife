ESX = nil

TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

local function getLicense(source)
    for k,v in pairs(GetPlayerIdentifiers(source))do
        if string.sub(v, 1, string.len("license:")) == "license:" then
        return v
        end

    end
    return ""
end

ESX.RegisterServerCallback('zedkover:requestPlayerTattoos', function(source, cb)
	local xPlayer = ESX.GetPlayerFromId(source)

	if xPlayer then
		MySQL.Async.fetchAll('SELECT tattoos FROM users WHERE identifier = @identifier', {
			['@identifier'] = getLicense(source)
		}, function(result)
			if result[1].tattoos then
				cb(json.decode(result[1].tattoos))
			else
				cb()
			end
		end)
	else
		cb()
	end
end)

RegisterServerEvent('zedkover:annoncetattoo')
AddEventHandler('zedkover:annoncetattoo', function(result)
	local _source = source  
	local xPlayers = ESX.GetPlayers()
	local name = GetPlayerName(source)
	for i=1, #xPlayers, 1 do 
		local xPlayer = ESX.GetPlayerFromId(xPlayers[i])
		        TriggerClientEvent('esx:showAdvancedNotification', xPlayers[i], 'Annonce Tattooshop', '~b~@'..name..'', result, 'CHAR_LIFEINVADER')
		end
end) 


ESX.RegisterServerCallback('zedkover:purchaseTattoo', function(source, cb, tattooList, tattoo)
	local xPlayer = ESX.GetPlayerFromId(source)

		table.insert(tattooList, tattoo)
		MySQL.Async.execute('UPDATE users SET tattoos = @tattoos WHERE identifier = @identifier', {
			['@tattoos'] = json.encode(tattooList),
			['@identifier'] = getLicense(source)
		})	
		cb(true)
end)

RegisterServerEvent('zedkover:changetattoo')
AddEventHandler('zedkover:changetattoo', function(target, cr, pr)
	TriggerClientEvent('zedkover:changetattoocl', target, cr, pr)
end)

RegisterServerEvent('zedkover:changeclothe')
AddEventHandler('zedkover:changeclothe', function(target, result, s, r)
	TriggerClientEvent('zedkover:changeclothecl', target, result, s, r)
end)



RegisterServerEvent('zedkover:getpedidclsource')
AddEventHandler('zedkover:getpedidclsource', function(target, playerid)
	TriggerClientEvent('zedkover:getpedid', target, playerid)
end)


--- stock
ESX.RegisterServerCallback('zedkover:getinventorytattoo', function(source, cb)
	local xPlayer = ESX.GetPlayerFromId(source)
	local items   = xPlayer.inventory
	cb({
		items = items
	})
end)

RegisterServerEvent('zedkover:putStockItemstattoo')
AddEventHandler('zedkover:putStockItemstattoo', function(itemName, count)
	local xPlayer = ESX.GetPlayerFromId(source)
	TriggerEvent('esx_addoninventory:getSharedInventory', "society_tattoo", function(inventory)
		local item = inventory.getItem(itemName)
		if item.count >= 0 then
			xPlayer.removeInventoryItem(itemName, count)
			inventory.addItem(itemName, count)
			TriggerClientEvent('esx:showNotification', xPlayer.source, 'Vous avez ajouter [~b~x' .. count .. '~s~] ~b~' .. item.label)
		else
			TriggerClientEvent('esx:showNotification', xPlayer.source, '~r~La quantité et invalid')
		end
		
	end)
end)

ESX.RegisterServerCallback('zedkover:getStockItemstattoo', function(source, cb, info)
	
end)     

ESX.RegisterServerCallback('zedkover:getStockItemstattoo', function(source, cb)
    TriggerEvent('esx_addoninventory:getSharedInventory', 'society_tattoo', function(inventory)
        cb(inventory.items) 
    end)     
end)       

RegisterServerEvent('zedkover:getStockItemtattoo')
AddEventHandler('zedkover:getStockItemtattoo', function(itemName, count)
	local xPlayer = ESX.GetPlayerFromId(source)
	TriggerEvent('esx_addoninventory:getSharedInventory', "society_tattoo", function(inventory)
		local item = inventory.getItem(itemName)
		if item.count >= tonumber(count) then
			inventory.removeItem(itemName, count)
			xPlayer.addInventoryItem(itemName, count)
		else
			TriggerClientEvent('esx:showNotification', xPlayer.source, '~r~La quantité et invalid')
		end
		TriggerClientEvent('esx:showNotification', xPlayer.source, 'Vous avez retirer [~b~x' .. count .. '~s~] ~b~' .. item.label)
	end)
end)
