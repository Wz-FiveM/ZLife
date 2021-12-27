ESX = nil
local CurrentActionData   = {}
local lastTime            = 0
local playerPed = GetPlayerPed(-1)

Citizen.CreateThread(function()
	while ESX == nil do
		TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
		Citizen.Wait(0)
	end
end)

local personalmenu = {}

------------------------------------------------------------------------------------
------------------------------------ Use Brolly ------------------------------------
------------------------------------------------------------------------------------

RegisterNetEvent('esx_useitem:brolly')
AddEventHandler('esx_useitem:brolly', function()
  local playerPed = GetPlayerPed(-1)
  local coords    = GetEntityCoords(playerPed)

	Citizen.CreateThread(function()
    
    local playerPed = GetPlayerPed(-1)
    local coords    = GetEntityCoords(playerPed)
    local boneIndex = GetPedBoneIndex(playerPed, 57005)
        
    RequestAnimDict('amb@code_human_wander_drinking@beer@male@base')
    
    while not HasAnimDictLoaded('amb@code_human_wander_drinking@beer@male@base') do
      Citizen.Wait(0)
    end
    
    ESX.Game.SpawnObject('p_amb_brolly_01', {
      x = coords.x,
      y = coords.y,
      z = coords.z + 2
    }, function(object)
    
    Citizen.CreateThread(function()
    
      AttachEntityToEntity(object, playerPed, boneIndex, 0.10, 0, -0.001, 80.0, 150.0, 200.0, true, true, false, true, 1, true)
      TaskPlayAnim(GetPlayerPed(-1), "amb@code_human_wander_drinking@beer@male@base", "static", 3.5, -8, -1, 49, 0, 0, 0, 0)
      Citizen.Wait(30000)
      DeleteObject(object)
      ClearPedSecondaryTask(playerPed)
      
     end)
    end)
  end)
end)

------------------------------------------------------------------------------------
------------------------------------ Use ROSE ------------------------------------
------------------------------------------------------------------------------------

RegisterNetEvent('esx_useitem:rose')
AddEventHandler('esx_useitem:rose', function()

  local playerPed = GetPlayerPed(-1)
  local coords    = GetEntityCoords(playerPed)

	Citizen.CreateThread(function()
    
    local playerPed = GetPlayerPed(-1)
    local coords    = GetEntityCoords(playerPed)
    local boneIndex = GetPedBoneIndex(playerPed, 57005)
        
    RequestAnimDict('amb@code_human_wander_drinking@beer@male@base')
    
    while not HasAnimDictLoaded('amb@code_human_wander_drinking@beer@male@base') do
      Citizen.Wait(0)
    end
    
    ESX.Game.SpawnObject('p_single_rose_s', {
      x = coords.x,
      y = coords.y,
      z = coords.z + 2
    }, function(object)
    
    Citizen.CreateThread(function()
    
      AttachEntityToEntity(object, playerPed, boneIndex, 0.10, 0, -0.001, 80.0, 150.0, 200.0, true, true, false, true, 1, true)
      TaskPlayAnim(GetPlayerPed(-1), "amb@code_human_wander_drinking@beer@male@base", "static", 3.5, -8, -1, 49, 0, 0, 0, 0)
      Citizen.Wait(30000)
      DeleteObject(object)
      ClearPedSecondaryTask(playerPed)
      
     end)
    end)
  end)
end)

---------------------------------------------------------------------------------------------
-------------------------------------------USE BONG -----------------------------------------
---------------------------------------------------------------------------------------------

RegisterNetEvent('esx_useitem:bong')
AddEventHandler('esx_useitem:bong', function()

  local playerPed = GetPlayerPed(-1)
  local coords    = GetEntityCoords(playerPed)

	Citizen.CreateThread(function()
    
    local playerPed  = GetPlayerPed(-1)
    local coords     = GetEntityCoords(playerPed)
    local boneIndex  = GetPedBoneIndex(playerPed, 18905)
    local boneIndex2 = GetPedBoneIndex(playerPed, 57005)

      RequestAnimDict('anim@safehouse@bong')
        
    while not HasAnimDictLoaded('anim@safehouse@bong') do
      Citizen.Wait(0)
    end
    
    ESX.Game.SpawnObject('hei_heist_sh_bong_01', {
      x = coords.x,
      y = coords.y,
      z = coords.z - 3
    }, function(object)

    ESX.Game.SpawnObject('p_cs_lighter_01', {
      x = coords.x,
      y = coords.y,
      z = coords.z - 3
    }, function(object2)
    
    Citizen.CreateThread(function()
    
      TaskPlayAnim(GetPlayerPed(-1), "anim@safehouse@bong", "bong_stage1", 3.5, -8, -1, 49, 0, 0, 0, 0)
      Citizen.Wait(1500)
      AttachEntityToEntity(object2, playerPed, boneIndex2, 0.10, 0.0, 0, 99.0, 192.0, 180.0, true, true, false, true, 1, true)
      AttachEntityToEntity(object, playerPed, boneIndex, 0.10, -0.25, 0, 95.0, 190.0, 180.0, true, true, false, true, 1, true)
      Citizen.Wait(6000)
      DeleteObject(object)
      DeleteObject(object2)
      ClearPedSecondaryTask(playerPed)
      TriggerServerEvent('esx_useitem:bong')
      end)
     end)
    end)
  end)
end)


-----------------------------------------------------------------------------------------------
------------------------------------------ OUTFIT SWIM ----------------------------------------
-----------------------------------------------------------------------------------------------
RegisterNetEvent('esx_useitem:swim')
AddEventHandler('esx_useitem:swim', function()
  maskdsq = not maskdsq
  local sqQ
  local playerPed = GetPlayerPed(-1)
  if maskdsq then 
    local B6zKxgVs,O3_X5=0,60*1000*10.02
    ESX.AddTimerBar("Oxygène :",{endTime=GetGameTimer()+O3_X5})
    local coords    = GetEntityCoords(playerPed)

    Citizen.CreateThread(function()
      
      local playerPed  = GetPlayerPed(-1)
      local coords     = GetEntityCoords(playerPed)
      local boneIndex  = GetPedBoneIndex(playerPed, 12844)
      local boneIndex2 = GetPedBoneIndex(playerPed, 24818)
      sqQ = true

      TriggerEvent('skinchanger:getSkin', function(skin)

        if skin.sex == 0 then
          ExecuteCommand('me change sa tenue.')
        local clothesSkin = {
          ['tshirt_1'] = 170,  ['tshirt_2'] = 0,
          ['shoes_1'] = 16,  ['shoes_2'] = 0,
          ['glasses_1'] = 26,  ['glasses_2'] = 0,
          ['mask_1'] = 171,  ['mask_2'] = 0
          }
          TriggerEvent('skinchanger:loadClothes', skin, clothesSkin)
        else
          ExecuteCommand('me change sa tenue.')
          local clothesSkin = {
            ['tshirt_1'] = 193,  ['tshirt_2'] = 0,
            ['shoes_1'] = 16,  ['shoes_2'] = 0,
            ['glasses_1'] = 28,  ['glasses_2'] = 0,
            ['mask_1'] = 159,  ['mask_2'] = 0
          }
          TriggerEvent('skinchanger:loadClothes', skin, clothesSkin)
        end
      end)
    
        Citizen.CreateThread(function()
          SetPedDiesInWater(playerPed, false)
          objectswim = object
          AttachEntityToEntity(object, playerPed, boneIndex, 0.0, 0.0, 0.0, 0.0, 90.0, 180.0, true, true, false, true, 1, true)
          SetEnableScuba(playerPed, true)
          SetEnableScubaGearLight(playerPed, true)
          ESX.ShowNotification('~b~Bouteille:\n~s~Vous avez ~g~équipé~s~ votre bouteille d\'oxygène.')
          Citizen.Wait(600000)
          if sqQ then 
          ESX.ShowNotification('~b~Bouteille:\n~r~Votre bouteille n\'a plus d\'oxygène.')
          ESX.TriggerServerCallback('esx_skin:getPlayerSkin', function(skin)
            TriggerEvent('skinchanger:loadSkin', skin)
          end)
          ESX.RemoveTimerBar()
          SetPedDiesInWater(playerPed, true)
          ClearPedSecondaryTask(playerPed)
          TriggerEvent("clp:removeitem", "mask_swim", 0)
          SetEnableScuba(playerPed, false)
          SetEnableScubaGearLight(playerPed, false)
        end
        end)
      end)
  elseif not maskdsq then 
    sqQ = false
    ESX.RemoveTimerBar()
    SetPedDiesInWater(playerPed, true)
    ClearPedSecondaryTask(playerPed)
    SetEnableScuba(playerPed, false)
    SetEnableScubaGearLight(playerPed, false)
    ESX.TriggerServerCallback('esx_skin:getPlayerSkin', function(skin)
      TriggerEvent('skinchanger:loadSkin', skin)
    end)
  end
end)

----------------------------------------------------------------------------------------------
---------------------------------------EAT SANDWICH ------------------------------------------
----------------------------------------------------------------------------------------------

RegisterNetEvent('esx_useitem:sandwich')
AddEventHandler('esx_useitem:sandwich', function()

  local playerPed = GetPlayerPed(-1)
  local coords    = GetEntityCoords(playerPed)

	Citizen.CreateThread(function()
    
    local playerPed  = GetPlayerPed(-1)
    local coords     = GetEntityCoords(playerPed)
    local boneIndex  = GetPedBoneIndex(playerPed, 18905)
    local boneIndex2 = GetPedBoneIndex(playerPed, 57005)

      RequestAnimDict('amb@code_human_wander_eating_donut@male@idle_a')
        
    while not HasAnimDictLoaded('amb@code_human_wander_eating_donut@male@idle_a') do
      Citizen.Wait(0)
    end
    
    ESX.Game.SpawnObject('prop_sandwich_01', {
      x = coords.x,
      y = coords.y,
      z = coords.z - 3
    }, function(object)

    
    Citizen.CreateThread(function()
    
      TaskPlayAnim(GetPlayerPed(-1), "amb@code_human_wander_eating_donut@male@idle_a", "idle_c", 3.5, -8, -1, 49, 0, 0, 0, 0)
      AttachEntityToEntity(object, playerPed, boneIndex2, 0.15, 0.01, -0.06, 185.0, 215.0, 180.0, true, true, false, true, 1, true)
      --Citizen.Wait(6500)
      DeleteObject(object)
      ClearPedSecondaryTask(playerPed)
      end)
    end)
  end)
end)

------------------------------------------------------------------------------------
------------------------------------ Use Tatgun ------------------------------------
------------------------------------------------------------------------------------

RegisterNetEvent('esx_useitem:tatgun')
AddEventHandler('esx_useitem:tatgun', function()

local playerPed = GetPlayerPed(-1)
local coords    = GetEntityCoords(playerPed)

Citizen.CreateThread(function()
  
  local playerPed = GetPlayerPed(-1)
  local coords    = GetEntityCoords(playerPed)
  local boneIndex = GetPedBoneIndex(playerPed, 11816)
  local boneIndex2 = GetPedBoneIndex(playerPed, 6286)
      
    RequestAnimDict('random@shop_tattoo')
      
  while not HasAnimDictLoaded('random@shop_tattoo') do
    Citizen.Wait(0)
  end

    ESX.Game.SpawnObject('v_ilev_ta_tatgun', {
      x = coords.x,
      y = coords.y,
      z = coords.z + 2
    }, function(object2)
  
      Citizen.CreateThread(function()

        AttachEntityToEntity(object2, playerPed, boneIndex2, 0.09, 0.11, 0.01, -75.0, -90.0, -140.0, true, true, false, true, 1, true)
        TaskPlayAnim(GetPlayerPed(-1), "random@shop_tattoo", "artist_artist_finishes_up_his_tattoo" ,3.5, -8, -1, 49, 0,false, false, false )
        Citizen.Wait(13000)
        DeleteObject(object)
        DeleteObject(object2) 
        ClearPedSecondaryTask(playerPed)
      end)
    end)
  end)
end)

-----------------------------------------------------------------------------------------------
--------------------------------------------- KIT PIC -----------------------------------------
-----------------------------------------------------------------------------------------------

RegisterNetEvent('esx_useitem:kitpic')
AddEventHandler('esx_useitem:kitpic', function()
  
    local playerPed = GetPlayerPed(-1)
    local coords    = GetEntityCoords(playerPed)

    ESX.ShowNotification("Vous avez ~g~déposé~s~ votre campement.")

    ESX.Game.SpawnObject('prop_yoga_mat_02',  {
      x = coords.x,
      y = coords.y,
      z = coords.z -1
    }, function(object)
    end)
    ESX.Game.SpawnObject('prop_yoga_mat_02',  {
      x = coords.x ,
      y = coords.y -0.9,
      z = coords.z -1
    }, function(object)
    end)
    ESX.Game.SpawnObject('prop_yoga_mat_02',  {
      x = coords.x ,
      y = coords.y +0.9,
      z = coords.z -1
    }, function(object)
    end)
    ESX.Game.SpawnObject('prop_beach_fire',  {
      x = coords.x +1.3,
      y = coords.y ,
      z = coords.z -1.6
    }, function(object)
    end)
    ESX.Game.SpawnObject('prop_skid_tent_01',  {
      x = coords.x -2.0,
      y = coords.y ,
      z = coords.z -2.0
    }, function(object)
    end)
    
end)

RegisterNetEvent("esx_useitem:Nightvision")
AddEventHandler("esx_useitem:Nightvision", function()
  nightvision = not nightvision
	if nightvision then
		SetNightvision(true)
		TriggerEvent('skinchanger:getSkin', function(skin)
			if skin.sex == 0 then
				local clothesSkin = {
            		['mask_1'] = 181, ['mask_2'] = 0
						}
			  TriggerEvent('skinchanger:loadClothes', skin, clothesSkin)
			else
				local clothesSkin = {
            		['mask_1'] = 169, ['mask_2'] 	= 0
        		}
				TriggerEvent('skinchanger:loadClothes', skin, clothesSkin)
			end
    	end)
    elseif not nightvision then 
		SetNightvision(false)
		TriggerEvent('skinchanger:getSkin', function(skin)
			if skin.sex == 0 then
				local clothesSkin = {
            		['mask_1'] = 0, ['mask_2'] = 0
						}
			  TriggerEvent('skinchanger:loadClothes', skin, clothesSkin)
			else
				local clothesSkin = {
            		['mask_1'] = 0, ['mask_2'] 	= 0
        		}
				TriggerEvent('skinchanger:loadClothes', skin, clothesSkin)
			end
    	end)
	end
end)

RegisterNetEvent('esx_useitem:ball')
  AddEventHandler('esx_useitem:ball', function()

    local playerPed = GetPlayerPed(-1)
    local coords    = GetEntityCoords(playerPed)

 ESX.Game.SpawnObject('prop_beach_volball01',  {
      x = coords.x +1.5,
      y = coords.y +1.5,
      z = coords.z -1
    }, function(object)
  end)

end)

RegisterNetEvent('esx_useitem:permis')
AddEventHandler('esx_useitem:permis', function()
  personalmenu.closestPlayer, personalmenu.closestDistance = ESX.Game.GetClosestPlayer()		
  if personalmenu.closestDistance ~= -1 and personalmenu.closestDistance <= 3.0 then
    TriggerServerEvent('jsfour-idcard:open', GetPlayerServerId(PlayerId()), GetPlayerServerId(personalmenu.closestPlayer), 'driver')
  else
    ESX.ShowNotification("~b~Distance\n~w~Rapprochez-vous.")
    TriggerServerEvent('jsfour-idcard:open', GetPlayerServerId(PlayerId()), GetPlayerServerId(PlayerId()), 'driver')
  end
end)

RegisterNetEvent('esx_useitem:permisarmes')
AddEventHandler('esx_useitem:permisarmes', function()
  personalmenu.closestPlayer, personalmenu.closestDistance = ESX.Game.GetClosestPlayer()		
  if personalmenu.closestDistance ~= -1 and personalmenu.closestDistance <= 3.0 then
    TriggerServerEvent('jsfour-idcard:open', GetPlayerServerId(PlayerId()), GetPlayerServerId(personalmenu.closestPlayer), 'weapon')
  else
    ESX.ShowNotification("~b~Distance\n~w~Rapprochez-vous.")
    TriggerServerEvent('jsfour-idcard:open', GetPlayerServerId(PlayerId()), GetPlayerServerId(PlayerId()), 'weapon')
  end
end)

RegisterNetEvent('esx_useitem:carteidentite')
AddEventHandler('esx_useitem:carteidentite', function()
  personalmenu.closestPlayer, personalmenu.closestDistance = ESX.Game.GetClosestPlayer()		
  if personalmenu.closestDistance ~= -1 and personalmenu.closestDistance <= 3.0 then
    TriggerServerEvent('jsfour-idcard:open', GetPlayerServerId(PlayerId()), GetPlayerServerId(personalmenu.closestPlayer))
  else
    ESX.ShowNotification("~b~Distance\n~w~Rapprochez-vous.")
    TriggerServerEvent('jsfour-idcard:open', GetPlayerServerId(PlayerId()), GetPlayerServerId(PlayerId()))
  end
end)
  
RegisterNetEvent('esx_objects:settenuehaz1')
AddEventHandler('esx_objects:settenuehaz1', function()
  if not UseTenu then
    cleanPlayer(playerPed)
    local dict, anim = "mp_clothing@female@shoes", "try_shoes_negative_a"
    ESX.Streaming.RequestAnimDict(dict)
    TaskPlayAnim(GetPlayerPed(-1),dict,anim,8.0, -8.0, -1, 0, 0, false, false, false)
    Citizen.Wait(6500)
    TriggerEvent('skinchanger:getSkin', function(skin)
      if skin.sex == 0 then
        ExecuteCommand('me change sa tenue.')
       local clothesSkin = {
        ['tshirt_1'] = 109, ['tshirt_2'] = 1,
        ['torso_1'] = 145, ['torso_2'] = 1,
        ['decals_1'] = 0,  ['decals_2'] = 0,
        ['mask_1'] = 95, ['mask_2'] = 0,
        ['arms'] = 22,
        ['pants_1'] = 71, ['pants_2'] = 1,
        ['shoes_1'] = 35, ['shoes_2'] = 0,
        ['helmet_1'] = -1, ['helmet_2'] = 0,
        ['bags_1'] = 0, ['bags_2'] = 0,
        ['bproof_1'] = 0,  ['bproof_2'] = 0
        }
        TriggerEvent('skinchanger:loadClothes', skin, clothesSkin)
      else
        ExecuteCommand('me change sa tenue.')
        local clothesSkin = {
        ['tshirt_1'] = 83, ['tshirt_2'] = 1,
        ['torso_1'] = 147, ['torso_2'] = 1,
        ['decals_1'] = 0,  ['decals_2'] = 0,
        ['mask_1'] = 83, ['mask_2'] = 0,
        ['arms'] = 49,
        ['pants_1'] = 72, ['pants_2'] = 1,
        ['shoes_1'] = 36, ['shoes_2'] = 0,
        ['helmet_1'] = -1, ['helmet_2'] = 0,
        ['bags_1'] = 0, ['bags_2'] = 0,
        ['bproof_1'] = 0,  ['bproof_2'] = 0
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
          TriggerEvent('skinchanger:loadSkin', skin)
          TriggerEvent('esx:restoreLoadout')
        end
      end)
    end)
  end
  UseTenu = not UseTenu
end)
RegisterNetEvent('esx_objects:settenuehaz2')
AddEventHandler('esx_objects:settenuehaz2', function()
  if not UseTenu then
    cleanPlayer(playerPed)
    local dict, anim = "mp_clothing@female@shoes", "try_shoes_negative_a"
    ESX.Streaming.RequestAnimDict(dict)
    TaskPlayAnim(GetPlayerPed(-1),dict,anim,8.0, -8.0, -1, 0, 0, false, false, false)
    Citizen.Wait(6500)
    TriggerEvent('skinchanger:getSkin', function(skin)
        if skin.sex == 0 then
          ExecuteCommand('me change sa tenue.')
            local clothesSkin = {
                ['tshirt_1'] = 109, ['tshirt_2'] = 3,
                ['torso_1'] = 145, ['torso_2'] = 3,
                ['decals_1'] = 0,  ['decals_2'] = 0,
                ['mask_1'] = 95, ['mask_2'] = 0,
                ['arms'] = 22,
                ['pants_1'] = 71, ['pants_2'] = 3,
                ['shoes_1'] = 35, ['shoes_2'] = 0,
                ['helmet_1'] = -1, ['helmet_2'] = 0,
                ['bags_1'] = 0, ['bags_2'] = 0,
                ['bproof_1'] = 0,  ['bproof_2'] = 0
            }
            TriggerEvent('skinchanger:loadClothes', skin, clothesSkin)
        else
          ExecuteCommand('me change sa tenue.')
            local clothesSkin = {
                ['tshirt_1'] = 83, ['tshirt_2'] = 3,
                ['torso_1'] = 147, ['torso_2'] = 3,
                ['decals_1'] = 0,  ['decals_2'] = 0,
                ['mask_1'] = 83, ['mask_2'] = 0,
                ['arms'] = 49,
                ['pants_1'] = 72, ['pants_2'] = 3,
                ['shoes_1'] = 36, ['shoes_2'] = 0,
                ['helmet_1'] = -1, ['helmet_2'] = 0,
                ['bags_1'] = 0, ['bags_2'] = 0,
                ['bproof_1'] = 0,  ['bproof_2'] = 0
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

          TriggerEvent('skinchanger:loadSkin', skin)
          TriggerEvent('esx:restoreLoadout')
        end
      end)
    end)
  end
  UseTenu = not UseTenu
end)

-- Jaune
RegisterNetEvent('esx_objects:settenuehaz3')
AddEventHandler('esx_objects:settenuehaz3', function()
  if not UseTenu then
    cleanPlayer(playerPed)
    local dict, anim = "mp_clothing@female@shoes", "try_shoes_negative_a"
    ESX.Streaming.RequestAnimDict(dict)
    TaskPlayAnim(GetPlayerPed(-1),dict,anim,8.0, -8.0, -1, 0, 0, false, false, false)
    Citizen.Wait(6500)
    TriggerEvent('skinchanger:getSkin', function(skin)
        if skin.sex == 0 then
          ExecuteCommand('me change sa tenue.')
            local clothesSkin = {
                ['tshirt_1'] = 109, ['tshirt_2'] = 2,
                ['torso_1'] = 145, ['torso_2'] = 2,
                ['decals_1'] = 0,  ['decals_2'] = 0,
                ['mask_1'] = 95, ['mask_2'] = 0,
                ['arms'] = 22,
                ['pants_1'] = 71, ['pants_2'] = 2,
                ['shoes_1'] = 35, ['shoes_2'] = 0,
                ['helmet_1'] = -1, ['helmet_2'] = 0,
                ['bags_1'] = 0, ['bags_2'] = 0,
                ['bproof_1'] = 0,  ['bproof_2'] = 0
            }
            TriggerEvent('skinchanger:loadClothes', skin, clothesSkin)
        else
          ExecuteCommand('me change sa tenue.')
            local clothesSkin = {
                ['tshirt_1'] = 83, ['tshirt_2'] = 2,
                ['torso_1'] = 147, ['torso_2'] = 2,
                ['decals_1'] = 0,  ['decals_2'] = 0,
                ['mask_1'] = 83, ['mask_2'] = 0,
                ['arms'] = 49,
                ['pants_1'] = 72, ['pants_2'] = 2,
                ['shoes_1'] = 36, ['shoes_2'] = 0,
                ['helmet_1'] = -1, ['helmet_2'] = 0,
                ['bags_1'] = 0, ['bags_2'] = 0,
                ['bproof_1'] = 0,  ['bproof_2'] = 0
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
          TriggerEvent('skinchanger:loadSkin', skin)
          TriggerEvent('esx:restoreLoadout')
        end
      end)
    end)
  end
  UseTenu  = not UseTenu
end)

-- Blanche
RegisterNetEvent('esx_objects:settenuehaz4')
AddEventHandler('esx_objects:settenuehaz4', function()
  if not UseTenu then
    cleanPlayer(playerPed)
    local dict, anim = "mp_clothing@female@shoes", "try_shoes_negative_a"
    ESX.Streaming.RequestAnimDict(dict)
    TaskPlayAnim(GetPlayerPed(-1),dict,anim,8.0, -8.0, -1, 0, 0, false, false, false)
    Citizen.Wait(6500)
    TriggerEvent('skinchanger:getSkin', function(skin)
        if skin.sex == 0 then
          ExecuteCommand('me change sa tenue.')
            local clothesSkin = {
                ['tshirt_1'] = 109, ['tshirt_2'] = 0,
                ['torso_1'] = 145, ['torso_2'] = 0,
                ['decals_1'] = 0, ['decals_2'] = 0,
                ['mask_1'] = 95, ['mask_2'] = 0,
                ['arms'] = 22,
                ['pants_1'] = 71, ['pants_2'] = 0,
                ['shoes_1'] = 35, ['shoes_2'] = 0,
                ['helmet_1'] = -1, ['helmet_2'] = 0,
                ['bags_1'] = 0, ['bags_2'] = 0,
                ['bproof_1'] = 0, ['bproof_2'] = 0
            }
            TriggerEvent('skinchanger:loadClothes', skin, clothesSkin)
        else
          ExecuteCommand('me change sa tenue.')
            local clothesSkin = {
                ['tshirt_1'] = 83, ['tshirt_2'] = 0,
                ['torso_1'] = 147, ['torso_2'] = 0,
                ['decals_1'] = 0, ['decals_2'] = 0,
                ['mask_1'] = 83, ['mask_2'] = 0,
                ['arms'] = 49,
                ['pants_1'] = 72, ['pants_2'] = 0,
                ['shoes_1'] = 36, ['shoes_2'] = 0,
                ['helmet_1'] = -1, ['helmet_2'] = 0,
                ['bags_1'] = 0, ['bags_2'] = 0,
                ['bproof_1'] = 0, ['bproof_2'] = 0
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

          TriggerEvent('skinchanger:loadSkin', skin)
          TriggerEvent('esx:restoreLoadout')
        end
      end)
    end)
  end
  UseTenu = not UseTenu
end)

--Tenue Jailer
RegisterNetEvent('esx_objects:settenuejailer')
AddEventHandler('esx_objects:settenuejailer', function()
  if not UseTenu then
    cleanPlayer(playerPed)
    local dict, anim = "mp_clothing@female@shoes", "try_shoes_negative_a"
    ESX.Streaming.RequestAnimDict(dict)
    TaskPlayAnim(GetPlayerPed(-1),dict,anim,8.0, -8.0, -1, 0, 0, false, false, false)
    Citizen.Wait(6500)
    TriggerEvent('skinchanger:getSkin', function(skin)
				if skin.sex == 0 then
          ExecuteCommand('me change sa tenue.')
					local clothesSkin = {
						['tshirt_1'] = 15, ['tshirt_2'] = 0,
						['torso_1'] = 68, ['torso_2'] = 0,
						['decals_1'] = 0, ['decals_2'] = 0,
						['arms'] = 0,
						['pants_1'] = 38, ['pants_2'] = 0,
						['shoes_1'] = 35, ['shoes_2'] = 0,
						['chain_1'] = 0, ['chain_2'] = 0
					}
					TriggerEvent('skinchanger:loadClothes', skin, clothesSkin)
				else
          ExecuteCommand('me change sa tenue.')
					local clothesSkin = {
						['tshirt_1'] = 3, ['tshirt_2'] = 0,
						['torso_1'] = 67, ['torso_2'] = 0,
						['decals_1'] = 0, ['decals_2'] = 0,
						['arms'] = 2,
						['pants_1'] = 41, ['pants_2'] = 0,
						['shoes_1'] = 35, ['shoes_2'] = 0,
						['chain_1'] = 0, ['chain_2'] = 0
					}
					TriggerEvent('skinchanger:loadClothes', skin, clothesSkin)
				end
				local playerPed = GetPlayerPed(-1)
				ClearPedBloodDamage(playerPed)
				ResetPedVisibleDamage(playerPed)
				ClearPedLastWeaponDamage(playerPed)
				ResetPedMovementClipset(playerPed, 0)
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

          TriggerEvent('skinchanger:loadSkin', skin)
          TriggerEvent('esx:restoreLoadout')
        end
      end)
    end)
  end
  UseTenu = not UseTenu
end)

function cleanPlayer(playerPed)
  SetPedArmour(playerPed, 0)
  ClearPedBloodDamage(playerPed)
  ResetPedVisibleDamage(playerPed)
  ClearPedLastWeaponDamage(playerPed)
  ResetPedMovementClipset(playerPed, 0)
end

