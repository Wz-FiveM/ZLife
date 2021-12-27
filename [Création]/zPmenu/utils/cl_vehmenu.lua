local a, b, c, d, e, f, g = {}, {}, {}, {}, {}, {}, {}
local h, i, j, k, l, m = false, false, false, false, false, false;
local n, o, p, q, r, s;
d.isDragged = false;
ESX = nil;
locksound = false;
onDuty = false;
Citizen.CreateThread(function()
    while ESX == nil do
        TriggerEvent('esx:getSharedObject', function(t)
            ESX = t
        end)
        Citizen.Wait(0)
    end
    while ESX.GetPlayerData().job == nil do
        Citizen.Wait(10)
    end
    a = ESX.GetPlayerData()
end)
local u;
function avantgauche()
    local v = GetPlayerPed(-1)
    local w = GetVehiclePedIsIn(v, false)
    if IsPedSittingInAnyVehicle(v) then
        if GetVehicleDoorAngleRatio(w, 0) > 0.0 then
            if u then
                RemoveNotification(u)
            end
            u = ShowAboveRadarMessage("Porte ~g~avant gauche~s~ fermée.")
            SetVehicleDoorShut(w, 0, false)
        else
            if u then
                RemoveNotification(u)
            end
            u = ShowAboveRadarMessage("Porte ~g~avant gauche~s~ ouverte.")
            SetVehicleDoorOpen(w, 0, false)
            frontleft = true
        end
    end
end
function avantdroite()
    local v = GetPlayerPed(-1)
    local w = GetVehiclePedIsIn(v, false)
    if IsPedSittingInAnyVehicle(v) then
        if GetVehicleDoorAngleRatio(w, 1) > 0.0 then
            if u then
                RemoveNotification(u)
            end
            u = ShowAboveRadarMessage("Porte ~g~avant droite~s~ fermée.")
            SetVehicleDoorShut(w, 1, false)
        else
            if u then
                RemoveNotification(u)
            end
            u = ShowAboveRadarMessage("Porte ~g~avant droite~s~ ouverte.")
            SetVehicleDoorOpen(w, 1, false)
            frontleft = true
        end
    end
end
function arrieregauche()
    local v = GetPlayerPed(-1)
    local w = GetVehiclePedIsIn(v, false)
    if IsPedSittingInAnyVehicle(v) then
        if GetVehicleDoorAngleRatio(w, 2) > 0.0 then
            if u then
                RemoveNotification(u)
            end
            u = ShowAboveRadarMessage("Porte ~g~arrière gauche~s~ fermées.")
            SetVehicleDoorShut(w, 2, false)
        else
            if u then
                RemoveNotification(u)
            end
            u = ShowAboveRadarMessage("Porte ~g~arrière gauche~s~ ouverte.")
            SetVehicleDoorOpen(w, 2, false)
            frontleft = true
        end
    end
end
function arrieredroite()
    local v = GetPlayerPed(-1)
    local w = GetVehiclePedIsIn(v, false)
    if IsPedSittingInAnyVehicle(v) then
        if GetVehicleDoorAngleRatio(w, 3) > 0.0 then
            if u then
                RemoveNotification(u)
            end
            u = ShowAboveRadarMessage("Porte ~g~arrière droite~s~ fermée.")
            SetVehicleDoorShut(w, 3, false)
        else
            if u then
                RemoveNotification(u)
            end
            u = ShowAboveRadarMessage("Porte ~g~arrière droite~s~ ouverte.")
            SetVehicleDoorOpen(w, 3, false)
            frontleft = true
        end
    end
end
function capot()
    local v = GetPlayerPed(-1)
    local w = GetVehiclePedIsIn(v, false)
    if IsPedSittingInAnyVehicle(v) then
        if GetVehicleDoorAngleRatio(w, 4) > 0.0 then
            if u then
                RemoveNotification(u)
            end
            u = ShowAboveRadarMessage("~g~Capot~s~ fermé.")
            SetVehicleDoorShut(w, 4, false)
        else
            if u then
                RemoveNotification(u)
            end
            u = ShowAboveRadarMessage("~g~Capot~s~ ouvert.")
            SetVehicleDoorOpen(w, 4, false)
            frontleft = true
        end
    end
end
function coffre()
    local v = GetPlayerPed(-1)
    local w = GetVehiclePedIsIn(v, false)
    if IsPedSittingInAnyVehicle(v) then
        if GetVehicleDoorAngleRatio(w, 5) > 0.0 then
            if u then
                RemoveNotification(u)
            end
            u = ShowAboveRadarMessage("~g~Coffre~s~ fermé.")
            SetVehicleDoorShut(w, 5, false)
        else
            if u then
                RemoveNotification(u)
            end
            u = ShowAboveRadarMessage("~g~Coffre~s~ ouvert.")
            SetVehicleDoorOpen(w, 5, false)
            frontleft = true
        end
    end
end
AddEventHandler('window_open', function(x)
    local y = GetPlayerPed(-1)
    local z = GetVehiclePedIsIn(y, false)
    if IsPedSittingInAnyVehicle(y) then
        if x == 1 then
            RollDownWindow(z, 1)
        elseif x == 2 then
            RollDownWindow(z, 0)
        elseif x == 3 then
            RollDownWindow(z, 3)
        elseif x == 4 then
            RollDownWindow(z, 2)
        elseif x == 5 then
            RollUpWindow(z, 0)
            RollUpWindow(z, 1)
            RollUpWindow(z, 2)
            RollUpWindow(z, 3)
        end
    else
    end
end)
local buttonSeat = { [157] = -1, [158] = 0, [160] = 1, [164] = 2, [165] = 3, [159] = 4, [161] = 5, [162] = 6, [163] = 7 }
local blockShuffle = true

Citizen.CreateThread(function()
	local canDoDriveBy = true
	local IsVehicleDriveable = IsVehicleDriveable
	local GetEntitySpeed = GetEntitySpeed
	local GetPedInVehicleSeat = GetPedInVehicleSeat
	local GetIsTaskActive = GetIsTaskActive

    while true do
        local attente = 500

		local Player = LocalPlayer()
		local ped, veh = Player.Ped, Player:GetVehicle()

        if veh and IsVehicleDriveable(veh) then
            attente = 1
			local max, broken = GetVehicleNumberOfWheels(veh), 0
			for i = 0, max do
				if IsVehicleTyreBurst(veh, i) then
					broken = broken + 1
					if broken >= math.floor(max * 0.5) then SetVehicleUndriveable(veh, true) break end
				end
			end
		end

        if veh then
            attente = 1
			local vehicleSpeed = GetEntitySpeed(veh)
			if vehicleSpeed <= 13.88 then
				if not canDoDriveBy and GetPedInVehicleSeat(veh, -1) == ped then
					SetPlayerCanDoDriveBy(Player.ID, true)
					canDoDriveBy = true
				end

				if UpdateOnscreenKeyboard() ~= 0 then
					for key, seat in pairs(buttonSeat) do
						if IsDisabledControlJustPressed(1, key) and IsVehicleSeatFree(veh, seat) and (GetPedInVehicleSeat(veh, -1) ~= ped or vehicleSpeed <= 11.11) then
							SetPedIntoVehicle(ped, veh, seat)
							blockShuffle = seat == 0
							Citizen.Wait(2000)
						end
					end
				end
			else
				if canDoDriveBy and GetPedInVehicleSeat(veh, -1) == ped then
					SetPlayerCanDoDriveBy(Player.ID, false)
					canDoDriveBy = false
				elseif not canDoDriveBy then
					SetPlayerCanDoDriveBy(Player.ID, true)
					canDoDriveBy = true
				end
			end

			if blockShuffle and GetPedInVehicleSeat(veh, 0) == ped and GetIsTaskActive(ped, 165) then
				SetPedIntoVehicle(ped, veh, 0)
			end
        end
        Wait(attente)
	end
end)

local N = true;
function statutmoteur()
    N = not N;
    if not N then
        SetVehicleEngineOn(GetVehiclePedIsIn(GetPlayerPed(-1), false), false, false, true)
        SetVehicleUndriveable(GetVehiclePedIsIn(GetPlayerPed(-1), false), true)
    elseif N then
        SetVehicleEngineOn(GetVehiclePedIsIn(GetPlayerPed(-1), false), true, false, true)
        SetVehicleUndriveable(GetVehiclePedIsIn(GetPlayerPed(-1), false), false)
    end
end
function vehicleType(O)
    local P = Config.Vehicles;
    for J = 1, #P, 1 do
        if IsVehicleModel(O, GetHashKey(P[J])) then
            return true
        end
    end
end
local Q = {"Allumer", "Eteindre"}
local R = {"Avant Droite", "Avant Gauche", "Arrière Droite", "Arrière Gauche", "Capot", "Coffre"}
local S = {"Avant Droite", "Avant Gauche", "Arrière Droite", "Arrière Gauche", "Fermer toutes les fenêtres"}
local T = {"Démarrer", "Couper"}
local U = {"Aucun", "Vitesse actuelle", "50", "75", "110", "130"}
local V = {"État du moteur", "État de la carrosserie", "Litre d'essence", "État du réservoir",
           "Température du moteur", "Information du véhicule"}
local W = {
    Base = {
        Header = {"commonmenu", "interaction_bgd"},
        Color = {color_black},
        HeaderColor = {3, 198, 255},
        Title = "Véhicule"
    },
    Data = {
        currentMenu = "Liste des options",
        ""
    },
    Events = {
        onSelected = function(self, X, Y, Z, _, a0, a1, a2, a3, a4)
            local a4 = Y.slidenum;
            local Y = Y.name;
            local a5 = Y.unkCheckbox;
            local a6, a7 = ESX.Game.GetClosestPlayer()
            local pPed = LocalPlayer()
            local v = PlayerPedId()
            local a8 = GetEntityCoords(v)
            local a9 = GetPlayerPed(-1)
            local z = GetVehiclePedIsIn(GetPlayerPed(-1), false)
            local aa = GetVehiclePedIsIn(a9, false)
            local ab = GetVehicleHealth(aa)
            local ac = math.ceil(GetEntitySpeed(aa) * 3.6)
            local ad = GetVehicleFuelLevel(aa)
            local ae = GetVehicleTank(aa)
            local af = GetVehicleCaro(aa)
            local ag = GetVehicleEngineTemperature(aa)
            if Y == "Moteur" then
                OpenMenu('Moteur')
            elseif a4 == 1 and Y == "Portes" then
                avantdroite()
            elseif a4 == 2 and Y == "Portes" then
                avantgauche()
            elseif a4 == 3 and Y == "Portes" then
                arrieredroite()
            elseif a4 == 4 and Y == "Portes" then
                arrieregauche()
            elseif a4 == 5 and Y == "Portes" then
                capot()
            elseif a4 == 6 and Y == "Portes" then
                coffre()
            elseif a4 == 1 and Y == "Fenêtres" then
                TriggerEvent('window_open', 2)
            elseif a4 == 2 and Y == "Fenêtres" then
                TriggerEvent('window_open', 1)
            elseif a4 == 3 and Y == "Fenêtres" then
                TriggerEvent('window_open', 4)
            elseif a4 == 4 and Y == "Fenêtres" then
                TriggerEvent('window_open', 3)
            elseif a4 == 5 and Y == "Fenêtres" then
                TriggerEvent('window_open', 5)
            elseif a4 == 1 and Y == "Régulateur de vitesse" then
                if u then
                    RemoveNotification(u)
                end
                u = ShowAboveRadarMessage("Régulateur de vitesse ~b~supprimé~s~.")
                SetEntityMaxSpeed(GetVehiclePedIsIn(a9, false), 1000.0 / 3.6)
            elseif a4 == 2 and Y == "Régulateur de vitesse" then
                if u then
                    RemoveNotification(u)
                end
                local ah = GetEntitySpeed(GetVehiclePedIsIn(a9, false))
                SetEntityMaxSpeed(GetVehiclePedIsIn(a9, false), ah)
                u = ShowAboveRadarMessage("Régulateur de vitesse défini sur : ~b~Vitesse actuelle~s~.")
            elseif a4 == 3 and Y == "Régulateur de vitesse" then
                if u then
                    RemoveNotification(u)
                end
                u = ShowAboveRadarMessage("Régulateur de vitesse défini sur : ~b~50Km/h~s~.")
                SetEntityMaxSpeed(GetVehiclePedIsIn(a9, false), 50.0 / 3.6)
            elseif a4 == 4 and Y == "Régulateur de vitesse" then
                if u then
                    RemoveNotification(u)
                end
                u = ShowAboveRadarMessage("Régulateur de vitesse défini sur : ~b~75Km/h~s~.")
                SetEntityMaxSpeed(GetVehiclePedIsIn(a9, false), 75.0 / 3.6)
            elseif a4 == 5 and Y == "Régulateur de vitesse" then
                if u then
                    RemoveNotification(u)
                end
                u = ShowAboveRadarMessage("Régulateur de vitesse défini sur : ~b~110Km/h~s~.")
                SetEntityMaxSpeed(GetVehiclePedIsIn(a9, false), 110.0 / 3.6)
            elseif a4 == 6 and Y == "Régulateur de vitesse" then
                if u then
                    RemoveNotification(u)
                end
                u = ShowAboveRadarMessage("Régulateur de vitesse défini sur : ~b~130Km/h~s~.")
                SetEntityMaxSpeed(GetVehiclePedIsIn(a9, false), 130.0 / 3.6)
            elseif a4 == 1 and Y == "Mégaphone" then
                if vehicleType(GetVehiclePedIsUsing(GetPlayerPed(-1))) then
                    OpenMenu('Mégaphone')
                else
                    ShowAboveRadarMessage("~r~Votre véhicule ne possède aucun mégaphone.")
                end
            elseif Y == "Activer la conduite automatique" then
                local G = GetVehiclePedIsIn(GetPlayerPed(-1), false)
                ihKb(G)
            elseif Y == "Status du moteur" then
                statutmoteur()
            elseif a4 == 1 and Y == "Information du véhicule" then
                if u then
                    RemoveNotification(u)
                end
                u = ShowAboveRadarMessage("État du moteur : ~b~" .. ab .. "%")
            elseif a4 == 2 and Y == "Information du véhicule" then
                if u then
                    RemoveNotification(u)
                end
                u = ShowAboveRadarMessage("État de la carrosserie : ~b~" .. af .. "%")
            elseif a4 == 3 and Y == "Information du véhicule" then
                if u then
                    RemoveNotification(u)
                end
                u = ShowAboveRadarMessage("Litre d'essence : ~b~" .. ad .. "")
            elseif a4 == 4 and Y == "Information du véhicule" then
                if u then
                    RemoveNotification(u)
                end
                u = ShowAboveRadarMessage("État du réservoir : ~b~" .. ae .. "%")
            elseif a4 == 5 and Y == "Information du véhicule" then
                if u then
                    RemoveNotification(u)
                end
                u = ShowAboveRadarMessage("Température du moteur : ~b~" .. ag .. "")
            elseif a4 == 6 and Y == "Information du véhicule" then
                if u then
                    RemoveNotification(u)
                end
                u = ShowAboveRadarMessage("Modèle : ~b~" ..
                                              GetLabelText(GetDisplayNameFromVehicleModel(GetEntityModel(aa))) ..
                                              "\n~s~Plaque : ~b~" .. GetVehicleNumberPlateText(aa) .. "")
            elseif Y == "Jeter l'ancre" then 
                local Veh=pPed:GetVehicle()
                if GetEntitySpeed(Veh)*3.6 >10 then ShowAboveRadarMessage("~r~Vous devez être à l'arrêt.") return end;
                local umyCNfj=not N_0xb0ad1238a709b1a2(Veh)
                N_0xe3ebaae484798530(Veh,true)
                SetBoatAnchor(Veh,umyCNfj)
                ShowAboveRadarMessage(umyCNfj and"Vous avez ~g~jeté~w~ l'ancre."or"Vous avez ~r~levé~w~ l'ancre.")
            end
        end
    },
    Menu = {
        ["Liste des options"] = {
            b = {{
                name = "Status du moteur",
                checkbox = false
            },             {
                name = "Jeter l'ancre",
                checkbox = false,
                canSee = function() return IsPedInAnyBoat(GetPlayerPed(-1)) end,
            },{
                name = "Fenêtres",
                slidemax = S,
                canSee = function() return not IsPedInAnyBoat(GetPlayerPed(-1)) end,
            }, {
                name = "Portes",
                slidemax = R,
                canSee = function() return not IsPedInAnyBoat(GetPlayerPed(-1)) end,
            }, {
                name = "Régulateur de vitesse",
                slidemax = U
            }, {
                name = "Activer la conduite automatique",
                ask = ">",
                askX = true,
                canSee = function() return not IsPedInAnyBoat(GetPlayerPed(-1)) end,
            }, {
                name = "Information du véhicule",
                slidemax = V
            }}
        },
        ["Moteur"] = {
            b = {{
                name = "Gestion moteur",
                slidemax = T
            }, {
                name = "Vérifier l'état du moteur"
            }, {
                name = "Vérifier la température du moteur"
            }}
        },
        ["Mégaphone"] = {
            b = {{
                name = "Conducteur Stop !"
            }, {
                name = "Arrêter votre putain de voiture"
            }, {
                name = "Arrêter vous immédiatement"
            }}
        }
    }
}
local ai = false;
local aj;
function ihKb(ak)
    local al = GetFirstBlipInfoId(8)
    if not ai and (not al or al == 0) then
        ShowAboveRadarMessage("~r~Vous devez placer un marqueur sur la carte.")
        return
    end
    ai = not ai;
    local am = GetPlayerPed(-1)
    if ai then
        local an = GetBlipInfoIdCoord(al)
        TaskVehicleDriveToCoordLongrange(am, ak, an, 25.0, 1076369579, 10.0)
    else
        ClearPedTasks(am)
    end
    if aj then
        RemoveNotification(aj)
    end
    aj = ShowAboveRadarMessage("Vous avez " .. (ai and "~g~activé" or "~r~désactivé") ..
                                   "~w~ la conduite automatique.")
end
RegisterControlKey("controlcar", "Ouvrir les options de véhicule", "F11", function()
    if IsPedInAnyVehicle(GetPlayerPed(-1)) then
        CreateMenu(W)
        setheader("Véhicule")
    end
end)
