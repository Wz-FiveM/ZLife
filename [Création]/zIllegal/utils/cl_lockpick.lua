local sortit = false
local Time = 15000

function crochetageVeh(veh,default)
    local pPed=PlayerPedId()
    local pCoords=GetEntityCoords(pPed);
    if not veh or not DoesEntityExist(veh) or GetDistanceBetweenCoords(pCoords,GetEntityCoords(veh),true)>2 then 
        return 
    end
    local MdoelVeh=GetEntityModel(veh)
    if not GetVehicleDoorsLockedForPlayer(veh,pPed) and not IsEntityAMissionEntity(veh) and VehToNet(veh)<=0 and not GetVehicleDoorsLockedForPlayer(veh,pPed) and (IsThisModelACar(MdoelVeh) or IsThisModelAPlane(MdoelVeh)or IsThisModelAHeli(MdoelVeh))then 
        SetVehicleDoorsLockedForAllPlayers(veh,true)
    end;
	local chance = math.random(0, 99);
	local x,y,z = table.unpack(GetOffsetFromEntityInWorldCoords(PlayerPedId(), 0.0, 0.0, 0.0))
	local coords = {x=x,y=y,z=z}
    local function WorldCoords(carW)
        local cPos=GetEntityCoords(carW)
        local OfSetEnt={
            GetOffsetFromEntityInWorldCoords(carW,0.0,0.0,0.0),
            GetOffsetFromEntityInWorldCoords(carW,5.0,0.0,0.0),
            GetOffsetFromEntityInWorldCoords(carW,-5.0,0.0,0.0),
            GetOffsetFromEntityInWorldCoords(carW,0.0,5.0,0.0),
            GetOffsetFromEntityInWorldCoords(carW,0.0,-5.0,0.0)
        }
        for _,v in pairs(OfSetEnt)do
        local MajCar,MajVeh=GetClosestMajorVehicleNode(v.x,v.y,v.z,3.0,0)
            if not MajCar or GetDistanceBetweenCoords(cPos,MajVeh)>10 then 
                return true 
            end 
        end;
        return false 
    end
    if chance >= 0 and chance <= 99 then
        if not WorldCoords(veh) then 
            TriggerServerEvent("call:makeCall","police",coords,"Vol de véhicule.")
        end
	end
    DrawTopNotification("Appuyez sur ~INPUT_VEH_DUCK~ pour ~b~arrêter.",true)
    local Timer1,VehSeat,Timer2=GetGameTimer(),GetPedInVehicleSeat(veh,-1),GetGameTimer()
    while GetDistanceBetweenCoords(pCoords,GetEntityCoords(veh),true)<2.0 and Timer1+Time>=GetGameTimer()do 
        if IsControlJustPressed(0,73)then 
            break 
        end
        if Timer2 <=GetGameTimer()then
            if VehSeat then
                local dict, anim = "veh@break_in@0h@p_m_two@","std_locked_ds"
		        RequestAndWaitDict(dict)
		        TaskPlayAnim(pPed, dict, anim, 8.0, 8.0, -1, 1, 1, 0, 0, 0)
            else 
                TaskEnterVehicle(pPed,veh,2000,-1,1.0,1,0)
            end;
            Timer2=GetGameTimer()+2000 
        end;
        Citizen.Wait(0)
    end;
    if VehSeat then 
        ClearPedTasksImmediately(pPed)
    end;
	ClearHelp(-1)
    if Timer1+Time>=GetGameTimer()then
        ShowAboveRadarMessage("~r~Vous avez abandonné le crochetage.")
        ClearPedTasksImmediately(pPed)
        return 
    end
    if not veh or not DoesEntityExist(veh)then 
        return 
    end
    if default then
        if not veh or not DoesEntityExist(veh)then 
            return 
        end;
        SetVehicleAlarm(veh,true)
        SetVehicleAlarmTimeLeft(veh,Time)
        local chance=math.random(1,2)
        if chance~=2 then 
			ShowAboveRadarMessage("~r~Vous n'avez pas réussi le crochetage.")
			TriggerServerEvent('removelockpick')
            PlaySoundFrontend(-1,"Drill_Pin_Break","DLC_HEIST_FLEECA_SOUNDSET",0)
            return 
        end 
    end;
    NetworkRequestControlOfEntity(veh)
    local timer=GetGameTimer()
    while not NetworkHasControlOfEntity(veh)and timer+2000 >GetGameTimer()do
        Citizen.Wait(0)
    end
	PlaySoundFrontend(-1,"MP_RANK_UP","HUD_FRONTEND_DEFAULT_SOUNDSET",0)
	TriggerServerEvent('removelockpick')
	ShowAboveRadarMessage("Vous avez ~g~déverrouillé~w~ le véhicule.")
	SetVehicleAlarm(veh,true)
    SetVehicleAlarmTimeLeft(veh,Time)
    SetVehicleDoorsLocked(veh, 1)
	SetVehicleDoorsLockedForAllPlayers(veh, false)
    SetEntityAsMissionEntity(veh,true,true)
    SetVehicleHasBeenOwnedByPlayer(veh,true)
end

RegisterNetEvent('clp:uyselockpickl')
AddEventHandler('clp:uyselockpickl', function()
	local coords = GetEntityCoords(PlayerPedId())
	local valid = GetClosestVehicle2(coords, 6.0)
    if valid then 
        crochetageVeh(valid,true)
    else 
        ShowAboveRadarMessage("~r~Aucun véhicule à proximité.")
    end
end)
