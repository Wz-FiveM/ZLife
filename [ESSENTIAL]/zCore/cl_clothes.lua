-- local Keys = {
-- 	["ESC"] = 322, ["F1"] = 288, ["F2"] = 289, ["F3"] = 170, ["F5"] = 166, ["F6"] = 167, ["F7"] = 168, ["F8"] = 169, ["F9"] = 56, ["F10"] = 57,
-- 	["~"] = 243, ["1"] = 157, ["2"] = 158, ["3"] = 160, ["4"] = 164, ["5"] = 165, ["6"] = 159, ["7"] = 161, ["8"] = 162, ["9"] = 163, ["-"] = 84, ["="] = 83, ["BACKSPACE"] = 177,
-- 	["TAB"] = 37, ["Q"] = 44, ["W"] = 32, ["E"] = 38, ["R"] = 45, ["T"] = 245, ["Y"] = 246, ["U"] = 303, ["P"] = 199, ["["] = 39, ["]"] = 40, ["ENTER"] = 18,
-- 	["CAPS"] = 137, ["A"] = 34, ["S"] = 8, ["D"] = 9, ["F"] = 23, ["G"] = 47, ["H"] = 74, ["K"] = 311, ["L"] = 182,
-- 	["LEFTSHIFT"] = 21, ["Z"] = 20, ["X"] = 73, ["C"] = 26, ["V"] = 0, ["B"] = 29, ["N"] = 249, ["M"] = 244, [","] = 82, ["."] = 81,
-- 	["LEFTCTRL"] = 36, ["LEFTALT"] = 19, ["SPACE"] = 22, ["RIGHTCTRL"] = 70,
-- 	["HOME"] = 213, ["PAGEUP"] = 10, ["PAGEDOWN"] = 11, ["DELETE"] = 178,
-- 	["LEFT"] = 174, ["RIGHT"] = 175, ["TOP"] = 27, ["DOWN"] = 173,
-- 	["NENTER"] = 201, ["N4"] = 108, ["N5"] = 60, ["N6"] = 107, ["N+"] = 96, ["N-"] = 97, ["N7"] = 117, ["N8"] = 61, ["N9"] = 118
-- }

-- ESX                           = nil
-- local GUI                     = {}
-- GUI.Time                      = 0
-- local HasAlreadyEnteredMarker = false
-- local LastZone                = nil
-- local CurrentAction           = nil
-- local CurrentActionMsg        = ''
-- local CurrentActionData       = {}
-- local HasPayed                = false
-- local HasLoadCloth			  = false
-- local h9dyA_4T = {24, 27, 178, 177, 189, 190, 187, 188, 202, 239, 240, 201, 172, 173, 174, 175}

-- Citizen.CreateThread(function()

-- 	while ESX == nil do
-- 		TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
-- 		Citizen.Wait(0)
-- 	end

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
-- 	ClearPedTasks(PlayerPedId())
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
--     --[[ DisableAllControlActions(0)
--     for mCsewfX, yY in pairs(h9dyA_4T) do
--         EnableControlAction(0, yY, true)
--     end
--     local NzeoQJ, AwGfFV = IsDisabledControlPressed(1, 44), IsDisabledControlPressed(1, 51)
--     if NzeoQJ or AwGfFV then
--         local wCRY = PlayerPedId()
--         SetEntityHeading(PlayerPedId(),NzeoQJ and GetEntityHeading(wCRY) - 1.0 or AwGfFV and GetEntityHeading(wCRY) + 1.0)
--     end ]]
-- end

-- -- Menu
-- local VetementPed = {
--     Base = { Title = "Vêtements", Header = {"shopui_title_lowendfashion", "shopui_title_lowendfashion"}, HeaderColor = {255,255,255}},
--     Data = { currentMenu = "Articles disponible :" },
--     Events = {
--         --onOpened=vms2,
--         onRender=vms6,
--         onExited=vms5,
--         onSelected = function(self, _, btn, PMenu, menuData, currentButton, currentBtn, currentSlt, result, slide)
-- 			local slide, btn, check, closestPlayer, closestDistance, playerPed, coords = btn.slidenum, btn.name, btn.unkCheckbox, ESX.Game.GetClosestPlayer(), PlayerPedId(), GetEntityCoords(playerPed)

--             if btn == "Valider" then
--                 --[[ local keyboard = KeyboardInput("Nom de la tenue", "", 50)
                                                
--                 TriggerEvent('skinchanger:getSkin', function(skin)
--                     TriggerServerEvent('esx_eden_clotheshop:saveOutfit', keyboard, skin)
--                 end) ]]
--                 SaveAccess()
--                 TriggerServerEvent('clp_access:buyaccess')
--                 ShowAboveRadarMessage("~b~Vous avez acheter des vêtements.")
--                 Wait(500)
--                 CloseMenu(true)
--             elseif btn == "Sauvegarder la tenue" then 
--                 local keyboard = KeyboardInput("Nom de la tenue", "", 50)
                                                
--                 TriggerEvent('skinchanger:getSkin', function(skin)
--                     TriggerServerEvent('esx_eden_clotheshop:saveOutfit', keyboard, skin)
--                 end)
--             end
--         end,
--         onSlide = function(menuData, btn, currentButton, currentSlt, slide, PMenu)
--             local currentMenu, currentBtn, slide, btn, ped = menuData.currentMenu, menuData.currentBtn, btn.slidenum, btn.name, GetPlayerPed(-1)
--             local coords = GetEntityCoords(GetPlayerPed(-1))
--             if btn == "Cheveux" and slide ~= -1 then
--                 cheveux = slide - 1
--                --[[  SetCamCoord(cam, coords.x-2.0, coords.y-1.0, coords.z+0.5)
--                 SetCamFov(cam, 30.0)
--                 PointCamAtCoord(cam, coords.x, coords.y, coords.z+0.5)
--                 SetCamShakeAmplitude(cam, 13.0)
--                 RenderScriptCams(1, 1, 1500, 1, 1) ]]
--                 TriggerEvent('skinchanger:change', 'hair_1', cheveux)
--             elseif btn == "Haut" and slide ~= -1 then
--                 haut = slide - 1
--                 --[[ SetCamCoord(cam, coords.x-1.75, coords.y, coords.z+0.60)
--                 SetCamFov(cam, 40.0)
--                 PointCamAtCoord(cam, coords.x, coords.y, coords.z)
--                 SetCamShakeAmplitude(cam, 13.0)
--                 RenderScriptCams(1, 1, 1500, 1, 1) ]]
--                 TriggerEvent('skinchanger:change', 'arms', haut)
--             elseif btn == "Couleur Haut" and slide ~= -1 then
--                 couleurhaut = slide - 1
--                 --[[ SetCamCoord(cam, coords.x-1.75, coords.y, coords.z+0.60)
--                 SetCamFov(cam, 40.0)
--                 PointCamAtCoord(cam, coords.x, coords.y, coords.z)
--                 SetCamShakeAmplitude(cam, 13.0)
--                 RenderScriptCams(1, 1, 1500, 1, 1) ]]
--                 TriggerEvent('skinchanger:change', 'arms_2', couleurhaut)
--             elseif btn == "Pantalon" and slide ~= -1 then
--                 pantalon = slide - 1
--                 --[[ SetCamCoord(cam, coords.x-1.75, coords.y, coords.z-0.55)
--                 SetCamFov(cam, 40.0)
--                 PointCamAtCoord(cam, coords.x, coords.y, coords.z-0.55)
--                 SetCamShakeAmplitude(cam, 13.0)
--                 RenderScriptCams(1, 1, 1500, 1, 1) ]]
--                 TriggerEvent('skinchanger:change', 'pants_1', pantalon)
--             elseif btn == "Couleur Pantalon" and slide ~= -1 then
--                 couleurpantalon = slide - 1
--                 --[[ SetCamCoord(cam, coords.x-1.75, coords.y, coords.z-0.55)
--                 SetCamFov(cam, 40.0)
--                 PointCamAtCoord(cam, coords.x, coords.y, coords.z-0.55)
--                 SetCamShakeAmplitude(cam, 13.0)
--                 RenderScriptCams(1, 1, 1500, 1, 1) ]]
--                 TriggerEvent('skinchanger:change', 'pants_2', couleurpantalon)
--             elseif btn == "Lunettes" and slide ~= -1 then
--                 lunettes = slide - 1
--                 --[[ SetCamCoord(cam, coords.x-2.0, coords.y-1.0, coords.z+0.5)
--                 SetCamFov(cam, 30.0)
--                 PointCamAtCoord(cam, coords.x, coords.y, coords.z+0.5)
--                 SetCamShakeAmplitude(cam, 13.0)
--                 RenderScriptCams(1, 1, 1500, 1, 1) ]]
--                 TriggerEvent('skinchanger:change', 'glasses_1', lunettes)
--             elseif btn == "Couleur Lunettes" and slide ~= -1 then
--                 couleurlunettes = slide - 1
--                 --[[ SetCamCoord(cam, coords.x-2.0, coords.y-1.0, coords.z+0.5)
--                 SetCamFov(cam, 30.0)
--                 PointCamAtCoord(cam, coords.x, coords.y, coords.z+0.5)
--                 SetCamShakeAmplitude(cam, 13.0)
--                 RenderScriptCams(1, 1, 1500, 1, 1) ]]
--                 TriggerEvent('skinchanger:change', 'glasses_2', couleurlunettes)
--             elseif btn == "Chapeau" and slide ~= -1 then
--                 chapeau = slide - 1
--                 --[[ SetCamCoord(cam, coords.x-2.0, coords.y-1.0, coords.z+0.5)
--                 SetCamFov(cam, 30.0)
--                 PointCamAtCoord(cam, coords.x, coords.y, coords.z+0.5)
--                 SetCamShakeAmplitude(cam, 13.0)
--                 RenderScriptCams(1, 1, 1500, 1, 1) ]]
--                 TriggerEvent('skinchanger:change', 'helmet_1', chapeau)
--             elseif btn == "Couleur Chapeau" and slide ~= -1 then
--                 couleurchapeau = slide - 1
--                 --[[ SetCamCoord(cam, coords.x-2.0, coords.y-1.0, coords.z+0.5)
--                 SetCamFov(cam, 30.0)
--                 PointCamAtCoord(cam, coords.x, coords.y, coords.z+0.5)
--                 SetCamShakeAmplitude(cam, 13.0)
--                 RenderScriptCams(1, 1, 1500, 1, 1) ]]
--                 TriggerEvent('skinchanger:change', 'helmet_2', couleurchapeau)
--             elseif btn == "Variation du visage" then 
--                 visage = slide - 1
--                 --[[ SetCamCoord(cam, coords.x-2.0, coords.y-1.0, coords.z+0.5)
--                 SetCamFov(cam, 30.0)
--                 PointCamAtCoord(cam, coords.x, coords.y, coords.z+0.5)
--                 SetCamShakeAmplitude(cam, 13.0)
--                 RenderScriptCams(1, 1, 1500, 1, 1) ]]
--                 TriggerEvent('skinchanger:change', 'facepeds', visage)
--             end
--         end
--     },

--     Menu = {
--         ["Articles disponible :"] = {
--             b = {
--                 {name = "Vêtements", ask = ">", askX = true},
--                 {name = "Accessoires", ask = ">", askX = true},
--                 {name = "Valider", ask = "~g~50$", askX = true},
--                 {name = "Sauvegarder la tenue", ask = ">", askX = true}
--             }
--         },
--         ["vêtements"] = {
--             b = {
--                 {name = "Haut", slidemax = 5},
--                 {name = "Couleur Haut", slidemax = 5},
--                 {name = "Pantalon", slidemax = 5},
--                 {name = "Couleur Pantalon", slidemax = 5},
--             }
--         },
--         ["accessoires"] = {
--             b = {
--                 {name = "Variation du visage", slidemax = 5},
--                 {name = "Lunettes", slidemax = 3},
--                 {name = "Couleur Lunettes", slidemax = 3},
--                 {name = "Chapeau", slidemax = 3},
--                 {name = "Couleur Chapeau", slidemax = 3},
--             }
--         },
--     }
-- }
-- local VetementNoPed = {
-- 	Base = { Title = "Vêtements", Header = {"shopui_title_lowendfashion", "shopui_title_lowendfashion"}, HeaderColor = {255,255,255}},
--     Data = { currentMenu = "Articles disponible:" },
--     Events = {
--         --onOpened=vms2,
-- 		onRender=vms6,
--         onExited=vms5,
--         onSelected = function(self, _, btn, PMenu, menuData, currentButton, currentBtn, currentSlt, result, slide)
-- 			local slide, btn, check, closestPlayer, closestDistance, playerPed, coords = btn.slidenum, btn.name, btn.unkCheckbox, ESX.Game.GetClosestPlayer(), PlayerPedId(), GetEntityCoords(playerPed)

--             if btn == "Valider" then
--                --[[  local keyboard = KeyboardInput("Nom de la tenue", "", 50)
                                                
--                 TriggerEvent('skinchanger:getSkin', function(skin)
--                     TriggerServerEvent('esx_eden_clotheshop:saveOutfit', keyboard, skin)
--                 end) ]]
--                 SaveAccess()
--                 TriggerServerEvent('clp_access:buyaccess')
--                 ShowAboveRadarMessage("~b~Vous avez acheter des vêtements.")
--                 Wait(500)
--                 CloseMenu(true)
--             elseif btn == "Sauvegarder la tenue" then 
--                 local keyboard = KeyboardInput("Nom de la tenue", "", 50)
                                                
--                 TriggerEvent('skinchanger:getSkin', function(skin)
--                     TriggerServerEvent('esx_eden_clotheshop:saveOutfit', keyboard, skin)
--                 end)
--                 ShowAboveRadarMessage("~b~Vous avez sauvegardez votre tenue sous le nom de ~g~"..keyboard.."~b~.")
--             end
--         end,
--         onSlide = function(menuData, btn, currentButton, currentSlt, slide, PMenu)
--             local currentMenu, currentBtn, slide, btn, ped = menuData.currentMenu, menuData.currentBtn, btn.slidenum, btn.name, GetPlayerPed(-1)
--             local coords = GetEntityCoords(GetPlayerPed(-1))

-- 			if btn == "T-Shirt" and slide ~= -1 then
--                 tshirt = slide - 1
--                --[[  SetCamCoord(cam, coords.x-1.75, coords.y, coords.z+0.60)
--                 SetCamFov(cam, 40.0)
--                 PointCamAtCoord(cam, coords.x, coords.y, coords.z)
--                 SetCamShakeAmplitude(cam, 13.0)
--                 RenderScriptCams(1, 1, 1500, 1, 1) ]]
--                 TriggerEvent('skinchanger:change', 'tshirt_1', tshirt)
--             elseif btn == "Couleur T-Shirt" and slide ~= -1 then
--                 ctshirt = slide - 1
--                --[[  SetCamCoord(cam, coords.x-1.75, coords.y, coords.z+0.60)
--                 SetCamFov(cam, 40.0)
--                 PointCamAtCoord(cam, coords.x, coords.y, coords.z)
--                 SetCamShakeAmplitude(cam, 13.0)
--                 RenderScriptCams(1, 1, 1500, 1, 1) ]]
--                 TriggerEvent('skinchanger:change', 'tshirt_2', ctshirt)
--             elseif btn == "Torse" and slide ~= -1 then
--                 torse = slide - 1
--                 --[[ SetCamCoord(cam, coords.x-1.75, coords.y, coords.z+0.60)
--                 SetCamFov(cam, 40.0)
--                 PointCamAtCoord(cam, coords.x, coords.y, coords.z)
--                 SetCamShakeAmplitude(cam, 13.0)
--                 RenderScriptCams(1, 1, 1500, 1, 1) ]]
--                 TriggerEvent('skinchanger:change', 'torso_1', torse)
--             elseif btn == "Couleur Torse" and slide ~= -1 then
--                 ctorse = slide - 1
--                 --[[ SetCamCoord(cam, coords.x-1.75, coords.y, coords.z+0.60)
--                 SetCamFov(cam, 40.0)
--                 PointCamAtCoord(cam, coords.x, coords.y, coords.z)
--                 SetCamShakeAmplitude(cam, 13.0)
--                 RenderScriptCams(1, 1, 1500, 1, 1) ]]
--                 TriggerEvent('skinchanger:change', 'torso_2', ctorse)
--             elseif btn == "Pantalon" and slide ~= -1 then
--                 pantalon = slide - 1
--                 --[[ SetCamCoord(cam, coords.x-1.75, coords.y, coords.z-0.55)
--                 SetCamFov(cam, 40.0)
--                 PointCamAtCoord(cam, coords.x, coords.y, coords.z-0.55)
--                 SetCamShakeAmplitude(cam, 13.0)
--                 RenderScriptCams(1, 1, 1500, 1, 1) ]]
--                 TriggerEvent('skinchanger:change', 'pants_1', pantalon)
--             elseif btn == "Couleur Pantalon" and slide ~= -1 then
--                 cpantalon = slide - 1
--                 --[[ SetCamCoord(cam, coords.x-1.75, coords.y, coords.z-0.55)
--                 SetCamFov(cam, 40.0)
--                 PointCamAtCoord(cam, coords.x, coords.y, coords.z-0.55)
--                 SetCamShakeAmplitude(cam, 13.0)
--                 RenderScriptCams(1, 1, 1500, 1, 1) ]]
--                 TriggerEvent('skinchanger:change', 'pants_2', cpantalon)
--             elseif btn == "Chaussures" and slide ~= -1 then
--                 chaussures = slide - 1
--                 --[[ SetCamCoord(cam, coords.x-1.0, coords.y, coords.z)
--                 SetCamFov(cam, 50.0)
--                 PointCamAtCoord(cam, coords.x, coords.y, coords.z-1.0)
--                 SetCamShakeAmplitude(cam, 13.0)
--                 RenderScriptCams(1, 1, 1500, 1, 1) ]]
--                 TriggerEvent('skinchanger:change', 'shoes_1', chaussures)
--             elseif btn == "Couleur Chaussures" and slide ~= -1 then
--                 cchaussures = slide - 1
--                 --[[ SetCamCoord(cam, coords.x-1.0, coords.y, coords.z)
--                 SetCamFov(cam, 50.0)
--                 PointCamAtCoord(cam, coords.x, coords.y, coords.z-1.0)
--                 SetCamShakeAmplitude(cam, 13.0)
--                 RenderScriptCams(1, 1, 1500, 1, 1) ]]
--                 TriggerEvent('skinchanger:change', 'shoes_2', cchaussures)
--             elseif btn == "Bras" and slide ~= -1 then
--                 bras = slide - 1
--                 --[[ SetCamCoord(cam, coords.x-1.75, coords.y, coords.z-0.15)
--                 SetCamFov(cam, 40.0)
--                 PointCamAtCoord(cam, coords.x, coords.y, coords.z-0.15)
--                 SetCamShakeAmplitude(cam, 13.0)
--                 RenderScriptCams(1, 1, 1500, 1, 1) ]]
--                 TriggerEvent('skinchanger:change', 'arms', bras)
--             elseif btn == "Couleur Bras" and slide ~= -1 then
--                 cbras = slide - 1
--                 --[[ SetCamCoord(cam, coords.x-1.75, coords.y, coords.z-0.15)
--                 SetCamFov(cam, 40.0)
--                 PointCamAtCoord(cam, coords.x, coords.y, coords.z-0.15)
--                 SetCamShakeAmplitude(cam, 13.0)
--                 RenderScriptCams(1, 1, 1500, 1, 1) ]]
--                 TriggerEvent('skinchanger:change', 'arms_2', cbras)
--             elseif btn == "Montre" and slide ~= -1 then
--                 montre = slide - 1
--                 --[[ SetCamCoord(cam, coords.x-1.50, coords.y-1.5, coords.z+0.60)
--                 SetCamFov(cam, 20.0)
--                 PointCamAtCoord(cam, coords.x, coords.y, coords.z)
--                 SetCamShakeAmplitude(cam, 13.0)
--                 RenderScriptCams(1, 1, 1500, 1, 1) ]]
--                 TriggerEvent('skinchanger:change', 'watches_1', montre)
--             elseif btn == "Couleur Montre" and slide ~= -1 then
--                 cmontre = slide - 1
--                --[[  SetCamCoord(cam, coords.x-1.50, coords.y-1.5, coords.z+0.60)
--                 SetCamFov(cam, 20.0)
--                 PointCamAtCoord(cam, coords.x, coords.y, coords.z)
--                 SetCamShakeAmplitude(cam, 13.0)
--                 RenderScriptCams(1, 1, 1500, 1, 1) ]]
--                 TriggerEvent('skinchanger:change', 'watches_2', cmontre)
--             elseif btn == "Chaîne" and slide ~= -1 then
--                 chaine = slide - 1
--                 --[[ SetCamCoord(cam, coords.x-1.75, coords.y, coords.z+0.60)
--                 SetCamFov(cam, 40.0)
--                 PointCamAtCoord(cam, coords.x, coords.y, coords.z)
--                 SetCamShakeAmplitude(cam, 13.0)
--                 RenderScriptCams(1, 1, 1500, 1, 1) ]]
--                 TriggerEvent('skinchanger:change', 'chain_1', chaine)
--             elseif btn == "Couleur Chaîne" and slide ~= -1 then
--                 cchaine = slide - 1
--                 --[[ SetCamCoord(cam, coords.x-1.75, coords.y, coords.z+0.60)
--                 SetCamFov(cam, 40.0)
--                 PointCamAtCoord(cam, coords.x, coords.y, coords.z)
--                 SetCamShakeAmplitude(cam, 13.0)
--                 RenderScriptCams(1, 1, 1500, 1, 1) ]]
--                 TriggerEvent('skinchanger:change', 'chain_2', cchaine)
--             elseif btn == "Bracelets" and slide ~= -1 then
--                 bracelets = slide - 1
--                 --[[ SetCamCoord(cam, coords.x-1.50, coords.y-0.2, coords.z+0.60)
--                 SetCamFov(cam, 20.0)
--                 PointCamAtCoord(cam, coords.x, coords.y, coords.z)
--                 SetCamShakeAmplitude(cam, 13.0)
--                 RenderScriptCams(1, 1, 1500, 1, 1) ]]
--                 TriggerEvent('skinchanger:change', 'bracelets_1', bracelets)
--             elseif btn == "Couleur Bracelets" and slide ~= -1 then
--                 cbracelets = slide - 1
--                 --[[ SetCamCoord(cam, coords.x, coords.y-1.00, coords.z)
--                 SetCamFov(cam, 40.0)
--                 PointCamAtCoord(cam, coords.x, coords.y, coords.z)
--                 SetCamShakeAmplitude(cam, 13.0)
--                 RenderScriptCams(1, 1, 1500, 1, 1) ]]
--                 TriggerEvent('skinchanger:change', 'bracelets_2', cbracelets)
--             elseif btn == "Chapeau" and slide ~= -1 then
--                 chapeau = slide - 1
--                 --[[ SetCamCoord(cam, coords.x-2.0, coords.y-1.0, coords.z+0.5)
--                 SetCamFov(cam, 30.0)
--                 PointCamAtCoord(cam, coords.x, coords.y, coords.z+0.5)
--                 SetCamShakeAmplitude(cam, 13.0)
--                 RenderScriptCams(1, 1, 1500, 1, 1) ]]
--                 TriggerEvent('skinchanger:change', 'helmet_1', chapeau)
--             elseif btn == "Couleur Chapeau" and slide ~= -1 then
--                 cchapeau = slide - 1
--                 --[[ SetCamCoord(cam, coords.x-2.0, coords.y-1.0, coords.z+0.5)
--                 SetCamFov(cam, 30.0)
--                 PointCamAtCoord(cam, coords.x, coords.y, coords.z+0.5)
--                 SetCamShakeAmplitude(cam, 13.0)
--                 RenderScriptCams(1, 1, 1500, 1, 1) ]]
--                 TriggerEvent('skinchanger:change', 'helmet_2', cchapeau)
--             elseif btn == "Lunettes" and slide ~= -1 then
--                 lunettes = slide - 1
--                 --[[ SetCamCoord(cam, coords.x-2.0, coords.y-1.0, coords.z+0.5)
--                 SetCamFov(cam, 30.0)
--                 PointCamAtCoord(cam, coords.x, coords.y, coords.z+0.5)
--                 SetCamShakeAmplitude(cam, 13.0)
--                 RenderScriptCams(1, 1, 1500, 1, 1) ]]
--                 TriggerEvent('skinchanger:change', 'glasses_1', lunettes)
--             elseif btn == "Couleur Lunettes" and slide ~= -1 then
--                 clunettes = slide - 1
--                 --[[ SetCamCoord(cam, coords.x-2.0, coords.y-1.0, coords.z+0.5)
--                 SetCamFov(cam, 30.0)
--                 PointCamAtCoord(cam, coords.x, coords.y, coords.z+0.5)
--                 SetCamShakeAmplitude(cam, 13.0)
--                 RenderScriptCams(1, 1, 1500, 1, 1) ]]
--                 TriggerEvent('skinchanger:change', 'glasses_2', clunettes)
--             elseif btn == "Oreillette" and slide ~= -1 then
--                 oreillette = slide - 1
--                 --[[ SetCamCoord(cam, coords.x-2.0, coords.y-1.0, coords.z+0.5)
--                 SetCamFov(cam, 30.0)
--                 PointCamAtCoord(cam, coords.x, coords.y, coords.z+0.5)
--                 SetCamShakeAmplitude(cam, 13.0)
--                 RenderScriptCams(1, 1, 1500, 1, 1) ]]
--                 TriggerEvent('skinchanger:change', 'ears_1', oreillette)
--             elseif btn == "Couleur Oreillette" and slide ~= -1 then
--                 coreillette = slide - 1
--                 --[[ SetCamCoord(cam, coords.x-2.0, coords.y-1.0, coords.z+0.5)
--                 SetCamFov(cam, 30.0)
--                 PointCamAtCoord(cam, coords.x, coords.y, coords.z+0.5)
--                 SetCamShakeAmplitude(cam, 13.0)
--                 RenderScriptCams(1, 1, 1500, 1, 1) ]]
--                 TriggerEvent('skinchanger:change', 'ears_2', coreillette)
--             elseif btn == "Calque" and slide ~= -1 then
--                 decals_1 = slide - 1
--                 --[[ SetCamCoord(cam, coords.x-1.75, coords.y, coords.z+0.60)
--                 SetCamFov(cam, 40.0)
--                 PointCamAtCoord(cam, coords.x, coords.y, coords.z)
--                 SetCamShakeAmplitude(cam, 13.0)
--                 RenderScriptCams(1, 1, 1500, 1, 1) ]]
--                 TriggerEvent('skinchanger:change', 'decals_1', decals_1)
--             elseif btn == "Calque 2" and slide ~= -1 then
--                 decals_2 = slide - 1
--                 --[[ SetCamCoord(cam, coords.x-1.75, coords.y, coords.z+0.60)
--                 SetCamFov(cam, 40.0)
--                 PointCamAtCoord(cam, coords.x, coords.y, coords.z)
--                 SetCamShakeAmplitude(cam, 13.0)
--                 RenderScriptCams(1, 1, 1500, 1, 1) ]]
--                 TriggerEvent('skinchanger:change', 'decals_2', decals_2)

--             elseif btn == "Sac" and slide ~= -1 then
--                 bags1 = slide - 1
--                 --[[ SetCamCoord(cam, coords.x-1.75, coords.y, coords.z+0.60)
--                 SetCamFov(cam, 40.0)
--                 PointCamAtCoord(cam, coords.x, coords.y, coords.z)
--                 SetCamShakeAmplitude(cam, 13.0)
--                 RenderScriptCams(1, 1, 1500, 1, 1) ]]
--                 TriggerEvent('skinchanger:change', 'bags_1', bags1)
--             elseif btn == "Couleur du sac" and slide ~= -1 then
--                 bags2 = slide - 1
--                 --[[ SetCamCoord(cam, coords.x-1.75, coords.y, coords.z+0.60)
--                 SetCamFov(cam, 40.0)
--                 PointCamAtCoord(cam, coords.x, coords.y, coords.z)
--                 SetCamShakeAmplitude(cam, 13.0)
--                 RenderScriptCams(1, 1, 1500, 1, 1) ]]
--                 TriggerEvent('skinchanger:change', 'bags_2', bags2)
--             end
--         end
--     },

--     Menu = {
--         ["Articles disponible:"] = {
--             b = {
--                 {name = "Vêtements", ask = ">", askX = true},
--                 {name = "Accessoires", ask = ">", askX = true},
--                 {name = "Valider", ask = "~g~50$", askX = true},
--                 {name = "Sauvegarder la tenue", ask = ">", askX = true}
--             }
--         },
--         ["vêtements"] = {
--             b = {
--                 {name = "T-Shirt", slidemax = 216},
--                 {name = "Couleur T-Shirt", slidemax = 50},
--                 {name = "Torse", slidemax = 428},
--                 {name = "Couleur Torse", slidemax = 50},
--                 {name = "Pantalon", slidemax = 161},
--                 {name = "Couleur Pantalon", slidemax = 50},
--                 {name = "Chaussures", slidemax = 106},
--                 {name = "Couleur Chaussures", slidemax = 50},
--                 {name = "Sac", slidemax = 89},
--                 {name = "Couleur du sac", slidemax = 50},
-- 				{name = "Bras", slidemax = 188},
--                 {name = "Couleur Bras", slidemax = 15},
--                 {name = "Calque", slidemax = 88},
--                 {name = "Calque 2", slidemax = 50},
--             }
--         },
--         ["accessoires"] = {
--             b = {
--                 {name = "Chapeau", slidemax = 150},
--                 {name = "Couleur Chapeau", slidemax = 50},
--                 {name = "Lunettes", slidemax = 29},
--                 {name = "Couleur Lunettes", slidemax = 50},
--                 {name = "Oreillette", slidemax = 27},
--                 {name = "Couleur Oreillette", slidemax = 50},
-- 				{name = "Montre", slidemax = 29},
--                 {name = "Couleur Montre", slidemax = 50},
--                 {name = "Chaîne", slidemax = 148},
--                 {name = "Couleur Chaîne", slidemax = 50},
--                 {name = "Bracelets", slidemax = 7},
--                 {name = "Couleur Bracelets", slidemax = 5},
--             }
--         },
--     }
-- }

-- function OpenShopMenuC()

--   local elements = {}


--   table.insert(elements, {label = _U('shop_clothes'),  value = 'shop_clothes'})
--   table.insert(elements, {label = _U('player_clothes'), value = 'player_dressing'})
--   table.insert(elements, {label = _U('suppr_cloth'), value = 'suppr_cloth'})

--   ESX.UI.Menu.CloseAll()

--   ESX.UI.Menu.Open(
   
--             'default', GetCurrentResourceName(), 'player_dressing',

--             {
             
--              css =  'suburban',

--              title =  'Suburban',

--              elements = elements

--             },
            
--     function(data, menu)
-- 	menu.close()
--       if data.current.value == 'shop_clothes' then
-- 			HasPayed = false

-- 	TriggerEvent('esx_skin:openRestrictedMenu', function(data, menu)

-- 		menu.close()

-- 		ESX.UI.Menu.Open(
-- 			'default', GetCurrentResourceName(), 'shop_confirm',

-- 			{

--             css =  'suburban',

-- 			title = 'Valider votre achat ?',

-- 			align = 'top-left',

-- 				elements = {
-- 					{label = _U('yes'), value = 'yes'},
-- 					{label = _U('no'), value = 'no'},
-- 				}
-- 			},

-- 			function(data, menu)

-- 				menu.close()

-- 				if data.current.value == 'yes' then

-- 					ESX.TriggerServerCallback('esx_eden_clotheshop:checkMoney', function(hasEnoughMoney)

-- 						if hasEnoughMoney then

-- 							TriggerEvent('skinchanger:getSkin', function(skin)
-- 								TriggerServerEvent('esx_skin:save', skin)
-- 							end)

-- 							TriggerServerEvent('esx_eden_clotheshop:pay')

-- 							HasPayed = true

-- 							ESX.TriggerServerCallback('esx_eden_clotheshop:checkPropertyDataStore', function(foundStore)

-- 								if foundStore then

-- 									ESX.UI.Menu.Open(

-- 										'default', GetCurrentResourceName(), 'save_dressing',
-- 										{

-- 										css = 'suburban',

-- 										title = "Donner un nom a cette tenue ?",

-- 										align = 'top-left',

-- 										elements = {
-- 												{label = _U('yes'), value = 'yes'},
-- 												{label = _U('no'),  value = 'no'},
-- 											}
-- 										},

-- 										function(data2, menu2)

-- 											menu2.close()

-- 											if data2.current.value == 'yes' then

-- 												local keyboard = KeyboardInput("Nom de la tenue", "", 50)
                                                
--                                                 TriggerEvent('skinchanger:getSkin', function(skin)
--                                                     TriggerServerEvent('esx_eden_clotheshop:saveOutfit', keyboard, skin)
--                                                 end)
--                                                 ESX.ShowNotification(_U('saved_outfit'))
-- 											end
-- 										end)
-- 								end
-- 							end)
-- 						else

-- 							TriggerEvent('esx_skin:getLastSkin', function(skin)
-- 								TriggerEvent('skinchanger:loadSkin', skin)
-- 							end)

-- 							ESX.ShowNotification(_U('not_enough_money'))

-- 						end

-- 					end)

-- 				end

-- 				if data.current.value == 'no' then

-- 					TriggerEvent('esx_skin:getLastSkin', function(skin)
-- 						TriggerEvent('skinchanger:loadSkin', skin)
-- 					end)

-- 				end

-- 				CurrentAction     = 'shop_menu'
-- 				CurrentActionMsg  = "Appuyez sur ~INPUT_PICKUP~ pour parler à ~b~Lana"
-- 				CurrentActionData = {}

-- 			end,
-- 			function(data, menu)

-- 				menu.close()

-- 				CurrentAction     = 'shop_menu'
-- 				CurrentActionMsg  = "Appuyez sur ~INPUT_PICKUP~ pour parler à ~b~Lana"
-- 				CurrentActionData = {}

-- 			end
-- 		)

-- 	end, function(data, menu)

-- 			menu.close()

-- 			CurrentAction     = 'shop_menu'
-- 			CurrentActionMsg  = "Appuyez sur ~INPUT_PICKUP~ pour parler à ~b~Lana"
-- 			CurrentActionData = {}

-- 	end, {
-- 		'tshirt_1',
-- 		'tshirt_2',
-- 		'torso_1',
-- 		'torso_2',
-- 		'decals_1',
-- 		'decals_2',
-- 		'arms',
-- 		'arms_2',
-- 		'pants_1',
-- 		'pants_2',
-- 		'shoes_1',
-- 		'shoes_2',
-- 	  	'chain_1',
-- 		'chain_2',
-- 		--'helmet_1',
-- 		--'helmet_2',
-- 		--'glasses_1',
-- 		--'glasses_2',
-- 		--'bags_1',
-- 		--'bags_2',
		
-- 	})
--       end

--       if data.current.value == 'player_dressing' then
		
--         ESX.TriggerServerCallback('esx_eden_clotheshop:getPlayerDressing', function(dressing)

--           local elements = {}

--           for i=1, #dressing, 1 do
--             table.insert(elements, {label = dressing[i], value = i})
--           end

--           ESX.UI.Menu.Open(
--             'default', GetCurrentResourceName(), 'player_dressing',

--             {

--             css = 'suburban',

--               title    = _U('player_clothes'),
--               align    = 'top-left',
--               elements = elements,
--             },
--             function(data, menu)

--               TriggerEvent('skinchanger:getSkin', function(skin)

--                 ESX.TriggerServerCallback('esx_eden_clotheshop:getPlayerOutfit', function(clothes)

--                   TriggerEvent('skinchanger:loadClothes', skin, clothes)
--                   TriggerEvent('esx_skin:setLastSkin', skin)

--                   TriggerEvent('skinchanger:getSkin', function(skin)
--                     TriggerServerEvent('esx_skin:save', skin)
--                   end)
				  
-- 				  ESX.ShowNotification("Suburban\n~g~Tenue chargée.")
-- 				  HasLoadCloth = true

--                 end, data.current.value)

--               end)

--             end,
--             function(data, menu)
--               menu.close()
			  
-- 			  CurrentAction     = 'shop_menu'
-- 			  CurrentActionMsg  = "Appuyez sur ~INPUT_PICKUP~ pour parler à ~b~Lana"
-- 			  CurrentActionData = {}
--             end
--           )

--         end)

--       end
	  
-- 	  if data.current.value == 'suppr_cloth' then
-- 		ESX.TriggerServerCallback('esx_eden_clotheshop:getPlayerDressing', function(dressing)
-- 			local elements = {}

-- 			for i=1, #dressing, 1 do
-- 				table.insert(elements, {label = dressing[i], value = i})
-- 			end
			
-- 			ESX.UI.Menu.Open(
--             'default', GetCurrentResourceName(), 'supprime_cloth',

--             {

--             css = 'suburban',
             
--               title    = _U('suppr_cloth'),
--               align    = 'top-left',
--               elements = elements,
--             },
--             function(data, menu)
-- 			menu.close()
-- 				TriggerServerEvent('esx_eden_clotheshop:deleteOutfit', data.current.value)
				  
-- 				ESX.ShowNotification("Suburban\n~r~Tenue supprimée.")

--             end,
--             function(data, menu)
--               menu.close()
			  
-- 			  CurrentAction     = 'shop_menu'
-- 			  CurrentActionMsg  = "Appuyez sur ~INPUT_PICKUP~ pour parler à ~b~Lana"
-- 			  CurrentActionData = {}
--             end
--           )
-- 		end)
-- 	  end

--     end,
--     function(data, menu)

--       menu.close()

--       CurrentAction     = 'room_menu'
--       CurrentActionMsg  = "Appuyez sur ~INPUT_PICKUP~ pour parler à ~b~Lana"
--       CurrentActionData = {}
--     end
--   )

-- end

-- AddEventHandler('esx_eden_clotheshop:hasEnteredMarker', function(zone)
-- 	CurrentAction     = 'shop_menu'
-- 	CurrentActionMsg  = "Appuyez sur ~INPUT_PICKUP~ pour parler à ~b~Lana"
-- 	CurrentActionData = {}
-- end)

-- AddEventHandler('esx_eden_clotheshop:hasExitedMarker', function(zone)
	
-- 	ESX.UI.Menu.CloseAll()
-- 	CurrentAction = nil

-- 	if not HasPayed then
-- 		if not HasLoadCloth then 

-- 			--[[ TriggerEvent('esx_skin:getLastSkin', function(skin)
-- 				TriggerEvent('skinchanger:loadSkin', skin)
-- 			end) ]]
-- 		end

-- 	end

-- end)

-- -- Create Blips
-- -- Citizen.CreateThread(function()

-- -- 	for i=1, #Config.ShopsC, 1 do

-- -- 		local blip = AddBlipForCoord(Config.ShopsC[i].x, Config.ShopsC[i].y, Config.ShopsC[i].z)

-- -- 		SetBlipSprite (blip, 73)
-- -- 		SetBlipScale(blip, 0.75)
-- -- 		SetBlipColour (blip, 62)
-- -- 		SetBlipAsShortRange(blip, true)
-- -- 		BeginTextCommandSetBlipName("STRING")
-- -- 		AddTextComponentString("Magasin de vêtements")
-- -- 		EndTextCommandSetBlipName(blip)
-- -- 	end

-- -- end)

-- -- local posmagasinsuburb = {
-- --     {x = -1193.16, y = -767.98, z = 17.32},
-- --     {x = -822.42, y = -1073.55, z = 11.33},
-- --     {x = 75.34, y = -1393.00, z = 29.38},
-- --     {x = -709.86, y = -153.1, z = 37.42},
-- --     {x = -163.37, y = -302.73, z = 39.73},
-- --     {x = 425.59, y = -806.15, z = 29.49},
-- --     {x = -1450.42, y = -237.66, z = 49.81},
-- --     {x = 4.87, y = 6512.46, z = 31.88},
-- --     {x = 125.77, y = -223.9, z = 54.56},
-- --     {x = 1693.92, y = 4822.82, z = 42.06},
-- --     {x = 614.19, y = 2762.79, z = 42.09},
-- --     {x = 1196.61, y = 2710.25, z = 38.22},
-- --     {x = -3170.54, y = 1043.68, z = 20.86},
-- --     {x = -1101.48, y = 2710.57, z = 19.11}
-- -- }

-- -- Enter / Exit marker events
-- -- Citizen.CreateThread(function()
-- -- 	while true do
-- -- 		local attente = 500

-- -- 		local coords      = GetEntityCoords(GetPlayerPed(-1))
-- -- 		local isInMarker  = false
-- -- 		local currentZone = nil

-- --         for k,v in pairs(posmagasinsuburb) do
-- --             if not IsPedInAnyVehicle(GetPlayerPed(-1), false) then 
-- --                 if(GetDistanceBetweenCoords(coords, posmagasinsuburb[k].x, posmagasinsuburb[k].y, posmagasinsuburb[k].z, true) < 10.0) then
-- --                     attente = 5
-- --                     if(GetDistanceBetweenCoords(coords, posmagasinsuburb[k].x, posmagasinsuburb[k].y, posmagasinsuburb[k].z, true) < 2.0) then
-- --                         attente = 1
-- --                         isInMarker  = true
-- --                         currentZone = k
-- --                     end
-- --                 end
-- -- 			elseif IsPedInAnyVehicle(GetPlayerPed(-1), false) then 
-- -- 				attente = 2500
-- -- 			end
-- -- 		end

-- -- 		if (isInMarker and not HasAlreadyEnteredMarker) or (isInMarker and LastZone ~= currentZone) then
-- -- 			attente = 1
-- -- 			HasAlreadyEnteredMarker = true
-- -- 			LastZone                = currentZone
-- -- 			TriggerEvent('esx_eden_clotheshop:hasEnteredMarker', currentZone)
-- -- 		end

-- -- 		if not isInMarker and HasAlreadyEnteredMarker then
-- -- 			attente = 1
-- -- 			HasAlreadyEnteredMarker = false
-- -- 			TriggerEvent('esx_eden_clotheshop:hasExitedMarker', LastZone)
-- -- 		end
-- -- 		Wait(attente)
-- -- 	end
-- -- end)

-- -- Key controls
-- Citizen.CreateThread(function()
-- 	while true do

-- 		local attente = 500

-- 		if CurrentAction ~= nil then
-- 			attente = 1
-- 			SetTextComponentFormat('STRING')
-- 			AddTextComponentString(CurrentActionMsg)
-- 			DisplayHelpTextFromStringLabel(0, 0, 0, -1)

-- 			if IsControlPressed(0,  Keys['E']) and (GetGameTimer() - GUI.Time) > 300 then

-- 				if CurrentAction == 'shop_menu' then
-- 					TriggerEvent('skinchanger:getSkin', function(skin)
--                         if skin.sex > 1 then
--                             CreateMenu(VetementPed)
--                             setheader("Vêtement")
--                         else
-- 							CreateMenu(VetementNoPed)
--                             setheader("Vêtement")
--                         end
--                     end)
-- 				end

-- 				CurrentAction = nil
-- 				GUI.Time      = GetGameTimer()

-- 			end

-- 		end
-- 		Wait(attente)
-- 	end
-- end)