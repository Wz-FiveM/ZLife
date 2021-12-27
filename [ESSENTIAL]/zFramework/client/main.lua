
local isLoadoutLoaded, isPaused, isPlayerSpawned, isDead = false, false, false, false
local lastLoadout, pickups = {}, {}


--[[ AddEventHandler("playerSpawned", function()
    NetworkSetFriendlyFireOption(true)
    SetCanAttackFriendly(PlayerPedId(), true, true)
end) ]]

Citizen.CreateThread(function()
	N_0x170f541e1cadd1de(false)
	NetworkSetFriendlyFireOption(true)

	while true do
		Citizen.Wait(4000)
		for _,i in pairs(GetActivePlayers()) do
			local ped = GetPlayerPed(i)
			if DoesEntityExist(ped) then
				SetCanAttackFriendly(ped, true, true)
			end
		end
	end
end)

RegisterNetEvent('esx:playerLoaded')
AddEventHandler('esx:playerLoaded', function(xPlayer)
	ESX.PlayerLoaded = true
	ESX.PlayerData = xPlayer

	TriggerEvent('es:setMoneyDisplay', 0.0)
end)

AddEventHandler('playerSpawned', function()
	while not ESX.PlayerLoaded do
		Citizen.Wait(1)
	end

	local playerPed = PlayerPedId()

	-- Restore position
	if ESX.PlayerData.lastPosition then
		SetEntityCoords(playerPed, ESX.PlayerData.lastPosition.x, ESX.PlayerData.lastPosition.y, ESX.PlayerData.lastPosition.z)
	end

	TriggerEvent('esx:restoreLoadout') -- restore loadout

	isLoadoutLoaded = true
	isPlayerSpawned = true
	isDead = false
end)

AddEventHandler('esx:onPlayerDeath', function()
	isDead = true
end)

AddEventHandler('skinchanger:loadDefaultModel', function()
	isLoadoutLoaded = false
end)

AddEventHandler('skinchanger:modelLoaded', function()
	while not ESX.PlayerLoaded do
		Citizen.Wait(1)
	end

	TriggerEvent('esx:restoreLoadout')
end)

AddEventHandler('esx:restoreLoadout', function()
	local playerPed = PlayerPedId()
	local ammoTypes = {}

	RemoveAllPedWeapons(playerPed, true)

	for i=1, #ESX.PlayerData.loadout, 1 do
		local weaponName = ESX.PlayerData.loadout[i].name
		local weaponHash = GetHashKey(weaponName)

		GiveWeaponToPed(playerPed, weaponHash, 0, false, false)
		local ammoType = GetPedAmmoTypeFromWeapon(playerPed, weaponHash)

		for j=1, #ESX.PlayerData.loadout[i].components, 1 do
			local weaponComponent = ESX.PlayerData.loadout[i].components[j]
			local componentHash = ESX.GetWeaponComponent(weaponName, weaponComponent).hash

			GiveWeaponComponentToPed(playerPed, weaponHash, componentHash)
		end

		if not ammoTypes[ammoType] then
			AddAmmoToPed(playerPed, weaponHash, ESX.PlayerData.loadout[i].ammo)
			ammoTypes[ammoType] = true
		end
		SetPedWeaponTintIndex(playerPed, weaponHash, ESX.PlayerData.loadout[i].tint or 0)
	end

	isLoadoutLoaded = true
end)

RegisterNetEvent('esx:setAccountMoney')
AddEventHandler('esx:setAccountMoney', function(account)
	for i=1, #ESX.PlayerData.accounts, 1 do
		if ESX.PlayerData.accounts[i].name == account.name then
			ESX.PlayerData.accounts[i] = account
			break
		end
	end
	TriggerEvent('c_inv:relaodinv')
end)

RegisterNetEvent('es:activateMoney')
AddEventHandler('es:activateMoney', function(money)
	TriggerEvent('c_inv:relaodinv')
	ESX.PlayerData.money = money
end)

RegisterNetEvent('esx:addInventoryItem')
AddEventHandler('esx:addInventoryItem', function(item, count)
	for i=1, #ESX.PlayerData.inventory, 1 do
		if ESX.PlayerData.inventory[i].name == item.name then
			ESX.PlayerData.inventory[i] = item
			break
		end
	end

	TriggerEvent('c_inv:relaodinv')

	if ESX.UI.Menu.IsOpen('default', 'es_extended', 'inventory') then
		ESX.ShowInventory()
	end
end)

RegisterNetEvent('esx:removeInventoryItem')
AddEventHandler('esx:removeInventoryItem', function(item, count)
	for i=1, #ESX.PlayerData.inventory, 1 do
		if ESX.PlayerData.inventory[i].name == item.name then
			ESX.PlayerData.inventory[i] = item
			break
		end
	end

	TriggerEvent('c_inv:relaodinv')

	if ESX.UI.Menu.IsOpen('default', 'es_extended', 'inventory') then
		ESX.ShowInventory()
	end
end)

RegisterNetEvent('esx:setJob')
AddEventHandler('esx:setJob', function(job)
	ESX.PlayerData.job = job
end)

RegisterNetEvent('esx:setOrg')
AddEventHandler('esx:setOrg', function(org)
	ESX.PlayerData.org = org
end)

RegisterNetEvent('esx:addWeapon')
AddEventHandler('esx:addWeapon', function(weaponName, ammo)
	local playerPed  = PlayerPedId()
	local weaponHash = GetHashKey(weaponName)
	TriggerEvent('c_inv:relaodinv')

	GiveWeaponToPed(playerPed, weaponHash, ammo, false, false)
	--AddAmmoToPed(playerPed, weaponHash, ammo) possibly not needed
end)

RegisterNetEvent('esx:removeWeapon')
AddEventHandler('esx:removeWeapon', function(weaponName, ammo)
	local playerPed  = PlayerPedId()
	local weaponHash = GetHashKey(weaponName)
	TriggerEvent('c_inv:relaodinv')
	
	RemoveWeaponFromPed(playerPed, weaponHash)

	if ammo then
		local pedAmmo = GetAmmoInPedWeapon(playerPed, weaponHash)
		local finalAmmo = math.floor(pedAmmo - ammo)
		SetPedAmmo(playerPed, weaponHash, finalAmmo)
	else
		SetPedAmmo(playerPed, weaponHash, 0) -- remove leftover ammo
	end
end)


RegisterNetEvent('esx:removeWeaponComponent')
AddEventHandler('esx:removeWeaponComponent', function(weaponName, weaponComponent)
	local playerPed  = PlayerPedId()
	local weaponHash = GetHashKey(weaponName)
	local componentHash = ESX.GetWeaponComponent(weaponName, weaponComponent).hash

	RemoveWeaponComponentFromPed(playerPed, weaponHash, componentHash)
end)

-- Commands
RegisterNetEvent('esx:teleport')
AddEventHandler('esx:teleport', function(pos)
	pos.x = pos.x + 0.0
	pos.y = pos.y + 0.0
	pos.z = pos.z + 0.0

	RequestCollisionAtCoord(pos.x, pos.y, pos.z)

	while not HasCollisionLoadedAroundEntity(PlayerPedId()) do
		RequestCollisionAtCoord(pos.x, pos.y, pos.z)
		Citizen.Wait(1)
	end

	SetEntityCoords(PlayerPedId(), pos.x, pos.y, pos.z)
end)

RegisterNetEvent('esx:setJob')
AddEventHandler('esx:setJob', function(job)

end)

RegisterNetEvent('esx:setOrg')
AddEventHandler('esx:setOrg', function(org)

end)

RegisterNetEvent('esx:spawnVehicle')
AddEventHandler('esx:spawnVehicle', function(model)
	local playerPed = PlayerPedId()
	local coords    = GetEntityCoords(playerPed)

	ESX.Game.SpawnVehicle(model, coords, 90.0, function(vehicle)
		TriggerEvent('persistent-vehicles/register-vehicle', vehicle)
		TaskWarpPedIntoVehicle(playerPed,  vehicle, -1)
	end)
end)

RegisterNetEvent('esx:spawnObject')
AddEventHandler('esx:spawnObject', function(model)
	local playerPed = PlayerPedId()
	local coords    = GetEntityCoords(playerPed)
	local forward   = GetEntityForwardVector(playerPed)
	local x, y, z   = table.unpack(coords + forward * 1.0)

	ESX.Game.SpawnObject(model, {
		x = x,
		y = y,
		z = z
	}, function(obj)
		SetEntityHeading(obj, GetEntityHeading(playerPed))
		PlaceObjectOnGroundProperly(obj)
	end)
end)

RegisterNetEvent('esx:pickup')
AddEventHandler('esx:pickup', function(id, label, player, props)
	local ped     = GetPlayerPed(GetPlayerFromServerId(player))
	local coords  = GetEntityCoords(ped)
	local forward = GetEntityForwardVector(ped)
	local x, y, z = table.unpack(coords + forward)

	ESX.Game.SpawnLocalObject(props or 'v_serv_abox_02', {
		x = x,
		y = y,
		z = z,
	}, function(obj)
		SetEntityAsMissionEntity(obj, true, false)
		PlaceObjectOnGroundProperly(obj)
		FreezeEntityPosition(obj, true)
		SetEntityHeading(obj, GetEntityHeading(ped))

		pickups[id] = {
			id = id,
			obj = obj,
			label = label,
			inRange = false,
			coords = {
				x = x,
				y = y,
				z = z
			}
		}
	end)
end)

RegisterNetEvent('esx:pickupcoords')
AddEventHandler('esx:pickupcoords', function(id, label, player, props, coords)
	local ped     = GetPlayerPed(GetPlayerFromServerId(player))

	ESX.Game.SpawnLocalObject(props or 'v_serv_abox_02', {
		x = coords.x,
		y = coords.y,
		z = coords.z,
	}, function(obj)
		SetEntityAsMissionEntity(obj, true, false)
		PlaceObjectOnGroundProperly(obj)
		FreezeEntityPosition(obj, true)

		pickups[id] = {
			id = id,
			obj = obj,
			label = label,
			inRange = false,
			coords = {
				x = coords.x,
				y = coords.y,
				z = coords.z
			}
		}
	end)
end)

RegisterNetEvent('esx:removePickup')
AddEventHandler('esx:removePickup', function(id)
	ESX.Game.DeleteObject(pickups[id].obj)
	FreezeEntityPosition(pickups[id].obj, false)
	pickups[id] = nil
end)

RegisterNetEvent('esx:pickupWeapon')
AddEventHandler('esx:pickupWeapon', function(weaponPickup, weaponName, ammo)
	local playerPed = PlayerPedId()
	local pickupCoords = GetOffsetFromEntityInWorldCoords(playerPed, 2.0, 0.0, 0.5)
	local weaponHash = GetHashKey(weaponPickup)

	CreateAmbientPickup(weaponHash, pickupCoords, 0, ammo, 1, false, true)
end)

RegisterNetEvent('esx:spawnPed')
AddEventHandler('esx:spawnPed', function(model)
	model           = (tonumber(model) ~= nil and tonumber(model) or GetHashKey(model))
	local playerPed = PlayerPedId()
	local coords    = GetEntityCoords(playerPed)
	local forward   = GetEntityForwardVector(playerPed)
	local x, y, z   = table.unpack(coords + forward * 1.0)

	Citizen.CreateThread(function()
		RequestModel(model)

		while not HasModelLoaded(model) do
			Citizen.Wait(1)
		end

		CreatePed(5, model, x, y, z, 0.0, true, false)
	end)
end)

RegisterNetEvent('esx:deleteVehicle')
AddEventHandler('esx:deleteVehicle', function()
	local playerPed = PlayerPedId()
	local vehicle   = ESX.Game.GetVehicleInDirection()

	if IsPedInAnyVehicle(playerPed, true) then
		vehicle = GetVehiclePedIsIn(playerPed, false)
	end

	TriggerEvent('persistent-vehicles/forget-vehicle', vehicle)
    Wait(50)

	if DoesEntityExist(vehicle) then
		ESX.Game.DeleteVehicle(vehicle)
	end
end)

-- Save loadout
Citizen.CreateThread(function()
	while true do
		Citizen.Wait(5000)

		local playerPed      = PlayerPedId()
		local loadout        = {}
		local loadoutChanged = false

		if IsPedDeadOrDying(playerPed) then
			isLoadoutLoaded = false
		end

		for i=1, #Config.Weapons do
			local weaponName = Config.Weapons[i].name
			local weaponHash = GetHashKey(weaponName)
			local weaponComponents = {}

			if HasPedGotWeapon(playerPed, weaponHash, false) and weaponName ~= 'WEAPON_UNARMED' then
				local ammo = GetAmmoInPedWeapon(playerPed, weaponHash)
				local components = Config.Weapons[i].components
				local tint = GetPedWeaponTintIndex(playerPed, weaponHash)

				for j=1, #components do
					if HasPedGotWeaponComponent(playerPed, weaponHash, components[j].hash) then
						table.insert(weaponComponents, components[j].name)
					end
				end

				if not lastLoadout[weaponName] or lastLoadout[weaponName] ~= ammo then
					loadoutChanged = true
				end

				lastLoadout[weaponName] = ammo
				lastLoadout[weaponName] = tint

				table.insert(loadout, {
					name = weaponName,
					ammo = ammo,
					tint = tint,
					label = Config.Weapons[i].label,
					components = weaponComponents
				})
			else
				if lastLoadout[weaponName] then
					loadoutChanged = true
				end

				lastLoadout[weaponName] = nil
			end
		end

		if loadoutChanged and isLoadoutLoaded then
			ESX.PlayerData.loadout = loadout
			TriggerServerEvent('esx:updateLoadout', loadout)
		end
	end
end)
function DrawText3D(B6zKxgVs, O3_X, DVs8kf2w, vms5, M7, v3)
    local ihKb = M7 or 7
    local JGSK, rA5U, Uc06 = table.unpack(GetGameplayCamCoords())
    M7 = GetDistanceBetweenCoords(JGSK, rA5U, Uc06, B6zKxgVs, O3_X, DVs8kf2w, 1)
    local lcBL = GetDistanceBetweenCoords(GetEntityCoords(GetPlayerPed(-1)), B6zKxgVs, O3_X, DVs8kf2w, 1) - 1.65
    local DHPxI, dx = ((1 / M7) * (ihKb * .7)) * (1 / GetGameplayCamFov()) * 100, 255;
    if lcBL < ihKb then
        dx = math.floor(255 * ((ihKb - lcBL) / ihKb))
    elseif lcBL >= ihKb then
        dx = 0
    end
    dx = v3 or dx
    SetTextFont(0)
    SetTextScale(.0 * DHPxI, .1 * DHPxI)
    SetTextColour(255, 255, 255, math.max(0, math.min(255, dx)))
    SetTextCentre(1)
    SetDrawOrigin(B6zKxgVs, O3_X, DVs8kf2w, 0)
    SetTextEntry("STRING")
    AddTextComponentString(vms5)
    DrawText(0.0, 0.0)
    ClearDrawOrigin()
end
-- Pickups
Citizen.CreateThread(function()
	while true do
		local attente = 500

		local playerPed = PlayerPedId()
		local coords = GetEntityCoords(playerPed)
		
		-- if there's no nearby pickups we can wait a bit to save performance
		if next(pickups) == nil then
			Citizen.Wait(500)
		end

		for k,v in pairs(pickups) do
			local distance = GetDistanceBetweenCoords(coords, v.coords.x, v.coords.y, v.coords.z, true)
			local closestPlayer, closestDistance = ESX.Game.GetClosestPlayer()
			--label = ('%s~n~%s'):format(label, "~b~E~s~ Pour ramasser")

			if distance <= 3.0 and not IsPedInAnyVehicle(playerPed, false) then
				attente = 1
				DrawText3D(v.coords.x, v.coords.y, v.coords.z - 0.7, "~b~E~s~ pour ramasser", 5)
			elseif IsPedInAnyVehicle(playerPed, false) then 
				attente = 2500
			end

			if distance < 0.7 then
				attente = 1
					if IsControlJustReleased(0, 38) and not IsPedInAnyVehicle(playerPed, false) then
						if IsPedOnFoot(playerPed) and (closestDistance == -1 or closestDistance > 1) and not v.inRange then

						local dict, anim = 'random@domestic', 'pickup_low'
						ESX.Streaming.RequestAnimDict(dict)
						TaskPlayAnim(playerPed, dict, anim, 8.0, 8.0, -1, 0, 1, 0, 0, 0)

						Citizen.Wait(1000)
						TriggerServerEvent('esx:onPickup', v.id)
						PlaySoundFrontend(-1, 'Bus_Schedule_Pickup', 'DLC_PRISON_BREAK_HEIST_SOUNDS', false)
						v.inRange = true
					elseif IsPedInAnyVehicle(playerPed, false) then 
						attente = 2500
					end
				end
			end
		end
		Wait(attente)
	end
end)

-- Last position
Citizen.CreateThread(function()
	while true do
		Citizen.Wait(1000)

		if ESX.PlayerLoaded and isPlayerSpawned then
			local playerPed = PlayerPedId()
			local coords    = GetEntityCoords(playerPed)

			if not IsEntityDead(playerPed) then
				ESX.PlayerData.lastPosition = {x = coords.x, y = coords.y, z = coords.z}
			end
		end
	end
end)

Citizen.CreateThread(function()
	while true do
		Citizen.Wait(1000)

		local playerPed = PlayerPedId()
		if IsEntityDead(playerPed) and isPlayerSpawned then
			isPlayerSpawned = false
		end
	end
end)


if Citizen and Citizen.CreateThread then
	CreateThread = Citizen.CreateThread
end

Async = {}

function Async.parallel(tasks, cb)
	if #tasks == 0 then
		cb({})
		return
	end
	local remaining = #tasks
	local results   = {}
	for i=1, #tasks, 1 do
		CreateThread(function()
			tasks[i](function(result)
				table.insert(results, result)
				remaining = remaining - 1;
				if remaining == 0 then
					cb(results)
				end
			end)
		end)
	end
end

function Async.parallelLimit(tasks, limit, cb)
	if #tasks == 0 then
		cb({})
		return
	end
	local remaining = #tasks
	local running   = 0
	local queue     = {}
	local results   = {}
	for i=1, #tasks, 1 do
		table.insert(queue, tasks[i])
	end
	local function processQueue()
		if #queue == 0 then
			return
		end
		while running < limit and #queue > 0 do
			local task = table.remove(queue, 1)
			running = running + 1
			task(function(result)
				table.insert(results, result)
				remaining = remaining - 1;
				running   = running - 1
				if remaining == 0 then
					cb(results)
				end
			end)
		end
		CreateThread(processQueue)
	end
	processQueue()
end

function Async.series(tasks, cb)
	Async.parallelLimit(tasks, 1, cb)
end

