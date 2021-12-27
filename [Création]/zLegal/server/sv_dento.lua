-- Dento
PlayersHarvestingDento = {}
PlayersCraftingDento = {}
PlayersCraftingDento2 = {}
PlayersSellingDento = {}
local saumon = 1
local sushi = 1
local paquetsushi = 1

if Config.MaxInService ~= -1 then
    TriggerEvent('esx_service:activateService', 'Dento', Config.MaxInService)
end

TriggerEvent('esx_phone:registerNumber', 'Dento', 'Client Dento', true, true)
TriggerEvent('esx_society:registerSociety', 'Dento', 'Dento', 'society_Dento', 'society_Dento', 'society_Dento', { type = 'private' })

local function HarvestDento(source)
    local _source = source
    SetTimeout(6500, function()
        if PlayersHarvestingDento[_source] == true then
            local xPlayer = ESX.GetPlayerFromId(_source)
            local SaumonQuantity = xPlayer.getInventoryItem('saumon')
            if SaumonQuantity.limit ~= -1 and SaumonQuantity.count >= SaumonQuantity.limit then
                TriggerClientEvent('esx:DrawMissionText', _source, '~r~Vous n\'avez plus de place dans votre inventaire.', 1250)
            else
                TriggerClientEvent('esx:DrawMissionText', _source, "Vous avez récupéré un ~g~Saumon~s~. (~b~+1~s~)", 1500)
                xPlayer.addInventoryItem('saumon', 1)
                HarvestDento(_source)
            end
        end
    end)
end
 
RegisterServerEvent('clp_Dento:startHarvestDento')
AddEventHandler('clp_Dento:startHarvestDento', function()
    local _source = source
    PlayersHarvestingDento[_source] = true
    TriggerClientEvent('esx:DrawMissionText', _source, '~g~Récupération des Saumons..', 1500)
    HarvestDento(_source)
end)

RegisterServerEvent('clp_Dento:stopHarvestDento')
AddEventHandler('clp_Dento:stopHarvestDento', function()
    local _source = source
    PlayersHarvestingDento[_source] = false
end)

RegisterServerEvent('clp_Dento:stopCraftDento')
AddEventHandler('clp_Dento:stopCraftDento', function()
    local _source = source
    PlayersCraftingDento[_source] = false
end)

local function CraftDento2(source)
    local _source = source
    SetTimeout(2500, function()
        if PlayersCraftingDento2[_source] == true then
            local xPlayer = ESX.GetPlayerFromId(_source)
            local sushiPaquetQuantity = xPlayer.getInventoryItem('saumon').count
            local sushiquantity = xPlayer.getInventoryItem('sushi')

            if sushiquantity.limit ~= -1 and sushiquantity.count >= sushiquantity.limit then
                TriggerClientEvent('esx:showNotification', source, "~r~Vous n\'avez plus de place dans votre inventaire.")
            elseif sushiPaquetQuantity <= 0 then
                TriggerClientEvent('esx:showNotification', source, "~r~Vous n\'avez plus de Saumons de saumon.")
            --[[ elseif FarmLimit >= 400 then 
                TriggerClientEvent('esx:DrawMissionText', _source, '~r~Vous avez atteint la limite de travail.', 5000) ]]
            else
                TriggerClientEvent('esx:DrawMissionText', _source, "Vous avez traité votre ~g~sushi~s~. (+~b~1~s~)", 1500)
                xPlayer.removeInventoryItem('saumon', 1)
                xPlayer.addInventoryItem('sushi', 1)
                CraftDento2(_source)
            end
        end
    end)
end

RegisterServerEvent('clp_Dento:startCraftDento2')
AddEventHandler('clp_Dento:startCraftDento2', function()
    local _source = source
    PlayersCraftingDento2[_source] = true
    TriggerClientEvent('esx:DrawMissionText', _source, '~g~Découpe en cours..', 1500)
    CraftDento2(_source)
end)

RegisterServerEvent('clp_Dento:stopCraftDento2')
AddEventHandler('clp_Dento:stopCraftDento2', function()
    local _source = source
    PlayersCraftingDento2[_source] = false
end)

local function SellDento(source, zone)
    if PlayersSellingDento[source] == true then
        local xPlayer = ESX.GetPlayerFromId(source)
        if zone == 'DentoSellFarm' then
            if xPlayer.getInventoryItem('sushi').count <= 0 then
                paquetsushi = 0
            else
                paquetsushi = 1
            end
            if paquetsushi == 0 then
                TriggerClientEvent('esx:DrawMissionText', source, '~r~Vous n\'avez pas suffisamment de sushis.', 3500)
                return
            elseif xPlayer.getInventoryItem('sushi').count <= 0 then
                TriggerClientEvent('esx:DrawMissionText', source, '~r~Vous n\'avez pas suffisamment de sushis.', 3500)
                paquetsushi = 0
                return
            else
                if (paquetsushi == 1) then
                    SetTimeout(3000, function()
                        xPlayer.removeInventoryItem('sushi', 1)

                        local money = math.random(6, 11)
                        xPlayer.addMoney(money)
                        TriggerClientEvent('esx:DrawMissionText', xPlayer.source, 'Vous avez vendu votre ~g~sushi~s~ à (~b~'..money..'$~s~)', 1500)
                        SellDento(source, zone)
                    end)
                end
            end
        end
    end
end

RegisterServerEvent('clp_Dento:startSellDento')
AddEventHandler('clp_Dento:startSellDento', function(zone)
    local _source = source
    if PlayersSellingDento[_source] == false then
        TriggerClientEvent('esx:showNotification', _source, '~r~Réessayez.')
        PlayersSellingDento[_source] = false
    else
        PlayersSellingDento[_source] = true
        TriggerClientEvent('esx:showNotification', _source, '~g~Vente en cours..')
        SellDento(_source, zone)
    end
end)

RegisterServerEvent('clp_Dento:stopSellDento')
AddEventHandler('clp_Dento:stopSellDento', function()
    local _source = source
    if PlayersSellingDento[_source] == true then
        PlayersSellingDento[_source] = false
    else
        PlayersSellingDento[_source] = true
    end

end)

RegisterServerEvent('clp_Dento:getStockItemDento')
AddEventHandler('clp_Dento:getStockItemDento', function(itemName, count)
    local _source = source
    local xPlayer = ESX.GetPlayerFromId(_source)
    TriggerEvent('esx_addoninventory:getSharedInventory', 'society_Dento', function(inventory)
        local item = inventory.getItem(itemName)
        if item.count >= count then
            inventory.removeItem(itemName, count)
            xPlayer.addInventoryItem(itemName, count)
        else
            TriggerClientEvent('esx:showNotification', xPlayer.source, '~r~Quantité invalide.')
        end
        TriggerClientEvent('esx:showNotification', xPlayer.source, 'Vous avez retiré ~g~' .. count .. '  ' .. item.label..'~s~ du coffre.')
    end)
end)



ESX.RegisterServerCallback('clp_Dento:getStockItemsDento', function(source, cb)
    TriggerEvent('esx_addoninventory:getSharedInventory', 'society_Dento', function(inventory)
        cb(inventory.items)
    end)
end)

RegisterServerEvent('clp_Dento:putStockItemsDento')
AddEventHandler('clp_Dento:putStockItemsDento', function(itemName, count)
    local _source = source
    local xPlayer = ESX.GetPlayerFromId(_source)
    TriggerEvent('esx_addoninventory:getSharedInventory', 'society_Dento', function(inventory)
        local item = inventory.getItem(itemName)
        local playerItemCount = xPlayer.getInventoryItem(itemName).count
        if item.count >= 0 and count <= playerItemCount then
            xPlayer.removeInventoryItem(itemName, count)
            inventory.addItem(itemName, count)
        else
            TriggerClientEvent('esx:showNotification', xPlayer.source, '~r~Quantité invalide.')
        end
        TriggerClientEvent('esx:showNotification', xPlayer.source, 'Vous avez ajouté ~g~' .. count .. '  ' .. item.label..'~s~ dans le coffre.')
    end)
end)
