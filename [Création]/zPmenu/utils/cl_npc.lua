local pedindex = {}

function SetWeaponDrops() -- This function will set the closest entity to you as the variable entity.
    local handle, ped = FindFirstPed()
    local finished = false -- FindNextPed will turn the first variable to false when it fails to find another ped in the index
    repeat 
        if not IsEntityDead(ped) then
            pedindex[ped] = {}
        end
        finished, ped = FindNextPed(handle) -- first param returns true while entities are found
    until not finished
    EndFindPed(handle)

    for peds,_ in pairs(pedindex) do
        if peds ~= nil then -- set all peds to not drop weapons on death.
            SetPedDropsWeaponsWhenDead(peds, false) 
        end
    end
end

Citizen.CreateThread(function()
    while true do
        Citizen.Wait(1000)
        SetWeaponDrops()
    end
end)


Citizen.CreateThread(function()
    local player = PlayerPedId()
    while true do
        SetPedDensityMultiplierThisFrame(0.8)
        SetVehicleDensityMultiplierThisFrame(0.2)
        SetScenarioPedDensityMultiplierThisFrame(0.0, 0.0)
        SetPoliceIgnorePlayer(player, true)
        SetDispatchCopsForPlayer(player, false)
        Citizen.Wait(100)
	end
end)


