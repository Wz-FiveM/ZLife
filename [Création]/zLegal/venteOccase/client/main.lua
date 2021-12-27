ESX = nil

PlayerData = {}
local SpamDeFDP = false
local type = {}
local PosPlusChere = vector3(162.29, -1508.45, 29.14)
PlusChereTable = {}

function LoadSellPlace()
	Citizen.CreateThread(function()
		local SellPos = ConfigVente.SellPosition
		local Blip = AddBlipForCoord(SellPos["x"], SellPos["y"], SellPos["z"])
		SetBlipSprite (Blip, 641)
		SetBlipDisplay(Blip, 6)
		SetBlipScale  (Blip, 0.8)
		SetBlipColour (Blip, 11)
		SetBlipAsShortRange(Blip, true)
		BeginTextCommandSetBlipName("STRING")
		AddTextComponentString("Vapid occasion")
		EndTextCommandSetBlipName(Blip)

		while true do
			local sleepThread = 500

			local ped = PlayerPedId()
			local pedCoords = GetEntityCoords(ped)

			local dstCheck = GetDistanceBetweenCoords(pedCoords, SellPos["x"], SellPos["y"], SellPos["z"], true)

				if dstCheck <= 5.0 then
					_menuOccas:ProcessMenus()
					sleepThread = 5
					DrawText3D(SellPos["x"], SellPos["y"], SellPos["z"], "Appuyez sur ~b~E ~w~pour ~b~accéder au Vapid.", 9)
					DrawMarker(25, SellPos["x"], SellPos["y"], SellPos["z"]-0.98, 0.0, 0.0, 0.0, 0, 0.0, 0.0, 1.5, 1.5, 0.6, 255, 255, 255, 100, false, true, 2, false, false, false, false)
					if IsControlJustPressed(0, 38) then
						MenuPrixOccas(GetVehiclePedIsUsing(ped))
					end
			end
			Wait(sleepThread)
		end
	end)
end

_menuOccas = NativeUI.CreatePool()
OccasMenu = NativeUI.CreateMenu("Vapid occasion", "Information", 0, 0)
_menuOccas:Add(OccasMenu)
_menuOccas:WidthOffset(0)


local price = nil
function OpenSellMenu(menu, veh)
	local menuVente = NativeUI.CreateItem("Ouvrir le menu de vente", "")
	menu:AddItem(menuVente) 
	if IsPedInAnyVehicle(GetPlayerPed(-1), false) then
		if price ~= nil then
			mettrePrix = NativeUI.CreateItem("Changer le prix (~b~" .. price .. "$~s~)", "")
			menu:AddItem(mettrePrix) 
			sell = NativeUI.CreateItem("~g~Valider la mise en vente du véhicule", "")
			menu:AddItem(sell) 
		else
			mettrePrix = NativeUI.CreateItem("Entrer le prix du véhicule : ", "")
			menu:AddItem(mettrePrix) 
		end
	end

	menu.OnItemSelect = function(sender, item, index)
		if item == mettrePrix then
			DisplayOnscreenKeyboard(1, "FMMC_KEY_TIP8", "", "", "", "", "", 128 + 1)
		
			while UpdateOnscreenKeyboard() ~= 1 and UpdateOnscreenKeyboard() ~= 2 do
				Citizen.Wait(0)
			end

			local result = GetOnscreenKeyboardResult()

			if result and result ~= "" then
				price = result
				MenuPrixOccas(GetVehiclePedIsUsing(GetVehiclePedIsIn(GetPlayerPed(-1), 0)))
			else
				price = nil
			end
		elseif item == sell then
			local vehProps = ESX.Game.GetVehicleProperties(veh)
			local pPed = GetPlayerPed(-1)
			local VehName = GetDisplayNameFromVehicleModel(GetEntityModel(GetVehiclePedIsUsing(pPed)))
			ESX.TriggerServerCallback("clp_vapid:isVehicleValid", function(valid)
				if valid then
					local pPed = GetPlayerPed(-1)
					local VehName = GetDisplayNameFromVehicleModel(GetEntityModel(GetVehiclePedIsUsing(pPed)))
					local vehicle2 = GetVehiclePedIsIn(GetPlayerPed(-1), false)
					local vehicleClass = GetVehicleClass(vehicle2)


					if vehicleClass == 0 then
						type = 'Compacts'
					elseif vehicleClass == 1 then
						type = 'Sedans'
					elseif vehicleClass == 2 then
						type = 'SUV'
					elseif vehicleClass == 3 then
						type = 'Coupes'
					elseif vehicleClass == 4 then
						type = 'Muscle'
					elseif vehicleClass == 5 then
						type = 'Sportive Classique'
					elseif vehicleClass == 6 then
						type = 'Sportive'
					elseif vehicleClass == 7 then
						type = 'Super sportive'
					elseif vehicleClass == 8 then
						type = 'Moto'
					elseif vehicleClass == 9 then
						type = 'Offroad'
					elseif vehicleClass == 10 then
						type = 'Industrial'
					elseif vehicleClass == 11 then
						type = 'Utilitaire'
					elseif vehicleClass == 12 then
						type = 'Vans'
					elseif vehicleClass == 13 then
						type = 'Vélo'
					else
						type = 'Inconnu'
					end
					SetEntityAsNoLongerNeeded(veh)
					DeleteEntity(veh)
					ESX.ShowNotification("~g~Votre véhicule (~b~"..VehName.."~g~) vient d'être mis en vente. (~b~" .. price .. "$~g~).")
					TriggerServerEvent("AnnounceVenteVehicule", price, VehName, type)
					_menuPool:CloseAllMenus()
				else
					ESX.ShowNotification("~r~Le véhicule ne vous appartient pas.")
				end
			end, vehProps, price, VehName)
		elseif item == menuVente then
			_menuOccas:CloseAllMenus()
			MenuOccas()
		end
	end
end


_menuOccas:RefreshIndex()
_menuOccas:MouseControlsEnabled (false);
_menuOccas:MouseEdgeEnabled (false);
_menuOccas:ControlDisablingEnabled(false);



function MenuPrixOccas(veh)
    OccasMenu:Clear()
    OpenSellMenu(OccasMenu, veh)
	OccasMenu:Visible(not OccasMenu:Visible())
end
