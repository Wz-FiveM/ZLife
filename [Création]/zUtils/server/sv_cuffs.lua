ESX = nil
local cuffed = {}
local ciseaut = {}
local sacheaded = {}

TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

ESX.RegisterUsableItem("cuffs", function(source)
    TriggerClientEvent("fn_cuff_item:checkCuff", source)
end)

ESX.RegisterUsableItem("cuff_keys", function(source)
    TriggerClientEvent("fn_cuff_item:uncuff", source)
end)

RegisterServerEvent("fn_cuff_item:uncuff")
AddEventHandler("fn_cuff_item:uncuff",function(player)
    local _source = source
    local xPlayer = ESX.GetPlayerFromId(_source)
    xPlayer.addInventoryItem("cuffs",1)
    cuffed[player]=false
    TriggerClientEvent('fn_cuff_item:forceUncuff', player)
end)

RegisterServerEvent("fn_cuff_item:handcuff")
AddEventHandler("fn_cuff_item:handcuff",function(player,state)
    local _source = source
    local xPlayer = ESX.GetPlayerFromId(_source)
    cuffed[player]=state
    TriggerClientEvent('fn_cuff_item:handcuff', player)
    if state then 
        xPlayer.removeInventoryItem("cuffs",1) 
    else 
        xPlayer.addInventoryItem("cuffs",1) 
    end
end)

ESX.RegisterServerCallback("fn_cuff_item:isCuffed",function(source,cb,target)
    cb(cuffed[target]~=nil and cuffed[target])
end)



ESX.RegisterUsableItem("sactete", function(source)
    TriggerClientEvent("fn_sachead_item:checksachead", source)
end)

RegisterServerEvent("fn_sachead_item:unsachead")
AddEventHandler("fn_sachead_item:unsachead",function(player)
    local _source = source
    local xPlayer = ESX.GetPlayerFromId(_source)
    sacheaded[player]=false
    TriggerClientEvent('fn_sachead_item:forceUnsachead', player)
end)

RegisterServerEvent("fn_sachead_item:handsachead")
AddEventHandler("fn_sachead_item:handsachead",function(player,state)
    local _source = source
    local xPlayer = ESX.GetPlayerFromId(_source)
    sacheaded[player]=state
    TriggerClientEvent('fn_sachead_item:handsachead', player)
end)

ESX.RegisterServerCallback("fn_sachead_item:issacheaded",function(source,cb,target)
    cb(sacheaded[target]~=nil and sacheaded[target])
end)



ESX.RegisterUsableItem("ciseau", function(source)
    local _source = source
    local xPlayer = ESX.GetPlayerFromId(_source)
    TriggerClientEvent("fn_ciseau_item:checkCiseau", source)
end)

RegisterServerEvent("fn_ciseau_item:unCiseau")
AddEventHandler("fn_ciseau_item:unCiseau",function(player)
    local _source = source
    local xPlayer = ESX.GetPlayerFromId(_source)
    xPlayer.addInventoryItem("cuffs",1)
    ciseaut[player]=false
    TriggerClientEvent('fn_ciseau_item:forceUncuff', player)
end)

RegisterServerEvent("clp_removeciseau")
AddEventHandler("clp_removeciseau",function(player)
    local _source = source
    local xPlayer = ESX.GetPlayerFromId(_source)
    xPlayer.removeInventoryItem('ciseau', 0)
end)


RegisterServerEvent("fn_ciseau_item:handCiseau")
AddEventHandler("fn_ciseau_item:handCiseau",function(player,state)
    local _source = source
    local xPlayer = ESX.GetPlayerFromId(_source)
    ciseaut[player]=state
    TriggerClientEvent('fn_ciseau_item:handCiseau', player)
    xPlayer.removeInventoryItem("ciseau",1) 
end)

ESX.RegisterServerCallback("fn_ciseau_item:isCiseau",function(source,cb,target)
    cb(ciseaut[target]~=nil and ciseaut[target])
end)