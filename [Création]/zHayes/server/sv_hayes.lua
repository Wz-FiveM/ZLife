ESX = nil
TriggerEvent('esx:getSharedObject', function(a)
    ESX = a 
end)

RegisterServerEvent('zHayes:BuyLsCustoms')
AddEventHandler('zHayes:BuyLsCustoms', function(price)
	local _source = source
	local xPlayer = ESX.GetPlayerFromId(_source)
	price = tonumber(price)
	local societyAccount = nil
	TriggerEvent('esx_addonaccount:getSharedAccount', 'society_lscustoms', function(account)
		societyAccount = account
	end)
	
	if price < societyAccount.money then
		TriggerClientEvent('zHayes:InstallLsCustoms', _source)
		societyAccount.removeMoney(price)
	else
		TriggerClientEvent('zHayes:CancelLsCustoms', _source)
		TriggerClientEvent('esx:showNotification', _source, "~r~La commande a été refusé car l'entreprise n'a plus assez de fonds nécessaires.")
	end
end)

for k,v in pairs(LsCustoms.Items) do 
	ESX.RegisterUsableItem(v.name, function(source)
		TriggerClientEvent(v.trigger, source)
	end)
end

RegisterServerEvent("zHayes:StartParticles")
AddEventHandler("zHayes:StartParticles", function(pos, particles, size)
	TriggerClientEvent("zHayes:StartParticles", -1, pos, particles, size)
end)