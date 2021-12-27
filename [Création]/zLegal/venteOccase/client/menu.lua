local objets = {}
local nomChercher = "Aucun nom" -- Useless pour l'instant
local VehiculeTable = {}
local owner = nil
local prixActuel = 0
local pause = false
local CloneNPC = nil
local loaded = false

Citizen.CreateThread(function()
	while ESX == nil do
		Citizen.Wait(10)

		TriggerEvent("esx:getSharedObject", function(response)
            ESX = response
		end)
	end

	if ESX.IsPlayerLoaded() then
        ESX.TriggerServerCallback('occas:GetVeh', function(vehicles)
            VehiculeTable = vehicles
        end)
        ESX.TriggerServerCallback('occas:GetOwner', function(id)
            owner = id
        end)
    end
    LoadSellPlace()
end)


RegisterNetEvent("esx:playerLoaded")
AddEventHandler("esx:playerLoaded", function(response)
    TriggerEvent("occase:ActualiseListVeh")
end)


RegisterNetEvent("occase:ActualiseListVeh")
AddEventHandler("occase:ActualiseListVeh", function()
    ESX.TriggerServerCallback('occas:GetVeh', function(vehicles)
        VehiculeTable = vehicles
    end)
    ESX.TriggerServerCallback('occas:GetOwner', function(id)
        owner = id
    end) 
end)
_menuPool = NativeUI.CreatePool()
mainMenu = NativeUI.CreateMenu("Vapid occasion", "Liste des occasions", 0, 0)
_menuPool:Add(mainMenu)
_menuPool:WidthOffset(0)


function MenuOccasVente(mainMenu)

    local vehiclePropsList = {}
    local VehTestCoords = vector3(-1389.82, -471.77, 78.200)
    local veh = ESX.Game.GetClosestVehicle(VehTestCoords)
    local distance = GetDistanceBetweenCoords(VehTestCoords, GetEntityCoords(veh), true)
    if veh ~= nil and distance < 3.0 then
        ESX.Game.DeleteVehicle(veh)
    end

    local pPed = GetPlayerPed(-1)
    local pCoords = GetEntityCoords(pPed)

	for k,v in ipairs(VehiculeTable) do
        local vehicleProps = json.decode(v.vehicleProps)
		vehiclePropsList[vehicleProps.plate] = vehicleProps
		local vehicleHash = vehicleProps.model
		local vehicleName = GetDisplayNameFromVehicleModel(vehicleHash)
		label = ('%s | %s %s | %s | %s$'):format(vehicleName, v.firstname, v.lastname, vehicleProps.plate, v.price)
		objets[vehicleProps.plate] = NativeUI.CreateItem(label, '')
		mainMenu:AddItem(objets[vehicleProps.plate]) 
	end

	mainMenu.OnItemSelect = function(sender, item, index)
		for k,v in ipairs(VehiculeTable) do
			local vehicleProps = json.decode(v.vehicleProps)
			vehiclePropsList[vehicleProps.plate] = vehicleProps
			local vehicleHash = vehicleProps.model
			local vehicleName = GetDisplayNameFromVehicleModel(vehicleHash)
            if item == objets[vehicleProps.plate] then
                local veh = ESX.Game.GetClosestVehicle(VehTestCoords)
                local distance = GetDistanceBetweenCoords(VehTestCoords, GetEntityCoords(veh), true)
                if veh ~= nil and distance < 3.0 then
                    ESX.Game.DeleteVehicle(veh)
                end
                LoadModel(vehicleHash)
                local vehTest = CreateVehicle(vehicleHash, -1389.82, -471.77, 78.200-1.0, GetEntityHeading(GetPlayerPed(-1)), false, 1)
                ESX.Game.SetVehicleProperties(vehTest, vehicleProps)
                TaskWarpPedIntoVehicle(PlayerPedId(), vehTest, -1)
                FreezeEntityPosition(vehTest, 1)
                SetVehicleDirtLevel(vehTest, 0.0)
                prixActuel = v.price
            end
        end
    end
end



local dejaTP = true
local oldCoords = nil
Citizen.CreateThread(function()
    while true do
        local attente = 500
        while ESX == nil do
            Citizen.Wait(10)
        end
        _menuPool:ProcessMenus()
        
        if _menuPool:IsAnyMenuOpen() then
            attente = 1
            if IsPedInAnyVehicle(GetPlayerPed(-1), false) then
                local pPed = GetPlayerPed(-1)
                local pCoords = GetEntityCoords(pPed)
                ESX.DrawMissionText("[E] Pour ~b~essayer le véhicule.\n~s~[F1] Pour ~g~acheter le véhicule. (~g~"..prixActuel.."$)", 50)

                if IsControlJustReleased(0, 38) then
                    TestVehicule()
                end
                if IsControlJustReleased(0, 288) then
                    Achats()
                end
                SetEntityVisible(PlayerPedId(), true, true)
            else
                SetEntityVisible(PlayerPedId(), false, false)
            end
            for _, i in ipairs(GetActivePlayers()) do
                local distance = GetDistanceBetweenCoords(GetEntityCoords(GetPlayerPed(i), 1), GetEntityCoords(PlayerPedId(), 1), 1)
                if distance <= 10.0 then
                    SetEntityVisible(GetPlayerPed(i), 0, 0)
                    SetEntityNoCollisionEntity(GetPlayerPed(i), GetPlayerPed(-1), false)
                end
            end
        elseif not dejaTP then
            dejaTP = true
            SetEntityCoords(GetPlayerPed(-1), oldCoords, 0.0, 0.0, 0.0, false)
            FreezeEntityPosition(GetPlayerPed(-1), 0)
            SetEntityVisible(PlayerPedId(), true, true)
            while DoesEntityExist(TempNpc) do
                SetEntityAsNoLongerNeeded(TempNpc)
                DeleteEntity(TempNpc)
                Wait(10)
            end 
            for _, i in ipairs(GetActivePlayers()) do
                local distance = GetDistanceBetweenCoords(GetEntityCoords(GetPlayerPed(i), 1), GetEntityCoords(PlayerPedId(), 1), 1)
                if distance <= 10.0 then
                    SetEntityVisible(GetPlayerPed(i), 1, 1)
                    SetEntityNoCollisionEntity(GetPlayerPed(i), GetPlayerPed(-1), true)
                end
            end   
        end    
        Wait(attente)
    end
end)

function Achats()
    local pPed = GetPlayerPed(-1)
    local TestVeh = GetVehiclePedIsIn(pPed, false)
    local VehName = GetDisplayNameFromVehicleModel(GetEntityModel(GetVehiclePedIsUsing(pPed)))

    ESX.TriggerServerCallback("clp_vapid:buyVehicle", function(isPurchasable, totalMoney, erreur)
        if erreur then
            ShowAboveRadarMessage("~b~Vapid\n~r~Le vendeur n'a pas été trouvé, aucune vente ne sera possible.")
        else
            if isPurchasable then
                ShowAboveRadarMessage("~b~Vapid~n~~s~Le véhicule ~b~"..VehName.."~s~ est désormais en fourrière.")
                _menuPool:CloseAllMenus()
            else
                ShowAboveRadarMessage("~b~Vapid\n~s~Il vous manque (~r~".. prixActuel - totalMoney .."$~s~) pour pouvoir acheter le véhicule.")
            end
        end
    end, ESX.Game.GetVehicleProperties(TestVeh), prixActuel)
end
function StartMusicEvent(event)
	PrepareMusicEvent(event)
	return TriggerMusicEvent(event) == 1
end
function TestVehicule()
    pause = true
    StartMusicEvent("EPS6_START")
    ESX.AddTimerBar("TEMPS RESTANT :",{endTime=GetGameTimer()+60*1000*0.50})
    local pPed = GetPlayerPed(-1)
    local TestVeh = GetVehiclePedIsIn(pPed, false)
    SetPedCoordsKeepVehicle(pPed, -1896.0, -3049.6, 13.96)
    FreezeEntityPosition(pPed, 0)
    FreezeEntityPosition(TestVeh, 0)
    ShowAboveRadarMessage("~b~Vapid\n~s~Vous avez ~b~30~s~ secondes pour essayer le véhicule.")
    EnPause()
    Citizen.Wait(30*1000)
    FreezeEntityPosition(pPed, 1)
    FreezeEntityPosition(TestVeh, 1)
    if IsPedInAnyVehicle(pPed, false) then
        SetPedCoordsKeepVehicle(pPed, -1389.82, -471.77, 78.200-1.0)
    else
        TaskWarpPedIntoVehicle(PlayerPedId(), TestVeh, -1)
        SetPedCoordsKeepVehicle(pPed, -1389.82, -471.77, 78.200-1.0)
    end
    SetVehicleOnGroundProperly(TestVeh)
    ShowAboveRadarMessage("~b~Vapid\n~s~L'essai du véhicule est terminé.")
    StartMusicEvent("MP_MC_ASSAULT_ADV_STOP")
    ESX.RemoveTimerBar()
    pause = false
end

function EnPause()
    Citizen.CreateThread(function()
        while pause do
            Citizen.Wait(1)
            for _, i in ipairs(GetActivePlayers()) do
                local distance = GetDistanceBetweenCoords(GetEntityCoords(GetPlayerPed(i), 1), GetEntityCoords(PlayerPedId(), 1), 1)
                if distance <= 10.0 then
                    SetEntityVisible(GetPlayerPed(i), 0, 0)
                    SetEntityVisible(PlayerPedId(), true, true)
                    SetEntityNoCollisionEntity(GetPlayerPed(i), GetPlayerPed(-1), false)
                end
            end
        end
    end)
end

LoadModel = function(model)
	while not HasModelLoaded(model) do
        RequestModel(model)
        local pPed = GetPlayerPed(-1)
        local pCoords = GetEntityCoords(pPed)
        ESX.DrawMissionText("~r~Le modèle charge..", 1000)
		Citizen.Wait(1)
	end
end


_menuPool:RefreshIndex()
_menuPool:MouseControlsEnabled (false);
_menuPool:MouseEdgeEnabled (false);
_menuPool:ControlDisablingEnabled(false);



function MenuOccas()
    oldCoords = GetEntityCoords(GetPlayerPed(-1))
    mainMenu:Clear()
    MenuOccasVente(mainMenu)
    
    while not HasModelLoaded(GetHashKey("mp_f_boatstaff_01")) do
        RequestModel(GetHashKey("mp_f_boatstaff_01"))
        Wait(10)
    end
    TempNpc = CreatePed(28, GetHashKey("mp_f_boatstaff_01"), -1393.08, -469.07, 77.20, 218.0, false, 1)
    SetEntityHeading(TempNpc, 218.0)
    TaskStartScenarioInPlace(TempNpc, "CODE_HUMAN_MEDIC_TIME_OF_DEATH", 0, false)
    SetBlockingOfNonTemporaryEvents(TempNpc, 1)

    SetEntityCoords(GetPlayerPed(-1), -1389.82, -471.77, 78.200-1.0, 0.0, 0.0, 0.0, 0)
    

    FreezeEntityPosition(GetPlayerPed(-1), 1)
    mainMenu:Visible(not mainMenu:Visible())
    dejaTP = false
end
