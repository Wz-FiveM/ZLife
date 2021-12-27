-- ESX = nil

-- Citizen.CreateThread(function()
--     while ESX == nil do
--     TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
--     Citizen.Wait(5000)
--     end
-- end)

-- local function SaveAccess()
--     TriggerEvent('skinchanger:getSkin', function(skin)
--         TriggerServerEvent('esx_skin:save', skin)
--         TriggerServerEvent('clp_access:savechapeau', skin)
--         TriggerServerEvent('clp_access:savelunettes', skin)
--         TriggerServerEvent('clp_access:saveoreillette', skin)
--         TriggerServerEvent('clp_access:savemasque', skin)
--     end)
-- end
-- local cam
-- local function vms5()
--     ClearPedTasks(PlayerPedId())
--     TriggerEvent('skinchanger:modelLoaded')
--     ESX.TriggerServerCallback('esx_skin:getPlayerSkin', function(skin)
--         TriggerEvent('skinchanger:loadSkin', skin)
--     end)
--     DestroyCam(cam)
--     RenderScriptCams(false, true, 500, false, false)
-- end
-- local function vms2()
--     Ta = GetPlayerPed(-1)
--     cam = CreateCam("DEFAULT_SCRIPTED_CAMERA", true)
--     SetCamRot(cam, 0.0, 0.0, 270.0, true)
--     local nArcvQl, h6Ub7U = GetEntityCoords(Ta), GetEntityHeading(Ta)
--     local Gm = h6Ub7U * math.pi / 180.0
--     SetCamCoord(cam, nArcvQl.x - 1.5 * math.sin(Gm), nArcvQl.y + 1.5 * math.cos(Gm), nArcvQl.z + .5)
--     SetCamRot(cam, .0, .0, 270.0, 2)
--     PointCamAtEntity(cam, Ta, .0, .0, .0, true)
--     SetCamActive(cam, true)
--     RenderScriptCams(1, 0, 500, 1, 0)
-- end
-- local h9dyA_4T = {24, 27, 178, 177, 189, 190, 187, 188, 202, 239, 240, 201, 172, 173, 174, 175}
-- local function vms6()
--     local XmVolesU=GetEntityCoords(GetPlayerPed(-1))
--     DrawMarker(0,XmVolesU+vector3(.0,.0,1.0),vector3(.0,.0,.0),vector3(0.0,0.0,0.0),.3,.3,0.15,31,157,224,150,false,true,true,false,false,false,false)
--     DisableAllControlActions(0)
--     for mCsewfX, yY in pairs(h9dyA_4T) do
--         EnableControlAction(0, yY, true)
--     end
--     local NzeoQJ, AwGfFV = IsDisabledControlPressed(1, 44), IsDisabledControlPressed(1, 51)
--     if NzeoQJ or AwGfFV then
--         local wCRY = PlayerPedId()
--         SetEntityHeading(PlayerPedId(),NzeoQJ and GetEntityHeading(wCRY) - 1.0 or AwGfFV and GetEntityHeading(wCRY) + 1.0)
--     end
-- end

 
-- local MasqueM = {
--     Base = { Title = "Coiffeur", Header = {"shopui_title_movie_masks", "shopui_title_movie_masks"}, HeaderColor = {255,255,255}},
--     Data = { currentMenu = "Catalogue :" },
--     Events = {
--         onOpened=vms2,
--         onRender=vms6,
--         onExited=vms5,
--         onSelected = function(self, _, btn, PMenu, menuData, currentButton, currentBtn, currentSlt, result, slide)
-- 			local slide, btn, check, closestPlayer, closestDistance, playerPed, coords = btn.slidenum, btn.name, btn.unkCheckbox, ESX.Game.GetClosestPlayer(), PlayerPedId(), GetEntityCoords(playerPed)

--             if btn == "Valider" then
--                 SaveAccess()
--                 TriggerServerEvent('clp_access:buyaccess')
--                 ShowAboveRadarMessage("~b~Vous avez acheter un masque.")
--                 CloseMenu(true)
--             end
--         end,
--         onSlide = function(menuData, btn, currentButton, currentSlt, slide, PMenu)
--             local currentMenu, currentBtn, slide, btn, ped = menuData.currentMenu, menuData.currentBtn, btn.slidenum, btn.name, GetPlayerPed(-1)
--             local coords = GetEntityCoords(GetPlayerPed(-1))

--             if btn == "Type du masque" and slide ~= -1 then
--                 mask = slide - 1
--                 SetCamCoord(cam, coords.x-2.0, coords.y-1.0, coords.z+0.5)
--                 SetCamFov(cam, 30.0)
--                 PointCamAtCoord(cam, coords.x, coords.y, coords.z+0.5)
--                 SetCamShakeAmplitude(cam, 13.0)
--                 RenderScriptCams(1, 1, 1500, 1, 1)
--                 TriggerEvent('skinchanger:change', 'mask_1', mask)
--             elseif btn == "Couleur du masque" and slide ~= -1 then
--                 mask2 = slide - 1
--                 SetCamCoord(cam, coords.x-2.0, coords.y-1.0, coords.z+0.5)
--                 SetCamFov(cam, 30.0)
--                 PointCamAtCoord(cam, coords.x, coords.y, coords.z+0.5)
--                 SetCamShakeAmplitude(cam, 13.0)
--                 RenderScriptCams(1, 1, 1500, 1, 1)
--                 TriggerEvent('skinchanger:change', 'mask_2', mask2)
--             end
--         end
--     },

--     Menu = {
--         ["Catalogue :"] = {
--             b = {
--                 {name = "Type du masque", slidemax = 233},
--                 {name = "Couleur du masque", slidemax = 25},
--                 {name = "Valider", ask = "~g~50$", askX = true}
--             }
--         }
--     }
-- }

-- local MasqueP = {
--     Base = { Title = "Coiffeur", Header = {"shopui_title_movie_masks", "shopui_title_movie_masks"}, HeaderColor = {255,255,255}},
--     Data = { currentMenu = "Catalogue :" },
--     Events = {
--         onOpened=vms2,
--         onRender=vms6,
--         onExited=vms5,
--         onSelected = function(self, _, btn, PMenu, menuData, currentButton, currentBtn, currentSlt, result, slide)
-- 			local slide, btn, check, closestPlayer, closestDistance, playerPed, coords = btn.slidenum, btn.name, btn.unkCheckbox, ESX.Game.GetClosestPlayer(), PlayerPedId(), GetEntityCoords(playerPed)

--             if btn == "Valider" then
--                 SaveAccess()
--                 TriggerServerEvent('clp_access:buyaccess')
--                 ShowAboveRadarMessage("~b~Vous avez acheter un masque.")
--                 CloseMenu(true)
--             end
--         end,
--         onSlide = function(menuData, btn, currentButton, currentSlt, slide, PMenu)
--             local currentMenu, currentBtn, slide, btn, ped = menuData.currentMenu, menuData.currentBtn, btn.slidenum, btn.name, GetPlayerPed(-1)
--             local coords = GetEntityCoords(GetPlayerPed(-1))

--             if btn == "Type du masque" and slide ~= -1 then
--                 mask = slide - 1
--                 SetCamCoord(cam, coords.x-2.0, coords.y-1.0, coords.z+0.5)
--                 SetCamFov(cam, 30.0)
--                 PointCamAtCoord(cam, coords.x, coords.y, coords.z+0.5)
--                 SetCamShakeAmplitude(cam, 13.0)
--                 RenderScriptCams(1, 1, 1500, 1, 1)
--                 TriggerEvent('skinchanger:change', 'tshirt_1', mask)
--             elseif btn == "Couleur du masque" and slide ~= -1 then
--                 mask2 = slide - 1
--                 SetCamCoord(cam, coords.x-2.0, coords.y-1.0, coords.z+0.5)
--                 SetCamFov(cam, 30.0)
--                 PointCamAtCoord(cam, coords.x, coords.y, coords.z+0.5)
--                 SetCamShakeAmplitude(cam, 13.0)
--                 RenderScriptCams(1, 1, 1500, 1, 1)
--                 TriggerEvent('skinchanger:change', 'tshirt_2', mask2)
--             end
--         end
--     },

--     Menu = {
--         ["Catalogue :"] = {
--             b = {
--                 {name = "Type du masque", slidemax = 233},
--                 {name = "Couleur du masque", slidemax = 25},
--                 {name = "Valider", ask = "~g~50$", askX = true}
--             }
--         }
--     }
-- }

-- local maskpos = {
--     {x = -1337.68,  y = -1277.92,  z = 4.88}
-- }

-- Citizen.CreateThread(function()
--     while true do
--         local attente = 500

--         for k, v in pairs(maskpos) do

--             local plyCoords = GetEntityCoords(GetPlayerPed(-1), false)
--             local dist = Vdist(plyCoords.x, plyCoords.y, plyCoords.z, maskpos[k].x, maskpos[k].y, maskpos[k].z)

--             if dist <= 2.5 then
--                 attente = 5
--                 DrawText3D(maskpos[k].x, maskpos[k].y, maskpos[k].z+0.2, "Appuyez sur ~b~E ~w~pour accéder au ~p~Magasin de masque~w~.", 9)
--                 if IsControlJustPressed(1,51) then 	
--                     TriggerEvent('skinchanger:getSkin', function(skin)
--                         if skin.sex > 1 then
--                             TriggerEvent("randPickupAnim")
--                             CreateMenu(MasqueP)
--                         else
--                             TriggerEvent("randPickupAnim")
-- 							CreateMenu(MasqueM)
--                         end
--                     end)
--                 end
--             end
--         end

--         Wait(attente)
--     end
-- end)

-- Heap = {}


-- Initialized = function()
--     CreateBarber()
-- end

-- Shop = {
--     Price = 250,

--     Barber = {
--         Model = GetHashKey("s_m_m_hairdress_01"),
--         Location = vector3(-815.86, -183.75, 36.5689),
--         Heading = 132.08
--     },

--     Scissors = {
--         Model = GetHashKey("p_cs_scissors_s"),
--         Location = vector3(0.0, 0.0, 0.0)
--     },

--     Scene = {
--         Location = vector3(-816.22, -182.97, 36.57)
--     },

--     HelpText = {
--         {
--             Label = "Hair Type",
--             Component = "hair_1"
--         },
--         {
--             Label = "Hair Style",
--             Component = "hair_2"
--         },
--         {
--             Label = "Hair Color",
--             Component = "hair_color_1"
--         },
--         {
--             Label = "Hair Loops",
--             Component = "hair_color_2"
--         },
--         {
--             Label = "Beard Type",
--             Component = "beard_1"
--         },
--         {
--             Label = "Beard Visibility",
--             Component = "beard_2"
--         },
--         {
--             Label = "Beard Color",
--             Component = "beard_3"
--         },
--         {
--             Label = "Beard Loops",
--             Component = "beard_4"
--         },
--         {
--             Label = "Eyebrow Type",
--             Component = "eyebrows_1"
--         },
--         {
--             Label = "Eyebrow Visibility",
--             Component = "eyebrows_2"
--         },
--         {
--             Label = "Eyebrow Color",
--             Component = "eyebrows_3"
--         },
--         {
--             Label = "Eyebrow Loops",
--             Component = "eyebrows_4"
--         }
--     }
-- }

-- GlobalFunction = function(eventName, eventData)
--     local globalOptions = {
--         Event = eventName,
--         Data = eventData
--     }

--     TriggerServerEvent("james_barbershop:globalEvent", globalOptions)
-- end

-- FetchBusyState = function()
--     ESX.TriggerServerCallback("james_barbershop:fetchBusyState", function(busyState)
--         Heap.Busy = busyState
--     end)
-- end

-- CreateBarber = function()
--     if IsEntityAMissionEntity(Heap.Barber) then return end
--     local barber = Shop.Barber
--     local scissors = Shop.Scissors

--     local barberBlip = AddBlipForCoord(barber.Location)

--     SetBlipSprite(barberBlip, 71)
--     SetBlipScale(barberBlip, 0.8)
--     SetBlipColour(barberBlip, 2)
--     SetBlipAsShortRange(barberBlip, true)
--     BeginTextCommandSetBlipName("STRING")
--     AddTextComponentString("Hairdresser")
--     EndTextCommandSetBlipName(barberBlip)

--     LoadModels({
--         barber.Model,
--         scissors.Model
--     })

--     --Heap.Barber = CreatePed(5, barber.Model, barber.Location, barber.Heading, false)
--     Heap.Barber = GetClosestPed2(GetEntityCoords(GetPlayerPed(-1)),2.2)
--     Heap.Scissors = CreateObject(scissors.Model, scissors.Location)

--     Heap.Cam = CreateCam("DEFAULT_ANIMATED_CAMERA", false)

--     SetPedKeepTask(Heap.Barber, false)
--     TaskSetBlockingOfNonTemporaryEvents(Heap.Barber, false)
--     SetEntityInvincible(Heap.Barber, false)
--     SetEntityAsMissionEntity(Heap.Barber,true,true)
--     TaskSetBlockingOfNonTemporaryEvents(Heap.Barber, true)

--     CleanupModels({
--         barber.Model,
--         scissors.Model
--     })
-- end

-- EnterBarber = function()
--     LoadModels({
--         "misshair_shop@hair_dressers"
--     })

--     DisplayRadar(false)

--     GlobalFunction("CHAIR_BUSY", true)

--     PlayCamAnimation("cam_enterchair")

--     GlobalFunction("SYNC_ANIMATION", {
--         Animation = "keeper_enterchair",
--         SceneHash = -1056964608,
--         ClearTasks = true
--     })

--     TaskPlayAnimAdvanced(Heap.Ped, "misshair_shop@hair_dressers", "player_enterchair", Shop.Scene.Location, vector3(0.0, 0.0, (Calculation(-2.6) - 90.0)), 1000.0, -1000.0, -1, 5642, 0.0, 2, 1)

--     WaitForAnimation("player_enterchair")

--     GlobalFunction("SYNC_ANIMATION", {
--         Animation = "keeper_idle_a",
--         SceneHash = -1056964608,
--         Looped = true
--     })

--     ChooseHaircut()

--     CleanupModels({
--         "misshair_shop@hair_dressers"
--     })
-- end
-- ExitChair = function()

--     PlayCamAnimation("cam_exitchair")

--     GlobalFunction("SYNC_ANIMATION", {
--         Animation = "keeper_exitchair",
--         SceneHash = -1056964608,
--         ClearTasks = true
--     })

--     TaskPlayAnimAdvanced(Heap.Ped, "misshair_shop@hair_dressers", "player_exitchair", Shop.Scene.Location, vector3(0.0, 0.0, (Calculation(-2.6) - 90.0)), 1000.0, -2.0, -1, 37896, 0.0, 2, 1)

--     WaitForAnimation("player_exitchair")

--     RenderScriptCams(false, true, 1000)

--     DestroyAllCams(true)

--     DisplayRadar(true)

--     GlobalFunction("CHAIR_BUSY", false)
-- end
-- local function vms6()
--     local XmVolesU=GetEntityCoords(GetPlayerPed(-1))
--     DrawMarker(0,XmVolesU+vector3(.0,.0,1.0),vector3(.0,.0,.0),vector3(0.0,0.0,0.0),.3,.3,0.15,31,157,224,150,false,true,true,false,false,false,false)
-- end
-- local BarberNoPe = {
--     Base = { Title = "Coiffeur", Header = {"shopui_title_barber3", "shopui_title_barber3"}, Blocked = true, HeaderColor = {255,255,255}},
--     Data = { currentMenu = "Catalogue :" },
--     Events = {
--         onSelected = function(self, _, btn, PMenu, menuData, currentButton, currentBtn, currentSlt, result, slide)
-- 			local slide, btn, check, closestDistance, playerPed, coords = btn.slidenum, btn.name, btn.unkCheckbox, PlayerPedId(), GetEntityCoords(playerPed)

--             if btn == "Valider" then
--                 TriggerEvent('skinchanger:getSkin', function(skin)
--                     TriggerServerEvent('esx_skin:save', skin)
--                 end)
--                 Wait(250)
--                 GetHaircut()
--                 CloseMenu(true)
--             end
--         end,
--         onSlide = function(menuData, btn, currentButton, currentSlt, slide, PMenu)
--             local currentMenu, currentBtn, slide, btn, ped = menuData.currentMenu, menuData.currentBtn, btn.slidenum, btn.name, GetPlayerPed(-1)
--             local coords = GetEntityCoords(GetPlayerPed(-1))

--             if btn == "Coiffures" and slide ~= -1 then
--                 coupe = slide - 1
--                 TriggerEvent('skinchanger:change', 'hair_1', coupe)
--             elseif btn == "Teintures" and slide ~= -1 then
--                 teinture1 = slide - 1
--                 TriggerEvent('skinchanger:change', 'hair_color_1', teinture1)
--             elseif btn == "Barbes" and slide ~= -1 then
--                 barbe = slide - 1
--                 TriggerEvent('skinchanger:change', 'beard_1', barbe)
--             elseif btn == "Opacité" and slide ~= -1 then
--                 tbarbe = slide - 1
--                 TriggerEvent('skinchanger:change', 'beard_2', tbarbe)
--             elseif btn == "Teintures de la barbe" and slide ~= -1 then
--                 teinture1b = slide - 1
--                 RenderScriptCams(1, 1, 1500, 1, 1)
--                 TriggerEvent('skinchanger:change', 'beard_3', teinture1b)
--             elseif btn == "Sourcil" and slide ~= -1 then
--                 sourcil = slide - 1
--                 TriggerEvent('skinchanger:change', 'eyebrows_1', sourcil)
--             elseif btn == "Opacité des sourcils" and slide ~= -1 then
--                 osourcils = slide - 1
--                 TriggerEvent('skinchanger:change', 'eyebrows_2', osourcils)
--             elseif btn == "Teintures des sourcils" and slide ~= -1 then
--                 teintsourcil = slide - 1
--                 TriggerEvent('skinchanger:change', 'eyebrows_3', teintsourcil)
--             elseif btn == "Maquillage " and slide ~= -1 then
--                 maquillage = slide - 1
--                 TriggerEvent('skinchanger:change', 'makeup_1', maquillage)
--             elseif btn == "Opacité " and slide ~= -1 then
--                 tmaquillage = slide - 1
--                 TriggerEvent('skinchanger:change', 'makeup_2', tmaquillage)
--             elseif btn == "Couleur" and slide ~= -1 then
--                 cmaquillage = slide - 1
--                 TriggerEvent('skinchanger:change', 'makeup_4', cmaquillage)
--             end
--         end
--     },

--     Menu = {
--         ["Catalogue :"] = {
--             b = {
--                 {name = "Cheveux", ask = ">", askX = true},
--                 {name = "Barbe", ask = ">", askX = true},
--                 {name = "Sourcils", ask = ">", askX = true},
--                 {name = "Maquillage", ask = ">", askX = true},
--                 {name = "Valider", ask = "~g~50$", askX = true}
--             }
--         },
--         ["cheveux"] = {
--             b = {
--                 {name = "Coiffures", slidemax = 97},
--                 {name = "Teintures", slidemax = 63},
--             }
--         },
--         ["barbe"] = {
--             b = {
--                 {name = "Barbes", slidemax = 28},
--                 {name = "Opacité", slidemax = 10},
--                 {name = "Teintures de la barbe", slidemax = 63},
--             }
--         },
--         ["sourcils"] = {
--             b = {
--                 {name = "Sourcil", slidemax = 33},
--                 {name = "Opacité des sourcils", slidemax = 10},
--                 {name = "Teintures des sourcils", slidemax = 63},
--             }
--         },
--         ["maquillage"] = {
--             b = {
--                 {name = "Maquillage ", slidemax = 71},
--                 {name = "Opacité ", slidemax = 10},
--                 {name = "Couleur", slidemax = 63},
--             }
--         },
--     }
-- }

-- ChooseHaircut = function()
--     TriggerEvent("skinchanger:getSkin", function(skin)
--         Heap.LastSkin = json.encode(skin)
--         Heap.NewSkin = skin
--     end)

--     local maxValues = GetMaxValues()

--     local currentComponent = 1

--     CreateMenu(BarberNoPe)
-- end

-- GetHaircut = function()
--     TriggerEvent('skinchanger:getSkin', function(skin)
--         TriggerServerEvent('esx_skin:save', skin)
--     end)

--     PlayCamAnimation("cam_hair_cut_a")

--     GlobalFunction("SYNC_ANIMATION", {
--         Animation = "keeper_hair_cut_a",
--         SceneHash = -1056964608,
--         ClearTasks = true
--     })

--     TaskPlayAnimAdvanced(Heap.Ped,"misshair_shop@hair_dressers", "player_base", Shop.Scene.Location, vector3(0.0, 0.0, (Calculation(-2.6) - 90.0)), 1000.0, -1000.0, -1, 5643, 0.0, 2, 1)

--     GlobalFunction("SYNC_PARTICLE", {
--         Net = PedToNet(Heap.Ped),
--         Skin = Heap.NewSkin
--     })

--     WaitForAnimation("keeper_hair_cut_a")

--     ExitChair()

--     TriggerServerEvent("james_barbershop:payment")
-- end

-- PlayDresserAnimation = function(pedHandle, animName, sceneHash, sceneLooped, clearTasks)
--     local animDict = "misshair_shop@hair_dressers"

--     while not RequestAmbientAudioBank("SCRIPT\\Hair_Cut", 0) do
--         Citizen.Wait(0)
--     end

--     LoadModels({
--         animDict
--     })

--     if clearTasks then
--         N_0xf1c03a5352243a30(pedHandle)
--         ClearPedTasksImmediately(pedHandle)
--     end

--     local scene = CreateSynchronizedScene(Shop.Scene.Location, vector3(0.0, 0.0, (Calculation(-2.6) - 90.0)), 2)

--     TaskSynchronizedScene(pedHandle, scene, animDict, animName, 1000.0, sceneHash, 0, 0, 1148846080, 0)
--     SetSynchronizedSceneOcclusionPortal(scene, not sceneLooped)
--     SetSynchronizedSceneLooped(scene, sceneLooped)
--     N_0x2208438012482a1a(pedHandle, false, false)

--     if DoesEntityExist(Heap.Scissors) then
--         local scissorsAnimation = GetScissorsAnimation(animName)

--         PlaySynchronizedEntityAnim(Heap.Scissors, scene, scissorsAnimation, animDict, 1000.0, -1000.0, 0, 1148846080)
--         ForceEntityAiAndAnimationUpdate(Heap.Scissors)
--     end

--     local speech = GetSpeech(animName)

--     if speech then
--         PlayAmbientSpeech1(Heap.Barber, speech, "SPEECH_PARAMS_FORCE")
--     end

--     Heap.Scene = scene

--     CleanupModels({
--         animDict
--     })
-- end

-- PlayCamAnimation = function(camAnimation)
--     if not DoesCamExist(Heap.Cam) then
--         Heap.Cam = CreateCam("DEFAULT_ANIMATED_CAMERA", false)
--     end

--     PlayCamAnim(Heap.Cam, camAnimation, "misshair_shop@hair_dressers", Shop.Scene.Location, vector3(0.0, 0.0, (Calculation(-2.6) - 90.0)), false, 2)
--     SetCamActive(Heap.Cam, true)
--     RenderScriptCams(true, false, 3000, true, false, false)
-- end

-- ApplyNewSkin = function()
--     TriggerEvent("skinchanger:loadSkin", Heap.NewSkin)
-- end

-- GetSpeech = function(animName)
--     if animName == "keeper_base" then
--         return "scissors_base"
--     elseif animName == "keeper_enterchair"then
--         return "SHOP_HAIR_WHAT_WANT"
--     elseif animName == "keeper_exitchair" then
--         return "SHOP_GOODBYE"
--     elseif animName == "keeper_idle_a" then
--         return "SHOP_HAIR_WHAT_WANT"
--     elseif animName == "keeper_idle_b" then
--         return "SHOP_HAIR_WHAT_WANT"
--     elseif animName == "keeper_idle_c" then
--         return "SHOP_HAIR_WHAT_WANT"
--     elseif animName == "keeper_hair_cut_a" then
--         return "SHOP_CUTTING_HAIR"
--     elseif animName == "keeper_hair_cut_b" then
--         return "SHOP_CUTTING_HAIR"
--     end
-- end

-- GetScissorsAnimation = function(animName)
--     if animName == "keeper_base" then
--         return "scissors_base"
--     elseif animName == "keeper_enterchair"then
--         return "scissors_enterchair"
--     elseif animName == "keeper_exitchair" then
--         return "scissors_exitchair"
--     elseif animName == "keeper_idle_a" then
--         return "scissors_idle_a"
--     elseif animName == "keeper_idle_b" then
--         return "scissors_idle_b"
--     elseif animName == "keeper_idle_c" then
--         return "scissors_idle_c"
--     elseif animName == "keeper_hair_cut_a" then
--         return "scissors_hair_cut_a"
--     elseif animName == "keeper_hair_cut_b" then
--         return "scissors_hair_cut_b"
--     end
-- end

-- GetMaxValues = function()
--     local data = {
--         beard_1 = GetNumHeadOverlayValues(1) - 1,
--         beard_2 = 10,
--         beard_3 = GetNumHairColors() - 1,
--         beard_4 = GetNumHairColors() - 1,
--         hair_1 = GetNumberOfPedDrawableVariations(Heap.Ped, 2) - 1,
--         hair_2 = GetNumberOfPedTextureVariations(Heap.Ped, 2, Heap.NewSkin.hair_1) - 1,
--         hair_color_1 = GetNumHairColors() - 1,
--         hair_color_2 = GetNumHairColors() - 1,
--         eye_color = 31,
--         eyebrows_1 = GetNumHeadOverlayValues(2) - 1,
--         eyebrows_2 = 10,
--         eyebrows_3 = GetNumHairColors() - 1,
--         eyebrows_4 = GetNumHairColors() - 1,
--         makeup_1 = GetNumHeadOverlayValues(4) - 1,
--         makeup_2 = 10,
--         makeup_3 = GetNumHairColors() - 1,
--         makeup_4 = GetNumHairColors() - 1
--     }

--     return data
-- end

-- WaitForAnimation = function(animName)
--     local started = GetGameTimer()

--     local animDuration = (GetAnimDuration("misshair_shop@hair_dressers", animName) * 1000) + 100

--     while GetGameTimer() - started < animDuration do
--         Citizen.Wait(0)
--     end
-- end

-- Calculation = function(number)
--     return number * 57.29578
-- end

-- DrawButtons = function(buttonsToDraw)
-- 	local instructionScaleform = RequestScaleformMovie("instructional_buttons")

-- 	while not HasScaleformMovieLoaded(instructionScaleform) do
-- 		Wait(0)
-- 	end

-- 	PushScaleformMovieFunction(instructionScaleform, "CLEAR_ALL")
-- 	PushScaleformMovieFunction(instructionScaleform, "TOGGLE_MOUSE_BUTTONS")
-- 	PushScaleformMovieFunctionParameterBool(0)
-- 	PopScaleformMovieFunctionVoid()

-- 	for buttonIndex, buttonValues in ipairs(buttonsToDraw) do
-- 		PushScaleformMovieFunction(instructionScaleform, "SET_DATA_SLOT")
-- 		PushScaleformMovieFunctionParameterInt(buttonIndex - 1)

-- 		PushScaleformMovieMethodParameterButtonName(buttonValues["button"])
-- 		PushScaleformMovieFunctionParameterString(buttonValues["label"])
-- 		PopScaleformMovieFunctionVoid()
-- 	end

-- 	PushScaleformMovieFunction(instructionScaleform, "DRAW_INSTRUCTIONAL_BUTTONS")
-- 	PushScaleformMovieFunctionParameterInt(-1)
-- 	PopScaleformMovieFunctionVoid()
-- 	DrawScaleformMovieFullscreen(instructionScaleform, 255, 255, 255, 255)
-- end

-- DrawBusySpinner = function(text)
--     SetLoadingPromptTextEntry("STRING")
--     AddTextComponentSubstringPlayerName(text)
--     ShowLoadingPrompt(3)
-- end

-- PlayAnimation = function(ped, dict, anim, settings)
-- 	if dict then
--         RequestAnimDict(dict)

--         while not HasAnimDictLoaded(dict) do
--             Citizen.Wait(0)
--         end

--         if settings == nil then
--             TaskPlayAnim(ped, dict, anim, 1.0, -1.0, 1.0, 0, 0, 0, 0, 0)
--         else
--             local speed = 1.0
--             local speedMultiplier = -1.0
--             local duration = 1.0
--             local flag = 0
--             local playbackRate = 0

--             if settings["speed"] then
--                 speed = settings["speed"]
--             end

--             if settings["speedMultiplier"] then
--                 speedMultiplier = settings["speedMultiplier"]
--             end

--             if settings["duration"] then
--                 duration = settings["duration"]
--             end

--             if settings["flag"] then
--                 flag = settings["flag"]
--             end

--             if settings["playbackRate"] then
--                 playbackRate = settings["playbackRate"]
--             end

--             TaskPlayAnim(ped, dict, anim, speed, speedMultiplier, duration, flag, playbackRate, 0, 0, 0)

--             while not IsEntityPlayingAnim(ped, dict, anim, 3) do
--                 Citizen.Wait(0)
--             end
--         end

--         RemoveAnimDict(dict)
-- 	else
-- 		TaskStartScenarioInPlace(ped, anim, 0, true)
-- 	end
-- end

-- LoadModels = function(models)
-- 	for index, model in ipairs(models) do
-- 		if IsModelValid(model) then
-- 			while not HasModelLoaded(model) do
-- 				RequestModel(model)

-- 				Citizen.Wait(10)
-- 			end
-- 		else
-- 			while not HasAnimDictLoaded(model) do
-- 				RequestAnimDict(model)

-- 				Citizen.Wait(10)
-- 			end
-- 		end
-- 	end
-- end

-- CleanupModels = function(models)
-- 	for index, model in ipairs(models) do
-- 		if IsModelValid(model) then
-- 			SetModelAsNoLongerNeeded(model)
-- 		else
-- 			RemoveAnimDict(model)
-- 		end
-- 	end
-- end

-- DrawScriptMarker = function(markerData)
--     DrawMarker(markerData["type"] or 1, markerData["pos"] or vector3(0.0, 0.0, 0.0), 0.0, 0.0, 0.0, (markerData["type"] == 6 and -90.0 or markerData["rotate"] and -180.0) or 0.0, 0.0, 0.0, markerData["size"] or vector3(1.0, 1.0, 1.0), markerData["rgb"] or vector3(255, 255, 255), 100, markerData["bob"] and true or false, true, 2, false, false, false, false)
-- end

-- DrawScriptText = function(coords, text)
--     local onScreen, _x, _y = World3dToScreen2d(coords.x, coords.y, coords.z)
--     local px, py, pz = table.unpack(GetGameplayCamCoords())

--     SetTextScale(0.35, 0.35)
--     SetTextFont(4)
--     SetTextProportional(1)
--     SetTextColour(255, 255, 255, 215)
--     SetTextEntry("STRING")
--     SetTextCentre(1)
--     AddTextComponentString(text)
--     DrawText(_x, _y)

--     local factor = (string.len(text)) / 370

--     DrawRect(_x, _y + 0.0125, 0.015 + factor, 0.03, 41, 11, 41, 68)
-- end

-- OpenInput = function(label, type)
-- 	AddTextEntry(type, label)

-- 	DisplayOnscreenKeyboard(1, type, "", "", "", "", "", 30)

-- 	while UpdateOnscreenKeyboard() == 0 do
-- 		DisableAllControlActions(0)
-- 		Wait(0)
-- 	end

-- 	if GetOnscreenKeyboardResult() then
-- 	  	return GetOnscreenKeyboardResult()
-- 	end
-- end

-- UUID = function()
--     math.randomseed(GetGameTimer() * math.random())

--     return math.random(100000, 999999)
-- end

-- RegisterNetEvent("esx:playerLoaded")
-- AddEventHandler("esx:playerLoaded", function(response)
--     ESX.PlayerData = response

--     FetchBusyState()
-- end)

-- RegisterNetEvent("james_barbershop:eventHandler")
-- AddEventHandler("james_barbershop:eventHandler", function(eventName, eventData)
--     if eventName == "CHAIR_BUSY" then
--         Heap.Busy = eventData
--     elseif eventName == "SYNC_ANIMATION" then
--         local animName = eventData.Animation
--         local sceneHash = eventData.SceneHash
--         local sceneLooped = eventData.Looped or false
--         local clearTasks = eventData.ClearTasks or false

--         if DoesEntityExist(Heap.Barber) then
--             PlayDresserAnimation(Heap.Barber, animName, sceneHash, sceneLooped, clearTasks)
--         end
--     elseif eventName == "SYNC_PARTICLE" then
--         local ped = NetToPed(eventData.Net)
--         local phase = GetSynchronizedScenePhase(Heap.Scene)

--         while phase < 1.0 do
--             phase = GetSynchronizedScenePhase(Heap.Scene)

--             if phase > .60 then
--                 if Heap.SoundPlaying then
--                     StopSound(Heap.SoundPlaying)

--                     if DoesParticleFxLoopedExist(Heap.Particle) then
--                         StopParticleFxLooped(Heap.Particle, 0)
--                     end

--                     Heap.SoundPlaying = false

--                     if ped == Heap.Ped then
--                         --TriggerEvent("skinchanger:loadSkin", eventData.Skin)
--                     end
--                 end
--             elseif phase > .30 then
--                 if not Heap.SoundPlaying then
--                     Heap.SoundPlaying = GetSoundId()

--                     if ped == Heap.Ped then
--                         while not HasNamedPtfxAssetLoaded("scr_barbershop") do
--                             Citizen.Wait(0)

--                             RequestNamedPtfxAsset("scr_barbershop")
--                         end

--                         UseParticleFxAsset("scr_barbershop")

--                         Heap.Particle = StartParticleFxLoopedOnPedBone("scr_barbers_haircut", ped, 0.0, 0.0, 0.1, 0.0, 0.0, 0.0, 31086, 1065353216, 0, 0, 0)

--                         SetParticleFxLoopedColour(Heap.Particle, 210, 105, 30, 0)
--                     end

--                     PlaySoundFromEntity(Heap.SoundPlaying, "Scissors", ped, "Barber_Sounds", false, 0)
--                 end
--             end

--             Citizen.Wait(0)
--         end
--     end
-- end)

-- Citizen.CreateThread(function()
--     while true do
--         local sleepThread = 5000

--         local newPed = PlayerPedId()

--         if Heap.Ped ~= newPed then
--             Heap.Ped = newPed
--         end

--         Citizen.Wait(sleepThread)
--     end
-- end)

-- Citizen.CreateThread(function()
--     Citizen.Wait(50)

--     while true do
--         local sleepThread = 500

--         local ped = Heap.Ped
--         local pedLocation = GetEntityCoords(ped)

--         local dstCheck = #(pedLocation - Shop.Barber.Location)

--         if dstCheck <= 6.5 and not Heap.Busy then
--             CreateBarber()
--             if dstCheck <= 2.0 then
--                 sleepThread = 5

--                 DrawTopNotification("Appuyez sur ~INPUT_CONTEXT~ pour accéder au ~o~Coiffeur~w~.")

--                 if IsControlJustReleased(0, 38) then
--                     EnterBarber()
--                 end
--             end

--             if not Heap.Greeted then
--                 PlayAmbientSpeech1(Heap.Barber, "SHOP_GREET", "SPEECH_PARAMS_FORCE")

--                 Heap.Greeted = true
--             end
--         else
--             if Heap.Greeted then
--                 Heap.Greeted = false
--             end
--         end


--         Citizen.Wait(sleepThread)
--     end
-- end)