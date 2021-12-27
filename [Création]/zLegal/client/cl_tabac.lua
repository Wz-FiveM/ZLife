local PlayerData = {}
local GUI = {}
GUI.Time = 0
local HasAlreadyEnteredMarker = false
local LastZone = nil
local CurrentAction = nil
local CurrentActionMsg = ''
local CurrentActionData = {}
local OnJob = true
local jobonlycarpen = true


ESX = nil

Citizen.CreateThread(function()
	while ESX == nil do
		TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
		Citizen.Wait(0)
	end

	while ESX.GetPlayerData().job == nil do
		Citizen.Wait(100)
	end

	ESX.PlayerData = ESX.GetPlayerData()
end)





RegisterNetEvent('esx:playerLoaded')
AddEventHandler('esx:playerLoaded', function(xPlayer)
	ESX.PlayerData = xPlayer
end)

RegisterNetEvent('esx:setJob')
AddEventHandler('esx:setJob', function(job)
	ESX.PlayerData.job = job
end)


local poscircuittabac = {
	{x = -105.3956, y = 1910.014, z = 196.946},
	{x = 202.8612, y = 2460.7333, z = 55.706},
	{x = -563.7114, y = 301.7722, z = 83.1451}
}

Citizen.CreateThread(function()
    if ESX.PlayerData.job.name == 'tabac' then
        for k in pairs(poscircuittabac) do
            local blip = AddBlipForCoord(poscircuittabac[k].x, poscircuittabac[k].y, poscircuittabac[k].z)
            SetBlipSprite(blip, 1)
            SetBlipAsShortRange(blip, true)
            SetBlipScale(blip, 0.6)
            SetBlipColour(blip, 0)
            BeginTextCommandSetBlipName("STRING")
            AddTextComponentString("Circuit Tabac")
            EndTextCommandSetBlipName(blip)
        end
    end
end)

local postabac = {
	{x = 814.489, y = -93.538, z = 80.5990}
}

Citizen.CreateThread(function()
    for k in pairs(postabac) do
	local blip = AddBlipForCoord(postabac[k].x, postabac[k].y, postabac[k].z)
	SetBlipSprite(blip, 140)
	SetBlipAsShortRange(blip, true)
	SetBlipScale(blip, 0.7)
	SetBlipColour(blip, 0)
	BeginTextCommandSetBlipName("STRING")
	AddTextComponentString("Tabac")
    EndTextCommandSetBlipName(blip)
    end
end)


AddEventHandler('clp_Tabac:hasEnteredMarkerTabac', function(zone)
    if ESX.PlayerData.job.name == "tabac" then
        if zone == 'TabacActions' then
            CurrentAction = 'Tabac_actions_menu'
            CurrentActionMsg = 'Appuyez sur ~INPUT_CONTEXT~ pour ~g~discuter'
            CurrentActionData = {}
        elseif zone == 'HarvestTabac' and not isNight() then
            CurrentAction = 'Tabac_harvest_menu'
            CurrentActionMsg = "Appuyez sur ~INPUT_CONTEXT~ pour ~g~commencer"
            CurrentActionData = {}
        elseif zone == 'TabacCraft2' then
            CurrentAction = 'Tabac_craft_menu2'
            CurrentActionMsg = "Appuyez sur ~INPUT_CONTEXT~ pour ~g~commencer"
            CurrentActionData = {}
        elseif zone == 'TabacSellFarm' then
            CurrentAction = 'Tabac_sell_menu'
            CurrentActionMsg = "Appuyez sur ~INPUT_CONTEXT~ pour ~g~commencer"
            CurrentActionData = {zone = zone}
        elseif zone == 'VehicleTabacDeleter' then
            local playerPed = GetPlayerPed(-1)
            if IsPedInAnyVehicle(playerPed,  false) then
                CurrentAction = 'delete_Tabac_vehicle'
                CurrentActionMsg = 'Appuyez sur ~INPUT_CONTEXT~ pour ~r~ranger le véhicule'
                CurrentActionData = {}
            end
        end
    end
end)

AddEventHandler('clp_Tabac:hasExitedMarkerTabac', function(zone)
    if ESX.PlayerData.job.name == "tabac" then
        if zone == 'TabacCraft2' then
            TriggerServerEvent('clp_Tabac:stopCraftTabac2')
            TriggerServerEvent('clp_Tabac:stopCraftTabac3')
            ESX.DrawMissionText("~r~Vous avez quitté la zone.", 3800)
        elseif zone == 'HarvestTabac' then
            TriggerServerEvent('clp_Tabac:stopHarvestTabac')
            ESX.DrawMissionText("~r~Vous avez quitté la zone.", 3800)
        elseif zone == 'TabacSellFarm' then
            TriggerServerEvent('clp_Tabac:stopSellTabac')
            ESX.DrawMissionText("~r~Vous avez quitté la zone.", 3800)
        end
        CurrentAction = nil
    end
end)


Citizen.CreateThread(function()
	while true do		
		local attente = 500
		local coords = GetEntityCoords(GetPlayerPed(-1))
		for k,v in pairs(Config.ZonesTabac) do
            if ESX.PlayerData.job.name == "tabac" then
                if(v.Type ~= -1 and GetDistanceBetweenCoords(coords, v.Pos.x, v.Pos.y, v.Pos.z, true) < 10) and not IsPedInAnyVehicle(GetPlayerPed(-1), false) then
                    attente = 1
                    DrawMarker(v.Type, v.Pos.x, v.Pos.y, v.Pos.z, 0.0, 0.0, 0.0, 0, 0.0, 0.0, v.Size.x, v.Size.y, v.Size.z, 0, 121, 255, 100, false, true, 2, false, false, false, false)
                elseif IsPedInAnyVehicle(GetPlayerPed(-1), false) then 
                    attente = 2500
                end
            else
                attente = 2500
            end
		end
		Wait(attente)
	end
end)

Citizen.CreateThread(function()
	while true do
		local attente = 500
			local coords = GetEntityCoords(GetPlayerPed(-1))
			local isInMarker = false
			local currentZone = nil
			for k,v in pairs(Config.ZonesTabac) do
                if ESX.PlayerData.job.name == "tabac" then
                    if(GetDistanceBetweenCoords(coords, v.Pos.x, v.Pos.y, v.Pos.z, true) < 5.5) then
                        attente = 1
                        isInMarker = true
                        currentZone = k
                    end
                else 
                    attente = 1500
                end
			end
			if (isInMarker and not HasAlreadyEnteredMarker) or (isInMarker and LastZone ~= currentZone) then
                if ESX.PlayerData.job.name == "tabac" then
                    attente = 1
                    HasAlreadyEnteredMarker = true
                    LastZone = currentZone
                    TriggerEvent('clp_Tabac:hasEnteredMarkerTabac', currentZone)
                else
                    attente = 500
                end
			end
			if not isInMarker and HasAlreadyEnteredMarker then
                if ESX.PlayerData.job.name == "tabac" then
                    attente = 1
                    HasAlreadyEnteredMarker = false
                    TriggerEvent('clp_Tabac:hasExitedMarkerTabac', LastZone)
                else
                    attente = 500
                end
			end
		Wait(attente)
	end
end)

Citizen.CreateThread(function()
    while true do
        Citizen.Wait(5)
        if ESX.PlayerData.job.name == "tabac" then
            if CurrentAction ~= nil then
                SetTextComponentFormat('STRING')
                AddTextComponentString(CurrentActionMsg)
                DisplayHelpTextFromStringLabel(0, 0, 0, -1)
                if IsControlJustReleased(0, 38) then

                    if CurrentAction == 'Tabac_actions_menu' and not IsPedSittingInAnyVehicle(GetPlayerPed(-1)) then
                        OpenTabacActionsMenu()
                    elseif CurrentAction == 'Tabac_harvest_menu' and not IsPedSittingInAnyVehicle(GetPlayerPed(-1)) then
                        Citizen.Wait(5000)
                        TriggerServerEvent('clp_Tabac:startHarvestTabac')
                    elseif CurrentAction == 'boss_Tabac_actions_menu' then
                        OpenBossTabacActionsMenu()
                    elseif CurrentAction == 'Tabac_craft_menu' and not IsPedSittingInAnyVehicle(GetPlayerPed(-1)) then
                        Citizen.Wait(5000)
                        TriggerServerEvent('clp_Tabac:startCraftTabac')
                    elseif CurrentAction == 'Tabac_craft_menu2' and not IsPedSittingInAnyVehicle(GetPlayerPed(-1)) then
                        Citizen.Wait(5000)
                        TriggerServerEvent('clp_Tabac:startCraftTabac2')
                    elseif CurrentAction == 'Tabac_sell_menu' and not IsPedSittingInAnyVehicle(GetPlayerPed(-1)) then
                        Citizen.Wait(5000)
                        TriggerServerEvent('clp_Tabac:startSellTabac', CurrentActionData.zone)
                    elseif CurrentAction == 'Tabac_sell_menu2' and not IsPedSittingInAnyVehicle(GetPlayerPed(-1)) then
                        Citizen.Wait(5000)
                        TriggerServerEvent('clp_Tabac:startSellTabac2', CurrentActionData.zone)
                    elseif CurrentAction == 'delete_Tabac_vehicle' then
                        local playerPed = GetPlayerPed(-1)
                        local vehicle = GetVehiclePedIsIn(playerPed,  false)
                        local hash = GetEntityModel(vehicle)
                        local plate = GetVehicleNumberPlateText(vehicle)
                        if hash == GetHashKey('burrito4') then
                            if Config.MaxInService ~= -1 then
                            TriggerServerEvent('esx_service:disableService', 'Tabac')
                            end
                            TriggerEvent('persistent-vehicles/forget-vehicle', vehicle)
                            Wait(50)
                            DeleteVehicle(vehicle)
                            TriggerServerEvent('esx_vehiclelock:deletekeyjobs', 'no', plate) --vehicle lock
                        else
                            ESX.ShowNotification('~r~Vous ne pouvez ranger que des véhicules du Tabac.')
                        end
                    end
                    CurrentAction = nil               
                end
            end
        else
            attente = 1500	
        end
    end
end)