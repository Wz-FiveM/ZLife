ESX = nil
TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)


local reportTable = {}
ESX.RegisterServerCallback('report:getUsergroup', function(source, cb)
	local xPlayer = ESX.GetPlayerFromId(source)
	local group = xPlayer.getGroup()
	cb(group)
end)

RegisterCommand('report', function(source, args, rawCommand)
	local xPlayer = ESX.GetPlayerFromId(source)
    local NomDuMec = xPlayer.getName()
    local idDuMec = source
    local RaisonDuMec = table.concat(args, " ")
    if #RaisonDuMec <= 1 then
        TriggerClientEvent("esx:showNotification", source, "~r~Veuillez rentrer une raison valable")
    elseif #RaisonDuMec >= 200 then
        TriggerClientEvent("esx:showNotification", source, "~r~Veuillez rentrer une raison moins longue")
    else
        TriggerClientEvent("esx:showNotification", source, "~g~Votre report a bien était envoyer")
        TriggerClientEvent("report:Open/CloseReport", -1, 1)
        table.insert(reportTable, {
            id = idDuMec,
            nom = NomDuMec,
            args = RaisonDuMec,
        })
    end
end, false)

RegisterServerEvent("report:CloseReport")
AddEventHandler("report:CloseReport", function(nomMec, raisonMec)
    TriggerClientEvent("report:Open/CloseReport", -1, 2, nomMec, raisonMec)
    table.remove(reportTable, id, nom, args)
end)

ESX.RegisterServerCallback('report:infoReport', function(source, cb)
    cb(reportTable)
end)

RegisterServerEvent("report:bring")
AddEventHandler("report:bring",function(IdDuMec, plyPedCoords, lequel)
    local xPlayer = ESX.GetPlayerFromId(source)
    if xPlayer.getGroup() == "mod" or xPlayer.getGroup() == "admin" or xPlayer.getGroup() == "superadmin" then
        if lequel == "bring" then
            TriggerClientEvent("report:bring", IdDuMec, plyPedCoords)
        else
            TriggerClientEvent("report:bring", plyPedCoords, IdDuMec)
        end
    else
        print('Tu peux pas !')
    end
end)

RegisterServerEvent("report:message")
AddEventHandler("report:message", function(onlyjoueurs, message)
    TriggerClientEvent("report:Notification", onlyjoueurs, message)
end)