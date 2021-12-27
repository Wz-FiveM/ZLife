ESX = nil
cooldownlist = {}

TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

local potrzebniPolicjanci = 3
local czastimer = 600 * 1000    
local gotowkaA = 4230		
local gotowkaB = 8123 				
--local KosztAktywacji = 2500 		
-----------------------------------
local MisjaAktywna = 0
local copsConnected = 0
local deadPeds = {}
local rob = false
local robbers = {}
PlayersCrafting    = {}
local CopsConnected  = 0


RegisterServerEvent('napadtransport:akceptujto')
AddEventHandler('napadtransport:akceptujto', function()
	local copsOnDuty = 0
	local Players = ESX.GetPlayers()
	local _source = source
	local xPlayer = ESX.GetPlayerFromId(_source)
	if MisjaAktywna == 0 then
		for i = 1, #Players do
			local xPlayer = ESX.GetPlayerFromId(Players[i])
			if xPlayer["job"]["name"] == "police" or xPlayer["job"]["name"] == "sheriff" then
				copsOnDuty = copsOnDuty + 1
			end
			if copsOnDuty >= potrzebniPolicjanci then
				TriggerClientEvent("napadtransport:Pozwolwykonac", _source)
				xPlayer.removeMoney(1000)
				OdpalTimer()
			else
        		TriggerClientEvent('esx:DrawMissionText', source, "~r~Je n'ai pas de mission pour l'instant.", 5000)
    		end
		end
	else
		TriggerClientEvent('esx:DrawMissionText', source, "~r~Je viens de donner une mission à quelqu'un.", 5000)
	end
end)

function OdpalTimer()
	MisjaAktywna = 1
		Wait(czastimer)
	MisjaAktywna = 0
end

RegisterServerEvent('napadtransport:graczZrobilnapad')
AddEventHandler('napadtransport:graczZrobilnapad', function()
local _source = source
local xPlayer = ESX.GetPlayerFromId(_source)
local LosujSiano = math.random(gotowkaA,gotowkaB)
xPlayer.addAccountMoney('black_money', LosujSiano)
--TriggerClientEvent('esx:showNotification', source, 'Tu as récupéré ~g~'..LosujSiano..' $~w~')
TriggerClientEvent('esx:DrawMissionText', source, "Vous avez récupéré ~r~"..LosujSiano.." $~w~", 8000)
Wait(2500)
end)










RegisterServerEvent('tost:zgarnijsiano')
AddEventHandler('tost:zgarnijsiano', function()
    local _source = source
	local xPlayer = ESX.GetPlayerFromId(_source)
	local Ilosc = math.random(3500,7500) 
	TriggerClientEvent('esx:showNotification', source, 'Vous avez gagné ~g~'..Ilosc..'$')
    xPlayer.addMoney(Ilosc)
	Wait(500)
end)


RegisterServerEvent('tost:zawiadompsy')
AddEventHandler('tost:zawiadompsy', function(x, y, z) 
    TriggerClientEvent('tost:infodlalspd', -1, x, y, z)
end)









function CountCops()

    local xPlayers = ESX.GetPlayers()
    copsConnected = 0

    for i=1, #xPlayers, 1 do
        local xPlayer = ESX.GetPlayerFromId(xPlayers[i])
        if xPlayer.job.name == 'police' or xPlayer.job.name == 'sheriff'then
            copsConnected = copsConnected + 1
        end
    end
    TriggerClientEvent('esx_mugging:copsConnected', -1, copsConnected)

    SetTimeout(60000, CountCops)

end
CountCops()

RegisterServerEvent('loffe_robbery:pedDead')
AddEventHandler('loffe_robbery:pedDead', function(store)
    if not deadPeds[store] then
        deadPeds[store] = 'deadlol'
        TriggerClientEvent('loffe_robbery:onPedDeath', -1, store)
        local second = 1000
        local minute = 60 * second
        local hour = 60 * minute
        local cooldown = Config.Shops[store].cooldown
        local wait = cooldown.hour * hour + cooldown.minute * minute + cooldown.second * second
        Wait(wait)
            if not Config.Shops[store].robbed then
                for k, v in pairs(deadPeds) do if k == store then 
                    table.remove(deadPeds, k) 
                end 
            end
            TriggerClientEvent('loffe_robbery:resetStore', -1, store)
        end
    end
end)

RegisterServerEvent('loffe_robbery:handsUp')
AddEventHandler('loffe_robbery:handsUp', function(store)
    TriggerClientEvent('loffe_robbery:handsUp', -1, store)
end)

RegisterServerEvent('loffe_robbery:pickUp')
AddEventHandler('loffe_robbery:pickUp', function(store)
    local xPlayer = ESX.GetPlayerFromId(source)
    local randomAmount = math.random(950, 2350)
    xPlayer.addMoney(randomAmount)
	TriggerClientEvent('esx:DrawMissionText', source, "Vous avez récupéré ~g~".. randomAmount .."$", 5000)
	TriggerClientEvent('loffe_robbery:removePickup', -1, store) 
end)

ESX.RegisterServerCallback('loffe_robbery:canRob', function(source, cb, store)
    local cops = 0
    local xPlayers = ESX.GetPlayers()
    for i = 1, #xPlayers do
        local xPlayer = ESX.GetPlayerFromId(xPlayers[i])
        if xPlayer.job.name == 'police' or xPlayer.job.name == 'sheriff' then
            cops = cops + 1
        end
    end
    if cops >= Config.Shops[store].cops then
        if not Config.Shops[store].robbed and not deadPeds[store] then
            cb(true)
        else
            cb(false)
        end
    else
        cb('no_cops')
    end
end)

RegisterServerEvent('loffe_robbery:policemsg')
AddEventHandler('loffe_robbery:policemsg', function(store)
    local src = source
    Config.Shops[store].robbed = true
    local xPlayers = ESX.GetPlayers()
    Wait(4000)
    for i = 1, #xPlayers do
        local xPlayer = ESX.GetPlayerFromId(xPlayers[i])
        if xPlayer.job.name == 'police' or xPlayer.job.name == 'sheriff' then
            TriggerClientEvent('loffe_robbery:msgPolice', xPlayer.source, store, src)
        end
    end
end)

RegisterServerEvent('loffe_robbery:rob')
AddEventHandler('loffe_robbery:rob', function(store)
    local src = source
    Config.Shops[store].robbed = true
    local xPlayers = ESX.GetPlayers()

    TriggerClientEvent('loffe_robbery:rob', -1, store)
    Wait(30000)
    TriggerClientEvent('loffe_robbery:robberyOver', src)

    local second = 1000
    local minute = 60 * second
    local hour = 60 * minute
    local cooldown = Config.Shops[store].cooldown
    local wait = cooldown.hour * hour + cooldown.minute * minute + cooldown.second * second
    Wait(wait)
    Config.Shops[store].robbed = false
    for k, v in pairs(deadPeds) do if k == store then table.remove(deadPeds, k) end end
    TriggerClientEvent('loffe_robbery:resetStore', -1, store)
end)

Citizen.CreateThread(function()
    while true do
        for i = 1, #deadPeds do TriggerClientEvent('loffe_robbery:pedDead', -1, i) end -- update dead peds
        Citizen.Wait(500)
    end
end)



function get3DDistance(x1, y1, z1, x2, y2, z2)
	return math.sqrt(math.pow(x1 - x2, 2) + math.pow(y1 - y2, 2) + math.pow(z1 - z2, 2))
end

RegisterServerEvent('esx_vangelico_robbery:gioielli1')
AddEventHandler('esx_vangelico_robbery:gioielli1', function()

	local xPlayer = ESX.GetPlayerFromId(source)

	xPlayer.addInventoryItem('jewels', math.random(5, 20))
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

local function Craft(source)

	SetTimeout(4000, function()

		if PlayersCrafting[source] == true and CopsConnected >= Config.RequiredCopsSell then

			local xPlayer  = ESX.GetPlayerFromId(source)
			local JewelsQuantity = xPlayer.getInventoryItem('jewels').count

			if JewelsQuantity < 20 then 
				TriggerClientEvent('esx:showNotification', source, "~r~Vous n\'avez pas assez de bijoux")
			else   
                xPlayer.removeInventoryItem('jewels', 20)
                Citizen.Wait(4000)
				xPlayer.addAccountMoney('black_money', 5000)
				
				Craft(source)
			end
		else
		TriggerClientEvent('esx:showNotification', source, "Il faut au moins ~b~3 Policier~s~ en ville pour vendre.")
		end
	end)
end

RegisterServerEvent('lester:vendita')
AddEventHandler('lester:vendita', function()
	local _source = source
	PlayersCrafting[_source] = true
	TriggerClientEvent('esx:showNotification', _source, "~y~Bijoux~s~ Vente en cours ...")
	Craft(_source)
end)

RegisterServerEvent('lester:nvendita')
AddEventHandler('lester:nvendita', function()
	local _source = source
	PlayersCrafting[_source] = false
end)






local CopsConnected       	   = 0
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

RegisterServerEvent("gofastclp:atendretest")
AddEventHandler("gofastclp:atendretest", function(bonus)
	if CopsConnected < 3 then
		TriggerClientEvent('esx:showNotification', source, "Action ~r~impossible~s~, il n'y a pas assez de LSPD en ville.", CopsConnected, 3)
	else
		TriggerClientEvent("chancelocal:clp_mission")
	end
	--end
end)

RegisterServerEvent("gofastclp:venfres")
AddEventHandler("gofastclp:venfres", function(bonus)
     local _source = source
     local xPlayer = ESX.GetPlayerFromId(_source)
     if not xPlayer then return; end

     if bonus > 950 then
		  TriggerClientEvent('esx:showNotification', source, '~g~Véhicule en parfait état.')
     elseif bonus > 900 then
		  TriggerClientEvent('esx:showNotification', source, '🔧~y~Véhicule en états correct.')
		  xPlayer.removeMoney(450)
     elseif bonus > 800 then
		  TriggerClientEvent('esx:showNotification', source, '🔧~o~Véhicule assez abimé.')
		  xPlayer.removeMoney(950)
     elseif bonus > 650 then
		  TriggerClientEvent('esx:showNotification', source, '🔧~r~Véhicule complétement abimé.')
		  xPlayer.removeMoney(1250)
     end
	 local montantentre = math.random(1250, 4320)
     --xPlayer.addMoney(montantentre)
     xPlayer.addAccountMoney('black_money', montantentre)
     TriggerClientEvent('esx:DrawMissionText', source, 'Le dealer vous a donné ~r~'..montantentre..' $', 4600)
end)



-----------------------------------------------------------LOCKPICK----------------------------------------------------------------

--[[ ESX.RegisterUsableItem('lockpick', function(source)
	local xPlayer = ESX.GetPlayerFromId(source)

    TriggerClientEvent("clippy_lockpick:open", xPlayer.source)
end) ]]

RegisterServerEvent('lockpick:positions')
AddEventHandler('lockpick:positions', function(x, y, z) 
	TriggerClientEvent('lockpick:infopolice', -1, x, y, z)
end)

RegisterNetEvent('removebecausecrocheter')
AddEventHandler('removebecausecrocheter', function()
    local _source = source
    local xPlayer = ESX.GetPlayerFromId(source)

    xPlayer.removeInventoryItem('lockpick', 1)
end)


RegisterNetEvent('ChanceOpenCarLock')
AddEventHandler('ChanceOpenCarLock', function()
    local _source = source
    local xPlayer = ESX.GetPlayerFromId(source)
    local total   = math.random(0, 99);

	if total >= 0 and total <= 50 then
        TriggerClientEvent('crochetagegagnecivil', source)
    else 
        TriggerClientEvent('crochetagefail', source)
    end
end)