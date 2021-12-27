local HasAlreadyEnteredMarker, LastZone = false, nil
local CurrentAction, CurrentActionMsg, CurrentActionData = nil, '', {}
local CurrentlyTowedVehicle, Blips, NPCOnJob, NPCTargetTowable, NPCTargetTowableZone = nil, {}, false, nil, nil
local NPCHasSpawnedTowable, NPCLastCancel, NPCHasBeenNextToTowable, NPCTargetDeleterZone = false, GetGameTimer() - 5 * 60000, false, false
local isDead, isBusy = false, false
local senservice = false
local cJoBcud={vector3(-1421.01,-452.96,35.90),vector3(195.81,-1467.75,28.12),vector3(
-229.5,6251.65,30.49),vector3(1998.93,3788.5,31.04),vector3(-337.39,-136.92,38.57),vector3(
-1155.54,-2007.183,12.74),vector3(731.82,-1088.82,21.73),vector3(1175.04,2640.22,37.32),vector3(
-210.3,-1323.74,29.69),vector3(255.4745,-2857.638,5.067799)}

ESX = nil
local PlayerData = {}


RegisterNetEvent('c_lscustoms:usetenue')
AddEventHandler('c_lscustoms:usetenue', function()
  if not UseTenu then

    cleanPlayer(playerPed)
    local dict, anim = "mp_clothing@female@shoes", "try_shoes_negative_a"
    ESX.Streaming.RequestAnimDict(dict)
    TaskPlayAnim(GetPlayerPed(-1),dict,anim,8.0, -8.0, -1, 0, 0, false, false, false)
    Citizen.Wait(6500)
    
    TriggerEvent('skinchanger:getSkin', function(skin)

      if skin.sex == 0 then
		ExecuteCommand('me change sa tenue.')
		senservice = true
		local clothesSkin = {
			['tshirt_1'] = 25, ['tshirt_2'] = 0,
			['torso_1'] = 105, ['torso_2'] = 0,
			['arms'] = 4,
			['pants_1'] = 50, ['pants_2'] = 0,
			['shoes_1'] = 32, ['shoes_2'] = 0,
			['helmet_1'] = -1, ['helmet_2'] = 0,
			}
			TriggerEvent('skinchanger:loadClothes', skin, clothesSkin)
		  else
			ExecuteCommand('me change sa tenue.')
			senservice = true
			local clothesSkin = {
				['tshirt_1'] = 15, ['tshirt_2'] = 0,
				['torso_1'] = 83, ['torso_2'] = 0,
				['arms'] = 0,
				['pants_1'] = 41, ['pants_2'] = 0,
			    ['shoes_1'] = 31, ['shoes_2'] = 0,
				['helmet_1'] = -1, ['helmet_2'] = 0,
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
		  senservice = false

          TriggerEvent('skinchanger:loadSkin', skin)
          TriggerEvent('esx:restoreLoadout')
        end
      end)
    end)
  end
  UseTenu = not UseTenu
end)

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

RegisterNetEvent('lscustoms:usemoteur')
AddEventHandler('lscustoms:usemoteur', function()
	local playerPed = GetPlayerPed(-1)
	local PlayerCoords = GetEntityCoords(playerPed)
	local YVLXYq = GetClosestVehicle(PlayerCoords.x, PlayerCoords.y, PlayerCoords.z, 5.0, 0, 71)
	doVehicleEntretien(1,YVLXYq)
end)

RegisterNetEvent('lscustoms:usepneu')
AddEventHandler('lscustoms:usepneu', function()
	local playerPed = GetPlayerPed(-1)
	local PlayerCoords = GetEntityCoords(playerPed)
	local YVLXYq = GetClosestVehicle(PlayerCoords.x, PlayerCoords.y, PlayerCoords.z, 5.0, 0, 71)
	repairPneu(YVLXYq)
end)

RegisterNetEvent('lscustoms:usekitcarro')
AddEventHandler('lscustoms:usekitcarro', function()
	local playerPed = GetPlayerPed(-1)
	local PlayerCoords = GetEntityCoords(playerPed)
	local YVLXYq = GetClosestVehicle(PlayerCoords.x, PlayerCoords.y, PlayerCoords.z, 5.0, 0, 71)
	doVehicleEntretien(2,YVLXYq)
end)

RegisterNetEvent('esx:playerLoaded')
AddEventHandler('esx:playerLoaded', function(xPlayer)
	ESX.PlayerData = xPlayer
end)

RegisterNetEvent('esx:setJob')
AddEventHandler('esx:setJob', function(job)
	ESX.PlayerData.job = job
end)

AddEventHandler('esx_lscustomsjob:hasEnteredMarker', function(zone)
	if zone == 'lscustomsActions' then
		CurrentAction     = 'lscustoms_actions_menu'
		CurrentActionMsg  = "Appuyez sur ~INPUT_CONTEXT~ pour ~b~discuter."
		CurrentActionData = {}
	elseif zone == 'VehicleDeleter' then
		DrawTopNotification("Appuyez sur ~INPUT_CONTEXT~ pour ~r~ranger le véhicule.")
		CurrentAction     = 'delete_vehicle'
		CurrentActionMsg  = "Appuyez sur ~INPUT_CONTEXT~ pour ~r~ranger le véhicule."
		CurrentActionData = {vehicle = vehicle}
	end
end)

AddEventHandler('esx_lscustomsjob:hasExitedMarker', function(zone)
	if zone =='VehicleDelivery' then
		NPCTargetDeleterZone = false
	end

	CurrentAction = nil
	ESX.UI.Menu.CloseAll()
end)


AddEventHandler('esx_lscustomsjob:hasExitedEntityZone', function(entity)
	if CurrentAction == 'remove_entity' then
		CurrentAction = nil
	end
end)

RegisterNetEvent('esx_phone:loaded')
AddEventHandler('esx_phone:loaded', function(phoneNumber, contacts)
	local specialContact = {
		name       = "Ls Custom\'s",
		number     = 'lscustoms',
		base64Icon = 'data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAAACAAAAAgCAYAAABzenr0AAAABHNCSVQICAgIfAhkiAAAAAlwSFlzAAALEwAACxMBAJqcGAAAA4BJREFUWIXtll9oU3cUx7/nJA02aSSlFouWMnXVB0ejU3wcRteHjv1puoc9rA978cUi2IqgRYWIZkMwrahUGfgkFMEZUdg6C+u21z1o3fbgqigVi7NzUtNcmsac40Npltz7S3rvUHzxQODec87vfD+/e0/O/QFv7Q0beV3QeXqmgV74/7H7fZJvuLwv8q/Xeux1gUrNBpN/nmtavdaqDqBK8VT2RDyV2VHmF1lvLERSBtCVynzYmcp+A9WqT9kcVKX4gHUehF0CEVY+1jYTTIwvt7YSIQnCTvsSUYz6gX5uDt7MP7KOKuQAgxmqQ+neUA+I1B1AiXi5X6ZAvKrabirmVYFwAMRT2RMg7F9SyKspvk73hfrtbkMPyIhA5FVqi0iBiEZMMQdAui/8E4GPv0oAJkpc6Q3+6goAAGpWBxNQmTLFmgL3jSJNgQdGv4pMts2EKm7ICJB/aG0xNdz74VEk13UYCx1/twPR8JjDT8wttyLZtkoAxSb8ZDCz0gdfKxWkFURf2v9qTYH7SK7rQIDn0P3nA0ehixvfwZwE0X9vBE/mW8piohhl1WH18UQBhYnre8N/L8b8xQvlx4ACbB4NnzaeRYDnKm0EALCMLXy84hwuTCXL/ExoB1E7qcK/8NCLIq5HcTT0i6u8TYbXUM1cAyyveVq8Xls7XhYrvY/4n3gC8C+dsmAzL1YUiyfWxvHzsy/w/dNd+KjhW2yvv/RfXr7x9QDcmo1he2RBiCCI1Q8jVj9szPNixVfgz+UiIGyDSrcoRu2J16d3I6e1VYvNSQjXpnucAcEPUOkGYZs/l4uUhowt/3kqu1UIv9n90fAY9jT3YBlbRvFTD4fw++wHjhiTRL/bG75t0jI2ITcHb5om4Xgmhv57xpGOg3d/NIqryOR7z+r+MC6qBJB/ZB2t9Om1D5lFm843G/3E3HI7Yh1xDRAfzLQr5EClBf/HBHK462TG2J0OABXeyWDPZ8VqxmBWYscpyghwtTd4EKpDTjCZdCNmzFM9k+4LHXIFACJN94Z6FiFEpKDQw9HndWsEuhnADVMhAUaYJBp9XrcGQKJ4qFE9k+6r2+MG3k5N8VQ22TVglbX2ZwOzX2VvNKr91zmY6S7N6zqZicVT2WNLyVSehESaBhxnOALfMeYX+K/S2yv7wmMAlvwyuR7FxQUyf0fgc/jztfkJr7XeGgC8BJJgWNV8ImT+AAAAAElFTkSuQmCC'
	}

	TriggerEvent('esx_phone:addSpecialContact', specialContact.name, specialContact.number, specialContact.base64Icon)
end)
local function JGSK(u)
    local pzDMZwG="switch@franklin@lamar_tagging_wall"
    RequestNamedPtfxAsset("scr_playerlamgraff")
    RequestAndWaitModel("prop_cs_spray_can")
    RequestAndWaitDict(pzDMZwG)
    while not HasNamedPtfxAssetLoaded("scr_playerlamgraff")do
        Citizen.Wait(0)
    end;
    local XPoQB,XxJ=GetPlayerPed(-1)
    local o5sms,JQi1jg=GetPlayerPed(-1),GetEntityCoords(GetPlayerPed(-1));
    local wVzn,pE=false,GetGameTimer()
    while not wVzn and pE+1500 >GetGameTimer()do 
        Wait(500)
    end
    local RSjapQ=CreateObject(GetHashKey("prop_cs_spray_can"),JQi1jg,true,true,false)
    SetNetworkIdCanMigrate(ObjToNet(RSjapQ),false)
    SetEntityNoCollisionEntity(RSjapQ,o5sms,true)
    AttachEntityToEntity(RSjapQ,o5sms,GetPedBoneIndex(o5sms,28422),0.0,-0.01,-0.02,0.0,0.0,0.0,1,1,0,0,2,1)
    local function QJf()
        if XxJ then 
            StopParticleFxLooped(XxJ,0)XxJ=nil 
        end 
    end
    local function zC()
        if not XxJ then 
            SetPtfxAssetNextCall("scr_playerlamgraff")
            XxJ=StartNetworkedParticleFxLoopedOnEntity("scr_lamgraff_paint_spray",RSjapQ,0.0,0.0,0.26,0.0,0.0,180.0,1.0,true,true,true)
            SetParticleFxLoopedColour(XxJ,1.0,1.0,1.0,0)
            SetParticleFxLoopedAlpha(XxJ,0.2)
        end 
    end
    TaskSynchronizedTasks(o5sms,{{anim={pzDMZwG,"lamar_tagging_wall_loop_lamar"},flag=0},{anim={pzDMZwG,"lamar_tagging_wall_exit_lamar"},flag=0},{anim={pzDMZwG,"lamar_tagging_exit_loop_lamar"},flag=0}})
    while not IsEntityPlayingAnim(o5sms,pzDMZwG,"lamar_tagging_wall_loop_lamar",3)do 
        Citizen.Wait(100)
    end;
    while IsEntityPlayingAnim(o5sms,pzDMZwG,"lamar_tagging_wall_loop_lamar",3)do
        Citizen.Wait(100)
    end
    local pfZ3SPy_=GetEntityAnimCurrentTime(o5sms,pzDMZwG,"lamar_tagging_wall_exit_lamar")
    while IsEntityPlayingAnim(o5sms,pzDMZwG,"lamar_tagging_wall_exit_lamar",3)do
        Citizen.Wait(0)
        pfZ3SPy_=GetEntityAnimCurrentTime(o5sms,pzDMZwG,"lamar_tagging_wall_exit_lamar")
        if pfZ3SPy_<0.38 then 
            QJf()
        elseif pfZ3SPy_<0.61 then 
            zC()
        elseif pfZ3SPy_<=1.0 then 
            QJf()
        end 
    end
    while IsEntityPlayingAnim(o5sms,pzDMZwG,"lamar_tagging_exit_loop_lamar",3)do
        Citizen.Wait(0)
        pfZ3SPy_=GetEntityAnimCurrentTime(o5sms,pzDMZwG,"lamar_tagging_exit_loop_lamar")
        if pfZ3SPy_<0.11 then 
            QJf()
        elseif pfZ3SPy_<0.55 then 
            zC()
        elseif pfZ3SPy_<0.75 then 
            QJf()
        elseif pfZ3SPy_<0.9 then 
            zC()
        elseif
        pfZ3SPy_<1.0 then 
            QJf()
        end 
    end;
	DetachEntity(RSjapQ,true,true)
	DeleteEntity(RSjapQ)
    SetEntityAsNoLongerNeeded(RSjapQ)
	RemoveNamedPtfxAsset("scr_playerlamgraff")
	TriggerServerEvent('clp_use:removespray')
    SetModelAsNoLongerNeeded("prop_cs_spray_can")
	RemoveAnimDict(pzDMZwG)
	QJf()
	u()
end

function UsePaintSpray(pDNa2ox6,Do6yo7nm)
	local playerPed = PlayerPedId()
	local coords    = GetEntityCoords(playerPed)
	local y06X3k=GetClosestVehicle(coords.x, coords.y, coords.z, 5.0, 0, 71)
	if not y06X3k or not DoesEntityExist(y06X3k)then
        ShowAboveRadarMessage("~r~Vous devez être à proximité d'un véhicule.")
        return 
    end
    JGSK(function()
    if not y06X3k or not DoesEntityExist(y06X3k)then
        ShowAboveRadarMessage("~r~Vous devez être à proximité d'un véhicule.")
        return 
    end
    SetVehicleModKit(y06X3k,0)
    if Do6yo7nm==1 then 
        SetVehicleModColor_1(y06X3k,pDNa2ox6)
    elseif Do6yo7nm==2 then
		SetVehicleModColor_2(y06X3k,pDNa2ox6)
	end
        ForceEntityAiAndAnimationUpdate(y06X3k)
        NetworkRequestControlOfEntity(y06X3k)
    end)
end

local rA5U,Uc06=0,0
local lcBL={
	menu={
		{
			{name="Normale",icon="fas fa-spray-can",cb=1},
			{name="Métallisée",icon="fas fa-spray-can",cb=1},
			{name="Perlée",icon="fas fa-spray-can",cb=1},
			{name="Mat",icon="fas fa-spray-can",cb=1},
			{name="Métalique",icon="fas fa-spray-can",cb=1},
			{name="Chrome",icon="fas fa-spray-can",cb=1}
		},
		{
			{name="Couleur principale",icon="fas fa-car",cb="close"},
			{name="Couleur secondaire",icon="fas fa-car",cb="close"}
		}
	},
	onSelected=function(ivnJjrA,d3fMjkg)
    if ivnJjrA==1 then 
        rA5U=d3fMjkg 
    else 
        Uc06=d3fMjkg 
    end;
    if Uc06 >0 and rA5U>0 then 
        UsePaintSpray(rA5U-1,Uc06)
    end 
end}
RegisterNetEvent('clp_use:spray')
AddEventHandler('clp_use:spray', function(phoneNumber, contacts)
	TriggerEvent('clp_closeinventory', source)
	Wait(50)
	CreateRoue(lcBL)
end)

-- Display markers
Citizen.CreateThread(function()
	while true do		
		local attente = 500

		if ESX.PlayerData.job and ESX.PlayerData.job.name == 'lscustoms' then
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

		if ESX.PlayerData.job and ESX.PlayerData.job.name == 'lscustoms' then

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
				TriggerEvent('esx_lscustomsjob:hasEnteredMarker', currentZone)
			end

			if not isInMarker and HasAlreadyEnteredMarker then
				attente = 1
				HasAlreadyEnteredMarker = false
				TriggerEvent('esx_lscustomsjob:hasExitedMarker', LastZone)
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
function repairPneu(scRP0)
	if DoesAnyProgressBarExists()then
        ShowAboveRadarMessage("~r~Vous réalisez déjà une action.")
        return 
    end;
    if not scRP0 or not DoesEntityExist(scRP0)then
        ShowAboveRadarMessage("~r~Vous devez être à proximité d'un véhicule.")
        return 
	end;
	local oh,DZXGTh,Su9Koz={},GetVehicleFuelLevel(scRP0),GetVehicleEngineHealth(scRP0)
	local XmVolesU = GetPlayerPed(-1)
	for Uk7e=0,10 do 
		oh[Uk7e]=IsVehicleTyreBurst(scRP0,Uk7e)
	end;
	TriggerServerEvent("clp:removeitem","pneu")
	createProgressBar("Changement des pneus",0,151,255,200, e)
	doAnim(2 and"WORLD_HUMAN_VEHICLE_MECHANIC"or{"mini@repair","fixing_a_ped"},e,1)
    SetEntityHeading(XmVolesU,2 and GetEntityHeading(XmVolesU)-180.0 or GetEntityHeading(XmVolesU))
	Wait(e)
	for KwQCk_G,ptZa in pairs(oh)do 
		if ptZa and(ptZa==true or ptZa==1)then
			SetVehicleTyreFixed(scRP0,tonumber(KwQCk_G))
			ShowAboveRadarMessage("~g~Les pneus du véhicule viennent d'être réparés.")
		end 
	end;
end
function doVehicleEntretien1(Rr,scRP0,AI0R2TQ6)
    if DoesAnyProgressBarExists()then
        ShowAboveRadarMessage("~r~Vous réalisez déjà une action.")
        return 
    end;
    if not scRP0 or not DoesEntityExist(scRP0)then
        ShowAboveRadarMessage("~r~Vous devez être à proximité d'un véhicule.")
        return 
	end;
	local XmVolesU = GetPlayerPed(-1)
	--if Rr==2 then 
		local eZ0l3ch
		print(eZ0l3ch)
		for W_63_9,h9dyA_4T in pairs(cJoBcud)do 
			if GetDistanceBetweenCoords(h9dyA_4T,GetEntityCoords(XmVolesU),true)<50 then 
				eZ0l3ch=true 
			end 
		end;
		if not eZ0l3ch then
			ShowAboveRadarMessage("~r~Vous devez être dans un garage.")
			return 
		end 
	--end;
        createProgressBar("Réparation en cours",0,151,255,200, e)
        doAnim(Rr==2 and"WORLD_HUMAN_VEHICLE_MECHANIC"or{"mini@repair","fixing_a_ped"},e,1)
        SetEntityHeading(XmVolesU,Rr==2 and GetEntityHeading(XmVolesU)-180.0 or GetEntityHeading(XmVolesU))
		requestVehControl(scRP0)
		SetVehicleDoorOpen(scRP0, 4, false, false)
        SetVehicleUndriveable(scRP0,true)
        Citizen.Wait(e)
        requestVehControl(scRP0)
        SetNetworkIdCanMigrate(VehToNet(scRP0),false)
		SetVehicleUndriveable(scRP0,false)
		local oh,DZXGTh,Su9Koz={},GetVehicleFuelLevel(scRP0),GetVehicleEngineHealth(scRP0)
        if Rr==1 then 
            SetVehicleEngineHealth(scRP0,1000.0)
        elseif Rr==2 then
            SetVehicleUndriveable(scRP0,false)
            SetVehicleFixed(scRP0)
            SetVehicleFuelLevel(scRP0,DZXGTh)
            SetVehicleEngineHealth(scRP0,Su9Koz)
            SetVehicleEngineOn(scRP0,true,false)
            SetVehicleBodyHealth(scRP0,1000.0)
            ForceEntityAiAndAnimationUpdate(scRP0)
        end;
	SetNetworkIdCanMigrate(VehToNet(scRP0),true)
	SetVehicleDoorShut(scRP0, 4, false, false)
    ShowAboveRadarMessage("~g~Vous avez réparé le véhicule.")
end
function doVehicleEntretien(Rr,scRP0,AI0R2TQ6)
    if not scRP0 or not DoesEntityExist(scRP0)then
        ShowAboveRadarMessage("~r~Vous devez être à proximité d'un véhicule.")
        return 
	end;
	local XmVolesU = GetPlayerPed(-1)
        createProgressBar("Réparation en cours",0,151,255,200, e)
        doAnim(Rr==2 and"WORLD_HUMAN_VEHICLE_MECHANIC"or{"mini@repair","fixing_a_ped"},e,1)
        SetEntityHeading(XmVolesU,Rr==2 and GetEntityHeading(XmVolesU)-180.0 or GetEntityHeading(XmVolesU))
		requestVehControl(scRP0)
		SetVehicleDoorOpen(scRP0, 4, false, false)
        SetVehicleUndriveable(scRP0,true)
        Citizen.Wait(e)
        requestVehControl(scRP0)
        SetNetworkIdCanMigrate(VehToNet(scRP0),false)
		SetVehicleUndriveable(scRP0,false)
		local oh,DZXGTh,Su9Koz={},GetVehicleFuelLevel(scRP0),GetVehicleEngineHealth(scRP0)
		if Rr==1 then 
			--TriggerServerEvent("clp:removeitem","moteur")
            SetVehicleEngineHealth(scRP0,1000.0)
		elseif Rr==2 then
			--TriggerServerEvent("clp:removeitem","kitcarro")
            SetVehicleUndriveable(scRP0,false)
            SetVehicleFixed(scRP0)
            SetVehicleFuelLevel(scRP0,DZXGTh)
            SetVehicleEngineHealth(scRP0,Su9Koz)
            SetVehicleEngineOn(scRP0,true,false)
            SetVehicleBodyHealth(scRP0,1000.0)
            ForceEntityAiAndAnimationUpdate(scRP0)
        end;
	SetNetworkIdCanMigrate(VehToNet(scRP0),true)
	SetVehicleDoorShut(scRP0, 4, false, false)
    ShowAboveRadarMessage("~g~Vous avez réparé le véhicule.")
end
function washVehicle(PEqsd,iSj,iXxD6s)
	if DoesAnyProgressBarExists()then ShowAboveRadarMessage("~r~Vous réalisez déjà une action.")return end;if not PEqsd or not
	DoesEntityExist(PEqsd)then
	ShowAboveRadarMessage("~r~Vous devez être à proximité d'un véhicule.")return end
	createProgressBar("Nettoyage en cours",0,151,255,200,B6zKxgVs)
	forceAnim({"WORLD_HUMAN_BUM_WASH"},nil,{time=B6zKxgVs})
	SetVehicleUndriveable(PEqsd,true)
	SetVehicleUndriveable(PEqsd,false)
	SetVehicleDirtLevel(PEqsd)
	ShowAboveRadarMessage("~g~Vous avez lavé le véhicule.")
end
function crochetagelVeh(veh)
	if DoesAnyProgressBarExists()then ShowAboveRadarMessage("~r~Vous réalisez déjà une action.")return end
	if not veh or not
	DoesEntityExist(veh)then
	ShowAboveRadarMessage("~r~Vous devez être à proximité d'un véhicule.")return end
	local dict, anim = "veh@break_in@0h@p_m_two@","std_locked_ds"
	ESX.Streaming.RequestAnimDict(dict)
	TaskPlayAnim(GetPlayerPed(-1), dict, anim, 8.0, 8.0, -1, 1, 1, 0, 0, 0)
	createProgressBar("Crochetage en cours",0,151,255,200, 10000)
	Citizen.Wait(10000)
	SetVehicleDoorsLocked(veh, 1)
	SetVehicleDoorsLockedForAllPlayers(veh, false)
	SetEntityAsMissionEntity(veh,true,true)
	SetVehicleHasBeenOwnedByPlayer(veh,true)
	ClearPedTasksImmediately(GetPlayerPed(-1))
	PlaySoundFrontend(-1, 'Drill_Pin_Break', 'DLC_HEIST_FLEECA_SOUNDSET', false)
	ShowAboveRadarMessage("Vous avez ~g~déverrouillé~w~ le véhicule.")
	isBusy = false
end
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
function flatbedveh(veh)
	if DoesAnyProgressBarExists()then ShowAboveRadarMessage("~r~Vous réalisez déjà une action.")return end
	if not veh or not
	DoesEntityExist(veh)then
	ShowAboveRadarMessage("~r~Vous devez être à proximité d'un véhicule.")return end
	local playerPed = PlayerPedId()
	local vehicle = GetVehiclePedIsIn(playerPed, true)
	local towmodel = GetHashKey('flatbed')
	local isVehicleTow = IsVehicleModel(vehicle, towmodel)
	if isVehicleTow then
		local targetVehicle = GetVehicleInDirection()
		if CurrentlyTowedVehicle == nil then
			if targetVehicle ~= 0 then
				if not IsPedInAnyVehicle(playerPed, true) then
					if vehicle ~= targetVehicle then
						AttachEntityToEntity(targetVehicle, vehicle, 20, -0.5, -5.0, 1.0, 0.0, 0.0, 0.0, false, false, false, false, 20, true)
						CurrentlyTowedVehicle = targetVehicle
						ShowAboveRadarMessage("~g~Le véhicule a été attaché avec succès.")
					else
						ShowAboveRadarMessage("~r~Vous ne pouvez pas attacher votre propre Flatbed.")
					end
				end
			else
				ShowAboveRadarMessage("~r~Il n\'y a pas de véhicule à attacher.")
			end
		else
			AttachEntityToEntity(CurrentlyTowedVehicle, vehicle, 20, -0.5, -12.0, 1.0, 0.0, 0.0, 0.0, false, false, false, false, 20, true)
			DetachEntity(CurrentlyTowedVehicle, true, true)
			CurrentlyTowedVehicle = nil
			ShowAboveRadarMessage("~g~Vous avez détaché le véhicule.")
		end
	else
		ShowAboveRadarMessage("~r~Vous devez avoir un Flatbed pour cette action.")
	end
end
local TimeMissionLimit = 60*1000*20
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
local possibleSpawn = {
    {pos = vector3(-223.04, -1329.68, 30.88-0.95),heading = 270.34,},
    {pos = vector3(733.32, -1082.44, 22.16-0.95),heading = 181.15,},
    {pos = vector3(1141.68, -773.0, 57.64-0.95),heading = 268.99,},
    {pos = vector3(118.68, 6599.48, 32.0-0.95),heading = 271.48,},
    {pos = vector3(1776.36, 3335.96, 41.2-0.95),heading = 210.84,},
    {pos = vector3(1176.88, 2650.24, 37.8-0.95),heading = 275.07,},
    {pos = vector3(-1128.76, -1998.12, 13.16-0.95),heading = 225.99,},
}
local stop = vector3(-356.28, -115.64, 38.68)

function LivrerVehicule(LongText, veh, possibleSpawn, stop, prix)
    ESX.AddTimerBar("TEMPS RESTANT :",{endTime=GetGameTimer()+TimeMissionLimit})
    ShowAboveRadarMessage("~b~LsCustoms\n~s~"..LongText)
	local i = math.random(1, #possibleSpawn)
	local a = math.random(1, #veh)
    local vehicule = veh[a].name
    local spawn = possibleSpawn[i].pos
    local heading = possibleSpawn[i].heading

    local blip = createBlip(spawn ,326,3,"Véhicule",true,1.0)
    local pPed = GetPlayerPed(-1)
    local pVeh = GetVehiclePedIsIn(pPed, false)
    local pCoords = GetEntityCoords(pPed)
    local dst = GetDistanceBetweenCoords(spawn, pCoords, true)

    local flt = vector3(-370.28, -107.64, 38.68)
    SpawnVehNotIn("flatbed", flt, 68.52, "FLATBED")

    while dst >= 30.0 do
        Wait(100)
        pCoords = GetEntityCoords(pPed)
        dst = GetDistanceBetweenCoords(spawn, pCoords, true)
    end
    local coords = {x=spawn.x,y=spawn.y,z=spawn.z}
    AddTextEntry("VOLE_VEH_MISSION", "Véhicule à récupérer.")
	SpawnVehNotIn(vehicule, spawn, heading, "CONCESS1")
	local flat = GetVehiclePedIsIn(GetPlayerPed(-1), false)

    while dst >= 3.0 do
        Wait(1)
        ShowFloatingHelp("VOLE_VEH_MISSION", spawn)
        pCoords = GetEntityCoords(pPed)
        DrawMarker(0,spawn.x,spawn.y,spawn.z+2.6,0.0,0.0,0.0,0.0,0.0,0.0,1.0,1.0,0.7,0,192,255,70,0,0,2,0,0,0,0)
        dst = GetDistanceBetweenCoords(spawn, pCoords, true)
    end

	local entity = GetClosestVehicle(GetEntityCoords(GetPlayerPed(-1)), 5.0, 0, 71)
	AttachEntityToEntity(entity, flat, 20, -0.5, -5.0, 1.0, 0.0, 0.0, 0.0, false, false, false, false, 20, true)
    RemoveBlip(blip)

    local blip = AddBlipForCoord(stop)
    SetBlipRoute(blip, 1)
    
    local dst = GetDistanceBetweenCoords(stop, pCoords, true)
    PlaySoundFrontend(-1, "Object_Dropped_Remote", "GTAO_FM_Events_Soundset", 0)
    ShowAboveRadarMessage("~b~LsCustoms\n~s~Récupérez le véhicule.")
    while dst >= 5.0 do
        Wait(1)
        pCoords = GetEntityCoords(pPed)
        dst = GetDistanceBetweenCoords(pCoords, stop, true)
    end

    local plate = GetVehicleNumberPlateText(entity)
    local pEngine = GetVehicleEngineHealth(entity)
    if plate == "CONCESS1" then 
        if pEngine > 750 then 
            ESX.RemoveTimerBar()
            PlaySoundFrontend(-1, "Out_Of_Bounds_Timer", "DLC_HEISTS_GENERAL_FRONTEND_SOUNDS", 0)
            ShowAboveRadarMessage("~b~LsCustoms\n~s~L'entreprise a reçu l'argent.")
            RemoveBlip(blip)
            SetBlipRoute(blip, 0)
            TaskVehicleTempAction(GetPlayerPed(-1), GetVehiclePedIsIn(GetPlayerPed(-1), 0), 6, 2000)
            Wait(2000)
            TaskLeaveAnyVehicle(GetPlayerPed(-1), 0, 0)
            SetVehicleDoorsLocked(GetVehiclePedIsIn(GetPlayerPed(-1), 1), 1)
            TriggerServerEvent("clp_mission:givemoneysociety", prix, "society_lscustoms")
            gain = prix
			Wait(3500)
			TriggerEvent('persistent-vehicles/forget-vehicle', entity)
			Wait(10)
			NetworkRequestControlOfEntity(entity)
			SetEntityAsMissionEntity(entity, true, true)
			Citizen.InvokeNative( 0xEA386986E786A54F, Citizen.PointerValueIntInitialized( entity ) )
			if (DoesEntityExist(entity)) then
				DeleteEntity(entity)
			end
			TriggerEvent('persistent-vehicles/forget-vehicle', flat)
			Wait(10)
			NetworkRequestControlOfEntity(flat)
			SetEntityAsMissionEntity(flat, true, true)
			Citizen.InvokeNative( 0xEA386986E786A54F, Citizen.PointerValueIntInitialized( entity ) )
			if (DoesEntityExist(flat)) then
				DeleteEntity(flat)
			end
        else 
            ShowAboveRadarMessage("~b~LsCustoms\n~s~Votre véhicule est trop abimé.")
            ESX.RemoveTimerBar()
            PlaySoundFrontend(-1, "Out_Of_Bounds_Timer", "DLC_HEISTS_GENERAL_FRONTEND_SOUNDS", 0)
            RemoveBlip(blip)
            SetBlipRoute(blip, 0)
            TaskVehicleTempAction(GetPlayerPed(-1), GetVehiclePedIsIn(GetPlayerPed(-1), 0), 6, 2000)
            Wait(2000)
            TaskLeaveAnyVehicle(GetPlayerPed(-1), 0, 0)
            SetVehicleDoorsLocked(GetVehiclePedIsIn(GetPlayerPed(-1), 1), 1)
            Wait(3500)
			TriggerEvent('persistent-vehicles/forget-vehicle', entity)
			Wait(10)
			NetworkRequestControlOfEntity(entity)
			SetEntityAsMissionEntity(entity, true, true)
			Citizen.InvokeNative( 0xEA386986E786A54F, Citizen.PointerValueIntInitialized( entity ) )
			if (DoesEntityExist(entity)) then
				DeleteEntity(entity)
			end
			TriggerEvent('persistent-vehicles/forget-vehicle', flat)
			Wait(10)
			NetworkRequestControlOfEntity(flat)
			SetEntityAsMissionEntity(flat, true, true)
			Citizen.InvokeNative( 0xEA386986E786A54F, Citizen.PointerValueIntInitialized( entity ) )
			if (DoesEntityExist(flat)) then
				DeleteEntity(flat)
			end
        end
    else
        ESX.RemoveTimerBar()
        PlaySoundFrontend(-1, "Out_Of_Bounds_Timer", "DLC_HEISTS_GENERAL_FRONTEND_SOUNDS", 0)
        RemoveBlip(blip)
        SetBlipRoute(blip, 0)
        ShowAboveRadarMessage("~b~LsCustoms\n~s~Ce n'est pas le bon véhicule.")
        TaskLeaveAnyVehicle(GetPlayerPed(-1), 0, 0)
        Wait(3500)
		TriggerEvent('persistent-vehicles/forget-vehicle', entity)
		Wait(10)
		NetworkRequestControlOfEntity(entity)
		SetEntityAsMissionEntity(entity, true, true)
		Citizen.InvokeNative( 0xEA386986E786A54F, Citizen.PointerValueIntInitialized( entity ) )
		if (DoesEntityExist(entity)) then
			DeleteEntity(entity)
		end
		TriggerEvent('persistent-vehicles/forget-vehicle', flat)
		Wait(10)
		NetworkRequestControlOfEntity(flat)
		SetEntityAsMissionEntity(flat, true, true)
		Citizen.InvokeNative( 0xEA386986E786A54F, Citizen.PointerValueIntInitialized( entity ) )
		if (DoesEntityExist(flat)) then
			DeleteEntity(flat)
		end
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
		elseif umyCNfj~=3 then
			doVehicleEntretien1(umyCNfj,YVLXYq)
		else 
			washVehicle(YVLXYq)
		end
	elseif Z65 ==4 then 
		if umyCNfj ~= 4 then 
			askVehInfo(umyCNfj,YVLXYq)
		elseif umyCNfj == 4 then 
			LivrerVehicule("Allez chercher le véhicule avec le Flatbed sur le parking.", VehSecur, possibleSpawn, stop, 500) 
		end
	elseif Z65 ==3 then
		if umyCNfj==3 then
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
		elseif umyCNfj==4 then
			flatbedveh(YVLXYq)
		elseif umyCNfj==5 then
			crochetagelVeh(YVLXYq)
		elseif umyCNfj==1 then
			SetEntityHeading(YVLXYq,GetEntityHeading(YVLXYq))
		else
			CreateFacture("society_lscustoms")
		end 
	end 
end
local DVs8kf2w={
	onSelected=O3_X,
	params={close=true},
	menu={ 
		{
			{name="Entretien du véhicule",icon="fas fa-car",cb=1},
			{name="Actions",icon="fas fa-location-arrow",cb=2},
			{name="Informations du véhicule",icon="fa fa-id-card",cb=3}
		},
		{
			{name="Réparer le moteur",icon="fas fa-wrench"},
			{name="Réparer la carrosserie",icon="fas fa-tools"},
			{name="Laver le véhicule",icon="fas fa-allergies"},
			{name="Réparer les pneus",icon="fa fa-dot-circle"},
			{name="Faire une annonce",icon="fab fa-affiliatetheme"}
		},
		{
			{name="Retourner le véhicule",icon="fas fa-undo"},
			{name="Créer une facture",icon="fas fa-file-invoice-dollar"},
			{name="Mettre le véhicule en fourrière",icon="fas fa-ban"},
			{name="Mettre le véhicule sur un Flatbed",icon="fas fa-car"},
			{name="Crocheter le véhicule",icon="fas fa-key"}
		},
		{
			{name="Immatriculation du véhicule",icon="fa fa-address-card"},
			{name="Etat du véhicule",icon="fas fa-heartbeat"},
			{name="Pièces du véhicule",icon="fa fa-chart-area"},
			{name="Mission",icon="fa fa-chart-area"}
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
			if IsControlJustReleased(0, 38) and ESX.PlayerData.job and ESX.PlayerData.job.name == 'lscustoms' then

				if CurrentAction == 'lscustoms_actions_menu' then
					OpenlscustomsActionsMenu()
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

		if ESX.PlayerData.job ~= nil and ESX.PlayerData.job.name == 'lscustoms' then
			RegisterControlKey("lscustomsnmenu","Ouvrir le menu lscustoms","F6",function()
				if ESX.PlayerData.job ~= nil and ESX.PlayerData.job.name == 'lscustoms' then
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


local function vestiaire(Ped, Select)
	if Select == 1 then 
		TriggerServerEvent("LsCustoms")
	end
end

local Vestiairehayes ={
    onSelected=vestiaire,
    params={close=true},
    menu={
        {
            {name="Commander sa tenue",icon="fab fa-affiliatetheme"}
        }
    }
}

local interval = 150

Citizen.CreateThread(function()
	while true do
		interval = 150
		local plyCoords = GetEntityCoords(GetPlayerPed(-1), false)
		local vestiaire = Vdist(plyCoords.x, plyCoords.y, plyCoords.z, -348.918, -170.0222, 39.0144)

		if vestiaire <= 8.0 then
			interval = 150
		end
		
		if vestiaire <= 7.0 then
			interval = 0
			DrawText3D(-348.918, -170.0222, 39.0144+0.50, 'Appuyez sur ~b~E~s~ pour accéder au ~b~Vestiaire~s~')
			DrawMarker(25, -348.918, -170.0222, 39.0144-0.98 , 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 1.0, 1.0, 1.0, 46, 134, 193, 120)
		end

		if vestiaire <= 1.5 then
			if IsControlJustReleased(0, 51) and ESX.PlayerData.job and ESX.PlayerData.job.name == 'lscustoms' then
				CreateRoue(Vestiairehayes)
			end
		end
		Wait(1)
	end
end)


