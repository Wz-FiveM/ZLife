ESX = nil
local PlayerData = {}

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


local interval = 1500

Citizen.CreateThread(function()
	while true do
        interval = 150
        local plyCoords = GetEntityCoords(GetPlayerPed(-1), false)
        local dist = Vdist(plyCoords.x, plyCoords.y, plyCoords.z, -788.831, -216.3922, 37.0796)

		if dist <= 8.0 then
            if ESX.PlayerData.job.name == "cardealer" and ESX.PlayerData.job.grade_name == "boss" then
			    interval = 0
			    DrawMarker(25, -788.831, -216.3922, 37.0796-0.98, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 1.0, 1.0, 1.0, 255, 255, 0, 100)
            end
		end

		if dist <= 1.5 then
            if ESX.PlayerData.job.name == "cardealer" and ESX.PlayerData.job.grade_name == "boss" then
                interval = 0
                if IsControlJustPressed(0, 51) then
                    TriggerEvent('esx_society:openBossMenu', 'cardealer', function(data, menu) end)
                end
            end
		end
		Citizen.Wait(interval)
	end
end)