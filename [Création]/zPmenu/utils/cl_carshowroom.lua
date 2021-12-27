ESX = nil
local PlayerData              = {}

Citizen.CreateThread(function()
    while ESX == nil do
        TriggerEvent('esx:getSharedObject', function(obj)
            ESX = obj
            print(obj)
        end)
        Citizen.Wait(0)
	end
	while ESX.GetPlayerData().job == nil do
		Citizen.Wait(10)
    end
    PlayerData = ESX.GetPlayerData()
end)

RegisterNetEvent('esx:playerLoaded')
AddEventHandler('esx:playerLoaded', function(xPlayer)
  PlayerData = xPlayer
end)

RegisterNetEvent('esx:setJob')
AddEventHandler('esx:setJob', function(job)
  PlayerData.job = job
end)

local O3_X, DVs8kf2w = {
    veh = 0
}
local vms5 = {
    ["veh"] = {
        name = "Concessionnaire voitures",
        pos = {showRoom = {{x = -791.341, y = -218.5151, z = 37.414, a = 215.169, dist = 6}}},
    },
    ["heli"] = {
        name = "Concessionnaire hélicoptères",
        pos = {showRoom=  {{x = -766.185, y = -1450.59, z = 5.0, a = 0.0, dist=6}}},
    },
    ["plane"] = {
        name = "Concessionnaire avions",
        pos = {showRoom=  {{x = -1274.19, y = -3385.99, z = 13.94, a = 0.0, dist=7}}},
    },
    ["boat"] = {
        name = "Concessionnaire bateaux",
        pos = {showRoom=  {{x = -890.56,  y = -1454.88,  z = -0.6, a = 106.45, dist = 7}}},
    }
}
local function M7()
    if DoesEntityExist(O3_X.car) then
        DeleteVehicle(O3_X.car)
    end
    if HasScaleformMovieLoaded(O3_X.s) then
        SetScaleformMovieAsNoLongerNeeded(O3_X.s)
    end
    O3_X = {
        veh = false
    }
end
local function v3(W_63_9, h9dyA_4T)
    local oh
    for DZXGTh, Su9Koz in pairs(W_63_9 or {}) do
        if not oh or GetDistanceBetweenCoords(Su9Koz.x, Su9Koz.y, Su9Koz.z, h9dyA_4T) <
            GetDistanceBetweenCoords(oh.x, oh.y, oh.z, h9dyA_4T) then
            oh = Su9Koz
        end
    end
    return oh
end

local TimeMissionLimit = 60*1000*20
local possibleSpawn = {
    {pos = vector3(-223.04, -1329.68, 30.88-0.95),heading = 270.34,},
    {pos = vector3(733.32, -1082.44, 22.16-0.95),heading = 181.15,},
    {pos = vector3(1141.68, -773.0, 57.64-0.95),heading = 268.99,},
    {pos = vector3(118.68, 6599.48, 32.0-0.95),heading = 271.48,},
    {pos = vector3(1776.36, 3335.96, 41.2-0.95),heading = 210.84,},
    {pos = vector3(1176.88, 2650.24, 37.8-0.95),heading = 275.07,},
    {pos = vector3(-1128.76, -1998.12, 13.16-0.95),heading = 225.99,},
}
local stop = vector3(-83.12, 81.08, 71.52)

function LivrerVehicule(LongText, vehicule, possibleSpawn, stop, prix)
    ESX.AddTimerBar("TEMPS RESTANT :",{endTime=GetGameTimer()+TimeMissionLimit})
    ShowAboveRadarMessage("~b~Concessionnaire\n~s~"..LongText)
    local i = math.random(1, #possibleSpawn)
    local spawn = possibleSpawn[i].pos
    local heading = possibleSpawn[i].heading

    local blip = createBlip(spawn ,326,3,"Véhicule",true,1.0)
    local pPed = GetPlayerPed(-1)
    local pVeh = GetVehiclePedIsIn(pPed, false)
    local pCoords = GetEntityCoords(pPed)
    local dst = GetDistanceBetweenCoords(spawn, pCoords, true)

    local flt = vector3(-93.52, 84.96, 71.68)
    local flat = SpawnVehNotIn("flatbed", flt, 149.82, "FLATBED")

    while dst >= 30.0 do
        Wait(100)
        pCoords = GetEntityCoords(pPed)
        dst = GetDistanceBetweenCoords(spawn, pCoords, true)
    end
    local coords = {x=spawn.x,y=spawn.y,z=spawn.z}
    AddTextEntry("VOLE_VEH_MISSION", "Véhicule à récupérer.")
    SpawnVehNotIn(vehicule, spawn, heading, "CONCESS1")

    while dst >= 3.0 do
        Wait(1)
        ShowFloatingHelp("VOLE_VEH_MISSION", spawn)
        pCoords = GetEntityCoords(pPed)
        DrawMarker(0,spawn.x,spawn.y,spawn.z+2.6,0.0,0.0,0.0,0.0,0.0,0.0,1.0,1.0,0.7,0,192,255,70,0,0,2,0,0,0,0)
        dst = GetDistanceBetweenCoords(spawn, pCoords, true)
    end

    DeleteVehi()
    RemoveBlip(blip)

    local blip = AddBlipForCoord(stop)
    SetBlipRoute(blip, 1)
    
    local dst = GetDistanceBetweenCoords(stop, pCoords, true)
    PlaySoundFrontend(-1, "Object_Dropped_Remote", "GTAO_FM_Events_Soundset", 0)
    ShowAboveRadarMessage("~b~Concessionnaire\n~s~Récupérez le véhicule.")
    while dst >= 5.0 do
        Wait(1)
        pCoords = GetEntityCoords(pPed)
        dst = GetDistanceBetweenCoords(pCoords, stop, true)
    end

    local plate = GetVehicleNumberPlateText(GetVehiclePedIsIn(GetPlayerPed(-1), 0))
    local pEngine = GetVehicleEngineHealth(GetVehiclePedIsIn(GetPlayerPed(-1)))
    if plate == "CONCESS1" then 
        if pEngine > 750 then 
            ESX.RemoveTimerBar()
            PlaySoundFrontend(-1, "Out_Of_Bounds_Timer", "DLC_HEISTS_GENERAL_FRONTEND_SOUNDS", 0)
            ShowAboveRadarMessage("~b~Concessionnaire\n~s~L'entreprise a reçu l'argent.")
            RemoveBlip(blip)
            SetBlipRoute(blip, 0)
            TaskVehicleTempAction(GetPlayerPed(-1), GetVehiclePedIsIn(GetPlayerPed(-1), 0), 6, 2000)
            Wait(2000)
            TaskLeaveAnyVehicle(GetPlayerPed(-1), 0, 0)
            SetVehicleDoorsLocked(GetVehiclePedIsIn(GetPlayerPed(-1), 1), 1)
            TriggerServerEvent("clp_mission:givemoneysociety", prix, "society_cardealer")
            gain = prix
            Wait(3500)
            DeleteVehi()
        else 
            ShowAboveRadarMessage("~b~Concessionnaire\n~s~Votre véhicule est trop abimé.")
            ESX.RemoveTimerBar()
            PlaySoundFrontend(-1, "Out_Of_Bounds_Timer", "DLC_HEISTS_GENERAL_FRONTEND_SOUNDS", 0)
            RemoveBlip(blip)
            SetBlipRoute(blip, 0)
            TaskVehicleTempAction(GetPlayerPed(-1), GetVehiclePedIsIn(GetPlayerPed(-1), 0), 6, 2000)
            Wait(2000)
            TaskLeaveAnyVehicle(GetPlayerPed(-1), 0, 0)
            SetVehicleDoorsLocked(GetVehiclePedIsIn(GetPlayerPed(-1), 1), 1)
            Wait(3500)
            DeleteVehi()
        end
    else
        ESX.RemoveTimerBar()
        PlaySoundFrontend(-1, "Out_Of_Bounds_Timer", "DLC_HEISTS_GENERAL_FRONTEND_SOUNDS", 0)
        RemoveBlip(blip)
        SetBlipRoute(blip, 0)
        ShowAboveRadarMessage("~b~Concessionnaire\n~s~Ce n'est pas le bon véhicule.")
        TaskLeaveAnyVehicle(GetPlayerPed(-1), 0, 0)
        Wait(3500)
        DeleteVehi()
    end
end

local CurrentVehicleData = nil
local ihKb = {}
local function JGSK(Uk7e, KwQCk_G, ptZa, PEqsd)
    local iSj = string.lower(ptZa.name)
    if ptZa.veh then
        if isJob('cardealer') then
            local FsYIVlkf = O3_X.car;
            ihKb = ptZa.veh
            Uk7e:OpenMenu("valider achat")
        else
            ShowAboveRadarMessage("~r~Veuillez vous addresser à un concessionnaire.")
        end
    elseif KwQCk_G.currentMenu == "valider achat" then
        if iSj == "~r~annuler" then
            if not ptZa.veh then
                M7()
                Uk7e:CloseMenu()
                return
            end
            ihKb = nil
        elseif iSj == "~g~acheter" then 
            if isJob('cardealer') and not isJobGrad('recruit') then
                ESX.TriggerServerCallback('esx_vehicleshop:buyVehicleSociety', function(hasEnoughMoney)
                    if hasEnoughMoney then
                        IsInShopMenu = false

                        local playerPed = PlayerPedId()

                        ESX.ShowNotification("~g~Vous venez d'acheter un véhicule : ~b~"..ihKb.."~g~.")
                    else
                        ESX.ShowNotification("~r~Vous n'avez pas assez d'argent dans la société pour acheter ce véhicule.")
                    end
                end, 'cardealer', ihKb)
            else
                ShowAboveRadarMessage("~r~Vous n'avez pas le grade requis pour acheter un véhicule.")
        end
        elseif iSj == "~y~tester" then 
            M7()
            local nvaIsNv7 = Uk7e.Data.Pos
            createPersoVeh(ihKb, {}, "TEST-VEH", -1,v3(nvaIsNv7.spawnPos2 or nvaIsNv7.spawnPos or nvaIsNv7.showRoom, GetEntityCoords(GetPlayerPed(-1))))
            Uk7e:CloseMenu()
        elseif iSj == "~g~vendre" then 
            local closestPlayer, closestDistance = ESX.Game.GetClosestPlayer()
            if isJob('cardealer') and not isJobGrad('recruit') then
                ESX.TriggerServerCallback('esx_vehicleshop:buyVehicleSociety', function(hasEnoughMoney)
                    if hasEnoughMoney then
                        if closestPlayer == -1 or closestDistance > 2.5 then return ShowAboveRadarMessage('~b~Distance\n~w~Rapprochez-vous.') end
                            local pLate = KeyboardInput("Plaque", '', 8)
                            local nvaIsNv7 = Uk7e.Data.Pos
                            M7()
                            Uk7e:CloseMenu()
                            vehg  = createPersoVeh(ihKb, {}, pLate, 1,v3(nvaIsNv7.spawnPos2 or nvaIsNv7.spawnPos or nvaIsNv7.showRoom, GetEntityCoords(GetPlayerPed(-1))))
                            local model = GetDisplayNameFromVehicleModel(GetEntityModel(vehg))
                            local vehicleProps = ESX.Game.GetVehicleProperties(vehg)
                            vehicleProps.plate = GetVehicleNumberPlateText(vehg)
                            TriggerServerEvent('esx_vehicleshop:sellVehicle', model)
                            TriggerServerEvent('esx_vehicleshop:setVehicleOwnedPlayerId', GetPlayerServerId(closestPlayer), vehicleProps)
                            for i = 1, 10 do
                                TriggerServerEvent('esx_vehiclelock:registerkey', vehicleProps.plate, GetPlayerServerId(closestPlayer))
                            end

                            print(model)
                            print(vehicleProps)
                            print(vehicleProps.plate)

                            ESX.ShowNotification("Le véhicule ~g~"..vehicleProps.plate.."~s~ a été attribué à ~g~"..GetPlayerName(closestPlayer).."~s~")
                        --end
                    else
                        ESX.ShowNotification("~r~Vous n'avez pas assez d'argent dans la société pour acheter ce véhicule.")
                    end
                end, 'cardealer', ihKb)
            else
                ShowAboveRadarMessage("~r~Vous n'avez pas le grade requis pour acheter un véhicule.")
        end
        elseif iSj == "~g~Acheter pour soi même" then
            if isJob('cardealer') and not isJobGrad('recruit') then
                ESX.TriggerServerCallback('esx_vehicleshop:buyVehicleSociety', function(hasEnoughMoney)
                    if hasEnoughMoney then
                        IS_DEV = true
                        local closestPlayer = PlayerId()
                        if closestPlayer then 
                            local pLate = KeyboardInput("Plaque", '', 8)
                            local nvaIsNv7 = Uk7e.Data.Pos
                            M7()
                            Uk7e:CloseMenu()
                            vehg  = createPersoVeh(ihKb, {}, pLate, 1,v3(nvaIsNv7.spawnPos2 or nvaIsNv7.spawnPos or nvaIsNv7.showRoom, GetEntityCoords(GetPlayerPed(-1))))
                            local model = GetDisplayNameFromVehicleModel(GetEntityModel(vehg))
                            local vehicleProps = ESX.Game.GetVehicleProperties(vehg)
                            vehicleProps.plate = GetVehicleNumberPlateText(vehg)
                            TriggerServerEvent('esx_vehicleshop:sellVehicle', model)
                            TriggerServerEvent('esx_vehicleshop:setVehicleOwnedPlayerId', GetPlayerServerId(closestPlayer), vehicleProps)
                            TriggerServerEvent('esx_vehiclelock:registerkey', vehicleProps.plate, GetPlayerServerId(closestPlayer))

                            print(model)
                            print(vehicleProps)
                            print(vehicleProps.plate)

                            ESX.ShowNotification("Le véhicule ~g~"..vehicleProps.plate.."~s~ a été attribué à ~g~"..GetPlayerName(closestPlayer).."~s~")
                        end
                    else
                        ESX.ShowNotification("~r~Vous n'avez pas assez d'argent dans la société pour acheter ce véhicule.")
                    end
                end, 'cardealer', ihKb)
            else
                ShowAboveRadarMessage("~r~Vous n'avez pas le grade requis pour acheter un véhicule.")
        end
        elseif iSj == "faire une facture" then 
            CreateFacture("society_cardealer")
        elseif iSj == "passer une annonce" then 
			local amount = KeyboardInput("Annonce", "", 250)
			if amount ~= nil then
				amount = string.len(amount)
				if amount >= 10 then 
					TriggerServerEvent('clp_cardealer:annoncecardealer',result)  
				else
					ShowAboveRadarMessage("~r~Votre message est trop court.")
				end
			end
        elseif iSj == "~y~livrer" then 
            M7()
            Uk7e:CloseMenu()
            LivrerVehicule("Allez chercher le véhicule avec le Flatbed sur le parking.", ihKb, possibleSpawn, stop, 500) 
        elseif iSj == "~r~mettre en fourière" then 
            local playerPed = GetPlayerPed(-1)
            local PlayerCoords = GetEntityCoords(playerPed)
            local YVLXYq = GetClosestVehicle(PlayerCoords.x, PlayerCoords.y, PlayerCoords.z, 5.0, 0, 71)
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
        end
    end
end
local function rA5U(Hs)
    local jk = vms5[DVs8kf2w] and vms5[DVs8kf2w].pos and vms5[DVs8kf2w].pos;
    if not jk or not jk.showRoom then
        return
    end
    Hs.Pos = jk
end
function GetVehicleNameFromModel(Su9Koz)
    local Uk7e=GetDisplayNameFromVehicleModel(Su9Koz)
    local KwQCk_G=GetLabelText(Uk7e)
    if KwQCk_G~="NULL"then 
        return KwQCk_G 
    end
    if Uk7e~="CARNOTFOUND"then 
        return Uk7e 
    end;
    return Su9Koz 
end;
function CreateVehicleStatsScaleform(qzSFyIO, Z65)
    local umyCNfj = GetHashKey(Z65)
    local FT = GetVehicleNameFromModel(umyCNfj)
    local bJfct = GetVehicleModelMaxSpeed(umyCNfj) * 1.25
    local OhuFpq_N = GetVehicleModelAcceleration(umyCNfj) * 200
    local Dzg = GetVehicleModelMaxBraking(umyCNfj) * 100
    local _4O = GetVehicleModelMaxTraction(umyCNfj) * 25
    return createScaleform("mp_car_stats_01", {{
        name = "SET_VEHICLE_INFOR_AND_STATS",
        param = {GetLabelText(FT),GetVehicleModelMaxNumberOfPassengers(Z65) .. " places", "MPCarHUD","Annis", "Vitesse max", "Accélération", "Frein", "Suspension", bJfct, OhuFpq_N, Dzg, _4O}
    }})
end

local Uc06 = false
local function lcBL(C, fLI2zRe, _Fr2YU, Xfn, U)
    if C ~= "valider achat" and Xfn and Xfn.veh and (not O3_X.veh or O3_X.veh ~= Xfn.veh) and U.Data.Pos then
        if DoesEntityExist(O3_X.car) then
            DeleteEntity(O3_X.car)
        end
        if HasScaleformMovieLoaded(O3_X.s) then
            SetScaleformMovieAsNoLongerNeeded(O3_X.s)
        end
        local Ebsw = v3(U.Data.Pos.spawnPos2 or U.Data.Pos.showRoom, GetEntityCoords(GetPlayerPed(-1)))
        local UlikV = GetHashKey(Xfn.veh)
        if IsModelInCdimage(UlikV) and Ebsw and not DoesEntityExist(O3_X.car) and not Uc06 then
            Citizen.CreateThread(function()
                Uc06 = true;
                RequestAndWaitModel(UlikV)
                if not HasModelLoaded(UlikV) then
                    Uc06 = false;
                    return
                end
                local JtAjijkG = CreateVehicle(UlikV, Ebsw.x, Ebsw.y, Ebsw.z, Ebsw.a, false, false)
                O3_X = {
                    veh = Xfn.veh,
                    car = JtAjijkG
                }
                while not DoesEntityExist(JtAjijkG) do
                    Citizen.Wait(0)
                end
                SetEntityNoCollisionEntity(JtAjijkG, 0, false)
                SetEntityCollision(JtAjijkG, 0, 0)
                SetModelAsNoLongerNeeded(UlikV)
                FreezeEntityPosition(JtAjijkG, true)
                SetEntityInvincible(JtAjijkG, true)
                SetVehicleDoorsLocked(JtAjijkG, 4)
                for s = 0, 24 do
                    SetVehicleModKit(JtAjijkG, 0)
                    RemoveVehicleMod(JtAjijkG, s)
                end
                O3_X.s = CreateVehicleStatsScaleform(JtAjijkG, Xfn.veh)
                Uc06 = false
            end)
        end
    end
end
local DHPxI = .9
local dx = {(10 * 0.8) * DHPxI, (6 * 0.8) * DHPxI, 1 * DHPxI}
local function RRuSHnxf()
    local YAtG_LV3 = O3_X.car;
    if not YAtG_LV3 or not DoesEntityExist(YAtG_LV3) then
        return
    end

    if O3_X.s and HasScaleformMovieLoaded(O3_X.s) then
        local LfEJbh_ = GetEntityCoords(YAtG_LV3)
        local JD = GetEntityHeight(YAtG_LV3, LfEJbh_.x, LfEJbh_.y, LfEJbh_.z, true, false)
        DrawScaleformMovie_3dNonAdditive(O3_X.s, LfEJbh_.x, LfEJbh_.y, LfEJbh_.z + 2.4 + JD, GetGameplayCamRot(0), 0.0,1.0, 0.0, dx[1], dx[2], dx[3], 0)
    end
end
local mcYOuT = {
    b = {{ 
        name = "~g~Vendre", 
    }, {
        name = "~y~Tester",
    }, {
        name = "~y~Livrer",
    }, {
        name = "~r~Mettre en fourière",
    }, {
        name = "~g~Acheter pour soi même",
    }, {
        name = "Faire une facture",
    }, {
        name = "Passer une annonce",
    }, {
        name = "~r~Annuler"
    }}
}
local Rr = {
    Base = {
        Header = {"shopui_title_ie_modgarage", "shopui_title_ie_modgarage"}, HeaderColor = {255, 255, 255}
    },
    Data = {
        currentMenu = "catalogue"
    },
    Events = {
        onOpened = rA5U,
        onRender = RRuSHnxf,
        onSelected = JGSK,
        onButtonSelected = lcBL,
        onExited = M7,
        setBonus = function(u)
            local pzDMZwG = u.price or u.veh and u.price
            if pzDMZwG then
                pzDMZwG = math.ceil(pzDMZwG * 1.3)
            end
            return pzDMZwG and string.format(" $%s", pzDMZwG)
        end,
        onBack = M7
    },
    Menu = {}
}
local scRP0 = {
    ["boat"] = {
        ["valider achat"] = mcYOuT,
        ["catalogue"] = {
            useFilter = true,
            b = {{
                name = "Dinghy 2 places",
                veh = "dinghy2",
                price = 8000
            }, {
                name = "Dinghy 4 places",
                veh = "dinghy",
                price = 9070
            }, {
                name = "Jetmax",
                veh = "jetmax",
                price = 17000
            }, {
                name = "Marquis",
                veh = "marquis",
                price = 25000
            }, {
                name = "Seashark",
                veh = "seashark",
                price = 4600
            }, {
                name = "Speeder",
                veh = "speeder",
                price = 19000
            }, {
                name = "Squalo",
                veh = "squalo",
                price = 13000
            }, {
                name = "Suntrap",
                veh = "suntrap",
                price = 12000
            }, {
                name = "Toro",
                veh = "toro",
                price = 18000
            }, {
                name = "Tropic",
                veh = "tropic",
                price = 12120
            }}
        }
    },
    ["plane"] = {
        ["valider achat"] = mcYOuT,
        ["catalogue"] = {
            useFilter = true,
            b = {{
                name = "Alpha-Z1",
                veh = "alphaz1",
                price = 310000
            }, {
                name = "Cuban 800",
                veh = "cuban800",
                price = 225000
            }, {
                name = "Dodo",
                veh = "dodo",
                price = 275000
            }, {
                name = "Duster",
                veh = "duster",
                price = 300000
            }, {
                name = "Howard NX-25",
                veh = "howard",
                price = 320000
            }, {
                name = "Luxor",
                veh = "luxor",
                price = 650000
            }, {
                name = "Luxor deluxe",
                veh = "luxor2",
                price = 680000
            }, {
                name = "Mallard",
                veh = "stunt",
                price = 96500
            }, {
                name = "Mammatus",
                veh = "mammatus",
                price = 375000
            }, {
                name = "Nimbus",
                veh = "nimbus",
                price = 600000
            }, {
                name = "Rogue",
                veh = "rogue",
                price = 275000
            }, {
                name = "Seabreeze",
                veh = "seabreeze",
                price = 135000
            }, {
                name = "Shamal",
                veh = "shamal",
                price = 164500
            }, {
                name = "ULM",
                veh = "microlight",
                price = 26500
            }, {
                name = "Velum",
                veh = "velum",
                price = 410000
            }, {
                name = "Velum",
                veh = "velum2",
                price = 460000
            }, {
                name = "Vestra",
                veh = "vestra",
                price = 325000
            }}
        }
    },
    ["heli"] = {
        ["valider achat"] = mcYOuT,
        ["catalogue"] = {
            useFilter = true,
            b = {{
                name = "Buzzard",
                veh = "buzzard2",
                price = 458230
            }, {
                name = "Cargobob",
                veh = "cargobob2",
                price = 605000
            }, {
                name = "Frogger",
                veh = "frogger",
                price = 352500
            }, {
                name = "Havok",
                veh = "havok",
                price = 120000
            }, {
                name = "Maverick",
                veh = "maverick",
                price = 335260
            }, {
                name = "SuperVolito Carbone",
                veh = "supervolito2",
                price = 525000
            }, {
                name = "Swift Simple",
                veh = "swift",
                price = 595000
            }, {
                name = "Swift Deluxe",
                veh = "swift2",
                price = 555000
            }, {
                name = "Volatus",
                veh = "volatus",
                price = 610000
            }}
        }
    },
    ["veh"] = {
        ["catalogue"] = {
            b = {{
                name = "Summer"
            }, {
                name = "Casino"
            }, {
                name = "Berlines"
            },{
                name = "Compacts"
            }, {
                name = "Coupes"
            }, {
                name = "Muscles"
            }, {
                name = "Off-Road"
            }, {
                name = "Sports"
            }, {
                name = "Sports Classics"
            }, {
                name = "Super"
            }, {
                name = "SUV"
            }, {
                name = "Vans"
            }, {
                name = "Motos"
            }, {
                name = "Bikes"
            }, {
                name = "Services"
            }, {
                name = "Tuner"
            }}
        },
        ["valider achat"] = mcYOuT,
        ["summer"] = {
            useFilter = true,
            b = {{
                name = "Invetero Coquette D10",
                veh = "coquette4",
                price = 125000
            }, {
                name = "Lampadati Tigon",
                veh = "tigon",
                price = 96500
            }, {
                name = "Maibatsu Penumbra",
                veh = "penumbra2",
                price = 12500
            },{
                name = "Dundreary Landstalker",
                veh = "landstalker2",
                price = 56250
            },{
                name = "Yosemite Ranchez",
                veh = "yosemite3",
                price = 36600
            },{
                name = "BF Club",
                veh = "club",
                price = 9850
            },{
                name = "Gauntlet Classic Custom",
                veh = "gauntlet5",
                price = 29400
            },{
                name = "Imponte Beater Dukes",
                veh = "dukes3",
                price = 22730
            },{
                name = "Youga Classic 4x4",
                veh = "youga3",
                price = 23000
            },{
                name = "Benefactor Glendale Custom",
                veh = "glendale2",
                price = 11050
            },{
                name = "Canis Seminole Frontier",
                veh = "seminole2",
                price = 18200
            },{
                name = "Vapid Peyote Custom",
                veh = "peyote3",
                price = 20260
            },{
                name = "Albany Manana Custom",
                veh = "manana2",
                price = 15710
            }}
        },
        ["casino"] = {
            useFilter = true,
            b = {{
                name = "Retinue custom",
                veh = "retinue2",
                price = 34600
            }, {
                name = "Caracara custom",
                veh = "caracara2",
                price = 36500
            },{
                name = "Thrax",
                veh = "thrax",
                price = 215000
            },{
                name = "Novak",
                veh = "Novak",
                price = 24500
            },{
                name = "Zorrusso",
                veh = "zorrusso",
                price = 168500
            },{
                name = "Issi 7",
                veh = "issi7",
                price = 19600
            },{
                name = "Locust",
                veh = "locust",
                price = 152500
            },{
                name = "Stryder",
                veh = "stryder",
                price = 32150
            },{
                name = "Emerus",
                veh = "emerus",
                price = 186500
            },{
                name = "Hellion",
                veh = "hellion",
                price = 24500
            },{
                name = "Dynasty",
                veh = "Dynasty",
                price = 14550
            },{
                name = "Gauntlet 3",
                veh = "gauntlet3",
                price = 17500
            },{
                name = "Nebula",
                veh = "nebula",
                price = 21350
            },{
                name = "Zion 3",
                veh = "zion3",
                price = 26350
            },{
                name = "Drafter",
                veh = "drafter",
                price = 54250
            },{
                name = "Asbo",
                veh = "asbo",
                price = 9850
            },{
                name = "Kanjo",
                veh = "kanjo",
                price = 14250
            },{
                name = "Imorgon",
                veh = "imorgon",
                price = 186500
            },{
                name = "Paragon",
                veh = "paragon",
                price = 94500
            },{
                name = "Jugular",
                veh = "jugular",
                price = 75620
            },{
                name = "Rrocket",
                veh = "rrocket",
                price = 23250
            },{
                name = "Neo",
                veh = "neo",
                price = 76420
            },{
                name = "Krieger",
                veh = "krieger",
                price = 164500
            },{
                name = "Peyote custom",
                veh = "peyote2",
                price = 18260
            },{
                name = "Gauntlet 4",
                veh = "gauntlet4",
                price = 26400
            },{
                name = "Everon",
                veh = "everon",
                price = 32500
            },{
                name = "Sugoi",
                veh = "Sugoi",
                price = 34250
            },{
                name = "Rebla",
                veh = "rebla",
                price = 43250
            },{
                name = "Furia",
                veh = "furia",
                price = 172300
            },{
                name = "VSTR",
                veh = "vstr",
                price = 64250
            },{
                name = "Komoda",
                veh = "komoda",
                price = 123000
            },{
                name = "Dewbauch",
                veh = "jb7002",
                price = 14600
            },{
                name = "Sultan custom",
                veh = "sultan2",
                price = 26400
            },{
                name = "Yosemite custom",
                veh = "yosemite2",
                price = 33600
            },{
                name = "Vagrant",
                veh = "vagrant",
                price = 38500
            },{
                name = "Outlaw",
                veh = "outlaw",
                price = 16500
            }}
        },
        ["muscles"] = {
            useFilter = true,
            b = {{
                name = "BF Injection",
                veh = "bfinjection",
                price = 12120
            }, {
                name = "Blade",
                veh = "blade",
                price = 9000
            }, {
                name = "Buccaneer",
                veh = "buccaneer",
                price = 12000
            }, {
                name = "Buccaneer Custom",
                veh = "buccaneer2",
                price = 17000
            }, {
                name = "Chino",
                veh = "chino",
                price = 16520
            }, {
                name = "Chino Custom",
                veh = "chino2",
                price = 11000
            }, {
                name = "Coquette BlackFin",
                veh = "coquette3",
                price = 100000
            }, {
                name = "Deviant",
                veh = "deviant",
                price = 20000
            }, {
                name = "Dune Loader",
                veh = "dloader",
                price = 7260
            }, {
                name = "Dominator",
                veh = "dominator",
                price = 27600
            }, {
                name = "Dominator Pisswasser",
                veh = "dominator2",
                price = 31200
            }, {
                name = "Dominator GTX",
                veh = "dominator3",
                price = 55000
            }, {
                name = "Dukes",
                veh = "dukes",
                price = 18730
            }, {
                name = "Dune Buggy",
                veh = "dune",
                price = 19400
            }, {
                name = "Ellie",
                veh = "ellie",
                price = 206000
            }, {
                name = "Faction",
                veh = "faction",
                price = 14260
            }, {
                name = "Faction Custom",
                veh = "faction2",
                price = 18190
            }, {
                name = "Faction Donk",
                veh = "faction3",
                price = 20930
            }, {
                name = "Gauntlet",
                veh = "gauntlet",
                price = 20000
            }, {
                name = "Gauntlet Redwood",
                veh = "gauntlet2",
                price = 23000
            }, {
                name = "Hermes",
                veh = "hermes",
                price = 16000
            }, {
                name = "Hotknife",
                veh = "hotknife",
                price = 26500
            }, {
                name = "Impaler",
                veh = "impaler",
                price = 12000
            }, {
                name = "Imperator",
                veh = "imperator",
                price = 24500
            }, {
                name = "Journey",
                veh = "journey",
                price = 10000
            }, {
                name = "Nightshade",
                veh = "nightshade",
                price = 85000
            }, {
                name = "Phoenix",
                veh = "phoenix",
                price = 90000
            }, {
                name = "Picador",
                veh = "picador",
                price = 13710
            }, {
                name = "Rat Loader Rouillé",
                veh = "ratloader",
                price = 8500
            }, {
                name = "Rat Truck",
                veh = "ratloader2",
                price = 11000
            }, {
                name = "Ruiner",
                veh = "ruiner",
                price = 17620
            }, {
                name = "Sabre Turbo",
                veh = "sabregt",
                price = 22600
            }, {
                name = "Sabre GT",
                veh = "sabregt2",
                price = 31200
            }, {
                name = "Tracteur",
                veh = "scrap",
                price = 8590
            }, {
                name = "Stallion",
                veh = "stalion",
                price = 14870
            }, {
                name = "Stallion Burger Shot",
                veh = "stalion2",
                price = 27000
            }, {
                name = "Tampa",
                veh = "tampa",
                price = 24250
            }, {
                name = "Tampa Drift",
                veh = "tampa2",
                price = 45000
            }, {
                name = "Tracteur",
                veh = "tractor",
                price = 7680
            }, {
                name = "Tracteur 2",
                veh = "tractor2",
                price = 8000
            }, {
                name = "Tulip",
                veh = "tulip",
                price = 18000
            }, {
                name = "Vamos",
                veh = "vamos",
                price = 15500
            }, {
                name = "Vigero",
                veh = "vigero",
                price = 10620
            }, {
                name = "Virgo",
                veh = "virgo",
                price = 10080
            }, {
                name = "Virgo Classique",
                veh = "virgo2",
                price = 13000
            }, {
                name = "Virgo Classique Custom",
                veh = "virgo3",
                price = 11000
            }, {
                name = "Voodoo Custom",
                veh = "voodoo",
                price = 11620
            }, {
                name = "Voodoo Epave",
                veh = "voodoo2",
                price = 10240
            }, {
                name = "Yosemite",
                veh = "yosemite",
                price = 27600
            }, {
                name = "Moon Beam",
                veh = "moonbeam",
                price = 16030
            }, {
                name = "SlamVan",
                veh = "slamvan",
                price = 12650
            }, {
                name = "Slamvan Custom",
                veh = "slamvan3",
                price = 26000
            }, {
                name = "Slamvan Lost",
                veh = "slamvan2",
                price = 20350
            }}
        },
        ["berlines"] = {
            useFilter = true,
            b = {{
                name = "Asea",
                veh = "asea",
                price = 4050
            }, {
                name = "Asterope",
                veh = "asterope",
                price = 4950
            }, {
                name = "Cognoscenti",
                veh = "cognoscenti",
                price = 20000
            }, {
                name = "Emperor",
                veh = "emperor",
                price = 4050
            }, {
                name = "Emperor Rouillé",
                veh = "emperor2",
                price = 3650
            }, {
                name = "Fugitive",
                veh = "fugitive",
                price = 18730
            }, {
                name = "Glendale",
                veh = "glendale",
                price = 4050
            }, {
                name = "Ingot",
                veh = "ingot",
                price = 5250
            }, {
                name = "Intruder",
                veh = "intruder",
                price = 6860
            }, {
                name = "Premier",
                veh = "premier",
                price = 4250
            }, {
                name = "Primo",
                veh = "primo",
                price = 6700
            }, {
                name = "Primo Custom",
                veh = "primo2",
                price = 14870
            }, {
                name = "Regina",
                veh = "regina",
                price = 4900
            }, {
                name = "Stafford",
                veh = "stafford",
                price = 20000
            }, {
                name = "Stanier",
                veh = "stanier",
                price = 6860
            }, {
                name = "Stratum",
                veh = "stratum",
                price = 5350
            }, {
                name = "Stretch",
                veh = "stretch",
                price = 263000
            }, {
                name = "Super Diamond",
                veh = "superd",
                price = 19600
            }, {
                name = "Surge",
                veh = "surge",
                price = 5250
            }, {
                name = "Tailgater",
                veh = "tailgater",
                price = 24250
            }, {
                name = "Warrener",
                veh = "warrener",
                price = 7260
            }, {
                name = "Washington",
                veh = "washington",
                price = 6860
            }}
        },
        ["services"] = {
            useFilter = true,
            b = {{
                name = "CVPI police",
                veh = "police",
                price = 12500
            },{
                name = "Dodge police",
                veh = "police2",
                price = 12500
            },{
                name = "Vapid Scoot",
                veh = "pscout",
                price = 5200
            },{
                name = "Explorer police",
                veh = "police3",
                price = 12500
            },{
                name = "Banalisé",
                veh = "police42",
                price = 6500
            },{
                name = "CVPI banalisé",
                veh = "police4",
                price = 5500
            },{
                name = "Moto police",
                veh = "lspdb",
                price = 3500
            },{
                name = "Riot police",
                veh = "polriot",
                price = 8500
            },{
                name = "Speedo police",
                veh = "polspeedo",
                price = 5700
            },{
                name = "Ambulance",
                veh = "ambulance",
                price = 7500
            }}
        },
        ["compacts"] = {
            useFilter = true,
            b = {{
                name = "Blista",
                veh = "blista",
                price = 3450
            }, {
                name = "Brioso R/A",
                veh = "brioso",
                price = 3000
            }, {
                name = "Caddie",
                veh = "caddy",
                price = 8650
            }, {
                name = "Caddie Abimé",
                veh = "caddy2",
                price = 7500
            }, {
                name = "Cheburek",
                veh = "cheburek",
                price = 14260
            }, {
                name = "Clique",
                veh = "clique",
                price = 9000
            }, {
                name = "Dilettante",
                veh = "dilettante",
                price = 3850
            }, {
                name = "Futo",
                veh = "futo",
                price = 7260
            }, {
                name = "Issi",
                veh = "issi2",
                price = 4450
            }, {
                name = "Issi Classique",
                veh = "issi3",
                price = 5000
            }, {
                name = "Tondeuse",
                veh = "mower",
                price = 3280
            }, {
                name = "Panto",
                veh = "panto",
                price = 3280
            }, {
                name = "Prairie",
                veh = "prairie",
                price = 5050
            }, {
                name = "Rhapsody",
                veh = "rhapsody",
                price = 4050
            }}
        },
        ["coupes"] = {
            useFilter = true,
            b = {{
                name = "Bifta",
                veh = "bifta",
                price = 19500
            }, {
                name = "Cognoscenti Cabrio",
                veh = "cogcabrio",
                price = 18000
            }, {
                name = "Exemplar",
                veh = "exemplar",
                price = 95500
            }, {
                name = "F620",
                veh = "f620",
                price = 59500
            }, {
                name = "Felon",
                veh = "felon",
                price = 27600
            }, {
                name = "Freecrawler",
                veh = "freecrawler",
                price = 26300
            }, {
                name = "Hustler",
                veh = "hustler",
                price = 11000
            }, {
                name = "Jackal",
                veh = "jackal",
                price = 15000
            }, {
                name = "Kalahari",
                veh = "kalahari",
                price = 12500
            }, {
                name = "Oracle",
                veh = "oracle",
                price = 32400
            }, {
                name = "Oracle XS",
                veh = "oracle2",
                price = 27600
            }, {
                name = "Schafter",
                veh = "schafter2",
                price = 36250
            }, {
                name = "Sentinel XS",
                veh = "sentinel",
                price = 22750
            }, {
                name = "Sentinel C",
                veh = "sentinel2",
                price = 26400
            }, {
                name = "Windsor",
                veh = "windsor",
                price = 20000
            }, {
                name = "Windsor Drop",
                veh = "windsor2",
                price = 26000
            }, {
                name = "Zion",
                veh = "zion",
                price = 15000
            }, {
                name = "Zion Cabrio",
                veh = "zion2",
                price = 41900
            }}
        },
        ["sports"] = {
            useFilter = true,
            b = {{
                name = "9F",
                veh = "ninef",
                price = 108000
            }, {
                name = "9F Cabrio",
                veh = "ninef2",
                price = 115000
            }, {
                name = "Alpha",
                veh = "alpha",
                price = 40000
            }, {
                name = "Banshee",
                veh = "banshee",
                price = 50000
            }, {
                name = "Bestia GTS",
                veh = "bestiagts",
                price = 65400
            }, {
                name = "Carbonizzare",
                veh = "carbonizzare",
                price = 50000
            }, {
                name = "Comet",
                veh = "comet2",
                price = 108000
            }, {
                name = "Comet SR",
                veh = "comet5",
                price = 125000
            }, {
                name = "Comet Retro Custom",
                veh = "comet3",
                price = 110000
            }, {
                name = "Coquette",
                veh = "coquette",
                price = 70000
            }, {
                name = "Elegy",
                veh = "elegy2",
                price = 95000
            }, {
                name = "Elegy Retro Custom",
                veh = "elegy",
                price = 83890
            }, {
                name = "Feltzer",
                veh = "feltzer2",
                price = 41900
            }, {
                name = "Furore GT",
                veh = "furoregt",
                price = 102500
            }, {
                name = "Fusilade",
                veh = "fusilade",
                price = 30000
            }, {
                name = "Itali GTO",
                veh = "italigto",
                price = 165000
            }, {
                name = "Jester",
                veh = "jester",
                price = 115000
            }, {
                name = "Jester (Course)",
                veh = "jester2",
                price = 108000
            }, {
                name = "Khamelion",
                veh = "khamelion",
                price = 96000
            }, {
                name = "Kuruma",
                veh = "kuruma",
                price = 40000
            }, {
                name = "Massacro",
                veh = "massacro",
                price = 115000
            }, {
                name = "Massacro (Course)",
                veh = "massacro2",
                price = 108000
            }, {
                name = "Lynx",
                veh = "lynx",
                price = 56250
            }, {
                name = "Pariah",
                veh = "pariah",
                price = 250000
            }, {
                name = "Raiden",
                veh = "raiden",
                price = 170600
            }, {
                name = "Rapid GT",
                veh = "rapidgt",
                price = 121000
            }, {
                name = "Rapid GT Cabrio",
                veh = "rapidgt2",
                price = 127000
            }, {
                name = "Revolter",
                veh = "revolter",
                price = 71500
            }, {
                name = "Schafter V12",
                veh = "schafter3",
                price = 35000
            }, {
                name = "Schafter LWB",
                veh = "schafter4",
                price = 52000
            }, {
                name = "Schlagen",
                veh = "schlagen",
                price = 100000
            }, {
                name = "Schwarzer",
                veh = "schwarzer",
                price = 53500
            }, {
                name = "Sentinel Classique",
                veh = "sentinel3",
                price = 32000
            }, {
                name = "Seven-70",
                veh = "seven70",
                price = 171000
            }, {
                name = "Surano",
                veh = "surano",
                price = 84000
            }, {
                name = "Verlierer",
                veh = "verlierer2",
                price = 123000
            }, {
                name = "Blista Compacts",
                veh = "blista2",
                price = 6290
            }, {
                name = "Blista GoGo Monkey",
                veh = "blista3",
                price = 6860
            }, {
                name = "Buffalo",
                veh = "buffalo",
                price = 30000
            }, {
                name = "Buffalo Sport",
                veh = "buffalo2",
                price = 40000
            }, {
                name = "Comet Safari",
                veh = "comet4",
                price = 115000
            }, {
                name = "Flash GT",
                veh = "flashgt",
                price = 35000
            }, {
                name = "Futo",
                veh = "futo",
                price = 7260
            }, {
                name = "GB200",
                veh = "gb200",
                price = 35000
            }, {
                name = "Hotring Sabre",
                veh = "hotring",
                price = 35000
            }, {
                name = "Omnis",
                veh = "omnis",
                price = 30000
            }, {
                name = "Penumbra",
                veh = "penumbra",
                price = 31800
            }, {
                name = "Streiter",
                veh = "streiter",
                price = 42000
            }, {
                name = "Sultan",
                veh = "sultan",
                price = 20400
            }, {
                name = "Tropos Rallye",
                veh = "tropos",
                price = 107000
            }}
        },
        ["sports classics"] = {
            useFilter = true,
            b = {{
                name = "190Z",
                veh = "z190",
                price = 45000
            }, {
                name = "Ardent",
                veh = "ardent",
                price = 100000
            }, {
                name = "Cheetah Classique",
                veh = "cheetah2",
                price = 200000
            }, {
                name = "Coquette Classic",
                veh = "coquette2",
                price = 90000
            }, {
                name = "Franken Stange",
                veh = "btype2",
                price = 74000
            }, {
                name = "Infernus Classique",
                veh = "infernus2",
                price = 110000
            }, {
                name = "JB 700",
                veh = "jb700",
                price = 43000
            }, {
                name = "Jester Classique",
                veh = "jester3",
                price = 170600
            }, {
                name = "Roosevelt",
                veh = "btype",
                price = 56000
            }, {
                name = "Roosevelt Valor",
                veh = "btype3",
                price = 65000
            }, {
                name = "Stinger",
                veh = "stinger",
                price = 83000
            }, {
                name = "Stinger GT",
                veh = "stingergt",
                price = 123000
            }, {
                name = "Stirling GT",
                veh = "feltzer3",
                price = 64000
            }, {
                name = "Tornado custom",
                veh = "tornado5",
                price = 27600
            }, {
                name = "Stromberg",
                veh = "stromberg",
                price = 102000
            }, {
                name = "Torero",
                veh = "torero",
                price = 197000
            }, {
                name = "Tornado classique",
                veh = "tornado",
                price = 14520
            }, {
                name = "Tornado décapotable",
                veh = "tornado2",
                price = 18730
            }, {
                name = "Turismo Classique",
                veh = "turismo2",
                price = 211000
            }, {
                name = "Viseris",
                veh = "viseris",
                price = 140000
            }, {
                name = "Z-Type",
                veh = "ztype",
                price = 130000
            }, {
                name = "Casco",
                veh = "casco",
                price = 100000
            }, {
                name = "Cheburek",
                veh = "cheburek",
                price = 14260
            }, {
                name = "Clique",
                veh = "clique",
                price = 9000
            }, {
                name = "Fagaloa",
                veh = "fagaloa",
                price = 26500
            }, {
                name = "GT500",
                veh = "gt500",
                price = 150000
            }, {
                name = "Issi Classique",
                veh = "issi3",
                price = 5000
            }, {
                name = "Mamba",
                veh = "mamba",
                price = 90000
            }, {
                name = "Manana",
                veh = "manana",
                price = 13710
            }, {
                name = "Michelli GT",
                veh = "michelli",
                price = 19500
            }, {
                name = "Monroe",
                veh = "monroe",
                price = 121900
            }, {
                name = "Peyote",
                veh = "peyote",
                price = 14260
            }, {
                name = "Pigalle",
                veh = "pigalle",
                price = 78000
            }, {
                name = "Rapid GT Classique",
                veh = "rapidgt3",
                price = 77000
            }, {
                name = "Retinue",
                veh = "retinue",
                price = 27600
            }, {
                name = "Savestra",
                veh = "savestra",
                price = 30500
            }, {
                name = "Swinger",
                veh = "swinger",
                price = 210000
            }, {
                name = "Tornado d'époque",
                veh = "tornado3",
                price = 13240
            }, {
                name = "Tornado d'époque décapotable",
                veh = "tornado4",
                price = 7260
            }, {
                name = "Tornado Rat Rod",
                veh = "tornado6",
                price = 15420
            }}
        },
        ["super"] = {
            useFilter = true,
            b = {{
                name = "Adder",
                veh = "adder",
                price = 190000
            }, {
                name = "Autarch",
                veh = "autarch",
                price = 200000
            }, {
                name = "Banshee 900R",
                veh = "banshee2",
                price = 170000
            }, {
                name = "Cheetah",
                veh = "cheetah",
                price = 210000
            }, {
                name = "Cyclone",
                veh = "cyclone",
                price = 160000
            }, {
                name = "Deveste",
                veh = "deveste",
                price = 230000
            }, {
                name = "Entity XF",
                veh = "entityxf",
                price = 195000
            }, {
                name = "Entity XXR",
                veh = "entity2",
                price = 215000
            }, {
                name = "ETR1",
                veh = "sheava",
                price = 132000
            }, {
                name = "FMJ",
                veh = "fmj",
                price = 202000
            }, {
                name = "GP1",
                veh = "gp1",
                price = 175000
            }, {
                name = "Infernus",
                veh = "infernus",
                price = 120000
            }, {
                name = "Itali GT",
                veh = "italigtb",
                price = 130000
            }, {
                name = "Itali GT Custom",
                veh = "italigtb2",
                price = 164000
            }, {
                name = "Neon",
                veh = "neon",
                price = 184400
            }, {
                name = "Nero",
                veh = "nero",
                price = 136000
            }, {
                name = "Nero Custom",
                veh = "nero2",
                price = 213000
            }, {
                name = "Osiris",
                veh = "osiris",
                price = 200000
            }, {
                name = "Reaper",
                veh = "reaper",
                price = 175000
            }, {
                name = "Ruston",
                veh = "ruston",
                price = 126000
            }, {
                name = "SC1",
                veh = "sc1",
                price = 202000
            }, {
                name = "Sultan RS",
                veh = "sultanrs",
                price = 50000
            }, {
                name = "Specter",
                veh = "specter",
                price = 103500
            }, {
                name = "Specter Custom",
                veh = "specter2",
                price = 125000
            }, {
                name = "T20",
                veh = "t20",
                price = 200000
            }, {
                name = "Taipan",
                veh = "taipan",
                price = 205000
            }, {
                name = "Tempesta",
                veh = "tempesta",
                price = 185000
            }, {
                name = "Turismo R",
                veh = "turismor",
                price = 195000
            }, {
                name = "Tyrant",
                veh = "tyrant",
                price = 193000
            }, {
                name = "Vacca",
                veh = "vacca",
                price = 95000
            }, {
                name = "Vagner",
                veh = "vagner",
                price = 189000
            }, {
                name = "Visione",
                veh = "visione",
                price = 197000
            }, {
                name = "Voltic",
                veh = "voltic",
                price = 150000
            }, {
                name = "X80 Proto",
                veh = "prototipo",
                price = 215000
            }, {
                name = "XA-21",
                veh = "xa21",
                price = 200000
            }, {
                name = "Zentorno",
                veh = "zentorno",
                price = 206000
            }}
        },
        ["off-road"] = {
            useFilter = true,
            b = {{
                name = "Blazer Street",
                veh = "blazer4",
                price = 10000
            }, {
                name = "Blazer",
                veh = "blazer",
                price = 4500
            }, {
                name = "Blazer Hot Rod",
                veh = "blazer3",
                price = 6500
            }, {
                name = "Buggy raid",
                veh = "trophytruck2",
                price = 34500
            }, {
                name = "Guardian",
                veh = "guardian",
                price = 36500
            }, {
                name = "Bodhi",
                veh = "bodhi2",
                price = 12000
            }, {
                name = "Brawler",
                veh = "brawler",
                price = 27500
            }, {
                name = "Bubsta 6x6",
                veh = "dubsta3",
                price = 121000
            }, {
                name = "Kalahari",
                veh = "kalahari",
                price = 12500
            }, {
                name = "Kamacho",
                veh = "kamacho",
                price = 60500
            }, {
                name = "Mesa Tout Terrain",
                veh = "mesa3",
                price = 30100
            }, {
                name = "Rancher XL",
                veh = "rancherxl",
                price = 39500
            }, {
                name = "Rebel",
                veh = "rebel2",
                price = 20000
            }, {
                name = "Rebel Rouillé",
                veh = "rebel",
                price = 14000
            }, {
                name = "Riata",
                veh = "riata",
                price = 37020
            }, {
                name = "Sandking XL",
                veh = "sandking",
                price = 59550
            }, {
                name = "Sandking SWB",
                veh = "sandking2",
                price = 30000
            }, {
                name = "Trophy Truck",
                veh = "trophytruck",
                price = 28500
            }}
        },
        ["suv"] = {
            useFilter = true,
            b = {{
                name = "Baller",
                veh = "baller",
                price = 25000
            }, {
                name = "Baller2",
                veh = "baller2",
                price = 35000
            }, {
                name = "Baller LE",
                veh = "baller3",
                price = 40000
            }, {
                name = "Baller LE LWB",
                veh = "baller4",
                price = 45000
            }, {
                name = "Patriot",
                veh = "patriot",
                price = 53500
            }, {
                name = "Patriot Limousine",
                veh = "patriot2",
                price = 193900
            }, {
                name = "MoonBeam Custom",
                veh = "moonbeam2",
                price = 20600
            }, {
                name = "Rocoto",
                veh = "rocoto",
                price = 26900
            }, {
                name = "Toros",
                veh = "toros",
                price = 200000
            }, {
                name = "XLS",
                veh = "xls",
                price = 21000
            }, {
                name = "Benjay XL",
                veh = "bjxl",
                price = 15000
            }, {
                name = "Cavalcade",
                veh = "cavalcade",
                price = 20000
            }, {
                name = "Cavalcade RA",
                veh = "cavalcade2",
                price = 25000
            }, {
                name = "Contender",
                veh = "contender",
                price = 90000
            }, {
                name = "Dubsta",
                veh = "dubsta",
                price = 30000
            }, {
                name = "Dubsta (V2)",
                veh = "dubsta2",
                price = 41900
            }, {
                name = "FQ2",
                veh = "fq2",
                price = 34750
            }, {
                name = "Granger",
                veh = "granger",
                price = 20000
            }, {
                name = "Gresley",
                veh = "gresley",
                price = 16000
            }, {
                name = "Habanero",
                veh = "habanero",
                price = 12000
            }, {
                name = "Huntley S",
                veh = "huntley",
                price = 20000
            }, {
                name = "Landstalker",
                veh = "landstalker",
                price = 43700
            }, {
                name = "Mesa",
                veh = "mesa",
                price = 61200
            }, {
                name = "Radius",
                veh = "radi",
                price = 24250
            }, {
                name = "Sadler",
                veh = "sadler",
                price = 17000
            }, {
                name = "Seminole",
                veh = "seminole",
                price = 13000
            }, {
                name = "Serrano",
                veh = "serrano",
                price = 22500
            }}
        },
        ["vans"] = {
            useFilter = true,
            b = {{
                name = "Minivan",
                veh = "minivan",
                price = 19830
            }, {
                name = "Pony",
                veh = "pony",
                price = 24250
            }, {
                name = "Pony SOTW",
                veh = "pony2",
                price = 28200
            }, {
                name = "Rumpo",
                veh = "rumpo",
                price = 27600
            }, {
                name = "Speedo",
                veh = "speedo",
                price = 16150
            }, {
                name = "Speedo Clown",
                veh = "speedo2",
                price = 20500
            }, {
                name = "Speedo Livery",
                veh = "speedo4",
                price = 23150
            }, {
                name = "Minivan Custom",
                veh = "minivan2",
                price = 24600
            }, {
                name = "Bison",
                veh = "bison",
                price = 12000
            }, {
                name = "Bison",
                veh = "bison3",
                price = 14000
            }, {
                name = "Bobcat XL",
                veh = "bobcatxl",
                price = 13500
            }, {
                name = "Gang Burrito Lost",
                veh = "gburrito",
                price = 17000
            }, {
                name = "Gang Burrito",
                veh = "gburrito2",
                price = 20000
            }, {
                name = "Paradise",
                veh = "paradise",
                price = 9500
            }, {
                name = "Rumpo2",
                veh = "rumpo2",
                price = 22030
            }, {
                name = "Surfer",
                veh = "surfer",
                price = 15030
            }, {
                name = "Surfer Rouille",
                veh = "surfer2",
                price = 8650
            }, {
                name = "Youga",
                veh = "youga",
                price = 18000
            }, {
                name = "Youga Classique",
                veh = "youga2",
                price = 20000
            }}
        },
        ["motos"] = {
            useFilter = true,
            b = { 
                {
                    name = "Akuma",
                    veh = "akuma",
                    price = 7500
                }, {
                    name = "Bati 801",
                    veh = "bati",
                    price = 12000
                }, {
                    name = "BF400",
                    veh = "bf400",
                    price = 6500
                }, {
                    name = "Carbon RS",
                    veh = "carbonrs",
                    price = 18000
                }, {
                    name = "Defiler",
                    veh = "defiler",
                    price = 9800
                }, {
                    name = "Diablous",
                    veh = "diablous",
                    price = 11250
                }, {
                    name = "Diablous Remastered",
                    veh = "diablous2",
                    price = 17500
                }, {
                    name = "Double T",
                    veh = "double",
                    price = 28000
                }, {
                    name = "Faggio sport",
                    veh = "faggio",
                    price = 1900
                }, {
                    name = "Faggio classique",
                    veh = "faggio2",
                    price = 2800
                }, {
                    name = "Faggio plage",
                    veh = "faggio3",
                    price = 4500
                }, {
                    name = "FCR",
                    veh = "fcr",
                    price = 18450
                }, {
                    name = "FCR Remastered",
                    veh = "fcr2",
                    price = 21500
                }, {
                    name = "Hakuchou",
                    veh = "hakuchou",
                    price = 31000
                }, {
                    name = "Hakuchou Remastered",
                    veh = "hakuchou2",
                    price = 55000
                }, {
                    name = "Lectro",
                    veh = "lectro",
                    price = 12500
                }, {
                    name = "Nemesis",
                    veh = "nemesis",
                    price = 5800
                }, {
                    name = "PCJ600",
                    veh = "pcj",
                    price = 6200
                }, {
                    name = "Ruffian",
                    veh = "ruffian",
                    price = 6800
                }, {
                    name = "Thrust",
                    veh = "thrust",
                    price = 24000
                }, {
                    name = "Vader",
                    veh = "vader",
                    price = 7200
                }, {
                    name = "Vindicator",
                    veh = "vindicator",
                    price = 23500
                }, {
                    name = "Vortex",
                    veh = "vortex",
                    price = 9800
                }, {
                    name = "Cliffhanger",
                    veh = "cliffhanger",
                    price = 9500
                }, {
                    name = "Enduro",
                    veh = "enduro",
                    price = 5500
                }, {
                    name = "Esskey",
                    veh = "esskey",
                    price = 4200
                }, {
                    name = "Deathbike",
                    veh = "deathbike",
                    price = 8650
                }, {
                    name = "Gargoyle",
                    veh = "gargoyle",
                    price = 16500
                }, {
                    name = "Manchez",
                    veh = "manchez",
                    price = 5300
                }, {
                    name = "Sanchez",
                    veh = "sanchez",
                    price = 5300
                }, {
                    name = "Sanchez",
                    veh = "sanchez2",
                    price = 5300
                }, {
                    name = "Avarus",
                    veh = "avarus",
                    price = 18000
                }, {
                    name = "Bagger",
                    veh = "bagger",
                    price = 13500
                }, {
                    name = "Chimera",
                    veh = "chimera",
                    price = 38000
                }, {
                    name = "Daemon",
                    veh = "daemon",
                    price = 11500
                }, {
                    name = "Daemon custom",
                    veh = "daemon2",
                    price = 13500
                }, {
                    name = "Hexer",
                    veh = "hexer",
                    price = 12000
                }, {
                    name = "Innovation",
                    veh = "innovation",
                    price = 23500
                }, {
                    name = "Nightblade",
                    veh = "nightblade",
                    price = 35000
                }, {
                    name = "Rat Bike",
                    veh = "ratbike",
                    price = 11250
                }, {
                    name = "Sanctus",
                    veh = "sanctus",
                    price = 25000
                }, {
                    name = "Sovereign",
                    veh = "sovereign",
                    price = 22000
                }, {
                    name = "Wolfsbane",
                    veh = "wolfsbane",
                    price = 9000
                }, {
                    name = "Zombie bobber",
                    veh = "zombiea",
                    price = 9500
                }, {
                    name = "Zombie chopper",
                    veh = "zombieb",
                    price = 12000
                }
            }
        },
        ["bikes"] = {
            useFilter = true,
            b = {{
                name = "BMX",
                veh = "bmx",
                price = 160
            }, {
                name = "Cruiser",
                veh = "cruiser",
                price = 510
            }, {
                name = "Scorcher",
                veh = "scorcher",
                price = 280
            }, {
                name = "Fixter",
                veh = "fixter",
                price = 225
            }, {
                name = "Tri-cycles race",
                veh = "tribike3",
                price = 520
            }, {
                name = "Whippet race",
                veh = "tribike",
                price = 520
            }}
        },
        ["tuner"] = {
            useFilter = true,
            b = {{
                name = "Comet C2",
                veh = "comet6",
                price = 175000
            }, {
                name = "Obey Tailgater 2",
                veh = "tailgater2",
                price = 155000
            }, {
                name = "ZR350",
                veh = "zr350",
                price = 140000
            }, {
                name = "Jester RR",
                veh = "jester3",
                price = 156000
            }}
        }
    },
}
Citizen.CreateThread(function()
    local XPoQB = GetDistanceBetweenCoords
    while true do
        Citizen.Wait(1000)
        local XxJ = GetEntityCoords(GetPlayerPed(-1))
        for o5sms, JQi1jg in pairs(vms5) do
            if GetEntityCoords(GetPlayerPed(-1)) then
                local wVzn = v3(JQi1jg.pos.showRoom, XxJ)
                local pE = wVzn and XPoQB(XxJ, wVzn.x, wVzn.y, wVzn.z, true)
                if pE and pE < (wVzn.dist or 6) then
                    DVs8kf2w = o5sms;
                    wVzn.ins = true
                elseif wVzn.ins then
                    wVzn.ins = false
                    DVs8kf2w = false
                end
            end
        end
    end
end)


Citizen.CreateThread(function()
    while true do
        local attente = 1000
        if DVs8kf2w then
            local RSjapQ = GetPlayerPed(-1)
            if IsEntityVisible(GetPlayerPed(-1)) then
                attente = 1
                DrawTopNotification("Appuyez sur ~INPUT_CONTEXT~ pour ~b~consulter le catalogue~w~.")
                if IsControlJustPressed(1, 51) then
                    Rr.Menu = scRP0[DVs8kf2w]
                    CreateMenu(Rr)
                end
            end
        end
        Wait(attente)
    end
end)