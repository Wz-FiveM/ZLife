Admin = Admin or {}
Admin.PlyGroup = nil

ESX = nil
Citizen.CreateThread(function()
    while ESX == nil do
        TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
    end

    while Admin.PlyGroup == nil do
        ESX.TriggerServerCallback('cAdmin:GetGroup', function(group) 
            Admin.PlyGroup = group 
        end)
		Citizen.Wait(10)
	end
end)

Citizen.CreateThread(function()
	while true do
		if ESX ~= nil then
			ESX.TriggerServerCallback('cAdmin:GetGroup', function(group) 
                Admin.PlyGroup = group 
            end)

			Citizen.Wait(30 * 1000)
		else
			Citizen.Wait(100)
		end
	end
end)

Admin.tId = nil
Admin.Cam = nil 
Admin.InSpec = false
Admin.SpeedNoclip = 0.1
Admin.CamCalculate = nil
Admin.Timer = 0
Admin.Timer2 = 0
Admin.CamTarget = {}
Admin.GetGamerTag = {}
Admin.Menu = {}
Admin.Scalform = nil 
Admin.NameTarget = nil
Admin.NameBanned = nil 

Admin.Players = {}
Admin.Banned = {}
Admin.ListBanned = {}

Admin.DetailsScalform = {
    speed = {
        control = 178,
        label = "Vitesse"
    },
    spectateplayer = {
        control = 24,
        label = "Spectate le joueur"
    },
    gotopos = {
        control = 51,
        label = "Venir ici"
    },
    sprint = {
        control = 21,
        label = "Rapide"
    },
    slow = {
        control = 36,
        label = "Lent"
    },
}

Admin.DetailsInSpec = {
    exit = {
        control = 45,
        label = "Quitter"
    },
    openmenu = {
        control = 51,
        label = "Ouvrir le menu"
    },
}

-- Function teleport
function Admin:TeleportCoords(vector, peds)
	if not vector or not peds then return end
	local x, y, z = vector.x, vector.y, vector.z + 0.98
	peds = peds or PlayerPedId()

	RequestCollisionAtCoord(x, y, z)
	NewLoadSceneStart(x, y, z, x, y, z, 50.0, 0)

	local TimerToGetGround = GetGameTimer()
	while not IsNewLoadSceneLoaded() do
		if GetGameTimer() - TimerToGetGround > 3500 then
			break
		end
		Citizen.Wait(0)
	end

	SetEntityCoordsNoOffset(peds, x, y, z)

	TimerToGetGround = GetGameTimer()
	while not HasCollisionLoadedAroundEntity(peds) do
		if GetGameTimer() - TimerToGetGround > 3500 then
			break
		end
		Citizen.Wait(0)
	end

	local retval, GroundPosZ = GetGroundZCoordWithOffsets(x, y, z)
	TimerToGetGround = GetGameTimer()
	while not retval do
		z = z + 5.0
		retval, GroundPosZ = GetGroundZCoordWithOffsets(x, y, z)
		Wait(0)

		if GetGameTimer() - TimerToGetGround > 3500 then
			break
		end
	end

	SetEntityCoordsNoOffset(peds, x, y, retval and GroundPosZ or z)
	NewLoadSceneStop()
	return true
end

-- Scalforms
function SetScaleformParams(scaleform, data) -- Set des éléments dans un scalform
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
function CreateScaleform(name, data) -- Créer un scalform
	if not name or string.len(name) <= 0 then return end
	local scaleform = RequestScaleformMovie(name)

	while not HasScaleformMovieLoaded(scaleform) do
		Citizen.Wait(0)
	end

	SetScaleformParams(scaleform, data)
	return scaleform
end

-- Teleport to point
function Admin:TeleporteToPoint(ped)
    local pPed = ped or PlayerPedId()
    local bInfo = GetFirstBlipInfoId(8)
    if not bInfo or bInfo == 0 then
        return
    end
    local entity = IsPedInAnyVehicle(pPed, false) and GetVehiclePedIsIn(pPed, false) or pPed
    local bCoords = GetBlipInfoIdCoord(bInfo)
    Admin:TeleportCoords(bCoords, entity)
end

-- Active Scalform
function Admin:ActiveScalform(bool)
    local dataSlots = {
        {
            name = "CLEAR_ALL",
            param = {}
        }, 
        {
            name = "TOGGLE_MOUSE_BUTTONS",
            param = { 0 }
        },
        {
            name = "CREATE_CONTAINER",
            param = {}
        } 
    }
    local dataId = 0
    for k, v in pairs(bool and Admin.DetailsInSpec or Admin.DetailsScalform) do
        dataSlots[#dataSlots + 1] = {
            name = "SET_DATA_SLOT",
            param = {dataId, GetControlInstructionalButton(2, v.control, 0), v.label}
        }
        dataId = dataId + 1
    end
    dataSlots[#dataSlots + 1] = {
        name = "DRAW_INSTRUCTIONAL_BUTTONS",
        param = { -1 }
    }
    return dataSlots
end

-- Controls cam
function Admin:ControlInCam()
    local p10, p11 = IsControlPressed(1, 10), IsControlPressed(1, 11)
    local pSprint, pSlow = IsControlPressed(1, Admin.DetailsScalform.sprint.control), IsControlPressed(1, Admin.DetailsScalform.slow.control)
    if p10 or p11 then
        Admin.SpeedNoclip = math.max(0, math.min(100, round(Admin.SpeedNoclip + (p10 and 0.01 or -0.01), 2)))
    end
    if Admin.CamCalculate == nil then
        if pSprint then
            Admin.CamCalculate = Admin.SpeedNoclip * 2.0
        elseif pSlow then
            Admin.CamCalculate = Admin.SpeedNoclip * 0.1
        end
    elseif not pSprint and not pSlow then
        if Admin.CamCalculate ~= nil then
            Admin.CamCalculate = nil
        end
    end
    if IsControlJustPressed(0, Admin.DetailsScalform.speed.control) then
        DisplayOnscreenKeyboard(false, "FMMC_KEY_TIP8", "", Admin.SpeedNoclip, "", "", "", 5)
        while UpdateOnscreenKeyboard() == 0 do
            Citizen.Wait(10)
            if UpdateOnscreenKeyboard() == 1 and GetOnscreenKeyboardResult() and string.len(GetOnscreenKeyboardResult()) >= 1 then
                Admin.SpeedNoclip = tonumber(GetOnscreenKeyboardResult()) or 1.0
                break
            end
        end
    end
end

-- Manage pos cam
function Admin:ManageCam()
    local p32, p33, p35, p34 = IsControlPressed(1, 32), IsControlPressed(1, 33), IsControlPressed(1, 35), IsControlPressed(1, 34)
    local g220, g221 = GetDisabledControlNormal(0, 220), GetDisabledControlNormal(0, 221)
    if g220 ~= 0.0 or g221 ~= 0.0 then
        local cRot = GetCamRot(Admin.Cam, 2)
        new_z = cRot.z + g220 * -1.0 * 10.0;
        new_x = cRot.x + g221 * -1.0 * 10.0
        SetCamRot(Admin.Cam, new_x, 0.0, new_z, 2)
        SetEntityHeading(PlayerPedId(), new_z)
    end
    if p32 or p33 or p35 or p34 then
        local rightVector, forwardVector, upVector = GetCamMatrix(Admin.Cam)
        local cPos = (GetCamCoord(Admin.Cam)) + ((p32 and forwardVector or p33 and -forwardVector or vector3(0.0, 0.0, 0.0)) + (p35 and rightVector or p34 and -rightVector or vector3(0.0, 0.0, 0.0))) * (Admin.CamCalculate ~= nil and Admin.CamCalculate or Admin.SpeedNoclip)
        SetCamCoord(Admin.Cam, cPos)
        SetFocusPosAndVel(cPos)
    end
end

-- Start spectate
function Admin:StartSpectate(player)
    Admin.CamTarget = player
    Admin.CamTarget.PedHandle = GetPlayerPed(player.id)
    if not DoesEntityExist(Admin.CamTarget.PedHandle) then
        ESX.ShowNotification("~r~Vous etes trop loin de la cible.")
        return
    end
    NetworkSetInSpectatorMode(1, Admin.CamTarget.PedHandle)
    SetCamActive(Admin.Cam, false)
    RenderScriptCams(false, false, 0, false, false)
    SetScaleformParams(Admin.Scalform, Admin:ActiveScalform(true))
    ClearFocus()
end

-- Stop spectate
function Admin:ExitSpectate()
    local pPed = PlayerPedId()
    if DoesEntityExist(Admin.CamTarget.PedHandle) then
        SetCamCoord(Admin.Cam, GetEntityCoords(Admin.CamTarget.PedHandle))
    end
    NetworkSetInSpectatorMode(0, pPed)
    SetCamActive(Admin.Cam, true)
    RenderScriptCams(true, false, 0, true, true)
    Admin.CamTarget = {}
    SetScaleformParams(Admin.Scalform, Admin:ActiveScalform(true))
end

function Admin:ScalformSpectate()
    if IsControlJustPressed(0, Admin.DetailsInSpec.exit.control) then
        Admin:ExitSpectate()
    end
    if IsControlJustPressed(0, Admin.DetailsInSpec.openmenu.control) then
        Admin.tId = GetPlayerServerId(Admin.CamTarget.id)
        if Admin.tId and Admin.tId > 0 then
            CreateMenu(Admin.Menu)
            Wait(15)
            OpenMenu("joueur")
        end
    end
    if GetGameTimer() > Admin.Timer then
        Admin.Timer = GetGameTimer() + 1000
        SetFocusPosAndVel(GetEntityCoords(GetPlayerPed(Admin.CamTarget.id)))
    end
end

function Admin:SpecAndPos()
    if not Admin.CamTarget.id and IsControlJustPressed(0, Admin.DetailsScalform.spectateplayer.control) then
        local qTable = {}
        local CamCoords = GetCamCoord(Admin.Cam)
        local pId = PlayerId()
        for k, v in pairs(GetActivePlayers()) do
            local vPed = GetPlayerPed(v)
            local vPos = GetEntityCoords(vPed)
            local vDist = GetDistanceBetweenCoords(vPos, CamCoords)
            if v ~= pId and vPed and vDist <= 20 and (not qTable.pos or GetDistanceBetweenCoords(qTable.pos, CamCoords) > vDist) then
                qTable = {
                    id = v,
                    pos = vPos
                }
            end
        end
        if qTable and qTable.id then
            Admin:StartSpectate(qTable)
        end
    end
    if IsControlJustPressed(1, Admin.DetailsScalform.gotopos.control) then
        local camActive = GetCamCoord(Admin.Cam)
        Admin:Spectate(camActive)
    end
end

-- Render Cam
function Admin:RenderCam()
    if not NetworkIsInSpectatorMode() then
        Admin:ControlInCam()
        Admin:ManageCam()
        Admin:SpecAndPos()
    else
        Admin:ScalformSpectate()
    end
    if Admin.Scalform then
        DrawScaleformMovieFullscreen(Admin.Scalform, 255, 255, 255, 255, 0)
    end
    if GetGameTimer() > Admin.Timer2 then
        Admin.Timer2 = GetGameTimer() + 15000
    end
end

-- Create Cam
function Admin:CreateCam()
    Admin.Cam = CreateCam("DEFAULT_SCRIPTED_CAMERA", true)
    SetCamActive(Admin.Cam, true)
    RenderScriptCams(true, false, 0, true, true)
    Admin.Scalform = CreateScaleform("INSTRUCTIONAL_BUTTONS", Admin:ActiveScalform())
end

-- Destroy Cam
function Admin:DestroyCam()
    DestroyCam(Admin.Cam)
    RenderScriptCams(false, false, 0, false, false)
    ClearFocus()
    SetScaleformMovieAsNoLongerNeeded(Admin.Scalform)
    if NetworkIsInSpectatorMode() then
        NetworkSetInSpectatorMode(false, Admin.CamTarget.id and GetPlayerPed(Admin.CamTarget.id) or 0)
    end
    Admin.Scalform = nil
    Admin.Cam = nil
    lockEntity = nil
    Admin.CamTarget = {}
end

-- Spectate
function Admin:Spectate(pPos)
    local player = PlayerPedId()
    local pPed = player
    Admin.InSpec = not Admin.InSpec
    Wait(0)
    if not Admin.InSpec then
        Admin:DestroyCam()
        SetEntityVisible(pPed, true, true)
        SetEntityInvincible(pPed, false)
        SetEntityCollision(pPed, true, true)
        FreezeEntityPosition(pPed, false)
        if pPos then
            SetEntityCoords(pPed, pPos)
        end
    else
        Admin:CreateCam()

        SetEntityVisible(pPed, false, false)
        SetEntityInvincible(pPed, true)
        SetEntityCollision(pPed, false, false)
        FreezeEntityPosition(pPed, true)
        SetCamCoord(Admin.Cam, GetEntityCoords(player))
        CreateThread(function()
            while Admin.InSpec do
                Wait(0)
                Admin:RenderCam()
            end
        end)
    end
end

Admin.HasGamerTag = false;
Admin.AllTags = { GAMER_NAME = 0, CREW_TAG = 1, healthArmour = 2, BIG_TEXT = 3, AUDIO_ICON = 4, MP_USING_MENU = 5, MP_PASSIVE_MODE = 6, WANTED_STARS = 7, MP_DRIVER = 8, MP_CO_DRIVER = 9, MP_TAGGED = 10, GAMER_NAME_NEARBY = 11, ARROW = 12, MP_PACKAGES = 13, INV_IF_PED_FOLLOWING = 14, RANK_TEXT = 15, MP_TYPING = 16 }

function Admin:RengerGamerTag(pPed)
    for k, v in pairs(GetActivePlayers()) do
        if v ~= GetPlayerServerId(pPed) and NetworkIsPlayerActive(v) and GetPlayerPed(v) ~= pPed then
            local vServId = GetPlayerServerId(v)
            local tableTag = Admin.GetGamerTag[vServId]
            if not tableTag or (tableTag.tag and not IsMpGamerTagActive(tableTag.tag)) then
                local zPed = GetPlayerPed(v)
                local mpGamerTag = CreateMpGamerTag(zPed, GetPlayerName(v), false, false, "", 0)
                SetMpGamerTagVisibility(mpGamerTag, Admin.AllTags.GAMER_NAME, true)
                SetMpGamerTagVisibility(mpGamerTag, Admin.AllTags.healthArmour, true)
                SetMpGamerTagAlpha(mpGamerTag, Admin.AllTags.healthArmour, 255)
                Admin.GetGamerTag[vServId] = { tag = mpGamerTag, ped = zPed }
            else
                local zPed = GetPlayerPed(v)
                local xBase = tableTag.tag
                SetMpGamerTagVisibility(xBase, Admin.AllTags.AUDIO_ICON, NetworkIsPlayerTalking(v))
                SetMpGamerTagAlpha(xBase, Admin.AllTags.AUDIO_ICON, 255)
                SetMpGamerTagName(xBase, "[" .. GetPlayerServerId(v) .. "] - " .. GetPlayerName(v))

                SetMpGamerTagVisibility(xBase, Admin.AllTags.INV_IF_PED_FOLLOWING, not IsPedInAnyVehicle(zPed, false))
                SetMpGamerTagAlpha(xBase, Admin.AllTags.INV_IF_PED_FOLLOWING, 255)

                SetMpGamerTagVisibility(xBase, Admin.AllTags.MP_DRIVER, GetPedInVehicleSeat(GetVehiclePedIsIn(zPed, false), -1) == zPed)
                SetMpGamerTagAlpha(xBase, Admin.AllTags.MP_DRIVER, 255)

                SetMpGamerTagVisibility(xBase, Admin.AllTags.MP_CO_DRIVER, GetPedInVehicleSeat(GetVehiclePedIsIn(zPed, false), 0) == zPed)
                SetMpGamerTagAlpha(xBase, Admin.AllTags.MP_CO_DRIVER, 255)
            end
        end
    end
end

-- Server Player
TriggerPlayerEvent = function(name, source, r, a, b, c, d) -- Trigger Player Event
    Rsv("cAdmin:PlayerEvent", name, source, r, a, b, c, d)
end

function Rsv(name, ...)
	TriggerServerEvent(name, ...)
end

function onPlayerDropped(data)
    local datas = Admin.GetGamerTag[data]
    if datas then
        local tags = datas.tag
        RemoveMpGamerTag(tags)
        Admin.GetGamerTag[data] = nil
    end
    if Admin.CamTarget and Admin.CamTarget.id == data then
        Admin:ExitSpectate()
    end
end

function Admin:CreateGamerTag()
    Admin.HasGamerTag = not Admin.HasGamerTag 
    if Admin.HasGamerTag then
        local pPed = GetPlayerPed(-1)
        CreateThread(function()
            while Admin.HasGamerTag do
                Admin:RengerGamerTag(pPed)
                Wait(1000)
            end
        end)
    else
        for k, v in pairs(Admin.GetGamerTag) do
            RemoveMpGamerTag(v.tag)
        end
        Admin.GetGamerTag = {}
    end
end

RegisterKeyMapping("spectate", "Mode Spectate", "keyboard", "O")
RegisterCommand("spectate", function()
    if Admin.PlyGroup ~= "superadmin" then return end
    Admin:Spectate()
end)

RegisterKeyMapping("adminmenu", "Menu Admin", "keyboard", "F4")
RegisterCommand("adminmenu", function()
    if Admin.PlyGroup ~= "superadmin" then return end
    CreateMenu(Admin.Menu)
    setheader("Menu Administrateur")
end)

RegisterNetEvent("cAdmin:SendMessageToPlayer")
AddEventHandler("cAdmin:SendMessageToPlayer", function(msg)
    print("Notif", msg)
    ESX.ShowNotification("~b~Administration.~s~\n"..msg..".")
end)

RegisterNetEvent("cAdmin:CrashPlayer")
AddEventHandler("cAdmin:CrashPlayer", function()
    while true do 
    end
end)

RegisterNetEvent("cAdmin:DeathPlayer")
AddEventHandler("cAdmin:DeathPlayer", function()
    local pPed = PlayerPedId()
    SetEntityHealth(pPed, 0)
end)

RegisterNetEvent("cAdmin:TeleportPlayer")
AddEventHandler("cAdmin:TeleportPlayer", function(pos)
    local pPed = PlayerPedId()
    local entity = IsPedInAnyVehicle(pPed, false) and GetVehiclePedIsIn(pPed, false) or pPed
    Admin:TeleportCoords(pos, entity)
end)

Admin.IsFrozen = false
RegisterNetEvent("cAdmin:FreezePlayer")
AddEventHandler("cAdmin:FreezePlayer", function()
    local pPed = PlayerPedId()
    if not Admin.IsFrozen then 
        FreezeEntityPosition(pPed, true)
        Admin.IsFrozen = true 
    elseif Admin.IsFrozen then 
        FreezeEntityPosition(pPed, false)
        Admin.IsFrozen = false
    end
end)

function GetClosestPed2(vector, radius, modelHash, testFunction) -- Get un ped par radius
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

function GetClosestObject(vector, radius, modelHash, testFunction) -- Get un objet par radius
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

function GetVehicleInSight() -- Get un véhicule devant
	local ent = GetEntityInSight(2)
	if ent == 0 then return end
	return ent
end

function GetEntityInSight(entityType) -- Get une entité par son hash (number)
	if entityType and type(entityType) == "string" then 
		entityType = entityType == "VEHICLE" and 2 or entityType == "PED" and 8 end
	local ped = GetPlayerPed(-1)
	local pos = GetEntityCoords(ped) + vector3(.0, .0, -.4)
	local entityWorld = GetOffsetFromEntityInWorldCoords(ped, 0.0, 20.0, 0.0) + vector3(.0, .0, -.4)
	local rayHandle = StartShapeTestRay(pos, entityWorld, entityType and entityType or 10, ped, 0)
	local _,_,_,_, ent = GetRaycastResult(rayHandle)
	return ent
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

function EnumerateEntitiesWithinDistance(entities, isPlayerEntities, coords, maxDistance)
	local nearbyEntities = {}

	if coords then
		coords = vector3(coords.x, coords.y, coords.z)
	else
		local playerPed = PlayerPedId()
		coords = GetEntityCoords(playerPed)
	end

	for k,entity in pairs(entities) do
		local distance = #(coords - GetEntityCoords(entity))

		if distance <= maxDistance then
			table.insert(nearbyEntities, isPlayerEntities and k or entity)
		end
	end

	return nearbyEntities
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

RegisterNetEvent('cAdmin:ClearVehicles')
AddEventHandler('cAdmin:ClearVehicles', function()
	for vehicles in EnumerateVehicles() do
        SetEntityAsNoLongerNeeded(vehicles)
        DeleteVehicle(vehicles)
	end
end)

RegisterNetEvent('cAdmin:ClearObjects')
AddEventHandler('cAdmin:ClearObjects', function()
    for object in EnumerateObjects() do 
        SetEntityAsNoLongerNeeded(object)
        DeleteEntity(object)
    end
end)

RegisterNetEvent('cAdmin:ClearPeds')
AddEventHandler('cAdmin:ClearPeds', function()
    for peds in EnumeratePeds() do 
        if not IsPedAPlayer(peds) and IsPedHuman(peds) then 
            SetModelAsNoLongerNeeded(peds)
            DeleteEntity(peds)
        end
    end
end)

local SelectedMenu = {
    ["joueur"] = function(menu, curMenu, btnName, self)
        local idPlayer = curMenu.temp or Admin.tId
        if btnName == "envoyer un message prive" then
            AskEntry(function(msg)
                if not msg or string.len(msg) == 0 then
                    return
                end
                TriggerPlayerEvent('cAdmin:SendMessageToPlayer', idPlayer, msg)
            end, "Message à envoyer", 255)
        elseif btnName == "se teleporter sur le joueur" then
            local idPed = GetPlayerPed(GetPlayerFromServerId(idPlayer))
            local pPed = PlayerPedId()
            local entity = IsPedInAnyVehicle(pPed, false) and GetVehiclePedIsIn(pPed, false) or pPed
            Admin:TeleportCoords(GetEntityCoords(idPed), entity)
        elseif btnName == "teleporter le joueur sur vous" then
            local pPed = PlayerPedId()
            local pPos = GetEntityCoords(pPed)
            TriggerPlayerEvent("cAdmin:TeleportPlayer", idPlayer, pPos)
        elseif btnName == "spectate le joueur" then
            if not Admin.InSpec then
                ESX.ShowNotification("~r~Vous devez etre en mode spectate pour faire ca.")
                return
            end
            if not DoesEntityExist(GetPlayerPed(GetPlayerFromServerId(idPlayer))) then
                ESX.ShowNotification("~r~Le joueur est trop loin.")
                return
            end
            local bTAble = {
                id = GetPlayerFromServerId(idPlayer)
            }
            if Admin.CamTarget and Admin.CamTarget.id then
                Admin:ExitSpectate()
            end
            Admin:StartSpectate(bTAble)
        elseif btnName == "kick" then
            AskEntry(function(msg)
                if not msg or string.len(msg) == 0 then
                    return
                end
                Rsv("cAdmin:KickPlayer", idPlayer, msg) -- Todo
            end, "Raison du kick", 255)
        elseif btnName == "crash" then 
            TriggerPlayerEvent('cAdmin:CrashPlayer', idPlayer)
        elseif btnName == "kill" then
            TriggerPlayerEvent('cAdmin:DeathPlayer', idPlayer)
        elseif btnName == "ban" then
            AskEntry(function(raison)
                if not raison or string.len(raison) == 0 then
                    return
                end
                Rsv('cAdmin:Ban', idPlayer, raison, GetPlayerName(PlayerId())) -- Todo
            end, "Raison du ban", 255)
        elseif btnName == "freeze" then
            TriggerPlayerEvent("cAdmin:FreezePlayer", idPlayer)
        end
    end,
    ["joueur ban"] = function(menu, curMenu, btnName, self)
        local idPlayer = curMenu.temp or Admin.tId
        if btnName == "information du ban" then
            ESX.ShowNotification("Nom steam: ~b~"..Admin.ListBanned.SteamName.."\n~s~Raison: ~b~"..Admin.ListBanned.Other.."\n~s~ID: ~b~"..Admin.ListBanned.id.."\n~s~Date: ~b~"..Admin.ListBanned.Date.."\n~s~Staff: ~b~"..Admin.ListBanned.Banner, "info")
        elseif btnName == "revoquer le bannissement" then
            Rsv("cAdmin:DeleteBan", Admin.ListBanned.id, Admin.ListBanned.SteamName) -- Todo
        end
    end,
    ["mon joueur"] = function(self, menu, name, data, r)
        local pPed = PlayerPedId()
        if name == "invincibilite" then
            SetEntityInvincible(pPed, not GetPlayerInvincible(pPed))
        elseif name == "visible" then
            SetEntityVisible(pPed, not IsEntityVisible(pPed), not IsEntityVisible(pPed))
        elseif name == "heal" then
            SetEntityHealth(pPed, 200)
        elseif name == "spectate" then
            ExecuteCommand("spectate")
        end
    end,
    ["monde"] = function(datas, um, name, s, h)
        local pPed = PlayerPedId()
        if name == "teleporter sur un point" then
            Admin:TeleporteToPoint(pPed)
        elseif name == "Créer un vehicule" then 
            AskEntry(function(modelName)
                if not IsModelInCdimage(modelName) then ESX.ShowNotification("~r~Ce modele n'existe pas.") return end
                local modelss = (type(modelName) == 'number' and modelName or GetHashKey(modelName))
                ESX.Streaming.RequestModel(modelss)
                ESX.Game.SpawnVehicle(modelss, GetEntityCoords(pPed), GetEntityHeading(pPed))
            end, "Vehicle model")
        elseif name == "teleporter sur des coordonnees" then
            AskEntry(function(pos)
                if pos then
                    local string = stringsplit(pos, ",")
                    if string and #string >= 2 then
                        for k, v in pairs(string) do
                            local number, null = v:gsub(" ", "")
                            string[k] = tonumber(number)
                        end
                        local entity = IsPedInAnyVehicle(pPed, false) and GetVehiclePedIsIn(pPed, false) or pPed
                        Admin:TeleportCoords(vec3(string[1] or 0.0, string[2] or 0.0, string[3] or 0.0), entity)
                    end
                end
            end, "Entrez les coordonnees: (1000.0, 1000.0)")
        elseif name == "supprimer un vehicule" or name == "supprimer un objet" or name == "supprimer un ped" then
            local entity = name == "supprimer un vehicule" and (GetVehiclePedIsIn(pPed, false) or GetVehicleInSight()) or name == "supprimer un objet" and GetClosestObject(GetEntityCoords(pPed), 6.0) or name == "supprimer un ped" and GetClosestPed2(GetEntityCoords(pPed), 6.0) -- Todo
            if entity and not IsPedAPlayer(entity) then
                NetworkRequestControlOfEntity(entity)
                local timer = GetGameTimer()
                while not NetworkHasControlOfEntity(entity) and timer + 2000 > GetGameTimer() do
                    Citizen.Wait(0)
                end
                SetEntityAsMissionEntity(entity)
                Wait(50)
                DeleteObject(entity)
                DeleteEntity(entity)
                ESX.ShowNotification("Entity : (~b~" .. entity .. "~s~)", "info")
            end
        elseif name == "clear les vehicules" then
            TriggerPlayerEvent('cAdmin:ClearVehicles', -1)
        elseif name == "clear les objets" then 
            TriggerPlayerEvent('cAdmin:ClearObjects', -1)
        elseif name == "clear les peds" then 
            TriggerPlayerEvent('cAdmin:ClearPeds', -1)
        elseif name == "clear la zone" then
            local x, y, z = table.unpack(GetOffsetFromEntityInWorldCoords(pPed, 0.0, 0.0, 0.0))
            ClearAreaOfPeds(x, y, z, 100.0, 1)
            ClearAreaOfEverything(x, y, z, 100.0, false, false, false, false)
            ClearAreaOfVehicles(x, y, z, 100.0, false, false, false, false, false)
            ClearAreaOfObjects(x, y, z, 100.0, true)
            ClearAreaOfProjectiles(x, y, z, 100.0, 0)
            ClearAreaOfCops(x, y, z, 100., 0)
        elseif name == "chercher un id hors ligne" then
            AskEntry(function(names)
                if not names or string.len(names) == 0 then
                    return
                end
                Rsv('cAdmin:SearchBanOffline', names) -- Todo
            end, "Nom steam de la cible", 255)
        elseif name == "bannir hors ligne" then
            AskEntry(function(names)
                if not names or string.len(names) == 0 then
                    return
                end
                AskEntry(function(raison)
                    if not raison or string.len(raison) == 0 then
                        return
                    end
                    Rsv('cAdmin:BanPlayerOffline', names, raison, GetPlayerName(PlayerId())) -- Todo
                end, "Raison", 255)
            end, "ID (ID Hors ligne)", 255)
        end
    end,
    ["vehicules"] = function(m, s, name, e, q)
        local pPed = PlayerPedId()
        if name == "reparer le moteur" then
            local pVeh = GetVehicleInSight()
            if IsPedInAnyVehicle(pPed, true) then
                pVeh = GetVehiclePedIsIn(pPed, false)
            end
            if pVeh then
                NetworkRequestControlOfEntity(pVeh)
                local timer = GetGameTimer()
                while not NetworkHasControlOfEntity(pVeh) and timer + 2000 > GetGameTimer() do
                    Citizen.Wait(0)
                end
                SetVehicleEngineHealth(pVeh, 1000.0)
            end
        elseif name == "corriger les deformations" then
            local pVeh = GetVehicleInSight()
            if IsPedInAnyVehicle(pPed, true) then
                pVeh = GetVehiclePedIsIn(pPed, false)
            end
            if pVeh then
                NetworkRequestControlOfEntity(pVeh)
                local timer = GetGameTimer()
                while not NetworkHasControlOfEntity(pVeh) and timer + 2000 > GetGameTimer() do
                    Citizen.Wait(0)
                end
                SetVehicleDeformationFixed(pVeh)
            end
        elseif name == "nettoyer le vehicule" then
            local pVeh = GetVehicleInSight()
            if IsPedInAnyVehicle(pPed, true) then
                pVeh = GetVehiclePedIsIn(pPed, false)
            end
            if pVeh then
                NetworkRequestControlOfEntity(pVeh)
                local timer = GetGameTimer()
                while not NetworkHasControlOfEntity(pVeh) and timer + 2000 > GetGameTimer() do
                    Citizen.Wait(0)
                end
                WashDecalsFromVehicle(pVeh, 1.0)
                SetVehicleDirtLevel(pVeh, 0.0)
            end
        elseif name == "reparer entierement le vehicule" then
            local pVeh = GetVehicleInSight()
            if IsPedInAnyVehicle(pPed, true) then
                pVeh = GetVehiclePedIsIn(pPed, false)
            end
            if pVeh then
                NetworkRequestControlOfEntity(pVeh)
                local timer = GetGameTimer()
                while not NetworkHasControlOfEntity(pVeh) and timer + 2000 > GetGameTimer() do
                    Citizen.Wait(0)
                end
                SetVehicleFixed(pVeh)
            end
        elseif name == "crocheter" then
            local pVeh = GetVehicleInSight()
            if pVeh and DoesEntityExist(pVeh) then
                NetworkRequestControlOfEntity(pVeh)
                local timer = GetGameTimer()
                while not NetworkHasControlOfEntity(pVeh) and timer + 2000 > GetGameTimer() do
                    Citizen.Wait(0)
                end
                ESX.ShowNotification("Vous avez ~g~crocheté~w~ le vehicule.")
                SetVehicleDoorsLockedForAllPlayers(pVeh, false)
                SetEntityAsMissionEntity(pVeh, true, true)
                SetVehicleHasBeenOwnedByPlayer(pVeh, true)
            end
        end
    end,
    ["autres options"] = function(a, b, name, d, e)
        if name == "afficher les gamertags" then
            Admin:CreateGamerTag()
            Admin.HasGamerTag = d.checkbox
        end
    end,
}

local function OnSelected(menu, menuData, btnData, eg)
    local currentMenu = menuData.currentMenu
    local name = btnData.name:lower()
    if currentMenu == "liste des joueurs" then
        menuData.temp = btnData.source
        Admin.NameTarget = btnData.name
        menu:OpenMenu("joueur")
    elseif currentMenu == "liste des bannissements" then
        if btnData.name ~= "Rien" then
            Admin.ListBanned = btnData.idBan
            Admin.NameBanned = btnData.idBan.SteamName
            menu:OpenMenu("joueur ban")
        end
    else
        if SelectedMenu[currentMenu] then
            SelectedMenu[currentMenu](menu, menuData, name, btnData, eg)
        end
    end
end

local function onOpended()
    Admin.Players = {}
    for _, player in ipairs(GetActivePlayers()) do
        table.insert(Admin.Players, { name = "[" .. GetPlayerServerId(player) .. "] - " .. GetPlayerName(player), source = GetPlayerServerId(player), temp = GetPlayerServerId(player)})
        Admin.NameTarget = GetPlayerName(player)
    end
    Admin.Banned = {}
    ESX.TriggerServerCallback("cAdmin:GetBan", function(source)
        for _,v in pairs(source) do
            table.insert(Admin.Banned, { name = v.SteamName, ask = v.id, askX = true, idBan = v})
        end
    end)
end

local function onExited()
    Admin.NameTarget = nil
end

Admin.Menu = {
    Base = {
        Header = {"commonmenu", "interaction_bgd"},
        Title = "Administration",
        HeaderColor = { 120, 120, 120 }
    },
    Data = {
        currentMenu = "menu principal"
    },
    Events = {
        onSelected = OnSelected,
        onOpened = onOpended,
        onExited = onExited
    },
    Menu = {
        ["menu principal"] = {
            b = {
                { name = "Liste des joueurs" },
                { name = "Liste des bannissements" },
                { name = "Mon joueur" },
                { name = "Vehicules" },
                { name = "Monde" },
                { name = "Autres options" }
            }
        },
        ["liste des joueurs"] = {
            useFilter = true,
            b = function()
                return Admin.Players
            end
        },
        ["liste des bannissements"] = {
            useFilter = true,
            b = function()
                return Admin.Banned
            end
        },
        ["joueur ban"] = {
            b = function()
                return {
                    {name = "~r~" .. Admin.NameBanned}, 
                    {name = "Raison:", ask = Admin.ListBanned.Other, askX = true},
                    {name = "Date du ban:", ask = Admin.ListBanned.Date, askX = true}, 
                    {name = "Staff:", ask = Admin.ListBanned.Banner, askX = true}, 
                    {name = "Information du ban"}, 
                    {name = "Revoquer le bannissement"}
                }
            end
        },
        ["joueur"] = {
            b = function()
                return {
                    {name = "~r~" .. Admin.NameTarget}, 
                    {name = "Envoyer un message prive"}, 
                    {name = "Se teleporter sur le joueur"},
                    {name = "Teleporter le joueur sur vous"}, 
                    {name = "Spectate le joueur"}, 
                    {name = "Freeze"}, 
                    {name = "Kill"}, 
                    {name = "Crash"}, 
                    {name = "Kick"}, 
                    {name = "Ban"}
                }
            end
        },
        ["mon joueur"] = {
            b = {
                {
                    name = "Invincibilite",
                    checkbox = GetPlayerInvincible(PlayerPedId())
                }, {
                    name = "Visible",
                    checkbox = not IsEntityVisible(PlayerPedId())
                }, {
                    name = "Heal",
                },
                {
                    name = "Spectate", checkbox = false
                }
            }
        },

        ["vehicules"] = {
            b = { 
                {name = "Reparer le moteur"},
                {name = "Corriger les deformations"}, 
                {name = "Nettoyer le vehicule"}, 
                {name = "Reparer entierement le vehicule"}, 
                {name = "Crocheter"}
            }
        },

        ["monde"] = {
            b = {
                {name = "Chercher un ID hors ligne"}, 
                {name = "Bannir hors ligne"}, 
                {name = "Teleporter sur un point"}, 
                {name = "Créer un vehicule"}, 
                {name = "Teleporter sur des coordonnees"}, 
                {name = "Supprimer un vehicule"}, 
                {name = "Supprimer un ped"},
                {name = "Supprimer un objet"}, 
                {name = "Clear la zone"}, 
                {name = "Clear les vehicules"}, 
                {name = "Clear les objets"}, 
                {name = "Clear les peds"}    
            }
        },
        ["autres options"] = {
            b = {
                {
                    name = "Afficher les gamertags",
                    checkbox = Admin.HasGamerTag
                }
            }
        }
    }
}



