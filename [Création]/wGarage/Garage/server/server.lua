ESX = nil

TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

ESX.RegisterServerCallback('wGarage:listevoiturefourriere', function(source, cb)
	local ownedCars = {}
	local xPlayer = ESX.GetPlayerFromId(source)
		MySQL.Async.fetchAll('SELECT * FROM owned_vehicles WHERE `stored` = @stored', { -- job = NULL
			['@stored'] = false
		}, function(data)
			for _,v in pairs(data) do
				local vehicle = json.decode(v.vehicle)
				table.insert(ownedCars, {vehicle = vehicle, stored = v.stored, plate = v.plate})
			end
			cb(ownedCars)
		end)
end)

ESX.RegisterServerCallback('wGarage:listevoiture', function(source, cb)
	local ownedCars = {}
	local xPlayer = ESX.GetPlayerFromId(source)
    MySQL.Async.fetchAll('SELECT * FROM owned_vehicles WHERE owner = @owner AND Type = @Type AND `stored` = @stored', { -- job = NULL
        ['@owner'] = xPlayer.identifier,
        ['@Type'] = 'car',
        ['@stored'] = true
    }, function(data)
        for _,v in pairs(data) do
            local vehicle = json.decode(v.vehicle)
            table.insert(ownedCars, {vehicle = vehicle, stored = v.stored, plate = v.plate})
        end
        cb(ownedCars)
    end)
end)

--état sortie véhicule
RegisterServerEvent('wGarage:etatvehiculesortie')
AddEventHandler('wGarage:etatvehiculesortie', function(plate, state)
	local xPlayer = ESX.GetPlayerFromId(source)

	MySQL.Async.execute('UPDATE owned_vehicles SET `stored` = @stored WHERE plate = @plate', {
		['@stored'] = state,
		['@plate'] = plate
	}, function(rowsChanged)
		if rowsChanged == 0 then
		end
	end)
end)


ESX.RegisterServerCallback('wGarage:rangervoiture', function (source, cb, vehicleProps)
	local ownedCars = {}
	local vehplate = vehicleProps.plate:match("^%s*(.-)%s*$")
	local vehiclemodel = vehicleProps.model
	local xPlayer = ESX.GetPlayerFromId(source)

	MySQL.Async.fetchAll('SELECT * FROM owned_vehicles WHERE owner = @owner AND @plate = plate', {
		['@owner'] = xPlayer.identifier,
		['@plate'] = vehicleProps.plate
	}, function (result)
		if result[1] ~= nil then
			local originalvehprops = json.decode(result[1].vehicle)
			if originalvehprops.model == vehiclemodel then
				MySQL.Async.execute('UPDATE owned_vehicles SET vehicle = @vehicle WHERE owner = @owner AND plate = @plate', {
					['@owner'] = xPlayer.identifier,
					['@vehicle'] = json.encode(vehicleProps),
					['@plate'] = vehicleProps.plate
				}, function (rowsChanged)
					if rowsChanged == 0 then
					end
					cb(true)
				end)
			else
				cb(false)
			end
		else
			cb(false)
		end
	end)
end)

