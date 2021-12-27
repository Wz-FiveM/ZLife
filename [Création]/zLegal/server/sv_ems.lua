ESX = nil
local playersHealing = {}

TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

RegisterServerEvent('esx_ambulancejob:reviveplayer')
AddEventHandler('esx_ambulancejob:reviveplayer', function(target)
	local xPlayer = ESX.GetPlayerFromId(source)
	local xPlayers = ESX.GetPlayers()

	if xPlayer.job.name == 'ambulance' then
		local societyAccount = nil
		TriggerEvent('esx_addonaccount:getSharedAccount', 'society_ambulance', function(account)
			societyAccount = account
		end)
		if societyAccount ~= nil then
			xPlayer.addMoney(Config.ReviveReward)
			TriggerClientEvent('esx_ambulancejob:reviveplayer', target)
			societyAccount.addMoney(150)
		end
		for i=1, #xPlayers, 1 do
			local xPlayer = ESX.GetPlayerFromId(xPlayers[i])
			if xPlayer.job.name == 'ambulance' then
				TriggerClientEvent('esx_ambulancejob:notif', xPlayers[i])
			end
		end
	end
end)

RegisterServerEvent('clp_ems:annonceems')
AddEventHandler('clp_ems:annonceems', function(result)
    local _source = source
    local xPlayer = ESX.GetPlayerFromId(_source)
    local xPlayers = ESX.GetPlayers()
    local text = result
    if xPlayer.getMoney() >= 500 then 
        xPlayer.removeMoney(500)
        for i = 1, #xPlayers, 1 do
            local xPlayer = ESX.GetPlayerFromId(xPlayers[i])
			TriggerClientEvent('GM:ShowAboveRadarMessageIcon', xPlayers[i], "CHAR_CALL911",1,"EMS","~r~Annonce",text, 1)
        end
    else
        TriggerClientEvent('esx:showNotification', source, "~r~Vous n'avez pas suffisamment d'argent.")
    end
end)


RegisterServerEvent('esx_ambulancejob:revive2')
AddEventHandler('esx_ambulancejob:revive2', function(target)
	local xPlayer = ESX.GetPlayerFromId(source)
	local xPlayers = ESX.GetPlayers()
	TriggerClientEvent('esx_ambulancejob:revive2', target)
end)


RegisterServerEvent('esx_ambulance:Notification')
AddEventHandler('esx_ambulance:Notification', function(x, y, z, name, coords)
	local _source = source
	local xPlayer = ESX.GetPlayerFromId(_source)
	local xPlayers = ESX.GetPlayers()

	for i = 1, #xPlayers, 1 do
		local thePlayer = ESX.GetPlayerFromId(xPlayers[i])
		if thePlayer.job.name == 'ambulance' then
			TriggerClientEvent('esx_ambulancejob:Notif2', xPlayers[i], _source, x, y, z, coords)
		end
	end
end)

-- Blips de l'unité X

RegisterServerEvent('esx_ambulance:NotificationBlipsX')
AddEventHandler('esx_ambulance:NotificationBlipsX', function(x, y, z, name)
	local _source = source
	local xPlayer = ESX.GetPlayerFromId(_source)
	local xPlayers = ESX.GetPlayers()

	for i = 1, #xPlayers, 1 do
		local thePlayer = ESX.GetPlayerFromId(xPlayers[i])
		if thePlayer.job.name == 'ambulance' then
			TriggerClientEvent('esx_ambulancejob:NotificationBlipsX2', xPlayers[i], _source, x, y, z)
		end
	end
end)

RegisterServerEvent('esx_ambulancejob:heal')
AddEventHandler('esx_ambulancejob:heal', function(target, type)
	local xPlayer = ESX.GetPlayerFromId(source)

	if xPlayer.job.name == 'ambulance' then
		TriggerClientEvent('esx_ambulancejob:heal', target, type)
	end
end)

RegisterServerEvent('esx_ambulancejob:putInVehicle')
AddEventHandler('esx_ambulancejob:putInVehicle', function(target)
	local xPlayer = ESX.GetPlayerFromId(source)

	if xPlayer.job.name == 'ambulance' then
		TriggerClientEvent('esx_ambulancejob:putInVehicle', target)
	end
end)

TriggerEvent('esx_phone:registerNumber', 'ambulance', _U('alert_ambulance'), true, true)

TriggerEvent('esx_society:registerSociety', 'ambulance', 'Ambulance', 'society_ambulance', 'society_ambulance', 'society_ambulance', {type = 'public'})

ESX.RegisterServerCallback('esx_ambulancejob:removeItemsAfterRPDeath', function(source, cb)
	local xPlayer = ESX.GetPlayerFromId(source)

	if Config.RemoveCashAfterRPDeath then
		if xPlayer.getMoney() > 0 then
			xPlayer.removeMoney(xPlayer.getMoney())
		end

		if xPlayer.getAccount('black_money').money > 0 then
			xPlayer.setAccountMoney('black_money', 0)
		end
	end

	if Config.RemoveItemsAfterRPDeath then
		for i=1, #xPlayer.inventory, 1 do
			if xPlayer.inventory[i].count > 0 then
				xPlayer.setInventoryItem(xPlayer.inventory[i].name, 0)
			end
		end
	end

	local playerLoadout = {}
	if Config.RemoveWeaponsAfterRPDeath then
		for i=1, #xPlayer.loadout, 1 do
			xPlayer.removeWeapon(xPlayer.loadout[i].name)
		end
	else -- save weapons & restore em' since spawnmanager removes them
		for i=1, #xPlayer.loadout, 1 do
			table.insert(playerLoadout, xPlayer.loadout[i])
		end

		-- give back wepaons after a couple of seconds
		Citizen.CreateThread(function()
			Citizen.Wait(5000)
			for i=1, #playerLoadout, 1 do
				if playerLoadout[i].label ~= nil then
					xPlayer.addWeapon(playerLoadout[i].name, playerLoadout[i].ammo)
				end
			end
		end)
	end

	cb()
end)

if Config.EarlyRespawnFine then
	ESX.RegisterServerCallback('esx_ambulancejob:checkBalance', function(source, cb)
		local xPlayer = ESX.GetPlayerFromId(source)
		local bankBalance = xPlayer.getAccount('bank').money

		cb(bankBalance >= Config.EarlyRespawnFineAmount)
	end)

	RegisterServerEvent('esx_ambulancejob:payFine')
	AddEventHandler('esx_ambulancejob:payFine', function()
		local xPlayer = ESX.GetPlayerFromId(source)
		local fineAmount = Config.EarlyRespawnFineAmount

		TriggerClientEvent('esx:showNotification', xPlayer.source, _U('respawn_bleedout_fine_msg', ESX.Math.GroupDigits(fineAmount)))
		xPlayer.removeAccountMoney('bank', fineAmount)
	end)
end

ESX.RegisterServerCallback('esx_ambulancejob:getItemAmount', function(source, cb, item)
	local xPlayer = ESX.GetPlayerFromId(source)
	local quantity = xPlayer.getInventoryItem(item).count

	cb(quantity)
end)

ESX.RegisterServerCallback('esx_ambulancejob:buyJobVehicle', function(source, cb, vehicleProps, type)
	local xPlayer = ESX.GetPlayerFromId(source)
	local price = getPriceFromHash(vehicleProps.model, xPlayer.job.grade_name, type)

	-- vehicle model not found
	if price == 0 then
		cb(false)
	else
		if xPlayer.getMoney() >= price then
			xPlayer.removeMoney(price)
	
			MySQL.Async.execute('INSERT INTO owned_vehicles (owner, vehicle, plate, type, job, `stored`) VALUES (@owner, @vehicle, @plate, @type, @job, @stored)', {
				['@owner'] = xPlayer.identifier,
				['@vehicle'] = json.encode(vehicleProps),
				['@plate'] = vehicleProps.plate,
				['@type'] = type,
				['@job'] = xPlayer.job.name,
				['@stored'] = true
			}, function (rowsChanged)
				cb(true)
			end)
		else
			cb(false)
		end
	end
end)

ESX.RegisterServerCallback('esx_ambulancejob:storeNearbyVehicle', function(source, cb, nearbyVehicles)
	local xPlayer = ESX.GetPlayerFromId(source)
	local foundPlate, foundNum

	for k,v in ipairs(nearbyVehicles) do
		local result = MySQL.Sync.fetchAll('SELECT plate FROM owned_vehicles WHERE owner = @owner AND plate = @plate AND job = @job', {
			['@owner'] = xPlayer.identifier,
			['@plate'] = v.plate,
			['@job'] = xPlayer.job.name
		})

		if result[1] then
			foundPlate, foundNum = result[1].plate, k
			break
		end
	end

	if not foundPlate then
		cb(false)
	else
		MySQL.Async.execute('UPDATE owned_vehicles SET `stored` = true WHERE owner = @owner AND plate = @plate AND job = @job', {
			['@owner'] = xPlayer.identifier,
			['@plate'] = foundPlate,
			['@job'] = xPlayer.job.name
		}, function (rowsChanged)
			if rowsChanged == 0 then
				cb(false)
			else
				cb(true, foundNum)
			end
		end)
	end

end)

function getPriceFromHash(hashKey, jobGrade, type)
	if type == 'helicopter' then
		local vehicles = Config.AuthorizedHelicopters[jobGrade]

		for k,v in ipairs(vehicles) do
			if GetHashKey(v.model) == hashKey then
				return v.price
			end
		end
	elseif type == 'car' then
		local vehicles = Config.AuthorizedVehicles[jobGrade]

		for k,v in ipairs(vehicles) do
			if GetHashKey(v.model) == hashKey then
				return v.price
			end
		end
	end

	return 0
end

RegisterServerEvent('esx_ambulancejob:removeItem')
AddEventHandler('esx_ambulancejob:removeItem', function(item)
	local _source = source
	local xPlayer = ESX.GetPlayerFromId(_source)

	xPlayer.removeInventoryItem(item, 1)
end)

RegisterServerEvent('esx_ambulancejob:giveItem')
AddEventHandler('esx_ambulancejob:giveItem', function(itemName)
	local xPlayer = ESX.GetPlayerFromId(source)

	if xPlayer.job.name ~= 'ambulance' then
		return
	elseif (itemName ~= 'medikit' and itemName ~= 'bandage') then
		return
	end

	local xItem = xPlayer.getInventoryItem(itemName)
	local count = 1

	if xItem.limit ~= -1 then
		count = xItem.limit - xItem.count
	end

	if xItem.count < xItem.limit then
		xPlayer.addInventoryItem(itemName, 5)
	else
		TriggerClientEvent('esx:showNotification', source, _U('max_item'))
	end
end)

TriggerEvent('es:addGroupCommand', 'revive', 'admin', function(source, args, user)
	if args[1] ~= nil then
		if GetPlayerName(tonumber(args[1])) ~= nil then
			TriggerClientEvent('esx_ambulancejob:reviveplayer', tonumber(args[1]))
		end
	else
		TriggerClientEvent('esx_ambulancejob:reviveplayer', source)
	end
end, function(source, args, user)
	TriggerClientEvent('chat:addMessage', source, { args = { '^1SYSTEM', 'Insufficient Permissions.' } })
end, { help = _U('revive_help'), params = {{ name = 'id' }} })

ESX.RegisterUsableItem('medikit', function(source)
	if not playersHealing[source] then
		local xPlayer = ESX.GetPlayerFromId(source)
		xPlayer.removeInventoryItem('medikit', 1)
	
		playersHealing[source] = true
		TriggerClientEvent('esx_ambulancejob:useItem', source, 'medikit')

		Citizen.Wait(10000)
		playersHealing[source] = nil
	end
end)

ESX.RegisterUsableItem('paracetamol', function(source)
	local xPlayers     = ESX.GetPlayers()
	local hasAmbulance = false

	for i = 1, #xPlayers, 1 do
	  local xPlayer = ESX.GetPlayerFromId(xPlayers[i])
	  if xPlayer.job.name == 'ambulance' then
		hasAmbulance = true
		break
	  end
	end

	local xPlayer = ESX.GetPlayerFromId(source)
	if not hasAmbulance then
		xPlayer.removeInventoryItem('paracetamol', 1)
		TriggerClientEvent('clp:useparacetamol', source)
	else
		TriggerClientEvent('esx:showNotification', source, "~r~Vous ne pouvez utiliser ce kit, un ambulancier est en service")  
	end
end)

ESX.RegisterUsableItem('bandage', function(source)
	local xPlayers     = ESX.GetPlayers()
	local hasAmbulance = false

	for i = 1, #xPlayers, 1 do
	  local xPlayer = ESX.GetPlayerFromId(xPlayers[i])
	  if xPlayer.job.name == 'ambulance' then
		hasAmbulance = true
		break
	  end
	end
	
	if not hasAmbulance then
		if not playersHealing[source] then
			local xPlayer = ESX.GetPlayerFromId(source)
			xPlayer.removeInventoryItem('bandage', 1)
		
			playersHealing[source] = true
			TriggerClientEvent('esx_ambulancejob:useItem', source, 'bandage')

			Citizen.Wait(10000)
			playersHealing[source] = nil
		end
	else
		TriggerClientEvent('esx:showNotification', source, "~r~Vous ne pouvez utiliser ce kit, un ambulancier est en service")  
	end
end)

ESX.RegisterServerCallback('esx_ambulancejob:getDeathStatus', function(source, cb)
	local identifier = GetPlayerIdentifiers(source)[1]

	MySQL.Async.fetchScalar('SELECT is_dead FROM users WHERE identifier = @identifier', {
		['@identifier'] = identifier
	}, function(isDead)
		if isDead then

		end

		cb(isDead)
	end)
end)

RegisterServerEvent('esx_ambulancejob:setDeathStatus')
AddEventHandler('esx_ambulancejob:setDeathStatus', function(isDead)
	local identifier = GetPlayerIdentifiers(source)[1]

	if type(isDead) ~= 'boolean' then

		return
	end

	MySQL.Sync.execute('UPDATE users SET is_dead = @isDead WHERE identifier = @identifier', {
		['@identifier'] = identifier,
		['@isDead'] = isDead
	})
end)


RegisterServerEvent('esx_ambulancejob:RetirerBlipServer')
AddEventHandler('esx_ambulancejob:RetirerBlipServer', function(blipsRenfort)
	local _source = source
	local xPlayer = ESX.GetPlayerFromId(_source)
	local xPlayers = ESX.GetPlayers()

	for i = 1, #xPlayers, 1 do
		local thePlayer = ESX.GetPlayerFromId(xPlayers[i])
		if thePlayer.job.name == 'ambulance' then
			TriggerClientEvent('esx_ambulancejob:BlipRetirer', xPlayers[i], blipsRenfort)
		end
	end
end)


RegisterServerEvent('AnnounceEMSOuvert')
AddEventHandler('AnnounceEMSOuvert', function()
	local _source = source
	local xPlayer = ESX.GetPlayerFromId(_source)
	local xPlayers	= ESX.GetPlayers()
	for i=1, #xPlayers, 1 do
		local xPlayer = ESX.GetPlayerFromId(xPlayers[i])
		TriggerClientEvent('esx:showAdvancedNotification', xPlayers[i], 'EMS', '~b~Annonce EMS', 'Un EMS est en service ! Votre santé avant tout !', 'CHAR_CALL911', 8)
	end
end)

RegisterServerEvent('AnnounceEMSFerme')
AddEventHandler('AnnounceEMSFerme', function()
	local _source = source
	local xPlayer = ESX.GetPlayerFromId(_source)
	local xPlayers	= ESX.GetPlayers()
	for i=1, #xPlayers, 1 do
		local xPlayer = ESX.GetPlayerFromId(xPlayers[i])
		TriggerClientEvent('esx:showAdvancedNotification', xPlayers[i], 'EMS', '~b~Annonce EMS', 'Il n\'y a plus d\'EMS en service !', 'CHAR_CALL911', 8)
	end
end)

-- Prise Appel EMS 


-- Notification appel ems pour tout les ems
RegisterServerEvent("Server:emsAppel")
AddEventHandler("Server:emsAppel", function(coords, id)
	--local xPlayer = ESX.GetPlayerFromId(source)
	local _coords = coords
	local xPlayers	= ESX.GetPlayers()

	for i=1, #xPlayers, 1 do
		local xPlayer = ESX.GetPlayerFromId(xPlayers[i])
          if xPlayer.job.name == 'ambulance' then
               TriggerClientEvent("AppelemsTropBien", xPlayers[i], _coords, id)
		end
	end
end)

-- Prise d'appel ems
RegisterServerEvent('EMS:PriseAppelServeur')
AddEventHandler('EMS:PriseAppelServeur', function()
	local _source = source
	local xPlayer = ESX.GetPlayerFromId(_source)
	local name = xPlayer.getName(source)
	local xPlayers = ESX.GetPlayers()

	for i = 1, #xPlayers, 1 do
		local thePlayer = ESX.GetPlayerFromId(xPlayers[i])
		if thePlayer.job.name == 'ambulance' then
			TriggerClientEvent('EMS:AppelDejaPris', xPlayers[i], name)
		end
	end
end)

ESX.RegisterServerCallback('EMS:GetID', function(source, cb)
	local idJoueur = source
	cb(idJoueur)
end)

local AppelTotal = 0
RegisterServerEvent('EMS:AjoutAppelTotalServeur')
AddEventHandler('EMS:AjoutAppelTotalServeur', function()
	local _source = source
	local xPlayer = ESX.GetPlayerFromId(_source)
	local name = xPlayer.getName(source)
	local xPlayers = ESX.GetPlayers()
	AppelTotal = AppelTotal + 1

	for i = 1, #xPlayers, 1 do
		local thePlayer = ESX.GetPlayerFromId(xPlayers[i])
		if thePlayer.job.name == 'ambulance' then
			TriggerClientEvent('EMS:AjoutUnAppel', xPlayers[i], AppelTotal)
		end
	end

end)

RegisterNetEvent("clp_death:removeweapon")
AddEventHandler("clp_death:removeweapon", function()
    _source = source
    xPlayer = ESX.GetPlayerFromId(source)
	local societyAccount = nil
	TriggerEvent('esx_addonaccount:getSharedAccount', 'society_ambulance', function(account)
		societyAccount = account
	end)
	societyAccount.addMoney(350)
	xPlayer.removeMoney(350)
end)