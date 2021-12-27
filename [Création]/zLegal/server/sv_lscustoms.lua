ESX                = nil

TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

if Config.MaxInService ~= -1 then
	TriggerEvent('esx_service:activateService', 'lscustoms', Config.MaxInService)
end

TriggerEvent('esx_phone:registerNumber', 'lscustoms', _U('lscustoms_customer'), true, true)
TriggerEvent('esx_society:registerSociety', 'lscustoms', 'lscustoms', 'society_lscustoms', 'society_lscustoms', 'society_lscustoms', {type = 'private'})

RegisterServerEvent('clp_lscustom:annonceatomic')
AddEventHandler('clp_lscustom:annonceatomic', function(result)
    local _source = source
    local xPlayer = ESX.GetPlayerFromId(_source)
    local xPlayers = ESX.GetPlayers()
    local text = result
        for i = 1, #xPlayers, 1 do
            local xPlayer = ESX.GetPlayerFromId(xPlayers[i])
            TriggerClientEvent('GM:ShowAboveRadarMessageIcon', xPlayers[i], "CHAR_BLIMP2",1,"Atomic","~y~Publicité",text, 1)
        end
end)

RegisterServerEvent('clp_lscustom:annoncelscustom')
AddEventHandler('clp_lscustom:annoncelscustom', function(result)
    local _source = source
    local xPlayer = ESX.GetPlayerFromId(_source)
    local xPlayers = ESX.GetPlayers()
    local text = result
        for i = 1, #xPlayers, 1 do
            local xPlayer = ESX.GetPlayerFromId(xPlayers[i])
            TriggerClientEvent('GM:ShowAboveRadarMessageIcon', xPlayers[i], "CHAR_LS_CUSTOMS",1,"Ls Customs\'s","~b~Publicité",text, 1)
        end
end)
ESX.RegisterUsableItem('spray', function(source)
	local _source = source
	local xPlayer = ESX.GetPlayerFromId(source)
	TriggerClientEvent("clp_use:spray", source)
end)
RegisterServerEvent('clp_use:removespray')
AddEventHandler('clp_use:removespray', function(result)
    local _source = source
    local xPlayer = ESX.GetPlayerFromId(_source)
	xPlayer.removeInventoryItem('spray', 1)
end)

RegisterServerEvent('esx_lscustomsjob:getStockItem')
AddEventHandler('esx_lscustomsjob:getStockItem', function(itemName, count)
	local xPlayer = ESX.GetPlayerFromId(source)

	TriggerEvent('esx_addoninventory:getSharedInventory', 'society_lscustoms', function(inventory)
		local item = inventory.getItem(itemName)
		local sourceItem = xPlayer.getInventoryItem(itemName)

		-- is there enough in the society?
		if count > 0 and item.count >= count then

			-- can the player carry the said amount of x item?
			if sourceItem.limit ~= -1 and (sourceItem.count + count) > sourceItem.limit then
				TriggerClientEvent('esx:showNotification', xPlayer.source, "~r~Vous n'avez plus de place dans votre inventaire.")
			else
				inventory.removeItem(itemName, count)
				xPlayer.addInventoryItem(itemName, count)
				--TriggerClientEvent('esx:showNotification', xPlayer.source, _U('have_withdrawn', count, item.label))
				TriggerClientEvent('esx:showNotification', xPlayer.source, 'Vous avez retiré ~g~' .. count .. '  ' .. item.label..'~s~ du coffre.')
			end
		else
			TriggerClientEvent('esx:showNotification', xPlayer.source, _U('invalid_quantity'))
		end
	end)
end)

ESX.RegisterServerCallback('esx_lscustomsjob:getStockItems', function(source, cb)
	TriggerEvent('esx_addoninventory:getSharedInventory', 'society_lscustoms', function(inventory)
		cb(inventory.items)
	end)
end)

RegisterServerEvent('esx_lscustomsjob:putStockItems')
AddEventHandler('esx_lscustomsjob:putStockItems', function(itemName, count)
	local xPlayer = ESX.GetPlayerFromId(source)

	TriggerEvent('esx_addoninventory:getSharedInventory', 'society_lscustoms', function(inventory)
		local item = inventory.getItem(itemName)
		local playerItemCount = xPlayer.getInventoryItem(itemName).count

		if item.count >= 0 and count <= playerItemCount then
			xPlayer.removeInventoryItem(itemName, count)
			inventory.addItem(itemName, count)
		else
			TriggerClientEvent('esx:showNotification', xPlayer.source, _U('invalid_quantity'))
		end

		--TriggerClientEvent('esx:showNotification', xPlayer.source, _U('have_deposited', count, item.label))
		TriggerClientEvent('esx:showNotification', xPlayer.source, 'Vous avez ajouté ~g~' .. count .. '  ' .. item.label..'~s~ dans le coffre.')
	end)
end)

ESX.RegisterServerCallback('esx_lscustomsjob:getPlayerInventory', function(source, cb)
	local xPlayer    = ESX.GetPlayerFromId(source)
	local items      = xPlayer.inventory

	cb({items = items})
end)

RegisterNetEvent('tenuelscustoms')
AddEventHandler('tenuelscustoms', function()
    local _source = source
    local xPlayer = ESX.GetPlayerFromId(source)

    xPlayer.addInventoryItem('LsCustoms', 1)
end)


RegisterNetEvent('clp:removeitem')
AddEventHandler('clp:removeitem', function(item)
    local _source = source
    local xPlayer = ESX.GetPlayerFromId(source)

    xPlayer.removeInventoryItem(item, 1)
end)



ESX.RegisterUsableItem('moteur', function(source)
	local _source = source
	local xPlayer = ESX.GetPlayerFromId(source)
	
	xPlayer.removeInventoryItem('moteur', 1)
		
	TriggerClientEvent('lscustoms:usemoteur', source)

	Citizen.Wait(10000)
end)

RegisterNetEvent('garage:moteur')
AddEventHandler('garage:moteur', function()

    local _source = source
    local xPlayer = ESX.GetPlayerFromId(source)

        xPlayer.addInventoryItem('moteur', 1)
		TriggerClientEvent('esx:showNotification', source, "Vous avez acheté un ~b~moteur~w~ pour ~g~0$~w~.")
end)

RegisterNetEvent('garage:kit')
AddEventHandler('garage:kit', function()

    local _source = source
    local xPlayer = ESX.GetPlayerFromId(source)

        xPlayer.addInventoryItem('kitcarro', 1)
		TriggerClientEvent('esx:showNotification', source, "Vous avez acheté un ~b~kit de carrosserie~w~ pour ~g~0$~w~.")
end)

ESX.RegisterUsableItem('pneu', function(source)
	local xPlayers     = ESX.GetPlayers()
	local hasLsCustomsp = false

	for i = 1, #xPlayers, 1 do
	  local xPlayer = ESX.GetPlayerFromId(xPlayers[i])
	  if xPlayer.job.name == 'lscustoms' then
		hasLsCustomsp = true
		break
	  end
	end
	
	if not hasLsCustomsp then
		local xPlayer = ESX.GetPlayerFromId(source)
		xPlayer.removeInventoryItem('pneu', 1)
		
		TriggerClientEvent('lscustoms:usepneu', source)

		Citizen.Wait(10000)
	else
		TriggerClientEvent('esx:showNotification', source, "~r~Vous ne pouvez utiliser ce pneu, un mécano est en service.")  
	end
end)

ESX.RegisterUsableItem('kitcarro', function(source)
	local xPlayers     = ESX.GetPlayers()
	local hasLsCustomsk = false

	for i = 1, #xPlayers, 1 do
	  local xPlayer = ESX.GetPlayerFromId(xPlayers[i])
	  if xPlayer.job.name == 'lscustoms' then
		hasLsCustomsk = true
		break
	  end
	end
	
	if not hasLsCustomsk then
		local xPlayer = ESX.GetPlayerFromId(source)
		xPlayer.removeInventoryItem('kitcarro', 1)
		
		TriggerClientEvent('lscustoms:usekitcarro', source)

		Citizen.Wait(10000)
	else
		TriggerClientEvent('esx:showNotification', source, "~r~Vous ne pouvez utiliser ce kit Carrosserie, un mécano est en service.")  
	end
end)