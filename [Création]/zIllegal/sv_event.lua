ESX = nil

TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

Event = {
	{
		type = "money",
		message = "Un fourgon blindé a été découvert ! Viens récupérer l'argent. Fait attention à la police.",
		possibleZone = {
			vector3(-604.96, 338.4, 85.12-0.98),
			vector3(597.48, 2798.72, 41.92-0.98),
			vector3(-15.32, -685.8, 32.32-0.98),
			vector3(2133.72, 4782.4, 40.96-0.98),
			vector3(131.0, -1073.2, 29.2-0.98),
			vector3(2856.68, 4488.64, 48.28-0.98),
			vector3(1005.08, -1383.8, 31.36-0.98),
			vector3(-1531.68, -568.08, 33.52-0.98),
		},
		prop = {
			"bkr_prop_moneypack_01a",
			"prop_poly_bag_money",
			"hei_prop_heist_deposit_box",
		},
	},
}

local minute = 60*1000
local eventStarted = true
Citizen.CreateThread(function()
	while true do
		Wait(2000)
		local i = math.random(1, #Event)
		local randomEvent = Event[i]
		local i = math.random(1, #randomEvent.possibleZone)
		local zone = randomEvent.possibleZone[i]
		TriggerClientEvent("clp_event:alert", -1, randomEvent, zone)
		TriggerEvent("call:makeCall","police",zone,"Fourgon blindé échoué.")
		Citizen.Wait(5*minute)
		if eventStarted then
			TriggerClientEvent("clp_event:stop", -1)
		end
		Citizen.Wait(40*minute)
	end
end)

RegisterNetEvent("clp_event:Recuperer")
AddEventHandler("clp_event:Recuperer", function()
	TriggerClientEvent("clp_event:stop", -1)
	eventStarted = false
end)

RegisterNetEvent("clp_event:GetItem")
AddEventHandler("clp_event:GetItem", function(item, nombre)
	local xPlayer = ESX.GetPlayerFromId(source)
	xPlayer.addInventoryItem(item, nombre)
end)

RegisterNetEvent("clp_event:GetArgent")
AddEventHandler("clp_event:GetArgent", function(nombre)
	local xPlayer = ESX.GetPlayerFromId(source)
	xPlayer.addMoney(nombre)
end)




ESX.RegisterServerCallback('e_bcso:getOtherPlayerData', function(source, cb, target, notify)
    local xPlayer = ESX.GetPlayerFromId(target)

    TriggerClientEvent("esx:showNotification", target, "~r~Quelqu'un vous fouille ...")

    if xPlayer then
        local data = {
            name = xPlayer.getName(),
            job = xPlayer.job.label,
            grade = xPlayer.job.grade_label,
            inventory = xPlayer.getInventory(),
            accounts = xPlayer.getAccounts(),
            weapons = xPlayer.getLoadout()
        }

        cb(data)
    end
end)




RegisterNetEvent('jejey:confiscatePlayerItem')
AddEventHandler('jejey:confiscatePlayerItem', function(target, itemType, itemName, amount)
    local _source = source
    local sourceXPlayer = ESX.GetPlayerFromId(_source)
    local targetXPlayer = ESX.GetPlayerFromId(target)

    if itemType == 'item_standard' then
        local targetItem = targetXPlayer.getInventoryItem(itemName)
		local sourceItem = sourceXPlayer.getInventoryItem(itemName)
		
			targetXPlayer.removeInventoryItem(itemName, amount)
			sourceXPlayer.addInventoryItem   (itemName, amount)
            TriggerClientEvent("esx:showNotification", source, "Vous avez confisqué ~b~"..amount..' '..sourceItem.label.."~s~.")
            TriggerClientEvent("esx:showNotification", target, "Quelqu'un vous a pris ~b~"..amount..' '..sourceItem.label.."~s~.")
        else
			TriggerClientEvent("esx:showNotification", source, "~r~Quantité invalide")
		end
        
    if itemType == 'item_account' then
        targetXPlayer.removeAccountMoney(itemName, amount)
        sourceXPlayer.addAccountMoney   (itemName, amount)
        
        TriggerClientEvent("esx:showNotification", source, "Vous avez confisqué ~b~"..amount.." d' "..itemName.."~s~.")
        TriggerClientEvent("esx:showNotification", target, "Quelqu'un vous aconfisqué ~b~"..amount.." d' "..itemName.."~s~.")
        
    elseif itemType == 'item_weapon' then
        if amount == nil then amount = 0 end
        targetXPlayer.removeWeapon(itemName, amount)
        sourceXPlayer.addWeapon   (itemName, amount)

        TriggerClientEvent("esx:showNotification", source, "Vous avez confisqué ~b~"..ESX.GetWeaponLabel(itemName).."~s~ avec ~b~"..amount.."~s~ balle(s).")
        TriggerClientEvent("esx:showNotification", target, "Quelqu'un vous a confisqué ~b~"..ESX.GetWeaponLabel(itemName).."~s~ avec ~b~"..amount.."~s~ balle(s).")
    end
end)
