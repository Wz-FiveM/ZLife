local healthEngineLast = 1000.0
local healthBodyLast = 1000.0
local healthPetrolTankLast = 1000.0

local cfg = {
	deformationMultiplier = 3.0,					-- How much should the vehicle visually deform from a collision. Range 0.0 to 10.0 Where 0.0 is no deformation and 10.0 is 10x deformation. -1 = Don't touch. Visual damage does not sync well to other players.
	deformationExponent = 0.4,					-- How much should the handling file deformation setting be compressed toward 1.0. (Make cars more similar). A value of 1=no change. Lower values will compress more, values above 1 it will expand. Dont set to zero or negative.
	collisionDamageExponent = 0.6,				-- How much should the handling file deformation setting be compressed toward 1.0. (Make cars more similar). A value of 1=no change. Lower values will compress more, values above 1 it will expand. Dont set to zero or negative.

	damageFactorEngine = 10.0,					-- Sane values are 1 to 100. Higher values means more damage to vehicle. A good starting point is 10
	damageFactorBody = 10.0,					-- Sane values are 1 to 100. Higher values means more damage to vehicle. A good starting point is 10
	damageFactorPetrolTank = 64.0,				-- Sane values are 1 to 200. Higher values means more damage to vehicle. A good starting point is 64
	engineDamageExponent = 0.6,					-- How much should the handling file engine damage setting be compressed toward 1.0. (Make cars more similar). A value of 1=no change. Lower values will compress more, values above 1 it will expand. Dont set to zero or negative.
	weaponsDamageMultiplier = 1.5,				-- How much damage should the vehicle get from weapons fire. Range 0.0 to 10.0, where 0.0 is no damage and 10.0 is 10x damage. -1 = don't touch
	degradingHealthSpeedFactor = 10,			-- Speed of slowly degrading health, but not failure. Value of 10 means that it will take about 0.25 second per health point, so degradation from 800 to 305 will take about 2 minutes of clean driving. Higher values means faster degradation
	cascadingFailureSpeedFactor = 8.0,			-- Sane values are 1 to 100. When vehicle health drops below a certain point, cascading failure sets in, and the health drops rapidly until the vehicle dies. Higher values means faster failure. A good starting point is 8

	degradingFailureThreshold = 200.0,			-- Below this value, slow health degradation will set in
	cascadingFailureThreshold = 100.0,			-- Below this value, health cascading failure will set in
	engineSafeGuard = 0.0,					-- Final failure value. Set it too high, and the vehicle won't smoke when disabled. Set too low, and the car will catch fire from a single bullet to the engine. At health 100 a typical car can take 3-4 bullets to the engine before catching fire.

	torqueMultiplierEnabled = true,				-- Decrease engine torque as engine gets more and more damaged

	-- The response curve to apply to the Brake. Range 0.0 to 10.0. Higher values enables easier braking, meaning more pressure on the throttle is required to brake hard. Does nothing for keyboard drivers

	classDamageMultiplier = {
		[0] = 	0.85,		--	0: Compacts
				0.85,		--	1: Sedans
				0.5,		--	2: SUVs
				0.85,		--	3: Coupes
				0.85,		--	4: Muscle
				0.85,		--	5: Sports Classics
				0.85,		--	6: Sports
				0.85,		--	7: Super
				0.25,		--	8: Motorcycles
				0.7,		--	9: Off-road
				0.25,		--	10: Industrial
				0.85,		--	11: Utility
				0.5,		--	12: Vans
				0.85,		--	13: Cycles
				0.5,		--	14: Boats
				0.85,		--	15: Helicopters
				0.85,		--	16: Planes
				0.85,		--	17: Service
				0.75,		--	18: Emergency
				0.75,		--	19: Military
				0.85,		--	20: Commercial
				0.85 		--	21: Trains
	}
}

local pedInSameVehicleLast = false
local vehicle
local lastVehicle
local vehicleClass
local fCollisionDamageMult = 0.0
local fDeformationDamageMult = 0.0
local fEngineDamageMult = 0.0
local fBrakeForce = 1.0

local healthEngineCurrent = 1000.0
local healthEngineNew = 1000.0
local healthEngineDelta = 0.0
local healthEngineDeltaScaled = 0.0

local healthBodyCurrent = 1000.0
local healthBodyNew = 1000.0
local healthBodyDelta = 0.0
local healthBodyDeltaScaled = 0.0

local healthPetrolTankCurrent = 1000.0
local healthPetrolTankNew = 1000.0
local healthPetrolTankDelta = 0.0
local healthPetrolTankDeltaScaled = 0.0

local DoesEntityExist = DoesEntityExist
local IsPedInAnyVehicle = IsPedInAnyVehicle
local GetEntityRoll = GetEntityRoll
local PlayerPedId = PlayerPedId
local IsThisModelACar = IsThisModelACar
local GetEntityModel = GetEntityModel
local GetEntitySpeed = GetEntitySpeed
local DisableControlAction = DisableControlAction
local GetPedInVehicleSeat = GetPedInVehicleSeat
local GetVehicleClass = GetVehicleClass

local function isPedDrivingAVehicle(ped, vehicle)
	if GetPedInVehicleSeat(vehicle, -1) == ped then
		local class = GetVehicleClass(vehicle)
		if class ~= 15 and class ~= 16 and class ~= 21 and class ~= 13 then
			return true
		end
	end

	return false
end

Citizen.CreateThread(function()
	while true do
		local attente = 500

		local Player = GetPlayerPed(-1)
		local ped, veh = GetPlayerPed(-1), GetVehiclePedIsIn(GetPlayerPed(-1), false)

		if IsPedInAnyVehicle(GetPlayerPed(-1), false) and veh and isPedDrivingAVehicle(ped, veh) and IsThisModelACar(GetEntityModel(veh)) and not IsControlPressed(1, 337) then
			attente = 1
			vehicle = veh
			vehicleClass = GetVehicleClass(vehicle)

			healthEngineCurrent = GetVehicleEngineHealth(vehicle)
			if healthEngineCurrent == 1000 then healthEngineLast = 1000.0 end
			healthEngineNew = healthEngineCurrent
			healthEngineDelta = healthEngineLast - healthEngineCurrent
			healthEngineDeltaScaled = healthEngineDelta * cfg.damageFactorEngine * cfg.classDamageMultiplier[vehicleClass]

			healthBodyCurrent = GetVehicleBodyHealth(vehicle)
			if healthBodyCurrent == 1000 then healthBodyLast = 1000.0 end
			healthBodyNew = healthBodyCurrent
			healthBodyDelta = healthBodyLast - healthBodyCurrent
			healthBodyDeltaScaled = healthBodyDelta * cfg.damageFactorBody * cfg.classDamageMultiplier[vehicleClass]

			healthPetrolTankCurrent = GetVehiclePetrolTankHealth(vehicle)
			if cfg.compatibilityMode and healthPetrolTankCurrent < 1 then
				healthPetrolTankLast = healthPetrolTankCurrent
			end
			if healthPetrolTankCurrent == 1000 then healthPetrolTankLast = 1000.0 end
			healthPetrolTankNew = healthPetrolTankCurrent
			healthPetrolTankDelta = healthPetrolTankLast-healthPetrolTankCurrent
			healthPetrolTankDeltaScaled = healthPetrolTankDelta * cfg.damageFactorPetrolTank * cfg.classDamageMultiplier[vehicleClass]
			if healthEngineCurrent > cfg.engineSafeGuard + 1 then
				SetVehicleUndriveable(vehicle,false)
			end
			if healthEngineCurrent <= cfg.engineSafeGuard + 1 then
				SetVehicleUndriveable(vehicle,true)
			end
			-- If ped spawned a new vehicle while in a vehicle or teleported from one vehicle to another, handle as if we just entered the car
			if vehicle ~= lastVehicle then
				pedInSameVehicleLast = false
			end
			if pedInSameVehicleLast == true then
				-- Damage happened while in the car = can be multiplied
				-- Only do calculations if any damage is present on the car. Prevents weird behavior when fixing using trainer or other script
				if healthEngineCurrent ~= 1000.0 or healthBodyCurrent ~= 1000.0 or healthPetrolTankCurrent ~= 1000.0 then
					-- Combine the delta values (Get the largest of the three)
					local healthEngineCombinedDelta = math.max(healthEngineDeltaScaled, healthBodyDeltaScaled, healthPetrolTankDeltaScaled)
					-- If huge damage, scale back a bit
					if healthEngineCombinedDelta > (healthEngineCurrent - cfg.engineSafeGuard) then
						healthEngineCombinedDelta = healthEngineCombinedDelta * 0.7
					end
					-- If complete damage, but not catastrophic (ie. explosion territory) pull back a bit, to give a couple of seconds og engine runtime before dying
					if healthEngineCombinedDelta > healthEngineCurrent then
						healthEngineCombinedDelta = healthEngineCurrent - (cfg.cascadingFailureThreshold / 5)
					end
					------- Calculate new value
					healthEngineNew = healthEngineLast - healthEngineCombinedDelta
					------- Sanity Check on new values and further manipulations
					-- If somewhat damaged, slowly degrade until slightly before cascading failure sets in, then stop
					if healthEngineNew > (cfg.cascadingFailureThreshold + 5) and healthEngineNew < cfg.degradingFailureThreshold then
						healthEngineNew = healthEngineNew-(0.038 * cfg.degradingHealthSpeedFactor)
					end
					-- If Damage is near catastrophic, cascade the failure
					if healthEngineNew < cfg.cascadingFailureThreshold then
						healthEngineNew = healthEngineNew-(0.1 * cfg.cascadingFailureSpeedFactor)
					end
					-- Prevent Engine going to or below zero. Ensures you can reenter a damaged car.
					if healthEngineNew < cfg.engineSafeGuard then
						healthEngineNew = cfg.engineSafeGuard
					end
					-- Prevent Explosions
					if cfg.compatibilityMode == false and healthPetrolTankCurrent < 750 then
						healthPetrolTankNew = 750.0
					end
					-- Prevent negative body damage.
					if healthBodyNew < 0  then
						healthBodyNew = 0.0
					end
				end
			else
				-- Just got in the vehicle. Damage can not be multiplied this round
				-- Set vehicle handling data
				fDeformationDamageMult = GetVehicleHandlingFloat(vehicle, 'CHandlingData', 'fDeformationDamageMult')
				fBrakeForce = GetVehicleHandlingFloat(vehicle, 'CHandlingData', 'fBrakeForce')
				local newFDeformationDamageMult = fDeformationDamageMult ^ cfg.deformationExponent	-- Pull the handling file value closer to 1
				if cfg.deformationMultiplier ~= -1 then SetVehicleHandlingFloat(vehicle, 'CHandlingData', 'fDeformationDamageMult', newFDeformationDamageMult * cfg.deformationMultiplier) end  -- Multiply by our factor
				if cfg.weaponsDamageMultiplier ~= -1 then SetVehicleHandlingFloat(vehicle, 'CHandlingData', 'fWeaponDamageMult', cfg.weaponsDamageMultiplier / cfg.damageFactorBody) end -- Set weaponsDamageMultiplier and compensate for damageFactorBody

				--Get the CollisionDamageMultiplier
				fCollisionDamageMult = GetVehicleHandlingFloat(vehicle, 'CHandlingData', 'fCollisionDamageMult')
				--Modify it by pulling all number a towards 1.0
				local newFCollisionDamageMultiplier = fCollisionDamageMult ^ cfg.collisionDamageExponent	-- Pull the handling file value closer to 1
				SetVehicleHandlingFloat(vehicle, 'CHandlingData', 'fCollisionDamageMult', newFCollisionDamageMultiplier)

				--Get the EngineDamageMultiplier
				fEngineDamageMult = GetVehicleHandlingFloat(vehicle, 'CHandlingData', 'fEngineDamageMult')
				--Modify it by pulling all number a towards 1.0
				local newFEngineDamageMult = fEngineDamageMult ^ cfg.engineDamageExponent	-- Pull the handling file value closer to 1
				SetVehicleHandlingFloat(vehicle, 'CHandlingData', 'fEngineDamageMult', newFEngineDamageMult)

				-- If body damage catastrophic, reset somewhat so we can get new damage to multiply
				if healthBodyCurrent < cfg.cascadingFailureThreshold then
					healthBodyNew = cfg.cascadingFailureThreshold
				end
				pedInSameVehicleLast = true
			end

			-- set the actual new values
			if healthEngineNew ~= healthEngineCurrent then
				SetVehicleEngineHealth(vehicle, healthEngineNew)
			end

			if healthBodyNew ~= healthBodyCurrent then SetVehicleBodyHealth(vehicle, healthBodyNew) end
			if healthPetrolTankNew ~= healthPetrolTankCurrent then SetVehiclePetrolTankHealth(vehicle, healthPetrolTankNew) end

			-- Store current values, so we can calculate delta next time around
			healthEngineLast = healthEngineNew
			healthBodyLast = healthBodyNew
			healthPetrolTankLast = healthPetrolTankNew
			lastVehicle = vehicle
		else
			if pedInSameVehicleLast == true then
				-- We just got out of the vehicle
				lastVehicle = GetVehiclePedIsIn(ped, true)
				if IsThisModelACar(GetEntityModel(lastVehicle)) then
					if cfg.deformationMultiplier ~= -1 then SetVehicleHandlingFloat(lastVehicle, 'CHandlingData', 'fDeformationDamageMult', fDeformationDamageMult) end -- Restore deformation multiplier
					SetVehicleHandlingFloat(lastVehicle, 'CHandlingData', 'fBrakeForce', fBrakeForce)  -- Restore Brake Force multiplier
					if cfg.weaponsDamageMultiplier ~= -1 then SetVehicleHandlingFloat(lastVehicle, 'CHandlingData', 'fWeaponDamageMult', cfg.weaponsDamageMultiplier) end	-- Since we are out of the vehicle, we should no longer compensate for bodyDamageFactor
					SetVehicleHandlingFloat(lastVehicle, 'CHandlingData', 'fCollisionDamageMult', fCollisionDamageMult) -- Restore the original CollisionDamageMultiplier
					SetVehicleHandlingFloat(lastVehicle, 'CHandlingData', 'fEngineDamageMult', fEngineDamageMult) -- Restore the original EngineDamageMultiplier
				end
			end
			pedInSameVehicleLast = false
		end
		Wait(attente)
	end
end)

Citizen.CreateThread(function()
	while true do
		local attente = 1000
		local vehicle = GetVehiclePedIsIn(GetPlayerPed(-1), false)
		local speed = GetEntitySpeed(vehicle)
		local kmh = 3.6
		local mph = 2.23694
		local vehicleClass = GetVehicleClass(vehicle)
		local vehicleModel = GetEntityModel(vehicle)
		playerPed = GetPlayerPed(-1)
			if IsPedInAnyVehicle(GetPlayerPed(-1), false) and math.floor(speed*kmh) > 18 then
				attente = 10
				DisableControlAction(0, 75, true)
				DisableControlAction(0, 24, true)
				DisableControlAction(0, 159, true) -- INPUT_VEH_PREV_RADIO_TRACK  
				DisableControlAction(0, 161, true) -- INPUT_VEH_NEXT_RADIO_TRACK 
				DisableControlAction(0, 162, true) -- INPUT_VEH_NEXT_RADIO
				DisableControlAction(0, 165, true) -- INPUT_VEH_PREV_RADIO
				DisableControlAction(0, 164, true) -- INPUT_VEH_PREV_RADIO
			elseif not IsPedInAnyVehicle(playerPed, false) then 
				attente = 2500
			end
		Wait(attente)
	end
end)


RestrictEmer = false
keepDoorOpen = false

local notify = false

Citizen.CreateThread(function()
    while true do
        local attente = 500
        local ped = GetPlayerPed(-1)
        local veh = GetVehiclePedIsIn(ped, false)

        if not notify then
			if IsPedInAnyVehicle(ped, true) then
				attente = 1
				notify = true
			elseif not IsPedInAnyVehicle(ped, false) then 
				attente = 2500
            end
        end
        if RestrictEmer then
			if GetVehicleClass(veh) == 18 then
				attente = 1
                if IsPedInAnyVehicle(ped, false) and IsControlPressed(2, 75) and not IsEntityDead(ped) then
                    Citizen.Wait(150)
                    if IsPedInAnyVehicle(ped, false) and IsControlPressed(2, 75) and not IsEntityDead(ped) then
                        SetVehicleEngineOn(veh, true, true, false)
                        if keepDoorOpen then
                            TaskLeaveVehicle(ped, veh, 256)
                        else
                            TaskLeaveVehicle(ped, veh, 0)
                        end
                    end
                end
            end
        else
            if IsPedInAnyVehicle(ped, false) and IsControlPressed(2, 75) and not IsEntityDead(ped) then
                Citizen.Wait(150)
                if IsPedInAnyVehicle(ped, false) and IsControlPressed(2, 75) and not IsEntityDead(ped) then
                    SetVehicleEngineOn(veh, true, true, false)
                    if keepDoorOpen then
                        TaskLeaveVehicle(ped, veh, 256)
                    else
                        TaskLeaveVehicle(ped, veh, 0)
                    end
				end
			elseif not IsPedInAnyVehicle(ped, false) then 
				attente = 2500
			end
		end
		Wait(attente)
	end
end)

function AddTextEntry(key, value)
	Citizen.InvokeNative(GetHashKey("ADD_TEXT_ENTRY"), key, value)
end

Citizen.CreateThread(function()
	AddTextEntry("police", "Ford CVPI")
	AddTextEntry("newvic", "Ford CVPI")
	AddTextEntry("police2", "Dodge Charger Police")
	AddTextEntry("14charger", "Dodge Charger Police")
	AddTextEntry("police3", "Ford Interceptor")
	AddTextEntry("16explorer", "Ford Interceptor")
	AddTextEntry("police4", "Ford CVPI Banalisé")
	AddTextEntry("fbi", "Oracle Banalisé")
	AddTextEntry("11caprice", "Chevrolet Caprice")
	AddTextEntry("16taurus", "Ford Taurus")
	AddTextEntry("19durango", "Durango K-9")
	AddTextEntry("03expeditionr", "Ford Expedition")
end)

Citizen.CreateThread(function()
	local SCENARIO_TYPES = { "WORLD_VEHICLE_MILITARY_PLANES_SMALL", "WORLD_VEHICLE_MILITARY_PLANES_BIG" }
	local SCENARIO_GROUPS = { 2017590552, 2141866469, 1409640232, "ng_planes" }
	local SUPPRESSED_MODELS = {"BLIMP", "hydra", "lectro","frogger", "buzzard2", "polmav", "massacro", "massacro2", "rapidgt", "feltzer2", "Jester", "Carbonizzare", "SHAMAL", "LUXOR", "LUXOR2", "JET", "LAZER", "TITAN", "BARRACKS", "BARRACKS2", "CRUSADER", "RHINO", "AIRTUG", "RIPLEY", "MIXER", "FIRETRUK", "duster", "frogger", "maverick", "buzzard", "buzzard2", "polmav", "tanker", "tanker2", "zentorno", "turismor" }

	while true do
		for _, sste in next, SCENARIO_TYPES do
			SetScenarioTypeEnabled(sste, false)
		end
		for _, ssge in next, SCENARIO_GROUPS do
			SetScenarioGroupEnabled(ssge, false)
		end
		for _, model in next, SUPPRESSED_MODELS do
			SetVehicleModelIsSuppressed(GetHashKey(model), true)
		end

		Citizen.Wait(20000)
	end
end)

Citizen.CreateThread(function()
	while true do
		local veh = GetVehiclePedIsTryingToEnter(PlayerPedId())
			if DoesEntityExist(veh) then
				if not IsVehiclePreviouslyOwnedByPlayer(veh) then 
					local pPed = PlayerPedId()
					local Model = GetEntityModel(veh)

					if not IsEntityAMissionEntity(veh) and not GetVehicleDoorsLockedForPlayer(veh, pPed) and (IsThisModelACar(Model) or IsThisModelAHeli(Model)or IsThisModelAPlane(Model)) and not (IsThisModelABicycle(Model) or IsThisModelABike(Model)) then 	
						local pPedVeh = GetPedInVehicleSeat(veh,-1)
						if pPedVeh and not IsPedAPlayer(pPedVeh)then 
							ClearPedTasks(pPed)
						elseif pPedVeh == 0 then
							SetVehicleDoorsLockedForPlayer(veh,pPed,true)
							SetVehicleDoorsLocked(veh, 2)
						end
					end
				end
			end
		Wait(10)
	end
end)


local IsControlJustPressed = IsControlJustPressed
local GetIsTaskActive = GetIsTaskActive
local PlayerPedId = PlayerPedId

Citizen.CreateThread(function ()
	local b = false

	local VehicleInteractions = {
		{ --[[bone = "door_dside_f",]] door = 0, seat = -1 }, -- Door left front (driver)
		{ --[[bone = "door_pside_f",]] door = 1, seat =  0 }, -- Door right front
		{ --[[bone = "door_dside_r",]] door = 2, seat = 1 }, -- Door left back
		{ --[[bone = "door_pside_r",]] door = 3, seat = 2 }, -- Door right back
	}

	while true do
		if IsControlJustPressed(0, 23) then
			local ped = PlayerPedId()
			if GetIsTaskActive(ped, 160) then
				local nearest
				local dist = math.huge
				local ppos = GetEntityCoords(ped)
				local vehicle = GetVehiclePedIsTryingToEnter(ped)

				if DoesEntityExist(vehicle) and GetSeatPedIsTryingToEnter(ped) == -1 then
					local bone
					local len
					local coords

					for i, v in ipairs(VehicleInteractions) do
						coords = false

						-- Use bone coords
						if v.bone then
							bone = GetEntityBoneIndexByName(vehicle, v.bone)

							if bone ~= -1 then
								coords = GetWorldPositionOfEntityBone(vehicle, bone)
							end

						-- Use entry position
						elseif v.door and DoesVehicleHaveDoor(vehicle, v.door) then
							coords = GetEntryPositionOfDoor(vehicle, v.door)
						end

						-- Is interaction is nearest
						if coords then
							len = GetDistanceBetweenCoords(vector3(ppos.x, ppos.y, ppos.z), coords)
							 -- Ignore out of interaction range
							if v.range and len > v.range then
							elseif len < dist then
								dist = len
								nearest = i
							end
						end
					end
				end

				if nearest then
					nearest = VehicleInteractions[nearest]

					if not nearest.seat then
						local door = nearest.door
						if door then -- open the door specified
							ClearPedTasks(ped)
							ClearPedTasksImmediately(ped)

							if GetVehicleDoorAngleRatio(vehicle, door) > 0.0 then
								SetVehicleDoorShut(vehicle, door, false)
								PlayVehicleDoorCloseSound(vehicle, 1)
							else
								SetVehicleDoorOpen(vehicle, door, false, false)
								PlayVehicleDoorOpenSound(vehicle, 0)
							end
						end
					else
						local seat = nearest.seat
						local occupant = GetPedInVehicleSeat(vehicle, seat)

						if DoesEntityExist(occupant) then
							local rel1 = GetRelationshipBetweenPeds(ped, occupant)
							if seat ~= -1 then ClearPedTasks(ped) end
							if rel1 >= 3 and rel1 <= 5 or rel1 == 255 then
							end
						else
							ClearPedTasks(ped)
							CanShuffleSeat(vehicle, false)
							TaskEnterVehicle(ped, vehicle, -1, seat, 1.0, 1, 0)
						end
					end
				end
			end
		elseif (IsControlJustPressed(1, 44) or IsControlJustPressed(1, 33) or IsControlJustPressed(1, 35)) and GetIsTaskActive(PlayerPedId(), 160) then
			ClearPedTasks(PlayerPedId())
		end

		Citizen.Wait(0)
	end
end)