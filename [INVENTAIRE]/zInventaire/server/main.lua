ESX = nil

TriggerEvent("esx:getSharedObject",function(obj)
	ESX = obj
end)

ESX.RegisterServerCallback("c_inventaire:getPlayerInventory", function(source, cb, target)
	local targetXPlayer = ESX.GetPlayerFromId(target)
	if targetXPlayer ~= nil then
		cb({inventory = targetXPlayer.inventory, money = targetXPlayer.getMoney(), accounts = targetXPlayer.accounts, weapons = targetXPlayer.loadout})
	else
		cb(nil)
	end
end)



RegisterServerEvent("c_inventaire:tradePlayerItem")
AddEventHandler("c_inventaire:tradePlayerItem", function(from, target, type, itemName, itemCount)
		local _source = from

		local sourceXPlayer = ESX.GetPlayerFromId(_source)
		local targetXPlayer = ESX.GetPlayerFromId(target)

		if type == "item_weapon" then return end

		if type == "item_standard" then
            local sourceItem = sourceXPlayer.getInventoryItem(itemName)
			local targetItem = targetXPlayer.getInventoryItem(itemName)

            if itemCount > 0 and sourceItem.count >= itemCount then
				if targetItem.limit == -1 or ((targetItem.count + itemCount) <= targetItem.limit) then
                    sourceXPlayer.removeInventoryItem(itemName, itemCount)
					targetXPlayer.addInventoryItem(itemName, itemCount)
                else
					TriggerClientEvent('esx:showNotification', source, '~r~Vous ne pouvez pas conserver cet article.')
                end
            end
		elseif type == "item_money" then
			if itemCount > 0 and sourceXPlayer.getMoney() >= itemCount then
				sourceXPlayer.removeMoney(itemCount)
				targetXPlayer.addMoney(itemCount)
				TriggerClientEvent('esx:showNotification', targetXPlayer, "Quelqu'un vous as pris ~g~"..itemCount.."$~s~.")
				TriggerClientEvent('esx:showNotification', sourceXPlayer, 'Vous avez pris ~g~'..itemCount..'$~s~.')
			end
		elseif type == "item_account" then
			if itemCount > 0 and sourceXPlayer.getAccount(itemName).money >= itemCount then
				sourceXPlayer.removeAccountMoney(itemName, itemCount)
				targetXPlayer.addAccountMoney(itemName, itemCount)
				TriggerClientEvent('esx:showNotification', targetXPlayer, "Quelqu'un vous as pris ~r~"..itemCount.."$~s~.")
				TriggerClientEvent('esx:showNotification', sourceXPlayer, 'Vous avez pris ~r~'..itemCount..'$~s~.')
			end
		end
	end
)

AddEventHandler('esx:playerLoaded', function (source)
    GetLicenses(source)
end)

function GetLicenses(source)
    TriggerEvent('esx_license:getLicenses', source, function (licenses)
        TriggerClientEvent('suku:GetLicenses', source, licenses)
    end)
end


RegisterServerEvent('esx:discardInventoryItem')
AddEventHandler('esx:discardInventoryItem', function(item, count)

	local _source = source
	local xPlayer  = ESX.GetPlayerFromId(source)

  xPlayer.removeInventoryItem(item, count, true)

end)

RegisterServerEvent('esx:modelChanged')
AddEventHandler('esx:modelChanged', function(id)
	TriggerClientEvent('esx:modelChanged', id)
end)
