local PlayerData, CurrentActionData, handcuffTimer, blipsCops, currentTask, spawnedVehicles = {}, {}, {}, {}, {}, {}
local HasAlreadyEnteredMarker, isDead, IsHandcuffed, hasAlreadyJoined, playerInService, isInShopMenu = false, false, false, false, false, false
local LastStation, LastPart, LastPartNum, LastEntity, CurrentAction, CurrentActionMsg
ESX = nil
blip = nil
blips = {}
local servicepolice = false
local attente = 0

function ShowFloatingHelpNotification(msg, coords) 
    AddTextEntry("FloatingHelpNotification", msg) 
    SetFloatingHelpTextWorldPosition(1, coords) 
    SetFloatingHelpTextStyle(1, 2, 2, -1, 3, 0) 
    BeginTextCommandDisplayHelp("FloatingHelpNotification") 
    EndTextCommandDisplayHelp(2, false, false, -1) 
end

Citizen.CreateThread(function()
	while ESX == nil do
		TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
		Citizen.Wait(0) 
	end

	while ESX.GetPlayerData().job == nil do
		Citizen.Wait(10)
	end


	PlayerData = ESX.GetPlayerData()
end)

local playerPed = PlayerPedId()

function cleanPlayer(playerPed)
	SetPedArmour(playerPed, 0)
	ClearPedBloodDamage(playerPed)
	ResetPedVisibleDamage(playerPed)
	ClearPedLastWeaponDamage(playerPed)
	ResetPedMovementClipset(playerPed, 0)
end

RegisterCommand("ser", function() TriggerServerEvent("player:serviceOff", "police") end, false)

RegisterNetEvent('c_lspd:usetenue')
AddEventHandler('c_lspd:usetenue', function()
  if not UseTenu then
	--TriggerServerEvent("player:serviceOn", "police")
    cleanPlayer(playerPed)
    local dict, anim = "mp_clothing@female@shoes", "try_shoes_negative_a"
    ESX.Streaming.RequestAnimDict(dict)
    TaskPlayAnim(GetPlayerPed(-1),dict,anim,8.0, -8.0, -1, 0, 0, false, false, false)
    Citizen.Wait(6500)
    
    TriggerEvent('skinchanger:getSkin', function(skin)

      if skin.sex == 0 then
		ExecuteCommand('me change sa tenue.')
		servicepolice = true
		local clothesSkin = {
			['tshirt_1'] = 18,  ['tshirt_2'] = 0,
			['torso_1'] = 19,   ['torso_2'] = 8,
			['decals_1'] = 0,   ['decals_2'] = 0,
			['arms'] = 38,
			['pants_1'] = 37,   ['pants_2'] = 2,
			['shoes_1'] = 89,   ['shoes_2'] = 0,
			['helmet_1'] = -1,  ['helmet_2'] = 0,
			['bags_1'] = 13,
			['chain_1'] = 0,    ['chain_2'] = 0,
			['mask_1'] = 0,  ['mask_2'] = 0,
			['bproof_1'] = 0,  ['bproof_2'] = 0,
			}
			TriggerEvent('skinchanger:loadClothes', skin, clothesSkin)
		  else
			ExecuteCommand('me change sa tenue.')
			servicepolice = true
			local clothesSkin = {
				['tshirt_1'] = 17,  ['tshirt_2'] = 0,
				['torso_1'] = 18,   ['torso_2'] = 8,
				['decals_1'] = 0,   ['decals_2'] = 0,
				['arms'] = 36,
				['pants_1'] = 40,  ['pants_2'] = 2,
				['shoes_1'] = 58,   ['shoes_2'] = 0,
				['helmet_1'] = -1,  ['helmet_2'] = 0,
				['bags_1'] = 11,
				['chain_1'] = 0,    ['chain_2'] = 0,
				['mask_1'] = 0,  ['mask_2'] = 0,
				['bproof_1'] = 0,  ['bproof_2'] = 0,
			}
        TriggerEvent('skinchanger:loadClothes', skin, clothesSkin)
      end
      local playerPed = GetPlayerPed(-1)
      ClearPedBloodDamage(playerPed)
      ResetPedVisibleDamage(playerPed)
      ClearPedLastWeaponDamage(playerPed)
    end)
  else

    TriggerEvent('skinchanger:getSkin', function(skin)

      ESX.TriggerServerCallback('esx_skin:getPlayerSkin', function(skin, hasSkin)

        if hasSkin then

          cleanPlayer(playerPed)
          local dict, anim = "mp_clothing@female@shoes", "try_shoes_negative_a"
          ESX.Streaming.RequestAnimDict(dict)
          TaskPlayAnim(GetPlayerPed(-1),dict,anim,8.0, -8.0, -1, 0, 0, false, false, false)
		  Citizen.Wait(6500)
		  servicepolice = false

          TriggerEvent('skinchanger:loadSkin', skin)
          TriggerEvent('esx:restoreLoadout')
		  --TriggerServerEvent("player:serviceOff", "police")
        end
      end)
    end)
  end
  UseTenu = not UseTenu
end)





Citizen.CreateThread(function()
	while true do	
		SetPedSuffersCriticalHits(GetPlayerPed(-1), false)
		Wait(1)
	end
end)


Citizen.CreateThread( function()
	while true do
		 Wait(500)
		 if IsPedShooting(GetPlayerPed(-1)) then
			local plyPos = GetEntityCoords(GetPlayerPed(-1), true)
			local msg = "Coups de feu entendu"
			TriggerServerEvent("call:makeCall", "police", {x=plyPos.x,y=plyPos.y,z=plyPos.z}, msg)
		 end
	end
end)

local HasAlreadyEnteredMarker, LastZone = false, nil
local CurrentAction, CurrentActionMsg, CurrentActionData = nil, '', {}
local CurrentlyTowedVehicle, Blips, NPCOnJob, NPCTargetTowable, NPCTargetTowableZone = nil, {}, false, nil, nil
local NPCHasSpawnedTowable, NPCLastCancel, NPCHasBeenNextToTowable, NPCTargetDeleterZone = false, GetGameTimer() - 5 * 60000, false, false
local isDead, isBusy = false, false
local senservice = true
local cJoBcud={vector3(-1420.94,-441.68,35.90),vector3(195.81,-1467.75,28.12),vector3(
-229.5,6251.65,30.49),vector3(1998.93,3788.5,31.04),vector3(-337.39,-136.92,38.57),vector3(
-1155.54,-2007.183,12.74),vector3(731.82,-1088.82,21.73),vector3(1175.04,2640.22,37.32),vector3(
-210.3,-1323.74,29.69),vector3(255.4745,-2857.638,5.067799)}

ESX = nil
local PlayerData = {}

Citizen.CreateThread(function()
	while ESX == nil do
		TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
		Citizen.Wait(0)
	end

	while ESX.GetPlayerData().job == nil do
		Citizen.Wait(100)
	end

	ESX.PlayerData = ESX.GetPlayerData()
end)

function SelectRandomTowable()
	local index = GetRandomIntInRange(1,  #Config.Towables)

	for k,v in pairs(Config.ZonesLsCus) do
		if v.Pos.x == Config.Towables[index].x and v.Pos.y == Config.Towables[index].y and v.Pos.z == Config.Towables[index].z then
			return k
		end
	end
end

RegisterNetEvent('esx:playerLoaded')
AddEventHandler('esx:playerLoaded', function(xPlayer)
	ESX.PlayerData = xPlayer
end)

RegisterNetEvent('esx:setJob')
AddEventHandler('esx:setJob', function(job)
	ESX.PlayerData.job = job
end)

AddEventHandler('esx_policejob:hasExitedEntityZone', function(entity)
	if CurrentAction == 'remove_entity' then
		CurrentAction = nil
	end
end)



-- Display markers
Citizen.CreateThread(function()
	while true do		
		local attente = 500

		if ESX.PlayerData.job and ESX.PlayerData.job.name == 'police' then
			local coords, letSleep = GetEntityCoords(PlayerPedId()), true

			for k,v in pairs(Config.ZonesLsCus) do
				if v.Type ~= -1 and GetDistanceBetweenCoords(coords, v.Pos.x, v.Pos.y, v.Pos.z, true) < 10 and not IsPedInAnyVehicle(GetPlayerPed(-1), false) then
					attente = 1
					DrawMarker(v.Type, v.Pos.x, v.Pos.y, v.Pos.z, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 1.0, 1.0, 0.6, 0, 121, 255, 100, false, true, 2, false, nil, nil, false)
					letSleep = false
				elseif IsPedInAnyVehicle(GetPlayerPed(-1), false) then 
					attente = 2500
				end
			end

			if letSleep then
				Citizen.Wait(500)
			end
		else
			Citizen.Wait(500)
		end
		Wait(attente)
	end
end)

-- Enter / Exit marker events
Citizen.CreateThread(function()
	while true do		
		local attente = 500

		if ESX.PlayerData.job and ESX.PlayerData.job.name == 'police' then

			local coords      = GetEntityCoords(PlayerPedId())
			local isInMarker  = false
			local currentZone = nil

			for k,v in pairs(Config.ZonesLsCus) do
				if(GetDistanceBetweenCoords(coords, v.Pos.x, v.Pos.y, v.Pos.z, true) < v.Size.x) then
					attente = 1
					isInMarker  = true
					currentZone = k
				end
			end

			if (isInMarker and not HasAlreadyEnteredMarker) or (isInMarker and LastZone ~= currentZone) then
				attente = 1
				HasAlreadyEnteredMarker = true
				LastZone                = currentZone
				TriggerEvent('esx_policejob:hasEnteredMarker', currentZone)
			end

			if not isInMarker and HasAlreadyEnteredMarker then
				attente = 1
				HasAlreadyEnteredMarker = false
				TriggerEvent('esx_policejob:hasExitedMarker', LastZone)
			end

		end
		Wait(attente)
	end
end)

local e,B6zKxgVs=18000,6000
function requestVehControl(veh)
	if not veh then return end
	local id = VehToNet(veh)

	if id > 0 and not NetworkHasControlOfEntity(veh) then
		NetworkRequestControlOfEntity(veh)
		while not NetworkHasControlOfEntity(veh) do
			Citizen.Wait(0)
		end

		return true
	end
end

function renfort1()
	local plyPos = GetEntityCoords(GetPlayerPed(-1), true)
	local msg = "Besoin de renfort"
	TriggerServerEvent("call:makeCall", "police", {x=plyPos.x,y=plyPos.y,z=plyPos.z}, msg)
end

function renfort2()
	local plyPos = GetEntityCoords(GetPlayerPed(-1), true)
	local msg = "Besoin de renfort Urgent"
	TriggerServerEvent("call:makeCall", "police", {x=plyPos.x,y=plyPos.y,z=plyPos.z}, msg)
end

function renfort3()
	local plyPos = GetEntityCoords(GetPlayerPed(-1), true)
	local msg = "Code 99"
	TriggerServerEvent("call:makeCall", "police", {x=plyPos.x,y=plyPos.y,z=plyPos.z}, msg)
end


RegisterCommand("am", function() renfort3() end, false)



function askVehInfo(oiY,FsYIVlkf)
	if not FsYIVlkf or not DoesEntityExist(FsYIVlkf)then 
		return 
	end
	if oiY==1 then
		local HLXS0Q_=GetVehicleNumberPlateText(FsYIVlkf)
		ShowAboveRadarMessage("~b~Plaque du véhicule :\n~w~"..HLXS0Q_)
	elseif oiY==2 then
		ShowAboveRadarMessage("~w~Moteur : ~b~"..math.ceil(GetVehicleEngineHealth(FsYIVlkf)/10).."%~n~~w~Carosserie : ~b~"..GetVehicleCaro(FsYIVlkf).."%~n~~s~Essence : ~b~"..math.ceil(GetVehicleFuelLevel(FsYIVlkf)).."L")
	elseif oiY==3 then
		local Kw,nvaIsNv7,vDnoL55,xlAK,zr1y=GetVehicleMod(FsYIVlkf,11)+1,IsToggleModOn(FsYIVlkf,18)and"~g~Installé"or"~r~Non-installé",GetVehicleMod(FsYIVlkf,13)+1,GetVehicleMod(FsYIVlkf,15)+1,GetVehicleMod(FsYIVlkf,12)+1
		ShowAboveRadarMessage("~b~Pièces du véhicule :~n~~w~Moteur ~b~("..Kw..")~n~~w~Freins ~b~("..zr1y..")~n~~w~Suspension ~b~("..xlAK..")~n~~w~Transmission ~b~("..vDnoL55 ..")~n~~w~Turbo : "..nvaIsNv7)
	end 
end

local function O3_X(Z65,umyCNfj,FT)
	local playerPed = GetPlayerPed(-1)
	local PlayerCoords = GetEntityCoords(playerPed)
	local YVLXYq = GetClosestVehicle(PlayerCoords.x, PlayerCoords.y, PlayerCoords.z, 5.0, 0, 71)
	if Z65 ==2 then
		if umyCNfj==4 then 
			repairPneu(YVLXYq)
		elseif umyCNfj==5 then 
			messagelscustomnotfinish = true
			local amount = KeyboardInput("Annonce", "", 250)
			if amount ~= nil then
				amount = string.len(amount)
				if amount >= 10 then 
					TriggerServerEvent('clp_lscustom:annoncelscustom',result)   
					messagelscustomnotfinish = false
				else
					ShowAboveRadarMessage("~r~Votre message est trop court.")
				end
			end
		elseif umyCNfj ~=3 then
			renfort1()
		elseif umyCNfj ~= 4 then
			renfort3()
		elseif umyCNfj ~= 5 then
			renfort2()
		end
	elseif Z65 ==4 then 
		if umyCNfj ~= 4 then 
			askVehInfo(umyCNfj,YVLXYq)
		elseif umyCNfj == 4 then 
			LivrerVehicule("Allez chercher le véhicule avec le Flatbed sur le parking.", VehSecur, possibleSpawn, stop, 500) 
		end
	elseif Z65 ==3 then
		if umyCNfj==3 then
			TriggerServerEvent('esx_license:addLicense', GetPlayerServerId(closestPlayer), 'weapon')
			ShowAboveRadarMessage('Vous venez d\'attribuer le ~b~PPA à ~b~quelqu\'un~g~.')
		elseif umyCNfj==4 then
				if not YVLXYq or not DoesEntityExist(YVLXYq)then
					ShowAboveRadarMessage("~r~Vous devez être à proximité d'un véhicule.")
					return 
				end;
				TriggerEvent('persistent-vehicles/forget-vehicle', YVLXYq)
				Wait(50)
				ClearAreaOfVehicles(GetEntityCoords(GetPlayerPed(-1)),5.0)
				YVLXYq=YVLXYq or getCloseVeh()
				requestVehControl(YVLXYq)
				SetVehicleHasBeenOwnedByPlayer(YVLXYq)
				Wait(500)
				DeleteEntity(YVLXYq)
				DeleteVehicle(YVLXYq)
		elseif umyCNfj==5 then
			TriggerServerEvent('esx_license:removeLicense', GetPlayerServerId(closestPlayer), 'weapon')
			ShowAboveRadarMessage('Vous venez de révoquer le ~b~PPA à ~b~quelqu\'un~b~.')
		elseif umyCNfj==1 then
			SetEntityHeading(YVLXYq,GetEntityHeading(YVLXYq))
		else
			CreateFacture("society_police")
		end 
	end 
end
local DVs8kf2w={
	onSelected=O3_X,
	params={close=true},
	menu={ 
		{
			{name="Renforts",icon="fas fa-users",cb=1},
			{name="Actions",icon="fas fa-location-arrow",cb=2},
			{name="Informations du véhicule",icon="fa fa-id-card",cb=3}
		},
		{
			{name="Renfort Urgent",icon="fas fa-users"},
			{name="Renfort Basique",icon="fas fa-users"},
			{name="Renfort Code 99",icon="fas fa-users"}
		},
		{
			{name="Retourner le véhicule",icon="fas fa-undo"},
			{name="Mettre une ammende",icon="fas fa-file-invoice-dollar"},
			{name="Attribuer le PPA",icon="fa fa-id-card"},
			{name="Mettre le véhicule en fourrière",icon="fas fa-key"},
			{name="Révoquer le PPA",icon="fas fa-ban"}
		},
		{
			{name="Immatriculation du véhicule",icon="fa fa-address-card"},
			{name="Etat du véhicule",icon="fas fa-heartbeat"}
		}
	}
}

-- Key Controls
Citizen.CreateThread(function()
	while true do
		local attente = 500

		if CurrentAction then
			ESX.ShowHelpNotification(CurrentActionMsg)
			attente = 5
			if IsControlJustReleased(0, 38) and ESX.PlayerData.job and ESX.PlayerData.job.name == 'police' then

				if CurrentAction == 'police_actions_menu' then
					OpenpoliceActionsMenu()
				elseif CurrentAction == 'delete_vehicle' then
					local veh = GetVehiclePedIsIn(GetPlayerPed(-1), false)
					TriggerEvent('persistent-vehicles/forget-vehicle', veh)
					Wait(50)
					ESX.Game.DeleteVehicle(veh)
					local plate = GetVehicleNumberPlateText(veh)
					TriggerServerEvent('esx_vehiclelock:deletekeyjobs', 'no', plate)

				elseif CurrentAction == 'remove_entity' then
					DeleteEntity(CurrentActionData.entity)
				end

				CurrentAction = nil
			end
		end

		if ESX.PlayerData.job ~= nil and ESX.PlayerData.job.name == 'police' then
			RegisterControlKey("policemenu","Ouvrir le menu Police","F6",function()
				if ESX.PlayerData.job ~= nil and ESX.PlayerData.job.name == 'police' then
					if senservice then 
						CreateRoue(DVs8kf2w)
					else 
						ShowAboveRadarMessage("~r~Vous n'avez pas votre tenue de service.")
					end
				end
			end)
		end
		Wait(attente)
	end
end)

AddEventHandler('esx:onPlayerDeath', function(data)
	isDead = true
end)

AddEventHandler('playerSpawned', function(spawn)
	isDead = false
end)





local VestiairesLSPD = {
    Base = { Header = {"commonmenu", "interaction_bgd"}, Color = {color_black}, HeaderColor = {50, 50, 50}, Title = 'Vestiaire' },
    Data = { currentMenu = "Accès au casier de la LSPD", "    " },
    Events = {
        onSelected = function(self, _, btn, PMenu, menuData, currentButton, currentBtn, currentSlt, result, playerPed)
            PlaySoundFrontend(-1, "SELECT", "HUD_FRONTEND_DEFAULT_SOUNDSET", 1)
            local slide = btn.slidenum
            local btn = btn.name
            local check = btn.unkCheckbox
            local closestPlayer, closestDistance = ESX.Game.GetClosestPlayer()


			if btn == "Reprendre vos affaires" then
				TriggerServerEvent("player:serviceOff", "police")
				TriggerEvent('esx_policejob:offDuty')
                ESX.TriggerServerCallback('esx_skin:getPlayerSkin', function(skin)
                    TriggerEvent('skinchanger:loadSkin', skin)
				end)
				SetPedArmour(playerPed, 0)			
			elseif btn == "Uniforme manches longues" then
				TriggerEvent('skinchanger:getSkin', function(skin)
					if skin.sex == 0 then
						TriggerEvent('skinchanger:loadClothes', skin, Config.Uniforms.manche_longe.male)
					elseif skin.sex == 1 then
						TriggerEvent('skinchanger:loadClothes', skin, Config.Uniforms.manche_longe.female)
					end
				end)
			elseif btn == "Uniforme cérémonie" then
				TriggerEvent('skinchanger:getSkin', function(skin)
					if skin.sex == 0 then
						TriggerEvent('skinchanger:loadClothes', skin, Config.Uniforms.ceremonie.male)
					elseif skin.sex == 1 then
						TriggerEvent('skinchanger:loadClothes', skin, Config.Uniforms.ceremonie.female)
					end
				end)
			elseif btn == "Uniforme moto" then
				TriggerEvent('skinchanger:getSkin', function(skin)
					if skin.sex == 0 then
						TriggerEvent('skinchanger:loadClothes', skin, Config.Uniforms.moto.male)
					elseif skin.sex == 1 then
						TriggerEvent('skinchanger:loadClothes', skin, Config.Uniforms.moto.female)
					end
				end)
            elseif btn == "Uniforme vélo" then
				TriggerEvent('skinchanger:getSkin', function(skin)
					if skin.sex == 0 then
						TriggerEvent('skinchanger:loadClothes', skin, Config.Uniforms.velo.male)
					elseif skin.sex == 1 then
						TriggerEvent('skinchanger:loadClothes', skin, Config.Uniforms.velo.female)
					end
				end)
			elseif btn == "Uniforme manches courtes" then
				TriggerEvent('skinchanger:getSkin', function(skin)
					if skin.sex == 0 then
						TriggerEvent('skinchanger:loadClothes', skin, Config.Uniforms.manche_courte.male)
					elseif skin.sex == 1 then
						TriggerEvent('skinchanger:loadClothes', skin, Config.Uniforms.manche_courte.female)
					end
				end)
		end
	end,
},
    Menu = {
        ["Accès au casier de la LSPD"] = {
            b = {
                {name = "Reprendre vos affaires", askX = true},
                {name = "Uniforme manches longues", askX = true},
                {name = "Uniforme manches courtes", askX = true},
                {name = "Uniforme cérémonie", askX = true},
                -- {name = "Uniforme moto", askX = true},
                -- {name = "Uniforme vélo", askX = true},
            }
        },
    }
}

function spawnCarLspd(car, pos, hl)
	local car = GetHashKey(car)
	
	if not IsAnyVehicleNearPoint(pos ,5.0) then 
		RequestModel(car)
		while not HasModelLoaded(car) do
			RequestModel(car)
			Citizen.Wait(0)
		end

		local vehicle = CreateVehicle(car, pos-0.50, hl, false, false)
		SetVehicleNumberPlateText(vehicle, "POLIC911")
		SetVehicleDoorsLocked(vehicle, 1)
		SetVehicleDoorsLockedForAllPlayers(vehicle, false)
		SetEntityAsMissionEntity(vehicle,true,true)
		TriggerEvent('persistent-vehicles/register-vehicle', vehicle)
		SetVehicleHasBeenOwnedByPlayer(vehicle,true)
		local plate = GetVehicleNumberPlateText(vehicle)
		TriggerServerEvent('esx_vehiclelock:givekey', 'no', plate) 
		--SetVehicleMaxMods(vehicle)
		for i = 1,15 do
			SetVehicleExtra(vehicle,i,false)
		end
	else 
		ShowAboveRadarMessage("Vous ne pouvez pas sortir le véhicule du garage.\n~r~Il y a un véhicule devant l'entrée.")
	end
end

local garageLSPD = {
    Base = { Header = {"commonmenu", "interaction_bgd"}, Color = {color_black}, HeaderColor = {50, 50, 50}, Title = 'Garage LSPD' },
    Data = { currentMenu = "Garage LSPD", "    " },
    Events = {
        onSelected = function(self, _, btn, PMenu, menuData, currentButton, currentBtn, currentSlt, result, playerPed)
            PlaySoundFrontend(-1, "SELECT", "HUD_FRONTEND_DEFAULT_SOUNDSET", 1)
            local slide = btn.slidenum
            local btn = btn.name
            local check = btn.unkCheckbox
            local closestPlayer, closestDistance = ESX.Game.GetClosestPlayer()


			if btn == "Ford CVPI" then
				spawnCarLspd("police", -1061.730, -853.608, 4.8689, 33.206)	 		
			elseif btn == "Dodge Charger" then
				spawnCarLspd("police2", -1061.730, -853.608, 4.8689, 33.206)	
			elseif btn == "Vapid Cruiser" then
				spawnCarLspd("police3", -1061.730, -853.608, 4.8689, 33.206)	
			elseif btn == "Dodge Charger Banalisée" then
				spawnCarLspd("police42", -1061.730, -853.608, 4.8689, 33.206)	
            elseif btn == "Moto Police" then
				spawnCarLspd("lspdb", -1061.730, -853.608, 4.8689, 33.206)	
			elseif btn == "Uniforme manches courtes" then
				spawnCarLspd("police", -1061.730, -853.608, 4.8689, 33.206)	
		end
	end,
},
    Menu = {
        ["Garage LSPD"] = {
            b = {
                {name = "Ford CVPI", askX = true},
                {name = "Dodge Charger", askX = true},
                {name = "Vapid Cruiser", askX = true},
				{name = "Dodge Charger Banalisée", askX = true},
                {name = "Moto Police", askX = true},
            }
        },
    }
}


local interval = 150

Citizen.CreateThread(function()
	while true do
		if ESX.PlayerData.job and ESX.PlayerData.job.name == 'police' then
			interval = 150
			local plyCoords = GetEntityCoords(GetPlayerPed(-1), false)
			local vestiaire = Vdist(plyCoords.x, plyCoords.y, plyCoords.z, -1098.569, -831.392, 14.282)
			local garage = Vdist(plyCoords.x, plyCoords.y, plyCoords.z, -1078.722, -856.6899, 5.0427)
			local stockveh = Vdist(plyCoords.x, plyCoords.y, plyCoords.z, -1061.735, -853.589, 4.8689)

			if stockveh <= 8.0 then
				interval = 150
			end
			
			if stockveh <= 7.0 then
				interval = 0
				ShowFloatingHelpNotification("~b~Police~w~\nAppuyer sur [~b~E~w~] pour ranger votre ~b~Véhicule", vector3(-1061.735, -853.589, 4.8689))
				DrawMarker(25, -1061.735, -853.589, 4.8689-0.98 , 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 1.0, 1.0, 1.0, 46, 134, 193, 120)
			end

			if stockveh <= 1.5 then
				if IsControlJustReleased(0, 51) then
					local vehicle = GetVehiclePedIsIn(GetPlayerPed(-1), false)
					ESX.Game.DeleteVehicle(vehicle)
					ESX.ShowColoredNotification("Vous avez ranger votre véhicule", 6)
					TriggerServerEvent('esx_vehiclelock:deletekeyjobs', 'no', "POLIC911")
				end
			end

			if vestiaire <= 8.0 then
				interval = 150
			end
			
			if vestiaire <= 7.0 then
				interval = 0
				ShowFloatingHelpNotification("~b~Police~w~\nAppuyer sur [~b~E~w~] pour ouvrir le ~b~Vestiaire", vector3(-1098.569, -831.392, 14.282))
				--DrawText3D(-1098.569, -831.392, 14.282+0.50, 'Appuyez sur ~b~E~s~ pour accéder au ~b~Vestiaire~s~')
				DrawMarker(25, -1098.569, -831.392, 14.282-0.98 , 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 1.0, 1.0, 1.0, 46, 134, 193, 120)
			end

			if vestiaire <= 1.5 then
				if IsControlJustReleased(0, 51) and ESX.PlayerData.job and ESX.PlayerData.job.name == 'police' then
					CreateMenu(VestiairesLSPD)
				end
			end

			if garage <= 8.0 then
				interval = 150
			end
			
			if garage <= 7.0 then
				interval = 0
				ShowFloatingHelpNotification("~b~Police~w~\nAppuyer sur [~b~E~w~] pour ouvrir le ~b~Garage", vector3(-1078.722, -856.6899, 5.0427))
				--DrawText3D(-1098.569, -831.392, 14.282+0.50, 'Appuyez sur ~b~E~s~ pour accéder au ~b~Vestiaire~s~')
				DrawMarker(25, -1078.722, -856.6899, 5.0427-0.98 , 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 1.0, 1.0, 1.0, 46, 134, 193, 120)
			end

			if garage <= 1.5 then
				if IsControlJustReleased(0, 51) and ESX.PlayerData.job and ESX.PlayerData.job.name == 'police' then
					CreateMenu(garageLSPD)
				end
			end
		end
		Wait(1)
	end
end)






