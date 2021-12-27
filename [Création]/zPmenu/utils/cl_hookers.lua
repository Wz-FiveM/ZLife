local L={GetHashKey("s_f_y_hooker_01"),GetHashKey("s_f_y_hooker_02"),GetHashKey("s_f_y_hooker_03"),GetHashKey("s_f_y_stripper_01"),GetHashKey("s_f_y_stripper_02"),GetHashKey("s_f_y_stripperlite")}
local WRH9={state=0,hooker=0,veh=0}
local cJoBcud="mini@prostitutes@sexnorm_veh_first_person"
local e={}
local attentepute = false
local nIdp
RegisterCommand('hooker', function()
	p = not p
	if p then
		if nIdp then
			RemoveNotification(nIdp)
		end
		nIdp = ShowAboveRadarMessage("Vous avez ~g~activé~s~ la possibilité de parler à des prostituées.")
		attentepute = true 
	elseif not p then
		attentepute = false
		if nIdp then
			RemoveNotification(nIdp)
		end
		nIdp = ShowAboveRadarMessage("Vous avez ~r~désactivé~s~ la possibilité de parler à des prostituées.")
	end
end)
local function B6zKxgVs(JGSK)
	local rA5U=GetEntityCoords(JGSK)
	local Uc06={GetOffsetFromEntityInWorldCoords(JGSK,0.0,0.0,0.0),GetOffsetFromEntityInWorldCoords(JGSK,5.0,0.0,0.0),GetOffsetFromEntityInWorldCoords(JGSK,-5.0,0.0,0.0),GetOffsetFromEntityInWorldCoords(JGSK,0.0,5.0,0.0),GetOffsetFromEntityInWorldCoords(JGSK,0.0,-5.0,0.0)}
	for lcBL,DHPxI in pairs(Uc06)do
	local dx,RRuSHnxf=GetClosestMajorVehicleNode(DHPxI.x,DHPxI.y,DHPxI.z,3.0,0)
		if not dx or GetDistanceBetweenCoords(rA5U,RRuSHnxf)>10 then 
			return true 
		end 
	end;
	return false 
end
local function O3_X()
    CloseMenu(true)
    local mcYOuT,Rr,scRP0=WRH9.hooker,WRH9.veh,GetPlayerPed(-1)
    if not IsEntityDead(mcYOuT)then 
        ClearPedTasks(mcYOuT)
        TaskClearLookAt(mcYOuT)
        if IsPedInAnyVehicle(mcYOuT)then 
            TaskLeaveVehicle(mcYOuT,Rr,0)
        end;
        SetBlockingOfNonTemporaryEvents(mcYOuT,false)
        N_0x18eb48cfc41f2ea0(mcYOuT,0)
        TaskWanderStandard(mcYOuT,1193033728,0)
        SetPedKeepTask(mcYOuT,true)
        SetPedAsNoLongerNeeded(mcYOuT)
        StopCurrentPlayingAmbientSpeech(mcYOuT)
    end
    if IsVehicleDriveable(Rr,0)and not IsEntityDead(Rr)then
        SetVehicleHandbrake(Rr,false)
        SetVehicleLights(Rr,3)
        SetVehicleInteriorlight(Rr,0)
        SetVehicleAutomaticallyAttaches(Rr,true,0)
        SetVehicleDoorsLockedForAllPlayers(Rr,false)
        SetVehicleDoorsLocked(Rr,1)
    end
    if not IsEntityDead(scRP0)then 
        TaskClearLookAt(scRP0)
		ClearPedTasks(scRP0)
		SetPedCanPlayAmbientAnims(scRP0,true)
		SetPedCanPlayAmbientBaseAnims(scRP0,true)
	end;
	if IsAudioSceneActive("PROSTITUTES_BJ_SPEECH_SCENE")then
		StopAudioScene("PROSTITUTES_BJ_SPEECH_SCENE")
	end
	ReleaseScriptAudioBank()
	ClearHelp(-1)WRH9={state=0,hooker=0,veh=0}
end
local function DVs8kf2w(AI0R2TQ6)
	BeginTextCommandIsThisHelpMessageBeingDisplayed(AI0R2TQ6)return EndTextCommandIsThisHelpMessageBeingDisplayed(0)end
	local function vms5()
		local yA=WRH9.hooker;WRH9.state=3;SetFollowVehicleCamViewMode(4)
		TaskSynchronizedTasks(yA,{{anim={cJoBcud,"proposition_to_sex_p1_prostitute"},flag=0},{anim={cJoBcud,"proposition_to_sex_p2_prostitute"},flag=0},{anim={cJoBcud,"sex_loop_prostitute"},flag=1}})
		TaskSynchronizedTasks(GetPlayerPed(-1),{{anim={cJoBcud,"proposition_to_sex_p1_male"},flag=0},{anim={cJoBcud,"proposition_to_sex_p2_male"},flag=0},{anim={cJoBcud,"sex_loop_male"},flag=1}})Citizen.Wait(3000)
		StartAudioScene("PROSTITUTES_BJ_SPEECH_SCENE")
		local XmVolesU=GetGameTimer()
		while XmVolesU+60000 >=GetGameTimer()do
		Citizen.Wait(0)
		if IsAnySpeechPlaying(yA)~=1 then
			PlayAmbientSpeech1(yA,"SEX_GENERIC","SPEECH_PARAMS_FORCE_NORMAL_CLEAR",1)
		end 
	end;
	StopAudioScene("PROSTITUTES_BJ_SPEECH_SCENE")
	TaskSynchronizedTasks(yA,{{anim={cJoBcud,"sex_to_proposition_p1_prostitute"},flag=0},{anim={cJoBcud,"sex_to_proposition_p2_prostitute"},flag=0},{anim={cJoBcud,"proposition_loop_prostitute"},flag=1}})
	TaskSynchronizedTasks(GetPlayerPed(-1),{{anim={cJoBcud,"sex_to_proposition_p1_male"},flag=0},{anim={cJoBcud,"sex_to_proposition_p2_male"},flag=0},{anim={cJoBcud,"proposition_loop_male"},flag=1}})Citizen.Wait(3000)WRH9.state=2
	SetFollowVehicleCamViewMode(1)
end
local function M7()
	local eZ0l3ch=WRH9.hooker;WRH9.state=3
	SetFollowVehicleCamViewMode(4)
	TaskSynchronizedTasks(eZ0l3ch,{{anim={cJoBcud,"proposition_to_bj_p1_prostitute"},flag=0},{anim={cJoBcud,"proposition_to_bj_p2_prostitute"},flag=0},{anim={cJoBcud,"bj_loop_prostitute"},flag=1}})
	TaskSynchronizedTasks(GetPlayerPed(-1),{{anim={cJoBcud,"proposition_to_bj_p1_male"},flag=0},{anim={cJoBcud,"proposition_to_bj_p2_male"},flag=0},{anim={cJoBcud,"bj_loop_male"},flag=1}})Citizen.Wait(3000)
	StartAudioScene("PROSTITUTES_BJ_SPEECH_SCENE")
	local W_63_9=GetGameTimer()
		while W_63_9+45000 >=GetGameTimer()do
		Citizen.Wait(0)
		if IsAnySpeechPlaying(eZ0l3ch)~=1 then
			PlayAmbientSpeech1(eZ0l3ch,"SEX_ORAL","SPEECH_PARAMS_FORCE_NORMAL_CLEAR",1)
		end 
	end;
	StopAudioScene("PROSTITUTES_BJ_SPEECH_SCENE")
	TaskSynchronizedTasks(eZ0l3ch,{{anim={cJoBcud,"bj_to_proposition_p1_prostitute"},flag=0},{anim={cJoBcud,"bj_to_proposition_p2_prostitute"},flag=0},{anim={cJoBcud,"proposition_loop_prostitute"},flag=1}})
	TaskSynchronizedTasks(GetPlayerPed(-1),{{anim={cJoBcud,"bj_to_proposition_p1_male"},flag=0},{anim={cJoBcud,"bj_to_proposition_p2_male"},flag=0},{anim={cJoBcud,"proposition_loop_male"},flag=1}})Citizen.Wait(3000)WRH9.state=2
	SetFollowVehicleCamViewMode(1)
end
local function v3(h9dyA_4T,oh,DZXGTh)
	local Uk7e=oh==1 and 15 or oh==2 and 50
	if oh==1 then 
		M7()
		TriggerServerEvent('clp_putes:pay', 25)
	elseif oh==2 then 
		vms5()
		TriggerServerEvent('clp_putes:pay', 75)
	end 
end
e={params={close=true},onSelected=v3,menu={{{name="Pipe (25$)",icon="fas fa-hand-holding-usd"},{name="Ken (75$)",icon="fas fa-hand-holding-usd"}}}}
local function ihKb(KwQCk_G,ptZa,PEqsd)
	local iSj=AddRelationshipGroup("ProstituteInPlay")
	SetRelationshipBetweenGroups(1,iSj,1862763509)
	SetPedRelationshipGroupHash(KwQCk_G,iSj)
	SetPedConfigFlag(KwQCk_G,229,true)
	SetPedConfigFlag(KwQCk_G,26,true)
	SetPedConfigFlag(KwQCk_G,115,true)
	SetBlockingOfNonTemporaryEvents(KwQCk_G,true)
	SetVehicleHandbrake(ptZa,1)
	SetVehicleLights(ptZa,4)
	SetVehicleInteriorlight(ptZa,1)
	SetVehicleAutomaticallyAttaches(ptZa,false,0)
	RequestAndWaitDict(cJoBcud)
	TaskSynchronizedTasks(KwQCk_G,{{anim={cJoBcud,"into_proposition_prostitute"},flag=0},{anim={cJoBcud,"proposition_loop_prostitute"},flag=1}})
	TaskSynchronizedTasks(PEqsd,{{anim={cJoBcud,"into_proposition_male"},flag=0},{anim={cJoBcud,"proposition_loop_male"},flag=1}})
end
Citizen.CreateThread(function()
	local iXxD6s
	local function oiY(FsYIVlkf)
		return IsThisModelACar(GetEntityModel(FsYIVlkf))and GetVehicleModelNumberOfSeats(GetEntityModel(FsYIVlkf))>1 
	end
	while true do 
		local attente = 5000
		if attentepute and(GetClockHours()>=22 or GetClockHours()<=6) then 
			attente = 0
			if WRH9.state==0 and IsPlayerPressingHorn(PlayerId())and (not iXxD6s or iXxD6s+1000 <GetGameTimer())and(GetClockHours()>=22 or GetClockHours()<=6)then 
				iXxD6s=GetGameTimer()
				local HLXS0Q_=GetClosestPed2(GetEntityCoords(GetPlayerPed(-1)),10.0,false,function(Kw)return
				not IsPedAPlayer(Kw) and tableHasValue(L,GetEntityModel(Kw)) end)
			if HLXS0Q_ and DoesEntityExist(HLXS0Q_)and not IsEntityDead(HLXS0Q_)and not IsPedFleeing(HLXS0Q_)then 
				local nvaIsNv7=GetVehiclePedIsIn(GetPlayerPed(-1))
				if nvaIsNv7 and IsVehicleSeatFree(nvaIsNv7,0)and oiY(nvaIsNv7)then
					PlayAmbientSpeech1(HLXS0Q_,"SOLICIT_MICHAEL","SPEECH_PARAMS_FORCE_SHOUTED_CLEAR",1)
					TaskEnterVehicle(HLXS0Q_,nvaIsNv7,-1,0,1.0,8388609,0)
					SetBlockingOfNonTemporaryEvents(HLXS0Q_,true)
					WRH9.hooker=HLXS0Q_;WRH9.veh=nvaIsNv7;WRH9.state=1 
				else
					PlayAmbientSpeech1(HLXS0Q_,"HOOKER_DECLINED","SPEECH_PARAMS_FORCE_SHOUTED_CLEAR",1)
				end 
			end 
		elseif WRH9.state==1 then
		local vDnoL55=IsPedInVehicle(WRH9.hooker,WRH9.veh)
		if not WRH9.time then 
			WRH9.time=GetGameTimer()
		end
			if not DVs8kf2w("PROS_SPOT")and vDnoL55 then
				BeginTextCommandDisplayHelp("PROS_SPOT")
				EndTextCommandDisplayHelp(0,0,0,-1)
			elseif vDnoL55 and WRH9.time and WRH9.time+1000*15 <GetGameTimer()and B6zKxgVs(WRH9.veh) and GetEntitySpeed(WRH9.veh)==0 then 
				ClearHelp(-1)
				SetGameplayCamRelativeHeading(-75.0)
				PlayAmbientSpeech1(WRH9.hooker,"HOOKER_OFFER_SERVICE","SPEECH_PARAMS_FORCE_SHOUTED_CLEAR",1)
				ihKb(WRH9.hooker,WRH9.veh,GetPlayerPed(-1))
				WRH9.state=2 
			end 
		elseif WRH9.state==2 then 
			HideHudComponentThisFrame(2)
			ShowHudComponentThisFrame(3)
			DrawTopNotification("Appuyez sur ~INPUT_CONTEXT~ pour ~p~discuter.~n~~s~Appuyez sur ~INPUT_RELOAD~ pour ~r~arrêter.")
			DisableControlAction(0,45,true)
			DisableControlAction(0,51,true)
			DisableControlAction(0,80,true)
			if IsDisabledControlPressed(0,51)then
				CreateRoue(e)
			end
			if IsDisabledControlPressed(0,45)then 
				O3_X(true)
			end;
			if IsControlJustPressed(0,0)then
				SetFollowVehicleCamViewMode(math.max(0,math.min(4,GetFollowVehicleCamViewMode()+1)))
			end 
		elseif WRH9.state==3 then
			if IsControlJustPressed(0,0)then
				SetFollowVehicleCamViewMode(math.max(0,math.min(4,GetFollowVehicleCamViewMode()+1)))
			end 
		end
		if WRH9.state~=0 then 
			local xlAK,zr1y=WRH9.hooker,WRH9.veh
			if not xlAK or not zr1y or IsEntityDead(xlAK)or IsEntityDead(zr1y)or GetDistanceBetweenCoords(GetEntityCoords(xlAK),GetEntityCoords(GetPlayerPed(-1)))>20 or not IsPedInAnyVehicle(GetPlayerPed(-1))then 
				O3_X()
			end 
			end
		end 
		Wait(attente)
	end 
end)