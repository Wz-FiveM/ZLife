local MissionStatus = {}
local ESX = nil

TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

RegisterNetEvent("clp_mission:SetStatus")
AddEventHandler("clp_mission:SetStatus", function(id)
    local steam = GetPlayerIdentifier(source, 1)
    local data = {}
    local exist = false
    for k,v in pairs(MissionStatus) do
        if v.id == steam then
            data = v
            exist = true
            table.remove(MissionStatus, k)
        end
    end
    if not exist then
        data = {
            id = steam,
            mission = {},
        }
    end
    table.insert(data.mission, id)
    table.insert(MissionStatus, data)
    TriggerClientEvent("clp_mission:status", source, data.mission)
end)

RegisterNetEvent("clp_mission:GetConfig")
AddEventHandler("clp_mission:GetConfig", function()
    TriggerClientEvent("clp_mission:GetConfig", source, peds, mission)
end)
RegisterNetEvent("clp_mission:status")
AddEventHandler("clp_mission:status", function()
    local steam = GetPlayerIdentifier(source, 1)
    local data = {}
    local exist = false
    for k,v in pairs(MissionStatus) do
        if v.id == steam then
            data = v
            exist = true
        end
    end
    if not exist then
        data = {
            id = steam,
            mission = {},
        }
    end
    TriggerClientEvent("clp_mission:status", source, data.mission)
end)

RegisterNetEvent("clp_mission:GetPay")
AddEventHandler("clp_mission:GetPay", function(amount)
    local xPlayer = ESX.GetPlayerFromId(source) 
    xPlayer.addMoney(amount)
end)

RegisterNetEvent("clp_mission:givemoney")
AddEventHandler("clp_mission:givemoney", function(amount)
    local xPlayer = ESX.GetPlayerFromId(source) 
    xPlayer.addAccountMoney('black_money', amount)
end)

RegisterNetEvent("clp_mission:givemoneysociety")
AddEventHandler("clp_mission:givemoneysociety", function(amount, society)
    local xPlayer = ESX.GetPlayerFromId(source) 
    local societyAccount = nil
    TriggerEvent('esx_addonaccount:getSharedAccount', society, function(account)
        societyAccount = account
    end)
    societyAccount.addMoney(amount)
end)

RegisterNetEvent("clp_mission:giveitemmission")
AddEventHandler("clp_mission:giveitemmission", function()
    local _source = source
    local xPlayer = ESX.GetPlayerFromId(_source) 
    local chance = math.random(0, 99);
    if chance >= 0 and chance <= 33 then
        xPlayer.addInventoryItem("coke", 15)
    elseif chance >= 33 and chance <= 66 then
        xPlayer.addInventoryItem("weed", 15)
    elseif chance >= 33 and chance <= 66 then
        xPlayer.addInventoryItem("meth", 15)
    end
end)

local braquageEnCours = false
local min = 60*1000
Citizen.CreateThread(function()
    while true do
        Wait(1000)
        if braquageEnCours then
            Wait(30*min)
            braquageEnCours = false
        end
    end
end)

RegisterNetEvent("clp_mission:SetStatus")
AddEventHandler("clp_mission:SetStatus", function()
    braquageEnCours = true
end)

RegisterNetEvent("clp_mission:pouvoir")
AddEventHandler("clp_mission:pouvoir", function()
    if braquageEnCours then
        TriggerClientEvent("clp_mission:pouvoir", source, false)
    else
        TriggerClientEvent("clp_mission:pouvoir", source, true)
    end
end)