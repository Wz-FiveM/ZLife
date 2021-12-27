local plyInProperties = {}
Server = {}
Server.Properties = {}

ESX = nil
TriggerEvent('esx:getSharedObject', function(a)
    ESX = a 
end)

Server.InstancePlayer = {}

RegisterServerEvent("ESX:createProperty")
AddEventHandler("ESX:createProperty", function(name, propertypos, garagepos, garagemax, interior, price, maxChest)
    local xPlayer = ESX.GetPlayerFromId(source)

    MySQL.Async.insert("INSERT INTO properties_list(property_name, property_pos, property_chest, garage_pos, garage_max, property_type, property_price) VALUES(@property_name, @property_pos, @property_chest, @garage_pos, @garage_max, @property_type, @property_price)", {
        ["@property_name"] = name,
        ["@property_pos"] = json.encode(propertypos),
        ["@property_chest"] = maxChest,
        ["@garage_pos"] = json.encode(garagepos),
        ["@garage_max"] = garagemax,
        ["@property_type"] = interior,
        ["@property_price"] = price
    })

    TriggerClientEvent("ESX:InitProperties", xPlayer.source)
end)

RegisterServerEvent("ESX:updateProperty")
AddEventHandler("ESX:updateProperty", function(pName, status, target)
    local xPlayer = target and ESX.GetPlayerFromId(target) or ESX.GetPlayerFromId(source)

    MySQL.Async.execute("UPDATE properties_list SET property_status = @status, property_owner = @identifier WHERE property_name = @pName", {
        ["@status"] = status,
        ["@identifier"] = xPlayer.getIdentifier(),
        ["@pName"] = pName
    })

    TriggerClientEvent("esx:showNotification", xPlayer.source, "Vous possedé désormais la propriété \n~b~" .. pName)
    Wait(1000)
    TriggerClientEvent("ESX:InitProperties", xPlayer.source)
end)

RegisterServerEvent("ESX:updatePropertyName")
AddEventHandler("ESX:updatePropertyName", function(pName, newName)
    local xPlayer = ESX.GetPlayerFromId(source)


    MySQL.Async.fetchAll("SELECT id_property FROM properties_list WHERE property_name = @pName", {
        ["@pName"] = newName
    }, function(result)
        if result[1] then return TriggerClientEvent("esx:showNotification", xPlayer.source, "~r~Une propriété avec ce nom existe déjà.") end

        MySQL.Async.execute("UPDATE properties_list SET property_name = @newName WHERE property_name = @pName", {
            ["@newName"] = newName,
            ["@pName"] = pName
        })    
        TriggerClientEvent("esx:showNotification", xPlayer.source, "Vous avez renommé votre propriété :\n~b~" .. newName .. ".")
    end)
end)

RegisterServerEvent("ESX:deleteProperty")
AddEventHandler("ESX:deleteProperty", function(pName)
    local xPlayer = ESX.GetPlayerFromId(source)
    
    MySQL.Async.execute("DELETE FROM properties_list WHERE property_name = @pName", {
        ["@pName"] = pName
    })

    TriggerClientEvent("esx:showNotification", xPlayer.source, "~r~Vous avez supprimé la propriété\n" .. pName .. ".")
    TriggerClientEvent("ESX:InitProperties", xPlayer.source)
end)

RegisterServerEvent("ESX:addAccess")
AddEventHandler("ESX:addAccess", function(pId, plyId, pName)
    local xPlayer = ESX.GetPlayerFromId(source)
    local xTarget = ESX.GetPlayerFromId(plyId)

    if xTarget then 
        MySQL.Async.fetchAll("SELECT firstname, lastname FROM users WHERE identifier = @identifier", {
            ["@identifier"] = xTarget.identifier
        }, function(result)
            if result[1] then
                local Player = {}
                Player.FirstName = result[1].firstname
                Player.LastName = result[1].lastname
                Player.Name = Player.FirstName .. " " .. Player.LastName

                MySQL.Async.execute("INSERT INTO properties_access(label, identifier, id_property) VALUES(@plyName, @identifier, @pId)", {
                    ["@plyName"] = Player.Name,
                    ["@identifier"] = xTarget.identifier,
                    ["@pId"] = pId
                })

                TriggerClientEvent("esx:showNotification", xPlayer.source, "Vous avez ajouté ~b~" .. Player.Name .. "~s~ à la propriété. \n~b~" .. pName)
            end
        end)

        TriggerClientEvent("esx:showNotification", xTarget.source, "Vous êtes désormais locataire de la propriété \n~b~" .. pName)
    end
end)

RegisterServerEvent("ESX:deleteAccess")
AddEventHandler("ESX:deleteAccess", function(identifier, pName)
    local xPlayer = ESX.GetPlayerFromId(source)

    MySQL.Async.execute("DELETE FROM properties_access WHERE identifier = @identifier", {
        ["@identifier"] = identifier
    })
end)

RegisterServerEvent("ESX:stockVehicleInProperty")
AddEventHandler("ESX:stockVehicleInProperty", function(pName, max, vehProps, pId)
    local xPlayer = ESX.GetPlayerFromId(source)

    MySQL.Async.fetchAll("SELECT label FROM properties_vehicles INNER JOIN properties_list ON properties_list.id_property = properties_vehicles.id_property WHERE property_name = @pName", {
        ["@pName"] = pName
    }, function(result)
        if result[max] then return TriggerClientEvent("esx:showNotification", xPlayer.source, "~r~Le garage est plein.") end
        MySQL.Async.execute("INSERT INTO properties_vehicles(label, vehicle_property, id_property) VALUES(@label, @vehProps, @pId)", {
            ["@label"] = vehProps.model,
            ["@vehProps"] = json.encode(vehProps),
            ["@pId"] = pId
        })

        TriggerClientEvent("ESX:stockVehicleInProperty", xPlayer.source, vehProps.model)
    end)

    if Server.Properties and Server.Properties[pId].Players then
        for k, v in pairs(Server.Properties[pId].Players) do
            if v ~= source then
                local xPlayer = ESX.GetPlayerFromId(v)
                TriggerClientEvent("ESX:refreshGarage", xPlayer.source)
            end
        end
    end
end)

RegisterServerEvent("ESX:ringProperty")
AddEventHandler("ESX:ringProperty", function(tblAccess, owner, pName)
    local xPlayer = ESX.GetPlayerFromId(source)

    local xTarget = ESX.GetPlayerFromIdentifier(owner) or nil
    if xTarget then
        TriggerClientEvent("ESX:ringProperty", xTarget.source, pName, xPlayer.source)
    end

    for k, v in pairs(tblAccess) do
        local xTarget = ESX.GetPlayerFromIdentifier(v.player_identifier) or nil
        if xTarget then
            TriggerClientEvent("ESX:ringProperty", xTarget.source, pName, xPlayer.source)
        end
    end
end)

RegisterServerEvent("ESX:refuseEnterProperty")
AddEventHandler("ESX:refuseEnterProperty", function(pName, target)
    local xPlayer = ESX.GetPlayerFromId(target)

    TriggerClientEvent("esx:showNotification", xPlayer.source, "L'accès à la propriété vous a été ~r~refusé.\n~b~" .. pName)
end)

RegisterServerEvent("ESX:acceptEnterProperty")
AddEventHandler("ESX:acceptEnterProperty", function(pName, target)
    local xPlayer = ESX.GetPlayerFromId(target)
    TriggerClientEvent("esx:showNotification", xPlayer.source, "L'accès à la propriété vous a été ~g~autorisé.\n~b~" .. pName)
    TriggerClientEvent("ESX:enterRingedProperty", xPlayer.source)
end)

RegisterServerEvent("ESX:vehicleOutGarage")
AddEventHandler("ESX:vehicleOutGarage", function(vehId, propId)
    MySQL.Async.execute("DELETE FROM properties_vehicles WHERE id_vehicle = @id", {
        ["@id"] = vehId
    })

    if Server.Properties and Server.Properties[propId].Players then
        for k, v in pairs(Server.Properties[propId].Players) do
            if v ~= source then
                local xPlayer = ESX.GetPlayerFromId(v)
                TriggerClientEvent("ESX:refreshGarage", xPlayer.source)
            end
        end
    end
end)

RegisterServerEvent("ESX:updatePropertyInterior")
AddEventHandler("ESX:updatePropertyInterior", function(pName, price, interior)
    local xPlayer = ESX.GetPlayerFromId(source)

    MySQL.Async.execute("UPDATE properties_list SET property_price = @price, property_type = @interior WHERE property_name = @pName", {
        ["@price"] = price,
        ["@interior"] = interior,
        ["@pName"] = pName
    })

    TriggerClientEvent("esx:showNotification", xPlayer.source, "Le prix de la propriété \n~b~" .. pName .. "\n~s~est désormais de ~b~" .. price .. "$.")
    Wait(500)
    TriggerClientEvent("ESX:InitProperties", xPlayer.source)
end)

RegisterServerEvent("ESX:updatePropertyGarage")
AddEventHandler("ESX:updatePropertyGarage", function(pName, price, max)
    local xPlayer = ESX.GetPlayerFromId(source)

    MySQL.Async.execute("UPDATE properties_list SET property_price = @price, garage_max = @max WHERE property_name = @pName", {
        ["@price"] = price,
        ["@max"] = max,
        ["@pName"] = pName
    })

    TriggerClientEvent("esx:showNotification", xPlayer.source, "Le prix de la propriété \n~b~" .. pName .. "\n~s~est désormais de ~b~" .. price .. "$.")
    Wait(500)
    TriggerClientEvent("ESX:InitProperties", xPlayer.source)
end)

RegisterServerEvent("ESX:updatePropertyPoids")
AddEventHandler("ESX:updatePropertyPoids", function(pName, price, max)
    local xPlayer = ESX.GetPlayerFromId(source)

    MySQL.Async.execute("UPDATE properties_list SET property_price = @price, property_chest = @max WHERE property_name = @pName", {
        ["@price"] = price,
        ["@max"] = max,
        ["@pName"] = pName
    })

    TriggerClientEvent("esx:showNotification", xPlayer.source, "Le prix de la propriété \n~b~" .. pName .. "\n~s~est désormais de ~b~" .. price .. "$.")
    Wait(500)
    TriggerClientEvent("ESX:InitProperties", xPlayer.source)
end)

ESX.RegisterServerCallback("ESX:PayBank", function(source, cb, money)
	local xPlayer = ESX.GetPlayerFromId(source)

	if xPlayer.getAccount('bank').money >= money then
		cb(true)
		xPlayer.removeAccountMoney("bank", money)
	else
		cb(false)
	end
end)

RegisterServerEvent("ESX:initInstance")
AddEventHandler("ESX:initInstance", function(id)
    local xPlayer = ESX.GetPlayerFromId(source)
    local xPlayers = ESX.GetPlayers()
    if not Server.Properties[id].Players[xPlayer.source] then
        Server.Properties[id].Players[xPlayer.source] = xPlayer.source
    end

    Server.InstancePlayer[xPlayer.identifier] = true 
    TriggerEvent("cProperty:CanSave", true, xPlayer.identifier)

    for k, v in pairs (Server.Properties[id].Players) do
        local xTarget = ESX.GetPlayerFromId(k)
        TriggerClientEvent("ESX:startInstance", xTarget.source, Server.Properties[id].Players, xPlayers)
    end
end)

RegisterServerEvent("ESX:outInstance")
AddEventHandler("ESX:outInstance", function(id)
    local xPlayer = ESX.GetPlayerFromId(source)   
    local xPlayers = ESX.GetPlayers()
    if Server.Properties[id].Players[xPlayer.source] then
        Server.Properties[id].Players[xPlayer.source] = nil 
    end

    Server.InstancePlayer[xPlayer.identifier] = false 
    TriggerEvent("cProperty:CanSave", false, xPlayer.identifier)

    for k, v in pairs (Server.Properties[id].Players) do
        local xTarget = ESX.GetPlayerFromId(k)
        TriggerClientEvent("ESX:startInstance", xTarget.source, Server.Properties[id].Players, xPlayers)
    end
end)

RegisterServerEvent("ESX:attributePropertyToOrga")
AddEventHandler("ESX:attributePropertyToOrga", function(pName, id_orga)
    MySQL.Async.execute("UPDATE properties_list SET orga = @orga WHERE property_name = @pName", {
        ["@orga"] = id_orga,
        ["@pName"] = pName
    })
end)


ESX.RegisterServerCallback("ESX:getProperties", function(source, cb)
    Server.Properties = {}
    MySQL.Async.fetchAll("SELECT * FROM properties_list", {},
    function(result)
        cb(result)

        for k, v in pairs (result) do
            Server.Properties[v.id_property] = v
            if not Server.Properties[v.id_property].Players then
                Server.Properties[v.id_property].Players = {}
            end
        end
    end)
end)

ESX.RegisterServerCallback("ESX:getAccess", function(source, cb, pName)
    MySQL.Async.fetchAll("SELECT properties_access.label AS 'player_name', properties_access.identifier AS 'player_identifier' FROM properties_access INNER JOIN properties_list ON properties_access.id_property = properties_list.id_property WHERE property_name = @name", {
        ["@name"] = pName
    }, function(result)
        cb(result)
    end)
end)

ESX.RegisterServerCallback("ESX:getVehicles", function(source, cb, pName)
    MySQL.Async.fetchAll("SELECT * FROM properties_vehicles INNER JOIN properties_list ON properties_list.id_property = properties_vehicles.id_property WHERE property_name = @pName", {
        ["@pName"] = pName
    }, function(result)
        cb(result)
    end)
end)

RegisterServerEvent("ESX:attributePropertyToJob")
AddEventHandler("ESX:attributePropertyToJob", function(pName, job)
    MySQL.Async.execute("UPDATE properties_list SET jobs = @jobs WHERE property_name = @pName", {
        ["@jobs"] = job,
        ["@pName"] = pName
    })
    local xPlayer = ESX.GetPlayerFromId(source)
    if xPlayer then 
        TriggerClientEvent("esx:showNotification", xPlayer.source, "~b~Vous avez attribuer la propriété à votre métier.")
    end
    Wait(500)
    TriggerClientEvent("ESX:InitProperties", xPlayer.source)
end)

AddEventHandler("onResourceStart", function()
    while true do
        local xPlayers = ESX.GetPlayers()

        for k, v in pairs(xPlayers) do
            local xPlayer = ESX.GetPlayerFromId(v)
            TriggerClientEvent("ESX:InitProperties", xPlayer.source)
        end
        Wait(5*60*1000)
    end
end)

RegisterServerEvent('ESX:SavePlayer')
AddEventHandler('ESX:SavePlayer', function()
	local xPlayer = ESX.GetPlayerFromId(source)
	local asyncTasks = {}

	if not Server.InstancePlayer[xPlayer.getIdentifier()] then 
		table.insert(asyncTasks, function(cb2)
			MySQL.Async.execute('UPDATE users SET accounts = @accounts, job = @job, job_grade = @job_grade, `group` = @group, loadout = @loadout, position = @position, inventory = @inventory WHERE identifier = @identifier', {
				['@accounts'] = json.encode(xPlayer.getAccounts(true)),
				['@job'] = xPlayer.job.name,
				['@job_grade'] = xPlayer.job.grade,
				['@group'] = xPlayer.getGroup(),
				['@loadout'] = json.encode(xPlayer.getLoadout(true)),
				['@position'] = json.encode(xPlayer.getCoords()),
				['@identifier'] = xPlayer.getIdentifier(),
				['@inventory'] = json.encode(xPlayer.getInventory(true))
			}, function(rowsChanged)
				cb2()
			end)
		end)
	end
end)

MySQL.Async.fetchAll("SELECT * FROM owned_vehicles", {},function (results)
    ESX.RegisterServerCallback("GetVehicles", function(source, cb)
        cb(results)
        for k,v in pairs(results) do
            veh = v.plate
        end
    end)
end)



RegisterNetEvent("esx_advancedgarage:setVehicleState")
AddEventHandler("esx_advancedgarage:setVehicleState", function (plate, state)
    local xPlayer = ESX.GetPlayerFromId(source)
    print(plate)
    print(state)
    MySQL.Async.execute('UPDATE owned_vehicles SET `stored` = @stored and `garageperso` = @garageperso WHERE plate = @plate',
        {    
            ['@stored'] = state,
            ['@garageperso'] = state,
            ['@plate'] = plate
        }
    )
end)









