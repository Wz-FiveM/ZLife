function sortirvoiture(vehicle, plate)
	x,y,z = table.unpack(GetEntityCoords(GetPlayerPed(-1),true))

	ESX.Game.SpawnVehicle(vehicle.model, {
		x = x,
		y = y,
		z = z 
	}, GetEntityHeading(PlayerPedId()), function(callback_vehicle)
		ESX.Game.SetVehicleProperties(callback_vehicle, vehicle)
		SetVehRadioStation(callback_vehicle, "OFF")
		SetVehicleFixed(callback_vehicle)
		SetVehicleDeformationFixed(callback_vehicle)
		SetVehicleUndriveable(callback_vehicle, false)
		SetVehicleEngineOn(callback_vehicle, true, true)
		TaskWarpPedIntoVehicle(GetPlayerPed(-1), callback_vehicle, -1)
	end)

	TriggerServerEvent('wGarage:etatvehiculesortie', plate, false)
end


function etatvehicle(vehicle, vehicleProps)
	ESX.Game.DeleteVehicle(vehicle)
	TriggerServerEvent('wGarage:etatvehiculesortie', vehicleProps.plate, true)
	ESX.ShowNotification('Ton véhicule est ranger dans le garage.')
end


--ranger voiture
function StockVehicle()
	local playerPed  = GetPlayerPed(-1)
	if IsPedInAnyVehicle(playerPed,  false) then
		local playerPed    = GetPlayerPed(-1)
		local coords       = GetEntityCoords(playerPed)
		local vehicle      = GetVehiclePedIsIn(playerPed, false)
		local vehicleProps = ESX.Game.GetVehicleProperties(vehicle)
		local current 	   = GetPlayersLastVehicle(GetPlayerPed(-1), true)
		local engineHealth = GetVehicleEngineHealth(current)
		local plate        = vehicleProps.plate

		ESX.TriggerServerCallback('wGarage:rangervoiture', function(valid)
			if valid then
                etatvehicle(vehicle, vehicleProps)
			else
                Visual.Popup('Impossible de ranger ce véhicule', 2000)
			end
		end, vehicleProps)
	else
        --Visual.Prompt('Pas de véhicule à ranger', 1)
        ESX.ShowNotification('~b~Garage~s~~n~Pas de véhicule à ranger')
	end
end


RegisterCommand("co", function(source, args, rawcommand)
    local p = GetEntityCoords(PlayerPedId())
    print(p.x..", "..p.y..", "..p.z.."   |  "..GetEntityHeading(PlayerPedId()))
end, false)