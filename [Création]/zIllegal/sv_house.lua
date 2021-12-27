local ESX = nil
local CopsConnected       	   = 0
local robbableItems = {
    [1] = {chance = 3, id = 'lockpick', name = 'Outil de crochetage', quantity = 1}, -- rare
    [2] = {chance = 3, id = 'lockpick', name = 'Outil de crochetage', quantity = math.random(1, 3)}, -- really common
    [3] = {chance = 3, id = 'lockpick', name = 'Outil de crochetage', quantity = 1}, -- rare
   }

--[[chance = 1 is very common, the higher the value the less the chance]]--

TriggerEvent('esx:getSharedObject', function(obj)
    ESX = obj
end)

function CountCops()
	local xPlayers = ESX.GetPlayers()

	CopsConnected = 0

	for i=1, #xPlayers, 1 do
		local xPlayer = ESX.GetPlayerFromId(xPlayers[i])
		if xPlayer.job.name == 'police' or xPlayer.job.name == 'sheriff' then
			CopsConnected = CopsConnected + 1
		end
	end

	SetTimeout(120 * 1000, CountCops)
end

CountCops()

ESX.RegisterUsableItem('advancedlockpick', function(source) --Hammer high time to unlock but 100% call cops
    if CopsConnected < 1 then
        TriggerClientEvent('esx:DrawMissionText', source, "~r~Action impossible. (Police)", 3500)
        return
    end
    local source = tonumber(source)
    local xPlayer = ESX.GetPlayerFromId(source)


    TriggerClientEvent('houseRobberies:attempt', source, xPlayer.getInventoryItem('advancedlockpick').count)
    
end)

RegisterServerEvent('houseRobberies:removeLockpick')
AddEventHandler('houseRobberies:removeLockpick', function()
    local source = tonumber(source)
    local xPlayer = ESX.GetPlayerFromId(source)
    xPlayer.removeInventoryItem('advancedlockpick', 1)
end)

RegisterServerEvent('houseRobberies:giveMoney')
AddEventHandler('houseRobberies:giveMoney', function()
    local _source = source
    local xPlayer = ESX.GetPlayerFromId(source)
    local HauseMoney = math.random(50,200) 
    local chancelock   = math.random(0, 99);
   
--[[     if chancelock >= 0 and chancelock <= 15 then
        xPlayer.addInventoryItem('lockpick', 1)
        TriggerClientEvent('esx:DrawMissionText', source, '+ ~g~1 Lockpick', 2500)
    else ]]
       xPlayer.addMoney(HauseMoney)
       TriggerClientEvent('esx:DrawMissionText', source, '+ ~g~'..HauseMoney..'$', 2500)
       --TriggerClientEvent('notification', source, 'You found $'..HauseMoney)
    --end
end)

--[[ RegisterServerEvent('houseRobberies:giveLockpick')
AddEventHandler('houseRobberies:giveLockpick', function()
    local _source = source
    local xPlayer = ESX.GetPlayerFromId(source)
    local total   = math.random(0, 99);

	if total >= 0 and total <= 15 then
       xPlayer.addInventoryItem('lockpick', 1)
       TriggerClientEvent('esx:DrawMissionText', source, '+ ~g~1 Lockpick', 2500)
    end
end) ]]


--[[ RegisterServerEvent('houseRobberies:searchItem')
AddEventHandler('houseRobberies:searchItem', function()
 local _source = source
 local xPlayer = ESX.GetPlayerFromId(source)
 local HauseMoney = math.random(150,350) 

    xPlayer.addMoney(HauseMoney)
    --TriggerClientEvent('esx:DrawMissionText', source, '+ ~g~'..HauseMoney..'$', 2500)
    TriggerClientEvent('notification', source, 'You found $'..HauseMoney)
end) ]]
