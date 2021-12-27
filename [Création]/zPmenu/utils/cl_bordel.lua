local Crawla = false
local playerPed = GetPlayerPed(-1)

CreateThread(function()
    while true do
        local ped = PlayerPedId()
        local explosionProof, collisionProof = true, false
        SetEntityProofs(ped, false, false, explosionProof, collisionProof, false, false, false, false)
        Wait(10000)
    end
end)

function vms5()
    CreateThread(function()
        local Uk7e=GetPlayerPed(-1)
        if IsPedInAnyVehicle(playerPed, false) then 
            return 
		end;
		
        local PlayerPed=GetPlayerPed(-1)
        Crawla=not Crawla
		if not Crawla then 
			local x,y,z = table.unpack(GetEntityCoords(GetPlayerPed(-1),true))
			Wait(0)
            FreezeEntityPosition(PlayerPed,false)
			local dict, anim = "get_up@directional@transition@prone_to_knees@crawl","front"
			TaskPlayAnim(PlayerPed,dict,anim,2.0, -2.0,-1,4,0.0)
		else
        if IsPedRunning(PlayerPed)or IsPedSprinting(PlayerPed)or IsPedStrafing(PlayerPed)then
			local dict, anim = "move_jump", "dive_start_run"
			ESX.Streaming.RequestAnimDict(dict)
            TaskPlayAnim(PlayerPed,dict,anim,8.0,-4.0,-1,4,.0)
            Citizen.Wait(1200)
		end;
		
        if IsPedArmed(PlayerPed, 5) then
            TaskAimGunScripted(PlayerPed,GetHashKey("SCRIPTED_GUN_TASK_PLANE_WING"),1,1)
        end

        CreateThread(function()
            while Crawla do 
				Wait(0)
				--ESX.DrawMissionText("~g~Allongé")
                FreezeEntityPosition(PlayerPed,false)
                    if IsPedSwimming(PlayerPed) or IsPedFalling(PlayerPed) then 
                        Crawla=false;
                        ClearPedTasks(PlayerPed)
                        FreezeEntityPosition(PlayerPed,false)
                        break 
                    end;
                    if IsControlJustReleased(1,32) or IsControlJustReleased(1,33) then
                        TaskAimGunScripted(PlayerPed,GetHashKey("SCRIPTED_GUN_TASK_PLANE_WING"),1,1)
                    end
					if IsControlPressed(1,32) and not IsEntityPlayingAnim(PlayerPed,"move_crawl","onfront_fwd",3) then
						local dict, anim = "move_crawl", "onfront_fwd"
						ESX.Streaming.RequestAnimDict(dict)
                        TaskPlayAnim(PlayerPed,dict,anim,8.0,-4.0,-1,9,0.0)
					elseif IsControlPressed(1,33) and not IsEntityPlayingAnim(PlayerPed,"move_crawl","onfront_bwd",3) then
						local dict, anim = "move_crawl", "onfront_bwd"
						ESX.Streaming.RequestAnimDict(dict)
                        TaskPlayAnim(PlayerPed,dict,anim,8.0,-4.0,-1,9,0.0)
                    end
                        if IsControlPressed(1,34) then
                            SetEntityHeading(PlayerPed,GetEntityHeading(PlayerPed)+1.0)
                        elseif IsControlPressed(1,35)then
                            SetEntityHeading(PlayerPed,GetEntityHeading(PlayerPed)-1.0)
                        end
                        if IsPedArmed(PlayerPed,5) then
                            while not IsPedWeaponReadyToShoot(PlayerPed)do
							SetPedCurrentWeaponVisible(PlayerPed,true)
							Citizen.Wait(0)
                        end;
                        --[[ if IsControlJustReleased(1,32)or IsControlJustReleased(1,33) then
                            TaskAimGunScripted(PlayerPed,GetHashKey("SCRIPTED_GUN_TASK_PLANE_WING"),1,1)
                        end  ]]
                    else
						if IsControlReleased(1,32) and IsControlReleased(1,33) then
							local dict, anim = "move_crawl", "onfront_fwd"
							ESX.Streaming.RequestAnimDict(dict)
                            TaskPlayAnim(PlayerPed,dict,anim,8.0,-4.0,-1,9,0.0)
                            FreezeEntityPosition(PlayerPed,true)
                        end 
                    end 
                end 
            end)
        end 
    end)
end

RegisterControlKey("liyng","S'allonger","",function()
	inlaying = not inlaying
	if not inlaying then 
		if not IsPedInAnyVehicle(GetPlayerPed(-1), false) then 
			vms5()
		end
	elseif inlaying then 
		if not IsPedInAnyVehicle(GetPlayerPed(-1), false) then 
			vms5()
		end
    end
end)

RegisterControlKey("stopanim","Stopper une animation","",function()
	ClearPedTasks(GetPlayerPed(-1))
end)

RegisterCommand("cleararea", function()
	local x,y,z = table.unpack(GetOffsetFromEntityInWorldCoords(PlayerPedId(), 0.0, 0.0, 0.0))
	ClearAreaOfPeds(x, y, z, 100.0, 1)
	ClearAreaOfEverything(x, y, z, 100.0, false, false, false, false)
	ClearAreaOfVehicles(x, y, z, 100.0, false, false, false, false, false)  
	ClearAreaOfObjects(x, y, z, 100.0, true)
	ClearAreaOfProjectiles(x, y, z, 100.0, 0)
	ClearAreaOfCops(x, y, z, 100., 0)
end)

RegisterCommand("unfreeze", function()
	local veh = GetVehiclePedIsIn(PlayerPedId())
	if veh then
		FreezeEntityPosition(veh)
	end
end)

RegisterControlKey("dormir","Dormir/se réveiller","J",function()
	while true do 
		Wait(0)
		local myPed = GetPlayerPed(-1)
		SetPedToRagdoll(myPed, 1000, 1000, 0, 0, 0, 0)
		ESX.ShowHelpNotification ("Appuyez sur ~INPUT_CONTEXT~ ou ~INPUT_JUMP~ pour ~b~vous relever")
		ResetPedRagdollTimer(myPed)
		if IsControlJustPressed(0, 22) or IsControlJustPressed(0, 46) then 
			break
		end
	end
end)

RegisterCommand("disc", function()
	TriggerServerEvent('clippy:deconnection')
end)

RegisterCommand("disconnect", function()
	TriggerServerEvent('clippy:deconnection')
end)

local waterTime
local notifRemplirseau
RegisterNetEvent('seau:remplirwaterseau')
AddEventHandler('seau:remplirwaterseau', function()
	local time = 6000
	local ped = GetPlayerPed(-1)

	if waterTime and waterTime > GetGameTimer() then 
		if notifRemplirseau then 
			RemoveNotification(notifRemplirseau) 
		end
		notifRemplirseau = ShowAboveRadarMessage(string.format("~r~Veuillez patienter encore %s seconde(s) avant de re-utiliser votre seau.", math.floor((waterTime - GetGameTimer()) / 1000))) return 
	end
	if not IsEntityInWater(ped) or IsPedSwimming(ped) then 
		if notifRemplirseau then 
			RemoveNotification(notifRemplirseau) 
		end
		notifRemplirseau = ShowAboveRadarMessage("~r~Vous devez être au bord de l'eau pour pouvoir récupérer l'eau.") return 
	end

	local wholeTime = 5000 + time
	waterTime = GetGameTimer() + wholeTime

	createProgressBar("Vous remplissez la bouteille",0,124,255, 200, 4500 + time)

	RemoveNotification(notifRemplirseau) 
	ExecuteCommand('me remplit une bouteille')
	TaskStartScenarioInPlace(ped, "WORLD_HUMAN_BUM_WASH", 0, true)

	Citizen.Wait(11000)
	ClearPedTasks(ped)
	TriggerServerEvent("seau:addwater")
end)

local truelleTime
local enwater = false
local notifTruelle
RegisterNetEvent('clp:usetruelle')
AddEventHandler('clp:usetruelle', function()
	local time = 60000
	local ped = GetPlayerPed(-1)

	if truelleTime and truelleTime > GetGameTimer() then 
		if notifTruelle then 
			RemoveNotification(notifTruelle) 
		end
		notifTruelle = ShowAboveRadarMessage(string.format("~r~Veuillez patienter encore %s seconde(s) avant de re-utiliser votre truelle.", math.floor((truelleTime - GetGameTimer()) / 1000))) return 
	end
	if not IsEntityInWater(ped) or IsPedSwimming(ped) then 
		if notifTruelle then 
			RemoveNotification(notifTruelle) 
		end
		notifTruelle = ShowAboveRadarMessage("~r~Vous devez être au bord de l'eau pour pouvoir récupérer de la terre humide.") return 
	end

	local treeTime = 0 + time
	truelleTime = GetGameTimer() + treeTime
	createProgressBar("Vous récupérez de la terre",99,86,86,255, treeTime)
	ExecuteCommand('me utilise sa truelle')
	enwater = true
	RemoveNotification(notifTruelle) 
	TaskStartScenarioInPlace(ped, "WORLD_HUMAN_BUM_WASH", 0, true)
	TriggerServerEvent('esx_drugs:startHarvestTerrehumide')

	Citizen.Wait(60000)
	enwater = false
	ClearPedTasks(ped)
	TriggerServerEvent('esx_drugs:stopHarvestTerrehumide')
end)

RegisterCommand('vomir', function()
	ExecuteCommand('me vomit')
	local playerPed = PlayerPedId()
	local playerPedcoords = GetEntityCoords(playerPed)
	RequestNamedPtfxAsset("scr_family5")
	local particle = StartNetworkedParticleFxLoopedOnEntityBone("SCR_TREV_PUKE",GetPlayerPed(-1),0.0,0.0,0.0,0.0,0.0,0.0,31086,1.0,0,0,0)
	StartNetworkedParticleFxLoopedOnEntityBone("SCR_TREV_PUKE",GetPlayerPed(-1),0.0,0.0,0.0,0.0,0.0,0.0,31086,1.0,0,0,0)
	local dict, anim = "MISSHEISTPALETOSCORE1LEADINOUT","TRV_PUKING_LEADOUT"
	ESX.Streaming.RequestAnimDict(dict)
	TaskPlayAnim(playerPed, dict, anim, 8.0, 8.0, -1, 0, 1, 0, 0, 0)
	UseParticleFxAssetNextCall("scr_family5")
	Citizen.Wait(1000)
	StopParticleFxLooped(particle,0)
end)

function cleanPlayer(playerPed)
	ClearPedBloodDamage(playerPed)
	ResetPedVisibleDamage(playerPed)
	ClearPedLastWeaponDamage(playerPed)
	ResetPedMovementClipset(playerPed, 0)
end

local UseMalette = false

RegisterNetEvent('kxzeriia:givemalette')
AddEventHandler('kxzeriia:givemalette', function(malette)
	local playerPed = GetPlayerPed(-1)

	if IsPedInAnyVehicle(playerPed,  false) then
		ESX.ShowNotification("~r~Vous ne pouvez équiper votre malette en véhicule.")
	else
		UseMalette = not UseMalette
		cleanPlayer(playerPed)
		if UseMalette then
			ExecuteCommand('me équipe : Malette')
			UseMalette = true
			PlaySoundFrontend(-1, "Pickup_Briefcase", "GTAO_Magnate_Boss_Modes_Soundset", 0)
			giveWeapon(malette)
		else
			UseMalette = false
			giveWeapon("weapon_unarmed")
		end
	end
end)

function giveWeapon(gunhash)
    GiveWeaponToPed(GetPlayerPed(-1), GetHashKey(gunhash), 1, false, true)
end

RegisterControlKey("stream","Commencer à filmer (Rockstar Editor)","F3",function()
	if not IsRecording()then 
        StartRecording(1)
    else
        StopRecordingAndSaveClip()
    end 
end)

local ModelBoxe=GetHashKey("prop_boxing_glove_01")
local Props1={}

function toggleGloves()
    for _,Propsmodel in pairs(Props1)do 
        DeleteEntity(Propsmodel)
    end;
    if tableCount(Props1)>0 then 
        Props1={}
        return 
    end
    RequestAndWaitModel(ModelBoxe)
    local pPed,pCoords=GetPlayerPed(-1),GetEntityCoords(GetPlayerPed(-1))
    local object=CreateObject(ModelBoxe,pCoords,1,0,0)
    local object1=CreateObject(ModelBoxe,pCoords,1,0,0)
    SetNetworkIdCanMigrate(ObjToNet(object1),false)
    SetNetworkIdCanMigrate(ObjToNet(object),false)
    table.insert(Props1,object)
	table.insert(Props1,object1)
	local AllVeh = GetVehicles()
	for k,v in pairs(AllVeh) do
        SetEntityNoCollisionEntity(Props1, v, true)
        SetEntityNoCollisionEntity(v, Props1, true)
        SetEntityCollision(v, 1, 1)
        ResetEntityAlpha(v)
    end
	for _,object2 in pairs(Props1)do
		SetEntityCollision(object2, 0, 0)
        SetEntityAsMissionEntity(object2,1,1)
    end
    AttachEntityToEntity(object,pPed,GetPedBoneIndex(pPed,6286),vector3(-0.1,0.01,-0.01),vector3(90.0,0.0,90.0),0,0,1,0,0,1)
    AttachEntityToEntity(object1,pPed,GetPedBoneIndex(pPed,36029),vector3(-0.1,0.02,0.02),vector3(-90.0,0.0,-90.0),0,0,1,0,0,1)
    ESX.ShowNotification("Vous avez équipé ~g~vos gants de boxe~w~.")
end

RegisterNetEvent('clp:usegantboxe')
AddEventHandler('clp:usegantboxe', function()
	toggleGloves()
end)

RegisterNetEvent("animbriquerformolotv")
AddEventHandler("animbriquerformolotv", function(source)
	if not IsPedInAnyVehicle(GetPlayerPed(-1)) then
		TaskStartScenarioInPlace(PlayerPedId(), "PROP_HUMAN_PARKING_METER", 0, true)
		createProgressBar("Fabrication en cours",255,201,0,255, 20000)
		Citizen.Wait(20000)
		TriggerServerEvent('apresanimmolotovremove')
		ESX.DrawMissionText('Vous avez obtenu ~g~1~s~ "~g~Coktail Molotov~s~".', 5000)
		ClearPedTasks(PlayerPedId())
	end
end)

local casseroltime
local notifCass

local casserolebroken = 0

function toggleCass()
	local pProps=GetHashKey("prop_kitch_pot_lrg")
	
	local time = 12000
	local ped = GetPlayerPed(-1)

	if casseroltime and casseroltime > GetGameTimer() then 
		if notifCass then 
			RemoveNotification(notifCass) 
		end
		notifCass = ShowAboveRadarMessage(string.format("~r~Veuillez patienter encore %s seconde(s) avant de re-utiliser votre casserole.", math.floor((casseroltime - GetGameTimer()) / 1000))) return 
	end

	local treeeeTime = 0 + time
	casseroltime = GetGameTimer() + treeeeTime

    	RequestAndWaitModel(pProps)
		RemoveNotification(notifCass) 
        local objectca=CreateObject(pProps,GetEntityCoords(GetPlayerPed(-1))+GetEntityForwardVector(GetPlayerPed(-1))*0.7-vec3(0.0,0.0,1.0),true,true,true)
        FreezeEntityPosition(objectca,true)
		SetNetworkIdCanMigrate(ObjToNet(objectca),false)
		if IsEntityInWater(ped) then 
			createProgressBar("Récupération de la terre",102,51,0,200, 12000)
		elseif not IsEntityInWater(ped) or IsPedSwimming(ped) then 
			createProgressBar("Filtrage de la terre",255,255,51,150, 12000)
		end
        TaskStartScenarioInPlace(PlayerPedId(), "WORLD_HUMAN_BUM_WASH", 0, false)
		Citizen.Wait(12000)
		if IsEntityInWater(ped) then 
			--if recolteterre >= farmlilterre then return drawCenterText('~r~Vous avez atteint la limite de travail.', 3500) end
			casserolebroken = casserolebroken + 1
			TriggerServerEvent('clp:usecasseroleterre', false)
		elseif not IsEntityInWater(ped) or IsPedSwimming(ped) then 
			--if recolteor >= farmlilor then return drawCenterText('~r~Vous avez atteint la limite de travail.', 3500) end
			casserolebroken = casserolebroken + 1
			TriggerServerEvent('clp:usecasseroleterre', true)
		end

		if casserolebroken >= 50 then 
			ShowAboveRadarMessage("~r~Votre casserole s'est abîmée.")
			casserolebroken = 0
			TriggerServerEvent('clp:removeitem', "casserole", 0)
		end

        ClearPedTasks(GetPlayerPed(-1))
        SetModelAsNoLongerNeeded(pProps)
        DeleteEntity(objectca)
    return true 
end

RegisterNetEvent('clp:usecasserole')
AddEventHandler('clp:usecasserole', function()
	toggleCass()
end)

RegisterCommand('pos', function(source, args)
    local pPed=PlayerPedId()
	local Matrix2,Matrix1,Matrix2,Matrix3=GetEntityMatrix(pPed)
	ClearFocus()
	SetFocusEntity(GetPlayerPed(PlayerId()))   
    DoScreenFadeOut(20)
    SetEntityCoords(pPed,7000.0,5000.0,300.0)
    Wait(20)
    SetEntityCoords(pPed,Matrix3+Matrix1*0.5)
    DoScreenFadeIn(20)
end)

RegisterCommand('infoperso', function(source, args)
	local plyData = ESX.GetPlayerData()
	if plyData and plyData.job and plyData.job.label and plyData.job.grade_label then
        ESX.ShowNotification("Job : ~g~"..plyData.job.label.."~s~\nGrade : ~g~"..plyData.job.grade_label.."~s~\nOragnisation : ~g~"..plyData.org.label.."~s~\nNom Steam : ~g~" .. GetPlayerName(PlayerId()))
	else 
        ESX.ShowNotification("~r~Données introuvables.")
	end
end)

RegisterCommand("save", function()
	local health = GetEntityHealth(GetPlayerPed(-1))
	TriggerServerEvent('esx_health:update', health)
	--[[ TriggerServerEvent('SavellPlayer')
	TriggerEvent('skinchanger:getSkin', function(skin)
		TriggerServerEvent('esx_skin:save', skin)
	end) ]]
end)

RegisterCommand('lastpos', function()
	TriggerServerEvent("zMenu:lastpos")
end)

RegisterNetEvent("zMenu:lastpos")
AddEventHandler("zMenu:lastpos", function(position) 
	coords = position
	SetEntityCoords(PlayerPedId(), coords.x, coords.y, coords.z+2.0, 0.0, 0.0, 0.0, false)
end)

RegisterCommand("clearprops", function()
	local object = GetClosestObject(GetEntityCoords(GetPlayerPed(-1)),2.0)
	DeleteObject(object)
end)

local poscharact = {
	{vector3(398.36, -1004.32, -99.0)}
}

Citizen.CreateThread(function()
    while true do
		local attente = 1500
        for _,v in pairs(poscharact) do
			if not IsPedInAnyVehicle(GetPlayerPed(-1), false) then 
				if Vdist2(GetEntityCoords(PlayerPedId(), false), v[1]) < 2.1 then
					attente = 5
					DrawTopNotification("Appuyez sur ~INPUT_CONTEXT~ pour ~g~register")
					if IsControlJustPressed(1,51) then 
						Wait(500)
						TriggerEvent('c_charact:create')
					end
				end
			elseif IsPedInAnyVehicle(GetPlayerPed(-1), false) then 
				attente = 2500
			end
		end
		Wait(attente)
    end
end)

local dstmulti = 1.0
local dsdSd = 0.8
local sXQzZoj = {"AIRP", "SANAND", "BEACH", "DELBE", "STAD","WVINE", "SANDY", "MIRR", "CYPRE"}

Citizen.CreateThread( function()
	local e = LocalPlayer()
	local FsYIVlkf, HLXS0Q_ = e.Ped, e:GetVehicle()
	local FT = PlayerPedId()
	while true do
		Citizen.Wait(100)

		StartAudioScene("CHARACTER_CHANGE_IN_SKY_SCENE")
        HideHudComponentThisFrame(19) -- weapon wheel
		HideHudComponentThisFrame(20) -- weapon wheel
		
		if IsPedBeingStunned(FsYIVlkf, 0) then
            if IsEntityInWater(FsYIVlkf) then
                ClearPedTasks(FsYIVlkf)
            else
                SetTimecycleModifier("Dont_tazeme_bro")
                SetPedMinGroundTimeForStungun(FsYIVlkf, 10000)
                while IsPedBeingStunned(FsYIVlkf, 0) do
                    Citizen.Wait(0)
                end
                DoScreenFadeOut(300)
				Citizen.Wait(300)
				ClearTimecycleModifier()
                DoScreenFadeIn(300)
            end
        end


		SetPedSuffersCriticalHits(FT, false)
	   	ClearPlayerWantedLevel(PlayerId())
	   	RestorePlayerStamina(PlayerId(), 1.0)
		SetPlayerHealthRechargeMultiplier(PlayerId(), 0.0)

		RemoveAllPickupsOfType(14)
		
		if tableHasValue(sXQzZoj, e.ZoneName) then
			dsdSd = 1.0
			SetPedDensityMultiplierThisFrame(dsdSd)
			SetVehicleDensityMultiplierThisFrame(dsdSd)
			SetParkedVehicleDensityMultiplierThisFrame(dsdSd)
		else
			dsdSd = 1.0
			SetParkedVehicleDensityMultiplierThisFrame(dstmulti)
			SetVehicleDensityMultiplierThisFrame(dsdSd)
		end;
	end
end)

Citizen.CreateThread(function()
    SwitchTrainTrack(0, false)
    SwitchTrainTrack(3, true)
    N_0x21973bbf8d17edfa(0, 300000)
	SetRandomTrains(true)
	SetMaxWantedLevel(0)
    ClearPlayerWantedLevel(PlayerId())
end)

Citizen.CreateThread(function() 
	while true do
		InvalidateIdleCam()
		N_0x9e4cfff989258472() --Disable the vehicle idle camera
		Wait(1000) --The idle camera activates after 30 second so we don't need to call this per frame
	end 
end)

local DHPxI = {
	"GANG_1", 
	"GANG_2", 
	"GANG_9", 
	"GANG_10", 
	"AMBIENT_GANG_LOST", 
	"AMBIENT_GANG_MEXICAN",
	"AMBIENT_GANG_FAMILY", 
	"AMBIENT_GANG_BALLAS", 
	"AMBIENT_GANG_MARABUNTE", 
	"AMBIENT_GANG_CULT",
	"AMBIENT_GANG_SALVA", 
	"AMBIENT_GANG_WEICHENG", 
	"AMBIENT_GANG_HILLBILLY", 
	"DEALER", 
	"HATES_PLAYER",
	"NO_RELATIONSHIP", 
	"SPECIAL", 
	"MISSION2", 
	"MISSION3", 
	"MISSION4", 
	"MISSION5", 
	"MISSION6", 
	"MISSION7",
	"MISSION8"
}
function Initialize()

	SetIgnoreLowPriorityShockingEvents(PlayerId(), true)
	SetPlayerCanBeHassledByGangs(PlayerId(), false) 
	SetPoliceIgnorePlayer(PlayerId(), true)
	SetEveryoneIgnorePlayer(PlayerId(), true)

	SetVehicleModelIsSuppressed(GetHashKey("zentorno"),true)
	SetVehicleModelIsSuppressed(GetHashKey("blimp"),true)
	SetVehicleModelIsSuppressed(GetHashKey("adder"),true)
	SetVehicleModelIsSuppressed(GetHashKey("turismor"),true)
	SetVehicleModelIsSuppressed(GetHashKey("firetruck"),true)
	SetVehicleModelIsSuppressed(GetHashKey("Carbonizzare"),true)
	SetVehicleModelIsSuppressed(GetHashKey("Jester"),true)
	SetVehicleModelIsSuppressed(GetHashKey("feltzer2"),true)
	SetVehicleModelIsSuppressed(GetHashKey("rapidgt"),true)
	SetVehicleModelIsSuppressed(GetHashKey("massacro"),true)
	SetVehicleModelIsSuppressed(GetHashKey("massacro2"),true)
	SetVehicleModelIsSuppressed(GetHashKey("hydra"),true)
	SetVehicleModelIsSuppressed(GetHashKey("lectro"),true)

	SetVehicleModelIsSuppressed(GetHashKey("frogger"),true)
	SetVehicleModelIsSuppressed(GetHashKey("buzzard2"),true)
	SetVehicleModelIsSuppressed(GetHashKey("polmav"),true)
	SetAudioFlag("WantedMusicDisabled",false)
	SetThisScriptCanRemoveBlipsCreatedByAnyScript(true)

	for _4O, C in ipairs(DHPxI) do
        SetRelationshipBetweenGroups(1, GetHashKey("PLAYER"), GetHashKey(C))
        SetRelationshipBetweenGroups(1, GetHashKey(C), GetHashKey("PLAYER"))
    end
end

Initialize()

Citizen.CreateThread(function()
	local FT = PlayerPedId()
    while true do 
        ClearAllBrokenGlass()
        ClearAllHelpMessages()
        LeaderboardsReadClearAll()
        ClearBrief()
        ClearGpsFlags()
        ClearPrints()
        ClearSmallPrints()
        ClearReplayStats()
        LeaderboardsClearCacheData()
        ClearFocus()
		ClearHdArea()
		
		DisablePlayerVehicleRewards(FT)
		ResetScriptGfxAlign()

        -- Vérifier si gênant 
        ClearThisPrint()
        ClearPedInPauseMenu()
        ClearFloatingHelp()
        ClearGpsRaceTrack()
        ClearOverrideWeather()
        ClearCloudHat()
		ClearHelp(true)
		ClearPedBloodDamage(GetPlayerPed(-1))
		SetPedConfigFlag(FT, 35, false)
		for _4O, C in ipairs(DHPxI) do
			SetRelationshipBetweenGroups(1, GetHashKey("PLAYER"), GetHashKey(C))
			SetRelationshipBetweenGroups(1, GetHashKey(C), GetHashKey("PLAYER"))
		end
		Citizen.InvokeNative(0x55598D21339CB998, 0.0)
    	Wait(100000)    
    end
end)

local function rA5U1(JQi1jg, wVzn, pE, RSjapQ)
	if wVzn.name == "Type" then
		TriggerEvent('skinchanger:change', 'bproof_1', wVzn.slidenum-1)
    end
end
local function rA5U(JQi1jg, wVzn, pE, RSjapQ)
	if wVzn.name == "Couleur" then
		TriggerEvent('skinchanger:change', 'bproof_2', wVzn.slidenum-1)
    end
end
local function fDhxJ(JQi1jg, wVzn, pE, RSjapQ)
	if pE.name == "Valider" then
		TriggerEvent("randPickupAnim")
		ShowAboveRadarMessage("~r~Kevlar\n~s~Vous venez de vous mettre un kevlar.")
		CloseMenu(true)
    end
end
local function createcam()
	local XmVolesU=GetEntityCoords(GetPlayerPed(-1))
    DrawMarker(0,XmVolesU+vector3(.0,.0,1.0),vector3(.0,.0,.0),vector3(0.0,0.0,0.0),.3,.3,0.15,255,0,0,100,false,true,true,false,false,false,false)
end

local Bullet = {
	Base = { Header = {"shopui_title_gunclub", "shopui_title_gunclub"}, HeaderColor = {255,255,255}, Blocked = true},
	Data = { currentMenu = "GPB"},
	Events = { 
		onSelected = fDhxJ,
		onSlide = rA5U,
		onRender = createcam
	},
	Menu = {
		["GPB"] = {
			b = {
				{name = "Couleur",slidemax = 8},
				{name = "Valider", ask = ">", askX = true}
			}
		}
	}
}

local Bulletpol = {
	Base = { Header = {"shopui_title_gunclub", "shopui_title_gunclub"}, HeaderColor = {255,255,255}, Blocked = true},
	Data = { currentMenu = "GPB"},
	Events = { 
		onSelected = fDhxJ,
		onSlide = rA5U1,
		onRender = createcam
	},
	Menu = {
		["GPB"] = {
			b = {
				{name = "Type",slidemax = 97},
				{name = "Valider", ask = ">", askX = true}
			}
		}
	}
}

local kevlar = false
local haveuseb = false
local bSdX = {}
RegisterNetEvent('c_use:bulletproof')
AddEventHandler('c_use:bulletproof', function(skin1, skin2, blt, jDft)
	local playerPed = GetPlayerPed(-1)
	if not haveuseb then 
		haveuseb = true
		bSdX = jDft
		ClearPedBloodDamage(playerPed)
		ResetPedVisibleDamage(playerPed)
		ClearPedLastWeaponDamage(playerPed)
		SetPedArmour(playerPed, blt)
		kevlar = true
		kevlarsimple = true
		TriggerEvent('skinchanger:getSkin', function(skin)
			if skin.sex == 0 then
				local clothesSkin = {
					['bproof_1'] = skin1,  ['bproof_2'] = 1
				}
				TriggerEvent('skinchanger:loadClothes', skin, clothesSkin)
			elseif skin.sex == 1 then
				local clothesSkin = {
					['bproof_1'] = skin2,  ['bproof_2'] = 1
				}
				TriggerEvent('skinchanger:loadClothes', skin, clothesSkin)
			end
			CreateMenu(Bullet)
		end)
	elseif haveuseb then 
		kevlar = false
		TriggerEvent('skinchanger:getSkin', function(skin)
			if skin.sex == 0 then
				local clothesSkin = {
					['bproof_1'] = 0,  ['bproof_2'] = 0
				}
				TriggerEvent('skinchanger:loadClothes', skin, clothesSkin)
			elseif skin.sex == 1 then
				local clothesSkin = {
					['bproof_1'] = 0,  ['bproof_2'] = 0
				}
				TriggerEvent('skinchanger:loadClothes', skin, clothesSkin)
			end
		end)
		kevlarsimple =false
		ClearPedBloodDamage(playerPed)
		ResetPedVisibleDamage(playerPed)
		ClearPedLastWeaponDamage(playerPed)
		SetPedArmour(playerPed, 0)
		bSdX = nil
		haveuseb = false
	end
end)

RegisterNetEvent('clp:removebullet')
AddEventHandler('clp:removebullet', function()
    local playerPed = GetPlayerPed(-1)
    ClearPedBloodDamage(playerPed)
    ResetPedVisibleDamage(playerPed)
    ClearPedLastWeaponDamage(playerPed)
    SetPedArmour(playerPed, 0)
end)

Citizen.CreateThread(function()
  while true do 
    local attente = 1000
      local playerPed = GetPlayerPed(-1)
      local forcearour = GetPedArmour(playerPed)
      if kevlar then
        attente = 500
        if forcearour <= 1 then 
          attente = 1
            TriggerEvent('skinchanger:change', 'bproof_1', 0)
            TriggerEvent('skinchanger:change', 'bproof_2', 0)
            ShowAboveRadarMessage("~r~Votre kevlar s'est brisé.")
			SetPedToRagdollWithFall(playerPed,1500,2000,0,-GetEntityForwardVector(playerPed),1.0,0.0,.0,.0,.0,.0,.0)
			SetPedToRagdoll(playerPed, 1000, 1000, 0, 0, 0, 0)
			ResetPedRagdollTimer(playerPed)
            ExecuteCommand("+dormir")
            if kevlarpolice then 
              kevlarpolice = false
              TriggerServerEvent('removebulletpolice')
            elseif kevlarsheriff then 
              kevlarsheriff = false
              TriggerServerEvent('removebulletsheriff')
            elseif kevlarsimple then 
			  kevlarsimple =false
			  TriggerServerEvent('clp:removeitem', bSdX, 0)
            end
            kevlar = false
        end
      end
      Wait(attente)
    end
end)

RegisterNetEvent('esx_useitem:removebulletpolice')
AddEventHandler('esx_useitem:removebulletpolice', function()
	haveub = not haveub
	if haveub then 
		local playerPed = GetPlayerPed(-1)

		ClearPedBloodDamage(playerPed)
		ResetPedVisibleDamage(playerPed)
		ClearPedLastWeaponDamage(playerPed)
		SetPedArmour(playerPed, 100)
		kevlar = true
		kevlarpolice = true	
		CreateMenu(Bulletpol)
		ExecuteCommand('me change sa tenue.')
	elseif not haveub then
		kevlarpolice =false
		TriggerEvent('skinchanger:change', 'bproof_1', 0)
		TriggerEvent('skinchanger:change', 'bproof_2', 0)
		ClearPedBloodDamage(playerPed)
		ResetPedVisibleDamage(playerPed)
		ClearPedLastWeaponDamage(playerPed)
		SetPedArmour(playerPed, 0)
		kevlar = false
		haveub = false
	end
end)