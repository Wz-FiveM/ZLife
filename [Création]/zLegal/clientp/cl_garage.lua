local Keys = {
	["ESC"] = 322, ["F1"] = 288, ["F2"] = 289, ["F3"] = 170, ["F5"] = 166, ["F6"] = 167, ["F7"] = 168, ["F8"] = 169, ["F9"] = 56, ["F10"] = 57, 
	["~"] = 243, ["1"] = 157, ["2"] = 158, ["3"] = 160, ["4"] = 164, ["5"] = 165, ["6"] = 159, ["7"] = 161, ["8"] = 162, ["9"] = 163, ["-"] = 84, ["="] = 83, ["BACKSPACE"] = 177, 
	["TAB"] = 37, ["Q"] = 44, ["W"] = 32, ["E"] = 38, ["R"] = 45, ["T"] = 245, ["Y"] = 246, ["U"] = 303, ["P"] = 199, ["["] = 39, ["]"] = 40, ["ENTER"] = 18,
	["CAPS"] = 137, ["A"] = 34, ["S"] = 8, ["D"] = 9, ["F"] = 23, ["G"] = 47, ["H"] = 74, ["K"] = 311, ["L"] = 182,
	["LEFTSHIFT"] = 21, ["Z"] = 20, ["X"] = 73, ["C"] = 26, ["V"] = 0, ["B"] = 29, ["N"] = 249, ["M"] = 244, [","] = 82, ["."] = 81,
	["LEFTCTRL"] = 36, ["LEFTALT"] = 19, ["SPACE"] = 22, ["RIGHTCTRL"] = 70, 
	["HOME"] = 213, ["PAGEUP"] = 10, ["PAGEDOWN"] = 11, ["DELETE"] = 178,
	["LEFT"] = 174, ["RIGHT"] = 175, ["TOP"] = 27, ["DOWN"] = 173,
	["NENTER"] = 201, ["N4"] = 108, ["N5"] = 60, ["N6"] = 107, ["N+"] = 96, ["N-"] = 97, ["N7"] = 117, ["N8"] = 61, ["N9"] = 118
}

local CurrentAction = nil
local GUI                       = {}
GUI.Time                        = 0
local HasAlreadyEnteredMarker   = false
local LastZone                  = nil
local CurrentActionMsg          = ''
local CurrentActionData         = {}
local times 					= 0

local HealthBodyVeh           = 1000
local TyreBurst               = true
local etat					  = nil

local this_Garage = {}

ESX = nil

Citizen.CreateThread(function()
	while ESX == nil do
		TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
		Citizen.Wait(0)
	end
end)

local poscarpounds = {
	{x = 1737.92,  y = 3709.12,  z = 34.12, spawn = {x = 1722.8,  y = 3713.44,  z = 34.2-0.80}, heading = 20.89, nameblip = "Fourrière véhicule", blip = 326},
	{x = -368.4,  y = -101.04,  z = 39.56, spawn = {x = -367.08,  y = -109.08,  z = 38.68-0.80}, heading = 251.92, nameblip = "Fourrière véhicule", blip = 326},
	{x = -1604.76,  y = 5256.68,  z = 2.08, spawn = {x = -1601.44,  y = 5260.76,  z = 0.12-0.80}, heading = 24.00, nameblip = "Fourrière bateaux", blip = 410},
	{x = 2141.44,  y = 4788.96,  z = 40.96, spawn = {x = 2114.16,  y = 4802.4,  z = 41.16-0.80}, heading = 114.61, nameblip = "Fourrière avions", blip = 423},
	{x = -753.52,  y = -1512.24,  z = 5.0, spawn = {x = -745.36,  y = -1468.48,  z = 5.0-0.80}, heading = 140.11, nameblip = "Fourrière hélicoptères", blip = 64},
}

Citizen.CreateThread(function()
    while true do
        local attente = 500

        for k in pairs(poscarpounds) do

            local plyCoords = GetEntityCoords(GetPlayerPed(-1), false)
            local dist = Vdist(plyCoords.x, plyCoords.y, plyCoords.z, poscarpounds[k].x, poscarpounds[k].y, poscarpounds[k].z)

			if dist <= 2.0 and not IsPedInAnyVehicle(GetPlayerPed(-1), false) then 
				attente = 10
				DrawText3D(poscarpounds[k].x, poscarpounds[k].y, poscarpounds[k].z, "Appuyez sur ~b~E ~w~pour ~b~accéder à la fourrière.", 9)
				if IsControlJustPressed(1,51) then 
					ReturnOwnedCarsMenu(poscarpounds[k].spawn.x,poscarpounds[k].spawn.y,poscarpounds[k].spawn.z, poscarpounds[k].heading)
				end
			elseif IsPedInAnyVehicle(GetPlayerPed(-1), false) then 
				attente = 2500
			end
		end
		Wait(attente)
    end
end)

Citizen.CreateThread(function()
    for k in pairs(poscarpounds) do
		local blip = AddBlipForCoord(poscarpounds[k].x, poscarpounds[k].y, poscarpounds[k].z)
		SetBlipSprite(blip, poscarpounds[k].blip)
		SetBlipColour(blip, 26)
		SetBlipScale(blip, 0.7)
		SetBlipAsShortRange(blip, true)
		BeginTextCommandSetBlipName("STRING")
		AddTextComponentString(poscarpounds[k].nameblip)
		EndTextCommandSetBlipName(blip)
    end
end)

function ReturnOwnedCarsMenu(spawnx,spawny,spawnz, heading)
	ESX.TriggerServerCallback('esx_advancedgarage:getOutOwnedCars', function(ownedCars)
		local elements = {}
	
		for _,v in pairs(ownedCars) do
			local hashVehicule = v.model
			local vehicleName = GetDisplayNameFromVehicleModel(hashVehicule)
			local plate = v.plate
			local labelvehicle
			
			labelvehicle = 'Nom : '..vehicleName..' / Plaque : '..plate..' <span style="color:;"> (250$)'
			
			table.insert(elements, {label = labelvehicle, value = v})
		end

		ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'return_owned_car', {
			css = 'fourriere',
			title = "Fourrière",
			align = 'top-left',
			elements = elements
		}, function(data, menu)
			ESX.TriggerServerCallback('esx_advancedgarage:checkMoneyCars', function(hasEnoughMoney)
				if hasEnoughMoney then
					if not IsAnyVehicleNearPoint(spawnx, spawny, spawnz,5.0) then 
						TriggerServerEvent('esx_advancedgarage:payCar')
						SpawnPoundedVehicle(data.current.value, data.current.value.plate, spawnx,spawny,spawnz, heading)
						ESX.UI.Menu.CloseAll()
					else 
						ESX.ShowNotification("Vous ne pouvez pas sortir le véhicule du garage.\n~r~Il y a un véhicule devant l'entrée.")
					end
				else
					ESX.ShowNotification("~r~Vous n'avez pas assez d'argent.")
				end
			end)
		end, function(data, menu)
			menu.close()
		end)
	end)
end

function SpawnPoundedVehicle(vehicle, plate, spawnx,spawny,spawnz, heading)
	ESX.Game.SpawnVehicle(vehicle.model, {
		x = spawnx,
		y = spawny,
		z = spawnz
	}, heading, function(callback_vehicle)
		ESX.Game.SetVehicleProperties(callback_vehicle, vehicle)
		SetVehRadioStation(callback_vehicle, "OFF")
		SetVehicleFixed(vehicle)
		SetVehicleUndriveable(vehicle, false)
		SetVehicleEngineOn(vehicle, true, true)
	end)
	ESX.ShowNotification("~g~Vous venez de récupérer votre ~b~véhicule ~g~immatriculé : ~b~"..vehicle.plate)
	TriggerServerEvent('esx_advancedgarage:setVehicleState', plate, false)
end