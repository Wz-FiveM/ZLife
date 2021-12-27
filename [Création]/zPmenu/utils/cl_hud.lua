local hasnotmapgps = false
local hasbuygps = false
local CinematiqueMode = false

RegisterNetEvent('esx_gps:addGPS')
AddEventHandler('esx_gps:addGPS', function()
	if not hasnotmapgps then 
		hasbuygps = true
		DisplayRadar(true)
	end
end)

RegisterNetEvent('esx_gps:removeGPS')
AddEventHandler('esx_gps:removeGPS', function()
	hasbuygps = false
	DisplayRadar(false)
end)

local function fcthud(Ped,Select)
	if Select == 1 then 
		hasnotmapgps = false
		CinematiqueMode = false
		if hasbuygps then
			DisplayRadar(true)
		end
		SetRadarBigmapEnabled(false, false)
	elseif Select == 2 then 
		CinematiqueMode = false
		if hasnotmapgps then 
			if hasbuygps then 
				DisplayRadar(true)
			end
		end
		SetRadarBigmapEnabled(true, false)
    elseif Select == 3 then 
		hasnotmapgps = true
		CinematiqueMode = false
		DisplayRadar(false)
	elseif Select == 4 then 
		hasnotmapgps = true
		CinematiqueMode = true
    end 
end

local MenuHud={
    onSelected = fcthud,
    params = {close=false},
    menu = {
        {
			{name="Mode Normal",icon="fas fa-reply"},
			{name="Mode Grande Map", icon="far fa-images"},
			{name="Mode Aucun",icon="fas fa-camera"},
			{name="Mode Cinématique",icon="fas fa-film"},
        }
    }
}

RegisterControlKey("menuhud","Ouvrir les options HUD","F7",function()
	CreateRoue(MenuHud)
end)

Citizen.CreateThread(function()
    while true do
		local attente = 650
		if CinematiqueMode then 
			attente = 1
			DrawRect(.0, .0, 2.0, .2, 0, 0, 0, 255)
			DrawRect(.0, .99, 2.0, .2, 0, 0, 0, 255)
			HideHudAndRadarThisFrame()
			HideHudComponentThisFrame(10)
		end
		Wait(attente)
    end
end)