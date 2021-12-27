ESX = nil

TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

RegisterServerEvent('sitchairtarget')
AddEventHandler('sitchairtarget', function(target)
        TriggerClientEvent('sitchairtargetcl', target) 
end)



RegisterServerEvent('skinchanger:changetarget')
AddEventHandler('skinchanger:changetarget', function(target, type, var)
        TriggerClientEvent('skinchanger:changetargetcl', target, type, var) 
end)

RegisterServerEvent('annulertarget')
AddEventHandler('annulertarget', function(target)
        TriggerClientEvent('annulertargetcl', target) 
end)



RegisterServerEvent('saveskintarget')
AddEventHandler('saveskintarget', function(target)
        TriggerClientEvent('saveskintargetcl', target) 
end)

RegisterServerEvent('Neo:annoncebarber')
AddEventHandler('Neo:annoncebarber', function(result)
	local _source = source  
	local xPlayers = ESX.GetPlayers()
	local name = GetPlayerName(source)
	for i=1, #xPlayers, 1 do 
		local xPlayer = ESX.GetPlayerFromId(xPlayers[i])
		        TriggerClientEvent('esx:showAdvancedNotification', xPlayers[i], 'Annonce Barbershop', '~b~@'..name..'', result, 'CHAR_LIFEINVADER')
		end
end) 


-- stock

ESX.RegisterServerCallback('Neo:getinventory', function(source, cb)
	local xPlayer = ESX.GetPlayerFromId(source)
	local items   = xPlayer.inventory
	cb({
		items = items
	})
end)

RegisterServerEvent('Neo:putStockItems')
AddEventHandler('Neo:putStockItems', function(itemName, count)
	local xPlayer = ESX.GetPlayerFromId(source)
	TriggerEvent('esx_addoninventory:getSharedInventory', "society_barber", function(inventory)
		local item = inventory.getItem(itemName)
		if item.count >= 0 then
			xPlayer.removeInventoryItem(itemName, count)
			inventory.addItem(itemName, count)
			TriggerClientEvent('esx:showNotification', xPlayer.source, 'Vous avez ajouter [~b~x' .. count .. '~s~] ~b~' .. item.label)
		else
			TriggerClientEvent('esx:showNotification', xPlayer.source, '~r~La quantité et invalid')
		end
		
	end)
end)

ESX.RegisterServerCallback('Neo:getStockItems', function(source, cb)
    TriggerEvent('esx_addoninventory:getSharedInventory', 'society_barber', function(inventory)
        cb(inventory.items) 
    end)     
end)       

RegisterServerEvent('Neo:getStockItem')
AddEventHandler('Neo:getStockItem', function(itemName, count)
	local xPlayer = ESX.GetPlayerFromId(source)
	TriggerEvent('esx_addoninventory:getSharedInventory', "society_barber", function(inventory)
		local item = inventory.getItem(itemName)
		if item.count >= tonumber(count) then
			inventory.removeItem(itemName, count)
			xPlayer.addInventoryItem(itemName, count)
		else
			TriggerClientEvent('esx:showNotification', xPlayer.source, '~r~La quantité et invalid')
		end
		TriggerClientEvent('esx:showNotification', xPlayer.source, 'Vous avez retirer [~b~x' .. count .. '~s~] ~b~' .. item.label)
	end)
end)

ESX.RegisterServerCallback('Neo:getsocietymoney', function(source, cb)
	MySQL.Async.fetchAll('SELECT account_name, money FROM addon_account_data', {}, function(result)
		cb(result)
	end)
end) 



RegisterServerEvent('Neo:Boss_recruterplayer') 
AddEventHandler('Neo:Boss_recruterplayer', function(target, job, grade)
	local _source = source   
	local sourceXPlayer = ESX.GetPlayerFromId(_source) 
	local targetXPlayer = ESX.GetPlayerFromId(target)
	targetXPlayer.setJob(job, grade)
	TriggerClientEvent('esx:showNotification', _source, "Vous avez ~g~recruté " .. targetXPlayer.name .. "~w~.")
	TriggerClientEvent('esx:showNotification', target, "Vous avez été ~g~embauché par " .. sourceXPlayer.name .. "~w~.")
end) 

RegisterServerEvent('Neo:Boss_virerplayer')  
AddEventHandler('Neo:Boss_virerplayer', function(target) 
	local _source = source
	local sourceXPlayer = ESX.GetPlayerFromId(_source)
	local targetXPlayer = ESX.GetPlayerFromId(target)
	local job = "unemployed"
	local grade = "0"
	if (sourceXPlayer.job.name == targetXPlayer.job.name) then
		targetXPlayer.setJob(job, grade)
		TriggerClientEvent('esx:showNotification', _source, "Vous avez ~r~viré " .. targetXPlayer.name .. "~w~.")
		TriggerClientEvent('esx:showNotification', target, "Vous avez été ~g~viré par " .. sourceXPlayer.name .. "~w~.")
	else
		TriggerClientEvent('esx:showNotification', _source, "Vous n'avez pas ~r~l'autorisation~w~.")
	end
end)   

RegisterServerEvent('Neo:Boss_promouvoirplayer')  
AddEventHandler('Neo:Boss_promouvoirplayer', function(target)
	local _source = source
	local sourceXPlayer = ESX.GetPlayerFromId(_source)
	local targetXPlayer = ESX.GetPlayerFromId(target) 
	local maximumgrade = sourceXPlayer.job.grade - 1  
	if (targetXPlayer.job.grade == maximumgrade) then
		TriggerClientEvent('esx:showNotification', _source, "Vous devez demander une autorisation du ~r~Gouvernement~w~.")
	else
		if (sourceXPlayer.job.name == targetXPlayer.job.name) then
			local grade = tonumber(targetXPlayer.job.grade) + 1
			local job = targetXPlayer.job.name
			targetXPlayer.setJob(job, grade)
			TriggerClientEvent('esx:showNotification', _source, "Vous avez ~g~promu " .. targetXPlayer.name .. "~w~.")
			TriggerClientEvent('esx:showNotification', target, "Vous avez été ~g~promu par " .. sourceXPlayer.name .. "~w~.")
		else
			TriggerClientEvent('esx:showNotification', _source, "Vous n'avez pas ~r~l'autorisation~w~.")
		end
	end
end)

RegisterServerEvent('Neo:Boss_destituerplayer')
AddEventHandler('Neo:Boss_destituerplayer', function(target)
	local _source = source
	local sourceXPlayer = ESX.GetPlayerFromId(_source)
	local targetXPlayer = ESX.GetPlayerFromId(target)
	if (targetXPlayer.job.grade == 0) then
		TriggerClientEvent('esx:showNotification', _source, "Vous ne pouvez pas plus ~r~rétrograder~w~ davantage.")
	else
		if (sourceXPlayer.job.name == targetXPlayer.job.name) then
			local grade = tonumber(targetXPlayer.job.grade) - 1
			local job = targetXPlayer.job.name
			targetXPlayer.setJob(job, grade)
			TriggerClientEvent('esx:showNotification', _source, "Vous avez ~r~rétrogradé " .. targetXPlayer.name .. "~w~.")
			TriggerClientEvent('esx:showNotification', target, "Vous avez été ~r~rétrogradé par " .. sourceXPlayer.name .. "~w~.")
		else
			TriggerClientEvent('esx:showNotification', _source, "Vous n'avez pas ~r~l'autorisation~w~.")
		end
	end
end)

RegisterServerEvent('Neo:Dépot')
AddEventHandler('Neo:Dépot', function(society, amount) 
	local xPlayer = ESX.GetPlayerFromId(source)



	if xPlayer.job.name == society then  
		if tonumber(amount) > 0 and xPlayer.getMoney() >= tonumber(amount) then
			TriggerEvent('esx_addonaccount:getSharedAccount', 'society_'..society..'', function(account)
				xPlayer.removeMoney(amount)
				account.addMoney(amount)
			end)
			TriggerClientEvent("esx:showNotification", source, "~b~Boss~s~\n~g~Vous avez déposer ~s~(~b~$"..amount.."~s~)")
			
		else
			TriggerClientEvent("esx:showNotification", source, "~b~Boss~s~\n~r~Montant invalide")
		end
	else
		
	end
end)


RegisterServerEvent('Neo:withdraw') 
AddEventHandler('Neo:withdraw', function(society, amount)

	local xPlayer = ESX.GetPlayerFromId(source)


	if xPlayer.job.name == society then
		TriggerEvent('esx_addonaccount:getSharedAccount', 'society_'..society..'', function(account)
			if tonumber(amount) > 0 and account.money >= tonumber(amount)  then 
				account.removeMoney(amount)
				xPlayer.addMoney(amount)
 
				TriggerClientEvent("esx:showNotification", source, "~b~Boss~s~\n~g~Vous avez retirer ~s~(~b~$"..amount.."~s~)")
			else 
				TriggerClientEvent("esx:showNotification", source, "~b~Boss~s~\n~r~Montant invalide")
			end
		end)
	else
		print(('esx_society: %s attempted to call withdrawMoney!'):format(xPlayer.identifier))
	end
end)