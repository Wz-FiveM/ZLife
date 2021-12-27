Citizen.CreateThread(function()
	local hudEnabled = false
	local PlayerPedId, GetVehiclePedIsIn, GetIsVehicleEngineRunning, GetVehicleIndicatorLights, GetVehicleLightsState, SendNUIMessage, GetEntitySpeed, GetVehicleFuelLevel = PlayerPedId, GetVehiclePedIsIn, GetIsVehicleEngineRunning, GetVehicleIndicatorLights, GetVehicleLightsState, SendNUIMessage, GetEntitySpeed, GetVehicleFuelLevel

	while true do
		local ped, waitTime = PlayerPedId(), 1000
		local veh = GetVehiclePedIsIn(ped)

		if GetPedInVehicleSeat(veh, -1) == ped and GetIsVehicleEngineRunning(veh) then
			hudEnabled = true
			waitTime = 100

			local _, positionLight, roadLight = GetVehicleLightsState(veh)

			SendNUIMessage({
				showhud = hudEnabled,
				speed = math.ceil(GetEntitySpeed(veh) * 3.6),
				feuPosition = positionLight == 1,
				feuRoute = roadLight == 1,
				clignotantDroite = false,
				clignotantGauche = false,
				fuel = GetVehicleFuelLevel(veh)
			})
		elseif hudEnabled then
			hudEnabled = false
			SendNUIMessage({ showhud = hudEnabled })
		end

		Citizen.Wait(waitTime)
	end
end)