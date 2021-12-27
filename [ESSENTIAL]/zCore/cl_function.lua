ESX = nil
PlayerData = {}
Citizen.CreateThread(function()
	while ESX == nil do
		TriggerEvent('esx:getSharedObject', function(a)
			ESX = a
		end)
		Citizen.Wait(0)
	end
	while ESX.GetPlayerData().job == nil do
		Citizen.Wait(10)
	end
	PlayerData = ESX.GetPlayerData()
end)
RegisterNetEvent('esx:playerLoaded')
AddEventHandler('esx:playerLoaded', function(b)
	ESX.PlayerData = b
end)
RegisterNetEvent('esx:setJob')
AddEventHandler('esx:setJob', function(c)
	ESX.PlayerData.job = c
end)

local e = {}
e.Vehicle = 0;
e.Ped = 0;
e.Weapon = {}
e.DecorItem = {}
e.Struct = {}
e.Sex = 0
e.InstanceID = 0;
e.InVehicle = false;
e.InCombat = false;
e.Ragdoll = false;
e.Dead = false;
e.Ko = false
e.IsDead = false
e.Pos = vector3(0.0, 0.0, 0.0)
e.Heading = 0.0;
e.ZoneName = ""
e.Invincible = false;
e.InteriorID = 0;
e.Armed = false
e.Shooting = false;
e.Cuffed = false;
e.Health = 0;
e.Armor = 0;
e.Visible = true;
e.Freezed = false
local B6zKxgVs = GetEntityCoords;
local O3_X = GetEntityHeading;
local DVs8kf2w = GetEntityHealth;
local vms5 = GetPedArmour
local M7 = IsPedShooting;
local v3 = GetInteriorFromEntity;
local ihKb = GetPlayerPed;
local JGSK = IsPedInAnyVehicle
local rA5U = GetNameOfZone;
local Uc06 = IsPedArmed;
local lcBL = IsPedCuffed;
local DHPxI = GetVehiclePedIsUsing
local dx = GetPedConfigFlag;
function e:Matrix()
    return GetEntityMatrix(self.Ped)
end
function e:GetVehicle()
    local RRuSHnxf = self.InVehicle and DHPxI(self.Ped)
    return RRuSHnxf and RRuSHnxf > 0 and RRuSHnxf
end
function e:Set(mcYOuT, Rr)
    e[mcYOuT] = Rr
	if mcYOuT == "Invincible" then
		SetEntityInvincible(e.Ped, Rr)
	elseif mcYOuT == "Visible" then
		SetEntityVisible(e.Ped, Rr)
	end
end
function e:Freeze(scRP0)
    if scRP0 ~= nil then
        self.Freezed = scRP0
    else
        self.Freezed = not self.Freezed
    end
    FreezeEntityPosition(self.Ped, self.Freezed)
end
function e:GetFlag(AI0R2TQ6)
    return dx(self.Ped, AI0R2TQ6, 1)
end
function LocalPlayer()
    return e
end
Citizen.CreateThread(function()
    e.ID = PlayerId()
    while true do
        e.Pos = B6zKxgVs(e.Ped)
        e.Heading = O3_X(e.Ped)
        e.Health = DVs8kf2w(e.Ped)
        e.Armor = vms5(e.Ped)
        e.Shooting = M7(e.Ped)
        e.InteriorID = v3(e.Ped)
        Citizen.Wait(0)
    end
end)
Citizen.CreateThread(function()
    while true do
        e.Ped = ihKb(-1)
        e.InVehicle = JGSK(e.Ped)
        e.ZoneName = rA5U(e.Pos)
        e.Armed = Uc06(e.Ped, 6)
        e.Cuffed = lcBL(e.Ped)
        Citizen.Wait(1000)
    end
end)

function canDoIt()
	local Player = LocalPlayer and LocalPlayer()
	if Player and (Player.Dead or Player.KO) then ShowAboveRadarMessage("~r~Vous ne pouvez pas faire cela.") return end
	return true
end

function setEntCoords(pos, ent, trustPos)
	if not pos or not pos.x or not pos.y or not pos.z or (ent and not DoesEntityExist(ent)) then return true end
	local x, y, z = pos.x, pos.y, pos.z + 1.0
	ent = ent or GetPlayerPed(-1)

	RequestCollisionAtCoord(x, y, z)
	NewLoadSceneStart(x, y, z, x, y, z, 50.0, 0)

	local tempTimer = GetGameTimer()
	while not IsNewLoadSceneLoaded() do
		if GetGameTimer() - tempTimer > 3000 then
			break
		end

		Citizen.Wait(0)
	end

	SetEntityCoordsNoOffset(ent, x, y, z)

	tempTimer = GetGameTimer()
	while not HasCollisionLoadedAroundEntity(ent) do
		if GetGameTimer() - tempTimer > 3000 then
			break
		end

		Citizen.Wait(0)
	end

	local foundNewZ, newZ
	if not trustPos then
		foundNewZ, newZ = GetGroundZCoordWithOffsets(x, y, z)
		tempTimer = GetGameTimer()
		while not foundNewZ do
			z = z + 10.0
			foundNewZ, newZ = GetGroundZCoordWithOffsets(x, y, z)
			Wait(0)

			if GetGameTimer() - tempTimer > 2000 then
				break
			end
		end
	end

	SetEntityCoordsNoOffset(ent, x, y, foundNewZ and newZ or z)
	NewLoadSceneStop()

	if type(pos) ~= "vector3" and pos.a then SetEntityHeading(ent, pos.a) end
	return true
end

function isJob(d)
	local j = ESX.PlayerData.job.name
	if j ~= d then
		return false
	end
	return true
end

function isJobGrad(d)
	local j = ESX.PlayerData.job.grade_name
	if j ~= d then
		return false
	end
	return true
end

function RegisterControlKey(strKeyName, strDescription, strKey, cbPress, cbRelease)
    RegisterKeyMapping("+" .. strKeyName, strDescription, "keyboard", strKey)

	RegisterCommand("+" .. strKeyName, function()
		if not cbPress or UpdateOnscreenKeyboard() == 0 then 
			return 
		end
        cbPress()
    end, false)

    RegisterCommand("-" .. strKeyName, function()
		if not cbRelease or UpdateOnscreenKeyboard() == 0 then 
			return 
		end
        cbRelease()
    end, false)
end

function isNight()
	local hour = GetClockHours()
	if hour > 21 or hour < 6 then
	 	return true
	end
end
function isNightDrugs()
	local hour = GetClockHours()
	if hour > 8 or hour < 6 then
	 	return true
	end
end

function SpawnVehNotIn(vehicle, start, heading, plate)
    RequestModel(vehicle)
    while not HasModelLoaded(vehicle) do Wait(100) end

    local veh = CreateVehicle(vehicle, start, heading, 1, 0) 
    SetVehicleDoorsLocked(veh, 0)
	SetVehicleDoorsLockedForAllPlayers(veh, false)
    SetEntityAsMissionEntity(veh,true,true)
    SetVehicleHasBeenOwnedByPlayer(veh,true)
    SetVehicleNumberPlateText(veh, plate)
end
function DrawText3D(B6zKxgVs, O3_X, DVs8kf2w, vms5, M7, v3)
    local ihKb = M7 or 7
    local JGSK, rA5U, Uc06 = table.unpack(GetGameplayCamCoords())
    M7 = GetDistanceBetweenCoords(JGSK, rA5U, Uc06, B6zKxgVs, O3_X, DVs8kf2w, 1)
    local lcBL = GetDistanceBetweenCoords(LocalPlayer().Pos, B6zKxgVs, O3_X, DVs8kf2w, 1) - 1.65
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
function DeleteVehi()
    Citizen.CreateThread(function()
        local entity = GetVehiclePedIsIn(GetPlayerPed(-1), true)
        NetworkRequestControlOfEntity(entity)
        local test = 0
        while test > 100 and not NetworkHasControlOfEntity(entity) do
            NetworkRequestControlOfEntity(entity)
            Wait(1)
            test = test + 1
        end

        SetEntityAsNoLongerNeeded(entity)
        SetEntityAsMissionEntity(entity, true, true)

        Citizen.InvokeNative( 0xEA386986E786A54F, Citizen.PointerValueIntInitialized(entity))
     
        while DoesEntityExist(entity) do 
            SetEntityAsNoLongerNeeded(entity)
            DeleteEntity(entity)
            Citizen.InvokeNative( 0xEA386986E786A54F, Citizen.PointerValueIntInitialized(entity))
            SetEntityCoords(entity, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0)
            Wait(300)
        end 
    end)
end
function loadAnimDict(dict)
	while (not HasAnimDictLoaded(dict)) do
		RequestAnimDict(dict)
		Citizen.Wait(5)
	end
end
RegisterNetEvent('randPickupAnim')
AddEventHandler('randPickupAnim', function()
    loadAnimDict('pickup_object')
    TaskPlayAnim(PlayerPedId(),'pickup_object', 'putdown_low',5.0, 1.5, 1.0, 48, 0.0, 0, 0, 0)
    Wait(1000)
    ClearPedSecondaryTask(PlayerPedId())
end)
local e,B6zKxgVs=18000,6000
function requestVehControl(veh)
	if not veh then return end
	local id = VehToNet(veh)

	if id > 0 and not NetworkHasControlOfEntity(veh) then
		NetworkRequestControlOfEntity(veh)
		while not NetworkHasControlOfEntity(veh) do
			Citizen.Wait(0)
		end

		return true
	end
end
local function EnumerateEntities(initFunc, moveFunc, disposeFunc)
	return coroutine.wrap(function()
		local iter, id = initFunc()
		if not id or id == 0 then
			disposeFunc(iter)
			return
		end

		local enum = {handle = iter, destructor = disposeFunc}
		setmetatable(enum, entityEnumerator)

		local next = true
		repeat
		coroutine.yield(id)
		next, id = moveFunc(iter)
		until not next

		enum.destructor, enum.handle = nil, nil
		disposeFunc(iter)
	end)
end

function EnumerateObjects()
	return EnumerateEntities(FindFirstObject, FindNextObject, EndFindObject)
end

function EnumeratePeds()
	return EnumerateEntities(FindFirstPed, FindNextPed, EndFindPed)
end

function EnumerateVehicles()
	return EnumerateEntities(FindFirstVehicle, FindNextVehicle, EndFindVehicle)
end

function EnumeratePickups()
	return EnumerateEntities(FindFirstPickup, FindNextPickup, EndFindPickup)
end

local GetActivePlayers = GetActivePlayers
local GetPlayerPed = GetPlayerPed
local GetEntityCoords = GetEntityCoords
local GetEntityForwardVector = GetEntityForwardVector
local IsEntityVisible = IsEntityVisible
local HasAnimDictLoaded = HasAnimDictLoaded

-- PLAYER_LOOP
function GetPlayers()
	return GetActivePlayers()
end

local max = 1.5
function getClosePly(bl, d, addVector)
	local ped, closestPlayer = GetPlayerPed(-1)
	local playerPos, playerForward = GetEntityCoords(ped), GetEntityForwardVector(ped)
	playerPos = playerPos + (addVector or playerForward * 0.5)

	for _,v in pairs(GetPlayers()) do
		local otherPed = GetPlayerPed(v)
		local otherPedPos = otherPed ~= ped and IsEntityVisible(otherPed) and GetEntityCoords(otherPed)

		if otherPedPos and GetDistanceBetweenCoords(otherPedPos, playerPos) <= (d or max) and (not closestPlayer or GetDistanceBetweenCoords(otherPedPos, playerPos)) then
			closestPlayer = v
		end
	end

	return closestPlayer
end

function IsBehindPed(cJoBcud)
    return not
    HasEntityClearLosToEntityInFront(cJoBcud,LocalPlayer().Ped)
end

function GetClosestVehicle2(vector, radius, modelHash, testFunction)
	if not vector or not radius then return end
	local handle, veh = FindFirstVehicle()
	local success, theVeh
	repeat
		local firstDist = GetDistanceBetweenCoords(GetEntityCoords(veh), vector.x, vector.y, vector.z, true)
		if firstDist < radius and (not modelHash or modelHash == GetEntityModel(veh)) and (not theVeh or firstDist < GetDistanceBetweenCoords(GetEntityCoords(theVeh), GetEntityCoords(veh), true)) and (not testFunction or testFunction(veh)) then
			theVeh = veh
		end
		success, veh = FindNextVehicle(handle)
	until not success
		EndFindVehicle(handle)

	return theVeh
end

function GetClosestObject(vector, radius, modelHash, testFunction)
	if not vector or not radius then return end
	local handle, veh = FindFirstObject()
	local success, theVeh
	repeat
		local firstDist = GetDistanceBetweenCoords(GetEntityCoords(veh), vector.x, vector.y, vector.z, true)
		if firstDist < radius and (not modelHash or modelHash == GetEntityModel(veh)) and (not theVeh or firstDist < GetDistanceBetweenCoords(GetEntityCoords(theVeh), GetEntityCoords(veh), true)) and (not testFunction or testFunction(veh)) then
			theVeh = veh
		end
		success, veh = FindNextObject(handle)
	until not success
		EndFindObject(handle)

	return theVeh
end

function GetClosestPed2(vector, radius, modelHash, testFunction)
	if not vector or not radius then return end
	local handle, myped, veh = FindFirstPed(), GetPlayerPed(-1)
	local success, theVeh
	repeat
		local firstDist = GetDistanceBetweenCoords(GetEntityCoords(veh), vector.x, vector.y, vector.z)
		if firstDist < radius and veh ~= myped and (not modelHash or modelHash == GetEntityModel(veh)) and (not theVeh or firstDist < GetDistanceBetweenCoords(GetEntityCoords(theVeh), GetEntityCoords(veh))) and (not testFunction or testFunction(veh)) then
			theVeh = veh
		end
		success, veh = FindNextPed(handle)
	until not success
		EndFindPed(handle)

	return theVeh
end

function tableHasValue(tbl, value, k)
	if not tbl or not value or type(tbl) ~= "table" then return end
	for _,v in pairs(tbl) do
		if k and v[k] == value or v == value then return true, _ end
	end
end

function ShowAboveRadarMessage(message, back)
	if back then ThefeedNextPostBackgroundColor(back) end
	SetNotificationTextEntry("jamyfafi")
	AddLongString(message)
	return DrawNotification(0, 1)
end

function ShowNotificationWithButton(button, message, back)
	if back then ThefeedNextPostBackgroundColor(back) end
	SetNotificationTextEntry("jamyfafi")
	return EndTextCommandThefeedPostReplayInput(1, button, message)
end

function DrawTopNotification(txt)
	SetTextComponentFormat("jamyfafi")
	AddLongString(txt)
	DisplayHelpTextFromStringLabel(0, 0, 0, -1)
end

function ShowAboveRadarMessageIcon(icon, intType, sender, title, text, back)
	if type(icon) == "number" then
		local ped = GetPlayerPed(GetPlayerFromServerId(icon))
		icon = ped and GetPedHeadshot(ped) or GetPedHeadshot(PlayerPedId())
	elseif not HasStreamedTextureDictLoaded(icon) then
		RequestStreamedTextureDict(icon, false)
		while not HasStreamedTextureDictLoaded(icon) do Wait(0) end
	end

	SetNotificationTextEntry("jamyfafi")
	AddLongString(text)

	SetNotificationMessage(icon, icon, true, intType, sender, title)
	SetStreamedTextureDictAsNoLongerNeeded(icon)
	return DrawNotification(0, 1)
end

RegisterNetEvent('GM:ShowAboveRadarMessageIcon')
AddEventHandler('GM:ShowAboveRadarMessageIcon', function(icon, intType, sender, title, text, back)
	ShowAboveRadarMessageIcon(icon, intType, sender, title, text, back)
end)

function drawCenterText(msg, time)
	ClearPrints()
	SetTextEntry_2("STRING")
	AddTextComponentString(msg)
	DrawSubtitleTimed(time and math.ceil(time) or 0, true)
end

function AddLongString(txt)
	local maxLen = 100
	for i = 0, string.len(txt), maxLen do
		local sub = string.sub(txt, i, math.min(i + maxLen, string.len(txt)))
		AddTextComponentString(sub)
	end
end


local entityEnumerator = {
	__gc = function(enum)
		if enum.destructor and enum.handle then
			enum.destructor(enum.handle)
		end

		enum.destructor = nil
		enum.handle = nil
	end
}

local function EnumerateEntities(initFunc, moveFunc, disposeFunc)
	return coroutine.wrap(function()
		local iter, id = initFunc()
		if not id or id == 0 then
			disposeFunc(iter)
			return
		end

		local enum = {handle = iter, destructor = disposeFunc}
		setmetatable(enum, entityEnumerator)

		local next = true
		repeat
		coroutine.yield(id)
		next, id = moveFunc(iter)
		until not next

		enum.destructor, enum.handle = nil, nil
		disposeFunc(iter)
	end)
end

function EnumerateObjects()
	return EnumerateEntities(FindFirstObject, FindNextObject, EndFindObject)
end

function EnumeratePeds()
	return EnumerateEntities(FindFirstPed, FindNextPed, EndFindPed)
end

function EnumerateVehicles()
	return EnumerateEntities(FindFirstVehicle, FindNextVehicle, EndFindVehicle)
end

function EnumeratePickups()
	return EnumerateEntities(FindFirstPickup, FindNextPickup, EndFindPickup)
end

function TaskSynchronizedTasks(ped, animData, clearTasks)
	for _,v in pairs(animData) do
		if not HasAnimDictLoaded(v.anim[1]) then
			RequestAnimDict(v.anim[1])
			while not HasAnimDictLoaded(v.anim[1]) do Citizen.Wait(0) end
		end
	end

	local _, sequence = OpenSequenceTask(0)
	for _,v in pairs(animData) do
		TaskPlayAnim(0, v.anim[1], v.anim[2], 2.0, -2.0, math.floor(v.time or -1), v.flag or 48, 0, 0, 0, 0)
	end

	CloseSequenceTask(sequence)
	if clearTasks then ClearPedTasks(ped) end
	TaskPerformSequence(ped, sequence)
	ClearSequenceTask(sequence)

	for _,v in pairs(animData) do
		RemoveAnimDict(v.anim[1])
	end

	return sequence
end

function RequestAndWaitModel(modelName)
	if modelName and IsModelInCdimage(modelName) and not HasModelLoaded(modelName) then
		RequestModel(modelName)
		while not HasModelLoaded(modelName) do Citizen.Wait(100) end
	end
end

function RequestAndWaitDict(dictName)
	if dictName and DoesAnimDictExist(dictName) and not HasAnimDictLoaded(dictName) then
		RequestAnimDict(dictName)
		while not HasAnimDictLoaded(dictName) do Citizen.Wait(100) end
	end
end

function RequestAndWaitSet(setName)
	if setName and not HasAnimSetLoaded(setName) then
		RequestAnimSet(setName)
		while not HasAnimSetLoaded(setName) do Citizen.Wait(100) end
	end
end


function tableCount(tbl, checkCount)
	if not tbl or type(tbl) ~= "table" then return not checkCount and 0 end
	local n = 0
	for k,v in pairs(tbl) do
		n = n + 1
		if checkCount and n >= checkCount then return true end
	end
	return not checkCount and n
end

function doAnim(animName, time, flag, ped, customPos)
	if type(animName) ~= "table" then animName = {animName} end
	ped, flag = ped or GetPlayerPed(-1), flag and tonumber(flag) or false

	if not animName or not animName[1] or string.len(animName[1]) < 1 then return end
    --print(IsEntityPlayingAnim(ped, animName[1], animName[2], 3))
    if IsEntityPlayingAnim(ped, animName[1], animName[2], 3) or IsPedActiveInScenario(ped) then ClearPedTasks(ped) 
        --print("o") 
        return end

	Citizen.CreateThread(function()
		forceAnim(animName, flag, { ped = ped, time = time, pos = customPos })
	end)
end

function GetDistanceBetween3DCoords(x1, y1, z1, x2, y2, z2)

    if x1 ~= nil and y1 ~= nil and z1 ~= nil and x2 ~= nil and y2 ~= nil and z2 ~= nil then
        return math.sqrt((x1 - x2) ^ 2 + (y1 - y2) ^ 2 + (z1 - z2) ^ 2)
    end
    return -1

end

local animBug = {"WORLD_HUMAN_MUSICIAN", "WORLD_HUMAN_CLIPBOARD"}
local femaleFix = {
	["WORLD_HUMAN_BUM_WASH"] = {"amb@world_human_bum_wash@male@high@idle_a", "idle_a"},
	["WORLD_HUMAN_SIT_UPS"] = {"amb@world_human_sit_ups@male@idle_a", "idle_a"},
	["WORLD_HUMAN_PUSH_UPS"] = {"amb@world_human_push_ups@male@base", "base"},
	["WORLD_HUMAN_BUM_FREEWAY"] = {"amb@world_human_bum_freeway@male@base", "base"},
	["WORLD_HUMAN_CLIPBOARD"] = {"amb@world_human_clipboard@male@base", "base"},
	["WORLD_HUMAN_VEHICLE_MECHANIC"] = {"amb@world_human_vehicle_mechanic@male@base", "base"},
}

function forceAnim(animName, flag, args)
	flag, args = flag and tonumber(flag) or false, args or {}
	local ped, time, clearTasks, animPos, animRot, animTime = args.ped or GetPlayerPed(-1), args.time, args.clearTasks, args.pos, args.ang

	if IsPedInAnyVehicle(ped) and (not flag or flag < 40) then return end

	if not clearTasks then ClearPedTasks(ped) end

	if not animName[2] and femaleFix[animName[1]] and GetEntityModel(ped) == -1667301416 then
		animName = femaleFix[animName[1]]
	end

	if animName[2] and not HasAnimDictLoaded(animName[1]) then
		if not DoesAnimDictExist(animName[1]) then return end
		RequestAnimDict(animName[1])
		while not HasAnimDictLoaded(animName[1]) do
			Citizen.Wait(10)
		end
	end

	if not animName[2] then
		ClearAreaOfObjects(GetEntityCoords(ped), 1.0)
		TaskStartScenarioInPlace(ped, animName[1], -1, not tableHasValue(animBug, animName[1]))
	else
        if not animPos then
            TaskPlayAnim(ped, animName[1], animName[2], 8.0, -8.0, -1, flag or 44, 1, 0, 0, 0, 0)
            --TaskPlayAnim(ped, animName[1], animName[2], 8.0, -8.0, -1, 1, 1, 0, 0, 0)
		else
			TaskPlayAnimAdvanced(ped, animName[1], animName[2], animPos.x, animPos.y, animPos.z, animRot.x, animRot.y, animRot.z, 8.0, -8.0, -1, 1, 1, 0, 0, 0)
		end
	end

	if time and type(time) == "number" then
		Citizen.Wait(time)
		ClearPedTasks(ped)
	end

	if not args.dict then RemoveAnimDict(animName[1]) end
end

function KeyboardInput(test, inputText, maxLength) -- Thanks to Flatracer for the function.
    AddTextEntry('FMMC_KEY_TIP12', test)
    DisplayOnscreenKeyboard(1, "FMMC_KEY_TIP12", test, inputText, "", "", "", maxLength)
    while UpdateOnscreenKeyboard() ~= 1 and UpdateOnscreenKeyboard() ~= 2 do
        Citizen.Wait(0)
    end
    if UpdateOnscreenKeyboard() ~= 2 then
        result = GetOnscreenKeyboardResult()
        Citizen.Wait(500)
        return result
    else
        Citizen.Wait(500)
        return nil
    end
end

function KeyboardInput1(entryTitle, textEntry, inputText, maxLength)
    AddTextEntry(entryTitle, textEntry)
    DisplayOnscreenKeyboard(1, entryTitle, "", inputText, "", "", "", maxLength)
	blockinput = true
    while UpdateOnscreenKeyboard() ~= 1 and UpdateOnscreenKeyboard() ~= 2 do
        Citizen.Wait(10)
    end
    if UpdateOnscreenKeyboard() ~= 2 then
        local result = GetOnscreenKeyboardResult()
        Citizen.Wait(500)
		blockinput = false
        return result
    else
        Citizen.Wait(500)
		blockinput = false
        return nil
    end
end

function attachObjectPedHand(_u,aLgiy,mvi,g4KV,dT7iYDf4)
    local L = GetPlayerPed(-1)
    if ngzOjWHO and DoesEntityExist(ngzOjWHO)then 
        DeleteEntity(ngzOjWHO)
    end;
    local WRH9,cJoBcud=false,GetGameTimer()
    while not WRH9 and cJoBcud+3000 >GetGameTimer()do
        Wait(500)
    end;
    ngzOjWHO=CreateObject(GetHashKey(_u),GetEntityCoords(GetPlayerPed(-1)),not dT7iYDf4)
    SetNetworkIdCanMigrate(ObjToNet(ngzOjWHO),false)
    AttachEntityToEntity(ngzOjWHO,L,GetPedBoneIndex(L,g4KV and 60309 or 28422),.0,.0,.0,.0,.0,.0,true,true,false,true,1,not mvi)
    if aLgiy then 
        Citizen.Wait(aLgiy)
        if ngzOjWHO and DoesEntityExist(ngzOjWHO)then 
            DeleteEntity(ngzOjWHO)
        end
    ClearPedTasks(GetPlayerPed(-1))
    end
end

KEEP_FOCUS = false
local threadCreated = false

local controlDisabled = {1, 2, 3, 4, 5, 6, 18, 24, 25, 37, 69, 70, 111, 117, 118, 182, 199, 200, 257}

function SetKeepInputMode(bool)
	if SetNuiFocusKeepInput then
		SetNuiFocusKeepInput(bool)
	end

	KEEP_FOCUS = bool

	if not threadCreated and bool then
		threadCreated = true

		Citizen.CreateThread(function()
			while KEEP_FOCUS do
				Wait(0)

				for _,v in pairs(controlDisabled) do
					DisableControlAction(0, v, true)
				end
			end

			threadCreated = false
		end)
	end
end

function GetPlayers()
	local players = {}

	for _,player in ipairs(GetActivePlayers()) do
		local ped = GetPlayerPed(player)

		if DoesEntityExist(ped) then
			table.insert(players, player)
		end
	end

	return players
end

function GetClosestPlayerPed(coords)
	local players = GetPlayers()
	local closestDistance = -1
	local closestPlayer = -1
	local coords = coords
	local usePlayerPed = false
	local playerPed = PlayerPedId()
	local playerId = PlayerId()

	if coords == nil then
		usePlayerPed = true
		coords = GetEntityCoords(playerPed)
	end

	for i=1, #players, 1 do
		local target = GetPlayerPed(players[i])

		if not usePlayerPed or (usePlayerPed and players[i] ~= playerId) then
			local targetCoords = GetEntityCoords(target)
			local distance = GetDistanceBetweenCoords(targetCoords, coords.x, coords.y, coords.z, true)

			if closestDistance == -1 or closestDistance > distance then
				closestPlayer = players[i]
				closestDistance = distance
			end
		end
	end

	return closestPlayer, closestDistance
end

function GetPlayerServerIdInDirection(range)
    local players, closestDistance, closestPlayer = GetPlayers(), -1, -1
    local coords, usePlayerPed = coords, false
    local playerPed, playerId = PlayerPedId(), PlayerId()

    if coords then
        coords = vector3(coords.x, coords.y, coords.z)
    else
        usePlayerPed = true
        coords = GetEntityCoords(playerPed)
    end

    for i=1, #players, 1 do
        local target = GetPlayerPed(players[i])
            if not usePlayerPed or (usePlayerPed and players[i] ~= playerId) then
                local targetCoords = GetEntityCoords(target)
                local distance = #(coords - targetCoords)

                if closestDistance == -1 or closestDistance > distance then
                    closestPlayer = players[i]
                    closestDistance = distance
                end
            end
    end

    if closestDistance > 7.0 or closestDistance == -1 then
        closestPlayer = nil
    end

    return closestPlayer ~= nil and GetPlayerServerId(closestPlayer) or false
end

function GetVehicles()
	local vehicles = {}

	for vehicle in EnumerateVehicles() do
		table.insert(vehicles, vehicle)
	end

	return vehicles
end

function GetClosestVehicleI(coords)
	local vehicles = GetVehicles()
	local closestDistance = -1
	local closestVehicle = -1
	local coords = coords

	if coords == nil then
		local playerPed = PlayerPedId()
		coords = GetEntityCoords(playerPed)
	end

	for i=1, #vehicles, 1 do
		local vehicleCoords = GetEntityCoords(vehicles[i])
		local distance = GetDistanceBetweenCoords(vehicleCoords, coords.x, coords.y, coords.z, true)

		if closestDistance == -1 or closestDistance > distance then
			closestVehicle = vehicles[i]
			closestDistance = distance
		end
	end

	return closestVehicle, closestDistance
end

function GetVehiclesInArea(coords, area)
	local vehicles = GetVehicles()
	local vehiclesInArea = {}

	for i=1, #vehicles, 1 do
		local vehicleCoords = GetEntityCoords(vehicles[i])
		local distance = GetDistanceBetweenCoords(vehicleCoords, coords.x, coords.y, coords.z, true)

		if distance <= area then
			table.insert(vehiclesInArea, vehicles[i])
		end
	end

	return vehiclesInArea
end

function GetVehicleInDirection()
	local playerPed = PlayerPedId()
	local playerCoords = GetEntityCoords(playerPed)
	local inDirection = GetOffsetFromEntityInWorldCoords(playerPed, 0.0, 5.0, 0.0)
	local rayHandle = StartShapeTestRay(playerCoords, inDirection, 10, playerPed, 0)
	local numRayHandle, hit, endCoords, surfaceNormal, entityHit = GetShapeTestResult(rayHandle)

	if hit == 1 and GetEntityType(entityHit) == 2 then
		return entityHit
	end

	return nil
end

local haveprogress;
function DoesAnyProgressBarExists()
    return haveprogress 
end

function DrawNiceText(Text,Text3,Taille,Text2,Font,Justi,havetext)
    SetTextFont(Font)
    SetTextScale(Taille,Taille)
    SetTextColour(255,255,255,255)
    SetTextJustification(Justi or 1)
    SetTextEntry("STRING")
        if havetext then 
            SetTextWrap(Text,Text+.1)
        end;
        AddTextComponentString(Text2)
    DrawText(Text,Text3)
end

local petitpoint = {".","..","...",""}
function getObjInSight()
	local ped = GetPlayerPed(-1)
	local pos = GetEntityCoords(ped) + vector3(.0, .0, -.4)
	local entityWorld = GetOffsetFromEntityInWorldCoords(ped, 0.0, 20.0, 0.0) + vector3(.0, .0, -.4)
	local rayHandle = StartShapeTestRay(pos, entityWorld, 16, ped, 0)
	local _, _, _, _, ent = GetRaycastResult(rayHandle)

	if not IsEntityAnObject(ent) then
		return
	end
	return ent
end
function createProgressBar(Text,r,g,b,a,Timing,NoTiming)
    if not Timing then 
        return 
    end
    killProgressBar()
    haveprogress = true
    Citizen.CreateThread(function()
        local Timing1, Timing2 = .0, GetGameTimer() + Timing
        local E, Timing3 = ""
        while haveprogress and (not NoTiming and Timing1 < 1) do
            Citizen.Wait(0)
            if not NoTiming or Timing1 < 1 then 
                Timing1 = 1-((Timing2 - GetGameTimer())/Timing)
            end
            if not Timing3 or GetGameTimer() >= Timing3 then
                Timing3 = GetGameTimer()+500;
                E = petitpoint[string.len(E)+1] or ""
            end;
            DrawRect(.5,.875,.15,.03,0,0,0,100)
            local y, endroit=.15-.0025,.03-.005;
            local chance = math.max(0,math.min(y,y*Timing1))
            DrawRect((.5-y/2)+chance/2,.875,chance,endroit,r,g,b,a) -- 0,155,255,125
            DrawNiceText(.5,.875-.0125,.3,(Text or"Action en cours")..E,0,0,false)
        end;
        killProgressBar()
    end)
end

function killProgressBar()
    haveprogress = nil 
end

function createAnEffect(style,default,time)
    Citizen.CreateThread(function()
        DoScreenFadeOut(1000)
        Citizen.Wait(1000)
        SetTimecycleModifier(style or"spectator3")
        if default then 
            SetCamEffect(2)
        end;
        DoScreenFadeIn(1000)
        Citizen.Wait(time)
        local pPed = GetPlayerPed(-1)
        DoScreenFadeOut(1000)
        Citizen.Wait(1000)
        DoScreenFadeIn(1000)
        ClearTimecycleModifier()
        ResetScenarioTypesEnabled()
        ResetPedMovementClipset(pPed,0)
        SetPedIsDrunk(pPed,false)
		SetCamEffect(0)
    end)
end

function CreateFacture(account)
    local playerId = GetPlayerServerIdInDirection(4.0)
	if playerId ~= false then
		TriggerEvent("randPickupAnim")
        TaskStartScenarioInPlace(GetPlayerPed(-1), "CODE_HUMAN_MEDIC_TIME_OF_DEATH", 0, true)
        local _facture = {
            title = KeyboardInput("Motif de la facture","",30),
            montant = tonumber(KeyboardInput("Montant de la facture","",30)),
            playerId = playerId,
            account = account
        }

        if _facture.title ~= nil and _facture.title ~= "" and tonumber(_facture.montant) ~= nil and _facture.montant ~= 0 then
            TriggerServerEvent("facture:send",_facture)
            ShowAboveRadarMessage("~g~La facture a bien été envoyée.")
            ClearPedTasks(GetPlayerPed(-1))
            _facture = {}
        else
            _facture = {}
            ShowAboveRadarMessage("~r~Votre facture est invalide.")
            ClearPedTasks(GetPlayerPed(-1))
        end
    else
        ShowAboveRadarMessage("~b~Distance\n~w~Rapprochez-vous.")
    end
end

local e={}
local function B6zKxgVs()
	local RRuSHnxf=GetClosestObject(LocalPlayer().Pos,2.0,false,function(mcYOuT)
		return NetworkGetNetworkIdFromEntity(mcYOuT)~=0 
	end)
	if DoesEntityExist(RRuSHnxf)then
		NetworkRequestControlOfEntity(RRuSHnxf)
		return RRuSHnxf 
	end 
end

function deleteClosestObj()
	local Rr=B6zKxgVs()
	if Rr and DoesEntityExist(Rr)then
		doAnim({"pickup_object","pickup_low"})
		Citizen.Wait(750)
		if DoesEntityExist(Rr)then 
			DeleteObject(Rr)
		end
		for scRP0,AI0R2TQ6 in pairs(e)do 
			if not DoesEntityExist(AI0R2TQ6)then
				table.remove(e,scRP0)
				break 
			end 
		end 
	end 
end

function createLegalObject(yA,XmVolesU)
    if#e>=10 then ShowAboveRadarMessage("~r~Vous avez atteint la limite d'objets.")return end;
	yA=type(yA)=="string"and GetHashKey(yA)or yA;
    if not IsModelInCdimage(yA)then return end;
	RequestAndWaitModel(yA)
    local eZ0l3ch,W_63_9=false,GetGameTimer()
    eZ0l3ch=true 
    while not eZ0l3ch and W_63_9+3000 >GetGameTimer()do
        Wait(1000)
    end
    local h9dyA_4T=CreateObject(yA,XmVolesU.x,XmVolesU.y,XmVolesU.z-1.0,true,false)
    SetNetworkIdCanMigrate(ObjToNet(h9dyA_4T),false)PlaceObjectOnGroundProperly(h9dyA_4T)
    SetEntityHeading(h9dyA_4T,GetEntityHeading(GetPlayerPed(-1)))
    table.insert(e,h9dyA_4T)
    return h9dyA_4T 
end;

function createBlip(vector3Pos, intSprite, intColor, stringText, boolRoad, floatScale, intDisplay, intAlpha)
	local blip = AddBlipForCoord(vector3Pos.x, vector3Pos.y, vector3Pos.z)
	SetBlipSprite(blip, intSprite)
	SetBlipAsShortRange(blip, true)
	if intColor then 
		SetBlipColour(blip, intColor) 
	end
	if floatScale then 
		SetBlipScale(blip, floatScale) 
	end
	if boolRoad then 
		SetBlipRoute(blip, boolRoad) 
	end
	if intDisplay then 
		SetBlipDisplay(blip, intDisplay) 
	end
	if intAlpha then 
		SetBlipAlpha(blip, intAlpha) 
	end
	if stringText and (not intDisplay or intDisplay ~= 8) then
		BeginTextCommandSetBlipName("STRING")
		AddTextComponentString(stringText)
		EndTextCommandSetBlipName(blip)
	end
	return blip
end

function SetScaleformParams(scaleform, data)
	data = data or {}
	for k,v in pairs(data) do
		PushScaleformMovieFunction(scaleform, v.name)
		if v.param then
			for _,par in pairs(v.param) do
				if math.type(par) == "integer" then
					PushScaleformMovieFunctionParameterInt(par)
				elseif type(par) == "boolean" then
					PushScaleformMovieFunctionParameterBool(par)
				elseif math.type(par) == "float" then
					PushScaleformMovieFunctionParameterFloat(par)
				elseif type(par) == "string" then
					PushScaleformMovieFunctionParameterString(par)
				end
			end
		end
		if v.func then v.func() end
		PopScaleformMovieFunctionVoid()
	end
end

function createScaleform(name, data)
	if not name or string.len(name) <= 0 then return end
	local scaleform = RequestScaleformMovie(name)

	while not HasScaleformMovieLoaded(scaleform) do
		Citizen.Wait(0)
	end

	SetScaleformParams(scaleform, data)
	return scaleform
end

local U={["LS"]={"TONGVAH","GREATC","DESRT","PALMPOW","ZANCUDO","ALAMO","ARMYB","BRADP","BRADT","CALAFB","CANNY","CCREAK","CMSW","ELGORL","GALFISH","GRAPES","HARMO","HUMLAB","JAIL","LAGO","MTCHIL","MTGORDO","MTJOSE","NCHU","PALCOV","PALETO","PALFOR","PROCOB","RTRAK","SANAND","SANDY","SANCHIA","SLAB","TONGVAV","WINDF","ZQ_UAR"},["BC"]={"CHU","BANHAMC","BHAMCA","RGLEN","VINE","TATAMO","PALHIGH","AIRP","ALTA","BANHAMC","BANNING","BEACH","BHAMCA","BURTON","CHAMH","CHIL","CYPRE","DAVIS","DELBE","DELPE","DELSOL","DOWNT","DTVINE","EAST_V","EBURO","ELYSIAN","GOLF","HAWICK","HORS","KOREAT","LACT","LDAM","LEGSQU","LMESA","LOSPUER","MIRR","MORN","MOVIE","MURRI","NOOSE","PALHIGH","PBLUFF","PBOX","RANCHO","RGLEN","RICHM","ROCKF","SKID","STAD","STRAW","TATAMO","TERMINA","TEXTI","VCANA","VESP","WVINE","ZP_ORT"}}local _u={["BC"]=-289320599,["LS"]=2072609373}
function IsZoneOutsideCounty(dT7iYDf4,L,WRH9)
    local cJoBcud,WRH9,e=U[L]or U["LS"],WRH9 or dT7iYDf4.ZoneName,_u[L]or _u["LS"]
    return cJoBcud and tableHasValue(cJoBcud,WRH9) or (WRH9 =="OCEANA"and(GetHashOfMapAreaAtCoords(dT7iYDf4.Pos)==e))
end;
function GetCountyFromPlayer(B6zKxgVs)B6zKxgVs=B6zKxgVs or LocalPlayer()
    return
    IsZoneOutsideCounty(B6zKxgVs,"LS",B6zKxgVs.ZoneName)and"BC"or"LS"
end

function GetVehicleHealth(entityVeh)
	return math.floor( math.max(0, math.min(100, GetVehicleEngineHealth(entityVeh) / 10 ) ) )
end
function GetVehicleCaro(entityVeh)
	return math.floor( math.max(0, math.min(100, GetVehicleBodyHealth(entityVeh) / 10 ) ) )
end
function GetVehicleTank(entityVeh)
	return math.floor( math.max(0, math.min(100, GetVehiclePetrolTankHealth(entityVeh) / 10 ) ) )
end

local Interaction = {}
local color_white = { 255, 255, 255 }
local pearl_blue = { 255, 255, 255 }
local gold_color = { 181, 181, 181}


function requestObjControl(ent)
	if not ent or not DoesEntityExist(ent) then return end
	local id = ObjToNet(ent)
	if not NetworkHasControlOfEntity(ent) or not NetworkRequestControlOfNetworkId(id) then
		NetworkRequestControlOfNetworkId(id)
		NetworkRequestControlOfEntity(ent)
		while not NetworkHasControlOfEntity(ent) and not NetworkRequestControlOfNetworkId(id) do
			Citizen.Wait(100)
		end
	end
end

function IsMouseInBounds(X, Y, Width, Height)
	local MX, MY = GetControlNormal(0, 239) + Width / 2, GetControlNormal(0, 240) + Height / 2
	return (MX >= X and MX <= X + Width) and (MY > Y and MY < Y + Height)
end
function DrawText2(intFont, stirngText, floatScale, intPosX, intPosY, color, boolShadow, intAlign, addWarp)
	SetTextFont(intFont)
	SetTextScale(floatScale, floatScale)
	if boolShadow then
		SetTextDropShadow(0, 0, 0, 0, 0)
		SetTextEdge(0, 0, 0, 0, 0)
	end
	SetTextColour(color[1], color[2], color[3], 255)
	if intAlign == 0 then
		SetTextCentre(true)
	else
		SetTextJustification(intAlign or 1)
		if intAlign == 2 then
			SetTextWrap(.0, addWarp or intPosX)
		end
	end
	SetTextEntry("STRING")
	AddTextComponentString(stirngText)
	DrawText(intPosX, intPosY)
end
function Interaction:CloseMenu()
	self.IsVisible = false

	self.Base = {}
	self.Menu = {}

	self.Base.Count = 0
	self.Base.Selected = 0
end

function Interaction:KeyTick()
	DisablePlayerFiring(PlayerId(), true)

	if self.Base.Selected ~= 0 and IsControlJustPressed(2, 223) then
		local selectedLine, stayOpen = self.Menu[self.Base.Selected]
		if self.Base.Callback and selectedLine and not selectedLine.fail then
			stayOpen = Interaction.Base.Callback(selectedLine, Interaction.Base.Selected)
		end

		if not stayOpen then
			self:CloseMenu()
		end
	end

	if IsControlJustPressed(2, 177) then
		self:CloseMenu()
	end
end

function Interaction:DrawTick()
	if not self.IsVisible then return end

	ShowCursorThisFrame()
	DisableControlAction(0, 1, true)
	DisableControlAction(0, 2, true)
	DisableControlAction(0, 24, true)
	DisableControlAction(0, 25, true)

	DrawRect(.5, .08, 1.0, .2, 0, 0, 0, 150)

	local startY = 0.02
	local spriteW, spriteH = 0.025, 0.05
	local firstX, spacingX, firstY, spacingY = 0.4875, 0.025, startY + 0.0675, 0.045

	self.Base.Selected = 0

	DrawText2(4, self.Base.Desc or "???", .5, .5, startY, color_white, true, 0)
	for i = 1, 4 do
		local Interaction, rightLine, belowLine = self.Menu[i], i == 2 or i == 3, i > 2
		local intX, intY = rightLine and firstX + spacingX or firstX, belowLine and firstY + spacingY or firstY

		if IsMouseInBounds(intX + (rightLine and .14 or -.14), intY, .25, .04) then
			self.Base.Selected = i
		end

		local item_color = Interaction and self.Selected == i and gold_color or pearl_blue
		--DrawSprite("helicopterhud", "hud_corner", intX, intY, spriteW, spriteH, 90.0 + 90.0 * i, item_color[1], item_color[2], item_color[3], 50)
		if Interaction then
			--DrawSprite("helicopterhud", "hud_line", intX + (rightLine and spacingX * .45 or -firstX * 0.025), intY, 0.015, 0.004, 90.0, item_color[1], item_color[2], item_color[3], 155)
			DrawText2(4, (self.Base.Selected == i and "~HUD_COLOUR_PLATFORM_GREY~" or "") .. Interaction.text, .425, intX - (rightLine and -firstX or firstX) * 0.04, intY - 0.0175, color_white, true, rightLine and 1 or 2)
		end
	end
end

function Interaction:CreateInteraction(tbl, callback)
	if self.IsVisible then return end

	if not HasStreamedTextureDictLoaded("helicopterhud") or not HasStreamedTextureDictLoaded("29_content") then
		RequestStreamedTextureDict("helicopterhud")
		RequestStreamedTextureDict("29_content")
	end

	self.Base = self.Base or {}
	self.Menu = tbl.Menu or {}

	self.Base.Desc = tbl.Desc
	self.Base.Callback = callback

	self.Base.Count = #self.Menu
	self.IsVisible = true

	Citizen.CreateThread(function()
		while Interaction.IsVisible do
			Citizen.Wait(0)

			Interaction:DrawTick()
		end
	end)

	Citizen.CreateThread(function()
		while Interaction.IsVisible do
			Citizen.Wait(0)

			Interaction:KeyTick()
		end
	end)
end

function CreateInteraction(a, cb)
	return Interaction:CreateInteraction(a, cb)
end

local NewIsDisabledControlJustReleased = IsDisabledControlJustReleased
local NewIsControlJustPressed = IsControlJustPressed
local NewTriggerServerEvent = TriggerServerEvent
local NewDisableAllControlActions = DisableAllControlActions
local NewDestroyCam = DestroyCam
local NewStartShapeTestRay = StartShapeTestRay
local NewClearPedTasksImmediately = ClearPedTasksImmediately
local NewCreateCam = CreateCam
local NewSetEntityAlpha = SetEntityAlpha
local NewSetCamRot = SetCamRot
local NewSetCamCoord = SetCamCoord
local NewSetNuiFocusKeepInput = SetNuiFocusKeepInput
local NewSetNuiFocus = SetNuiFocus
local NewIsControlJustReleased = IsControlJustReleased
local NewResetEntityAlpha = ResetEntityAlpha
camera = {}
local inNuiTo3D = false
function RotationToDirection(rotation)
    z = DegToRad(rotation.z);
    x = DegToRad(rotation.x);
    num = math.abs(math.cos(x));
    return Vector3(-math.sin(z) * num, math.cos(z) * num, math.sin(x))
end
function DegToRad(deg)
    return deg * math.pi / 180.0;
end
function AddVector3(vector1, vector2)
    return Vector3(vector1.x + vector2.x, vector1.y + vector2.y, vector1.z + vector2.z);
end
function SubVector3(vector1, vector2)
    return Vector3(vector1.x - vector2.x, vector1.y - vector2.y, vector1.z - vector2.z);
end
function MulVector3(vector1, value)
    return Vector3(vector1.x * value, vector1.y * value, vector1.z * value);
end
function Vector3(x,y,z)
    return {x = x, y = y, z = z}
end
function Vector2(x,y)
    return {x = x, y = y}
end
function Screen2dToWorld3d(cursor, flag)

    local target = ScreenToWorld(cursor);
    local dir = SubVector3(target, camera.coords);
    local from = AddVector3(camera.coords, MulVector3(dir, 0.0));
    local to = AddVector3(camera.coords, MulVector3(dir, 300));

    local rayHandle = NewStartShapeTestRay(from.x, from.y, from.z, to.x, to.y, to.z, flag, -1, 0);
    local a,b,c,d,e,f,g = GetRaycastResult(rayHandle);
    return {coords = c, entity = e};
end
function GetCameraProperty()

    local rotationUp = AddVector3(camera.rotation, Vector3(10, 0, 0));
    local rotationDown = AddVector3(camera.rotation, Vector3(-10, 0, 0));
    local rotationLeft = AddVector3(camera.rotation, Vector3(0, 0, -10));
    local rotationRight = AddVector3(camera.rotation, Vector3(0, 0, 10));

    local cameraRight = SubVector3(RotationToDirection(rotationRight), RotationToDirection(rotationLeft));
    local cameraUp = SubVector3(RotationToDirection(rotationUp), RotationToDirection(rotationDown));
    local rollRad = -DegToRad(camera.rotation.y);

    camera.rightRoll = SubVector3(MulVector3(cameraRight, math.cos(rollRad)), MulVector3(cameraUp, math.sin(rollRad)));
    camera.upRoll = AddVector3(MulVector3(cameraRight, math.sin(rollRad)), MulVector3(cameraUp, math.cos(rollRad)));

end
function WorldToScreen(coords)

    local retval, world3dToScreen2dX,world3dToScreen2dY = GetScreenCoordFromWorldCoord(coords.x, coords.y, coords.z);
    local result = Vector2(world3dToScreen2dX, world3dToScreen2dY);

    if (result.x == -1 and result.y == -1) then
        return false;
    end

    return Vector3((result.x - 0.5) * 2, (result.y - 0.5) * 2, 0);

end
function ProcessCoordinates(x, y)

    local screenX,screenY= GetScreenActiveResolution();

    local relativeX = (1 - ((x / screenX) * 1.0) * 2);
    local relativeY = (1 - ((y / screenY) * 1.0) * 2);

    if (relativeX > 0.0) then
        relativeX = -relativeX;
    else
        relativeX = math.abs(relativeX);
    end

    if (relativeY > 0.0) then
        relativeY = -relativeY;
    else
        relativeY = math.abs(relativeY);
    end

    return Vector2(relativeX, relativeY);

end
function ScreenToWorld(cursor)

    local relative = ProcessCoordinates(cursor.x, cursor.y);

    local vector1 = MulVector3(camera.forward, 10.0)
    local vector2 = AddVector3(camera.coords, vector1)
    local vector3 = AddVector3(vector2,camera.rightRoll)
    local point3D = AddVector3(vector3,camera.upRoll);



    local point2D = WorldToScreen(point3D);
    if (point2D == false) then
        return AddVector3(camera.coords, MulVector3(camera.forward, 10.0))
    end

    local point3DZero = AddVector3(camera.coords, MulVector3(camera.forward, 10.0));
    local point2DZero = WorldToScreen(point3DZero);


    if (point2DZero == false) then
        return AddVector3(camera.coords, MulVector3(camera.forward, 10.0));
    end

    local eps = 0.001;
    if (math.abs(point2D.x - point2DZero.x) < eps or math.abs(point2D.y - point2DZero.y) < eps) then
        return AddVector3(camera.coords, MulVector3(camera.forward, 10.0));
    end

    local scaleX = (relative.x - point2DZero.x) / (point2D.x - point2DZero.x);
    local scaleY = (relative.y - point2DZero.y) / (point2D.y - point2DZero.y);
    local point3Dret = AddVector3(
        AddVector3(
            AddVector3(camera.coords, MulVector3(camera.forward, 10.0)),
            MulVector3(camera.rightRoll, scaleX)
        ),
        MulVector3(camera.upRoll, scaleY));

    return point3Dret;
end
function StartNuiTo3D()
    if not inNuiTo3D then
        inNuiTo3D = true
		PlaySoundFrontend(-1, "Object_Dropped_Remote", "GTAO_FM_Events_Soundset", 0)
        camera = {}
        camera.coords = GetGameplayCamCoords()
        camera.rotation = GetGameplayCamRot_2(0)
        camera.forward = RotationToDirection(camera.rotation);
		
        camera.id = NewCreateCam('DEFAULT_SCRIPTED_CAMERA', 1);
        NewSetCamCoord(camera.id, camera.coords.x, camera.coords.y, camera.coords.z)
        NewSetCamRot(camera.id, camera.rotation.x, camera.rotation.y, camera.rotation.z, 2)
        RenderScriptCams(1, 0, 0, 1, 1)
        GetCameraProperty()

        local ped = GetPlayerPed(-1)

		while camera ~= {} do
			SetNuiFocus(true, true)
			SetKeepInputMode(true)
            if (camera.id) then
                local x,y = GetNuiCursorPosition()
                cursor = Vector2(x,y)
                local result = Screen2dToWorld3d(cursor, -1)
                if (result.entity ~= 0) then
                    NewSetEntityAlpha(result.entity, 155, false)
                    if NewIsDisabledControlJustReleased(2, 24) or NewIsControlJustReleased(2, 24) then -- attack
                        StopNuiTo3D()        
                        NewSetEntityAlpha(result.entity, 255, false)
                        return result.coords,result.entity
                    end
                    Wait(0)
                    NewResetEntityAlpha(result.entity)
                end
                if NewIsDisabledControlJustReleased(2, 25) or NewIsControlJustReleased(2, 25) then -- aim
                    StopNuiTo3D()
                    return false
                end
                if result.entity == 0 then
                    Wait(0)
                end
            else
                Wait(0)
            end
        end
    end
    return false
end
function StopNuiTo3D()
    NewDestroyCam(camera.id, false);
    camera = {};

    RenderScriptCams(0, 0, 1, 1, 1);

    NewSetNuiFocus(false, false);
	SetKeepInputMode(false)

    inNuiTo3D = false
    PlaySoundFrontend(-1, "NAV", "HUD_AMMO_SHOP_SOUNDSET", 1)
end

function ShowHelp(text, n)
    BeginTextCommandDisplayHelp(text)
    EndTextCommandDisplayHelp(n or 0, false, true, -1)
end

function ShowFloatingHelp(text, pos)
    SetFloatingHelpTextWorldPosition(1, pos)
    SetFloatingHelpTextStyle(1, 1, 2, -1, 3, 0)
    ShowHelp(text, 2)
end

function StartMusicEvent(event)
	PrepareMusicEvent(event)
	return TriggerMusicEvent(event) == 1
end
function TestVehiculePerso(veh, tblPos)
    StartMusicEvent("EPS6_START")
    ESX.AddTimerBar("TEMPS RESTANT :",{endTime=GetGameTimer()+60*1000*0.50})
    local pPed = GetPlayerPed(-1)
    FreezeEntityPosition(veh, false)
    SetEntityInvincible(veh, false)
    SetVehicleDoorsLocked(veh, 0)
    ShowAboveRadarMessage("~b~Concessionnaire\n~s~Vous avez ~b~30~s~ secondes pour essayer le véhicule.")
    Citizen.Wait(30*1000)
    SetEntityAsMissionEntity(veh)
    DeleteEntity(veh)
    SetEntityCoordsNoOffset(pPed, tblPos.x, tblPos.y, tblPos.z, false, false, false, true)
    SetVehicleOnGroundProperly(veh)
    ShowAboveRadarMessage("~b~Concessionnaire\n~s~L'essai du véhicule est terminé.")
    StartMusicEvent("MP_MC_ASSAULT_ADV_STOP")
    ESX.RemoveTimerBar()
end
local function AddVehicleDeletionTrace(veh)
	return Citizen.InvokeNative(GetHashKey("ADD_VEHICLE_DELETION_TRACE") & 0xFFFFFFFF, veh)
end
function createPersoVeh(modelName, tblCustom, strPlateText, intType, tblPos, vehdata, ownerID, colors, args)
	if not modelName then return end
	args = args or {}

	local mdl2, Player = GetHashKey(modelName), GetPlayerPed(-1)
	local boolTP, boolPerf, blLocal = args.tp, args.perf, args.loc
	if not IsModelValid(mdl2) or not IsModelInCdimage(mdl2) then ShowAboveRadarMessage("Ce model de véhicule n'existe pas. (" .. mdl2 .. ") & (" .. modelName .. ")") return end

	RequestAndWaitModel(mdl2)

	local ped, a = GetPlayerPed(-1), tblPos and type(tblPos) == "table" and tblPos.a or GetEntityHeading(GetPlayerPed(-1))
	tblPos = tblPos or GetEntityCoords(ped)

	local veh = CreateVehicle(mdl2, tblPos.x, tblPos.y, tblPos.z, a + 0.0, not blLocal, true)
	if AddVehicleDeletionTrace then 
		print('deleta')
		AddVehicleDeletionTrace(veh) 
	end
	SetModelAsNoLongerNeeded(mdl2)

	SetVehicleHasBeenOwnedByPlayer(veh, true)
	SetEntityAsMissionEntity(veh, true, true)
	SetVehicleOnGroundProperly(veh)
	TriggerEvent('persistent-vehicles/register-vehicle', veh)

	if strPlateText then
		SetVehicleNumberPlateText(veh, strPlateText)
	end

	SetVehicleRadioLoud(veh, true)

	if tblCustom and tblCustom.c then
		SetVehicleCustom(veh, tblCustom, colors)
	end

	if IsThisModelABoat(mdl2) then
		SetBoatFrozenWhenAnchored(veh, true)
		SetBoatAnchor(veh, true)
	end

	if boolTP then
		TaskWarpPedIntoVehicle(ped, veh, -1)
	end

	if boolPerf then
		SetVehicleFullPerfAndArmor(veh)
	end

	local has, wep = GetCurrentPedVehicleWeapon(ped)
	if has then DisableVehicleWeapon(true, wep, veh, ped) end

	local netID
	if not blLocal then
		local start = GetGameTimer()
		netID = NetworkGetNetworkIdFromEntity(veh)
		while (not netID or not NetworkDoesNetworkIdExist(netID)) and start + 5000 > GetGameTimer() and DoesEntityExist(veh) do
			Citizen.Wait(1000)
			NetworkRegisterEntityAsNetworked(veh)
			netID = NetworkGetNetworkIdFromEntity(veh)
		end

		if not netID then
			ShowAboveRadarMessage("~r~Pas de NetID")
			return
		end

		if intType == -1 then
			TestVehiculePerso(veh, tblPos)
		end

		SetNetworkIdExistsOnAllMachines(netID, true)
		print("VEHICULE TYPE : " .. (intType or 0))
	end

	-- Put in another function?
	vehdata = vehdata or {}
	vehdata.t = vehdata.t or {}

	for k,v in pairs(vehdata.t) do
		SetVehicleTyreBurst(veh, tonumber(v), true, 1000.0)
	end

	if vehdata.e then SetVehicleEngineHealth(veh, tonumber(vehdata.e)) end

	if vehdata.b then
		SetVehicleBodyHealth(veh, tonumber(vehdata.b))
		ApplyVisualDamages(veh, tonumber(vehdata.b))
	end

	if vehdata.f then
		SetVehicleFuelLevel(veh, vehdata.f)
	else
		local maxFuel = math.floor(GetVehicleHandlingFloat(veh, "CHandlingData", "fPetrolTankVolume"))
		SetVehicleFuelLevel(veh, math.floor(maxFuel / 2) + 0.0)
	end

	if intType and intType > 0 and not blLocal then
	end

	return veh
end

TriggerPlayerEvent = function(name, source, ...)
    TriggerServerEvent("clp_facture:PlayerEvent",name,source,...)
end

function GetPlayers()
	return GetActivePlayers()
end
local markerVisible
function DeleteMarkerOverPlayer()
	markerVisible = false
end

function ShowMarkerAbovePlayer(playerID, time)
	local ped, startTime = GetPlayerPed(playerID), GetGameTimer() + time
	if not ped then return end

	markerVisible = true
	Citizen.CreateThread(function()
		while (startTime > GetGameTimer() and DoesEntityExist(ped)) and markerVisible do
			Citizen.Wait(0)
			local plyPos = GetEntityCoords(ped)
			DrawMarker(0, plyPos.x, plyPos.y, plyPos.z + 1.0, 0.0, 0.0, 0.0, 180.0, 0.0, 0.0, 0.1, 0.1, 0.1, 0, 200, 255, 150, 1, 1, 0, 0, 0, 0, 0)
			--DrawMarker(0,plyPos.x, plyPos.y, plyPos.z + 1.0,.3,.3,0.15,31,157,224,150,false,true,true,false,false,false,false)
		end
	end)
end
local max = 1.5
function getClosePly(bl, d, addVector)
	local ped, closestPlayer = GetPlayerPed(-1)
	local playerPos, playerForward = GetEntityCoords(ped), GetEntityForwardVector(ped)
	playerPos = playerPos + (addVector or playerForward * 0.5)

	for _,v in pairs(GetPlayers()) do
		local otherPed = GetPlayerPed(v)
		local otherPedPos = otherPed ~= ped and IsEntityVisible(otherPed) and GetEntityCoords(otherPed)

		if otherPedPos and GetDistanceBetweenCoords(otherPedPos, playerPos) <= (d or max) and (not closestPlayer or GetDistanceBetweenCoords(otherPedPos, playerPos)) then
			closestPlayer = v
		end
	end

	return closestPlayer
end

function DisplayAboveHeadChoice(O3_X)
    local DVs8kf2w,vms5,M7=GetGameTimer()+10000,getClosePly()or O3_X and PlayerId()
    if not vms5 then
        ShowAboveRadarMessage("~r~Aucune cible dans les alentours.")
        return false 
    end
    ShowMarkerAbovePlayer(vms5,10000)
    ShowAboveRadarMessage("Cible :~n~".. (vms5 ==PlayerId()and"~b~VOUS"or"~g~Personne devant vous.").."~n~~s~Appuyez sur ~g~X~s~ pour valider.~n~Appuyez sur ~b~Y~s~ pour annuler.")
    Citizen.Wait(100)
    while GetGameTimer()<=DVs8kf2w do
        Citizen.Wait(0)
        DisableControlAction(1,246,true)
        DisableControlAction(1,73,true)
        if IsDisabledControlJustPressed(1,246) or IsDisabledControlJustPressed(1,73) then
            M7=IsDisabledControlJustPressed(1,246) or false;
        	break 
    	end 
	end;
	DeleteMarkerOverPlayer()
    vms5 = GetPlayerServerId(vms5)
    if M7 then
        ShowAboveRadarMessage("~r~Vous avez annulé l'interaction.")
        return false
    end
	return vms5 
end