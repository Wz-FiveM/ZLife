local PlayerData = {}
local dragStatus = {}
dragStatus.isDragged = false
local IsHandcuffed = false 
local isPlayerSpawned = false
local enaction = false 
local mvil = {}

local ngzOjWHO=false
RegisterNetEvent('c_interaction:mettrecoffre')
AddEventHandler('c_interaction:mettrecoffre', function()
    IsHandcuffed = false
    enaction = true
    dragStatus.isDragged = false
    local vms5,M7=PlayerPedId(),ngzOjWHO
    if not M7 then
        local v3=GetClosestVehicle2(GetEntityCoords(vms5),3.0)
        if not DoesEntityExist(v3)or not IsEntityAVehicle(v3)or not IsThisModelACar(GetEntityModel(v3)) and not IsVehiclePreviouslyOwnedByPlayer(v3) then 
        return end
        SetEntityVisible(vms5, false)
        SetEntityInvincible(vms5, true)
        SetPedCanRagdoll(vms5,false)
        SetPedCanSwitchWeapon(vms5,false)
        SetFollowPedCamViewMode(4)
        local ihKb=GetEntityHeading(v3)
        SetEntityHeading(vms5,ihKb)
        SetGameplayCamRelativeHeading(0.0)
        local JGSK,rA5U=GetModelDimensions(GetEntityModel(v3))
        local Uc06=vec3(JGSK.x+rA5U.x,rA5U.y,0.0)
        AttachEntityToEntity(vms5,v3,0,-vec3(Uc06.x,Uc06.y,-0.3),.0,.0,.0,0,0,0,0,2,true)
        ngzOjWHO=VehToNet(v3)
        SetTimecycleModifier("FRANKLIN")
        ShowAboveRadarMessage("~g~Vous avez été mis dans le coffre du véhicule.")
    elseif M7 then 
        local lcBL=GetEntityAttachedTo(vms5)
        DetachEntity(vms5,true,true)
        SetEntityInvincible(vms5, false)
        SetEntityVisible(vms5, true)
        SetPedCanRagdoll(vms5,true)
        SetPedCanSwitchWeapon(vms5,true)
        ClearTimecycleModifier()
        ngzOjWHO=nil
        enaction = false
        SetEntityHeading(vms5,-GetEntityHeading(lcBL))
        ShowAboveRadarMessage("~r~Vous venez d'être sortit du coffre du véhicule.")
        SetFollowPedCamViewMode(1)
    end 
end)

RegisterNetEvent('c_interaction:putInVehicle')
AddEventHandler('c_interaction:putInVehicle', function()
    local playerPed = PlayerPedId()
    IsHandcuffed = false
    enaction = false
    dragStatus.isDragged = false
    if not IsPedInAnyVehicle(playerPed) then
        local vehicle, distance = GetClosestVehicleI()
        local modelHash = GetEntityModel(vehicle)
        if vehicle and distance < 3 and IsVehiclePreviouslyOwnedByPlayer(vehicle) then
            for i = GetVehicleModelNumberOfSeats(modelHash), 0, -1 do
                if IsVehicleSeatFree(vehicle, i) then
                    TaskWarpPedIntoVehicle(playerPed, vehicle, i)
                end
            end
        end
    end
end)

RegisterNetEvent('c_interaction:outOfVehicle')
AddEventHandler('c_interaction:outOfVehicle', function()
    local playerPed = PlayerPedId()
    IsHandcuffed = false
    enaction = false
    dragStatus.isDragged = false
    if IsPedInAnyVehicle(playerPed) then
        local vehicle = GetVehiclePedIsIn(playerPed)
        TaskLeaveVehicle(playerPed, vehicle, 0)
        if isDead then
            TriggerEvent('disc-death:startAnim')
        end
    end
end)

RegisterNetEvent('clp_interact:drag')
AddEventHandler('clp_interact:drag', function(copId)
	dragStatus.isDragged = not dragStatus.isDragged
    dragStatus.CopId = copId
    IsHandcuffed = true
end)

Citizen.CreateThread(function()
	local playerPed
	local targetPed

	while true do
		local attente = 500

        if IsHandcuffed then
            attente = 1
			playerPed = PlayerPedId()

			if dragStatus.isDragged then
				targetPed = GetPlayerPed(GetPlayerFromServerId(dragStatus.CopId))

                if not IsPedSittingInAnyVehicle(targetPed) and not IsEntityAttachedToAnyPed(targetPed) then
                    enaction = true
					AttachEntityToEntity(playerPed, targetPed, 11816, 0, 0.54, 0.0, 0.0, 0.0, 0.0, false, false, false, false, 2, true)
				else
					dragStatus.isDragged = false
                    DetachEntity(playerPed, true, false)
                    enaction = false
				end

				if IsPedDeadOrDying(targetPed, true) then
                    dragStatus.isDragged = false
                    enaction = false
					DetachEntity(playerPed, true, false)
				end

			else
                DetachEntity(playerPed, true, false)
                IsHandcuffed = false
                enaction = false
			end
		else
			Citizen.Wait(500)
        end
        Wait(attente)
	end
end)

local function B6zKxgVs(L)
    if L.coords then
        L.vcoords = vector3(L.coords[1] or L.coords.x, L.coords[2] or L.coords.y, L.coords[3] or L.coords.z)
    end
    if L.hit ~= 0 then
        L.model = GetEntityModel(L.entity)
        L.entity_position = GetEntityCoords(L.entity)
    end
    L.distance = (L.entity_position or L.vcoords) and GetDistanceBetweenCoords(LocalPlayer().Pos, L.entity_position or L.vcoords) or 999;
    return L
end
function GMContextMenuLock(ihKb)
    TriggerEvent("offline::contextmenu:lock")
end
function GMContextMenuUnlock()
    TriggerEvent("offline::contextmenu:unlock")
end

local function selectplayer(Ped,Select)
    GMContextMenuUnlock()
    if Select == 1 then
        local target, distance = GetClosestPlayerPed()
        if target and distance < 3 then
            --TriggerEvent("randPickupAnim")
            TriggerServerEvent('clp_interact:drag', GetPlayerServerId(target))
        end
    elseif Select == 2 then
        local target, distance = GetClosestPlayerPed()
        if target and distance < 1.5 then
            if IsEntityPlayingAnim(GetPlayerPed(target), "random@mugging3", "handsup_standing_base", 3) then
                TriggerEvent("c_inventaire:openPlayerInventory", GetPlayerServerId(target), GetPlayerName(PlayerPedId()))
                Citizen.CreateThread(function()
                forceAnim({"missexile3", "ex03_dingy_search_case_a_michael"}, 1)
                while isInInventory do
                    Citizen.Wait(500)
                end
            ClearPedTasks(LocalPlayer().Ped)
        end)
        ExecuteCommand('me fouille quelqu\'un')
        end
else
ShowAboveRadarMessage("~r~La personne doit lever les mains.")
end
    elseif Select == 3 then 
        local target, distance = GetClosestPlayerPed()
        if target and distance < 3 then
            TriggerEvent("randPickupAnim")
            TriggerServerEvent('c_interaction:putInVehicle', GetPlayerServerId(target))
        end
    elseif Select == 4 then 
        local target, distance = GetClosestPlayerPed()
        if target and distance < 3 then
            TriggerEvent("randPickupAnim")
            TriggerServerEvent('c_interaction:outOfVehicle', GetPlayerServerId(target))
        end
    elseif Select == 5 then 
        local target, distance = GetClosestPlayerPed()
        if target and distance < 3 then
            TriggerEvent("randPickupAnim")
            TriggerServerEvent('c_interaction:mettrecoffre', GetPlayerServerId(target))
        end
    end 
end

function GetDriverOfVehicle(vehicle)
	local dPed = GetPedInVehicleSeat(vehicle, -1)
	for a = 0, 32 do
		if dPed == GetPlayerPed(a) then
			return a
		end
	end
	return -1
end

function CanUseWeapon(allowedWeapons)
	local player = PlayerId()
	local plyPed = GetPlayerPed(player)
	local plyCurrentWeapon = GetSelectedPedWeapon(plyPed)
	for a = 1, #allowedWeapons do
		if GetHashKey(allowedWeapons[a]) == plyCurrentWeapon then
			return true
		end
	end
	return false
end

function GetClosestVehicleToPlayer()
	local player = PlayerId()
	local plyPed = GetPlayerPed(player)
	local plyPos = GetEntityCoords(plyPed, false)
	local plyOffset = GetOffsetFromEntityInWorldCoords(plyPed, 0.0, 1.0, 0.0)
	local radius = 3.0
	local rayHandle = StartShapeTestCapsule(plyPos.x, plyPos.y, plyPos.z, plyOffset.x, plyOffset.y, plyOffset.z, radius, 10, plyPed, 7)
	local _, _, _, _, vehicle = GetShapeTestResult(rayHandle)
	return vehicle
end

function GetClosestVehicleTire(vehicle)
	local tireBones = {"wheel_lf", "wheel_rf", "wheel_lm1", "wheel_rm1", "wheel_lm2", "wheel_rm2", "wheel_lm3", "wheel_rm3", "wheel_lr", "wheel_rr"}
	local tireIndex = {
		["wheel_lf"] = 0,
		["wheel_rf"] = 1,
		["wheel_lm1"] = 2,
		["wheel_rm1"] = 3,
		["wheel_lm2"] = 45,
		["wheel_rm2"] = 47,
		["wheel_lm3"] = 46,
		["wheel_rm3"] = 48,
		["wheel_lr"] = 4,
		["wheel_rr"] = 5,
	}
	local player = PlayerId()
	local plyPed = GetPlayerPed(player)
	local plyPos = GetEntityCoords(plyPed, false)
	local minDistance = 1.0
	local closestTire = nil
	
	for a = 1, #tireBones do
		local bonePos = GetWorldPositionOfEntityBone(vehicle, GetEntityBoneIndexByName(vehicle, tireBones[a]))
		local distance = Vdist(plyPos.x, plyPos.y, plyPos.z, bonePos.x, bonePos.y, bonePos.z)

		if closestTire == nil then
			if distance <= minDistance then
				closestTire = {bone = tireBones[a], boneDist = distance, bonePos = bonePos, tireIndex = tireIndex[tireBones[a]]}
			end
		else
			if distance < closestTire.boneDist then
				closestTire = {bone = tireBones[a], boneDist = distance, bonePos = bonePos, tireIndex = tireIndex[tireBones[a]]}
			end
		end
	end

	return closestTire
end

local function selectveh(Ped,Select)
    GMContextMenuUnlock()
    local Uc06,lcBL=mvil.veh,GetPlayerPed(-1)
    if not Uc06 or not DoesEntityExist(Uc06)or GetDistanceBetweenCoords(GetEntityCoords(Uc06),GetEntityCoords(lcBL))>5 then return end
    if Select == 1 then 
		if GetVehicleDoorAngleRatio(Uc06,5)<=0.1 then 
            SetVehicleDoorOpen(Uc06,5)
        else 
            SetVehicleDoorShut(Uc06,5)
        end 
    elseif Select == 2 then 
        if GetVehicleDoorAngleRatio(Uc06,4)<=0.1 then 
            SetVehicleDoorOpen(Uc06,4)
        else 
            SetVehicleDoorShut(Uc06,4)
        end 
    elseif Select == 3 then 
        ShowAboveRadarMessage("Réservoir: ~b~"..math.ceil(GetVehicleFuelLevel(Uc06)).."L\n~w~état moteur: ~b~"..math.ceil(GetVehicleEngineHealth(Uc06)/10).."%\n~w~état véhicule: ~b~"..GetVehicleHealth(Uc06).."%")
    elseif Select == 4 then 
        local RRuSHnxf;local mcYOuT=lcBL
        if not DecorExistOn(Uc06,"Fuel")then
            local yA=math.floor(GetVehicleHandlingFloat(Uc06,"CHandlingData","fPetrolTankVolume"))
            SetVehicleFuelLevel(Uc06,math.floor(yA/2)+0.0)
        end;
        forceAnim({"weapon@w_sp_jerrycan","fire"},47)
        while GetDistanceBetweenCoords(GetEntityCoords(Uc06),GetEntityCoords(lcBL))<5 do
            if not RRuSHnxf or RRuSHnxf+3000 <GetGameTimer()then 
                SetVehicleFuelLevel(Uc06,GetVehicleFuelLevel(Uc06)-1)
                drawCenterText("~b~-1L~s~ Dans le véhicule.",2000)
                RRuSHnxf=GetGameTimer()
            end;
            DrawTopNotification("Appuyez sur ~INPUT_CELLPHONE_CANCEL~ pour ~r~annuler le siphonnage~s~.")
            if IsDisabledControlJustPressed(0,194)then 
                break 
            end;
            Wait(0)
        end
        ClearPedTasks(mcYOuT)
    elseif Select == 5 then 
        local allowedWeapons = {"WEAPON_KNIFE", "WEAPON_BOTTLE", "WEAPON_DAGGER", "WEAPON_HATCHET", "WEAPON_MACHETE", "WEAPON_SWITCHBLADE"}
		local player = PlayerId()
		local plyPed = GetPlayerPed(player)
		local vehicle = GetClosestVehicleToPlayer()
		local animDict = "melee@knife@streamed_core_fps"
        local animName = "ground_attack_on_spot"
        
        if vehicle ~= 0 then
			if CanUseWeapon(allowedWeapons) then
				local closestTire = GetClosestVehicleTire(vehicle)
				if closestTire ~= nil then
					if IsVehicleTyreBurst(vehicle, closestTire.tireIndex, 0) == false then
						RequestAnimDict(animDict)
						while not HasAnimDictLoaded(animDict) do
							Citizen.Wait(100)
						end
						local animDuration = GetAnimDuration(animDict, animName)
						TaskPlayAnim(plyPed, animDict, animName, 8.0, -8.0, animDuration, 15, 1.0, 0, 0, 0)
						Citizen.Wait((animDuration / 2) * 1000)
						local driverOfVehicle = GetDriverOfVehicle(vehicle)
						local driverServer = GetPlayerServerId(driverOfVehicle)
						SetVehicleTyreBurst(vehicle, closestTire.tireIndex, 0, 100.0)
						Citizen.Wait((animDuration / 2) * 1000)
						ClearPedTasksImmediately(plyPed)
					end
				end
			end
		end
    end 
end

RegisterNetEvent('bmx:usebmx')
AddEventHandler('bmx:usebmx', function(car)
    if IsPedInAnyVehicle(GetPlayerPed(-1), false) then return ShowAboveRadarMessage("~r~Vous ne pouvez pas sortir votre "..car.." dans un véhicule.") end
    local model = car
    RequestModel(model)
    while not HasModelLoaded(model) do
        RequestModel(model)
        Citizen.Wait(0)
    end
    local ped = PlayerPedId()
    local veh = CreateVehicle(model, GetEntityCoords(PlayerPedId()) + GetEntityForwardVector(ped), GetEntityHeading(PlayerPedId()) - 90.0, true, true)
    SetEntityAsMissionEntity(veh, true, true)
    SetVehicleModColor_1(veh,0)
    SetVehicleModColor_2(veh,0)
	SetVehicleOnGroundProperly(veh)
end)

local validveh = {"BMX","Fixter","Scorcher","Whippet","Endurex","Tri-Cycles"}
local function selectvbike(Ped,Select)
    GMContextMenuUnlock()
    local Uc06,lcBL=mvil.veh,GetPlayerPed(-1)
    if not Uc06 or not DoesEntityExist(Uc06)or GetDistanceBetweenCoords(GetEntityCoords(Uc06),GetEntityCoords(lcBL))>5 then return end
    if Select == 1 then 
        if tableHasValue(validveh, GetLabelText(GetDisplayNameFromVehicleModel(GetEntityModel(Uc06)))) then
            TriggerEvent('persistent-vehicles/forget-vehicle', Uc06)
            Wait(50)
            if IsVehicleModel(Uc06, GetHashKey('bmx')) then 
                TriggerServerEvent('addbmx', "bmx")
            elseif IsVehicleModel(Uc06, GetHashKey('fixter')) then 
                TriggerServerEvent('addbmx', "fixter")
            elseif IsVehicleModel(Uc06, GetHashKey('scorcher')) then 
                TriggerServerEvent('addbmx', "scorcher")
            elseif IsVehicleModel(Uc06, GetHashKey('tribike')) then 
                TriggerServerEvent('addbmx', "tribike")
            elseif IsVehicleModel(Uc06, GetHashKey('tribike2')) then 
                TriggerServerEvent('addbmx', "tribike2")
            elseif IsVehicleModel(Uc06, GetHashKey('tribike3')) then 
                TriggerServerEvent('addbmx', "tribike3")
            end
            SetEntityAsMissionEntity(Uc06)
            DeleteVehicle(Uc06)
            PlaySoundFrontend(-1, 'Bus_Schedule_Pickup', 'DLC_PRISON_BREAK_HEIST_SOUNDS', false)
        end
    elseif Select == 2 then 
        ShowAboveRadarMessage("Réservoir: ~b~"..math.ceil(GetVehicleFuelLevel(Uc06)).."L\n~w~état moteur: ~b~"..math.ceil(GetVehicleEngineHealth(Uc06)/10).."%\n~w~état véhicule: ~b~"..GetVehicleHealth(Uc06).."%")
    end 
end

local mMenuVeh = {
    onSelected = selectveh,
    params = {close = true},
    menu = {
        {
            {name="Ouvrir le coffre",icon="fa fa-box"},
            {name="Ouvrir le capot",icon="fas fa-car"},
            {name="Etat du véhicule",icon="fas fa-gas-pump"},
            {name="Vider le réservoir du véhicule",icon="fas fa-gas-pump"},
            {name="Percer les pneus",icon="fa fa-dot-circle"},
        }
    }
}
local mMenuBike = {
    onSelected = selectvbike,
    params = {close = true},
    menu = {
        {
            {name="Ramasser",icon="fas fa-bicycle"},
            {name="Etat du vélo",icon="fas fa-gas-pump"},
        }
    }
}
local mMenuPlayer = {
    onSelected = selectplayer,
    params = {close = true},
    menu = {
        {
            {name="Trainer",icon="fa fa-child"},
            {name="Fouiller",icon="fa fa-diagnoses"},
            {name="Mettre dans le véhicule",icon="fa fa-car"},
            {name="Sortir du véhicule",icon="fa fa-car"},
            {name="Mettre dans le coffre",icon="fa fa-car"},
        }
    }
}



AddEventHandler("offline::contextmenu:click", function(Su9Koz, Uk7e)
    local L = B6zKxgVs(Uk7e)
    if Uk7e.hit == 1 then
        local KwQCk_G = GetEntityType(Uk7e.entity)
        if KwQCk_G == 2 and L.distance <= 5 then
            if IsThisModelABicycle(L.model) then 
                mvil = {
                    veh = Uk7e.entity, 
                }
                CreateRoue(mMenuBike)
            else
                mvil = {
                    veh = Uk7e.entity, 
                }
                CreateRoue(mMenuVeh)
            end

        elseif KwQCk_G == 1 and L.distance <= 5 then
            if IsPedAPlayer(Uk7e.entity) then
                if L.distance <= 5 then
                    CreateRoue(mMenuPlayer)
				else
					ShowAboveRadarMessage('~r~Vous ne pouvez pas faire cette action.')
                end
            else
                mvil = {
                    pedsfix = Uk7e.entity, 
                }
                drawCenterText("~b~Je ne sais pas.", 3500)
            end
        end
    end
    GMContextMenuLock()
end)
