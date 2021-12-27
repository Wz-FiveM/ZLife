ESX = nil

TriggerEvent("esx:getSharedObject", function(response)
    ESX = response
end)


ESX.RegisterServerCallback('vente:getUsergroup', function(source, cb)
     local xPlayer = ESX.GetPlayerFromId(source)
     local group = xPlayer.getGroup()
     cb(group)
end)

ESX.RegisterServerCallback('vente:GetMoinEtPlusVeh', function(source, cb)
	MySQL.Async.fetchAll("SELECT vehicleProps, MAX(price) FROM vehicles_for_sale", nil, function(result)
		cb(result)
	end)
end)

local VehiclesForSale = 0

ESX.RegisterServerCallback("clp_vapid:retrieveVehicles", function(source, cb)
	local src = source
	local identifier = ESX.GetPlayerFromId(src)["identifier"]

	MySQL.Async.fetchAll("SELECT seller, vehicleProps, price FROM vehicles_for_sale", nil, function(result)
		local vehicleTable = {}

		 VehiclesForSale = 0

		if result[1] ~= nil then
			for i = 1, #result, 1 do
				VehiclesForSale = VehiclesForSale + 1

				local seller = false

				if result[i]["seller"] == identifier then
					seller = true
				end

				table.insert(vehicleTable, { ["price"] = result[i]["price"], ["vehProps"] = json.decode(result[i]["vehicleProps"]), ["owner"] = seller })
			end
		end

		cb(vehicleTable)
	end)
end)


ESX.RegisterServerCallback("clp_vapid:isVehicleValid1", function(source, cb, vehicleProps,  VehName)
	local src = source
	local xPlayer = ESX.GetPlayerFromId(src)
    local plate = vehicleProps["plate"]
	local isFound = false
	RetrievePlayerVehicles(xPlayer.identifier, function(ownedVehicles)
		for id, v in pairs(ownedVehicles) do
			if Trim(plate) == Trim(v.plate) then
				isFound = true
				break
			end		
		end
		cb(isFound)
	end)
end)

ESX.RegisterServerCallback("clp_vapid:isVehicleValid", function(source, cb, vehicleProps, price, VehName)
	local src = source
	local xPlayer = ESX.GetPlayerFromId(src)
    
    local plate = vehicleProps["plate"]

	local isFound = false

	RetrievePlayerVehicles(xPlayer.identifier, function(ownedVehicles)

		for id, v in pairs(ownedVehicles) do

			if Trim(plate) == Trim(v.plate) then
                
                MySQL.Async.execute("INSERT INTO vehicles_for_sale (seller, vehicleProps, price) VALUES (@sellerIdentifier, @vehProps, @vehPrice)",
                    {
					["@sellerIdentifier"] = xPlayer["identifier"],
                        	["@vehProps"] = json.encode(vehicleProps),
                        	["@vehPrice"] = price
                    }, function(row)
				end)
				local m = vehicleProps["modEngine"]
				local f = vehicleProps["modBrakes"]
				local t = vehicleProps["modTransmission"]
				if m == -1 then m = 0 end
				if f == -1 then f = 0 end
				if t == -1 then t = 0 end

				MySQL.Async.execute('DELETE FROM owned_vehicles WHERE plate = @plate', { ["@plate"] = plate}, function(row) end)
				MySQL.Async.execute('DELETE FROM open_car WHERE value = @value', { ["@value"] = plate}, function(row) end)
				
                	TriggerClientEvent("occase:ActualiseListVeh", -1)

				isFound = true
				break

			end		

		end

		cb(isFound)

	end)
end)

ESX.RegisterServerCallback("clp_vapid:buyVehicle", function(source, cb, vehProps, price, remove)
	
	local src = source
	local xPlayer = ESX.GetPlayerFromId(src)
    
	local price = price
	local plate = vehProps["plate"]

	MySQL.Async.fetchAll('SELECT price FROM vehicles_for_sale WHERE vehicleProps LIKE "%' .. plate .. '%"', nil, function(result)
		if remove ~= "remove" then
			if result[1]["price"] == price then
				if xPlayer.getAccount("bank")["money"] >= price or price == 0 then
					MySQL.Async.fetchAll('SELECT seller FROM vehicles_for_sale WHERE vehicleProps LIKE "%' .. plate .. '%"', nil, function(result)
						if result[1] ~= nil and result[1]["seller"] ~= nil then
							UpdateCash(result[1]["seller"], price)

							xPlayer.removeAccountMoney("bank", price)
				
							MySQL.Async.execute("INSERT INTO owned_vehicles (plate, owner, vehicle, job, stored) VALUES (@plate, @identifier, @vehProps, @job, @stored)",
								{
									["@plate"] = plate,
									["@identifier"] = xPlayer["identifier"],
									["@vehProps"] = json.encode(vehProps),
									['@job'] = 'empty',
									["@stored"] = 0
								}, function(row)
							end)

							MySQL.Async.execute("INSERT INTO open_car (label, value, NB, got, identifier) VALUES (@label, @value, @NB, @got, @identifier)",
							{
								['@label'] = 'Cles',
								["@value"] = plate,
								['@NB']   		  = 1,
								['@got']  		  = 'true',
								["@identifier"] = xPlayer["identifier"],
								["@vehProps"] = json.encode(vehProps),
								["@state"] = 1
							}, function(row) 
						end)

							TriggerClientEvent("occase:ActualiseListVeh", -1)

							MySQL.Async.execute('DELETE FROM vehicles_for_sale WHERE vehicleProps LIKE "%' .. plate .. '%"', nil, function(row) end)
							cb(true)
						else
							print("Something went wrong, there was no car.")
							cb(false, _, true)
						end
					end)
				else
					cb(false, xPlayer.getAccount("bank")["money"])
				end
			else
				DropPlayer(src, "RUBY AC | Vous avez perdu la synchronisation avec le serveur. Vous informations on été envoyé au staff pour étudier votre désync.\nLe joueur **["..src.."]**: "..GetPlayerName(src).." à essayer d'acheter un véhicule à **"..price.."$** alors que le prix était: **"..result[1]	["price"].."$**)") -- Add your anti cheat detection here.
			end
		else
			if xPlayer.getAccount("bank")["money"] >= price or price == 0 then
				MySQL.Async.fetchAll('SELECT seller FROM vehicles_for_sale WHERE vehicleProps LIKE "%' .. plate .. '%"', nil, function(result)
					if result[1] ~= nil and result[1]["seller"] ~= nil then
						xPlayer.removeAccountMoney("bank", price)
			
						MySQL.Async.execute("INSERT INTO owned_vehicles (plate, owner, vehicle, job, stored) VALUES (@plate, @identifier, @vehProps, @job, @stored)",
						{
							["@plate"] = plate,
							["@identifier"] = xPlayer["identifier"],
							["@vehProps"] = json.encode(vehProps),
							['@job'] = 'empty',
							["@stored"] = 0
						}, function(row)
					end)

						MySQL.Async.execute("INSERT INTO open_car (label, value, NB, got, identifier) VALUES (@label, @value, @NB, @got, @identifier)",
						{
							['@label'] = 'Cles',
							["@value"] = plate,
							['@NB'] = 1,
							['@got'] = 'true',
							["@identifier"] = xPlayer["identifier"],
							["@vehProps"] = json.encode(vehProps),
							["@state"] = 1
						}, function(row) 
					end)
					
						TriggerClientEvent("occase:ActualiseListVeh", -1)

									
						MySQL.Async.execute('DELETE FROM vehicles_for_sale WHERE vehicleProps LIKE "%' .. plate .. '%"', nil, function(row) end)
						cb(true)
					else
						print("Something went wrong, there was no car.")
					end
				end)
			else
				cb(false, xPlayer.getAccount("bank")["money"])
			end		
		end
	end)
end)


function RetrievePlayerVehicles(newIdentifier, cb)
	local identifier = newIdentifier

	local yourVehicles = {}

	MySQL.Async.fetchAll("SELECT * FROM owned_vehicles WHERE owner = @identifier", {['@identifier'] = identifier}, function(result) 

		for id, values in pairs(result) do

			local vehicle = json.decode(values.vehicle)
			local plate = values.plate

			table.insert(yourVehicles, { vehicle = vehicle, plate = plate })
		end

		cb(yourVehicles)

	end)
end

function UpdateCash(identifier, cash)
	local xPlayer = ESX.GetPlayerFromIdentifier(identifier)

	if xPlayer ~= nil then
		xPlayer.addAccountMoney("bank", cash)

		TriggerClientEvent("esx:showNotification", xPlayer.source, "~b~Vapid\n~s~Un de vos véhicules viens d'être acheté. (~b~"..cash.."$~s~)")
	else
		MySQL.Async.fetchAll('SELECT bank FROM users WHERE identifier = @identifier', { ["@identifier"] = identifier }, function(result)
			if result[1]["bank"] ~= nil then
				MySQL.Async.execute("UPDATE users SET bank = @newBank WHERE identifier = @identifier",
					{
						["@identifier"] = identifier,
						["@newBank"] = result[1]["bank"] + cash
					}, function(rows) 
				end)
			end
		end)
	end
end

Trim = function(word)
	if word ~= nil then
		return word:match("^%s*(.-)%s*$")
	else
		return nil
	end
end

RegisterServerEvent('AnnounceVenteVehicule')
AddEventHandler('AnnounceVenteVehicule', function(prix, VehName, type)
	TriggerClientEvent('esx:showNotification', -1, "~b~Vapid\n~s~Nouveau véhicule en vente.\n~w~Type: ~b~"..type.."\n~w~Modèle: ~b~"..VehName.."\n~w~Prix: ~b~"..prix.."$")
end)

ESX.RegisterServerCallback('occas:GetVeh', function(source, cb)
	MySQL.Async.fetchAll("SELECT * FROM vehicles_for_sale INNER JOIN users ON vehicles_for_sale.seller = users.identifier", nil, function(result)
		cb(result)
	end)
end)


ESX.RegisterServerCallback("occas:GetOwner", function(source, cb)
	local identifant = GetPlayerIdentifier(source)
	for k,v in pairs(GetPlayerIdentifiers(source)) do
		if string.sub(v, 1, string.len("license:")) == "license:" then
			license = v
			--print(license)
			cb(license)
		end
	end
end)