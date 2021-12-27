ActionsCars = ActionsCars or {}
ActionsCars.Notif = nil
ActionsCars.Regular = false
ActionsCars.Auto = false

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

RegisterNetEvent("zHayes:ActionOnVehicles")
AddEventHandler("zHayes:ActionOnVehicles", function(data, door)
	local player = PlayerPedId()
	local pPed = player
	local pVeh = GetVehiclePedIsIn(player, false)
	
	if not IsPedInAnyVehicle(player, false) then return ESX.ShowNotification("~r~Vous devez être dans un véhicule.") end 

	if data == 1 then 
		if GetIsVehicleEngineRunning(pVeh) then 
			SetVehicleEngineOn(pVeh, false, false, true)
			SetVehicleUndriveable(pVeh, true)
		else
			SetVehicleEngineOn(pVeh, true, false, true)
			SetVehicleUndriveable(pVeh, false)
		end
	elseif data == 2 then 
		if ActionsCars.Notif then RemoveNotification(ActionsCars.Notif) end
		ActionsCars.Notif = ESX.ShowNotification("État de votre moteur: ~b~"..GetVehicleHealth(pVeh).."%~s~.")
	elseif data == 3 then 
		if ActionsCars.Regular then 
			if ActionsCars.Notif then RemoveNotification(ActionsCars.Notif) end
			ActionsCars.Notif = ESX.ShowNotification("Vous avez ~r~désactivé~s~ le régulateur de vitesse.")
			SetEntityMaxSpeed(pVeh, 1000.0)
			ActionsCars.Regular = false 
		elseif not ActionsCars.Regular then
			if ActionsCars.Notif then RemoveNotification(ActionsCars.Notif) end
			ActionsCars.Notif = ESX.ShowNotification("Vous avez ~b~activé~s~ le régulateur de vitesse à: ~b~"..math.floor(GetEntitySpeed(pVeh) * 3.6).."Km/h~s~.")
			SetEntityMaxSpeed(pVeh, GetEntitySpeed(pVeh))
			ActionsCars.Regular = true
		end
	elseif data == 4 then 
		local blip = GetFirstBlipInfoId(8)
		local blipInfo = 0
		if blip == 0 or not blip then ESX.ShowNotification("~r~Vous devez placer un marqueur sur la carte.") return end
		if not ActionsCars.Auto then 
			ActionsCars.Auto = true 
			blipInfo = GetBlipInfoIdCoord(blip)
			TaskVehicleDriveToCoordLongrange(pPed, pVeh, blipInfo, 25.0, 1076369579, 10.0)
		elseif ActionsCars.Auto then 
			ActionsCars.Auto = false
			ClearPedTasks(pPed)
		end
		if ActionsCars.Notif then RemoveNotification(ActionsCars.Notif) end
		ActionsCars.Notif = ESX.ShowNotification("Vous avez " .. (ActionsCars.Auto and "~b~activé" or "~r~désactivé") .."~s~ la conduite automatique.")
		Citizen.CreateThread(function()
			while ActionsCars.Auto do 
				local dist = Vdist(GetEntityCoords(player), blipInfo)
				if dist <= 50 then 
					ESX.ShowNotification("Vous êtes ~b~arrivé~s~ à destination.")
					ActionsCars.Auto = false
					ClearPedTasks(pPed)
				end
				Wait(500)
			end
		end)
	elseif data == 5 or data == 6 or data == 7 or data == 8 or data == 9 or data == 10 then 
		if GetVehicleDoorAngleRatio(pVeh, door.number) > 0.0 then
            if ActionsCars.Notif then RemoveNotification(ActionsCars.Notif) end
			ActionsCars.Notif = ESX.ShowNotification("Porte ~b~"..door.name.."~s~ fermées.")
            SetVehicleDoorShut(pVeh, door.number, false)
        else
            if ActionsCars.Notif then RemoveNotification(ActionsCars.Notif) end
			ActionsCars.Notif = ESX.ShowNotification("Porte ~b~"..door.name.."~s~ ouvertes.")
            SetVehicleDoorOpen(pVeh, door.number, false)
        end
	end
end)