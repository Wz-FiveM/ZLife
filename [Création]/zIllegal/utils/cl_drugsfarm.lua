ESX 			    			= nil
local cokeQTE       			= 0
local acidesulfuriqueQTE       	= 0
local antigelQTE				= 0
local terreQTE				= 0
local pelleQTE					= 0
local coke_poochQTE 			= 0
local weedQTE					= 0
local weed_poochQTE 			= 0
local methQTE					= 0
local meth_poochQTE 			= 0
local opiumQTE					= 0
local opium_poochQTE 			= 0
local myJob 					= nil
local HasAlreadyEnteredMarker   = false
local LastZone                  = nil
local isInZone                  = false
local CurrentAction             = nil
local CurrentActionMsg          = ''
local CurrentActionData         = {}
local prop_name = 'prop_ld_shovel'
local DVs8kf2w="scr_reburials"
local playerPed = GetPlayerPed(-1)
local pelle = false
local inVeh = IsPedInAnyVehicle(GetPlayerPed(-1), false)

Citizen.CreateThread(function()
	while ESX == nil do
		TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
		Citizen.Wait(0)
	end
end)


AddEventHandler('c_drugs:hasEnteredMarker', function(zone)
	if myJob == 'police' or myJob == 'sheriff' then
		return
	end
	
	if zone == 'exitMarker' and not isNightDrugs() then
		CurrentAction     = zone
		CurrentActionMsg  = "Appuyez sur ~INPUT_CONTEXT~ pour ~r~arrêter"
		CurrentActionData = {}	
	elseif zone == 'CokeField' and not inVeh then
		--if acidesulfuriqueQTE  >= 2 then 
		CurrentAction     = zone
		CurrentActionMsg  = "Appuyez sur ~INPUT_CONTEXT~ pour ~g~commencer"
		CurrentActionData = {}
		--end
	elseif zone == 'TerreField' and not inVeh then 
		if pelleQTE >= 1 then
		CurrentAction     = zone
		CurrentActionMsg  = "Appuyez sur ~INPUT_CONTEXT~ pour ~g~commencer"
		CurrentActionData = {}
		end
	elseif zone == 'AcideField' and not inVeh then 
		CurrentAction     = zone
		CurrentActionMsg  = "Appuyez sur ~INPUT_CONTEXT~ pour ~g~commencer"
		CurrentActionData = {}
	elseif zone == 'AntigelField' and not inVeh then 
		CurrentAction     = zone
		CurrentActionMsg  = "Appuyez sur ~INPUT_CONTEXT~ pour ~g~commencer"
		CurrentActionData = {}
	elseif zone == 'MethField' and not inVeh then
		if antigelQTE >= 2 then 
			CurrentAction     = zone
			CurrentActionMsg  = "Appuyez sur ~INPUT_CONTEXT~ pour ~g~commencer"
			CurrentActionData = {}
		end
	elseif zone == 'WeedField' and not inVeh then
		if terreQTE >= 2 then
		CurrentAction     = zone
		CurrentActionMsg  = "Appuyez sur ~INPUT_CONTEXT~ pour ~g~commencer"
		CurrentActionData = {}
		end
	end
end)

AddEventHandler('c_drugs:hasExitedMarker', function(zone)
	CurrentAction = nil
	ESX.UI.Menu.CloseAll()

	if zone == 'CokeField' then
		ClearPedTasks(GetPlayerPed(-1))
		TriggerServerEvent('c_drugs:stopHarvestCoke')
	elseif zone == 'AcideField' then 
		ClearPedTasks(GetPlayerPed(-1))
		TriggerServerEvent('c_drugs:stopHarvestAcide')
	elseif zone == 'AntigelField' then
		ClearPedTasks(GetPlayerPed(-1))
		TriggerServerEvent('c_drugs:stopHarvestAntigel')
	elseif zone == 'CokeProcessing' then
		ClearPedTasks(GetPlayerPed(-1))
		TriggerServerEvent('c_drugs:stopTransformCoke')
	elseif zone == 'MethField' then
		ClearPedTasks(GetPlayerPed(-1))
		TriggerServerEvent('c_drugs:stopHarvestMeth')
	elseif zone == 'MethProcessing' then
		ClearPedTasks(GetPlayerPed(-1))
		TriggerServerEvent('c_drugs:stopTransformMeth')
	elseif zone == 'WeedField' then
		ClearPedTasks(GetPlayerPed(-1))
		TriggerServerEvent('c_drugs:stopHarvestWeed')
	elseif zone == 'WeedProcessing' then
		ClearPedTasks(GetPlayerPed(-1))
		TriggerServerEvent('c_drugs:stopTransformWeed')
	end
end)

RegisterNetEvent('c_drugs:ReturnInventory')
AddEventHandler('c_drugs:ReturnInventory', function(cokeNbr, cokepNbr, acidesulfuriqueQTENbr, antigelQTENbr, pelleQTENbr, terreQTENbr, methNbr, methpNbr, weedNbr, weedpNbr, jobName, currentZone)
	cokeQTE	   = cokeNbr
	coke_poochQTE = cokepNbr
	acidesulfuriqueQTE = acidesulfuriqueQTENbr
	antigelQTE = antigelQTENbr
	pelleQTE = pelleQTENbr
	terreQTE = terreQTENbr
	methQTE 	  = methNbr
	meth_poochQTE = methpNbr
	weedQTE 	  = weedNbr
	weed_poochQTE = weedpNbr
	myJob		 = jobName
	TriggerEvent('c_drugs:hasEnteredMarker', currentZone)
end)

-- Activate menu when player is inside marker
Citizen.CreateThread(function()
	while true do		
		local attente = 250

		local coords      = GetEntityCoords(GetPlayerPed(-1))
		local isInMarker  = false
		local currentZone = nil

		for k,v in pairs(Config.Zones) do
			if(GetDistanceBetweenCoords(coords, v.x, v.y, v.z, true) < 7.0) and not inVeh then
				attente = 1
				isInMarker  = true
				currentZone = k
			elseif IsPedInAnyVehicle(GetPlayerPed(-1), false) then 
				attente = 2500
			end
		end

		if isInMarker and not hasAlreadyEnteredMarker then
			attente = 1
			hasAlreadyEnteredMarker = true
			lastZone				= currentZone
			TriggerServerEvent('c_drugs:GetUserInventory', currentZone)
		end

		if not isInMarker and hasAlreadyEnteredMarker then
			attente = 1
			hasAlreadyEnteredMarker = false
			TriggerEvent('c_drugs:hasExitedMarker', lastZone)
		end

		if isInMarker and isInZone then
			attente = 1
			TriggerEvent('c_drugs:hasEnteredMarker', 'exitMarker')
		end
		Wait(attente)
	end
end)


-- Key Controls
Citizen.CreateThread(function()
	while true do
		local attente = 250
		if CurrentAction ~= nil then
			attente = 1
			SetTextComponentFormat('STRING')
			AddTextComponentString(CurrentActionMsg)
			DisplayHelpTextFromStringLabel(0, 0, false, -1)
			if IsControlJustPressed(1, 51) then
				isInZone = true 
				if CurrentAction == 'exitMarker' then
					isInZone = false 
					ESX.ShowNotification("~r~Vous avez abandonné.")
					TriggerEvent('c_drugs:hasExitedMarker', lastZone)
				elseif CurrentAction == 'CokeField' and not inVeh then

					if not isNightDrugs() then 
						ShowAboveRadarMessage('~r~Les vannes sont fermées à cette heure.') 
					else
						TriggerEvent("randPickupAnim")
						TriggerServerEvent('c_drugs:startHarvestCoke')
						Citizen.Wait(5000)
					end
				elseif CurrentAction == 'AcideField' and not inVeh then 

					if not isNightDrugs() then 
						ShowAboveRadarMessage('~r~Les vannes sont fermées à cette heure.') 
					else
						TriggerEvent("randPickupAnim")
						TriggerServerEvent('c_drugs:startHarvestAcide')
						Citizen.Wait(3500)
					end
				elseif CurrentAction == 'AntigelField' and not inVeh then 

					if not isNightDrugs() then 
						ShowAboveRadarMessage('~r~Les vannes sont fermées à cette heure.') 
					else
						TriggerEvent("randPickupAnim")
						TriggerServerEvent('c_drugs:startHarvestAntigel')
						Citizen.Wait(3500)
					end
					
				elseif CurrentAction == 'CokeProcessing' and not inVeh then

					if not isNightDrugs() then 
						ShowAboveRadarMessage('~r~Les vannes sont fermées à cette heure.') 
					else
						TriggerEvent("randPickupAnim")
						TriggerServerEvent('c_drugs:startTransformCoke')
						Citizen.Wait(65000)
					end
					
				elseif CurrentAction == 'CokeDealer' and not inVeh then

					if not isNightDrugs() then 
						ShowAboveRadarMessage('~r~Les vannes sont fermées à cette heure.') 
					else
						TriggerEvent("randPickupAnim")
						TriggerServerEvent('c_drugs:startSellCoke')
					end
					
				elseif CurrentAction == 'MethField' and not inVeh then

					if not isNightDrugs() then 
						ShowAboveRadarMessage('~r~Les vannes sont fermées à cette heure.') 
					else
						TriggerEvent("randPickupAnim")
						TriggerServerEvent('c_drugs:startHarvestMeth')
						Citizen.Wait(5000)
					end
					
				elseif CurrentAction == 'MethProcessing' and not inVeh then
					if not isNightDrugs() then 
						ShowAboveRadarMessage('~r~Les vannes sont fermées à cette heure.') 
					else
						TriggerEvent("randPickupAnim")
						TriggerServerEvent('c_drugs:startTransformMeth')
						Citizen.Wait(65000)
					end
				elseif CurrentAction == 'MethDealer' and not inVeh then

					if not isNightDrugs() then 
						ShowAboveRadarMessage('~r~Les vannes sont fermées à cette heure.') 
					else
						TriggerEvent("randPickupAnim")
						TriggerServerEvent('c_drugs:startSellMeth')
					end
				elseif CurrentAction == 'WeedField' and not inVeh then

					if not isNightDrugs() then 
						ShowAboveRadarMessage('~r~Les vannes sont fermées à cette heure.') 
					else
						TriggerEvent("randPickupAnim")
						TriggerServerEvent('c_drugs:startHarvestWeed')
						Citizen.Wait(5000)
					end
				elseif CurrentAction == 'WeedProcessing' and not inVeh then

					if not isNightDrugs() then 
						ShowAboveRadarMessage('~r~Les vannes sont fermées à cette heure.') 
					else
						TriggerEvent("randPickupAnim")
						TriggerServerEvent('c_drugs:startTransformWeed')
						Citizen.Wait(65000)
					end
				elseif CurrentAction == 'WeedDealer' and not inVeh then

					if not isNightDrugs() then 
						ShowAboveRadarMessage('~r~Les vannes sont fermées à cette heure.') 
					else
						TriggerEvent("randPickupAnim")
						TriggerServerEvent('c_drugs:startSellWeed')
					end
					
				else
					isInZone = false -- not a c_drugs zone
				end
				
				CurrentAction = nil
			end
		end
		Wait(attente)
	end
end)

local dirtsZones = {"TONGVAH", "GRAPES"}
local allowedDirts = {3008270349, 3833216577, 1333033863, 1109728704, 3594309083, 1144315879, 2128369009, 223086562, 1584636462, -700658213}
local goodDirts = {1109728704, 3594309083}
local orpillageZone = {"TONGVAV", "TATAMO", "ZANCUDO", "CCREAK", "ARMYB", "LAGO"}
local pCoords = GetEntityCoords(GetPlayerPed(-1))
local enpelle = false
local pellebroken = 0

local function CanPlayerOrpiller(Player)
    local ped = GetPlayerPed(-1)
    return tableHasValue(orpillageZone, GetNameOfZone(pCoords.x,pCoords.y,pCoords.z)) and IsEntityInWater(ped) and not IsPedSwimming(ped) and IsPedStill(ped)
end

local shovelModel = GetHashKey("prop_ld_shovel")
local animDict = "random@burial"
local B6zKxgVs,O3_X2=0,60*1000*0.27

local function UseShovel(Player)
	ESX.AddTimerBar("TEMPS RESTANT :",{endTime=GetGameTimer()+O3_X2})
	enpelle = true
	ExecuteCommand('me utilise sa Pelle')
	pellebroken = pellebroken + 1
    local pos, ped = GetEntityCoords(GetPlayerPed(-1)), GetPlayerPed(-1)
    local weaponUsed = GetCurrentPedWeapon(ped)
	RequestAndWaitDict(animDict)
	RequestAndWaitModel(shovelModel)
	local playerPed = GetPlayerPed(-1)
	local shovel = CreateObject(shovelModel, GetEntityCoords(playerPed), true, false, true)
	SetNetworkIdCanMigrate(ObjToNet(shovel), false)
    SetModelAsNoLongerNeeded(shovelModel)
	SetNetworkIdCanMigrate(NetworkGetNetworkIdFromEntity(shovel), false)
	SetCurrentPedWeapon(playerPed, GetHashKey("weapon_unarmed"), true)
	TaskPlayAnim(playerPed, animDict, "a_burial", 8.0, -4.0, -1, 0, 0, 0, 0, 0)
	AttachEntityToEntity(shovel, playerPed, GetPedBoneIndex(playerPed, 28422), 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0, 0, 0, 0, 2, 1)
	local endTime = GetGameTimer() + GetAnimDuration(animDict, "a_burial") * 900
	local particleDict = "scr_reburials"
	RequestNamedPtfxAsset(particleDict)
	while not HasNamedPtfxAssetLoaded(particleDict) do
		Citizen.Wait(0)
	end
	while GetGameTimer() < endTime do
		if IsEntityPlayingAnim(playerPed, "random@burial", "a_burial", 3) then
			Citizen.Wait(250)
			UseParticleFxAssetNextCall(particleDict)
			StartNetworkedParticleFxNonLoopedOnEntity("scr_burial_dirt", shovel, 0.0, 0.0, -0.95, 0.0, 180.0, 0.0, 1065353216, 0, 0, 0)
		end
		Citizen.Wait(0)
	end
	TaskPlayAnim(playerPed, animDict, "a_burial_stop", 8.0, -4.0, -1, 0, 0, 0, 0, 0)
	DetachEntity(shovel, 0, true)
	enpelle = false
	AttachEntityToEntity(shovel, playerPed, GetPedBoneIndex(playerPed, 28422), 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0, 0, 0, 0, 2, 1)
	UseParticleFxAssetNextCall(particleDict)
	StartNetworkedParticleFxNonLoopedOnEntity("scr_burial_dirt", shovel, 0.0, 0.0, -0.95, 0.0, 180.0, 0.0, 1065353216, 0, 0, 0)
	RemoveNamedPtfxAsset(particleDict)
	while GetEntityAnimCurrentTime(playerPed, "random@burial", "a_burial_stop") <= 0.275 do 
		Citizen.Wait(320) 
	end
	TriggerServerEvent('c_drugs:startHarvestTerre', 3)
	ShowAboveRadarMessage("Vous avez récupéré de la ~g~Terre~s~. (~b~+3~s~)")
    DeleteEntity(shovel)
	RemoveAnimDict(animDict)
	ESX.RemoveTimerBar()
    ClearPedTasks(ped)
	SetCurrentPedWeapon(ped, weaponUsed, true)
	if pellebroken >= 13 then 
		print("pelle broken")
		ShowAboveRadarMessage("~r~Votre pelle s'est brisé au niveau du manche.")
		pellebroken = 0
		TriggerServerEvent('pelle:broken')
	end
    return true
end

function UseShovelForDirt(Player)
    local pos, ped = GetEntityCoords(GetPlayerPed(-1)), GetPlayerPed(-1)
	local _, hit, _, _, material = GetShapeTestResultEx(CastRayPointToPoint(pos, pos - vector3(0.0, 0.0, 2.0), -1, ped))
	if not tableHasValue(allowedDirts, material) then ShowAboveRadarMessage("~r~Vous ne pouvez pas creuser ici.") 
		return 
	end
	if not UseShovel(Player) then 
		return 
	end
end

RegisterNetEvent('commencercreuserverif') 
AddEventHandler('commencercreuserverif', function()
	local Player = GetPlayerPed(-1)
	local ped = GetPlayerPed(-1)
	if IsPedStill(ped) then
		if not enpelle then 
			UseShovelForDirt(Player)
		end
	end
end)