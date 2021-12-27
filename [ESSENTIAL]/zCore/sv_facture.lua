ESX = nil

TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

RegisterServerEvent('clp_facture:PlayerEvent')
AddEventHandler("clp_facture:PlayerEvent",function(name,source,...)
    TriggerClientEvent(name,source,...)
end)

RegisterServerEvent("facture:pay")
AddEventHandler("facture:pay",function(montant, account, _facture)
	local _source = source
    local xPlayer = ESX.GetPlayerFromId(_source)
    local getargentpropre = xPlayer.getMoney()
    
    if getargentpropre >= montant then
        local societyAccount = nil
        TriggerEvent('esx_addonaccount:getSharedAccount', account, function(account)
            societyAccount = account
        end)
        societyAccount.addMoney(montant)
        xPlayer.removeMoney(montant)
        TriggerClientEvent('esx:showNotification', source, "Facture payé. (~b~"..montant.."$~s~).")
    else 
        --if xPlayer.getAccount('bank').money >= montant then
            local societyAccount = nil
            TriggerEvent('esx_addonaccount:getSharedAccount', account, function(account)
                societyAccount = account
            end)
            societyAccount.addMoney(montant)
            xPlayer.removeAccountMoney('bank', montant)
            TriggerClientEvent('esx:showNotification', source, "Facture payé. (~b~"..montant.."$~s~).")
        --else
            --TriggerClientEvent('esx:showNotification', source, "~r~Vous n'avez pas assez d'argent.")
        --end
    end
end)

RegisterServerEvent("facture:send")
AddEventHandler("facture:send",function(_facture)
    _facture.source = source
    TriggerClientEvent("facture:get",_facture.playerId,_facture)
end)