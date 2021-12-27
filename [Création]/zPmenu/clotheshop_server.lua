ESX = nil
TriggerEvent('esx:getSharedObject', function(obj)
    ESX = obj
end)

-- start iCore code
-- return tenue table
ESX.RegisterServerCallback('iCore:getPlayerTenues', function(source, cb, _)
    local _source, xPlayer = source, ESX.GetPlayerFromId(source)

    MySQL.Async.fetchAll( 'SELECT * FROM user_clothes WHERE identifier = @identifier', {
        ['@identifier'] = xPlayer.identifier
    }, function(result)
        cb(result)
    end)
end)

ESX.RegisterServerCallback('iCore:getTenueLabel', function(source, cb, name)
    local xPlayer = ESX.GetPlayerFromId(source)

    MySQL.Async.fetchAll( 'SELECT tenue FROM user_clothes WHERE identifier = @identifier AND label = @label', {
        ['@identifier'] = xPlayer.identifier,
        ['@label'] = name
    }, function(result)
        cb(result)
    end)
end)

-- delete tenue in db
RegisterServerEvent("iCore:deleteTenue")
AddEventHandler("iCore:deleteTenue", function(name)
    local xPlayer = ESX.GetPlayerFromId(source)
    MySQL.Async.execute(
        'DELETE FROM user_clothes WHERE identifier = @identifier AND label = @label', {
            ['@identifier'] = xPlayer.identifier,
            ['@label'] = name
        }
    )
end)

-- check if name is taken
ESX.RegisterServerCallback('iCore:isTenueLabelTaken', function (source, cb, name)
    local xPlayer = ESX.GetPlayerFromId(source)

	MySQL.Async.fetchAll('SELECT label FROM user_clothes WHERE label = @label AND identifier = @identifier', {
        ['@label'] = name,
        ['@identifier'] = xPlayer.identifier
    }, function (result)
        cb(result[1] ~= nil)
	end)
end)

ESX.RegisterServerCallback("iCore:getPlyClothes", function(source, cb)
    local xPlayer = ESX.GetPlayerFromId(source)

    MySQL.Async.fetchAll(
        'SELECT * FROM iwaclothes WHERE identifier = @identifier', {
            ['@identifier'] = xPlayer.identifier
        },
    function(result)
        cb(result)
    end)
end)

RegisterServerEvent("iCore:renameVet")
AddEventHandler("iCore:renameVet", function(id, newName)
    local xPlayer = ESX.GetPlayerFromId(source)

    if newName ~= nil and newName ~= 0 then 
        MySQL.Async.execute(
            'UPDATE iwaclothes SET label = @label WHERE id = @id', {
                ['@label'] = newName,
                ['@id'] = id
            }
        )
    end
end)

RegisterServerEvent("iCore:deleteVet")
AddEventHandler("iCore:deleteVet", function(tenueId)
    MySQL.Async.execute(
        'DELETE FROM iwaclothes WHERE id = @id', {
            ['@id'] = tenueId
        }
    )
end)

RegisterServerEvent("iCore:giveVet")
AddEventHandler("iCore:giveVet", function(target, tenueId)
    local xPlayer = ESX.GetPlayerFromId(source)
    local xTarget = ESX.GetPlayerFromId(target)

    MySQL.Async.execute(
        'UPDATE iwaclothes SET identifier = @identifier WHERE id = @id', {
            ['@identifier'] = xTarget.getIdentifier(),
            ['@id'] = tenueId
        }
    )

    xTarget.triggerEvent("esx:showNotification", "Vous avez reçu un ~b~vêtement")
end)