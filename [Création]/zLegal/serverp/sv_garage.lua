ESX                = nil

TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

ESX.RegisterServerCallback('esx_advancedgarage:getOutOwnedCars', function(source, cb)
	local ownedCars = {}

	MySQL.Async.fetchAll('SELECT * FROM owned_vehicles WHERE owner = @owner AND Type = @Type AND job = @job AND `stored` = @stored', {
		['@owner'] = GetPlayerIdentifiers(source)[1],
		['@Type'] = 'car',
		['@job'] = 'empty',
		['@stored'] = false
	}, function(data) 
		for _,v in pairs(data) do
			local vehicle = json.decode(v.vehicle)
			table.insert(ownedCars, vehicle)
		end
		cb(ownedCars)
	end)
end)

ESX.RegisterServerCallback('esx_advancedgarage:checkMoneyCars', function(source, cb)
	local xPlayer = ESX.GetPlayerFromId(source)
	if xPlayer.get('money') >= 250 then
		cb(true)
	else
		cb(false)
	end
end)

RegisterServerEvent('esx_advancedgarage:payCar')
AddEventHandler('esx_advancedgarage:payCar', function()
	local xPlayer = ESX.GetPlayerFromId(source)
	xPlayer.removeMoney(250)
	TriggerClientEvent('esx:showNotification', source, _U('you_paid') .. 250)
end)

RegisterServerEvent('esx_advancedgarage:setVehicleState')
AddEventHandler('esx_advancedgarage:setVehicleState', function(plate, state)
	local xPlayer = ESX.GetPlayerFromId(source)

	MySQL.Async.execute('UPDATE owned_vehicles SET `stored` = @stored WHERE plate = @plate', {
		['@stored'] = state,
		['@plate'] = plate
	}, function(rowsChanged)
		if rowsChanged == 0 then
			--print(('esx_advancedgarage: %s exploited the garage!'):format(xPlayer.identifier))
		end
	end)
end)