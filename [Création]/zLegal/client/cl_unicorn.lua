
local GUI = {}
GUI.Time = 0
local HasAlreadyEnteredMarker = false
local LastZone = nil
local CurrentAction = nil
local CurrentActionMsg = ''
local CurrentActionData = {}
local OnJob = false
local BlipsUnicorn = {}
local JobBlipsUnicorn = {}
local JobBlipsUnicorn2 = {}
local Blips2Unicorn = {}
local JobBlips2Unicorn = {}
local serviceuni = false

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

function OpenUnicornHarvestMenu()

	local elements = {
		{label = 'Houblon', value = 'harvest_houblon'}
	}

	ESX.UI.Menu.CloseAll()

	ESX.UI.Menu.Open(
		'default', GetCurrentResourceName(), 'unicorn_harvest',
		{
			css = 'unicorn',
			title = 'Ramasser du Houblon',
			elements = elements
		},
		function(data, menu)

			if data.current.value == 'harvest_houblon' then
				menu.close()
				TriggerServerEvent('clp_unicorn:startHarvestUnicorn')
			end

		end,
		function(data, menu)
			menu.close()
			CurrentAction = 'unicorn_harvest_menu'
			CurrentActionMsg = "Appuyez sur ~INPUT_CONTEXT~ pour ~g~commencer"
			CurrentActionData = {}
		end
	)
end

RegisterNetEvent('c_unicorn:usetenue')
AddEventHandler('c_unicorn:usetenue', function()
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
		serviceuni = true
		local clothesSkin = {
			['tshirt_1'] = 47,  ['tshirt_2'] = 0,
			['torso_1'] = 71,   ['torso_2'] = 0,
			['decals_1'] = 0,   ['decals_2'] = 0,
			['arms'] = 1,
			['pants_1'] = 37,   ['pants_2'] = 0,
			['shoes_1'] = 28,   ['shoes_2'] = 0,
			['helmet_1'] = -1,  ['helmet_2'] = 0,
			['bags_1'] = 0,
			['chain_1'] = 0,    ['chain_2'] = 0,
			['mask_1'] = 0,  ['mask_2'] = 0,
			['bproof_1'] = 0,  ['bproof_2'] = 0,
			}
			TriggerEvent('skinchanger:loadClothes', skin, clothesSkin)
		  else
			ExecuteCommand('me change sa tenue.')
			serviceuni = true
			local clothesSkin = {
				['tshirt_1'] = 42,  ['tshirt_2'] = 0,
				['torso_1'] = 6,   ['torso_2'] = 0,
				['decals_1'] = 0,   ['decals_2'] = 0,
				['arms'] = 1,
				['pants_1'] = 7,  ['pants_2'] = 0,
				['shoes_1'] = 25,   ['shoes_2'] = 0,
				['helmet_1'] = -1,  ['helmet_2'] = 0,
				['bags_1'] = 0,
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
		  serviceuni = false

          TriggerEvent('skinchanger:loadSkin', skin)
          TriggerEvent('esx:restoreLoadout')
		  --TriggerServerEvent("player:serviceOff", "police")
        end
      end)
    end)
  end
  UseTenu = not UseTenu
end)

function OpenUnicornHarvestMenu2()

	local elements = {
		{label = 'Malt', value = 'harvest_malt'}
	}

	ESX.UI.Menu.CloseAll()

	ESX.UI.Menu.Open(
		'default', GetCurrentResourceName(), 'unicorn_harvest2',
		{
			css = 'unicorn',
			title = 'Ramasser du malt',
			elements = elements
		},
		function(data, menu)

			if data.current.value == 'harvest_malt' then
				menu.close()
				TriggerServerEvent('clp_unicorn:startHarvestUnicorn2')
			end

		end,
		function(data, menu)
			menu.close()
			CurrentAction = 'unicorn_harvest_menu2'
			CurrentActionMsg = "Appuyez sur ~INPUT_CONTEXT~ pour ~g~commencer"
			CurrentActionData = {}
		end
	)
end

function OpenUnicornCraftMenu()

	local elements = {
		{label = 'Bière', value = 'craft_biere'},
		{label = 'Cocktail', value = 'craft_cocktail'},
		{label = 'Mojito', value = 'craft_mojito'},
		{label = 'Rhum', value = 'craft_rhum'}
	}

	ESX.UI.Menu.CloseAll()

	ESX.UI.Menu.Open(
		'default', GetCurrentResourceName(), 'unicorn_craft',
		{
			css = 'unicorn',
			title = 'Distillation',
			elements = elements
		},
		function(data, menu)

			if data.current.value == 'craft_biere' then
				menu.close()
				TriggerServerEvent('clp_unicorn:startCraftUnicorn')
			elseif data.current.value == 'craft_cocktail' then
				menu.close()
				TriggerServerEvent('clp_unicorn:startCraftUnicorn2')
			elseif data.current.value == 'craft_mojito' then
				menu.close()
				TriggerServerEvent('clp_unicorn:startCraftUnicorn3')
			elseif data.current.value == 'craft_rhum' then
				menu.close()
				TriggerServerEvent('clp_unicorn:startCraftUnicorn4')
			end
			
		end,
		function(data, menu)
			menu.close()
			CurrentAction = 'unicorn_craft_menu'
			CurrentActionMsg = "Appuyez sur ~INPUT_CONTEXT~ pour ~g~commencer"
			CurrentActionData = {}
		end
	)
end

local function selectunicornmenu(Ped, Select)
	if Select == 1 then 
		messageunicornnotfinish = true
		local amount = KeyboardInput("Annonce", "", 250)
		if amount ~= nil then
			amount = string.len(amount)
			if amount >= 10 then 
				TriggerServerEvent('clp_unicorn:annonceUnicorn',result)  
				messageunicornnotfinish = false
			else
				ESX.ShowNotification("~r~Votre message est trop court.")
			end
		end
	elseif Select == 2 then 
		CreateFacture("society_unicorn")
	end
end

local MenuUnicorn ={
    onSelected=selectunicornmenu,
    params={close=true},
    menu={
        {
            {name="Passer une annonce",icon="fab fa-affiliatetheme"},
            {name="Faire une facture",icon="fas fa-file-invoice-dollar"}
        }
    }
}

function OpenGetStocksUnicornMenu()

	ESX.TriggerServerCallback('clp_unicorn:getStockItemsUnicorn', function(items)

		print(json.encode(items))

		local elements = {}

		for i=1, #items, 1 do
			if items[i].count > 0 then
				table.insert(elements, {label = 'x' .. items[i].count .. ' ' .. items[i].label, value = items[i].name})
			end
		end

	  ESX.UI.Menu.Open(
	    'default', GetCurrentResourceName(), 'stocks_unicorn_menu',
	    {
	    	css = 'unicorn',
		    title = 'Galaxy Stock',
		    elements = elements
	    },
	    function(data, menu)

	    	local itemName = data.current.value

			local amount = KeyboardInput("Quantité", "", "", 8)
			if amount ~= nil then
				amount = tonumber(amount)
				if type(amount) == 'number' then
					TriggerServerEvent('clp_unicorn:getStockItemUnicorn', itemName, amount)
				end
				OpenGetStocksUnicornMenu()
			end

	    end,
	    function(data, menu)
	    	menu.close()
	    end
	  )

	end)
end

function OpenPutStocksUnicornMenu()

	ESX.TriggerServerCallback('clp_jobs:getPlayerInventory', function(inventory)
	
			local elements = {}
	
			for i=1, #inventory.items, 1 do
	
				local item = inventory.items[i]
	
				if item.count > 0 then
					table.insert(elements, {label = item.label .. ' x' .. item.count, type = 'item_standard', value = item.name})
				end
	
			end
	
			ESX.UI.Menu.Open(
				'default', GetCurrentResourceName(), 'stocks_menu_unicorn',
				{
					css = 'unicorn',
					title = 'Inventaire',
					elements = elements
				},function(data, menu)
				local itemName = data.current.value

			local amount = KeyboardInput("Quantité", "", "", 8)
			if amount ~= nil then
				amount = tonumber(amount)
				if type(amount) == 'number' then
					TriggerServerEvent('clp_unicorn:putStockItemsUnicorn', itemName, amount)
				end
				OpenPutStocksUnicornMenu()
			end
		end,function(data, menu)
					menu.close()
				end
			)
	
		end)
	
	end

RegisterNetEvent('esx:playerLoaded')
AddEventHandler('esx:playerLoaded', function(xPlayer)
	ESX.PlayerData = xPlayer
end)

RegisterNetEvent('esx:setJob')
AddEventHandler('esx:setJob', function(job)
	ESX.PlayerData.job = job
end)

function IsJobTrueUnicorn()
	if ESX.PlayerData ~= nil then
	  local IsJobTrueUnicorn = false
	  if ESX.PlayerData.job ~= nil and ESX.PlayerData.job.name == 'unicorn' then
		IsJobTrueUnicorn = true
	  end
	  return IsJobTrueUnicorn
	end
end
  
local poscircuitunicorn = {
	{x = 1835.11, y = 5042.02, z = 57.25},
	{x = 131.47, y = -1285.19, z = 28.3}
}

Citizen.CreateThread(function()
    for k in pairs(poscircuitunicorn) do
	local blip = AddBlipForCoord(poscircuitunicorn[k].x, poscircuitunicorn[k].y, poscircuitunicorn[k].z)
	SetBlipSprite(blip, 1)
	SetBlipScale(blip, 0.6)
	SetBlipColour(blip, 20)
	SetBlipAsShortRange(blip, true)
	BeginTextCommandSetBlipName("STRING")
	AddTextComponentString("Circuit Galaxy")
    EndTextCommandSetBlipName(blip)
    end
end)

AddEventHandler('clp_unicorn:hasEnteredMarkerUnicorn', function(zone)

	if zone == 'UnicornActions' then
		CurrentAction = 'unicorn_actions_menu'
		CurrentActionMsg = 'Appuyez sur ~INPUT_CONTEXT~ pour ~g~discuter'
		CurrentActionData = {}
	elseif zone == 'HarvestUnicorn' and not isNight() then
		CurrentAction = 'unicorn_harvest_menu'
		CurrentActionMsg = "Appuyez sur ~INPUT_CONTEXT~ pour ~g~commencer"
		CurrentActionData = {}
	elseif zone == 'HarvestUnicorn2' and not isNight() then
		CurrentAction = 'unicorn_harvest_menu2'
		CurrentActionMsg = "Appuyez sur ~INPUT_CONTEXT~ pour ~g~commencer"
		CurrentActionData = {}
	elseif zone == 'UnicornCraft' and serviceuni then
		CurrentAction = 'unicorn_craft_menu'
		CurrentActionMsg = "Appuyez sur ~INPUT_CONTEXT~ pour ~g~commencer"
		CurrentActionData = {}
	elseif zone == 'BossActionsUnicorn' and ESX.PlayerData.job.grade_name == 'boss' then
		CurrentAction = 'boss_unicorn_actions_menu'
		CurrentActionMsg = 'Appuyez sur ~INPUT_CONTEXT~ pour ~g~discuter'
		CurrentActionData = {}
	end
end)

AddEventHandler('clp_unicorn:hasExitedMarkerUnicorn', function(zone)

	if zone == 'UnicornCraft' then
		TriggerServerEvent('clp_unicorn:stopCraftUnicorn')
		TriggerServerEvent('clp_unicorn:stopCraftUnicorn2')
		TriggerServerEvent('clp_unicorn:stopCraftUnicorn3')
		TriggerServerEvent('clp_unicorn:stopCraftUnicorn4')
	elseif zone == 'HarvestUnicorn' then
		TriggerServerEvent('clp_unicorn:stopHarvestUnicorn')
	elseif zone == 'HarvestUnicorn2' then
		TriggerServerEvent('clp_unicorn:stopHarvestUnicorn2')
	end

	CurrentAction = nil
	ESX.UI.Menu.CloseAll()
end)


-- Display markers
Citizen.CreateThread(function()
	while true do		
		local attente = 500
		if ESX.PlayerData.job ~= nil and ESX.PlayerData.job.name == 'unicorn' then

			local coords = GetEntityCoords(GetPlayerPed(-1))
			
			for k,v in pairs(Config.Zones8) do
				if(v.Type ~= -1 and GetDistanceBetweenCoords(coords, v.Pos.x, v.Pos.y, v.Pos.z, true) < 10) and not IsPedInAnyVehicle(GetPlayerPed(-1), false) then
					attente = 1
					DrawMarker(v.Type, v.Pos.x, v.Pos.y, v.Pos.z, 0.0, 0.0, 0.0, 0, 0.0, 0.0, v.Size.x, v.Size.y, v.Size.z, v.Color.r, v.Color.g, v.Color.b, 100, false, true, 2, false, false, false, false)
				elseif IsPedInAnyVehicle(GetPlayerPed(-1), false) then 
					attente = 2500
				end
			end
		end
		Wait(attente)
	end
end)

Citizen.CreateThread(function()
	while true do		
		local attente = 500	
		if ESX.PlayerData.job ~= nil and ESX.PlayerData.job.name == 'unicorn' then
			local coords = GetEntityCoords(GetPlayerPed(-1))
			local isInMarker = false
			local currentZone = nil
			for k,v in pairs(Config.Zones8) do
				if(GetDistanceBetweenCoords(coords, v.Pos.x, v.Pos.y, v.Pos.z, true) < 5.5) then
					attente = 1
					isInMarker = true
					currentZone = k
				end
			end
			if (isInMarker and not HasAlreadyEnteredMarker) or (isInMarker and LastZone ~= currentZone) then
				attente = 1
				HasAlreadyEnteredMarker = true
				LastZone = currentZone
				TriggerEvent('clp_unicorn:hasEnteredMarkerUnicorn', currentZone)
			end
			if not isInMarker and HasAlreadyEnteredMarker then
				attente = 1
				HasAlreadyEnteredMarker = false
				TriggerEvent('clp_unicorn:hasExitedMarkerUnicorn', LastZone)
			end
		end
		Wait(attente)
	end
end)



-- Key Controls
Citizen.CreateThread(function()
    while true do
        local attente = 500

        if CurrentAction ~= nil then
            SetTextComponentFormat('STRING')
            AddTextComponentString(CurrentActionMsg)
			DisplayHelpTextFromStringLabel(0, 0, false, -1)
			attente = 5
            if IsControlJustReleased(1, 38) and ESX.PlayerData.job ~= nil and ESX.PlayerData.job.name == 'unicorn' then
                if CurrentAction == 'unicorn_harvest_menu' and not IsPedSittingInAnyVehicle(GetPlayerPed(-1)) and serviceuni then
					Citizen.Wait(5000)
					TriggerServerEvent('clp_unicorn:startHarvestUnicorn')
				elseif CurrentAction == 'unicorn_harvest_menu2' and not IsPedSittingInAnyVehicle(GetPlayerPed(-1)) and serviceuni then
					Citizen.Wait(5000)
					TriggerServerEvent('clp_unicorn:startHarvestUnicorn')
				elseif CurrentAction == 'boss_unicorn_actions_menu' then
                	OpenBossUnicornActionsMenu()
				elseif CurrentAction == 'unicorn_craft_menu' and not IsPedSittingInAnyVehicle(GetPlayerPed(-1)) and serviceuni then
					OpenUnicornCraftMenu()
                elseif CurrentAction == 'delete_unicorn_vehicle' and serviceuni then
                    local playerPed = GetPlayerPed(-1)
                    local vehicle = GetVehiclePedIsIn(playerPed,  false)
                    local hash = GetEntityModel(vehicle)
                    local plate = GetVehicleNumberPlateText(vehicle)
					if hash == GetHashKey('burrito3') or
					--hash == GetHashKey('brioso') or
					hash == GetHashKey('cognoscenti') then
                        if Config.MaxInService ~= -1 then
                          TriggerServerEvent('esx_service:disableService', 'unicorn')
						end
						TriggerEvent('persistent-vehicles/forget-vehicle', vehicle)
						Wait(50)
                        DeleteVehicle(vehicle)
                        	TriggerServerEvent('esx_vehiclelock:deletekeyjobs', 'no', plate) --vehicle lock
                    else
                        ESX.ShowNotification('Vous ne pouvez ranger que des ~b~véhicules de L\'Unicorn~s~.')
                    end
				end
                CurrentAction = nil               
            end
		end
		

		if ESX.PlayerData.job ~= nil and ESX.PlayerData.job.name == 'unicorn' then
			RegisterControlKey("unicornmenu","Ouvrir le menu galaxy","F6",function()
				if ESX.PlayerData.job ~= nil and ESX.PlayerData.job.name == 'unicorn' then
					if serviceuni then 
						CreateRoue(MenuUnicorn)
					else 
						ShowAboveRadarMessage("~r~Vous n'avez pas votre tenue de service.")
					end
				end
			end)
		end
		Wait(attente)
	end
end)


function OpenBossUnicornActionsMenu()

	local elements = {
		{label = 'Déposer Stock', value = 'put_stock_unicorn'},
		{label = 'Prendre Stock', value = 'get_stock_unicorn'},
		{label = '---------------', value = nil},
		{label = 'Action Patron', value = 'boss_unicorn_actions'}
	}

	ESX.UI.Menu.CloseAll()

	ESX.UI.Menu.Open(
		'default', GetCurrentResourceName(), 'boss_actions_unicorn',
		{
			css = 'unicorn',
			title = 'Boss',
			elements = elements
		},
		function(data, menu)

			if data.current.value == 'put_stock_unicorn' then
				OpenPutStocksUnicornMenu()
			elseif data.current.value == 'get_stock_unicorn' then
				OpenGetStocksUnicornMenu()
			elseif data.current.value == 'boss_unicorn_actions' then
				TriggerEvent('esx_society:openBossMenu', 'unicorn', function(data, menu)
					menu.close()
				end)
			end

		end,
		function(data, menu)
			menu.close()
			CurrentAction = 'boss_unicorn_actions_menu'
			CurrentActionMsg = 'Appuyez sur ~INPUT_CONTEXT~ pour ~g~discuter'
			CurrentActionData = {}
		end
	)
end

local function vestiaire(Ped, Select)
	if Select == 1 then 
		TriggerServerEvent("tenueunicorn")
	end
end

local Vestiaireunicorn ={
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
		local vestiaire = Vdist(plyCoords.x, plyCoords.y, plyCoords.z, 99.3611, -1311.995, 29.264)

		if vestiaire <= 8.0 then
			interval = 150
		end
		
		if vestiaire <= 7.0 then
			interval = 0
			DrawText3D(99.3611, -1311.995, 29.264+0.50, 'Appuyez sur ~b~E~s~ pour accéder au ~b~Vestiaire~s~')
			DrawMarker(25, 99.3611, -1311.995, 29.264-0.98 , 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 1.0, 1.0, 1.0, 46, 134, 193, 120)
		end

		if vestiaire <= 1.5 then
			if IsControlJustReleased(0, 51) and ESX.PlayerData.job and ESX.PlayerData.job.name == 'unicorn' then
				CreateRoue(Vestiaireunicorn)
			end
		end
		Wait(1)
	end
end)

Position = {
    {
        x = 109.6706, y = -1312.3670, z = 29.7485-0.98, a = 211.100, 
        ped = "csb_stripper_02",
    },
	{
		x = 106.897, y = -1314.041, z = 29.7485-0.98, a = 212.253,
		ped = "csb_stripper_02",
	},
	{
		x = 112.5222, y = -1310.632, z = 29.7483-0.98, a = 209.537,
		ped = "csb_stripper_02"
	},
}


Citizen.CreateThread(function()
    for k,v in pairs(Position) do
        RequestModel(GetHashKey(v.ped))
		while not HasModelLoaded(GetHashKey(v.ped)) do
            RequestModel(GetHashKey(v.ped))
			Wait(50)
		end
        local Ped = CreatePed(1, v.ped, v.x, v.y, v.z, v.a, false, false)
		loadDict('mp_safehouse')
        TaskPlayAnim(Ped, "mp_safehouse","lap_dance_girl", 8.0, -8.0, -1, 2, 0, false, false, false)
        SetEntityInvincible(Ped, true)
        SetEntityCanBeDamaged(Ped, true)



        SetBlockingOfNonTemporaryEvents(Ped, true)
        FreezeEntityPosition(Ped, true)
    end
end)


loadDict = function(dict)
    RequestAnimDict(dict)
    while not HasAnimDictLoaded(dict) do
        Wait(10)
    end
end
