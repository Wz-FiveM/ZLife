ESX = nil

TriggerEvent('esx:getSharedObject', function(obj)
    ESX = obj
end)

ESX.RegisterServerCallback('clp_jobs:getPlayerInventory', function(source, cb)
    local _source = source
    local xPlayer = ESX.GetPlayerFromId(_source)
    local items = xPlayer.inventory

    cb({
        items = items
    })

end)

local FarmLimit = 0

ESX.RegisterServerCallback('clp_jobs:getPlayerInventory2', function(source, cb)
    local _source = source
    local xPlayer = ESX.GetPlayerFromId(_source)
    local blackMoney = xPlayer.getAccount('black_money').money
    local items = xPlayer.inventory

    cb({
        blackMoney = blackMoney,
        items = items
    })
end)

function AddToSoldAmount(source,amount)
	for k,v in pairs(soldAmount) do
		if v.id == source then
			v.amount = v.amount + amount
			return
		end
	end
end

function CheckSoldAmount(source)
	for k,v in pairs(soldAmount) do
		if v.id == source then
			return v.amount
			
		end
	end
	table.insert(soldAmount,{id = source, amount = 0})
	return CheckSoldAmount(source)
end

-- Bc Fuel
PlayersHarvestingbcfuel = {}
PlayersCraftingbcfuel = {}
PlayersCraftingbcfuel2 = {}
PlayersSellingbcfuel = {}
PlayersSellingbcfuel2 = {}
local raisin = 1
local jusraisin = 1
local bouteillesse = 1

if Config.MaxInService ~= -1 then
    TriggerEvent('esx_service:activateService', 'bcfuel', Config.MaxInService)
end

TriggerEvent('esx_phone:registerNumber', 'bcfuel', 'Client bcfuel', true, true)
TriggerEvent('esx_society:registerSociety', 'bcfuel', 'bcfuel', 'society_bcfuel', 'society_bcfuel', 'society_bcfuel', { type = 'private' })

RegisterServerEvent('clp_bcfuel:annoncebcfuel')
AddEventHandler('clp_bcfuel:annoncebcfuel', function(result)
    local _source = source
    local xPlayer = ESX.GetPlayerFromId(_source)
    local xPlayers = ESX.GetPlayers()
    local text = result
    if xPlayer.getMoney() >= 500 then 
        xPlayer.removeMoney(500)
        for i = 1, #xPlayers, 1 do
            local xPlayer = ESX.GetPlayerFromId(xPlayers[i])
            TriggerClientEvent('GM:ShowAboveRadarMessageIcon', xPlayers[i], "CHAR_RON",1,"Globe Oil","~o~Publicité",text, 1)
        end
    else
        TriggerClientEvent('esx:showNotification', source, "~r~Vous n'avez pas suffisamment d'argent.")
    end
end)

local function Harvestbcfuel(source)
    local _source = source
    SetTimeout(2500, function()
        if PlayersHarvestingbcfuel[_source] == true then
            local xPlayer = ESX.GetPlayerFromId(_source)
            local Petrol1Quantity = xPlayer.getInventoryItem('petrol')
            if Petrol1Quantity.limit ~= -1 and Petrol1Quantity.count >= Petrol1Quantity.limit then
                TriggerClientEvent('esx:showNotification', _source, '~r~Vous n\'avez plus de place dans votre inventaire.')
            --[[ elseif FarmLimit >= 400 then 
                TriggerClientEvent('esx:DrawMissionText', _source, '~r~Vous avez atteint la limite de travail.', 5000) ]]
            else
                TriggerClientEvent('esx:DrawMissionText', _source, "Vous avez récupéré du ~g~Pétrole~s~. (~b~+1~s~)", 1500)
                xPlayer.addInventoryItem('petrol', 1)
                --FarmLimit = FarmLimit + 1
                Harvestbcfuel(_source)
            end
        end
    end)
end

RegisterServerEvent('clp_bcfuel:startHarvestbcfuel')
AddEventHandler('clp_bcfuel:startHarvestbcfuel', function()
    local _source = source
    PlayersHarvestingbcfuel[_source] = true
    TriggerClientEvent('esx:DrawMissionText', _source, '~g~Récolte en cours..', 1500)
    Harvestbcfuel(_source)
end)

RegisterServerEvent('clp_bcfuel:stopHarvestbcfuel')
AddEventHandler('clp_bcfuel:stopHarvestbcfuel', function()
    local _source = source
    PlayersHarvestingbcfuel[_source] = false
end)

local function Craftbcfuel2(source)
    local _source = source
    SetTimeout(2500, function()
        if PlayersCraftingbcfuel2[_source] == true then
            local xPlayer = ESX.GetPlayerFromId(_source)
			local petrolQuantity = xPlayer.getInventoryItem('petrol').count
			local bouteilleessence = xPlayer.getInventoryItem('bouteilleessence')

			if bouteilleessence.limit ~= -1 and bouteilleessence.count >= bouteilleessence.limit then
				TriggerClientEvent('esx:showNotification', source, "~r~Vous n\'avez plus de place dans votre inventaire.")
			elseif petrolQuantity < 0 then
                TriggerClientEvent('esx:showNotification', source, "~r~Vous n\'avez pas suffisamment de pétrole.")
            --[[ elseif FarmLimit >= 400 then 
                TriggerClientEvent('esx:DrawMissionText', _source, '~r~Vous avez atteint la limite de travail.', 5000) ]]
            else
                TriggerClientEvent('esx:DrawMissionText', _source, "Vous avez traité votre ~g~Pétrole~s~. (+~b~1 Bouteille d'essence~s~)", 1500)
                xPlayer.removeInventoryItem('petrol', 1)
                xPlayer.addInventoryItem('bouteilleessence', 1)
                Craftbcfuel2(_source)
            end
        end
    end)
end

RegisterServerEvent('clp_bcfuel:startCraftbcfuel2')
AddEventHandler('clp_bcfuel:startCraftbcfuel2', function()
    local _source = source
    PlayersCraftingbcfuel2[_source] = true
    TriggerClientEvent('esx:DrawMissionText', _source, '~g~Traitement en cours..', 1500)
    Craftbcfuel2(_source)
end)

RegisterServerEvent('clp_bcfuel:stopCraftbcfuel2')
AddEventHandler('clp_bcfuel:stopCraftbcfuel2', function()
    local _source = source
    PlayersCraftingbcfuel2[_source] = false
end)

local function Sellbcfuel2(source, zone)
    if PlayersSellingbcfuel2[source] == true then
        local xPlayer = ESX.GetPlayerFromId(source)
        if zone == 'bcfuelSellFarm2' then
            if xPlayer.getInventoryItem('bouteilleessence').count <= 0 then
                bouteillesse = 0
            else
                bouteillesse = 1
            end
            if bouteillesse == 0 then
                TriggerClientEvent('esx:showNotification', source, '~r~Vous n\'avez pas suffisamment de bouteilles d\'essence à vendre.')
                return
            elseif xPlayer.getInventoryItem('bouteilleessence').count <= 0 then
                TriggerClientEvent('esx:showNotification', source, '~r~Vous n\'avez pas suffisamment de bouteilles d\'essence à vendre.')
                bouteillesse = 0
                return
            else
                if (bouteillesse == 1) then
                    SetTimeout(3000, function()
                        local societyAccount = nil
                        local moneysoce = math.random(13, 18)
                        TriggerEvent('esx_addonaccount:getSharedAccount', 'society_bcfuel', function(account)
                            societyAccount = account
                        end)
                        if societyAccount ~= nil then
                            societyAccount.addMoney(moneysoce)
                        end
                        local money = math.random(2, 6)
                        xPlayer.removeInventoryItem('bouteilleessence', 1)
                        xPlayer.addMoney(money)
                        TriggerClientEvent('esx:DrawMissionText', xPlayer.source, 'Vous avez vendu votre ~g~Bouteille d\'essence~s~ à (~b~'..money..'$~s~)', 1500)
                        Sellbcfuel2(source, zone)
                    end)
                end

            end
        end
    end
end

RegisterServerEvent('clp_bcfuel:startSellbcfuel2')
AddEventHandler('clp_bcfuel:startSellbcfuel2', function(zone)
    local _source = source
    if PlayersSellingbcfuel2[_source] == false then
        TriggerClientEvent('esx:showNotification', _source, '~r~Réessayez.')
        PlayersSellingbcfuel2[_source] = false
    else
        PlayersSellingbcfuel2[_source] = true
        TriggerClientEvent('esx:DrawMissionText', _source, '~g~Vente en cours..', 1500)
        Sellbcfuel2(_source, zone)
    end
end)

RegisterServerEvent('clp_bcfuel:stopSellbcfuel2')
AddEventHandler('clp_bcfuel:stopSellbcfuel2', function()
    local _source = source
    if PlayersSellingbcfuel2[_source] == true then
        PlayersSellingbcfuel2[_source] = false
    else
        PlayersSellingbcfuel2[_source] = true
    end
end)

RegisterServerEvent('clp_bcfuel:getStockItembcfuel')
AddEventHandler('clp_bcfuel:getStockItembcfuel', function(itemName, count)
    local _source = source
    local xPlayer = ESX.GetPlayerFromId(_source)
    TriggerEvent('esx_addoninventory:getSharedInventory', 'society_bcfuel', function(inventory)
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

ESX.RegisterServerCallback('clp_bcfuel:getStockItemsbcfuel', function(source, cb)
    TriggerEvent('esx_addoninventory:getSharedInventory', 'society_bcfuel', function(inventory)
        cb(inventory.items)
    end)
end)

RegisterServerEvent('clp_bcfuel:putStockItemsbcfuel')
AddEventHandler('clp_bcfuel:putStockItemsbcfuel', function(itemName, count)
    local _source = source
    local xPlayer = ESX.GetPlayerFromId(_source)
    TriggerEvent('esx_addoninventory:getSharedInventory', 'society_bcfuel', function(inventory)
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

RegisterServerEvent('clp_Jap:putStockItemsJap')
AddEventHandler('clp_Jap:putStockItemsJap', function(itemName, count)
    local _source = source
    local xPlayer = ESX.GetPlayerFromId(_source)
    TriggerEvent('esx_addoninventory:getSharedInventory', 'society_restojap', function(inventory)
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

-- Unicorn
PlayersHarvestingUnicorn = {}
PlayersHarvestingUnicorn2 = {}
PlayersCraftingUnicorn = {}
PlayersCraftingUnicorn2 = {}
PlayersCraftingUnicorn3 = {}
PlayersCraftingUnicorn4 = {}

if Config.MaxInService ~= -1 then
    TriggerEvent('esx_service:activateService', 'unicorn', Config.MaxInService)
end

TriggerEvent('esx_phone:registerNumber', 'unicorn', 'Client Unicorn', true, true)
TriggerEvent('esx_society:registerSociety', 'unicorn', 'Unicorn', 'society_unicorn', 'society_unicorn', 'society_unicorn', { type = 'private' })

RegisterServerEvent('clp_unicorn:annonceUnicorn')
AddEventHandler('clp_unicorn:annonceUnicorn', function(result)
    local _source = source
    local xPlayer = ESX.GetPlayerFromId(_source)
    local xPlayers = ESX.GetPlayers()
    local text = result
    if xPlayer.getMoney() >= 500 then 
        xPlayer.removeMoney(500)
        for i = 1, #xPlayers, 1 do
            local xPlayer = ESX.GetPlayerFromId(xPlayers[i])
            TriggerClientEvent('GM:ShowAboveRadarMessageIcon', xPlayers[i], "WEB_BAHAMAMAMASWEST",1,"Unicorn","~r~Publicité",text, 1)
        end
    else
        TriggerClientEvent('esx:showNotification', source, "~r~Vous n\'avez pas suffisamment d'argent.")
    end
end)

RegisterServerEvent('clp_Jap:annonceJap')
AddEventHandler('clp_Jap:annonceJap', function(result)
    local _source = source
    local xPlayer = ESX.GetPlayerFromId(_source)
    local xPlayers = ESX.GetPlayers()
    local text = result
    if xPlayer.getMoney() >= 500 then 
        xPlayer.removeMoney(500)
        for i = 1, #xPlayers, 1 do
            local xPlayer = ESX.GetPlayerFromId(xPlayers[i])
            TriggerClientEvent('GM:ShowAboveRadarMessageIcon', xPlayers[i], "WEB_DEBBIEBABES85",1,"Restaurant Japonais","~r~Publicité",text, 1)
        end
    else
        TriggerClientEvent('esx:showNotification', source, "~r~Vous n\'avez pas suffisamment d'argent.")
    end
end)

local function HarvestUnicorn(source)
    local _source = source
    SetTimeout(4000, function()
        if PlayersHarvestingUnicorn[_source] == true then
            local xPlayer = ESX.GetPlayerFromId(_source)
            local houblonQuantity = xPlayer.getInventoryItem('houblon')
            if houblonQuantity.limit ~= -1 and houblonQuantity.count >= houblonQuantity.limit then
                TriggerClientEvent('esx:showNotification', _source, '~r~Vous n\'avez plus de place dans votre inventaire.')
            --[[ elseif FarmLimit >= 400 then 
                TriggerClientEvent('esx:DrawMissionText', _source, '~r~Vous avez atteint la limite de travail.', 5000) ]]
            else
                TriggerClientEvent('esx:DrawMissionText', _source, "Vous avez récupéré du ~g~Houblon~s~. (~b~+2~s~)", 2000)
                xPlayer.addInventoryItem('houblon', 2)
                --FarmLimit = FarmLimit + 1
                HarvestUnicorn(_source)
            end
        end
    end)
end

RegisterServerEvent('clp_unicorn:startHarvestUnicorn')
AddEventHandler('clp_unicorn:startHarvestUnicorn', function()
    local _source = source
    PlayersHarvestingUnicorn[_source] = true
    TriggerClientEvent('esx:showNotification', _source, '~g~Récolte en cours..')
    HarvestUnicorn(_source)
end)

RegisterServerEvent('clp_unicorn:stopHarvestUnicorn')
AddEventHandler('clp_unicorn:stopHarvestUnicorn', function()
    local _source = source
    PlayersHarvestingUnicorn[_source] = false
end)

local function CraftUnicorn(source)
    local _source = source
    SetTimeout(4000, function()
        if PlayersCraftingUnicorn[_source] == true then
            local xPlayer = ESX.GetPlayerFromId(_source)
            local HoublonBiereQuantity = xPlayer.getInventoryItem('houblon').count
            local MaltBiereQuantity = xPlayer.getInventoryItem('malt').count
            local LevureBiereQuantity = xPlayer.getInventoryItem('levure').count
            local WaterBiereQuantity = xPlayer.getInventoryItem('water').count
            if HoublonBiereQuantity >= 5  then
                TriggerClientEvent('esx:DrawMissionText', _source, "- 5 ~b~houblon~s~ (+ 1 ~g~bière~s~)", 2000)
				xPlayer.removeInventoryItem('houblon', 5)
				xPlayer.addInventoryItem('biere', 1)
				CraftUnicorn(_source)
            else
				TriggerClientEvent('esx:showNotification', _source, '~r~Vous n\'avez pas suffisamment de ~b~composants nécessaires~r~.')
            end
        end
    end)
end

RegisterServerEvent('clp_unicorn:startCraftUnicorn')
AddEventHandler('clp_unicorn:startCraftUnicorn', function()
    local _source = source
    PlayersCraftingUnicorn[_source] = true
    TriggerClientEvent('esx:showNotification', _source, '~g~Distillation en cours..')
    CraftUnicorn(_source)
end)

RegisterServerEvent('clp_unicorn:stopCraftUnicorn')
AddEventHandler('clp_unicorn:stopCraftUnicorn', function()
    local _source = source
    PlayersCraftingUnicorn[_source] = false
end)

local function CraftUnicorn2(source)
    local _source = source
    SetTimeout(4000, function()
        if PlayersCraftingUnicorn2[_source] == true then
            local xPlayer = ESX.GetPlayerFromId(_source)
            local JusfruitCocktailQuantity = xPlayer.getInventoryItem('houblon').count
            local BananeCocktailQuantity = xPlayer.getInventoryItem('banane').count
            local SiropCocktailQuantity = xPlayer.getInventoryItem('sirop').count
            local GlaconCocktailQuantity = xPlayer.getInventoryItem('glacon').count
            if JusfruitCocktailQuantity >= 7 then
                TriggerClientEvent('esx:DrawMissionText', _source, "- 7 ~b~houblon~s~ (+ 1 ~g~cocktail~s~)", 2000)
                xPlayer.removeInventoryItem('houblon', 7)
                xPlayer.addInventoryItem('cocktail', 1)
                CraftUnicorn2(_source)
            else
                TriggerClientEvent('esx:showNotification', _source, '~r~Vous n\'avez pas suffisamment de ~b~composants nécessaires~r~.')
            end
        end
    end)
end

RegisterServerEvent('clp_unicorn:startCraftUnicorn2')
AddEventHandler('clp_unicorn:startCraftUnicorn2', function()
    local _source = source
    PlayersCraftingUnicorn2[_source] = true
    TriggerClientEvent('esx:showNotification', _source, '~g~Distillation en cours..')
    CraftUnicorn2(_source)
end)

RegisterServerEvent('clp_unicorn:stopCraftUnicorn2')
AddEventHandler('clp_unicorn:stopCraftUnicorn2', function()
    local _source = source
    PlayersCraftingUnicorn2[_source] = false
end)

local function CraftUnicorn3(source)
    local _source = source
    SetTimeout(4000, function()
        if PlayersCraftingUnicorn3[_source] == true then
            local xPlayer = ESX.GetPlayerFromId(_source)
            local RhumMojitoQuantity = xPlayer.getInventoryItem('houblon').count
            local SucrecanneMojitoQuantity = xPlayer.getInventoryItem('sucrecanne').count
            local SiropMojitoQuantity = xPlayer.getInventoryItem('menthe').count
            local CitronMojitoQuantity = xPlayer.getInventoryItem('citron').count
            local WatergMojitoQuantity = xPlayer.getInventoryItem('waterg').count
            local GlaconMojitoQuantity = xPlayer.getInventoryItem('glacon').count
            if RhumMojitoQuantity >= 6 then
                TriggerClientEvent('esx:DrawMissionText', _source, "- 6 ~b~houblon~s~ (+ 1 ~g~mojito~s~)", 2000)
                xPlayer.removeInventoryItem('houblon', 6)
                xPlayer.addInventoryItem('mojito', 1)

                CraftUnicorn3(_source)
            else
                TriggerClientEvent('esx:showNotification', _source, '~r~Vous n\'avez pas suffisamment de ~b~composants nécessaires~r~.')
            end
        end
    end)
end

RegisterServerEvent('clp_unicorn:startCraftUnicorn3')
AddEventHandler('clp_unicorn:startCraftUnicorn3', function()
    local _source = source
    PlayersCraftingUnicorn3[_source] = true
    TriggerClientEvent('esx:showNotification', _source, '~g~Distillation en cours..')
    CraftUnicorn3(_source)
end)

RegisterServerEvent('clp_unicorn:stopCraftUnicorn3')
AddEventHandler('clp_unicorn:stopCraftUnicorn3', function()
    local _source = source
    PlayersCraftingUnicorn3[_source] = false
end)

local function CraftUnicorn4(source)
    local _source = source
    SetTimeout(4000, function()
        if PlayersCraftingUnicorn4[_source] == true then
            local xPlayer = ESX.GetPlayerFromId(_source)
            local LevureRhumQuantity = xPlayer.getInventoryItem('houblon').count
            local JuscanneRhumQuantity = xPlayer.getInventoryItem('juscanne').count
            local SiropRhumQuantity = xPlayer.getInventoryItem('sirop').count
            if LevureRhumQuantity >= 4 then
                TriggerClientEvent('esx:DrawMissionText', _source, "- 4 ~b~houblon~s~ (+ 1 ~g~rhum~s~)", 2000)
				xPlayer.removeInventoryItem('houblon', 4)
				xPlayer.addInventoryItem('rhum', 1)
				CraftUnicorn4(_source)
            else
				TriggerClientEvent('esx:showNotification', _source, '~r~Vous n\'avez pas suffisamment de ~s~composants nécessaires~r~.')
            end
        end
    end)
end

RegisterServerEvent('clp_unicorn:startCraftUnicorn4')
AddEventHandler('clp_unicorn:startCraftUnicorn4', function()
    local _source = source
    PlayersCraftingUnicorn4[_source] = true
    TriggerClientEvent('esx:showNotification', _source, '~g~Distillation en cours..')
    CraftUnicorn4(_source)
end)

RegisterServerEvent('clp_unicorn:stopCraftUnicorn4')
AddEventHandler('clp_unicorn:stopCraftUnicorn4', function()
    local _source = source
    PlayersCraftingUnicorn4[_source] = false
end)

RegisterServerEvent('clp_unicorn:getStockItemUnicorn')
AddEventHandler('clp_unicorn:getStockItemUnicorn', function(itemName, count)
    local _source = source
    local xPlayer = ESX.GetPlayerFromId(_source)
    TriggerEvent('esx_addoninventory:getSharedInventory', 'society_unicorn', function(inventory)
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

ESX.RegisterServerCallback('clp_unicorn:getStockItemsUnicorn', function(source, cb)
    TriggerEvent('esx_addoninventory:getSharedInventory', 'society_unicorn', function(inventory)
        cb(inventory.items)
    end)
end)

RegisterServerEvent('clp_unicorn:putStockItemsUnicorn')
AddEventHandler('clp_unicorn:putStockItemsUnicorn', function(itemName, count)
    local _source = source
    local xPlayer = ESX.GetPlayerFromId(_source)
    TriggerEvent('esx_addoninventory:getSharedInventory', 'society_unicorn', function(inventory)
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


-- taxi
PlayersHarvestingtaxi = {}
PlayersHarvestingtaxi2 = {}
PlayersCraftingtaxi = {}
PlayersCraftingtaxi2 = {}
PlayersCraftingtaxi3 = {}
PlayersCraftingtaxi4 = {}

if Config.MaxInService ~= -1 then
    TriggerEvent('esx_service:activateService', 'taxi', Config.MaxInService)
end

TriggerEvent('esx_phone:registerNumber', 'taxi', 'Client taxi', true, true)
TriggerEvent('esx_society:registerSociety', 'taxi', 'taxi', 'society_taxi', 'society_taxi', 'society_taxi', { type = 'private' })

RegisterServerEvent('clp_taxi:annoncetaxi')
AddEventHandler('clp_taxi:annoncetaxi', function(result)
    local _source = source
    local xPlayer = ESX.GetPlayerFromId(_source)
    local xPlayers = ESX.GetPlayers()
    local text = result
    if xPlayer.getMoney() >= 500 then 
        xPlayer.removeMoney(500)
        for i = 1, #xPlayers, 1 do
            local xPlayer = ESX.GetPlayerFromId(xPlayers[i])
            TriggerClientEvent('GM:ShowAboveRadarMessageIcon', xPlayers[i], "CHAR_TAXI",1,"Taxi","~y~Publicité",text, 1)
        end
    else
        TriggerClientEvent('esx:showNotification', source, "~r~Vous n\'avez pas suffisamment d'argent.")
    end
end)

RegisterServerEvent('clp_taxi:getStockItemtaxi')
AddEventHandler('clp_taxi:getStockItemtaxi', function(itemName, count)
    local _source = source
    local xPlayer = ESX.GetPlayerFromId(_source)
    TriggerEvent('esx_addoninventory:getSharedInventory', 'society_taxi', function(inventory)
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

ESX.RegisterServerCallback('clp_taxi:getStockItemstaxi', function(source, cb)
    TriggerEvent('esx_addoninventory:getSharedInventory', 'society_taxi', function(inventory)
        cb(inventory.items)
    end)
end)

RegisterServerEvent('clp_taxi:putStockItemstaxi')
AddEventHandler('clp_taxi:putStockItemstaxi', function(itemName, count)
    local _source = source
    local xPlayer = ESX.GetPlayerFromId(_source)
    TriggerEvent('esx_addoninventory:getSharedInventory', 'society_taxi', function(inventory)
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


-- Immo
PlayersHarvestingImmo = {}
PlayersHarvestingImmo2 = {}
PlayersCraftingImmo = {}
PlayersCraftingImmo2 = {}
PlayersCraftingImmo3 = {}
PlayersCraftingImmo4 = {}

if Config.MaxInService ~= -1 then
    TriggerEvent('esx_service:activateService', 'Immo', Config.MaxInService)
end

TriggerEvent('esx_phone:registerNumber', 'Immo', 'Client Immo', true, true)
TriggerEvent('esx_society:registerSociety', 'realestateagent', 'realestateagent', 'society_realestateagent', 'society_realestateagent', 'society_realestateagent', { type = 'private' })

RegisterServerEvent('clp_Immo:annonceImmo')
AddEventHandler('clp_Immo:annonceImmo', function(codebk, textbk)
    local _source = source
    local xPlayer = ESX.GetPlayerFromId(_source)
    local xPlayers = ESX.GetPlayers()
    for i = 1, #xPlayers, 1 do
        local xPlayer = ESX.GetPlayerFromId(xPlayers[i])
        TriggerClientEvent('GM:ShowAboveRadarMessageIcon', xPlayers[i], "CHAR_JIMMY",1,codebk,"~b~Publicité Agent Immobilier",textbk, 1)
    end
end)

RegisterServerEvent('clp_Immo:annonceAmbulance')
AddEventHandler('clp_Immo:annonceAmbulance', function(link, textbk)
    local _source = source
    local xPlayer = ESX.GetPlayerFromId(_source)
    local xPlayers = ESX.GetPlayers()
    for i = 1, #xPlayers, 1 do
        local xPlayer = ESX.GetPlayerFromId(xPlayers[i])
        TriggerClientEvent('GM:ShowAboveRadarMessageIcon', xPlayers[i], "CHAR_CALL911",1,link,"~b~Publicité EMS",textbk, 1)
    end
end)


RegisterServerEvent('clp_Immo:annoncePolice')
AddEventHandler('clp_Immo:annoncePolice', function(link, textbk)
    local _source = source
    local xPlayer = ESX.GetPlayerFromId(_source)
    local xPlayers = ESX.GetPlayers()
    for i = 1, #xPlayers, 1 do
        local xPlayer = ESX.GetPlayerFromId(xPlayers[i])
        TriggerClientEvent('GM:ShowAboveRadarMessageIcon', xPlayers[i], "CHAR_CALL911",1,link,"~b~Publicité LSPD",textbk, 1)
    end
end)

RegisterServerEvent('clp_Immo:annonceLscustoms')
AddEventHandler('clp_Immo:annonceLscustoms', function(link, textbk)
    local _source = source
    local xPlayer = ESX.GetPlayerFromId(_source)
    local xPlayers = ESX.GetPlayers()
    for i = 1, #xPlayers, 1 do
        local xPlayer = ESX.GetPlayerFromId(xPlayers[i])
        TriggerClientEvent('GM:ShowAboveRadarMessageIcon', xPlayers[i], "CHAR_CARSITE3",1,codebk,"~b~Publicité Hayes Auto",textbk, 1)
    end
end)

RegisterServerEvent('clp_Immo:getStockItemImmo')
AddEventHandler('clp_Immo:getStockItemImmo', function(itemName, count)
    local _source = source
    local xPlayer = ESX.GetPlayerFromId(_source)
    TriggerEvent('esx_addoninventory:getSharedInventory', 'society_realestateagent', function(inventory)
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

ESX.RegisterServerCallback('clp_Immo:getStockItemsImmo', function(source, cb)
    TriggerEvent('esx_addoninventory:getSharedInventory', 'society_realestateagent', function(inventory)
        cb(inventory.items)
    end)
end)

RegisterServerEvent('clp_Immo:putStockItemsImmo')
AddEventHandler('clp_Immo:putStockItemsImmo', function(itemName, count)
    local _source = source
    local xPlayer = ESX.GetPlayerFromId(_source)
    TriggerEvent('esx_addoninventory:getSharedInventory', 'society_realestateagent', function(inventory)
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

-- Carpenter
PlayersHarvestingCarpenter = {}
PlayersCraftingCarpenter = {}
PlayersCraftingCarpenter2 = {}
PlayersSellingCarpenter = {}
local bois = 1
local planche = 1
local paquetplanche = 1

if Config.MaxInService ~= -1 then
    TriggerEvent('esx_service:activateService', 'Carpenter', Config.MaxInService)
end

TriggerEvent('esx_phone:registerNumber', 'Carpenter', 'Client Carpenter', true, true)
TriggerEvent('esx_society:registerSociety', 'Carpenter', 'Carpenter', 'society_Carpenter', 'society_Carpenter', 'society_Carpenter', { type = 'private' })

local function HarvestCarpenter(source)
    local _source = source
    SetTimeout(2500, function()
        if PlayersHarvestingCarpenter[_source] == true then
            local xPlayer = ESX.GetPlayerFromId(_source)
            local RondinQuantity = xPlayer.getInventoryItem('bois')
            if RondinQuantity.limit ~= -1 and RondinQuantity.count >= RondinQuantity.limit then
                TriggerClientEvent('esx:DrawMissionText', _source, '~r~Vous n\'avez plus de place dans votre inventaire.', 1250)
            elseif FarmLimit >= 400 then 
                TriggerClientEvent('esx:DrawMissionText', _source, '~r~Vous avez atteint la limite de travail.', 5000)
            else
                TriggerClientEvent('esx:DrawMissionText', _source, "Vous avez récupéré un ~g~Rondin~s~. (~b~+1~s~)", 1500)
                xPlayer.addInventoryItem('bois', 1)
                FarmLimit = FarmLimit + 1
                HarvestCarpenter(_source)
            end
        end
    end)
end
 
RegisterServerEvent('clp_Carpenter:startHarvestCarpenter')
AddEventHandler('clp_Carpenter:startHarvestCarpenter', function()
    local _source = source
    PlayersHarvestingCarpenter[_source] = true
    TriggerClientEvent('esx:DrawMissionText', _source, '~g~Récupération des rondins..', 1500)
    HarvestCarpenter(_source)
end)

RegisterServerEvent('clp_Carpenter:stopHarvestCarpenter')
AddEventHandler('clp_Carpenter:stopHarvestCarpenter', function()
    local _source = source
    PlayersHarvestingCarpenter[_source] = false
end)

RegisterServerEvent('clp_Carpenter:stopCraftCarpenter')
AddEventHandler('clp_Carpenter:stopCraftCarpenter', function()
    local _source = source
    PlayersCraftingCarpenter[_source] = false
end)

local function CraftCarpenter2(source)
    local _source = source
    SetTimeout(2500, function()
        if PlayersCraftingCarpenter2[_source] == true then
            local xPlayer = ESX.GetPlayerFromId(_source)
            local PlanchePaquetQuantity = xPlayer.getInventoryItem('bois').count
            local planchequantity = xPlayer.getInventoryItem('planche')

            if planchequantity.limit ~= -1 and planchequantity.count >= planchequantity.limit then
                TriggerClientEvent('esx:showNotification', source, "~r~Vous n\'avez plus de place dans votre inventaire.")
            elseif PlanchePaquetQuantity <= 0 then
                TriggerClientEvent('esx:showNotification', source, "~r~Vous n\'avez plus de rondins de bois.")
            elseif FarmLimit >= 400 then 
                TriggerClientEvent('esx:DrawMissionText', _source, '~r~Vous avez atteint la limite de travail.', 5000)
            else
                TriggerClientEvent('esx:DrawMissionText', _source, "Vous avez traité votre ~g~Planche~s~. (+~b~1~s~)", 1500)
                xPlayer.removeInventoryItem('bois', 1)
                xPlayer.addInventoryItem('planche', 1)
                CraftCarpenter2(_source)
            end
        end
    end)
end

RegisterServerEvent('clp_Carpenter:startCraftCarpenter2')
AddEventHandler('clp_Carpenter:startCraftCarpenter2', function()
    local _source = source
    PlayersCraftingCarpenter2[_source] = true
    TriggerClientEvent('esx:DrawMissionText', _source, '~g~Découpe en cours..', 1500)
    CraftCarpenter2(_source)
end)

RegisterServerEvent('clp_Carpenter:stopCraftCarpenter2')
AddEventHandler('clp_Carpenter:stopCraftCarpenter2', function()
    local _source = source
    PlayersCraftingCarpenter2[_source] = false
end)

local function SellCarpenter(source, zone)
    if PlayersSellingCarpenter[source] == true then
        local xPlayer = ESX.GetPlayerFromId(source)
        if zone == 'CarpenterSellFarm' then
            if xPlayer.getInventoryItem('planche').count <= 0 then
                paquetplanche = 0
            else
                paquetplanche = 1
            end
            if paquetplanche == 0 then
                TriggerClientEvent('esx:DrawMissionText', source, '~r~Vous n\'avez pas suffisamment de planches.', 3500)
                return
            elseif xPlayer.getInventoryItem('planche').count <= 0 then
                TriggerClientEvent('esx:DrawMissionText', source, '~r~Vous n\'avez pas suffisamment de planches.', 3500)
                paquetplanche = 0
                return
            else
                if (paquetplanche == 1) then
                    SetTimeout(3000, function()
                        xPlayer.removeInventoryItem('planche', 1)

                        local money = math.random(6, 11)
                        xPlayer.addMoney(money)
                        TriggerClientEvent('esx:DrawMissionText', xPlayer.source, 'Vous avez vendu votre ~g~Planche~s~ à (~b~'..money..'$~s~)', 1500)
                        SellCarpenter(source, zone)
                    end)
                end
            end
        end
    end
end

RegisterServerEvent('clp_Carpenter:startSellCarpenter')
AddEventHandler('clp_Carpenter:startSellCarpenter', function(zone)
    local _source = source
    if PlayersSellingCarpenter[_source] == false then
        TriggerClientEvent('esx:showNotification', _source, '~r~Réessayez.')
        PlayersSellingCarpenter[_source] = false
    else
        PlayersSellingCarpenter[_source] = true
        TriggerClientEvent('esx:showNotification', _source, '~g~Vente en cours..')
        SellCarpenter(_source, zone)
    end
end)

RegisterServerEvent('clp_Carpenter:stopSellCarpenter')
AddEventHandler('clp_Carpenter:stopSellCarpenter', function()
    local _source = source
    if PlayersSellingCarpenter[_source] == true then
        PlayersSellingCarpenter[_source] = false
    else
        PlayersSellingCarpenter[_source] = true
    end

end)

RegisterServerEvent('clp_Carpenter:getStockItemCarpenter')
AddEventHandler('clp_Carpenter:getStockItemCarpenter', function(itemName, count)
    local _source = source
    local xPlayer = ESX.GetPlayerFromId(_source)
    TriggerEvent('esx_addoninventory:getSharedInventory', 'society_Carpenter', function(inventory)
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

RegisterServerEvent('clp_Jap:getStockItemsJap')
AddEventHandler('clp_Jap:getStockItemsJap', function(itemName, count)
    local _source = source
    local xPlayer = ESX.GetPlayerFromId(_source)
    TriggerEvent('esx_addoninventory:getSharedInventory', 'society_restojap', function(inventory)
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


ESX.RegisterServerCallback('clp_Jap:getStockItemsJap', function(source, cb)
    TriggerEvent('esx_addoninventory:getSharedInventory', 'society_restojap', function(inventory)
        cb(inventory.items)
    end)
end)




RegisterServerEvent('clp_Jap:putStockItems')
AddEventHandler('clp_Jap::putStockItems', function(itemName, count)
	local xPlayer = ESX.GetPlayerFromId(source)
	local sourceItem = xPlayer.getInventoryItem(itemName)

	TriggerEvent('esx_addoninventory:getSharedInventory', 'society_restojap', function(inventory)
		local inventoryItem = inventory.getItem(itemName)

		-- does the player have enough of the item?
		if sourceItem.count >= count and count > 0 then
			xPlayer.removeInventoryItem(itemName, count)
			inventory.addItem(itemName, count)
			TriggerClientEvent('esx:showNotification', xPlayer.source, 'Vous avez ajouté ~g~' .. count .. '  ' .. inventoryItem.label..'~s~ dans le coffre.')
		else
			TriggerClientEvent('esx:showNotification', xPlayer.source, _U('quantity_invalid'))
		end
	end)
end)


ESX.RegisterServerCallback('clp_Carpenter:getStockItemsCarpenter', function(source, cb)
    TriggerEvent('esx_addoninventory:getSharedInventory', 'society_Carpenter', function(inventory)
        cb(inventory.items)
    end)
end)

RegisterServerEvent('clp_Carpenter:putStockItemsCarpenter')
AddEventHandler('clp_Carpenter:putStockItemsCarpenter', function(itemName, count)
    local _source = source
    local xPlayer = ESX.GetPlayerFromId(_source)
    TriggerEvent('esx_addoninventory:getSharedInventory', 'society_Carpenter', function(inventory)
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


TriggerEvent('esx_phone:registerNumber', 'ltds', 'Client LTD', true, true)
TriggerEvent('esx_society:registerSociety', 'ltds', 'ltds', 'society_ltds', 'society_ltds', 'society_ltds', { type = 'private' })

RegisterServerEvent('clp_ltds:annonceltds')
AddEventHandler('clp_ltds:annonceltds', function(result)
    local _source = source
    local xPlayer = ESX.GetPlayerFromId(_source)
    local xPlayers = ESX.GetPlayers()
    local text = result
    for i = 1, #xPlayers, 1 do
        local xPlayer = ESX.GetPlayerFromId(xPlayers[i])
        TriggerClientEvent('GM:ShowAboveRadarMessageIcon', xPlayers[i], "DIA_TANNOY",1,"LTD","~r~Publicité",text, 1)
    end
end)

RegisterServerEvent('clp_taxi:annonceltds')
AddEventHandler('clp_taxi:annonceltds', function(result)
    local _source = source
    local xPlayer = ESX.GetPlayerFromId(_source)
    local xPlayers = ESX.GetPlayers()
    local text = result
    for i = 1, #xPlayers, 1 do
        local xPlayer = ESX.GetPlayerFromId(xPlayers[i])
        TriggerClientEvent('GM:ShowAboveRadarMessageIcon', xPlayers[i], "DIA_TANNOY",1,"TAXI","~y~Publicité",text, 1)
    end
end)

RegisterServerEvent('clp_ltds:getStockItemsltds')
AddEventHandler('clp_ltds:getStockItemsltds', function(itemName, count)
    local _source = source
    local xPlayer = ESX.GetPlayerFromId(_source)
    TriggerEvent('esx_addoninventory:getSharedInventory', 'society_ltds', function(inventory)
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

ESX.RegisterServerCallback('clp_ltds:getStockItemsltds', function(source, cb)
    TriggerEvent('esx_addoninventory:getSharedInventory', 'society_ltds', function(inventory)
        cb(inventory.items)
    end)
end)

RegisterServerEvent('clp_ltds:putStockItemsltds')
AddEventHandler('clp_ltds:putStockItemsltds', function(itemName, count)
    local _source = source
    local xPlayer = ESX.GetPlayerFromId(_source)
    TriggerEvent('esx_addoninventory:getSharedInventory', 'society_ltds', function(inventory)
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














PlayersHarvestingLtd = {}
PlayersCraftingLtd = {}
PlayersCraftingLtd2 = {}
PlayersSellingLtd = {}
local bois = 1
local planche = 1
local paquetplanche = 1

if Config.MaxInService ~= -1 then
    TriggerEvent('esx_service:activateService', 'Ltds', Config.MaxInService)
end

TriggerEvent('esx_phone:registerNumber', 'Ltds', 'Client Ltd', true, true)
TriggerEvent('esx_society:registerSociety', 'Ltds', 'Ltds', 'society_Ltds', 'society_Ltds', 'society_Ltds', { type = 'private' })




local function HarvestLtd(source)
    local _source = source
    SetTimeout(2500, function()
        if PlayersHarvestingLtd[_source] == true then
            local xPlayer = ESX.GetPlayerFromId(_source)
            local RondinQuantity = xPlayer.getInventoryItem('bread')
            local seau = xPlayer.getInventoryItem('seau')
            local test = math.random(1, 2)
            if RondinQuantity.limit ~= -1 and RondinQuantity.count >= RondinQuantity.limit then
                TriggerClientEvent('esx:DrawMissionText', _source, '~r~Vous n\'avez plus de place dans votre inventaire.', 1250)

            elseif FarmLimit >= 400 then 
                TriggerClientEvent('esx:DrawMissionText', _source, '~r~Vous avez atteint la limite de travail.', 5000)

            elseif test == 1 then
                TriggerClientEvent('esx:DrawMissionText', _source, "Vous avez récupéré un ~g~Pain~s~. (~b~+1~s~)", 1500)
                xPlayer.addInventoryItem('bread', 1)
                FarmLimit = FarmLimit + 1
                HarvestLtd(_source)
            else
                TriggerClientEvent('esx:DrawMissionText', _source, "Vous avez récupéré un ~g~Seau~s~. (~b~+1~s~)", 1500)
                xPlayer.addInventoryItem('seau', 1)
                FarmLimit = FarmLimit + 1
                HarvestLtd(_source)
            end
        end
    end)
end
 





RegisterServerEvent('clp_Ltd:startHarvestLtd')
AddEventHandler('clp_Ltd:startHarvestLtd', function()
    local _source = source
    PlayersHarvestingLtd[_source] = true
    TriggerClientEvent('esx:DrawMissionText', _source, '~g~Récupération du pain..', 1500)
    HarvestLtd(_source)
end)

RegisterServerEvent('clp_Ltd:stopHarvestLtd')
AddEventHandler('clp_Ltd:stopHarvestLtd', function()
    local _source = source
    PlayersHarvestingLtd[_source] = false
end)

RegisterServerEvent('clp_Ltd:stopCraftLtd')
AddEventHandler('clp_Ltd:stopCraftLtd', function()
    local _source = source
    PlayersCraftingLtd[_source] = false
end)

local function CraftLtd2(source)
    local _source = source
    SetTimeout(2500, function()
        if PlayersCraftingLtd2[_source] == true then
            local xPlayer = ESX.GetPlayerFromId(_source)
            local PlanchePaquetQuantity = xPlayer.getInventoryItem('bread').count
            local planchequantity = xPlayer.getInventoryItem('hamburger')
            local test = math.random(1, 2)

            if planchequantity.limit ~= -1 and planchequantity.count >= planchequantity.limit then
                TriggerClientEvent('esx:showNotification', source, "~r~Vous n\'avez plus de place dans votre inventaire.")
            elseif PlanchePaquetQuantity <= 0 then
                TriggerClientEvent('esx:showNotification', source, "~r~Vous n\'avez plus de pain.")
            elseif FarmLimit >= 400 then 
                TriggerClientEvent('esx:DrawMissionText', _source, '~r~Vous avez atteint la limite de travail.', 5000)
            else
                TriggerClientEvent('esx:DrawMissionText', _source, "Vous avez traité votre ~g~Hamburger~s~. (+~b~1~s~)", 1500)
                xPlayer.removeInventoryItem('bread', 1)
                xPlayer.addInventoryItem('hamburger', 1)
                CraftLtd2(_source)
            end
        end
    end)
end

RegisterServerEvent('clp_Ltd:startCraftLtd2')
AddEventHandler('clp_Ltd:startCraftLtd2', function()
    local _source = source
    PlayersCraftingLtd2[_source] = true
    TriggerClientEvent('esx:DrawMissionText', _source, '~g~Traitement en cours..', 1500)
    CraftLtd2(_source)
end)

RegisterServerEvent('clp_Ltd:stopCraftLtd2')
AddEventHandler('clp_Ltd:stopCraftLtd2', function()
    local _source = source
    PlayersCraftingLtd2[_source] = false
end)

local function SellLtd(source, zone)
    if PlayersSellingLtd[source] == true then
        local xPlayer = ESX.GetPlayerFromId(source)
        if zone == 'LtdSellFarm' then
            if xPlayer.getInventoryItem('hamburger').count <= 0 then
                paquetplanche = 0
            else
                paquetplanche = 1
            end
            if paquetplanche == 0 then
                TriggerClientEvent('esx:DrawMissionText', source, '~r~Vous n\'avez pas suffisamment de hamburger.', 3500)
                return
            elseif xPlayer.getInventoryItem('hamburger').count <= 0 then
                TriggerClientEvent('esx:DrawMissionText', source, '~r~Vous n\'avez pas suffisamment de hamburger.', 3500)
                paquetplanche = 0
                return
            else
                if (paquetplanche == 1) then
                    SetTimeout(3000, function()
                        xPlayer.removeInventoryItem('hamburger', 1)

                        local money = math.random(6, 11)
                        xPlayer.addMoney(money)
                        TriggerClientEvent('esx:DrawMissionText', xPlayer.source, 'Vous avez vendu votre ~g~Hamburger~s~ à (~b~'..money..'$~s~)', 1500)
                        SellLtd(source, zone)
                    end)
                end
            end
        end
    end
end

RegisterServerEvent('clp_Ltd:startSellLtd')
AddEventHandler('clp_Ltd:startSellLtd', function(zone)
    local _source = source
    if PlayersSellingLtd[_source] == false then
        TriggerClientEvent('esx:showNotification', _source, '~r~Réessayez.')
        PlayersSellingLtd[_source] = false
    else
        PlayersSellingLtd[_source] = true
        TriggerClientEvent('esx:showNotification', _source, '~g~Vente en cours..')
        SellLtd(_source, zone)
    end
end)

RegisterServerEvent('clp_Ltd:stopSellCarpenter')
AddEventHandler('clp_Ltd:stopSellCarpenter', function()
    local _source = source
    if PlayersSellingCarpenter[_source] == true then
        PlayersSellingCarpenter[_source] = false
    else
        PlayersSellingCarpenter[_source] = true
    end

end)

RegisterServerEvent('clp_Ltd:getStockItemCarpenter')
AddEventHandler('clp_Ltd:getStockItemCarpenter', function(itemName, count)
    local _source = source
    local xPlayer = ESX.GetPlayerFromId(_source)
    TriggerEvent('esx_addoninventory:getSharedInventory', 'society_Carpenter', function(inventory)
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















-- tabac


-- Carpenter
PlayersHarvestingTabac = {}
PlayersCraftingTabac = {}
PlayersCraftingTabac2 = {}
PlayersSellingTabac = {}
local feuilles = 1
local feuilletabac = 1
local paquetplanche = 1

if Config.MaxInService ~= -1 then
    TriggerEvent('esx_service:activateService', 'Tabac', Config.MaxInService)
end

TriggerEvent('esx_phone:registerNumber', 'Tabac', 'Client Tabac', true, true)
TriggerEvent('esx_society:registerSociety', 'Tabac', 'Tabac', 'society_Tabac', 'society_Tabac', 'society_Tabac', { type = 'private' })

local function HarvestTabac(source)
    local _source = source
    SetTimeout(2500, function()
        if PlayersHarvestingTabac[_source] == true then
            local xPlayer = ESX.GetPlayerFromId(_source)
            local RondinQuantity = xPlayer.getInventoryItem('feuilles')
            if RondinQuantity.limit ~= -1 and RondinQuantity.count >= RondinQuantity.limit then
                TriggerClientEvent('esx:DrawMissionText', _source, '~r~Vous n\'avez plus de place dans votre inventaire.', 1250)
            --[[ elseif FarmLimit >= 400 then 
                TriggerClientEvent('esx:DrawMissionText', _source, '~r~Vous avez atteint la limite de travail.', 5000) ]]
            else
                TriggerClientEvent('esx:DrawMissionText', _source, "Vous avez récupéré une ~g~Feuille~s~. (~b~+1~s~)", 1500)
                xPlayer.addInventoryItem('feuilles', 1)
                --FarmLimit = FarmLimit + 1
                HarvestTabac(_source)
            end
        end
    end)
end
 
RegisterServerEvent('clp_Tabac:startHarvestTabac')
AddEventHandler('clp_Tabac:startHarvestTabac', function()
    local _source = source
    PlayersHarvestingTabac[_source] = true
    TriggerClientEvent('esx:DrawMissionText', _source, '~g~Récupération des feuilles pur..', 1500)
    HarvestTabac(_source)
end)

RegisterServerEvent('clp_Tabac:stopHarvestTabac')
AddEventHandler('clp_Tabac:stopHarvestTabac', function()
    local _source = source
    PlayersHarvestingTabac[_source] = false
end)

RegisterServerEvent('clp_Tabac:stopCraftTabac')
AddEventHandler('clp_Tabac:stopCraftTabac', function()
    local _source = source
    PlayersCraftingTabac[_source] = false
end)

local function CraftTabac2(source)
    local _source = source
    SetTimeout(2500, function()
        if PlayersCraftingTabac2[_source] == true then
            local xPlayer = ESX.GetPlayerFromId(_source)
            local PlanchePaquetQuantity = xPlayer.getInventoryItem('feuilles').count
            local planchequantity = xPlayer.getInventoryItem('feuilletabac')

            if planchequantity.limit ~= -1 and planchequantity.count >= planchequantity.limit then
                TriggerClientEvent('esx:showNotification', source, "~r~Vous n\'avez plus de place dans votre inventaire.")
            elseif PlanchePaquetQuantity <= 0 then
                TriggerClientEvent('esx:showNotification', source, "~r~Vous n\'avez plus de feuilles.")
            --[[ elseif FarmLimit >= 400 then 
                TriggerClientEvent('esx:DrawMissionText', _source, '~r~Vous avez atteint la limite de travail.', 5000) ]]
            else
                TriggerClientEvent('esx:DrawMissionText', _source, "Vous avez traité votre ~g~Feuilles~s~. (+~b~1~s~)", 1500)
                xPlayer.removeInventoryItem('feuilles', 1)
                xPlayer.addInventoryItem('feuilletabac', 1)
                CraftTabac2(_source)
            end
        end
    end)
end

RegisterServerEvent('clp_Tabac:startCraftTabac2')
AddEventHandler('clp_Tabac:startCraftTabac2', function()
    local _source = source
    PlayersCraftingTabac2[_source] = true
    TriggerClientEvent('esx:DrawMissionText', _source, '~g~Découpe en cours..', 1500)
    CraftTabac2(_source)
end)

RegisterServerEvent('clp_Tabac:stopCraftTabac2')
AddEventHandler('clp_Tabac:stopCraftTabac2', function()
    local _source = source
    PlayersCraftingTabac2[_source] = false
end)

local function SellTabac(source, zone)
    if PlayersSellingTabac[source] == true then
        local xPlayer = ESX.GetPlayerFromId(source)
        if zone == 'TabacSellFarm' then
            if xPlayer.getInventoryItem('feuilletabac').count <= 0 then
                paquetplanche = 0
            else
                paquetplanche = 1
            end
            if paquetplanche == 0 then
                TriggerClientEvent('esx:DrawMissionText', source, '~r~Vous n\'avez pas suffisamment de Feuille de tabac.', 3500)
                return
            elseif xPlayer.getInventoryItem('feuilletabac').count <= 0 then
                TriggerClientEvent('esx:DrawMissionText', source, '~r~Vous n\'avez pas suffisamment de Feuille de tabac.', 3500)
                paquetplanche = 0
                return
            else
                if (paquetplanche == 1) then
                    SetTimeout(3000, function()
                        xPlayer.removeInventoryItem('feuilletabac', 1)

                        local money = math.random(6, 11)
                        xPlayer.addMoney(money)
                        TriggerClientEvent('esx:DrawMissionText', xPlayer.source, 'Vous avez vendu votre ~g~Feuille de tabac~s~ à (~b~'..money..'$~s~)', 1500)
                        SellTabac(source, zone)
                    end)
                end
            end
        end
    end
end

RegisterServerEvent('clp_Tabac:startSellTabac')
AddEventHandler('clp_Tabac:startSellTabac', function(zone)
    local _source = source
    if PlayersSellingTabac[_source] == false then
        TriggerClientEvent('esx:showNotification', _source, '~r~Réessayez.')
        PlayersSellingTabac[_source] = false
    else
        PlayersSellingTabac[_source] = true
        TriggerClientEvent('esx:showNotification', _source, '~g~Vente en cours..')
        SellTabac(_source, zone)
    end
end)

RegisterServerEvent('clp_Tabac:stopSellTabac')
AddEventHandler('clp_Tabac:stopSellTabac', function()
    local _source = source
    if PlayersSellingTabac[_source] == true then
        PlayersSellingTabac[_source] = false
    else
        PlayersSellingTabac[_source] = true
    end

end)

RegisterServerEvent('clp_Tabac:getStockItemTabac')
AddEventHandler('clp_Tabac:getStockItemTabac', function(itemName, count)
    local _source = source
    local xPlayer = ESX.GetPlayerFromId(_source)
    TriggerEvent('esx_addoninventory:getSharedInventory', 'society_Tabac', function(inventory)
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