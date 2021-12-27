ESX = nil

TriggerEvent('esx:getSharedObject', function(obj)
    ESX = obj
end)




RegisterServerEvent('wCore:FarmItem')
AddEventHandler("wCore:FarmItem", function(itemRequired, itemwin, countwin, countrequired, sell, money)
    local xPlayer = ESX.GetPlayerFromId(source)
    local Required = itemRequired and xPlayer.getInventoryItem(itemRequired) or nil

    if xPlayer then 

        if sell and money and itemRequired and Required then 
            if Required.count > 0 then 
                xPlayer.addMoney(money)
                local label = itemRequired or "Nil"
                xPlayer.removeInventoryItem(itemRequired, countrequired)
                TriggerClientEvent('esx:showNotification', source, "Vous avez vendu ~b~x"..countrequired.." "..label.." ~s~à ~g~"..money.."$~s~.", 1500)
            else
                local label = itemRequired or "Nil"
                TriggerClientEvent("rCore:CanFarm", source, false)
                TriggerClientEvent("esx:showNotification", source, "~r~Vous n'avez plus assez de ~b~"..label.."~r~ à vendre.")
            end

        elseif itemRequired and Required then 
            if Required.count > 0 then 
                xPlayer.removeInventoryItem(itemRequired, countrequired)
                xPlayer.addInventoryItem(itemwin, countwin)
            else
                local label = itemRequired or "Nil"
                TriggerClientEvent("rCore:CanFarm", source, false)
                TriggerClientEvent("esx:showNotification", source, "~r~Vous n'avez plus assez de ~b~"..label.."~r~.")
            end

        elseif not itemRequired then 
            xPlayer.addInventoryItem(itemwin, countwin)
        end
    end
end)


