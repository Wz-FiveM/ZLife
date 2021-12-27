local configPed = {}
local configMission = {}
local MissionDone = {}
local sync = false
local MenuOpen = false
local SpawnVehSecur = {
    {pos = vector3(-1902.88, 240.08, 86.24-0.95),heading = 31.07,stop = vector3(1508.84, -2147.48, 77.16),},
    {pos = vector3(1643.28, 4839.24, 42.04-0.95),heading = 98.22,stop = vector3(-1132.92, 2697.64, 18.8),},
    {pos = vector3(905.8, -1059.76, 32.84-0.95),heading = 270.00,stop = vector3(-3102.56, 253.04, 11.96),},
    {pos = vector3(1259.0, 2727.56, 38.48-0.95),heading = 269.99,stop = vector3(-975.2, -268.64, 38.32),},
    {pos = vector3(1551.88, 2194.88, 78.88-0.95),heading = 357.89,stop = vector3(727.72, -1291.6, 26.28),},
}
local VehSecur = {
    {name = "bobcatxl"},
    {name = "coquette3"},
    {name = "rebel2"},
    {name = "cavalcade"},
    {name = "seminole"},
    {name = "fugitive"},
    {name = "buffalo2"},
    {name = "kuruma"},
    {name = "coquette2"},
    {name = "michelli"},
    {name = "fagaloa"},
    {name = "gburrito2"},
    {name = "bison"},
    {name = "minivan"},
    {name = "rancherxl"},
    {name = "sandking"},
    {name = "vamos"},
    {name = "moonbeam"},
    {name = "dominator"},
    {name = "oracle"},
    {name = "sentinel2"},
    {name = "zion"},
    {name = "clique"},
    {name = "felon"},
    {name = "speedo4"},
    {name = "youga2"},
}

ESX = nil
Citizen.CreateThread(function()
	while ESX == nil do
    	TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
    	Citizen.Wait(0)
	end
end)

Citizen.CreateThread(function()
    TriggerServerEvent("clp_mission:GetConfig")
    TriggerServerEvent("clp_mission:status")
end)
RegisterNetEvent("clp_mission:GetConfig")
AddEventHandler("clp_mission:GetConfig", function(confPed, confMission)
    configPed = confPed
    configMission = confMission
    sync = true
end)
RegisterNetEvent("clp_mission:status")
AddEventHandler("clp_mission:status", function(done)
    MissionDone = done
end)

RMenu.Add('mission', 'main', RageUI.CreateMenu("Missions", " "))
RMenu:Get('mission', 'main'):SetSubtitle("~b~Missions disponibles")
RMenu:Get('mission', 'main').EnableMouse = false
RMenu:Get('mission', 'main').Closed = function()
    MenuOpen = false
end;

local function startScreenSec()
    local pCoords = GetEntityCoords(GetPlayerPed(-1))
    local nvaIsNv7 = GetStreetNameFromHashKey(GetStreetNameAtCoord(pCoords.x, pCoords.y, pCoords.z, 0, 0))
    local vehicuecol = 2;
    local reussitetaux = 79.0;
    local vehexport = 100;
    local reusiiteexport = 100.0;
    local gain = 4000
    local scalsec = createScaleform("securoserv", {{
        name = "DEACTIVATE"
    }, {
        name = "SET_PLAYER_DATA",
        param = {"Macbeat", true, 6.0, 11, 5.0, 2, 4.0, "Informations", vehicuecol, reussitetaux, vehexport,
                 reusiiteexport, gain, false, pCoords.x, pCoords.y}
    }, {
        name = "UPDATE_COOLDOWN",
        param = {1000}
    }, {
        name = "ADD_VEHICLE_WAREHOUSE",
        param = {2, 0.0, 0.0, 0, 0, 0, 0, 0, 0, "SecuroServ", nvaIsNv7, "IE_WH_DESC_1", "IE_WH_TXD_4", true, 0.0, 2.0,
                 0.0, 0.0}
    }})
    PushScaleformMovieFunction(scalsec, "showScreen")
    PushScaleformMovieFunctionParameterInt(4)
    PopScaleformMovieFunctionVoid()
    return scalsec
end
local function CloseSec()
    ClearHelp(true)
    if PaneauSecur then
        PlaySoundFrontend(-1,"Logout","GTAO_Exec_SecuroServ_Computer_Sounds",true)
		SetScaleformMovieAsNoLongerNeeded(PaneauSecur)
		PaneauSecur=nil 
    end 
end
local function CliclSecu(paneau)
    local J,F=GetDisabledControlNormal(2,239),GetDisabledControlNormal(2,240)PushScaleformMovieFunction(paneau,"SET_MOUSE_INPUT")
    PushScaleformMovieFunctionParameterFloat(J)
    PushScaleformMovieFunctionParameterFloat(F)
    PopScaleformMovieFunctionVoid()
    EnableControlAction(2,237,1)
    if IsControlJustPressed(2,237)then
        CallScaleformMovieFunctionFloatParams(paneau,"SET_INPUT_EVENT",237.0,-1082130432,-1082130432,-1082130432,-1082130432)
		PlaySoundFrontend(-1,"Mouse_Click","GTAO_Exec_SecuroServ_Warehouse_PC_Sounds",true)
        CloseSec()
        VolVehSecuro("~r~SecuroServ\n~s~Un véhicule viens d'être retrouvé, vas le chercher et ramène le en bon état !", VehSecur, SpawnVehSecur, 2000, 7) 
    end;
    EnableControlAction(2,238,1)
    if IsControlJustPressed(2,238)then
        CallScaleformMovieFunctionFloatParams(paneau,"SET_INPUT_EVENT",202.0,-1082130432,-1082130432,-1082130432,-1082130432)
    end;
    EnableControlAction(2,177,1)
    if IsControlJustPressed(2,177)then 
        CloseSec()
    end 
end;

local function OpenMenu(id)
    RageUI.Visible(RMenu:Get('mission', 'main'), not RageUI.Visible(RMenu:Get('mission', 'main')))
    while MenuOpen do
        Citizen.Wait(1)
        if RageUI.Visible(RMenu:Get('mission', 'main')) then
            RageUI.DrawContent({ header = true, glare = true, instructionalButton = true }, function()
                for _,v in pairs(configMission) do
                    if v.ped == id then
                        local done = false
                        for _,i in pairs(MissionDone) do
                            if v.id == i then
                                done = true
                            end
                        end
                        if not done then
                            RageUI.Button(v.Titre.." - ~g~Possible", v.Desc, {}, true, function(Hovered, Active, Selected)
                                if (Selected) then
                                    if v.type == "voleVehicule" then
                                        RageUI.Visible(RMenu:Get('mission', 'main'), not RageUI.Visible(RMenu:Get('mission', 'main')))
                                        MenuOpen = false
                                        TriggerEvent("randPickupAnim")
                                        VoleDeVehicule(v.LongText, v.vehicule, v.possibleSpawn, v.stop, v.prix, v.id) 
                                    elseif v.type == "voleVehiculeLamar" then
                                        RageUI.Visible(RMenu:Get('mission', 'main'), not RageUI.Visible(RMenu:Get('mission', 'main')))
                                        MenuOpen = false
                                        TriggerEvent("randPickupAnim")
                                        VoleDeVehiculeLamar(v.LongText, v.vehicule, v.possibleSpawn, v.stop, v.prix, v.id) 
                                    elseif v.type == "voleSecuroserv" then
                                        RageUI.Visible(RMenu:Get('mission', 'main'), not RageUI.Visible(RMenu:Get('mission', 'main')))
                                        MenuOpen = false
                                        local d = exports.zClothes:ESXP_GetXP()
                                        if d >= 20000 then 
                                            PaneauSecur=startScreenSec()
                                        else
                                            ShowAboveRadarMessage("~r~Vous devez être un ~b~Soldat~r~ pour faire cette mission.")
                                        end
                                    elseif v.type == "voleMarchandise" then
                                        RageUI.Visible(RMenu:Get('mission', 'main'), not RageUI.Visible(RMenu:Get('mission', 'main')))
                                        MenuOpen = false
                                        local d = exports.zClothes:ESXP_GetXP()
                                        if d >= 10000 then 
                                            TriggerEvent("randPickupAnim")
                                            Voledemarchandise(v.LongText, v.vehicule, v.possibleSpawn, v.stop, v.prix, v.id) 
                                        else
                                            ShowAboveRadarMessage("~r~Vous devez être un ~b~Escroc~r~ pour faire cette mission.")
                                        end
                                    elseif v.type == "braquo" then
                                        RageUI.Visible(RMenu:Get('mission', 'main'), not RageUI.Visible(RMenu:Get('mission', 'main')))
                                        MenuOpen = false
                                        local d = exports.zClothes:ESXP_GetXP()
                                        if d >= 10000 then 
                                            TriggerEvent("randPickupAnim")
                                            braquo(v)
                                        else
                                            ShowAboveRadarMessage("~r~Vous devez être un ~b~Escroc~r~ pour faire cette mission.")
                                        end
                                    end
                                end
                            end)
                        else
                            RageUI.Button(v.Titre.." - ~r~Impossible", nil, { RightBadge = RageUI.BadgeStyle.Lock }, true, function(Hovered, Active, Selected)
                                if (Selected) then
                                    ShowAboveRadarMessage("~r~Vous avez déjà réalisé cette mission.")
                                end
                            end)
                        end
                    end
                end
            end, function()
            end)
        end
    end
end

Citizen.CreateThread(function()
    while true do
        local attente = 500
        local pPed = GetPlayerPed(-1)
        local pCoords = GetEntityCoords(pPed)
        for _,v in pairs(configPed) do
            local dst = GetDistanceBetweenCoords(pCoords, v.coords)
            if not IsPedInAnyVehicle(pPed, false) then 
                if dst <= 2.0 then
                    attente = 5
                    DrawText3D(v.coords.x,v.coords.y,v.coords.z+1.1, "Appuyez sur ~b~E ~w~pour ~b~accéder aux missions.", 9)
                    if IsControlJustReleased(1, 38) then
                        MenuOpen = true
                        OpenMenu(v.id)
                    end
                end
            elseif IsPedInAnyVehicle(pPed, false) then 
                attente = 2500
            end
        end
        if PaneauSecur and HasScaleformMovieLoaded(PaneauSecur)then
            attente = 1
            DrawScaleformMovieFullscreen(PaneauSecur,255,255,255,255)
            CliclSecu(PaneauSecur)
            HideHudAndRadarThisFrame()
            DisableAllControlActions(0)
            DisableControlAction(2,200,1)
        end 
        Wait(attente)
    end
end)

function StartMusicEvent(event)
	PrepareMusicEvent(event)
	return TriggerMusicEvent(event) == 1
end

function SpawnVeh(vehicle, start, heading)
    RequestModel(vehicle)
    while not HasModelLoaded(vehicle) do Wait(100) end

    local veh = CreateVehicle(vehicle, start, heading, 1, 0) 
    SetVehicleDoorsLocked(veh, 1)
	SetVehicleDoorsLockedForAllPlayers(veh, false)
    SetEntityAsMissionEntity(veh,true,true)
    SetVehicleHasBeenOwnedByPlayer(veh,true)
    TaskWarpPedIntoVehicle(GetPlayerPed(-1), veh, -1)
    SetVehicleNumberPlateText(veh, "BRAQU911")
end

function SpawnVehNotIn(vehicle, start, heading, plate)
    RequestModel(vehicle)
    while not HasModelLoaded(vehicle) do Wait(100) end

    local veh = CreateVehicle(vehicle, start, heading, 1, 0) 
    SetVehicleDoorsLocked(veh, 0)
	SetVehicleDoorsLockedForAllPlayers(veh, true)
    SetEntityAsMissionEntity(veh,false,false)
    SetVehicleHasBeenOwnedByPlayer(veh,false)
    SetVehicleNumberPlateText(veh, plate)
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


str = "Mission réussite."
local rt = RequestScaleformMovie("MP_BIG_MESSAGE_FREEMODE")

function d()
	Citizen.CreateThread(function()
		while true do
			if HasScaleformMovieLoaded(rt) then
				HideHudComponentThisFrame(7)
				HideHudComponentThisFrame(8)
				HideHudComponentThisFrame(9)
				HideHudComponentThisFrame(6)
				HideHudComponentThisFrame(19)
	
				if (curMsg == "SHOW_MISSION_PASSED_MESSAGE") then
				
				PushScaleformMovieFunction(rt, curMsg)
	 
				PushScaleformMovieMethodParameterString(str)
				EndScaleformMovieMethod()
	
				PushScaleformMovieFunctionParameterInt(145)
				PushScaleformMovieFunctionParameterBool(false)
				PushScaleformMovieFunctionParameterInt(1)
				PushScaleformMovieFunctionParameterBool(true)
				PushScaleformMovieFunctionParameterInt(69)
	
				PopScaleformMovieFunctionVoid()
	
				Citizen.InvokeNative(0x61bb1d9b3a95d802, 1)
				end
				
				DrawScaleformMovieFullscreen(rt, 255, 255, 255, 255)
			end
			Wait(0)
		end
	end)
	StartScreenEffect("SuccessTrevor",  2500,  false)
	curMsg = "SHOW_MISSION_PASSED_MESSAGE"
	SetAudioFlag("AvoidMissionCompleteDelay", true)
	PlayMissionCompleteAudio("FRANKLIN_BIG_01")
	Citizen.Wait(3000)
	StopScreenEffect()
	curMsg = "TRANSITION_OUT"
	PushScaleformMovieFunction(rt, "TRANSITION_OUT")
	PopScaleformMovieFunction()
	Citizen.Wait(2000)
end

local finish = false
function VolVehSecuro(longtext, veh, SpawnVehSecur, prix, id)
    StartMusicEvent("MP_MC_ASSAULT_ADV_START")
    StartMusicEvent("MP_MC_ASSAULT_ADV_SUSPENSE")
    StartMusicEvent("DHP1_VEHICLE_ARRIVE")
    ESX.AddTimerBar("TEMPS RESTANT :",{endTime=GetGameTimer()+60*1000*20})
    local i = math.random(1, #SpawnVehSecur)
    local a = math.random(1, #veh)
    local vehicule = veh[a].name
    local spawn = SpawnVehSecur[i].pos
    local heading = SpawnVehSecur[i].heading
    local stop = SpawnVehSecur[i].stop
    ShowAboveRadarMessage(longtext)

    local blip = createBlip(spawn ,326,28,"Véhicule à récupérer",true,1.0)
    local pPed = GetPlayerPed(-1)
    local pVeh = GetVehiclePedIsIn(pPed, false)
    local pCoords = GetEntityCoords(pPed)
    local dst = GetDistanceBetweenCoords(spawn, pCoords, true)
    while dst >= 30.0 do
        Wait(100)
        pCoords = GetEntityCoords(pPed)
        dst = GetDistanceBetweenCoords(spawn, pCoords, true)
        RageUI.Text({message = "Dirigez vous vers ~r~la destination~s~."})
    end
    local coords = {x=spawn.x,y=spawn.y,z=spawn.z}
    TriggerServerEvent("call:makeCall","police",coords,"Transaction bizarre.")
    AddTextEntry("VOLE_VEH_MISSION", "Véhicule à récupérer.")
    SpawnVehNotIn(vehicule, spawn, heading, "SECUROSE")
    createped("s_m_m_chemsec_01",spawn,heading,GetPlayerPed(-1),"weapon_heavypistol")
    createped("s_m_y_pestcont_01",spawn,heading,GetPlayerPed(-1),"weapon_machinepistol")

    while dst >= 3.0 do
        Wait(1)
        DistantCopCarSirens(1)
        ShowFloatingHelp("VOLE_VEH_MISSION", spawn)
        RageUI.Text({message = "Le ~r~véhicule ~s~n'est pas loin."})
        pCoords = GetEntityCoords(pPed)
        DrawMarker(0,spawn.x,spawn.y,spawn.z+2.6,0.0,0.0,0.0,0.0,0.0,0.0,1.0,1.0,0.7,0,192,255,70,0,0,2,0,0,0,0)
        dst = GetDistanceBetweenCoords(spawn, pCoords, true)
    end

    RemoveBlip(blip)

    local blip = createBlip(stop ,326,37,"Destination",true,1.0)
    
    local dst = GetDistanceBetweenCoords(stop, pCoords, true)
    PlaySoundFrontend(-1, "Object_Dropped_Remote", "GTAO_FM_Events_Soundset", 0)
    ShowAboveRadarMessage("~r~SecuroServ\n~s~Crochetez le véhicule avec vos lockpick.")
    SetFakeWantedLevel(2)
    while dst >= 5.0 do
        Wait(1)
        RageUI.Text({message = "Livrez le véhicule ~r~à destination~s~."})
        pCoords = GetEntityCoords(pPed)
        dst = GetDistanceBetweenCoords(pCoords, stop, true)
    end

    local plate = GetVehicleNumberPlateText(GetVehiclePedIsIn(GetPlayerPed(-1), 0))
    local pEngine = GetVehicleEngineHealth(GetVehiclePedIsIn(GetPlayerPed(-1)))
    if plate == "SECUROSE" then 
        if pEngine > 750 then 
            ESX.RemoveTimerBar()
            PlaySoundFrontend(-1, "Out_Of_Bounds_Timer", "DLC_HEISTS_GENERAL_FRONTEND_SOUNDS", 0)
            ShowAboveRadarMessage("~b~SecuroServ\n~s~Vous avez reçu de l'argent. (~r~"..prix.."$~s~).")
            DistantCopCarSirens(0)
            RemoveBlip(blip)
            SetBlipRoute(blip, 0)
            TaskVehicleTempAction(GetPlayerPed(-1), GetVehiclePedIsIn(GetPlayerPed(-1), 0), 6, 2000)
            Wait(2000)
            TaskLeaveAnyVehicle(GetPlayerPed(-1), 0, 0)
            SetVehicleDoorsLocked(GetVehiclePedIsIn(GetPlayerPed(-1), 1), 1)
            StartMusicEvent("MP_MC_ASSAULT_ADV_STOP")
            TriggerServerEvent("clp_mission:givemoney", prix)
            TriggerServerEvent("clp_mission:SetStatus", id)
            SetFakeWantedLevel(0)
            DeleteVehi()
            TriggerEvent('esx_xp:Add',  1500)
            d()
            if not finish then
                finish = true 
                VolVehSecuro("~r~SecuroServ\n~s~Un autre véhicule viens d'être retrouvé, vas le chercher et ramène le en bon état !", veh, SpawnVehSecur, 2000, 7) 
            end
        else 
            ShowAboveRadarMessage("~r~SecuroServ\n~s~Votre véhicule est trop abimé.")
            ESX.RemoveTimerBar()
            PlaySoundFrontend(-1, "Out_Of_Bounds_Timer", "DLC_HEISTS_GENERAL_FRONTEND_SOUNDS", 0)
            DistantCopCarSirens(0)
            RemoveBlip(blip)
            SetBlipRoute(blip, 0)
            TaskVehicleTempAction(GetPlayerPed(-1), GetVehiclePedIsIn(GetPlayerPed(-1), 0), 6, 2000)
            Wait(2000)
            TaskLeaveAnyVehicle(GetPlayerPed(-1), 0, 0)
            SetVehicleDoorsLocked(GetVehiclePedIsIn(GetPlayerPed(-1), 1), 1)
            StartMusicEvent("MP_MC_ASSAULT_ADV_STOP")
            TriggerServerEvent("clp_mission:SetStatus", id)
            Wait(3500)
            DeleteVehi()
            SetFakeWantedLevel(0)
        end
    else
        local pPed = LocalPlayer()
        local pVehs = pPed:GetVehicle()
        ESX.RemoveTimerBar()
        DistantCopCarSirens(0)
        PlaySoundFrontend(-1, "Out_Of_Bounds_Timer", "DLC_HEISTS_GENERAL_FRONTEND_SOUNDS", 0)
        RemoveBlip(blip)
        SetBlipRoute(blip, 0)
        ShowAboveRadarMessage("~r~SecuroServ\n~s~T'a essayé de me niquer ? T'aurais pas dû !")
        print(pVehs)
        StartMusicEvent("MP_MC_ASSAULT_ADV_STOP")
        TriggerServerEvent("clp_mission:SetStatus", id)
        SetEntityHealth(GetPlayerPed(-1), 125)
        DeleteVehi()
        SetFakeWantedLevel(0)
        TriggerEvent('esx_xp:Add',  -1500)
    end
end
