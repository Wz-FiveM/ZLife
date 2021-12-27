local HeliDispo = {GetHashKey("maverick2")}

local function DescenteRappel()
    local pPed,pVeh=GetPlayerPed(-1),GetVehiclePedIsIn(GetPlayerPed(-1), false)
    if not pVeh or not tableHasValue(HeliDispo,GetEntityModel(pVeh))then 
        return 
    end
    if GetPedInVehicleSeat(pVeh,-1)==pPed or GetPedInVehicleSeat(pVeh,0)==pPed then
        ShowAboveRadarMessage("~r~Vous ne pouvez pas descendre depuis cette place.")return 
    end;
    TaskRappelFromHeli(pPed,0)
    Citizen.Wait(30000)
end;

local Light=false

local function selectheli(Ped,Select)
    local Veh=GetVehiclePedIsIn(GetPlayerPed(-1), false)
    if not Veh or not tableHasValue(HeliDispo,GetEntityModel(Veh))then 
        return 
    end
    if Select==1 then 
        Light = not Light
        if Light then 
            SetVehicleSearchlight(Veh,true)
        elseif not Light and IsVehicleSearchlightOn(Veh) then 
            SetVehicleSearchlight(Veh,false)
        end
    elseif Select==2 then 
        DescenteRappel()
    end 
end

local MenuHelico = {
	onSelected=selectheli,
	params={close=false},
	menu={
		{
			{name="Lampe",icon="far fa-lightbulb"},
			{name="Descente en rappel",icon="fas fa-anchor"}
		}
	}
}

RegisterControlKey("menuheli","Ouvrir le menu hélicoptère","E",function()
	if tableHasValue(HeliDispo,GetEntityModel(GetVehiclePedIsIn(GetPlayerPed(-1), false))) then 
		CreateRoue(MenuHelico)
	end
end)

--[[ local function selectboat(Ped,Select)
    local Veh=GetVehiclePedIsIn(GetPlayerPed(-1), false)
    if Select==1 then 
		if GetEntitySpeed(Veh)*3.6 >10 then ShowAboveRadarMessage("~r~Vous devez être à l'arrêt.") return end;
			local umyCNfj=not N_0xb0ad1238a709b1a2(Veh)
			N_0xe3ebaae484798530(Veh,true)
			SetBoatAnchor(Veh,umyCNfj)
			ShowAboveRadarMessage(umyCNfj and"Vous avez ~g~jeté~w~ l'ancre."or"Vous avez ~r~levé~w~ l'ancre.")
    end 
end

local Menuboat = {
	onSelected=selectboat,
	params={close=false},
	menu={
		{
			{name="Jeter l'ancre",icon="fas fa-anchor"}
		}
	}
}

RegisterControlKey("menuboat","Ouvrir le menu bateau","E",function()
	if IsPedInAnyBoat(GetPlayerPed(-1)) then 
		CreateRoue(Menuboat)
	end
end) ]]

local fov_max = 95.0
local fov_min = 5.0 -- max zoom level (smaller fov is more zoom)
local zoomspeed = 10.0 -- camera zoom speed
local speed_lr = 8.0 -- speed by which the camera pans left-right
local speed_ud = 8.0 -- speed by which the camera pans up-down

local binoculars = false
local fov = (fov_max+fov_min)*0.5

local storeBinoclarKey = 177

function j(bool)
	binoculars = bool
	Citizen.CreateThread(function()
		while true do
			local attente = 1000
			local lPed = GetPlayerPed(-1)
			local vehicle = GetVehiclePedIsIn(lPed)
	
			if binoculars then
				attente = 1
				if not ( IsPedSittingInAnyVehicle( lPed ) ) then
					TaskStartScenarioInPlace(GetPlayerPed(-1), "WORLD_HUMAN_BINOCULARS", 0, 1)
					PlayAmbientSpeech1(GetPlayerPed(-1), "GENERIC_CURSE_MED", "SPEECH_PARAMS_FORCE")
				end
	
				Wait(2000)
	
				SetTimecycleModifier("default")
	
				SetTimecycleModifierStrength(0.3)
	
				local scaleform = RequestScaleformMovie("BINOCULARS")
	
				while not HasScaleformMovieLoaded(scaleform) do
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
				PushScaleformMovieFunctionParameterInt(0) -- 0 for nothing, 1 for LSPD logo
				PopScaleformMovieFunctionVoid()
	
				while binoculars and not IsEntityDead(lPed) and (GetVehiclePedIsIn(lPed) == vehicle) and true do
					if IsControlJustPressed(0, storeBinoclarKey) then -- Toggle binoculars
						ClearPedTasks(GetPlayerPed(-1))
						binoculars = false
					end
	
					local zoomvalue = (1.0/(fov_max-fov_min))*(fov-fov_min)
					CheckInputRotation(cam, zoomvalue)
	
					HandleZoom(cam)
					HideHUDThisFrame()
	
					DrawScaleformMovieFullscreen(scaleform, 255, 255, 255, 255)
					Citizen.Wait(0)
				end
	
				binoculars = false
				attente = 1000
				ClearTimecycleModifier()
				fov = (fov_max+fov_min)*0.5
				RenderScriptCams(false, false, 0, 1, 0)
				SetScaleformMovieAsNoLongerNeeded(scaleform)
				DestroyCam(cam, false)
				SetNightvision(false)
				SetSeethrough(false)
			end
			Wait(attente)
		end
	end)
end

--EVENTS--

-- Activate binoculars
RegisterNetEvent('binoculars:Activate')
AddEventHandler('binoculars:Activate', function()
	j(true)
end)

--FUNCTIONS--
function HideHUDThisFrame()
	HideHelpTextThisFrame()
	HideHudComponentThisFrame(1) -- Wanted Stars
	HideHudComponentThisFrame(2) -- Weapon icon
	HideHudComponentThisFrame(3) -- Cash
	HideHudComponentThisFrame(4) -- MP CASH
	HideHudComponentThisFrame(6)
	HideHudComponentThisFrame(7)
	HideHudComponentThisFrame(8)
	HideHudComponentThisFrame(9)
	HideHudComponentThisFrame(13) -- Cash Change
	HideHudComponentThisFrame(11) -- Floating Help Text
	HideHudComponentThisFrame(12) -- more floating help text
	HideHudComponentThisFrame(15) -- Subtitle Text
	HideHudComponentThisFrame(18) -- Game Stream
	HideHudComponentThisFrame(19) -- weapon wheel
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

		if IsControlJustPressed(0,241) then -- Scrollup
			fov = math.max(fov - zoomspeed, fov_min)
		end
		if IsControlJustPressed(0,242) then
			fov = math.min(fov + zoomspeed, fov_max) -- ScrollDown
		end
		local current_fov = GetCamFov(cam)
		if math.abs(fov-current_fov) < 0.1 then
			fov = current_fov
		end
		SetCamFov(cam, current_fov + (fov - current_fov)*0.05)
	else
		if IsControlJustPressed(0,17) then -- Scrollup
			fov = math.max(fov - zoomspeed, fov_min)
		end
		if IsControlJustPressed(0,16) then
			fov = math.min(fov + zoomspeed, fov_max) -- ScrollDown
		end
		local current_fov = GetCamFov(cam)
		if math.abs(fov-current_fov) < 0.1 then -- the difference is too small, just set the value directly to avoid unneeded updates to FOV of order 10^-5
			fov = current_fov
		end
		SetCamFov(cam, current_fov + (fov - current_fov)*0.05) -- Smoothing of camera zoom
	end
end