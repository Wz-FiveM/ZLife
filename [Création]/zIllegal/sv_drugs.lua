ESX = nil

local PlayerHackTimer = {}
local PlayerDrugsTimer = {}
local PlayerConvertTimer = {}
local CopsConnected       	   = 0

TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

function competCops()
	local xPlayers = ESX.GetPlayers()

	CopsConnected = 0

	for i=1, #xPlayers, 1 do
		local xPlayer = ESX.GetPlayerFromId(xPlayers[i])
		if xPlayer.job.name == 'police' or xPlayer.job.name == 'sheriff' then
			CopsConnected = CopsConnected + 1
		end
	end

	SetTimeout(120 * 1000, competCops)
end

competCops()


Citizen.CreateThread(function() -- do not touch this thread function!
	while true do
	Citizen.Wait(1000)
		for k,v in pairs(PlayerHackTimer) do
			if v.time <= 0 then
				RemoveStarted(v.started)
			else
				v.time = v.time - 1000
			end
		end
		for k,v in pairs(PlayerDrugsTimer) do
			if v.timeDrugs <= 0 then
				RemoveStartedDrugs(v.startedDrugs)
			else
				v.timeDrugs = v.timeDrugs - 1000
			end
		end
		for k,v in pairs(PlayerConvertTimer) do
			if v.timeConvert <= 0 then
				RemoveStartedConvert(v.startedConvert)
			else
				v.timeConvert = v.timeConvert - 1000
			end
		end
	end
end)


RegisterServerEvent("esx_newDrugs:reward")
AddEventHandler("esx_newDrugs:reward",function(amount,typed)
	local xPlayer = ESX.GetPlayerFromId(source)
	xPlayer.addInventoryItem(typed.."brick",math.ceil(amount))
end)

RegisterServerEvent("esx_newDrugs:syncMissionData")
AddEventHandler("esx_newDrugs:syncMissionData",function(data)
	TriggerClientEvent("esx_newDrugs:syncMissionData",-1,data)
end)

ESX.RegisterUsableItem('pelle', function(source)
	TriggerClientEvent('commencercreuserverif', source)
end)

RegisterServerEvent("pelle:broken")
AddEventHandler("pelle:broken",function()
	local xPlayer = ESX.GetPlayerFromId(source)
	xPlayer.removeInventoryItem("pelle",1)
end)

-- // ## DRUGS EFFECT ## // --

ESX.RegisterUsableItem('meth', function(source)
	if not CheckedStartedDrugs(GetPlayerIdentifier(source)) then
	TriggerClientEvent("c_drugs:activate_meth",source)
	local xPlayer = ESX.GetPlayerFromId(source)
	xPlayer.removeInventoryItem("meth",1)
	else
	 	TriggerClientEvent("esx:showNotification",source,string.format("Vous pouvez ~r~ consommer ~s~ un autre ~y~ médicament ~s~ en : ~b~%s secondes~s~",GetTimeForDrugs(GetPlayerIdentifier(source))))
	end
end)

ESX.RegisterUsableItem('coke', function(source)
	if not CheckedStartedDrugs(GetPlayerIdentifier(source)) then
	TriggerClientEvent("c_drugs:activate_coke",source)
	local xPlayer = ESX.GetPlayerFromId(source)
	xPlayer.removeInventoryItem("coke",1)
	else
	 	TriggerClientEvent("esx:showNotification",source,string.format("Vous pouvez ~r~ consommer ~s~ un autre ~y~ médicament ~s~ en : ~b~%s secondes~s~",GetTimeForDrugs(GetPlayerIdentifier(source))))
	end
end)

ESX.RegisterUsableItem('weed', function(source)
	if not CheckedStartedDrugs(GetPlayerIdentifier(source)) then
	TriggerClientEvent("c_drugs:activate_weed",source)
	local xPlayer = ESX.GetPlayerFromId(source)
	xPlayer.removeInventoryItem("weed",1)
	else
	 	TriggerClientEvent("esx:showNotification",source,string.format("Vous pouvez ~r~ consommer ~s~ un autre ~y~ médicament ~s~ en : ~b~%s secondes~s~",GetTimeForDrugs(GetPlayerIdentifier(source))))
	end
end)

function RemoveStarted(source)
	for k,v in pairs(PlayerHackTimer) do
		if v.started == source then
			table.remove(PlayerHackTimer,k)
		end
	end
end

function CheckedStarted(source)
	for k,v in pairs(PlayerHackTimer) do
		if v.started == source then
			return true
		end
	end
	return false
end


function RemoveStartedDrugs(source)
	for k,v in pairs(PlayerDrugsTimer) do
		if v.startedDrugs == source then
			table.remove(PlayerDrugsTimer,k)
		end
	end
end

function GetTimeForDrugs(source)
	for k,v in pairs(PlayerDrugsTimer) do
		if v.startedDrugs == source then
			return math.ceil(v.timeDrugs/1000)
		end
	end
end

function CheckedStartedDrugs(source)
	for k,v in pairs(PlayerDrugsTimer) do
		if v.startedDrugs == source then
			return true
		end
	end
	return false
end

function RemoveStartedConvert(source)
	for k,v in pairs(PlayerConvertTimer) do
		if v.startedConvert == source then
			table.remove(PlayerConvertTimer,k)
		end
	end
end

local soldAmount = {}

RegisterServerEvent("esx_newDrugs:sellDrugs")
AddEventHandler("esx_newDrugs:sellDrugs", function()
	if CopsConnected < 1 then
		TriggerClientEvent('esx:DrawMissionText', source, "~r~Action impossible. (Police)", 3500)
		return
	end

	local _source = source
	local xPlayer = ESX.GetPlayerFromId(_source)
	local weed = xPlayer.getInventoryItem('weed').count
	local meth = xPlayer.getInventoryItem('meth').count
	local coke = xPlayer.getInventoryItem('coke').count
	local drugamount = 0
	local price = 0
	local drugType = nil
	
	if weed > 0 then
		drugType = 'weed'
		if weed == 1 then
			drugamount = 1
		elseif weed == 2 then
			drugamount = math.random(1,1)
		elseif weed == 3 then	
			drugamount = math.random(1,1)
		elseif weed >= 4 then	
			drugamount = math.random(1,1)
		elseif weed >= 5 then	
			drugamount = math.random(1,1)
		elseif weed >= 6 then	
			drugamount = math.random(1,1)
		end
		
	elseif meth > 0 then
		drugType = 'meth'
		if meth == 1 then
			drugamount = 1
		elseif meth == 2 then
			drugamount = math.random(1,1)
		elseif meth >= 3 then	
			drugamount = math.random(1,1)
		end
		
	elseif coke > 0 then
		drugType = 'coke'
		if coke == 1 then
			drugamount = 1
		elseif coke == 2 then
			drugamount = math.random(1,1)
		elseif coke >= 3 then	
			drugamount = math.random(1,1)
		end
	
	else
		TriggerClientEvent('esx:DrawMissionText', _source, "~r~Vous n'avez pas suffisamment de marchandise.", 5000)
		return
	end
	
	if drugType=='weed' then
		price = math.random(65,95) * drugamount
	elseif drugType=='meth' then
		price = math.random(145,185) * drugamount
	elseif drugType=='coke' then
		price = math.random(115,160) * drugamount
	end
	
	if drugType ~= nil then
		xPlayer.removeInventoryItem(drugType, drugamount)
	end
	
	xPlayer.addAccountMoney('black_money', price)
	if drugType=='weed' then
		TriggerClientEvent('esx:DrawMissionText', _source, "~g~Client : ~s~Merci beaucoup pour ton ~g~Cannabis~s~. (~r~+ " .. price .."$~s~)", 3650)
	elseif drugType=='meth' then
		TriggerClientEvent('esx:DrawMissionText', _source, "~g~Client : ~s~Merci beaucoup pour ta ~b~Méthamphétamine~s~. (~r~+ " .. price .."$~s~)", 3650)
	elseif drugType=='coke' then
		TriggerClientEvent('esx:DrawMissionText', _source, "~g~Client : ~s~Merci beaucoup pour ta ~y~Cocaïne~s~. (~r~+ " .. price .."$~s~)", 3650)
	end
end)

RegisterServerEvent("esx_newDrugs:canSellDrugs")
AddEventHandler("esx_newDrugs:canSellDrugs", function()
	local xPlayer = ESX.GetPlayerFromId(source)
	if xPlayer ~= nil then
		local soldAmount = (xPlayer.getInventoryItem("coke").count > 0 or xPlayer.getInventoryItem("meth").count > 0 or xPlayer.getInventoryItem("weed").count > 0)
		TriggerClientEvent("esx_newDrugs:canSellDrugs",source,soldAmount)
	end
end)

RegisterServerEvent("c_drugsale:canSellDrugs")
AddEventHandler("c_drugsale:canSellDrugs", function()
	local xPlayer = ESX.GetPlayerFromId(source)
	if xPlayer ~= nil then
		local sell = (xPlayer.getInventoryItem("coke").count > 0 or xPlayer.getInventoryItem("meth").count > 0 or xPlayer.getInventoryItem("weed").count > 0)
		TriggerClientEvent("c_drugsale:canSellDrugs",source,sell)
	end
end)


--------------------------------------------------------------------------------------------------------------------------------------------------------------
--------------------------------------------------------------------------------------------------------------------------------------------------------------
----------------------------------------------ESX DRUGS-------------------------------------------------------------------------------------------------------
--------------------------------------------------------------------------------------------------------------------------------------------------------------
--------------------------------------------------------------------------------------------------------------------------------------------------------------
--------------------------------------------------------------------------------------------------------------------------------------------------------------
--------------------------------------------------------------------------------------------------------------------------------------------------------------
--------------------------------------------------------------------------------------------------------------------------------------------------------------
----------------------------------------------ESX DRUGS-------------------------------------------------------------------------------------------------------
--------------------------------------------------------------------------------------------------------------------------------------------------------------
--------------------------------------------------------------------------------------------------------------------------------------------------------------
--------------------------------------------------------------------------------------------------------------------------------------------------------------
--------------------------------------------------------------------------------------------------------------------------------------------------------------
--------------------------------------------------------------------------------------------------------------------------------------------------------------
----------------------------------------------ESX DRUGS-------------------------------------------------------------------------------------------------------
--------------------------------------------------------------------------------------------------------------------------------------------------------------
--------------------------------------------------------------------------------------------------------------------------------------------------------------
--------------------------------------------------------------------------------------------------------------------------------------------------------------


local PlayersHarvestingCoke    = {}
local PlayersTransformingCoke  = {}
local PlayersSellingCoke       = {}
local PlayersHarvestingMeth    = {}
local PlayersTransformingMeth  = {}
local PlayersSellingMeth       = {}
local PlayersHarvestingAcide   = {}
local PlayersHarvestingWeed    = {}
local PlayersTransformingWeed  = {}
local PlayersSellingWeed       = {}
local PlayersHarvestingTerre   = {}
local PlayersHarvestingTerrehumide = {}
local PlayersHarvestingAntigel = {}

TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

--coke
local function HarvestCoke(source)
	if CopsConnected < 0 then
		TriggerClientEvent('esx:DrawMissionText', source, "~r~Action impossible. (Police)", 3500)
		return
	end

	SetTimeout(6500, function()
		if PlayersHarvestingCoke[source] then
			local xPlayer = ESX.GetPlayerFromId(source)
			local acidesulQuantity = xPlayer.getInventoryItem('acidesulfurique').count
			local coke = xPlayer.getInventoryItem('feuilledecoca')

			if coke.limit ~= -1 and coke.count >= coke.limit then
				TriggerClientEvent('esx:showNotification', source, "~r~Vous ne pouvez plus fabriquer de coca.")
			elseif acidesulQuantity < 2 then 
				TriggerClientEvent('esx:showNotification', source, "~r~Vous n\'avez plus d\'acide sulfurique.")
			else
				TriggerClientEvent('esx:DrawMissionText', source, "- 2 ~b~Acide~s~ (+~g~ 1 Coca~s~)", 4500)
				xPlayer.removeInventoryItem('acidesulfurique', 2)
				xPlayer.addInventoryItem('feuilledecoca', 1)
				HarvestCoke(source)
			end
		end
	end)
end

RegisterServerEvent('c_drugs:startHarvestCoke')
AddEventHandler('c_drugs:startHarvestCoke', function()
	local _source = source

	if not PlayersHarvestingCoke[_source] then
		PlayersHarvestingCoke[_source] = true

		TriggerClientEvent('esx:DrawMissionText', _source, "~g~Récolte en cours..", 2500)
		HarvestCoke(_source)
	else
		
	end
end)

RegisterServerEvent('c_drugs:stopHarvestCoke')
AddEventHandler('c_drugs:stopHarvestCoke', function()
	local _source = source

	PlayersHarvestingCoke[_source] = false
end)

local function TransformCoke(source)
	if CopsConnected < 0 then
		TriggerClientEvent('esx:DrawMissionText', source, "~r~Action impossible. (Police)", 3500)
		return
	end

	SetTimeout(60000, function()
		if PlayersTransformingCoke[source] then
			local xPlayer = ESX.GetPlayerFromId(source)
			local cokeQuantity = xPlayer.getInventoryItem('feuilledecoca').count
			local pooch = xPlayer.getInventoryItem('cokebrick')

			if pooch.limit ~= -1 and pooch.count >= pooch.limit then
				TriggerClientEvent('esx:showNotification', source, "~r~Vous avez trop de bloques.")
			elseif cokeQuantity < 100 then
				TriggerClientEvent('esx:showNotification', source, "~r~Vous n\'avez pas suffisamment de coca à traiter.")
			else
				xPlayer.removeInventoryItem('feuilledecoca', 125)
				xPlayer.addInventoryItem('cokebrick', 1)

				TransformCoke(source)
			end
		end
	end)
end

RegisterServerEvent('c_drugs:startTransformCoke')
AddEventHandler('c_drugs:startTransformCoke', function()
	local _source = source

	if not PlayersTransformingCoke[_source] then
		PlayersTransformingCoke[_source] = true

		TriggerClientEvent('esx:showNotification', _source, "~g~Traitement en cours..")
		TransformCoke(_source)
	else
		
	end
end)

RegisterServerEvent('c_drugs:stopTransformCoke')
AddEventHandler('c_drugs:stopTransformCoke', function()
	local _source = source

	PlayersTransformingCoke[_source] = false
end)

RegisterServerEvent('c_drugs:stopSellCoke')
AddEventHandler('c_drugs:stopSellCoke', function()
	local _source = source

	PlayersSellingCoke[_source] = false
end)

--meth
local function HarvestMeth(source)
	if CopsConnected < 0 then
		TriggerClientEvent('esx:DrawMissionText', source, "~r~Action impossible. (Police)", 3500)
		return
	end
	
	SetTimeout(6000, function()
		if PlayersHarvestingMeth[source] then
			local xPlayer = ESX.GetPlayerFromId(source)
			local antigelQuantity = xPlayer.getInventoryItem('antigel').count
			local meth = xPlayer.getInventoryItem('crystaldemeth')

			if meth.limit ~= -1 and meth.count >= meth.limit then
				TriggerClientEvent('esx:showNotification', source, "~r~Vous avez trop de cristaux de meth.")
			elseif antigelQuantity < 2 then 
				TriggerClientEvent('esx:showNotification', source, "~r~Vous n\'avez pas suffisamment ~b~de sodium benzoate~r~.")
			else
				TriggerClientEvent('esx:DrawMissionText', source, "- 2 ~b~Sodium benzoate~s~ (+~g~ 1 Crystal de meth~s~)", 1500)
				xPlayer.removeInventoryItem('antigel', 2)
				xPlayer.addInventoryItem('crystaldemeth', 1)
				HarvestMeth(source)
			end
		end
	end)
end

RegisterServerEvent('c_drugs:startHarvestMeth')
AddEventHandler('c_drugs:startHarvestMeth', function()
	local _source = source

	if not PlayersHarvestingMeth[_source] then
		PlayersHarvestingMeth[_source] = true

		TriggerClientEvent('esx:DrawMissionText', _source, "~g~Récolte en cours..", 2500)
		HarvestMeth(_source)
	else
		
	end
end)

RegisterServerEvent('c_drugs:stopHarvestMeth')
AddEventHandler('c_drugs:stopHarvestMeth', function()
	local _source = source

	PlayersHarvestingMeth[_source] = false
end)

local function TransformMeth(source)
	if CopsConnected < 0 then
		TriggerClientEvent('esx:DrawMissionText', source, "~r~Action impossible. (Police)", 3500)
		return
	end

	SetTimeout(60000, function()
		if PlayersTransformingMeth[source] then
			local xPlayer = ESX.GetPlayerFromId(source)
			local methQuantity = xPlayer.getInventoryItem('crystaldemeth').count
			local pooch = xPlayer.getInventoryItem('methbrick')

			if pooch.limit ~= -1 and pooch.count >= pooch.limit then
				TriggerClientEvent('esx:showNotification', source, "~r~Vous avez trop de bloques.")
			elseif methQuantity < 100 then
				TriggerClientEvent('esx:showNotification', source, "~r~Vous n\'avez pas suffisamment de crystal de meth à conditionner.")
			else
				xPlayer.removeInventoryItem('crystaldemeth', 125)
				xPlayer.addInventoryItem('methbrick', 1)

				TransformMeth(source)
			end
		end
	end)
end

RegisterServerEvent('c_drugs:startTransformMeth')
AddEventHandler('c_drugs:startTransformMeth', function()
	local _source = source

	if not PlayersTransformingMeth[_source] then
		PlayersTransformingMeth[_source] = true

		TriggerClientEvent('esx:showNotification', _source, "~g~Traitement en cours..")
		TransformMeth(_source)
	else
		
	end
end)

RegisterServerEvent('c_drugs:stopTransformMeth')
AddEventHandler('c_drugs:stopTransformMeth', function()
	local _source = source

	PlayersTransformingMeth[_source] = false
end)

RegisterServerEvent('c_drugs:stopSellMeth')
AddEventHandler('c_drugs:stopSellMeth', function()
	local _source = source

	PlayersSellingMeth[_source] = false
end)

--weed
local function HarvestWeed(source)
	if CopsConnected < 0 then
		TriggerClientEvent('esx:DrawMissionText', source, "~r~Action impossible. (Police)", 3500)
		return
	end

	SetTimeout(8250, function()
		if PlayersHarvestingWeed[source] then
			local _source = source
			local xPlayer = ESX.GetPlayerFromId(_source)
			local terreQuantity = xPlayer.getInventoryItem('terre').count
			local weed = xPlayer.getInventoryItem('chanvre')

			if weed.limit ~= -1 and weed.count >= weed.limit then
				TriggerClientEvent('esx:showNotification', source, "~r~Vous avez trop de chanvre.")
			elseif terreQuantity < 2 then
				TriggerClientEvent('esx:showNotification', source, "~r~Vous n\'avez pas suffisamment de terre.")
			else
				TriggerClientEvent('esx:DrawMissionText', source, "- 2 ~b~Terre~s~ (+~g~ 1 Graîne de cannabis~s~)", 4500)
				xPlayer.removeInventoryItem('terre', 2)
				xPlayer.addInventoryItem('graineweed', 1)
				HarvestWeed(source)
			end
		end
	end)
end

RegisterServerEvent('c_drugs:startHarvestWeed')
AddEventHandler('c_drugs:startHarvestWeed', function()
	local _source = source

	if not PlayersHarvestingWeed[_source] then
		PlayersHarvestingWeed[_source] = true

		TriggerClientEvent('esx:DrawMissionText', _source, "~g~Récolte en cours..", 2500)
		HarvestWeed(_source)
	else
		
	end
end)

RegisterServerEvent('c_drugs:stopHarvestWeed')
AddEventHandler('c_drugs:stopHarvestWeed', function()
	local _source = source

	PlayersHarvestingWeed[_source] = false
end)

local function TransformWeed(source)
	if CopsConnected < 0 then
		TriggerClientEvent('esx:DrawMissionText', source, "~r~Action impossible. (Police)", 3500)
		return
	end

	SetTimeout(60000, function()
		if PlayersTransformingWeed[source] then
			local xPlayer = ESX.GetPlayerFromId(source)
			local weedQuantity = xPlayer.getInventoryItem('chanvre').count
			local pooch = xPlayer.getInventoryItem('weedbrick')

			if pooch.limit ~= -1 and pooch.count >= pooch.limit then
				TriggerClientEvent('esx:showNotification', source, "~r~Vous avez trop de bloques.")
			elseif weedQuantity < 100 then
				TriggerClientEvent('esx:showNotification', source, "~r~Vous n\'avez pas suffisamment de chanvre.")
			else
				xPlayer.removeInventoryItem('chanvre', 125)
				xPlayer.addInventoryItem('weedbrick', 1)

				TransformWeed(source)
			end
		end
	end)
end

RegisterServerEvent('c_drugs:startTransformWeed')
AddEventHandler('c_drugs:startTransformWeed', function()
	local _source = source

	if not PlayersTransformingWeed[_source] then
		PlayersTransformingWeed[_source] = true

		TriggerClientEvent('esx:showNotification', _source, "~g~Traitement en cours..")
		TransformWeed(_source)
	else
		
	end
end)

RegisterServerEvent('c_drugs:stopTransformWeed')
AddEventHandler('c_drugs:stopTransformWeed', function()
	local _source = source

	PlayersTransformingWeed[_source] = false
end)

RegisterServerEvent('c_drugs:stopSellWeed')
AddEventHandler('c_drugs:stopSellWeed', function()
	local _source = source

	PlayersSellingWeed[_source] = false
end)

ESX.RegisterServerCallback('drugs:savoirsipelle', function(source, cb, item)
    local _source = source
    local xPlayer = ESX.GetPlayerFromId(source)
    local items = xPlayer.getInventoryItem(item)
    --print(('gcphone:getItemAmount quantite phone : ' .. xPlayer.identifier))
    if items == nil then
        cb(0)
    else
        cb(items.count)
    end
end)

RegisterServerEvent('c_drugs:startHarvestTerre')
AddEventHandler('c_drugs:startHarvestTerre', function(count)
	local _source = source
	local xPlayer = ESX.GetPlayerFromId(source)
	xPlayer.addInventoryItem('terre', count)
end)

local function HarvestTerreHumide(source)

	SetTimeout(2850, function()
		if PlayersHarvestingTerrehumide[source] then
			local xPlayer = ESX.GetPlayerFromId(source)
			local terreCount = xPlayer.getInventoryItem('terrehumide')

			if terreCount.limit ~= -1 and terreCount.count >= terreCount.limit then
				TriggerClientEvent('esx:showNotification', source, "~r~Vous ne pouvez plus ramasser de terre humide.")
				TriggerClientEvent("arrettersupppropandanim", source)
			else
				TriggerClientEvent('esx:DrawMissionText', source, "Vous avez récupéré une ~g~Terre humide~s~. (~b~+1~s~)", 1500)
				xPlayer.addInventoryItem('terrehumide', 1)
				HarvestTerreHumide(source)
			end
		end
	end)
end

RegisterServerEvent('c_drugs:startHarvestTerrehumide')
AddEventHandler('c_drugs:startHarvestTerrehumide', function()
	local _source = source

	if not PlayersHarvestingTerrehumide[_source] then
		PlayersHarvestingTerrehumide[_source] = true

		TriggerClientEvent('esx:DrawMissionText', _source, "~g~Récolte en cours..", 2500)
		HarvestTerreHumide(_source)
	else
		
	end
end)

RegisterServerEvent('c_drugs:stopHarvestTerrehumide')
AddEventHandler('c_drugs:stopHarvestTerrehumide', function()
	local _source = source

	PlayersHarvestingTerrehumide[_source] = false
end)


RegisterServerEvent('c_drugs:stopHarvestTerre')
AddEventHandler('c_drugs:stopHarvestTerre', function()
	local _source = source

	PlayersHarvestingTerre[_source] = false
end)

local function HarvestAcide(source)
	if CopsConnected < 0 then
		TriggerClientEvent('esx:showNotification', source, "~r~Action impossible. (Police)")
		return
	end

	SetTimeout(1650, function()
		if PlayersHarvestingAcide[source] then
			local xPlayer = ESX.GetPlayerFromId(source)
			local acide = xPlayer.getInventoryItem('acidesulfurique')
 
			if acide.limit ~= -1 and acide.count >= acide.limit then
				TriggerClientEvent('esx:showNotification', source, "~r~Vous ne pouvez plus ramasser d'acide.")
			else
				TriggerClientEvent('esx:DrawMissionText', source, "Vous avez récupéré un ~g~Acide sulfurique~s~. (~b~+1~s~)", 1200)
				xPlayer.addInventoryItem('acidesulfurique', 1)
				HarvestAcide(source)
			end
		end
	end)
end

RegisterServerEvent('c_drugs:startHarvestAcide')
AddEventHandler('c_drugs:startHarvestAcide', function()
	local _source = source

	if not PlayersHarvestingAcide[_source] then
		PlayersHarvestingAcide[_source] = true

		TriggerClientEvent('esx:DrawMissionText', _source, "~g~Récolte en cours..", 2500)
		HarvestAcide(_source)
	else
		
	end
end)

RegisterServerEvent('c_drugs:stopHarvestAcide')
AddEventHandler('c_drugs:stopHarvestAcide', function()
	local _source = source

	PlayersHarvestingAcide[_source] = false
end)


local function HarvestAntigel(source)
	if CopsConnected < 0 then
		TriggerClientEvent('esx:showNotification', source, "~r~Action impossible. (Police)")
		return
	end

	SetTimeout(1500, function()
		if PlayersHarvestingAntigel[source] then
			local xPlayer = ESX.GetPlayerFromId(source)
			local antigel = xPlayer.getInventoryItem('antigel')

			if antigel.limit ~= -1 and antigel.count >= antigel.limit then
				TriggerClientEvent('esx:showNotification', source, "~r~Vous ne pouvez plus ramasser d'sodium benzoate.")
			else
				TriggerClientEvent('esx:DrawMissionText', source, "Vous avez récupéré un ~g~Sodium benzoate~s~. (~b~+1~s~)", 1200)
				xPlayer.addInventoryItem('antigel', 1)
				HarvestAntigel(source)
			end
		end
	end)
end

RegisterServerEvent('c_drugs:startHarvestAntigel')
AddEventHandler('c_drugs:startHarvestAntigel', function()
	local _source = source

	if not PlayersHarvestingAntigel[_source] then
		PlayersHarvestingAntigel[_source] = true

		TriggerClientEvent('esx:DrawMissionText', _source, "~g~Récolte en cours..", 2500)
		HarvestAntigel(_source)
	else
		
	end
end)

RegisterServerEvent('c_drugs:stopHarvestAntigel')
AddEventHandler('c_drugs:stopHarvestAntigel', function()
	local _source = source

	PlayersHarvestingAntigel[_source] = false
end)

RegisterServerEvent('c_drugs:GetUserInventory')
AddEventHandler('c_drugs:GetUserInventory', function(currentZone)
	local _source = source
	local xPlayer = ESX.GetPlayerFromId(_source)
	TriggerClientEvent('c_drugs:ReturnInventory',
		_source,
		xPlayer.getInventoryItem('feuilledecoca').count,
		xPlayer.getInventoryItem('cokebrick').count,
		xPlayer.getInventoryItem('acidesulfurique').count,
		xPlayer.getInventoryItem('antigel').count,
		xPlayer.getInventoryItem('pelle').count,
		xPlayer.getInventoryItem('terre').count,
		xPlayer.getInventoryItem('crystaldemeth').count,
		xPlayer.getInventoryItem('methbrick').count,
		xPlayer.getInventoryItem('chanvre').count,
		xPlayer.getInventoryItem('weedbrick').count,
		xPlayer.job.name,
		currentZone
	)
end)