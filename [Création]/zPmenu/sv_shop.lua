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



---- recruter
RegisterServerEvent('pl_givekeys')
AddEventHandler('pl_givekeys', function(target, currentgarage, iterator)
	local identifier = getLicense(target)
    TriggerClientEvent('esx:showNotification', target, "~g~Vous venez de recevoire les clé de ~s~~h~~b~"..GetPlayerName(source))
    TriggerClientEvent('esx:showNotification', source, "~g~Vous venez de de donner une paire de clé a  ~s~~h~~b~"..GetPlayerName(target))
    TriggerClientEvent("pl_givekeysmanuelement", target, iterator)
	MySQL.Async.execute('INSERT INTO p_garagekeys (identifier, garageid, name) VALUES (@identifier, @garageid, @name)',{
		['@identifier']   = identifier,    
		['@garageid']   = currentgarage,
        ['@name'] = GetPlayerName(target)
	}, function(rowsChanged)
	end)
end) 

RegisterServerEvent('pl_changementgarage')
AddEventHandler('pl_changementgarage', function(type, iterator, value)
    local xPlayers = ESX.GetPlayers()
    for i = 1, #xPlayers do
        local xPlayer = ESX.GetPlayerFromId(xPlayers[i])
        TriggerClientEvent("pl_changementgaragecl", xPlayers[i], type, iterator, value)
    end
end) 

RegisterServerEvent('pl_insertmanuellement')
AddEventHandler('pl_insertmanuellement', function(name, places, entree, rangement, prix, id, cr)
    local xPlayers = ESX.GetPlayers()
    for i = 1, #xPlayers do
        local xPlayer = ESX.GetPlayerFromId(xPlayers[i])
        TriggerClientEvent('pl_insertmanuellementcl', xPlayers[i], name, places, entree, rangement, prix, id, cr)
    end
end) 



RegisterServerEvent('pl_refreshgarage')
AddEventHandler('pl_refreshgarage', function(id, places)
    local xPlayers = ESX.GetPlayers()
    for i = 1, #xPlayers do
        local xPlayer = ESX.GetPlayerFromId(xPlayers[i])
        if source ~= xPlayers[i] then 
            TriggerClientEvent("pl_refreshgaragecl", xPlayers[i], id, places)
        end
    end
end) 


ESX.RegisterServerCallback('pl_checkkeys', function(source, cb, id)
    MySQL.Async.fetchAll('SELECT identifier, id, name FROM p_garagekeys WHERE garageid = @garageid', {
        ['@garageid'] = id
    }, function(result)
        cb(result)
    end)  
end)



ESX.RegisterServerCallback('pl_checkifhasgotkeys', function(source, cb, id, target)
    local identifier = getLicense(target)
    MySQL.Async.fetchAll('SELECT id, name FROM p_garagekeys WHERE garageid = @garageid AND identifier = @identifier', {
        ['@garageid'] = id,
        ['@identifier'] = identifier
    }, function(result)
        if json.encode(result) ~= "[]" then 
            cb("false")
        else
            cb("true")
        end
    end)  
end)

ESX.RegisterServerCallback('pl_checkkeysbegin', function(source, cb, id)
    local identifier = getLicense(source)
    MySQL.Async.fetchAll('SELECT identifier, id, name FROM p_garagekeys WHERE garageid = @garageid', {
        ['@garageid'] = id
    }, function(result)
        if json.encode(result) ~= "[]" then 
            for k, v in pairs(result) do 
                if v.identifier == identifier then 
                    cb("owned")
                end 
            end 
        end 
    end)  
end)



RegisterServerEvent('pl_creategarage')
AddEventHandler('pl_creategarage', function(name, places, entering, rangement, price)
	local identifier = getLicense(source)
    local creator = {name = GetPlayerName(source), steam = identifier}
	MySQL.Async.execute('INSERT INTO p_garage (creator, name, places, inside, rangement, price) VALUES (@creator, @name, @places, @inside, @rangement, @price)',{
		['@creator']   = json.encode(creator),    
		['@name']   = name,
        ['@places'] = places,
        ['@inside'] = json.encode(entering),
        ['@rangement'] = json.encode(rangement),
        ['@price'] = price
	}, function(rowsChanged)
    end)  
    Wait(500)
    MySQL.Async.fetchAll('SELECT id FROM p_garage WHERE creator = @creator AND name = @name AND places = @places AND inside = @inside AND rangement = @rangement AND price = @price', {
        ['@creator'] = json.encode(creator),    
		['@name'] = name,
        ['@places'] = places,
        ['@inside'] = json.encode(entering),
        ['@rangement'] = json.encode(rangement),
        ['@price'] = price
    }, function(result)
        TriggerEvent('pl_insertmanuellement', name, places, json.encode(entering), json.encode(rangement), price, result[1].id, json.encode(creator))
    
	end)
end) 

RegisterServerEvent('pl_givelocation')
AddEventHandler('pl_givelocation', function(id, target, iterator, result)
    local identifier = getLicense(target)
    local owner = {name = GetPlayerName(target), steam = identifier}
    TriggerClientEvent('esx:showNotification', target, "~g~Vous venez de recevoire les clé de ~s~~h~~b~"..GetPlayerName(source))
    TriggerClientEvent('esx:showNotification', source, "~g~Vous venez de de donner une paire de clé a  ~s~~h~~b~"..GetPlayerName(target))
    local xPlayers = ESX.GetPlayers()
    for i = 1, #xPlayers do
        local xPlayer = ESX.GetPlayerFromId(xPlayers[i])
        TriggerClientEvent("pf_givegaragelocationdate", xPlayers[i], "everyone", iterator, result, json.encode(owner))
    end 
    TriggerClientEvent("pf_givegaragelocationdate", target, "solo", iterator, result, json.encode(owner))
    MySQL.Async.execute('UPDATE p_garage SET owner = @owner WHERE id = @id', {
        ['@id'] = id,
        ['@owner'] = json.encode(owner),
    })
    MySQL.Async.execute('UPDATE p_garage SET locationdate = @locationdate WHERE id = @id', {
        ['@id'] = id,
        ['@locationdate'] = result,
    })
end)


RegisterServerEvent('pl_givegaragetoplayer')
AddEventHandler('pl_givegaragetoplayer', function(id, target, iterator)
    local identifier = getLicense(target)
    local owner = {name = GetPlayerName(target), steam = identifier}
    TriggerClientEvent('esx:showNotification', target, "~g~Vous venez de recevoire les clé de ~s~~h~~b~"..GetPlayerName(source))
    TriggerClientEvent('esx:showNotification', source, "~g~Vous venez de de donner une paire de clé a  ~s~~h~~b~"..GetPlayerName(target))
    local xPlayers = ESX.GetPlayers()
    for i = 1, #xPlayers do
        local xPlayer = ESX.GetPlayerFromId(xPlayers[i])
        TriggerClientEvent("pl_givegaragetoplayercl", xPlayers[i], "everyone", iterator, json.encode(owner))
    end 
    TriggerClientEvent("pl_givegaragetoplayercl", target, "solo", iterator, json.encode(owner))
    MySQL.Async.execute('UPDATE p_garage SET owner = @owner WHERE id = @id', {
        ['@id'] = id,
        ['@owner'] = json.encode(owner) 
    })
end)


RegisterServerEvent('pl_updatetable')
AddEventHandler('pl_updatetable', function(id, result, info)
    MySQL.Async.execute('UPDATE p_garage SET '..result..' = @'..result..' WHERE id = @id', {
        ['@id'] = id,
        ['@'..result..''] = info 
    })
end)


ESX.RegisterServerCallback('pl_getallgarages', function(source, cb)
    MySQL.Async.fetchAll('SELECT locationdate, creator, id, name, places, inside, owner, price, rangement FROM p_garage ', {}, function(result)
        cb(result)  
    end)  
end)

ESX.RegisterServerCallback('pl_checkifowned', function(source, cb, id)
    local owners = nil
    MySQL.Async.fetchAll('SELECT owner FROM p_garage WHERE id = @id', {
        ["@id"] = id
    }, function(result)
        if json.encode(result) ~= "[[]]" then 
            for k, v in pairs(result) do
                local owner = json.decode(v.owner)
                if owner ~= nil then 
                    owners = owner
                end 
            end
        end 
        cb(owners)
    end)  
end)




ESX.RegisterServerCallback('pl_checkowner', function(source, cb, owner)
    local identifier = getLicense(source)
    if owner ~= nil then 
        if owner.steam == identifier then  
            cb("owned")
        else
            cb("false")
        end 
    else
        cb("isowned")
    end
end)

local playersInProperties = {}

RegisterServerEvent('pl_entergarage')
AddEventHandler('pl_entergarage', function(propertyID, propertyData)
    local _source = source
    local xPlayer = ESX.GetPlayerFromId(_source)	

    table.insert(playersInProperties, {
        propid = propertyID,
        property = propertyData.name,
        player = _source,
        name = xPlayer.name,
    })

    if #playersInProperties > 0 then
        for k, property in pairs(playersInProperties) do
            if property.propid == propertyID then
                if property.player ~= _source then
                    local playerEnter = ESX.GetPlayerFromId(_source)
                end
            else
				if property.player ~= _source then
					TriggerClientEvent('myProperties:setPlayerInvisible', property.player, "enter", _source, propertyID)
					TriggerClientEvent('myProperties:setPlayerInvisible', _source, "enter",property.player, propertyID)
				end
            end
        end
    end
end)


RegisterServerEvent('pl_leavegarage')
AddEventHandler('pl_leavegarage', function()
    local _source = source
	local xPlayer = ESX.GetPlayerFromId(_source)	
    for k, property in pairs(playersInProperties) do
        TriggerClientEvent('myProperties:setPlayerInvisible', _source, "exit")
        if property.name == xPlayer.name then
            table.remove(playersInProperties, k)
            break
        end
    end
end)


--- garage 
RegisterServerEvent('myProperties:setPlayerInvisiblesrv')
AddEventHandler('myProperties:setPlayerInvisiblesrv', function(k)
    local xPlayers = ESX.GetPlayers()
    for i = 1, #xPlayers do
        local xPlayer = ESX.GetPlayerFromId(xPlayers[i])
        if source ~= xPlayers[i] then 
            TriggerClientEvent("myProperties:setPlayerInvisible", source, xPlayers[i], k)
        end    
    end
end)

RegisterServerEvent('pl_sendmessageback')
AddEventHandler('pl_sendmessageback', function(type, target, id, places, k, entering)
    local source = source
    local xPlayer = ESX.GetPlayerFromId(source)
    local xTarget = ESX.GetPlayerFromIdentifier(target)
    if type == "not_accepted" then 
        TriggerClientEvent('esx:showNotification', xTarget.source, "~r~La personne a refuser votre demande")
    elseif type == "accepted" then
        TriggerClientEvent('esx:showNotification', xTarget.source, "~g~Votre demande a été accepter")
        TriggerClientEvent('pl_acceptplayerinhouse', xTarget.source, id, places, k, entering)
    end 
end)



RegisterServerEvent('pl_askforentryingarage')
AddEventHandler('pl_askforentryingarage', function(steam, name, id, places, k, entering)
    local identifier = getLicense(source)
    local xPlayer = ESX.GetPlayerFromId(source)
    local xTarget = ESX.GetPlayerFromIdentifier(steam)
    if xTarget ~= nil then
    TriggerClientEvent('esx:showNotification', xTarget.source, "~bh~"..GetPlayerName(source).."~hs~ sonne a votre garage nomé ~shb~"..name)
    TriggerClientEvent('esx:showNotification', xTarget.source, "~b~Y ~s~pour accepter/ ~r~F~s~ Refuser")
    TriggerClientEvent('pl_askforentryingaragecl', xTarget.source, identifier, id, places, k, entering)
    else
        TriggerClientEvent('esx:showNotification', source, "joueur absent")
    end
end)

RegisterServerEvent('pl_insertintogarage')
AddEventHandler('pl_insertintogarage', function(idGarage, vehicleProps)
	MySQL.Async.execute('INSERT INTO p_garagecars (garageid, vehicleprops) VALUES (@garageid, @vehicleprops)',{
		['@garageid']   = idGarage, 
        ['@vehicleprops'] = json.encode(vehicleProps)   
	}, function(rowsChanged)
	end)
end) 

ESX.RegisterServerCallback('pl_checkcars', function(source, cb, id)
    MySQL.Async.fetchAll('SELECT id, vehicleprops FROM p_garagecars WHERE garageid = @garageid', {
        ['@garageid'] = id
    }, function(result)
        cb(result)
    end)  
end)

ESX.RegisterServerCallback('pl_checkcarsid', function(source, cb, id, plate)
    MySQL.Async.fetchAll('SELECT id, vehicleprops FROM p_garagecars WHERE garageid = @garageid', {
        ['@garageid'] = id
    }, function(result)
        local vehicle = nil
        if result ~= "[]" then 
            for k, v in pairs(result) do 
                local result = json.decode(v.vehicleprops)
                if result.plate == plate then 
                    vehicle = result.plate
                end 
            end 
        end 
        cb(vehicle)
    end)  
end)



RegisterServerEvent('pl_deletegaragevehicle')
AddEventHandler('pl_deletegaragevehicle', function(id) 
    MySQL.Async.execute('DELETE FROM p_garagecars WHERE id = @id', {
        ['@id'] = id
    })
end)

RegisterServerEvent('pl_deletelocokeys')
AddEventHandler('pl_deletelocokeys', function(id, steam, k) 
    local xTarget = getLicense(steam)
    if xTarget ~= nil then 
        TriggerClientEvent("pl_deletelocokeyscl", xTarget.source, k)
    end
    TriggerClientEvent('esx:showNotification', source, "~r~Vous venez de retirer une paire de clé.")
    TriggerClientEvent('esx:showNotification', xTarget.source, "~r~Vous avez plus de paire de clé.")
    MySQL.Async.execute('DELETE FROM p_garagekeys WHERE id = @id', {
        ['@id'] = id
    })
end)



RegisterServerEvent('pl_checklocation')
AddEventHandler('pl_checklocation', function()
    local identifier = getLicense(source)
    local _source = source
    Citizen.CreateThread( function()
        while true do
            MySQL.Async.fetchAll('SELECT locationdate, id, owner FROM p_garage', {}, function(result)
                for k, v in pairs(result) do
                    if v.owner ~= nil then 
                        local owner = json.decode(v.owner)
                        if owner.steam == identifier and v.locationdate ~= nil then 
                            if os.date("%x") == v.locationdate then 
                                TriggerClientEvent("pl_removegarage", _source, v.id)
                                removegarage(v.id)
                            end 
                        end
                    end
                end
            end)
            Wait(10000)
        end 
    end)

end)

function removegarage(result)
    TriggerEvent("pl_updatetable", result, "owner", DEFAULT)
    TriggerEvent("pl_updatetable", result, "locationdate", DEFAULT)
end