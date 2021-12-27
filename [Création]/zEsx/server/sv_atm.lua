-- ONLY IF YOU USE ESX
ESX = nil
TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

RegisterServerEvent("atm:handlingMoney") 
AddEventHandler("atm:handlingMoney", function(action, amount)

    -- HERE YOU HAVE TO PUT YOUR FUNCTION TO REMOVE/ADD/GET MONEY OF THE PLAYER
    -- YOU HAVE TO CHANGE ALL THE LINE BELLOW COMMENTS

    local _source = source
    local xPlayer = ESX.GetPlayerFromId(source)
    -- DO NOT CHANGE THIS
    if action == "withdraw" then
        local _source = source
        local xPlayer = ESX.GetPlayerFromId(source)
        if xPlayer.getBank() >= amount then
            -- CHANGE THIS 
            xPlayer.addMoney(amount)
            xPlayer.removeBank(amount)
            TriggerClientEvent("esx:showNotification", xPlayer.source, "Vous avez retiré ~g~"..amount.."$")
            -- DO NOT CHANGE THIS
            TriggerClientEvent("atm:addLog", xPlayer.source, 0, "Retrait de cash", amount)
        end
    end

    if action == "deposit" then
        local _source = source
        local xPlayer = ESX.GetPlayerFromId(source)
        if xPlayer.getMoney() >= amount then
            -- CHANGE THIS 
            xPlayer.removeMoney(amount)
            xPlayer.addBank(amount)
            TriggerClientEvent("esx:showNotification", xPlayer.source, "Vous avez déposé ~g~"..amount.."$")
            -- DO NOT CHANGE THIS
            TriggerClientEvent("atm:addLog", xPlayer.source, 1, "Dépot de cash", amount)
        end
    end
    local playerMoney = xPlayer.getBank()
    local playerCash = xPlayer.getMoney()
    -- DO NOT CHANGE THIS
    TriggerClientEvent("atm:sendMoney", _source, playerMoney, playerCash)
end)

ESX.RegisterUsableItem('cartebleu', function(source)
    TriggerClientEvent('uteilcartebleu', source)
end)