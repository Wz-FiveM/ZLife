local sexeSelect = 0
local teteSelect = 0
local colorPeauSelect = 0
local cheveuxSelect = 0
local bebarSelect = -1
local poilsCouleurSelect = 0
local ImperfectionsPeau = 0
local face, acne, skin, eyecolor, skinproblem, freckle, wrinkle, hair, haircolor, eyebrow, beard, beardcolor
local camfin = false
local creaperso = false 

PMenu = {}
PMenu.Data = {}

local playerPed = PlayerPedId()
local incamera = false
local board_scaleform
local handle
local board
local board_model = GetHashKey("prop_police_id_board")
local board_pos = vector3(0.0,0.0,0.0)
local overlay
local overlay_model = GetHashKey("prop_police_id_text")
local isinintroduction = false
local pressedenter = false
local introstep = 0
local timer = 0
local inputgroups = {0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17, 18, 19, 20, 21, 22, 23, 24, 25, 26, 27, 28, 29, 30, 31}
local enanimcinematique = false
local InIntro = false
local namepedlist = Config.namepedList

local myIdentifiers = {}

local sound = false

local function introstart()
    --TriggerServerEvent("SetBucket:enter")
    InIntro = true
	local Camera
	local DoTime = 1000
    local CamTime = 12000
    local pPed = GetPlayerPed(-1)
    local pCoords = GetEntityCoords(pPed)
    TriggerEvent("playerSpawned")
    FreezeEntityPosition(PlayerPedId(),true)
    DestroyAllCams()
    TriggerEvent('es:setMoneyDisplay', 0.0)
	DisplayRadar(false)
	SetTimecycleModifier("DefaultColorCode")
    TriggerMusicEvent("GLOBAL_KILL_MUSIC")
    SetOverrideWeather("EXTRASUNNY")
    NetworkOverrideClockTime(16,0,0)
    PrepareMusicEvent("FM_INTRO_START")
	TriggerMusicEvent("FM_INTRO_START")
	PlaySoundFrontend(-1, "Short_Transition_In", "PLAYER_SWITCH_CUSTOM_SOUNDSET")
    SetEntityVisible(GetPlayerPed(-1), false)
    DoScreenFadeOut(0)
    DoScreenFadeIn(1000)
    TriggerEvent('esx_status:setDisplay', 0.0)
    RequestCollisionAtCoord(pCoords.x, pCoords.y, pCoords.z)
    ClearPedTasksImmediately(pPed)
    ClearPlayerWantedLevel(PlayerId())
    while not HasCollisionLoadedAroundEntity(pPed) do
        Citizen.Wait(100)
    end
    ShutdownLoadingScreen()
    DoScreenFadeIn(500)
    while IsScreenFadingIn() do
        Citizen.Wait(100)
    end
    SetPoliceIgnorePlayer(GetPlayerPed(-1), true) 
	
    Citizen.CreateThread(function()
        while true do
            Citizen.Wait(0)
                DrawNiceText(.5,.8,0.8,"Appuyez sur ~b~SPACE~w~ pour valider votre chargement.",4,0)
				if IsControlJustPressed(1,18) then 
					InIntro = false
                    ShowAboveRadarMessage("~g~Chargement de votre personnage.")
					local playerCoord = GetEntityCoords(GetPlayerPed(-1))
					RequestCollisionAtCoord(playerCoord.x, playerCoord.y, playerCoord.z)
					Wait(1500)
					DoScreenFadeOut(1000)
					Wait(1000)
					local coords = GetOffsetFromEntityInWorldCoords(GetPlayerPed(-1), 0.0, -3.0, 4.5)
					SetCamFov(Camera,50.0)
					SetCamCoord(Camera,coords.x, coords.y, coords.z)
					PointCamAtEntity(Camera,GetPlayerPed(-1))
					NetworkClearVoiceChannel()
					Wait(500)
					SetEntityVisible(GetPlayerPed(-1), true, 0)
					SetEntityCollision(GetPlayerPed(-1), true)
					FreezeEntityPosition(GetPlayerPed(-1), false)
					SetFocusArea(GetEntityCoords(GetPlayerPed(-1)), 0.0, 0.0, 0.0)
					ClearFocus()
					SetFocusEntity(GetPlayerPed(PlayerId()))   
					RenderScriptCams(false, true, 4000, true, true)
					DestroyCam(Camera)
					DoScreenFadeIn(4000)
					ClearTimecycleModifier()
                    PlaySoundFrontend(-1, "1st_Person_Transition", "PLAYER_SWITCH_CUSTOM_SOUNDSET", 0)
                    PlaySoundFrontend(-1, "SwitchWhiteWarning", "SPECIAL_ABILITY_SOUNDSET", 0)
                    TriggerEvent('c_inv:relaodinv')
                    PrepareMusicEvent("FM_SUDDEN_DEATH_STOP_MUSIC")
                    TriggerMusicEvent("FM_SUDDEN_DEATH_STOP_MUSIC")
                    TriggerServerEvent("mumble:Initialise")
                    ShowAboveRadarMessage("~g~Votre personnage a bien été chargé.")
                    Wait(2500)
                    TriggerEvent('demarche:loadsave', true, true)
                    TriggerServerEvent('c_health:upstarhe')
                    TriggerEvent('esx_health:pl')
                    TriggerMusicEvent("ASS1_LOST")
                    return 
                end 
            end 
        end)
    Camera = CreateCam('DEFAULT_SCRIPTED_CAMERA', true)
    SetCamCoord(Camera,0,0,1500.0)
    SetCamRot(Camera, -90.0, 0.0, 0.0, true)
    SetCamFov(Camera,100.0)
    ShakeCam(Camera,"HAND_SHAKE",0.7)
    SetCamActive(Camera, true)
    RenderScriptCams(true, true, 10, true, true)
	Citizen.Wait(CamTime)
	if not InIntro then 
		return 
	end
	DoScreenFadeOut(DoTime)
	Citizen.Wait(DoTime)
	DoScreenFadeIn(DoTime)
    SetCamCoord(Camera,1028.0,2415.0,1500.0)
    SetCamRot(Camera, -90.0, 0.0, 0.0, true)
    SetCamFov(Camera,100.0)
    ShakeCam(Camera,"HAND_SHAKE",0.7)
    SetCamActive(Camera, true)
	RenderScriptCams(true, true, 10, true, true)
	Citizen.Wait(CamTime)
	if not InIntro then 
		return 
	end
	DoScreenFadeOut(DoTime)
	Citizen.Wait(DoTime)
	DoScreenFadeIn(DoTime)
    SetCamCoord(Camera,1789.0,3648.0,1500.0)
    SetCamRot(Camera, -90.0, 0.0, 0.0, true)
    SetCamFov(Camera,100.0)
    ShakeCam(Camera,"HAND_SHAKE",0.7)
    SetCamActive(Camera, true)
	RenderScriptCams(true, true, 10, true, true)
	Citizen.Wait(CamTime)
	if not InIntro then 
		return 
	end
	DoScreenFadeOut(DoTime)
	Citizen.Wait(DoTime)
	DoScreenFadeIn(DoTime)
    SetCamCoord(Camera,36.0,4260.0,1500.0)
    SetCamRot(Camera, -90.0, 0.0, 0.0, true)
    SetCamFov(Camera,100.0)
    ShakeCam(Camera,"HAND_SHAKE",0.7)
    SetCamActive(Camera, true)
	RenderScriptCams(true, true, 10, true, true)
	Citizen.Wait(CamTime)
	if not InIntro then 
		return 
	end
	DoScreenFadeOut(DoTime)
	Citizen.Wait(DoTime)
	DoScreenFadeIn(DoTime)
    SetCamCoord(Camera,277.0,5332.0,1500.0)
    SetCamRot(Camera, -90.0, 0.0, 0.0, true)
    SetCamFov(Camera,100.0)
    ShakeCam(Camera,"HAND_SHAKE",0.7)
    SetCamActive(Camera, true)
	RenderScriptCams(true, true, 10, true, true)
	Citizen.Wait(CamTime)
	if not InIntro then 
		return 
	end
	DoScreenFadeOut(DoTime)
	Citizen.Wait(DoTime)
	DoScreenFadeIn(DoTime)
	coords = GetOffsetFromEntityInWorldCoords(GetPlayerPed(-1), 0.0, -3.0, 4.5)
    SetCamCoord(Camera,coords.x, coords.y, coords.z+60.0)
    SetCamRot(Camera, -90.0, 0.0, 0.0, true)
    SetCamFov(Camera,100.0)
    ShakeCam(Camera,"HAND_SHAKE",0.7)
    SetCamActive(Camera, true)
	RenderScriptCams(true, true, 10, true, true)
end;

local function LoadScaleform (scaleform)
	local handle = RequestScaleformMovie(scaleform)
	if handle ~= 0 then
		while not HasScaleformMovieLoaded(handle) do
			Citizen.Wait(0)
		end
	end
	return handle
end


local function CreateNamedRenderTargetForModel(name, model)
	local handle = 0
	if not IsNamedRendertargetRegistered(name) then
		RegisterNamedRendertarget(name, 0)
	end
	if not IsNamedRendertargetLinked(model) then
		LinkNamedRendertarget(model)
	end
	if IsNamedRendertargetRegistered(name) then
		handle = GetNamedRendertargetRenderId(name)
	end

	return handle
end

local function CallScaleformMethod (scaleform, method, ...)
	local t
	local args = { ... }

	BeginScaleformMovieMethod(scaleform, method)

	for k, v in ipairs(args) do
		t = type(v)
		if t == 'string' then
			PushScaleformMovieMethodParameterString(v)
		elseif t == 'number' then
			if string.match(tostring(v), "%.") then
				PushScaleformMovieFunctionParameterFloat(v)
			else
				PushScaleformMovieFunctionParameterInt(v)
			end
		elseif t == 'boolean' then
			PushScaleformMovieMethodParameterBool(v)
		end
	end
	EndScaleformMovieMethod()
end


function CreateBoard(ped)
    local plyData = ESX.GetPlayerData()
    RequestModel(board_model)
    while not HasModelLoaded(board_model) do Wait(0) end
    RequestModel(overlay_model)
    while not HasModelLoaded(overlay_model) do Wait(0) end
    board = CreateObject(board_model, GetEntityCoords(ped), false, true, false)
    overlay = CreateObject(overlay_model, GetEntityCoords(ped), false, true, false)
    AttachEntityToEntity(overlay, board, -1, 4103, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, false, false, false, false, 2, true)
    ClearPedWetness(ped)
    ClearPedBloodDamage(ped)
    ClearPlayerWantedLevel(PlayerId())
    SetCurrentPedWeapon(ped, GetHashKey("weapon_unarmed"), 1)
    AttachEntityToEntity(board, ped, GetPedBoneIndex(ped, 28422), 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0, 0, 0, 0, 2, 1)
    CallScaleformMethod(board_scaleform, 'SET_BOARD', "Nouveau", "1,500$", 'LOS SANTOS POLICE DEPT', 'Civil')
end

local FirstSpawn     = true
local LastSkin       = nil
local PlayerLoaded   = false

RegisterNetEvent('esx:playerLoaded')
AddEventHandler('esx:playerLoaded', function(xPlayer)
    PlayerLoaded = true
    TriggerEvent('c_inv:relaodinv')
end)

AddEventHandler('playerSpawned', function()
	Citizen.CreateThread(function()
		while not PlayerLoaded do
			Citizen.Wait(10)
		end
		if FirstSpawn then
			ESX.TriggerServerCallback('esx_skin:getPlayerSkin', function(skin, jobSkin)
				if skin == nil then
					TriggerEvent('c_charact:create')
				else
                    TriggerEvent('skinchanger:loadSkin', skin)
                    introstart()
				end
			end)
			FirstSpawn = false
		end
	end)
end)
function createcam(default, x,y,z,angle,angle1,zoom1,zoom)
    DisplayRadar(false)
    --TriggerEvent('esx_status:setDisplay', 0.0)
    RenderScriptCams(false, false, 0, 1, 0)
    DestroyCam(cam, false)
    if (not DoesCamExist(cam)) then
        if default then
            cam = CreateCamWithParams('DEFAULT_SCRIPTED_CAMERA', x, y, z, angle, angle1, zoom1, zoom, false, 0)
        else
            cam = CreateCamWithParams('DEFAULT_SCRIPTED_CAMERA', x, y, z, angle, angle1, zoom1, zoom, false, 0)
        end
        SetCamActive(cam, true)
        RenderScriptCams(true, false, 0, true, false)
    end
end

function CreateCamEnter()
    cam = CreateCamWithParams("DEFAULT_SCRIPTED_CAMERA", 415.55, -998.50, -99.29, 0.00, 0.00, 89.75, 50.00, false, 0)
    SetCamActive(cam, true)
    RenderScriptCams(true, false, 2000, true, true) 
end
function SpawnCharacter()
    cam2 = CreateCamWithParams("DEFAULT_SCRIPTED_CAMERA", 411.30, -998.62, -99.01, 0.00, 0.00, 89.75, 50.00, false, 0)
    PointCamAtCoord(cam2, 411.30, -998.62, -99.01)
    SetCamActiveWithInterp(cam2, cam, 5000, true, true)
end
function destorycam()
    RenderScriptCams(false, false, 0, 1, 0)
    DestroyCam(cam, false)
end
RegisterNetEvent('c_character:SpawnCharacter')
AddEventHandler('c_character:SpawnCharacter', function(spawn)
    PrepareMusicEvent("FM_INTRO_START")
    TriggerMusicEvent("FM_INTRO_START")
    SetOverrideWeather("EXTRASUNNY")
    SetWeatherTypePersist("EXTRASUNNY")
    NetworkOverrideClockTime(12, 0, 0)
    RenderScriptCams(0, 0, 1, 1, 1)
    ClearTimecycleModifier("scanline_cam_cheap")
    SetFocusEntity(GetPlayerPed(PlayerId()))
    DoScreenFadeOut(0)
    SetEntityCoords(PlayerPedId(), -785.36, -1044.56, 13.0)
    SetEntityCollision(GetPlayerPed(-1), true, true)

    for k, v in pairs(GetActivePlayers()) do 
        if v ~= GetPlayerIndex() then 
            print('sortie instance')
            NetworkConcealPlayer(v, false, false) 
        end 
    end

    SetEntityHeading(PlayerPedId(), 117.07)
    FreezeEntityPosition(PlayerPedId(), false)
    SetBlockingOfNonTemporaryEvents(PlayerPedId(), false)
    UnpinInterior(GetInteriorAtCoordsWithType(vector3(399.9, -998.7, -100.0), "v_mugshot"))
    DoScreenFadeIn(1500)
    ClearPedTasks(GetPlayerPed(-1))
    Citizen.Wait(500)
    ESX.ShowNotification("~g~Vous sortez du bureau de douane.\n~s~Nous vous souhaitons un agréable séjour parmis nous.")
    --TriggerEvent('esx_status:setDisplay', 1.0)
    TriggerEvent('instance:close')
    destorycam()
    SetPlayerInvincible(PlayerPedId(), false)
    Citizen.Wait(5000)
    PrepareMusicEvent("FM_SUDDEN_DEATH_STOP_MUSIC")
    TriggerMusicEvent("FM_SUDDEN_DEATH_STOP_MUSIC")
    SetEntityVisible(GetPlayerPed(-1), true, false)
end)

TakePhoto = N_0xa67c35c56eb1bd9d
WasPhotoTaken = N_0x0d6ca79eeebd8ca3
SavePhoto = N_0x3dec726c25a11bac
ClearPhoto = N_0xd801cc02177fa3f1

function savephotowashphone()
	CreateMobilePhone(1)
	-- CellCamActivate(true, true)

	TakePhoto()

	if WasPhotoTaken() then
		SavePhoto(-1)
		ClearPhoto()
		PlaySoundFrontend(-1, "Camera_Shoot", "Phone_Soundset_Franklin", 0)
	end

	DestroyMobilePhone()
end

function startAnims(lib, anim)
	ESX.Streaming.RequestAnimDict(lib, function()
		TaskPlayAnim(PlayerPedId(), lib, anim, 8.0, 8.0, -1, 14, 0, false, false, false)
	end)
end

local interior_pos1 = vector3(399.9, -998.7, -100.0)
local interior1 = GetInteriorAtCoordsWithType(interior_pos1, "v_mugshot")

local overlay_model = GetHashKey("prop_police_id_text")
local board_model = GetHashKey("prop_police_id_board")

RegisterNetEvent("clp_char:createsign")
AddEventHandler("clp_char:createsign", function(name, job, money)
	local function LoadScaleform (scaleform)
		local handle = RequestScaleformMovie(scaleform)

		if handle ~= 0 then
			while not HasScaleformMovieLoaded(handle) do
				Citizen.Wait(0)
			end
		end

		return handle
	end

	local function CallScaleformMethod (scaleform, method, ...)
		local t
		local args = { ... }

		BeginScaleformMovieMethod(scaleform, method)

		for k, v in ipairs(args) do
			t = type(v)
			if t == 'string' then
				PushScaleformMovieMethodParameterString(v)
			elseif t == 'number' then
				if string.match(tostring(v), "%.") then
					PushScaleformMovieFunctionParameterFloat(v)
				else
					PushScaleformMovieFunctionParameterInt(v)
				end
			elseif t == 'boolean' then
				PushScaleformMovieMethodParameterBool(v)
			end
		end

		EndScaleformMovieMethod()
	end

	local interior_pos = vector3(399.9, -998.7, -100.0)
	local interior = GetInteriorAtCoordsWithType(interior_pos, "v_mugshot")
	local room = 2086940140 -- mugshot room
	local lineup_male = "mp_character_creation@lineup@male_a"

	local handle
	local board
	local board_pos = vector3(409.02, -1000.8, -98.859)
	local board_scaleform
	local overlay

	local camera_scaleform
	local campis

	--
	local TakePhoto = N_0xa67c35c56eb1bd9d
	local WasPhotoTaken = N_0x0d6ca79eeebd8ca3
	local SavePhoto = N_0x3dec726c25a11bac
	local ClearPhoto = N_0xd801cc02177fa3f1
	--

	local function Cleanup()
		ReleaseNamedRendertarget("ID_Text")
		SetScaleformMovieAsNoLongerNeeded(board_scaleform)
		DeleteObject(overlay)
		DeleteObject(board)
		DestroyCam(campis, 1)
		ReleaseNamedScriptAudioBank("DLC_GTAO/MUGSHOT_ROOM")
		ReleaseNamedScriptAudioBank("Mugshot_Character_Creator")
		RemoveAnimDict(lineup_male)
		ClearPedTasksImmediately(PlayerPedId())
        StopPlayerSwitch()
        destorycam()
        UnpinInterior("v_mugshot")
        FreezeEntityPosition(GetPlayerPed(-1), false)
		handle = false
	end

    local function TaskHoldBoard()
        --TriggerEvent('esx_status:setDisplay', 0.0)
        local empty, sequence = OpenSequenceTask(0)
        local dict, anim = lineup_male, "react_light"
        local anim1 = "Loop"
        ESX.Streaming.RequestAnimDict(dict)
		TaskPlayAnim(0, dict, anim, 8.0, -8.0, -1, 512, 0, 0, 0, 0)
		TaskPlayAnim(0, dict, anim1, 8.0, -8.0, -1, 513, 0, 0, 0, 0)
		CloseSequenceTask(sequence)
		ClearPedTasks(PlayerPedId())
		TaskPerformSequence(PlayerPedId(), sequence)
		ClearSequenceTask(sequence)
	end

    local function TaskRaiseBoard()
        --TriggerEvent('esx_status:setDisplay', 0.0)
        local empty, sequence = OpenSequenceTask(0)
        local dict, anim = lineup_male, "low_to_high"
        local anim1 = "Loop_raised"
        ESX.Streaming.RequestAnimDict(dict)
		TaskPlayAnim(0, dict, anim, 8.0, -8.0, -1, 512, 0, 0, 0, 0)
		TaskPlayAnim(0, dict, anim1, 8.0, -8.0, -1, 513, 0, 0, 0, 0)
		CloseSequenceTask(sequence)
		ClearPedTasks(PlayerPedId())
		TaskPerformSequence(PlayerPedId(), sequence)
		ClearSequenceTask(sequence)
	end

    local function TaskWalkInToRoom()
        --TriggerEvent('esx_status:setDisplay', 0.0)
		local empty, sequence = OpenSequenceTask(0)
		local ped = PlayerPedId()
        local rot = vector3(0.0, 0.0, 0.0)
        local dict, anim = lineup_male, "Intro"
        local anim1 = "Loop"
        ESX.Streaming.RequestAnimDict(dict)
		TaskPlayAnimAdvanced(0, dict, anim, board_pos, rot, 8.0, -8.0, -1, 4608, 0, 2, 0)
		TaskPlayAnim(0, dict, anim1, 8.0, -8.0, -1, 513, 0, 0, 0, 0)
		CloseSequenceTask(sequence)
		ClearPedTasks(ped)
		TaskPerformSequence(ped, sequence)
		ClearSequenceTask(sequence)
	end

    local function ConfigCameraUI(bool)
        --TriggerEvent('esx_status:setDisplay', 0.0)
		CallScaleformMethod(camera_scaleform, 'OPEN_SHUTTER', 250)
		if bool then
			CallScaleformMethod(camera_scaleform, 'SHOW_PHOTO_FRAME', false)
			CallScaleformMethod(camera_scaleform, 'SHOW_PHOTO_BORDER', true, -0.7, 0.5, 0.5, 162, 120)
		else
			CallScaleformMethod(camera_scaleform, 'SHOW_REMAINING_PHOTOS', true)
			CallScaleformMethod(camera_scaleform, 'SET_REMAINING_PHOTOS', 0, 1)
			CallScaleformMethod(camera_scaleform, 'SHOW_PHOTO_FRAME', true)
			CallScaleformMethod(camera_scaleform, 'SHOW_PHOTO_BORDER', false)
		end
	end

    local function TaskTakePicture()
        --TriggerEvent('esx_status:setDisplay', 0.0)
		local ped = PlayerPedId()

        savephotowashphone()
		CallScaleformMethod(camera_scaleform, 'CLOSE_SHUTTER', 250)
		if RequestScriptAudioBank("Mugshot_Character_Creator", false, -1) then
			PlaySound(-1, "Take_Picture", "MUGSHOT_CHARACTER_CREATION_SOUNDS", 0, 0, 1)
		end

		TakePhoto()
		if WasPhotoTaken() --[[and SavePhoto(-1)]] then

		end
		ConfigCameraUI(true)
		ClearPhoto()
	end
	local function ExitRoom ()
        local empty, sequence = OpenSequenceTask(0)
        local dict, anim = lineup_male, "outro"
        local anim1 = "outro_loop"
        ESX.Streaming.RequestAnimDict(dict)
		TaskPlayAnim(0, dict, anim, 8.0, -8.0, -1, 512, 0, 0, 0, 0)
		TaskPlayAnim(0, dict, anim1, 8.0, -8.0, -1, 513, 0, 0, 0, 0)
		CloseSequenceTask(sequence)
		ClearPedTasks(PlayerPedId())
		TaskPerformSequence(PlayerPedId(), sequence)
		ClearSequenceTask(sequence)
		TaskLookAtCoord(PlayerPedId(), GetCamCoord(campis), -1, 10240, 2)
		Citizen.Wait(9000)
		Cleanup()
		RenderScriptCams(false, false, 0, false, false)
		TriggerEvent('c_character:SpawnCharacter')
	end

	local function func_1636 (campis, f1, f2, f3, f4)
		N_0xf55e4046f6f831dc(campis, f1)
		N_0xe111a7c0d200cbc5(campis, f2)
		SetCamDofFnumberOfLens(campis, f3)
		SetCamDofMaxNearInFocusDistanceBlendLevel(campis, f4)
	end

	-- Camera
	Citizen.CreateThread(function ()
		-- SCRIPT::SHUTDOWN_LOADING_SCREEN();
		LoadInterior(interior)
		DoScreenFadeOut(0)

		-- Booth cam
		campis = CreateCam("DEFAULT_SCRIPTED_CAMERA", false)
		SetCamCoord(campis, 416.4084, -998.3806, -99.24789)
		SetCamRot(campis, 0.878834, -0.022102, 90.0173, 2)
		SetCamFov(campis, 36.97171)
		ShakeCam(campis, "HAND_SHAKE", 0.1)
		func_1636(campis, 7.2, 1.0, 0.5, 1.0)

		-- Show booth cam eventually
		Wait(5000)
		ConfigCameraUI(false)
		SetCamActive(campis, true)

		-- Zoomed cam
		campis2 = CreateCam("DEFAULT_SCRIPTED_CAMERA", false)
		SetCamCoord(campis2, 412.0216, -997.9448, -98.8) -- In room
		SetCamRot(campis2, 0.865862, -0.01934, 91.04581, 2)
		SetCamFov(campis2, 35.2015)

		while DoesCamExist(campis) do
			if not IsCamInterpolating(campis) and not IsCamInterpolating(campis2) then
				RenderScriptCams(true, false, 3000, 1, 0, 0)
			end
			Wait(0)
		end
	end)

	-- Fade in
	Citizen.CreateThread(function ()
		Wait(500)
		if IsScreenFadedOut() or IsScreenFadingOut() then
			DoScreenFadeIn(500)
		end
	end)

	Citizen.CreateThread(function ()
		local ped = PlayerPedId()
        --TriggerEvent('esx_status:setDisplay', 0.0)
		SetEntityCoords(interior_pos)
		FreezeEntityPosition(ped, true)
		RequestModel(board_model)
		RequestModel(overlay_model)
		RequestAnimDict(lineup_male);
		RequestScriptAudioBank("DLC_GTAO/MUGSHOT_ROOM", false, -1)
		RequestScriptAudioBank("Mugshot_Character_Creator", false, -1)

		while not IsInteriorReady(interior) do Wait(1) end
		while not HasModelLoaded(board_model) or not HasModelLoaded(overlay_model) do Wait(1) end
		while not HasAnimDictLoaded(lineup_male) do Wait(1) end

		board = CreateObject(board_model, board_pos, false, true, false)
		overlay = CreateObject(overlay_model, board_pos, false, true, false)
		AttachEntityToEntity(overlay, board, -1, 4103, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, false, false, false, false, 2, true)
		SetModelAsNoLongerNeeded(board_model)
		SetModelAsNoLongerNeeded(overlay_model)

		SetEntityCoords(ped, board_pos)
		ClearPedWetness(ped)
		ClearPedBloodDamage(ped)
		ClearPlayerWantedLevel(PlayerId())
		SetCurrentPedWeapon(ped, GetHashKey("weapon_unarmed"), 1)
		FreezeEntityPosition(ped, false)
		AttachEntityToEntity(board, ped, GetPedBoneIndex(ped, 28422), 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0, 0, 0, 0, 2, 1)

		-- FIXME
		ClearPedTasksImmediately(ped)
		TaskWalkInToRoom()
		Wait(7000)
		if RequestScriptAudioBank("DLC_GTAO/MUGSHOT_ROOM", false, -1) then
			PlaySoundFrontend(-1, "Lights_On", "GTAO_MUGSHOT_ROOM_SOUNDS", true)
		end

		Wait(500)
		TaskHoldBoard()

		PlaySound(-1, "Zoom_In", "MUGSHOT_CHARACTER_CREATION_SOUNDS", 0, 0, 1)

		if DoesCamExist(campis2) then
			StopCamShaking(campis2)
			SetCamActiveWithInterp(campis2, campis, 300, 1, 1)
		end

		Wait(5000)
		TaskTakePicture()
		Wait(1000)
		ConfigCameraUI(false)
		SetCamActiveWithInterp(campis, campis2, 300, 1, 1)
		PlaySound(-1, "Zoom_Out", "MUGSHOT_CHARACTER_CREATION_SOUNDS", 0, 0, 1)
		ExitRoom()
	end)

	Citizen.CreateThread(function ()
		board_scaleform = LoadScaleform("mugshot_board_01")
		camera_scaleform = LoadScaleform("digital_camera")
		handle = CreateNamedRenderTargetForModel("ID_Text", overlay_model)
        --TriggerEvent('esx_status:setDisplay', 0.0)
		CallScaleformMethod(board_scaleform, 'SET_BOARD', name, money, 'LOS SANTOS POLICE DEPT', job)
        ConfigCameraUI(fasle)

		while handle do
			HideHudAndRadarThisFrame()
			SetTextRenderId(handle)
			Set_2dLayer(4)
			Citizen.InvokeNative(0xC6372ECD45D73BCD, 1)
			DrawScaleformMovie(board_scaleform, 0.405, 0.37, 0.81, 0.74, 255, 255, 255, 255, 0);
			Citizen.InvokeNative(0xC6372ECD45D73BCD, 0)
			SetTextRenderId(GetDefaultScriptRendertargetRenderId())

			Citizen.InvokeNative(0xC6372ECD45D73BCD, 1)
			DrawScaleformMovieFullscreen(camera_scaleform, 255, 255, 255, 255, 0);
			Citizen.InvokeNative(0xC6372ECD45D73BCD, 0)
			Wait(0)
		end
	end)
end)

function AddLongString(txt)
	local maxLen = 100
	for i = 0, string.len(txt), maxLen do
		local sub = string.sub(txt, i, math.min(i + maxLen, string.len(txt)))
		AddTextComponentString(sub)
	end
end
function drawCenterText(msg, time)
	ClearPrints()
	SetTextEntry_2("STRING")
	AddTextComponentString(msg)
	DrawSubtitleTimed(time and math.ceil(time) or 0, true)
end

local isCameraActive = false
local asacarte = false
local h9dyA_4T = {24, 27, 178, 177, 189, 190, 187, 188, 202, 239, 240, 201, 172, 173, 174, 175}

local creationPerso = {
    Base = { Header = {"commonmenu", "interaction_bgd"}, Color = {color_black}, Blocked = true , HeaderColor = {0, 255, 220}, Title = "Création de votre personnage"},
    Data = { currentMenu = "Nouveau personnage" },
    Events = {
        onRender = function()
            local nI2F0id = GetPlayerPed(-1)
            DisableAllControlActions(0)
            for mCsewfX, yY in pairs(h9dyA_4T) do
                EnableControlAction(0, yY, true)
            end
            local NzeoQJ, AwGfFV = IsDisabledControlPressed(1, 44), IsDisabledControlPressed(1, 51)
            if NzeoQJ or AwGfFV then
                local wCRY = PlayerPedId()
                SetEntityHeading(PlayerPedId(),NzeoQJ and GetEntityHeading(wCRY) - 1.0 or AwGfFV and GetEntityHeading(wCRY) + 1.0)
            end
            SetOverrideWeather("EXTRASUNNY")
            SetWeatherTypePersist("EXTRASUNNY")
            FreezePedCameraRotation(nI2F0id)
            TaskSetBlockingOfNonTemporaryEvents(nI2F0id, true)
        end,
        onOpened = function()
            TriggerEvent('skinchanger:change', 'Largeurnez', 20)
            TriggerEvent('skinchanger:change', 'Hauteurnez', 20)
            TriggerEvent('skinchanger:change', 'Longueurnez', 20)
            TriggerEvent('skinchanger:change', 'Abaissementdunez', 20)
            TriggerEvent('skinchanger:change', 'Abaissementpicdunez', 20)
            TriggerEvent('skinchanger:change', 'Torsiondunez', 20)
        end,
        onSelected = function(self, _, btn)
            if btn.name == "Traits du visage" then 
                OpenMenu("Traits du visage")
            elseif btn.name == "Apparence" then
                OpenMenu("Apparence")
            elseif btn.name == "Barbe" then 
                OpenMenu("Barbe")
            elseif btn.name == "Pilosité" then 
                OpenMenu("Pilosité")
            elseif btn.name == "Recentrer son personnage" then 
                DoScreenFadeOut(1000)
                Wait(1000)
                SetEntityCoords(PlayerPedId(), 402.84, -996.72, -99.0-0.98, 0.0, 0.0, 0.0, true)
                TriggerEvent('skinchanger:change', 'tshirt_1', 15)
                TriggerEvent('skinchanger:change', 'torso_1', 15)
                TriggerEvent('skinchanger:change', 'shoes_1', 45)
                DoScreenFadeIn(1000)
            elseif btn.name == "Maquillage" then 
                OpenMenu("Maquillage")
            elseif btn.name == "Bras" then 
                OpenMenu("Bras")
            elseif btn.name == "Prénom" then 
                ResultPrenom = btn.askValue
            elseif btn.name == "Nom" then 
                ResultNom = btn.askValue
             elseif btn.name == "Date de naissance" then 
                ResultDateDeNaissance = btn.askValue
            elseif btn.name == "Lieu de naissance" then 
                ResultLieuNaissance = btn.askValue
            elseif btn.name == "Taille" then 
                ResultTaille = btn.askValue
            elseif btn.name == "Sexe" then 
                ResultSexe = btn.askValue
            elseif btn.name == "~g~Continuer & Sauvegarder" then
                TriggerEvent('skinchanger:change', 'tshirt_1', 15)
                TriggerEvent('skinchanger:change', 'torso_1', 15)
                TriggerEvent('skinchanger:change', 'shoes_1', 45)
                if ResultSexe == nil then return ShowAboveRadarMessage("~r~Vous n'avez pas bien renseigné votre sexe.") end
                if ResultDateDeNaissance == nil then return ShowAboveRadarMessage("~r~Vous n'avez pas bien renseigné votre date de naissance.") end
                if ResultTaille == nil then return ShowAboveRadarMessage("~r~Vous n'avez pas bien renseigné votre taille.") end
                if ResultPrenom == nil then return ShowAboveRadarMessage("~r~Vous n'avez pas bien renseigné votre prénom.") end
                if ResultNom == nil then return ShowAboveRadarMessage("~r~Vous n'avez pas bien renseigné votre nom.") end
               -- CreateRota(false)
                TriggerServerEvent("c_character:givetiemstart") 
                TriggerServerEvent('c_character:saveidentite', ResultSexe, ResultPrenom, ResultNom, ResultDateDeNaissance, ResultTaille)
                print("".. ResultSexe, ResultPrenom, ResultNom, ResultDateDeNaissance, ResultTaille .. "")
                startAnims("mp_character_creation@customise@male_a", "drop_outro")
                TriggerEvent('skinchanger:getSkin', function(skin)
                    if skin.sex == 1 then 
                        TriggerEvent('skinchanger:change', 'glasses_1', 5)
                        TriggerEvent('skinchanger:change', 'glasses_2', 0)
                    else
                        TriggerEvent('skinchanger:change', 'glasses_1', 0)
                    end
                    LastSkin = skin
                end)
                TriggerEvent('skinchanger:getSkin', function(skin)
                    TriggerServerEvent('esx_skin:save', skin)
                end)
                PrepareMusicEvent("FM_SUDDEN_DEATH_STOP_MUSIC")
                TriggerMusicEvent("FM_SUDDEN_DEATH_STOP_MUSIC")
                incamera = true
                createcam(false)
                self:CloseMenu(true)
                createcam(false, 414.64, -998.16, -98.68, 0.0, 0.0, 88.455696105957, 60.0)
                DeleteObject(board)
                DeleteObject(overlay)
                DoScreenFadeOut(3000)
                Wait(3000)
                DoScreenFadeIn(3000)
                TriggerServerEvent("clp_char:createsign") 
                TriggerServerEvent("SetBucket:leave")
            end
        end,
        onSlide = function(menuData, btn, currentButton, currentSlt, slide, PMenu)
            local currentMenu, currentBtn, slide, btn, ped = menuData.currentMenu, menuData.currentBtn, btn.slidenum, btn.name, GetPlayerPed(-1)
            if btn == "Skin" and slide ~= -1 then
                sex = slide - 1
                createcam(true, 403.0, -998.24, -98.4, -21.0, 0.0, 1.0, 70.0)
                TriggerEvent('skinchanger:change', 'Largeurnez', 20)
                TriggerEvent('skinchanger:change', 'Hauteurnez', 20)
                TriggerEvent('skinchanger:change', 'Longueurnez', 20)
                TriggerEvent('skinchanger:change', 'Abaissementdunez', 20)
                TriggerEvent('skinchanger:change', 'Abaissementpicdunez', 20)
                TriggerEvent('skinchanger:change', 'Torsiondunez', 20)
                TriggerEvent('skinchanger:change', 'sex', sex)
            elseif btn == "Visage" and slide ~= -1 then
                createcam(true, 402.92, -998.12, -98.3, 0.0, 0.0, 1.0, 20.0)
                face = slide - 1
                TriggerEvent('skinchanger:change', 'face', face)
            elseif btn == "Peau" and slide ~= -1 then
                createcam(true, 403.0, -998.24, -98.4, -21.0, 0.0, 1.0, 70.0)
                skin = slide - 1
                TriggerEvent('skinchanger:change', 'skin', skin)
            elseif btn == "Type de bras" and slide ~= -1 then
                createcam(true, 403.0, -998.24, -98.4, -21.0, 0.0, 1.0, 70.0)
                local arms = slide - 1
                TriggerEvent('skinchanger:change', 'arms', arms)
            elseif btn == "Couleur des bras" and slide ~= -1 then
                createcam(true, 403.0, -998.24, -98.4, -21.0, 0.0, 1.0, 70.0)
                local arms2 = slide - 1
                TriggerEvent('skinchanger:change', 'arms_2', arms2)
            elseif btn == "Type des sourcils" and slide ~= -1 then
                createcam(true, 402.92, -998.12, -98.3, 0.0, 0.0, 1.0, 20.0)
                eyebrow = slide - 1
                TriggerEvent('skinchanger:change', 'eyebrows_1', eyebrow)
            elseif btn == "Taille des sourcils" and slide ~= -1 then
                createcam(true, 402.92, -998.12, -98.3, 0.0, 0.0, 1.0, 20.0)
                eyebrow = slide - 1
                TriggerEvent('skinchanger:change', 'eyebrows_2', eyebrow)
            elseif btn == "Type de la barbe" and slide ~= -1 then
                createcam(true, 402.92, -998.12, -98.3, 0.0, 0.0, 1.0, 20.0)
                beard = slide - 1
                TriggerEvent('skinchanger:change', 'beard_1', beard)
            elseif btn == "Couleur de la barbe" and slide ~= -1 then
                createcam(true, 402.92, -998.12, -98.3, 0.0, 0.0, 1.0, 20.0)
                beard3 = slide - 1
                TriggerEvent('skinchanger:change', 'beard_3', beard3)
            elseif btn == "Taille de la barbe" and slide ~= -1 then
                createcam(true, 402.92, -998.12, -98.3, 0.0, 0.0, 1.0, 20.0)
                beard2 = slide - 1
                TriggerEvent('skinchanger:change', 'beard_2', beard2)
            elseif btn == "Type de cheveux" and slide ~= -1 then
                createcam(true, 402.92, -998.12, -98.3, 0.0, 0.0, 1.0, 20.0)
                hair = slide - 1
                TriggerEvent('skinchanger:change', 'hair_1', hair)
            elseif btn == "Couleur des cheveux" and slide ~= -1 then
                createcam(true, 402.92, -998.12, -98.3, 0.0, 0.0, 1.0, 20.0)
                hair2 = slide - 1
                TriggerEvent('skinchanger:change', 'hair_color_1', hair2)
            elseif btn == "Poils du torse" and slide ~= -1 then
                createcam(true, 402.92, -998.12, -98.7, 0.0, 0.0, 1.0, 42.0)
                local chest1 = slide - 1
                TriggerEvent('skinchanger:change', 'chest_1', chest1)
            elseif btn == "Taille des poils du torse" and slide ~= -1 then
                createcam(true, 402.92, -998.12, -98.7, 0.0, 0.0, 1.0, 42.0)
                local chest2 = slide - 1
                TriggerEvent('skinchanger:change', 'chest_2', chest2)
            elseif btn == "Couleur des poils du torse" and slide ~= -1 then
                createcam(true, 402.92, -998.12, -98.7, 0.0, 0.0, 1.0, 42.0)
                local chest3 = slide - 1
                TriggerEvent('skinchanger:change', 'chest_3', chest3)
            elseif btn == "Couleur des yeux" and slide ~= -1 then
                createcam(true, 402.92, -998.12, -98.3, 0.0, 0.0, 1.0, 10.0)
                eyecolor = slide - 1
                TriggerEvent('skinchanger:change', 'eye_color', eyecolor)
            elseif btn == "Imperfections du corp" and slide ~= -1 then
                createcam(true, 402.92, -998.12, -98.7, 0.0, 0.0, 1.0, 42.0)
                local bodyb1 = slide - 1
                TriggerEvent('skinchanger:change', 'bodyb_1', bodyb1)
            elseif btn == "Opacité imperfections du corp" and slide ~= -1 then
                createcam(true, 402.92, -998.12, -98.7, 0.0, 0.0, 1.0, 42.0)
                local bodyb2 = slide - 1
                TriggerEvent('skinchanger:change', 'bodyb_2', bodyb2)
            elseif btn == "Type de maquillage" and slide ~= -1 then
                createcam(true, 402.92, -998.12, -98.3, 0.0, 0.0, 1.0, 20.0)
                local makeup1 = slide - 1
                TriggerEvent('skinchanger:change', 'makeup_1', makeup1)
            elseif btn == "Opacité du maquillage" and slide ~= -1 then
                createcam(true, 402.92, -998.12, -98.3, 0.0, 0.0, 1.0, 20.0)
                local makeup2 = slide - 1
                TriggerEvent('skinchanger:change', 'makeup_2', makeup2)
            elseif btn == "Couleur du maquillage" and slide ~= -1 then
                createcam(true, 402.92, -998.12, -98.3, 0.0, 0.0, 1.0, 20.0)
                local makeup3 = slide - 1
                TriggerEvent('skinchanger:change', 'makeup_3', makeup3)
            elseif btn == "Type de rouge à lèvres" and slide ~= -1 then
                createcam(true, 402.92, -998.12, -98.3, 0.0, 0.0, 1.0, 20.0)
                local lipstick1 = slide - 1
                TriggerEvent('skinchanger:change', 'lipstick_1', lipstick1)
            elseif btn == "Opacité du rouge à lèvres" and slide ~= -1 then
                createcam(true, 402.92, -998.12, -98.3, 0.0, 0.0, 1.0, 20.0)
                local lipstick2 = slide - 1
                TriggerEvent('skinchanger:change', 'lipstick_2', lipstick2)
            elseif btn == "Couleur du rouge à lèvres" and slide ~= -1 then
                createcam(true, 402.92, -998.12, -98.3, 0.0, 0.0, 1.0, 20.0)
                local lipstick3 = slide - 1
                TriggerEvent('skinchanger:change', 'lipstick_3', lipstick3)
            elseif btn == "Rides" and slide ~= -1 then
                createcam(true, 402.92, -998.12, -98.3, 0.0, 0.0, 1.0, 20.0)
                local wrinkle = slide - 1
                TriggerEvent('skinchanger:change', 'age_1', wrinkle)
            elseif btn == "Opacité des rides" and slide ~= -1 then
                createcam(true, 402.92, -998.12, -98.3, 0.0, 0.0, 1.0, 20.0)
                local wrinkle2 = slide - 1
                TriggerEvent('skinchanger:change', 'age_2', wrinkle2)
            elseif btn == "Dommages UV" and slide ~= -1 then
                createcam(true, 402.92, -998.12, -98.3, 0.0, 0.0, 1.0, 20.0)
                local sun1 = slide - 1
                TriggerEvent('skinchanger:change', 'sun_1', sun1)
            elseif btn == "Opacité des dommages UV" and slide ~= -1 then
                createcam(true, 402.92, -998.12, -98.3, 0.0, 0.0, 1.0, 20.0)
                local sun2 = slide - 1
                TriggerEvent('skinchanger:change', 'sun_2', sun2)
            elseif btn == "Teint" and slide ~= -1 then
                createcam(true, 402.92, -998.12, -98.3, 0.0, 0.0, 1.0, 20.0)
                local complexion1 = slide - 1
                TriggerEvent('skinchanger:change', 'complexion_1', complexion1)
            elseif btn == "Opacité du teint" and slide ~= -1 then
                createcam(true, 402.92, -998.12, -98.3, 0.0, 0.0, 1.0, 20.0)
                local complexion2 = slide - 1
                TriggerEvent('skinchanger:change', 'complexion_2', complexion2)
            elseif btn == "Taches de rousseur" and slide ~= -1 then
                createcam(true, 402.92, -998.12, -98.3, 0.0, 0.0, 1.0, 20.0)
                local freckle = slide - 1
                TriggerEvent('skinchanger:change', 'moles_1', freckle)
            elseif btn == "Opacité des taches de rousseurs" and slide ~= -1 then
                createcam(true, 402.92, -998.12, -98.3, 0.0, 0.0, 1.0, 20.0)
                local freckle2 = slide - 1
                TriggerEvent('skinchanger:change', 'moles_2', freckle2)
            elseif btn == "Rougeurs" and slide ~= -1 then
                createcam(true, 402.92, -998.12, -98.3, 0.0, 0.0, 1.0, 20.0)
                local blush1 = slide - 1
                TriggerEvent('skinchanger:change', 'blush_1', blush1)
            elseif btn == "Opacité des rougeurs" and slide ~= -1 then
                createcam(true, 402.92, -998.12, -98.3, 0.0, 0.0, 1.0, 20.0)
                local blush2 = slide - 1
                TriggerEvent('skinchanger:change', 'blush_2', blush2)
            elseif btn == "Couleur des rougeurs" and slide ~= -1 then
                createcam(true, 402.92, -998.12, -98.3, 0.0, 0.0, 1.0, 20.0)
                local blush3 = slide - 1
                TriggerEvent('skinchanger:change', 'blush_3', blush3)
            elseif btn == "Lunettes (debug)" and slide ~= -1 then
                createcam(true, 402.92, -998.12, -98.3, 0.0, 0.0, 1.0, 20.0)
                local eyesdebug = slide - 1
                TriggerEvent('skinchanger:change', 'glasses_1', eyesdebug)
            elseif btn == "Visage (ped)" and slide ~= -1 then
                createcam(true, 402.92, -998.12, -98.3, 0.0, 0.0, 1.0, 20.0)
                local facepeds = slide - 1
                TriggerEvent('skinchanger:change', 'facepeds', facepeds)
            elseif btn == "Variations du visage" and slide ~= -1 then
                createcam(true, 402.92, -998.12, -98.3, 0.0, 0.0, 1.0, 20.0)
                local facepeds2 = slide - 1
                TriggerEvent('skinchanger:change', 'facepeds2', facepeds2)
            elseif btn == "Cheveux (ped)" and slide ~= -1 then
                createcam(true, 402.92, -998.12, -98.3, 0.0, 0.0, 1.0, 20.0)
                local cheveuxped = slide - 1
                TriggerEvent('skinchanger:change', 'hair_1', cheveuxped)
            elseif btn == "Haut (ped)" and slide ~= -1 then
                createcam(true, 402.92, -998.12, -98.7, 0.0, 0.0, 1.0, 42.0)
                local armespeds = slide - 1
                TriggerEvent('skinchanger:change', 'arms', armespeds)
            elseif btn == "Couleur Haut (ped)" and slide ~= -1 then
                createcam(true, 402.92, -998.12, -98.7, 0.0, 0.0, 1.0, 42.0)
                local armespeds2 = slide - 1
                TriggerEvent('skinchanger:change', 'arms_2', armespeds2)
            elseif btn == "Pantalon (ped)" and slide ~= -1 then
                createcam(true, 402.92, -998.12, -99.32, -5.0, 0.0, 1.0, 50.0)
                local pantalonpeds = slide - 1
                TriggerEvent('skinchanger:change', 'pants_1', pantalonpeds)
            elseif btn == "Couleur Pantalon (ped)" and slide ~= -1 then
                createcam(true, 402.92, -998.12, -99.32, -5.0, 0.0, 1.0, 50.0)
                local pantalonpeds2 = slide - 1
                TriggerEvent('skinchanger:change', 'pants_2', pantalonpeds2)
            elseif btn == "Lunettes (ped)" and slide ~= -1 then
                createcam(true, 402.92, -998.12, -98.3, 0.0, 0.0, 1.0, 20.0)
                local lunettespeds = slide - 1
                TriggerEvent('skinchanger:change', 'glasses_1', lunettespeds)
            elseif btn == "Couleur Lunettes (ped)" and slide ~= -1 then
                createcam(true, 402.92, -998.12, -98.3, 0.0, 0.0, 1.0, 20.0)
                local couleurlunettespeds = slide - 1
                TriggerEvent('skinchanger:change', 'glasses_2', couleurlunettespeds)
            elseif btn == "Chapeau (ped)" and slide ~= -1 then
                createcam(true, 402.92, -998.12, -98.3, 0.0, 0.0, 1.0, 20.0)
                local chapeaupeds = slide - 1
                TriggerEvent('skinchanger:change', 'helmet_1', chapeaupeds)
            elseif btn == "Couleur Chapeau (ped)" and slide ~= -1 then
                createcam(true, 402.92, -998.12, -98.3, 0.0, 0.0, 1.0, 20.0)
                local couleurchapeaupeds = slide - 1
                TriggerEvent('skinchanger:change', 'helmet_2', couleurchapeaupeds)
            elseif btn == "Largeur nez" and slide ~= -1 then
                createcam(true, 402.92, -998.12, -98.3, 0.0, 0.0, 1.0, 20.0)
                local Largeurnez = slide - 1
                TriggerEvent('skinchanger:change', 'Largeurnez', Largeurnez)
            elseif btn == "Hauteur nez" and slide ~= -1 then
                createcam(true, 402.92, -998.12, -98.3, 0.0, 0.0, 1.0, 20.0)
                local Hauteurnez = slide - 1
                TriggerEvent('skinchanger:change', 'Hauteurnez', Hauteurnez)
            elseif btn == "Longueur nez" and slide ~= -1 then
                createcam(true, 402.92, -998.12, -98.3, 0.0, 0.0, 1.0, 20.0)
                local Longueurnez = slide - 1
                TriggerEvent('skinchanger:change', 'Longueurnez', Longueurnez)
            elseif btn == "Abaissement du nez" and slide ~= -1 then
                createcam(true, 402.92, -998.12, -98.3, 0.0, 0.0, 1.0, 20.0)
                local Abaissementdunez = slide - 1
                TriggerEvent('skinchanger:change', 'Abaissementdunez', Abaissementdunez)
            elseif btn == "Abaissement pic du nez" and slide ~= -1 then
                createcam(true, 402.92, -998.12, -98.3, 0.0, 0.0, 1.0, 20.0)
                local Abaissementpicdunez = slide - 1
                TriggerEvent('skinchanger:change', 'Abaissementpicdunez', Abaissementpicdunez)
            elseif btn == "Torsion du nez" and slide ~= -1 then
                createcam(true, 402.92, -998.12, -98.3, 0.0, 0.0, 1.0, 20.0)
                local Torsiondunez = slide - 1
                TriggerEvent('skinchanger:change', 'Torsiondunez', Torsiondunez)
            elseif btn == "Hauteur sourcils" and slide ~= -1 then
                createcam(true, 402.92, -998.12, -98.3, 0.0, 0.0, 1.0, 20.0)
                local Hauteursourcils = slide - 1
                TriggerEvent('skinchanger:change', 'Hauteursourcils', Hauteursourcils)
            elseif btn == "Profondeur sourcils" and slide ~= -1 then
                createcam(true, 402.92, -998.12, -98.3, 0.0, 0.0, 1.0, 20.0)
                local Profondeursourcils = slide - 1
                TriggerEvent('skinchanger:change', 'Profondeursourcils', Profondeursourcils)
            elseif btn == "Hauteur des pommettes" and slide ~= -1 then
                createcam(true, 402.92, -998.12, -98.3, 0.0, 0.0, 1.0, 20.0)
                local Hauteurdespommettes = slide - 1
                TriggerEvent('skinchanger:change', 'Hauteurdespommettes', Hauteurdespommettes)
            elseif btn == "Largeur des pommettes" and slide ~= -1 then
                createcam(true, 402.92, -998.12, -98.3, 0.0, 0.0, 1.0, 20.0)
                local Largeurdespommettes = slide - 1
                TriggerEvent('skinchanger:change', 'Largeurdespommettes', Largeurdespommettes)
            elseif btn == "Largeur des joues" and slide ~= -1 then
                createcam(true, 402.92, -998.12, -98.3, 0.0, 0.0, 1.0, 20.0)
                local Largeurdesjoues = slide - 1
                TriggerEvent('skinchanger:change', 'Largeurdesjoues', Largeurdesjoues)
            elseif btn == "Ouverture des yeux" and slide ~= -1 then
                createcam(true, 402.92, -998.12, -98.3, 0.0, 0.0, 1.0, 20.0)
                local Ouverturedesyeux = slide - 1
                TriggerEvent('skinchanger:change', 'Ouverturedesyeux', Ouverturedesyeux)
            elseif btn == "Epaisseur des levres" and slide ~= -1 then
                createcam(true, 402.92, -998.12, -98.3, 0.0, 0.0, 1.0, 20.0)
                local Epaisseurdeslevres = slide - 1
                TriggerEvent('skinchanger:change', 'Epaisseurdeslevres', Epaisseurdeslevres)
            elseif btn == "Largeur de la machoire" and slide ~= -1 then
                createcam(true, 402.92, -998.12, -98.3, 0.0, 0.0, 1.0, 20.0)
                local Largeurdelamachoire = slide - 1
                TriggerEvent('skinchanger:change', 'Largeurdelamachoire', Largeurdelamachoire)
            elseif btn == "Longueur du dos de la machoire" and slide ~= -1 then
                createcam(true, 402.92, -998.12, -98.3, 0.0, 0.0, 1.0, 20.0)
                local Longueurdudosdelamachoire = slide - 1
                TriggerEvent('skinchanger:change', 'Longueurdudosdelamachoire', Longueurdudosdelamachoire)
            elseif btn == "Abaissement du menton" and slide ~= -1 then
                createcam(true, 402.92, -998.12, -98.3, 0.0, 0.0, 1.0, 20.0)
                local Abaissementdumenton = slide - 1
                TriggerEvent('skinchanger:change', 'Abaissementdumenton', Abaissementdumenton)
            elseif btn == "Longueur de l'os du menton" and slide ~= -1 then
                createcam(true, 402.92, -998.12, -98.3, 0.0, 0.0, 1.0, 20.0)
                local Longueurdelosdumenton = slide - 1
                TriggerEvent('skinchanger:change', 'Longueurdelosdumenton', Longueurdelosdumenton)
            elseif btn == "Largeur du menton" and slide ~= -1 then
                createcam(true, 402.92, -998.12, -98.3, 0.0, 0.0, 1.0, 20.0)
                local Largeurdumenton = slide - 1
                TriggerEvent('skinchanger:change', 'Largeurdumenton', Largeurdumenton)
            elseif btn == "Trou du menton" and slide ~= -1 then
                createcam(true, 402.92, -998.12, -98.3, 0.0, 0.0, 1.0, 20.0)
                local Troudumenton = slide - 1
                TriggerEvent('skinchanger:change', 'Troudumenton', Troudumenton)
            elseif btn == "Epaisseur du cou" and slide ~= -1 then
                createcam(true, 402.92, -998.12, -98.3, 0.0, 0.0, 1.0, 20.0)
                local Epaisseurducou = slide - 1
                TriggerEvent('skinchanger:change', 'Epaisseurducou', Epaisseurducou)
            end
        end,
        onAdvSlide = function(M6ilzGJ, iW6CD, wZdg, BaX, SJsW11k)
            local Ki1HJT, wjim8xCV = iW6CD.currentMenu, GetPlayerPed(-1)
            if Ki1HJT == "Traits du visage" then
                TriggerEvent('skinchanger:change', wZdg.pso, wZdg.advSlider[3])
            end
        end,
    },

	Menu = {
        ["Nouveau personnage"] = {
            useFilter = true,
			b = {
                {name = "Skin", slidemax = 529--[[564]], Description = "Attention, les skin 'ped' ne peuvent être que très légèrement modifiés."},
                {name = "Apparence", ask = ">", askX = true, Description = "Choisissez votre apparence."},
                {name = "Maquillage", ask = ">", askX = true, Description = "Choisissez votre maquillage."},
                {name = "Traits du visage", ask = ">", askX = true, Description = "Choisissez vos traits du visage."},
                {name = "Apparence peds", ask = ">", askX = true, Description = "Choisissez votre couleur de peau."},
                {name = "Identité", ask = ">", askX = true, Description = "Choisissez votre identité."},
                {name = "Recentrer son personnage", ask = ">", askX = true, Description = "Permet de recentrer votre personnage"}
			}
        },
        ["identité"] = {
            useFilter = true, 
			b = {
                {name = "Prénom", ask = "Aslan", Description = "Choisissez votre prénom."},
                {name = "Nom", ask = "Doblow", Description = "Choisissez votre nom."},
                {name = "Date de naissance", ask = "JJ/MM/AAAA", Description = "Choisissez votre date de naissance."},
                {name = "Lieu de naissance", ask = "Los Santos", Description = "Où votre personnage est-il né ?."},
                {name = "Taille", ask = "170", Description = "Choisissez votre taille."},
                {name = "Sexe", ask = "m/f", Description = "Choisissez votre sexe."},
                {name = "~g~Continuer & Sauvegarder", Description = "~r~Attention ! ~s~Si vous acceptez cette étape, vous ne pourrez plus revenir en arrière."},
			}
        },
        ["Apparence"] = {   
            useFilter = true,     
            refresh=true,
			b = {
                {name = "Visage", slidemax = 45, Description = "Choisissez votre visage."},
                {name = "Peau", slidemax = 45, Description = "Choisissez votre couleur de peau."},
                {name = "Type de bras", slidemax = 188, Description = "Choisissez vos bras."},
                {name = "Couleur des bras", slidemax = 10, Description = "Choisissez vos bras."},
                {name = "Pilosité", ask = ">", askX = true, Description = "Choisissez votre pilosité."},
                {name = "Couleur des yeux", slidemax = 31, Description = "Choisissez votre couleur des yeux."},
                {name = "Imperfections du corp", slidemax = 11, Description = "Choisissez vos imperfections du corp."},
                {name = "Opacité imperfections du corp", slidemax = 10, Description = "Choisissez l'opacité de vos imperfections."},
                {name = "Lunettes (debug)", slidemax = 10, Description = "Debug vos lunettes."},
            }
        },
        ["apparence peds"] = { 
            useFilter = true,          
			b = {
                {name = "Visage (ped)", slidemax = 10, Description = "Choisissez votre type de visage."},
                {name = "Variations du visage", slidemax = 5, Description = "Choisissez la variations de visage."},
                {name = "Cheveux (ped)", slidemax = 5, Description = "Choisissez vos cheveux."},
                {name = "Haut (ped)", slidemax = 5, Description = "Choisissez le haut."},
                {name = "Couleur Haut (ped)", slidemax = 5, Description = "Choisissez la couleur du haut."},
                {name = "Pantalon (ped)", slidemax = 5, Description = "Choisissez votre pantalon."},
                {name = "Couleur Pantalon (ped)", slidemax = 5, Description = "Choisissez la couleur du pantalon."},
                {name = "Lunettes (ped)", slidemax = 5, Description = "Choisissez vos lunettes."},
                {name = "Couleur Lunettes (ped)", slidemax = 5, Description = "Choisissez la couleur de vos lunettes."},
                {name = "Chapeau (ped)", slidemax = 5, Description = "Choisissez votre chapeau."},
                {name = "Couleur Chapeau (ped)", slidemax = 5, Description = "Choisissez la couleur de votre chapeau."},
            }
        },
        ["Maquillage"] = { 
            useFilter = true,          
			b = {
                {name = "Type de maquillage", slidemax = 71, Description = "Choisissez votre type de maquillage."},
                {name = "Opacité du maquillage", slidemax = 10, Description = "Choisissez la taille de votre maquillage."},
                {name = "Couleur du maquillage", slidemax = 63, Description = "Choisissez la couleur de votre maquillage."},
                {name = "Type de rouge à lèvres", slidemax = 9, Description = "Choisissez votre type de rouge à lèvres."},
                {name = "Opacité du rouge à lèvres", slidemax = 10, Description = "Choisissez la taille de votre rouge à lèvres."},
                {name = "Couleur du rouge à lèvres", slidemax = 63, Description = "Choisissez la couleur de votre rouge à lèvres."},
            }
        },
        ["Traits du visage"] = {     
            useFilter = true,      
            extra = true,
			b = {
                {name = "Rides", slidemax = 15, Description = "Choisissez vos rides."},
                {name = "Opacité des rides", slidemax = 10, Description = "Choisissez la taille de vos rides."},
                {name = "Dommages UV", slidemax = 10, Description = "Choisissez vos dommages UV."},
                {name = "Opacité des dommages UV", slidemax = 10, Description = "Choisissez l'opacité de vos dommages UV."},
                {name = "Teint", slidemax = 11, Description = "Choisissez votre teint."},
                {name = "Opacité du teint", slidemax = 10, Description = "Choisissez l'opacité de votre teint."},
                {name = "Taches de rousseur", slidemax = 17, Description = "Choisissez vos taches de rousseur."},
                {name = "Opacité des taches de rousseurs", slidemax = 10, Description = "Choisissez l'opacité de vos tahes de rousseur."},
                {name = "Rougeurs", slidemax = 32, Description = "Choisissez vos rougeurs."},
                {name = "Opacité des rougeurs", slidemax = 10, Description = "Choisissez l'opacité des rougeurs."},
                {name = "Couleur des rougeurs", slidemax = 63, Description = "Choisissez la couleur de vos rougeurs."},
                {name = "Largeur nez", advSlider = {0, 40, 20}, pso = "Largeurnez", Description = ""},
                {name = "Hauteur nez", advSlider = {0, 40, 20}, pso = "Hauteurnez",Description = ""},
                {name = "Longueur nez", advSlider = {0, 40, 20}, pso = "Longueurnez",Description = ""},
                {name = "Abaissement du nez", advSlider = {0, 40, 20},pso = "Abaissementdunez", Description = ""},
                {name = "Abaissement pic du nez", advSlider = {0, 40, 20}, pso = "Abaissementpicdunez",Description = ""},
                {name = "Torsion du nez", advSlider = {0, 40, 20}, pso = "Torsiondunez",Description = ""},
                {name = "Hauteur sourcils", advSlider = {0, 40, 20}, pso = "Hauteursourcils",Description = ""},
                {name = "Profondeur sourcils", advSlider = {0, 40, 20}, pso = "Profondeursourcils",Description = ""},
                {name = "Hauteur des pommettes", advSlider = {0, 40, 20}, pso = "Hauteurdespommettes",Description = ""},
                {name = "Largeur des pommettes", advSlider = {0, 40, 20}, pso = "Largeurdespommettes",Description = ""},
                {name = "Largeur des joues", advSlider = {0, 40, 20}, pso = "Largeurdesjoues",Description = ""},
                {name = "Ouverture des yeux", advSlider = {0, 40, 20}, pso = "Ouverturedesyeux",Description = ""},
                {name = "Epaisseur des levres", advSlider = {0, 40, 20}, pso = "Epaisseurdeslevres",Description = ""},
                {name = "Largeur de la machoire", advSlider = {0, 40, 20}, pso = "Largeurdelamachoire",Description = ""},
                {name = "Longueur du dos de la machoire", advSlider = {0, 40, 20}, pso = "Longueurdudosdelamachoire",Description = ""},
                {name = "Abaissement du menton", advSlider = {0, 40, 20}, pso = "Abaissementdumenton",Description = ""},
                {name = "Longueur de l'os du menton", advSlider = {0, 40, 20}, pso = "Longueurdelosdumenton",Description = ""},
                {name = "Largeur du menton", advSlider = {0, 40, 20}, pso = "Largeurdumenton",Description = ""},
                {name = "Trou du menton", advSlider = {0, 40, 20}, pso = "Troudumenton",Description = ""},
                {name = "Epaisseur du cou", advSlider = {0, 40, 20}, pso = "Epaisseurducou",Description = ""},
            }
        },
        ["Pilosité"] = {     
            useFilter = true,      
			b = {
                {name = "Type de cheveux", slidemax = 97, Description = "Choisissez votre type de coiffure."},
                {name = "Couleur des cheveux", slidemax = 63, Description = "Choisissez la couleur de votre coiffure."},
                {name = "Taille de la barbe", slidemax = 10, Description = "Choisissez la taille de votre barbe."},
                {name = "Type de la barbe", slidemax = 28, Description = "Choisissez votre type de barbe."},
                {name = "Couleur de la barbe", slidemax = 63, Description = "Choisissez la couleur de votre barbe."},
                {name = "Type des sourcils", slidemax = 33, Description = "Choisissez le type de sourcils."},
                {name = "Taille des sourcils", slidemax = 10, Description = "Choisissez la taille de vos sourcils."},
                {name = "Poils du torse", slidemax = 16, Description = "Choisissez le type de poils de torse."},
                {name = "Taille des poils du torse", slidemax = 10, Description = "Choisissez la taille de vos poils de torse."},
                {name = "Couleur des poils du torse", slidemax = 63, Description = "Choisissez la couleur de vos poils de torse."},
            }
        },
	}
}

function AnimationIntro()
    RequestAnimDict("mp_character_creation@lineup@male_a")
    Citizen.Wait(100)
    startAnims("mp_character_creation@lineup@male_a", "intro")
    Citizen.Wait(5700)
    RequestAnimDict("mp_character_creation@customise@male_a")
    Citizen.Wait(100)
    TaskPlayAnim(PlayerPedId(), "mp_character_creation@customise@male_a", "loop", 1.0, 1.0, -1, 0, 1, 0, 0, 0)
    Citizen.Wait(2250)
end

function CharCreator()
    SetPlayerModel(PlayerPedId(), "mp_m_freemode_01")
    local nI2F0id = GetPlayerPed(-1)
    local N4aMD_P = GetInteriorAtCoordsWithType(vector3(399.9, -998.7, -100.0), "v_mugshot")
    LoadInterior(N4aMD_P)
    RequestInteriorRoomByName(N4aMD_P, GetHashKey("v_mugshot"))
    RequestInteriorRoomByName(N4aMD_P, GetHashKey("V_WinningRoom"))
    DoScreenFadeOut(2000)
    Citizen.Wait(2000) 
    DestroyAllCams(true)
    cam3 = CreateCamWithParams("DEFAULT_SCRIPTED_CAMERA", 402.92, -1000.72, -99.01, 0.00, 0.00, 0.00, 50.00, false, 0)
    SetCamActive(cam3, true)
    Citizen.Wait(500)
    DoScreenFadeIn(2000)
    SetEntityCoords(PlayerPedId(), 405.59, -997.18, -99.00, 0.0, 0.0, 0.0, true)
    SetEntityHeading(PlayerPedId(), 90.00)
    Citizen.Wait(100)
    cam4 = CreateCamWithParams("DEFAULT_SCRIPTED_CAMERA", 402.99, -998.02, -99.00, 0.00, 0.00, 0.00, 70.00, false, 0)
    PointCamAtCoord(cam4, 402.99, -998.02, -99.00)
    SetCamActiveWithInterp(cam4, cam3, 5000, true, true)
    local dict, anim = "mp_character_creation@customise@male_a", "intro"
    ESX.Streaming.RequestAnimDict(dict)
    TaskPlayAnim(PlayerPedId(), dict, anim, 1.0, 1.0, 4000, 0, 1, 0, 0, 0)
    Citizen.Wait(5000)
    ClearPedTasks(PlayerPedId())
    RenderScriptCams(false, true, 500, true, true)      
    Citizen.Wait(100)
    SetPlayerModel(PlayerPedId(), "mp_m_freemode_01")
    createcam(true, 403.0, -998.24, -98.4, -21.0, 0.0, 1.0, 70.0)
    DoScreenFadeOut(1000)
    Wait(1000)
    ForceRoomForEntity(nI2F0id, N4aMD_P, GetHashKey("v_mugshot"))
    ForceRoomForEntity(nI2F0id, N4aMD_P, GetHashKey("V_WinningRoom"))
    FreezeEntityPosition(GetPlayerPed(-1), true)
    SetOverrideWeather("EXTRASUNNY")
    SetWeatherTypePersist("EXTRASUNNY")
    FreezePedCameraRotation(nI2F0id)
    TaskSetBlockingOfNonTemporaryEvents(nI2F0id, true)
    SetPedDefaultComponentVariation(nI2F0id)
    SetBlockingOfNonTemporaryEvents(GetPlayerPed(-1), true)
    SetPedKeepTask(GetPlayerPed(-1), true)
    SetEntityCoords(PlayerPedId(), 402.84, -996.72, -99.0-0.98, 0.0, 0.0, 0.0, true)
    SetEntityHeading(PlayerPedId(), 186.99)
    DoScreenFadeIn(1000)
end

TriggerEvent('instance:registerType', 'skin')
TriggerEvent('instance:registerType', 'property')

RegisterNetEvent('c_charact:create')
AddEventHandler('c_charact:create', function()
    TriggerServerEvent("SetBucket:enter")
    LoadInterior(interior1)
    local characterModel = "mp_m_freemode_01"
    TriggerEvent('esx_status:setDisplay', 0.0)
    SetPlayerInvincible(PlayerPedId(), true)
    DisplayRadar(false)
    for k, v in pairs(GetActivePlayers()) do 
        if v ~= GetPlayerIndex() then 
            print('on instance')
			NetworkConcealPlayer(v, true, true) 
		end 
	end
    while not HasModelLoaded(characterModel) do
        RequestModel(characterModel)
        Citizen.Wait(0)
    end
    SetPlayerModel(PlayerId(), characterModel)
    SetPedDefaultComponentVariation(playerPed)
    SetPedDecoration(GetPlayerPed(-1),GetHashKey("mpbeach_overlays"),GetHashKey("FM_Hair_Fuzz"))
    SetModelAsNoLongerNeeded(characterModel)
    TriggerEvent('skinchanger:change', 'tshirt_1', 15)
    TriggerEvent('skinchanger:change', 'torso_1', 15)
    TriggerEvent('skinchanger:change', 'arms', 15)
    TriggerEvent('skinchanger:change', 'pants_1', 14)
    TriggerEvent('skinchanger:change', 'shoes_1', 45)
    TriggerEvent('skinchanger:change', 'glasses_1', 0)
    TriggerEvent('skinchanger:change', 'helmet_1', -1)
    --CreateRota(true)
    for i = 0, 357 do
        DisableAllControlActions(i)
    end
    CreateCamEnter()
    CharCreator()
    PrepareMusicEvent("FM_INTRO_DRIVE_START")
    TriggerMusicEvent("FM_INTRO_DRIVE_START")
    CreateMenu(creationPerso)
    setheader("Création")
    incamera = true
    DeleteObject(board)
    DeleteObject(overlay)
end)

RegisterNetEvent('instance:onCreate')
AddEventHandler('instance:onCreate', function(instance)
	if instance.type == 'skin' then
		TriggerEvent('instance:enter', instance)
	end
end)

RegisterCommand('resetnose', function()    
    TriggerEvent('skinchanger:change', 'Largeurnez', 20)
    TriggerEvent('skinchanger:change', 'Hauteurnez', 20)
    TriggerEvent('skinchanger:change', 'Longueurnez', 20)
    TriggerEvent('skinchanger:change', 'Abaissementdunez', 20)
    TriggerEvent('skinchanger:change', 'Abaissementpicdunez', 20)
    TriggerEvent('skinchanger:change', 'Torsiondunez', 20)
    Wait(20)
    TriggerEvent('skinchanger:getSkin', function(skin)
        TriggerServerEvent('esx_skin:save', skin)
    end)
end)




RegisterCommand('crea', function()    
    TriggerEvent('c_charact:create')
end)



