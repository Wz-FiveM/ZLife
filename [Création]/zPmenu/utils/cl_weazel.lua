local holdingCam = false
local usingCam = false
local holdingMic = false
local usingMic = false
local camModel = "prop_v_cam_01"
local camanimDict = "missfinale_c2mcs_1"
local camanimName = "fin_c2_mcs_1_camman"
local micModel = "p_ing_microphonel_01"
local actionTime = 10
local mic_net = nil
local cam_net = nil


RegisterNetEvent("Cam:ToggleCam")
AddEventHandler("Cam:ToggleCam", function()
    if not holdingCam then
        RequestModel(GetHashKey(camModel))
        while not HasModelLoaded(GetHashKey(camModel)) do
            Citizen.Wait(100)
        end

        RequestAnimDict(camanimDict)
        while not HasAnimDictLoaded(camanimDict) do
            Citizen.Wait(100)
        end

        local plyCoords = GetOffsetFromEntityInWorldCoords(GetPlayerPed(PlayerId()), 0.0, 0.0, -5.0)
        local camspawned = CreateObject(GetHashKey(camModel), plyCoords.x, plyCoords.y, plyCoords.z, 1, 1, 1)
        Citizen.Wait(100)
        local netid = ObjToNet(camspawned)
        SetNetworkIdExistsOnAllMachines(netid, true)
        NetworkSetNetworkIdDynamic(netid, true)
        SetNetworkIdCanMigrate(netid, false)
        AttachEntityToEntity(camspawned, GetPlayerPed(PlayerId()), GetPedBoneIndex(GetPlayerPed(PlayerId()), 28422), 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 1, 1, 0, 1, 0, 1)
        TaskPlayAnim(GetPlayerPed(PlayerId()), 1.0, -1, -1, 50, 0, 0, 0, 0) -- 50 = 32 + 16 + 2
        TaskPlayAnim(GetPlayerPed(PlayerId()), camanimDict, camanimName, 1.0, -1, -1, 50, 0, 0, 0, 0)
        cam_net = netid
		holdingCam = true
		DrawTopNotification("Appuyez sur ~INPUT_PICKUP~ pour ~g~activer la caméra~s~.")
		startcams(true)
    else
        ClearPedSecondaryTask(GetPlayerPed(PlayerId()))
        DetachEntity(NetToObj(cam_net), 1, 1)
        DeleteEntity(NetToObj(cam_net))
        cam_net = nil
		holdingCam = false
		usingCam = false
		startcams(false)
    end
end)

local fov_max = 70.0
local fov_min = 5.0
local zoomspeed = 10.0
local speed_lr = 8.0
local speed_ud = 8.0
local sWs = false
local camera = false
local fov = (fov_max+fov_min)*0.5

function startcams(bool)
	Citizen.CreateThread(function()
		while bool do 
			Wait(0)
			local lPed = GetPlayerPed(-1)
			local vehicle = GetVehiclePedIsIn(lPed)

			if holdingCam and IsControlJustReleased(1, 38) then
				camera = true
	
				Wait(0)

				SetTimecycleModifier("default")
	
				SetTimecycleModifierStrength(0.3)
				
				local scaleform = RequestScaleformMovie("security_camera")
				local scaleform2 = RequestScaleformMovie("breaking_news")
	
	
				while not HasScaleformMovieLoaded(scaleform) do
					Citizen.Wait(10)
				end
				while not HasScaleformMovieLoaded(scaleform2) do
					Citizen.Wait(10)
				end
	
	
				local lPed = GetPlayerPed(-1)
				local vehicle = GetVehiclePedIsIn(lPed)
				local cam = CreateCam("DEFAULT_SCRIPTED_FLY_CAMERA", true)

	
				AttachCamToEntity(cam, lPed, 0.0,0.0,1.0, true)
				SetCamRot(cam, 0.0,0.0,GetEntityHeading(lPed))
				SetCamFov(cam, fov)
				RenderScriptCams(true, false, 0, 1, 0)
				PushScaleformMovieFunction(scaleform, "SET_CAM_LOGO")
				PushScaleformMovieFunction(scaleform2, "breaking_news")
				PopScaleformMovieFunctionVoid()
	
				while camera and not IsEntityDead(lPed) and (GetVehiclePedIsIn(lPed) == vehicle) and true do
					if IsControlJustPressed(0, 177) then
						PlaySoundFrontend(-1, "SELECT", "HUD_FRONTEND_DEFAULT_SOUNDSET", false)
						camera = false
					end
	
					local zoomvalue = (1.0/(fov_max-fov_min))*(fov-fov_min)
					CheckInputRotation(cam, zoomvalue)
	
					HandleZoom(cam)
					HideHUDThisFrame()
	
					DrawScaleformMovieFullscreen(scaleform, 255, 255, 255, 255)
					DrawScaleformMovie(scaleform2, 0.5, 0.63, 1.0, 1.0, 255, 255, 255, 255)
					Citizen.Wait(10)
				end
				camera = false
				ClearTimecycleModifier()
				fov = (fov_max+fov_min)*0.5
				RenderScriptCams(false, false, 0, 1, 0)
				SetScaleformMovieAsNoLongerNeeded(scaleform)
				DestroyCam(cam, false)
				SetNightvision(false)
				SetSeethrough(false)
			end
		end
	end)
end

RegisterNetEvent('camera:Activate')
AddEventHandler('camera:Activate', function()
	camera = not camera
end)

function HideHUDThisFrame()
	HideHelpTextThisFrame()
	HideHudAndRadarThisFrame()
	HideHudComponentThisFrame(1)
	HideHudComponentThisFrame(2)
	HideHudComponentThisFrame(3)
	HideHudComponentThisFrame(4)
	HideHudComponentThisFrame(6)
	HideHudComponentThisFrame(7)
	HideHudComponentThisFrame(8)
	HideHudComponentThisFrame(9)
	HideHudComponentThisFrame(13)
	HideHudComponentThisFrame(11)
	HideHudComponentThisFrame(12)
	HideHudComponentThisFrame(15)
	HideHudComponentThisFrame(18)
	HideHudComponentThisFrame(19)
end

function CheckInputRotation(cam, zoomvalue)
	local rightAxisX = GetDisabledControlNormal(0, 220)
	local rightAxisY = GetDisabledControlNormal(0, 221)
	local rotation = GetCamRot(cam, 2)
	if rightAxisX ~= 0.0 or rightAxisY ~= 0.0 then
		new_z = rotation.z + rightAxisX*-1.0*(speed_ud)*(zoomvalue+0.1)
		new_x = math.max(math.min(20.0, rotation.x + rightAxisY*-1.0*(speed_lr)*(zoomvalue+0.1)), -89.5)
		SetCamRot(cam, new_x, 0.0, new_z, 2)
	end
end

function HandleZoom(cam)
	local lPed = GetPlayerPed(-1)
	if not ( IsPedSittingInAnyVehicle( lPed ) ) then

		if IsControlJustPressed(0,241) then
			fov = math.max(fov - zoomspeed, fov_min)
		end
		if IsControlJustPressed(0,242) then
			fov = math.min(fov + zoomspeed, fov_max)
		end
		local current_fov = GetCamFov(cam)
		if math.abs(fov-current_fov) < 0.1 then
			fov = current_fov
		end
		SetCamFov(cam, current_fov + (fov - current_fov)*0.05)
	else
		if IsControlJustPressed(0,17) then
			fov = math.max(fov - zoomspeed, fov_min)
		end
		if IsControlJustPressed(0,16) then
			fov = math.min(fov + zoomspeed, fov_max)
		end
		local current_fov = GetCamFov(cam)
		if math.abs(fov-current_fov) < 0.1 then
			fov = current_fov
		end
		SetCamFov(cam, current_fov + (fov - current_fov)*0.05)
	end
end

RegisterNetEvent("Mic:ToggleMic")
AddEventHandler("Mic:ToggleMic", function()
	if not holdingMic then
		local oiY = LocalPlayer()
        local FsYIVlkf, HLXS0Q_, pfZ3SPy_ = oiY.Ped, oiY:GetVehicle(), oiY.Pos
        RequestModel(GetHashKey(micModel))
        while not HasModelLoaded(GetHashKey(micModel)) do
            Citizen.Wait(100)
        end
        local plyCoords = GetOffsetFromEntityInWorldCoords(GetPlayerPed(PlayerId()), 0.0, 0.0, -5.0)
        local micspawned = CreateObject(GetHashKey(micModel), pfZ3SPy_, true, 0, 0)
        Citizen.Wait(100)
        local netid = ObjToNet(micspawned)
        SetNetworkIdExistsOnAllMachines(netid, true)
        NetworkSetNetworkIdDynamic(netid, true)
        SetNetworkIdCanMigrate(netid, false)
		AttachEntityToEntity(micspawned, GetPlayerPed(PlayerId()), GetPedBoneIndex(GetPlayerPed(PlayerId()), 60309), 0.055, 0.05, 0.0, 240.0, 0.0, 0.0, 0, 0, 0, 1, 0, 1)
        mic_net = netid
		holdingMic = true
    else
        ClearPedSecondaryTask(GetPlayerPed(PlayerId()))
        DetachEntity(NetToObj(mic_net), 1, 1)
        DeleteEntity(NetToObj(mic_net))
        mic_net = nil
        holdingMic = false
		usingMic = false
    end
end)