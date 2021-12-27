Clothes = Clothes or {}
Clothes.Data = {}

ESX = nil
TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

RegisterServerEvent("cClothes:saveClothes")
AddEventHandler("cClothes:saveClothes", function(type, id, color, label, target)
    local xPlayer = ESX.GetPlayerFromId(target and target or source)
    local identifier = xPlayer.identifier

    if Clothes.Data[identifier] then 
        table.insert(Clothes.Data[identifier], {label = label, id = id, color = color, type = type})
    else
        MySQL.Async.fetchAll('SELECT clothes FROM users WHERE identifier = @identifier', {
            ['@identifier'] = xPlayer.identifier
        }, function(result)
            Clothes.Data[xPlayer.identifier] = json.decode(result[1].clothes) or {}
        end)
        TriggerClientEvent("esx:showNotification", source, "~r~Veuillez tentez une seconde fois.")
    end
end)

RegisterServerEvent("cClothes:deleteClothes")
AddEventHandler("cClothes:deleteClothes", function(id, base, target)
    local xPlayer = ESX.GetPlayerFromId(target and target or source)
    local identifier = xPlayer.identifier

    if Clothes.Data[identifier] then 
        table.remove(Clothes.Data[identifier], id)
        TriggerClientEvent("esx:showNotification", source, "Vous avez ~r~supprimé~s~ votre ~b~"..base.."~s~.")
    else
        MySQL.Async.fetchAll('SELECT clothes FROM users WHERE identifier = @identifier', {
            ['@identifier'] = xPlayer.identifier
        }, function(result)
            Clothes.Data[xPlayer.identifier] = json.decode(result[1].clothes) or {}
        end)
        TriggerClientEvent("esx:showNotification", source, "~r~Veuillez tentez une seconde fois.")
    end
end)

RegisterServerEvent("cClothes:renameClothes")
AddEventHandler("cClothes:renameClothes", function(id, base, msg)
    local xPlayer = ESX.GetPlayerFromId(source)
    local identifier = xPlayer.identifier

    if Clothes.Data[identifier] then 
        for k,v in pairs(Clothes.Data[identifier]) do 
            if k == id then 
                v.label = msg
                TriggerClientEvent("esx:showNotification", source, "Vous avez renommez votre ~b~"..base.."~s~ en: ~b~"..msg.."~s~.")
            end 
        end
    else
        MySQL.Async.fetchAll('SELECT clothes FROM users WHERE identifier = @identifier', {
            ['@identifier'] = xPlayer.identifier
        }, function(result)
            Clothes.Data[xPlayer.identifier] = json.decode(result[1].clothes) or {}
        end)
        TriggerClientEvent("esx:showNotification", source, "~r~Veuillez tentez une seconde fois.")
    end
end)

RegisterServerEvent("cClothes:giveClothes")
AddEventHandler("cClothes:giveClothes", function(type, id, color, name, target, k)
    local xPlayer = ESX.GetPlayerFromId(source)
    local xTarget = ESX.GetPlayerFromId(target)

    if xTarget then 
        if Clothes.Data[xPlayer.identifier] then 
            table.remove(Clothes.Data[xPlayer.identifier], k)
            TriggerClientEvent("esx:showNotification", source, "Vous avez donné votre ~b~"..name.."~s~ à ~b~quelqu'un~s~.")
            if Clothes.Data[xTarget.identifier] then 
                table.insert(Clothes.Data[xTarget.identifier], {label = name, id = id, color = color, type = type})
                TriggerClientEvent("esx:showNotification", target, "Vous avez reçu: ~b~"..name.."~s~ de ~b~quelqu'un~s~.")
            else
                Clothes.Data[xTarget.identifier] = {}
                Wait(50)
                table.insert(Clothes.Data[xTarget.identifier], {label = name, id = id, color = color, type = type})
                TriggerClientEvent("esx:showNotification", target, "Vous avez reçu: ~b~"..name.."~s~ de ~b~quelqu'un~s~.")
            end
        else
            MySQL.Async.fetchAll('SELECT clothes FROM users WHERE identifier = @identifier', {
                ['@identifier'] = xPlayer.identifier
            }, function(result)
                Clothes.Data[xPlayer.identifier] = json.decode(result[1].clothes) or {}
            end)
            TriggerClientEvent("esx:showNotification", source, "~r~Veuillez tentez une seconde fois.")
        end
    else
        TriggerClientEvent("esx:showNotification", source, "~r~Le joueur n'est pas trouvable.")
    end
end)

ESX.RegisterServerCallback("cClothes:getPlayerClothes", function(source, cb)
    local xPlayer = ESX.GetPlayerFromId(source)
    local targetClothes = nil
    local identifier = xPlayer.identifier

    if Clothes.Data[identifier] then 
        cb(Clothes.Data[identifier])
    else 
        MySQL.Async.fetchAll('SELECT clothes FROM users WHERE identifier = @identifier', {
            ['@identifier'] = identifier
        }, function(result)
            Clothes.Data[identifier] = json.decode(result[1].clothes) or {}
            targetClothes = json.decode(result[1].clothes)
        end)
        Wait(150)
        if xPlayer ~= nil then 
            cb(targetClothes)
        else
            cb(nil)
        end
    end
end)

ESX.RegisterServerCallback("cClothes:PayMoney", function(source, cb, money)
	local xPlayer = ESX.GetPlayerFromId(source)

	if xPlayer.getMoney() >= money then
		cb(true)
		xPlayer.removeMoney(money)
	else
		cb(false)
	end
end)

Citizen.CreateThread(function()
    Wait(20000)
    while true do 

        local xPlayers   = ESX.GetPlayers()

        for i=1, #xPlayers, 1 do
            local xPlayer = ESX.GetPlayerFromId(xPlayers[i])

            if Clothes.Data[xPlayer.identifier] then 
                MySQL.Async.execute('UPDATE `users` SET `clothes` = @clothes WHERE `identifier` = @identifier', {
                    ['@identifier'] = xPlayer.identifier,
                    ['@clothes'] = json.encode(Clothes.Data[xPlayer.identifier])
                }, function(rowsChanged)
                end)
            end
        end

        print("[SAVE PLAYER CLOTHES]")
        Wait(3 * 60 * 1000)
    end
end)

AddEventHandler('playerDropped', function()
    local playerId = source
    local xPlayer = ESX.GetPlayerFromId(playerId)

    if xPlayer then
        local identifier = xPlayer.identifier
        if Clothes.Data[identifier] then 
            MySQL.Async.execute('UPDATE `users` SET `clothes` = @clothes WHERE `identifier` = @identifier', {
                ['@identifier'] = identifier,
                ['@clothes'] = json.encode(Clothes.Data[identifier])
            }, function(rowsChanged)
                Clothes.Data[identifier] = nil
            end)
        end
    end
end)