ESX                           = nil

local PlayerData              = {}

Citizen.CreateThread(function ()
    while ESX == nil do
        TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
        Citizen.Wait(1)
    end

    while ESX.GetPlayerData() == nil do
        Citizen.Wait(10)
    end

    PlayerData = ESX.GetPlayerData()

    LoadMarkers()
end) 

RegisterNetEvent('esx:playerLoaded')
AddEventHandler('esx:playerLoaded', function(xPlayer)
    PlayerData = xPlayer
end)

RegisterNetEvent('esx:setjob')
AddEventHandler('esx:setjob', function(job)
    PlayerData.job = job
end)

local zonetp = {
    ['Ambulance'] = {
		['job'] = 'none',
		['Enter'] = { 
			['x'] = 339.39, 
			['y'] = -564.26, 
			['z'] = 28.74-0.98,
			['Information'] = '',
		},
		['Exit'] = {
			['x'] = 338.56, 
			['y'] = -583.92, 
			['z'] = 74.16, 
			['Information'] = '' 
		}
    },
    ['LostMc'] = {
		['job'] = 'none',
		['Enter'] = { 
			['x'] = 16.6, 
			['y'] = 3729.96, 
			['z'] = 39.68,
			['Information'] = '',
		},
		['Exit'] = {
			['x'] = 1121.0, 
			['y'] = -3152.48, 
			['z'] = -37.08, 
			['Information'] = '' 
		}
    },
    ['Unicorn'] = {
		['job'] = 'none',
		['Enter'] = { 
			['x'] = 132.72, 
			['y'] = -1294.04, 
			['z'] = 29.28,
			['Information'] = '',
		},
		['Exit'] = {
			['x'] = 132.48, 
			['y'] = -1287.44, 
			['z'] = 29.28, 
			['Information'] = '' 
		}
    },
    ['Avocat'] = {
		['job'] = 'none',
		['Enter'] = { 
			['x'] = -1912.08, 
			['y'] = -576.56, 
			['z'] = 18.16,
			['Information'] = '',
		},
		['Exit'] = {
			['x'] = -1910.48, 
			['y'] = -574.6, 
			['z'] = 18.16,
			['Information'] = '' 
		}
    },
    ['eglise1'] = {
		['job'] = 'none',
		['Enter'] = { 
			['x'] = -766.84, 
			['y'] = -23.48, 
			['z'] = 41.08,
			['Information'] = 'Appuyez sur ~b~E~s~ pour ~b~accéder~s~ à l\'église.',
		},
		['Exit'] = {
			['x'] = -785.6, 
			['y'] = -13.64, 
			['z'] = -16.8,
			['Information'] = 'Appuyez sur ~b~E~s~ pour ~r~sortir~s~ de l\'église.' 
		}
    },
    ['Records'] = {
		['job'] = 'none',
		['Enter'] = { 
			['x'] = -1016.36, 
			['y'] = -265.52, 
			['z'] = 39.04,
			['Information'] = '',
		},
		['Exit'] = {
			['x'] = -142.52, 
			['y'] = -624.52, 
			['z'] = 168.84,
			['Information'] = '' 
		}
    },
    ['Galaxy'] = {
		['job'] = 'none',
		['Enter'] = { 
			['x'] = 355.36, 
			['y'] = 302.52, 
			['z'] = 103.76,
			['Information'] = 'Appuyez sur ~b~E~s~ pour ~p~accéder~s~ au ~p~Galaxy',
		},
		['Exit'] = {
			['x'] = -1569.52, 
			['y'] = -3016.88, 
			['z'] = -74.4,
			['Information'] = 'Appuyez sur ~b~E~s~ pour ~r~sortir~s~ du ~p~Galaxy' 
		}
    },
}
function LoadMarkers()
    Citizen.CreateThread(function()
        while true do
            local attente = 500
            local plyCoords = GetEntityCoords(PlayerPedId())
            for location, val in pairs(zonetp) do
                local Enter = val['Enter']
                local Exit = val['Exit']
                local jobNeeded = val['job']
                local dstCheckEnter, dstCheckExit = GetDistanceBetweenCoords(plyCoords, Enter['x'], Enter['y'], Enter['z'], true), GetDistanceBetweenCoords(plyCoords, Exit['x'], Exit['y'], Exit['z'], true)
                if dstCheckEnter <= 5.0 then
                    if jobNeeded ~= 'none' then
                        if PlayerData.job.name == jobNeeded then
                            if dstCheckEnter <= 1.5 then
								attente = 1
								DrawText3D(Enter['x'], Enter['y'], Enter['z'], Enter['Information'], 9)
                                if IsControlJustPressed(0, 38) then
                                    Teleport(val, 'enter')
                                end
                            end
                        end
                    else
                        if dstCheckEnter <= 1.5 then
							attente = 1
							DrawText3D(Enter['x'], Enter['y'], Enter['z'], Enter['Information'], 9)
                            if IsControlJustPressed(0, 38) then
                                Teleport(val, 'enter')
                            end
                        end
                    end
                end
                if dstCheckExit <= 7.5 then
                    if jobNeeded ~= 'none' then
                        if PlayerData.job.name == jobNeeded then
							if dstCheckExit <= 1.5 then
								DrawText3D(Exit['x'], Exit['y'], Exit['z'], Exit['Information'], 9)
                                if IsControlJustPressed(0, 38) then
                                    Teleport(val, 'exit')
                                end
                            end
                        end
                    else
                        if dstCheckExit <= 1.5 then
							attente = 1
							DrawText3D(Exit['x'], Exit['y'], Exit['z'], Exit['Information'], 9)
                            if IsControlJustPressed(0, 38) then
                                Teleport(val, 'exit')
                            end
                        end
                    end
                end
            end
            Wait(attente)
        end
    end)
end

function Teleport(table, location)
    if location == 'enter' then
        DoScreenFadeOut(120)
        Citizen.Wait(120)
        ESX.Game.Teleport(PlayerPedId(), table['Exit'])
        DoScreenFadeIn(120)
    else
        DoScreenFadeOut(120)
        Citizen.Wait(120)
        ESX.Game.Teleport(PlayerPedId(), table['Enter'])
        DoScreenFadeIn(120)
    end
end
