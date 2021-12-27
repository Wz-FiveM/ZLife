local CurrentAction, CurrentActionMsg, CurrentActionData = nil, '', {}
local HasAlreadyEnteredMarker, LastHospital, LastPart, LastPartNum
local IsBusy = false
local spawnedVehicles, isInShopMenu = {}, false
local enService = false

ESX = nil
local PlayerData = {}

Citizen.CreateThread(function()
    while ESX == nil do
        TriggerEvent('esx:getSharedObject', function(obj)
            ESX = obj
        end)
        Citizen.Wait(0)
    end

    while ESX.GetPlayerData().job == nil do
        Citizen.Wait(100)
    end

    PlayerLoaded = true
    ESX.PlayerData = ESX.GetPlayerData()
end)

function OpenAmbulanceActionsMenu()
    local elements = {
        --{ label = _U('cloakroom'), value = 'cloakroom' },
        --[[ {label = ("Obtenir les clés des véhicules"), value = 'givekey'},
        {label = ("Rendre les clés des véhicules"), value = 'removekey'} ]]
    }

    if Config.EnablePlayerManagement and ESX.PlayerData.job.grade_name == 'boss' then
        table.insert(elements, { label = _U('boss_actions'), value = 'boss_actions' })
    end

    ESX.UI.Menu.CloseAll()

    ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'ambulance_actions', {
        css = 'ems',
        title = _U('ambulance'),
        align = 'top-left',
        elements = elements
    }, function(data, menu)
        if data.current.value == 'cloakroom' then
            --OpenCloakroomMenuEms()
        elseif data.current.value == 'boss_actions' then
            TriggerEvent('esx_society:openBossMenu', 'ambulance', function(data, menu)
                menu.close()
            end, { wash = false })
        elseif data.current.value == 'givekey' then
            TriggerServerEvent('esx_vehiclelock:givekey', 'no', "AMBUL911")
        elseif data.current.value == 'removekey' then
            TriggerServerEvent('esx_vehiclelock:deletekeyjobs', 'no', "AMBUL911")
        end
    end, function(data, menu)
        menu.close()
    end)
end

local TimeMissionLimit = 60 * 1000 * 20
local possibleSpawn = {
    { pos = vector3(57.4, 267.92, 109.56 - 0.95), heading = 222.10 },
    { pos = vector3(-148.24, -295.0, 39.8 - 0.95), heading = 205.16 },
    { pos = vector3(-805.0, -225.08, 37.24 - 0.95), heading = 85.26 },
    { pos = vector3(-1200.16, -1168.08, 7.68 - 0.95), heading = 164.99 },
    { pos = vector3(13.72, -1668.72, 29.2 - 0.95), heading = 266.17 },
    { pos = vector3(1155.84, -457.72, 67.0 - 0.95), heading = 179.98 },
    { pos = vector3(52.76, 231.28, 109.52 - 0.95), heading = 297.81 },
    { pos = vector3(1186.12, 2698.0, 38.0 - 0.95), heading = 193.48 },
    { pos = vector3(1931.36, 3719.8, 32.88 - 0.95), heading = 224.37 },
    { pos = vector3(1670.04, 4751.6, 41.88 - 0.95), heading = 286.34 },
    { pos = vector3(-107.16, 6314.64, 31.48 - 0.95), heading = 203.21 },
}

local stop = {
    { pos = vector3(363.24, -593.36, 28.68) }
}

local pedssp = {
    { peds = "csb_ramp_hic" },
    { peds = "cs_zimbor" },
    { peds = "cs_tom" },
    { peds = "csb_customer" },
    { peds = "csb_abigail" },
    { peds = "a_f_y_eastsa_03" },
    { peds = "a_f_y_indian_01" },
    { peds = "a_f_y_tourist_01" },
    { peds = "a_f_m_ktown_01" },
    { peds = "a_m_m_fatlatin_01" },
    { peds = "a_m_m_golfer_01" },
    { peds = "a_m_m_eastsa_01" },
    { peds = "a_m_o_beach_01" },
    { peds = "a_m_o_salton_01" },
    { peds = "a_m_y_beachvesp_01" },
}

local pedy

function createpedems(model, pos, heading)
    local playerped = GetPlayerPed(-1)
    RequestModel(model)
    while not HasModelLoaded(model) do
        Wait(10)
    end
    pedy = CreatePed(4, model, pos.x, pos.y, pos.z, heading, false, false)
    ApplyPedDamagePack(pedy, "HitByVehicle", 100.0, 100.0)
end

function ChercherCientEMS(LongText, possibleSpawn, stop, prix)
    if not IsVehicleModel(GetVehiclePedIsIn(GetPlayerPed(-1)), GetHashKey('ambulance')) then
        ShowAboveRadarMessage("~r~Vous devez être en ambulance pour commencer cette mission.")
        return
    end
    StartMusicEvent("MP_MC_ASSAULT_ADV_START")
    StartMusicEvent("MP_MC_ASSAULT_ADV_SUSPENSE")
    ESX.AddTimerBar("TEMPS RESTANT :", { endTime = GetGameTimer() + TimeMissionLimit })
    ShowAboveRadarMessage("~r~Ambulance\n~s~" .. LongText)
    local i = math.random(1, #possibleSpawn)
    local spawn = possibleSpawn[i].pos
    local heading = possibleSpawn[i].heading
    local b = math.random(1, #stop)
    local stopip = stop[b].pos
    local z = math.random(1, #pedssp)
    local pedsmod = pedssp[z].peds

    local blip = createBlip(spawn, 47, 41, "Blessé", true, 1.0)
    local pPed = GetPlayerPed(-1)
    local pVeh = GetVehiclePedIsIn(pPed, false)
    local pCoords = GetEntityCoords(pPed)
    local dst = GetDistanceBetweenCoords(spawn, pCoords, true)
    while dst >= 30.0 do
        Wait(100)
        pCoords = GetEntityCoords(pPed)
        dst = GetDistanceBetweenCoords(spawn, pCoords, true)
        RageUI.Text({ message = "Dirigez vous vers ~r~la destination~s~." })
    end
    local coords = { x = spawn.x, y = spawn.y, z = spawn.z }

    createpedems(pedsmod, spawn, heading)

    while dst >= 6.0 do
        Wait(1)
        ShowFloatingHelp("VOLE_VEH_MISSION", spawn)
        RageUI.Text({ message = "Le ~r~blessé ~s~n'est pas loin." })
        pCoords = GetEntityCoords(pPed)
        DrawMarker(0, spawn.x, spawn.y, spawn.z + 2.6, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 1.0, 1.0, 0.7, 0, 192, 255, 70, 0, 0, 2, 0, 0, 0, 0)
        dst = GetDistanceBetweenCoords(spawn, pCoords, true)
    end

    local nvaIsNv7 = GetVehiclePedIsIn(GetPlayerPed(-1))
    PlayAmbientSpeech1(pedy, "SOLICIT_MICHAEL", "SPEECH_PARAMS_FORCE_SHOUTED_CLEAR", 1)
    TaskEnterVehicle(pedy, nvaIsNv7, -1, 2, 1.0, 8388609, 0)

    RemoveBlip(blip)

    local blip = AddBlipForCoord(stopip)
    SetBlipRoute(blip, 1)

    local dst = GetDistanceBetweenCoords(stopip, pCoords, true)
    PlaySoundFrontend(-1, "Object_Dropped_Remote", "GTAO_FM_Events_Soundset", 0)
    while dst >= 5.0 do
        Wait(1)
        RageUI.Text({ message = "Livrez le blessé ~r~à destination~s~." })
        pCoords = GetEntityCoords(pPed)
        dst = GetDistanceBetweenCoords(pCoords, stopip, true)
    end

    local plate = GetVehicleNumberPlateText(GetVehiclePedIsIn(GetPlayerPed(-1), 0))
    local pEngine = GetVehicleEngineHealth(GetVehiclePedIsIn(GetPlayerPed(-1)))
    ESX.RemoveTimerBar()
    PlaySoundFrontend(-1, "Out_Of_Bounds_Timer", "DLC_HEISTS_GENERAL_FRONTEND_SOUNDS", 0)
    ShowAboveRadarMessage("~r~Ambulance\n~s~L'entreprise a reçu de l'argent. (~r~" .. prix .. "$~s~).")
    RemoveBlip(blip)
    SetBlipRoute(blip, 0)
    TaskVehicleTempAction(GetPlayerPed(-1), GetVehiclePedIsIn(GetPlayerPed(-1), 0), 6, 2000)
    Wait(2000)
    TaskLeaveAnyVehicle(pedy, 0, 0)
    SetVehicleDoorsLocked(GetVehiclePedIsIn(GetPlayerPed(-1), 1), 1)
    StartMusicEvent("MP_MC_ASSAULT_ADV_STOP")
    Wait(2000)
    SetEntityAsMissionEntity(pedy)
    DeleteEntity(pedy)
    TriggerServerEvent("clp_mission:givemoneysociety", prix, "society_ambulance")
end

Civiere = {}
Civiere.NetID = 0
local notCiviere = false
local isAttachedCiviere = false
local ngzOjWHO = GetHashKey("v_med_bed1")
function Civiere:Attach()
    if self.NetID == 0 then
        return
    end
    local _u = NetworkDoesEntityExistWithNetworkId(self.NetID) and NetworkGetEntityFromNetworkId(self.NetID)
    if _u and DoesEntityExist(_u) then
        requestObjControl(_u)
        local aLgiy = getClosePly()
        local mvi = aLgiy and GetPlayerPed(aLgiy)
        if mvi and DoesEntityExist(mvi) and (IsPedStill(mvi) or IsPedRagdoll(mvi) or IsEntityDead(mvi)) then
            TriggerPlayerEvent("clp_civ:actmed", 1, GetPlayerServerId(aLgiy))
        end
    end
end
function Civiere:Create()
    if self.NetID ~= 0 and NetworkDoesEntityExistWithNetworkId(self.NetID) then
        return
    end
    notCiviere = true
    local g4KV = LocalPlayer()
    local dT7iYDf4 = g4KV.Ped
    RequestAndWaitModel(ngzOjWHO)
    local L = CreateObject(ngzOjWHO, g4KV.Pos, true, true, false)
    SetModelAsNoLongerNeeded(ngzOjWHO)
    Civiere.NetID = ObjToNet(L)
    SetNetworkIdCanMigrate(Civiere.NetID, false)
    SetEntityHeading(L, GetEntityHeading(dT7iYDf4))
    RequestAndWaitDict("missfinale_c2ig_11")
    TaskPlayAnim(dT7iYDf4, "missfinale_c2ig_11", "pushcar_offcliff_m", 8.0, -8, -1, 49, 0, 0, 0, 0)
    RemoveAnimDict("missfinale_c2ig_11")
    AttachEntityToEntity(L, dT7iYDf4, 11816, 0.0, 2.0, -.45, 0.0, 0.0, 0.0, false, false, false, false, 2, true)
end
function Civiere:Remove()
    if self.NetID == 0 then
        return
    end
    notCiviere = false
    local WRH9 = NetworkDoesEntityExistWithNetworkId(self.NetID) and NetworkGetEntityFromNetworkId(self.NetID)
    if WRH9 and DoesEntityExist(WRH9) then
        requestObjControl(WRH9)
        local cJoBcud = getClosePly()
        local e = cJoBcud and GetPlayerPed(cJoBcud)
        if e and IsEntityAttachedToEntity(e, WRH9) then
            TriggerPlayerEvent("clp_civ:actmed", 1, GetPlayerServerId(cJoBcud))
        end
        SetEntityAsMissionEntity(WRH9, 1, 1)
        DeleteObject(WRH9)
        ClearPedTasks(LocalPlayer().Ped)
        self.NetID = 0
    end
end
local dM = false
Citizen.CreateThread(function()
    while true do
        Citizen.Wait(1000)
        if dM then
            local B6zKxgVs = LocalPlayer().Ped;
            local O3_X = GetEntityAttachedTo(B6zKxgVs)
            if not IsEntityPlayingAnim(B6zKxgVs, "savecountryside@", "m_sleep_loop_countryside", 3) then
                forceAnim({ "savecountryside@", "m_sleep_loop_countryside" }, 2)
            end
            if not O3_X or not DoesEntityExist(O3_X) then
                dM = false
                DetachEntity(B6zKxgVs, true, true)
                SetPedCanRagdoll(B6zKxgVs, true)
                ClearPedTasksImmediately(B6zKxgVs)
            end
        end
    end
end)
local U = IsDisabledControlJustPressed
function Civiere:Think(DVs8kf2w, vms5)
    if vms5 and U(1, 47) then
        local M7, v3 = DVs8kf2w.Ped, DVs8kf2w.Pos;
        local ihKb = GetClosestObject(v3, 3.0, ngzOjWHO)
        requestObjControl(ihKb)
        local JGSK = GetEntityAttachedTo(ihKb)
        if JGSK and DoesEntityExist(JGSK) and JGSK == M7 then
            DetachEntity(ihKb, 1, 1)
            ClearPedTasks(M7)
            self.NetID = ObjToNet(ihKb)
        elseif ihKb and DoesEntityExist(ihKb) then
            RequestAndWaitDict("missfinale_c2ig_11")
            TaskPlayAnim(M7, "missfinale_c2ig_11", "pushcar_offcliff_m", 8.0, -8, -1, 49, 0, 0, 0, 0)
            RemoveAnimDict("missfinale_c2ig_11")
            AttachEntityToEntity(ihKb, M7, 11816, 0.0, 2.0, -0.45, 0.0, 0.0, 0.0, false, false, false, false, 2, true)
            self.NetID = ObjToNet(ihKb)
        end
    end
end
RegisterNetEvent("clp_civ:actmed")
AddEventHandler("clp_civ:actmed", function(Kw, nvaIsNv7)
    local vDnoL55 = LocalPlayer()
    local xlAK = vDnoL55.Ped
    if Kw == 1 then
        local zr1y = GetEntityAttachedTo(xlAK)
        if (zr1y and DoesEntityExist(zr1y) or isAttachedCiviere) then
            DetachEntity(xlAK, 1, 1)
            isAttachedCiviere = false
            TaskSynchronizedTasks(xlAK, { { anim = { "savecountryside@", "m_sleep_loop_countryside" }, flag = 0, time = 300 }, { anim = { "savecountryside@", "t_getout_countryside" }, flag = 0 } })
            return
        end
        if not isAttachedCiviere then
            local Hs = GetClosestObject(GetEntityCoords(xlAK), 4, GetHashKey("v_med_bed1"))
            if Hs and DoesEntityExist(Hs) then
                SetPedCanRagdoll(xlAK, false)
                AttachEntityToEntity(xlAK, Hs, 11816, 0.0, 0.0, 0.7, 0.0, 0.0, 180.0, false, false, false, false, 2, true)
                forceAnim({ "savecountryside@", "m_sleep_loop_countryside" }, 2)
                SetPedCanRagdoll(xlAK, true)
                isAttachedCiviere = true
            end
        end
    end
end)

Citizen.CreateThread(function()
    while true do
        local attente = 1200
        if notCiviere then
            attente = 5
            Civiere:Think(LocalPlayer(), true)
        elseif not notCiviere then
            Civiere:Think(LocalPlayer(), false)
            attente = 1200
        end
        Wait(attente)
    end
end)

local function lcBL(Uk7e, KwQCk_G, ptZa)
    if Uk7e == 1 then
        if KwQCk_G == 5 then
            CreateFacture("society_ambulance")
        end
    elseif Uk7e == 4 then
        if KwQCk_G == 1 then
            deleteClosestObj()
        else
            createLegalObject(ptZa.h, LocalPlayer().Pos)
        end
    elseif Uk7e == 3 then
        local iSj = getClosePly()
        if KwQCk_G == 1 then
            local closestPlayer, closestDistance = ESX.Game.GetClosestPlayer()

            if not DoesAnyProgressBarExists() then
                if closestPlayer == -1 or closestDistance > 2.5 then
                    ShowAboveRadarMessage(_U('no_players'))
                else
                    IsBusy = true
                    ESX.TriggerServerCallback('esx_ambulancejob:getItemAmount', function(quantity)
                        if quantity > 0 then
                            local closestPlayerPed = GetPlayerPed(closestPlayer)
                            local playerPed = PlayerPedId()
                            local pPos = GetEntityCoords(playerPed)
                            createProgressBar("Réanimation en cours", 0, 255, 185, 120, 9000)
                            doAnim({ "missheistfbi3b_ig8_2", "cpr_loop_paramedic" }, true)
                            Wait(9000)
                            local chance = math.random(0, 99);
                            if chance >= 0 and chance <= 50 then
                                ShowAboveRadarMessage("~b~Réanimation\n~s~Vous venez de réanimer une personne.")
                                TriggerServerEvent('esx_ambulancejob:removeItem', 'medikit')
                                TriggerServerEvent('esx_ambulancejob:reviveplayer', GetPlayerServerId(closestPlayer))
                            else
                                ShowAboveRadarMessage("~r~Vous n'avez pas réussi à réanimer la personne !")
                            end
                            ClearPedTasks(playerPed)
                            SetEntityCoords(playerPed, pPos.x, pPos.y, pPos.z)
                        else
                            ShowAboveRadarMessage("~r~Vous n'avez pas de kit de soin.")
                        end
                        IsBusy = false
                    end, 'medikit')
                end
            else
                ShowAboveRadarMessage("~r~Vous êtes déjà entrain de réaliser une action.")
            end
        elseif KwQCk_G == 2 and iSj then
            local closestPlayer, closestDistance = ESX.Game.GetClosestPlayer()

            if not DoesAnyProgressBarExists() then
                if closestPlayer == -1 or closestDistance > 2.5 then
                    ShowAboveRadarMessage(_U('no_players'))
                else
                    ESX.TriggerServerCallback('esx_ambulancejob:getItemAmount', function(quantity)
                        if quantity > 0 then
                            local closestPlayerPed = GetPlayerPed(closestPlayer)
                            local health = GetEntityHealth(closestPlayerPed)

                            if health > 0 then
                                local playerPed = PlayerPedId()

                                IsBusy = true
                                forceAnim({ "CODE_HUMAN_MEDIC_KNEEL" })
                                createProgressBar("Soins en cours", 0, 255, 185, 120, 10000)
                                Citizen.Wait(10000)
                                ClearPedTasks(playerPed)

                                TriggerServerEvent('esx_ambulancejob:removeItem', 'bandage')
                                TriggerServerEvent('esx_ambulancejob:heal', GetPlayerServerId(closestPlayer), 'small')
                                ShowAboveRadarMessage(_U('heal_complete', GetPlayerName(closestPlayer)))
                                IsBusy = false
                                --end)
                            else
                                ShowAboveRadarMessage(_U('player_not_conscious'))
                            end
                        else
                            ShowAboveRadarMessage(_U('not_enough_bandage'))
                        end
                    end, 'bandage')
                end
            else
                ShowAboveRadarMessage("~r~Vous êtes déjà entrain de réaliser une action.")
            end
        elseif KwQCk_G == 3 then
            ChercherCientEMS("Allez chercher le blessé avec votre ambulance.", possibleSpawn, stop, 250)
        elseif KwQCk_G == 4 then
            messageemsnotfinish = true
            local amount = KeyboardInput("Annonce", "", 250)
            if amount ~= nil then
                amount = string.len(amount)
                if amount >= 10 then
                    TriggerServerEvent('clp_ems:annonceems', result)
                    messageemsnotfinish = false
                else
                    ShowAboveRadarMessage("~r~Votre message est trop court.")
                end
            end
        end
    elseif Uk7e == 5 then
        if KwQCk_G == 1 then
            Civiere:Attach()
        elseif KwQCk_G == 2 then
            Civiere:Create()
        elseif KwQCk_G == 3 then
            Civiere:Remove()
        end
    elseif Uk7e == 2 then
        if KwQCk_G == 1 then
            ClearPedTasks(LocalPlayer().Ped)
        else
            doAnim(ptZa.id)
        end
    end
end

local MenuEms = {
    onSelected = lcBL,
    params = { close = true },
    menu = {
        {
            { name = "Animations", icon = "fas fa-child", cb = 1 },
            { name = "Actions", icon = "fas fa-location-arrow", cb = 2 },
            { name = "Objets", icon = "fas fa-chair", cb = 3 },
            { name = "Civière", icon = "fas fa-dolly-flatbed", cb = 4 },
            { name = "Faire une facture", icon = "fas fa-file-invoice-dollar" }
        },
        {
            { name = "Arrêter", icon = "far fa-stop-circle" },
            { name = "Ausculter", icon = "fas fa-file-medical-alt", id = "CODE_HUMAN_MEDIC_KNEEL" },
            { name = "Massage cardiaque", icon = "fas fa-heartbeat", id = "CODE_HUMAN_MEDIC_TEND_TO_DEAD" },
            { name = "Prendre des notes", icon = "fas fa-user-md", id = "CODE_HUMAN_MEDIC_TIME_OF_DEATH" },
            { name = "Prendre des photos", icon = "fas fa-camera", id = "WORLD_HUMAN_PAPARAZZI" }
        },
        {
            { name = "Réanimer", icon = "fas fa-heartbeat" },
            { name = "Soigner", icon = "fas fa-medkit" },
            { name = "Chercher des blessés", icon = "fas fa-file-medical-alt" },
            { name = "Passer une annonce", icon = "fab fa-affiliatetheme" }
        },
        {
            { name = "Ramasser", icon = "fas fa-undo" },
            { name = "Barrière", icon = "fas fa-bars", h = "prop_barrier_work06a" },
            { name = "Plot", icon = "fas fa-exclamation-triangle", h = "prop_byard_net02" }
        },
        {
            { name = "Placer un individu", icon = "fas fa-dolly-flatbed" },
            { name = "Sortir", icon = "fas fa-sign-out-alt" },
            { name = "Ranger", icon = "far fa-minus-square" }
        }
    }
}

-- Draw markers & Marker logic
Citizen.CreateThread(function()
    while true do
        local attente = 850
        local playerCoords = GetEntityCoords(PlayerPedId())
        local letSleep, isInMarker, hasExited = true, false, false
        local currentHospital, currentPart, currentPartNum

        for hospitalNum, hospital in pairs(Config.Hospitals) do

            -- Ambulance Actions
            -- for k, v in ipairs(hospital.AmbulanceActions) do
            --     local distance = GetDistanceBetweenCoords(playerCoords, v, true)

            --     if distance < 10 and not IsPedInAnyVehicle(GetPlayerPed(-1), false) then
            --         attente = 1
            --         DrawMarker(25, v, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 1.25, 1.25, 1.0001, 0, 121, 255, 200, 0, 0, 0, 0)
            --         letSleep = false
            --     elseif IsPedInAnyVehicle(GetPlayerPed(-1), false) then
            --         attente = 2500
            --     end

            --     if distance < Config.MarkerEms.x then
            --         attente = 1
            --         isInMarker, currentHospital, currentPart, currentPartNum = true, hospitalNum, 'AmbulanceActions', k
            --     end
            -- end

            -- Pharmacies
            for k, v in ipairs(hospital.Pharmacies) do
                local distance = GetDistanceBetweenCoords(playerCoords, v, true)

                if distance < 10 and not IsPedInAnyVehicle(GetPlayerPed(-1), false) then
                    attente = 1
                    DrawMarker(25, v, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 1.25, 1.25, 1.0001, 0, 121, 255, 200, 0, 0, 0, 0)
                    letSleep = false
                elseif IsPedInAnyVehicle(GetPlayerPed(-1), false) then
                    attente = 2500
                end

                if distance < Config.MarkerEms.x then
                    attente = 1
                    isInMarker, currentHospital, currentPart, currentPartNum = true, hospitalNum, 'Pharmacy', k
                end
            end

            -- Vehicle Spawners
            -- for k, v in ipairs(hospital.Vehicles) do
            --     local distance = GetDistanceBetweenCoords(playerCoords, v.Spawner, true)

            --     if distance < 10 and not IsPedInAnyVehicle(GetPlayerPed(-1), false) then
            --         attente = 1
            --         DrawMarker(v.Marker.type, v.Spawner, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, v.Marker.x, v.Marker.y, v.Marker.z, 0, 121, 255, v.Marker.a, false, false, 2, v.Marker.rotate, nil, nil, false)
            --         letSleep = false
            --     elseif IsPedInAnyVehicle(GetPlayerPed(-1), false) then
            --         attente = 2500
            --     end

            --     if distance < v.Marker.x then
            --         attente = 1
            --         isInMarker, currentHospital, currentPart, currentPartNum = true, hospitalNum, 'Vehicles', k
            --     end
            -- end

            -- -- Helicopter Spawners
            -- for k, v in ipairs(hospital.Helicopters) do
            --     local distance = GetDistanceBetweenCoords(playerCoords, v.Spawner, true)

            --     if distance < 10 and not IsPedInAnyVehicle(GetPlayerPed(-1), false) then
            --         attente = 1
            --         DrawMarker(v.Marker.type, v.Spawner, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, v.Marker.x, v.Marker.y, v.Marker.z, 0, 121, 255, v.Marker.a, false, false, 2, v.Marker.rotate, nil, nil, false)
            --         letSleep = false
            --     elseif IsPedInAnyVehicle(GetPlayerPed(-1), false) then
            --         attente = 2500
            --     end

            --     if distance < v.Marker.x then
            --         attente = 1
            --         isInMarker, currentHospital, currentPart, currentPartNum = true, hospitalNum, 'Helicopters', k
            --     end
            -- end

        end

        -- Logic for exiting & entering markers
        if isInMarker and not HasAlreadyEnteredMarker or (isInMarker and (LastHospital ~= currentHospital or LastPart ~= currentPart or LastPartNum ~= currentPartNum)) then

            if (LastHospital ~= nil and LastPart ~= nil and LastPartNum ~= nil) and (LastHospital ~= currentHospital or LastPart ~= currentPart or LastPartNum ~= currentPartNum) then
                attente = 1
                TriggerEvent('esx_ambulancejob:hasExitedMarker', LastHospital, LastPart, LastPartNum)
                hasExited = true
            end

            HasAlreadyEnteredMarker, LastHospital, LastPart, LastPartNum = true, currentHospital, currentPart, currentPartNum

            TriggerEvent('esx_ambulancejob:hasEnteredMarker', currentHospital, currentPart, currentPartNum)

        end

        if not hasExited and not isInMarker and HasAlreadyEnteredMarker then
            attente = 1
            HasAlreadyEnteredMarker = false
            TriggerEvent('esx_ambulancejob:hasExitedMarker', LastHospital, LastPart, LastPartNum)
        end

        if letSleep then
            Citizen.Wait(500)
        end
        Wait(attente)
    end
end)

AddEventHandler('esx_ambulancejob:hasEnteredMarker', function(hospital, part, partNum)
    if ESX.PlayerData.job and ESX.PlayerData.job.name == 'ambulance' then
        if part == 'AmbulanceActions' then
            CurrentAction = part
            CurrentActionMsg = _U('actions_prompt')
            CurrentActionData = {}
        elseif part == 'Pharmacy' then
            CurrentAction = part
            CurrentActionMsg = _U('open_pharmacy')
            CurrentActionData = {}
        elseif part == 'Vehicles' then
            CurrentAction = part
            CurrentActionMsg = _U('garage_prompt')
            CurrentActionData = { hospital = hospital, partNum = partNum }
        elseif part == 'Helicopters' then
            CurrentAction = part
            CurrentActionMsg = _U('helicopter_prompt')
            CurrentActionData = { hospital = hospital, partNum = partNum }
        end
    end
end)

AddEventHandler('esx_ambulancejob:hasExitedMarker', function(hospital, part, partNum)
    if not isInShopMenu then
        ESX.UI.Menu.CloseAll()
    end

    CurrentAction = nil
end)

local function selectmenushopems(Ped, Selected)
    if Selected == 1 then
        TriggerServerEvent('esx_ambulancejob:giveItem', "bandage")
    elseif Selected == 2 then
        TriggerServerEvent('esx_ambulancejob:giveItem', "medikit")
    end
end

local ShopMenuEms = {
    onSelected = selectmenushopems,
    params = { close = false },
    menu = {
        {
            { name = "Bandages (x5)", icon = "fa fa-briefcase-medical" },
            { name = "Kits de soins (x5)", icon = "fa fa-briefcase-medical" },
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
            if IsControlJustReleased(0, 51) then
                if CurrentAction == 'Pharmacy' then
                    --if enService then
                        CreateRoue(ShopMenuEms)
                    --else
                        --ShowAboveRadarMessage("~r~Vous n'avez pas votre tenue de service.")
                    --end
                end
                CurrentAction = nil
            end
        end

        if ESX.PlayerData.job ~= nil and ESX.PlayerData.job.name == 'ambulance' then
            RegisterControlKey("ambulancemenu", "Ouvrir le menu ambulance", "F6", function()
                if ESX.PlayerData.job ~= nil and ESX.PlayerData.job.name == 'ambulance' then
                    --if enService then
                        CreateRoue(MenuEms)
                    -- else
                    --     ShowAboveRadarMessage("~r~Vous n'avez pas votre tenue de service.")
                    -- end
                end
            end)
        end
        Wait(attente)
    end
end)









function drawLoadingText(text, red, green, blue, alpha)
    SetTextFont(4)
    SetTextScale(0.0, 0.5)
    SetTextColour(red, green, blue, alpha)
    SetTextDropshadow(0, 0, 0, 0, 255)
    SetTextEdge(1, 0, 0, 0, 255)
    SetTextDropShadow()
    SetTextOutline()
    SetTextCentre(true)

    BeginTextCommandDisplayText("STRING")
    AddTextComponentSubstringPlayerName(text)
    EndTextCommandDisplayText(0.5, 0.5)
end

AddEventHandler('onResourceStop', function(resource)
    if resource == GetCurrentResourceName() then
        ESX.RemoveTimerBar()
        killProgressBar()
        SetEntityInvincible(GetPlayerPed(-1), false)
        KO = false
        Ko1 = false
        pouvoireeload = false
        hasnoko = false
        isDead = false
        dead = false
        SetEntityInvincible(GetPlayerPed(-1), false)
        Wait(250)
        SetEntityInvincible(GetPlayerPed(-1), false)
        TaskSetBlockingOfNonTemporaryEvents(GetPlayerPed(-1), false)
        ClearTimecycleModifier()
    end
end)

locksound = false
local wait = 15
local count = 60
local dead = false
local weaponHashType = { "Inconnue", "Dégâts de mêlée", "Blessure par balle", "Chute", "Dégâts explosifs", "Feu", "Chute", "Éléctrique", "Écorchure", "Gaz", "Gaz", "Eau" }
local boneTypes = {
    ["Dos"] = { 0, 23553, 56604, 57597 },
    ["Crâne"] = { 1356, 11174, 12844, 17188, 17719, 19336, 20178, 20279, 20623, 21550, 25260, 27474, 29868, 31086, 35731, 43536, 45750, 46240, 47419, 47495, 49979, 58331, 61839, 39317 },
    ["Coude droit"] = { 2992 },
    ["Coude gauche"] = { 22711 },
    ["Main gauche"] = { 4089, 4090, 4137, 4138, 4153, 4154, 4169, 4170, 4185, 4186, 18905, 26610, 26611, 26612, 26613, 26614, 60309 },
    ["Main droite"] = { 6286, 28422, 57005, 58866, 58867, 58868, 58869, 58870, 64016, 64017, 64064, 64065, 64080, 64081, 64096, 64097, 64112, 64113 },
    ["Bras gauche"] = { 5232, 45509, 61007, 61163 },
    ["Bras droit"] = { 28252, 40269, 43810 },
    ["Jambe droite"] = { 6442, 16335, 51826, 36864 },
    ["Jambe gauche"] = { 23639, 46078, 58271, 63931 },
    ["Pied droit"] = { 20781, 24806, 35502, 52301 },
    ["Pied gauche"] = { 2108, 14201, 57717, 65245 },
    ["Poîtrine"] = { 10706, 64729, 24816, 24817, 24818 },
    ["Ventre"] = { 11816 },
}

local deathTime, waitTime, deathCause = 0, 60 * 1000 * 6.5, {}
local put = nil

local function canBeRevived()
    local bool = not DoesEntityExist(GetEntityAttachedTo(GetPlayerPed(-1)))
    if not bool then
        ShowAboveRadarMessage("~r~Vous avez besoin d'une réanimation.")
    end
    return bool
end

local pouvoireeload = false
local hasnoko = false
Citizen.CreateThread(function()
    while true do
        Citizen.Wait(0)
        local Player = GetPlayerPed(-1)
        isDead = dead
        if KO then
            dead = false
            isDead = false
            SetEntityInvincible(GetPlayerPed(-1), true)
            TaskSetBlockingOfNonTemporaryEvents(GetPlayerPed(-1), true)
            if not hasnoko then
                local ped = GetPlayerPed(-1)
                if not pouvoireeload then
                    entity = GetClosestPed2(GetEntityCoords(GetPlayerPed(-1)), 3.5)
                    if not IsPedAPlayer(entity) and IsPedHuman(entity) then
                        DeleteEntity(entity)
                    end
                    SetEntityHealth(ped, 120)
                    SetEntityInvincible(GetPlayerPed(-1), true)
                    ShakeGameplayCam("DEATH_FAIL_IN_EFFECT_SHAKE", 1.0)
                    createProgressBar("Inconscient", 175, 25, 25, 150, 30000)
                    createAnEffect("damage", true, 28500)
                    SetPedToRagdollWithFall(ped, 1500, 2000, 0, -GetEntityForwardVector(ped), 1.0, 0.0, .0, .0, .0, .0, .0)
                    Ko1 = true
                end
                Citizen.CreateThread(function()
                    while Ko1 do
                        Wait(0)
                        if not IsPedAPlayer(entity) and IsPedHuman(entity) then
                            DeleteEntity(entity)
                        end
                        SetEntityInvincible(GetPlayerPed(-1), true)
                        SetFollowPedCamViewMode(0)
                        DisableControlAction(0, 0, true)
                        SetPlayerInvincible(PlayerPedId(), true)
                        SetPedToRagdoll(ped, 1000, 1000, 0, 0, 0, 0)
                        ResetPedRagdollTimer(ped)
                    end
                end)
                Wait(30000)
                killProgressBar()
                if not hasnoko then
                    pouvoireeload = true
                end
                Wait(1)
                hasnoko = true
                Citizen.CreateThread(function()
                    while pouvoireeload do
                        Wait(0)
                        ESX.ShowHelpNotification("Appuyez sur ~INPUT_CONTEXT~ ou ~INPUT_JUMP~ pour ~b~vous relever")
                        if IsControlJustPressed(0, 22) or IsControlJustPressed(0, 46) then
                            pouvoireeload = false
                            KO = false
                            Ko1 = false
                            SetEntityInvincible(GetPlayerPed(-1), false)
                            entity = GetClosestPed2(GetEntityCoords(GetPlayerPed(-1)), 3.5)
                            if not IsPedAPlayer(entity) and IsPedHuman(entity) then
                                DeleteEntity(entity)
                            end
                            DoScreenFadeOut(1000)
                            Citizen.Wait(1000)
                            DoScreenFadeIn(1000)
                            SetEntityInvincible(GetPlayerPed(-1), false)
                            ESX.RemoveTimerBar()
                            setSobre()
                            SetTimecycleModifier('')
                            ShowAboveRadarMessage("~b~Inconscient\n~w~Vous êtes blessé.")
                            ShakeGameplayCam("DEATH_FAIL_IN_EFFECT_SHAKE", 0.5)
                            RequestAnimSet("move_m@injured")
                            LocalPlayer():Set("Ko", false)
                            SetPedMovementClipset(ped, "move_m@injured", true)
                            hasnoko = false
                            TaskSetBlockingOfNonTemporaryEvents(GetPlayerPed(-1), false)
                            SetEntityInvincible(GetPlayerPed(-1), false)
                            Wait(250)
                            SetEntityInvincible(GetPlayerPed(-1), false)
                        end
                    end
                end)
            end
        end
        if dead then
            local ped = GetPlayerPed(-1)
            local B6zKxgVs, TimeComa = 0, 60 * 1000 * 6.502
            SetEntityInvincible(GetPlayerPed(-1), true)
            createAnEffect("rply_vignette", true, 60000)
            SetPedToRagdollWithFall(ped, 1500, 2000, 0, -GetEntityForwardVector(ped), 1.0, 0.0, .0, .0, .0, .0, .0)
            entity = GetClosestPed2(GetEntityCoords(GetPlayerPed(-1)), 3.5)
            if not IsPedAPlayer(entity) and IsPedHuman(entity) then
                DeleteEntity(entity)
            end
            ESX.AddTimerBar("Temps du coma :", { endTime = GetGameTimer() + TimeComa })
            PlayMissionCompleteAudio("GENERIC_FAILED")
            SetEntityInvincible(GetPlayerPed(-1), true)
            SetTimecycleModifier("rply_vignette")
            Citizen.Wait(1000)
            SetPedToRagdollWithFall(ped, 0, 0, 0, -GetEntityForwardVector(ped), .0, 0.0, .0, .0, .0, .0, .0)
            while dead do

                SetTimecycleModifier("rply_vignette")
                SetEntityHealth(ped, 120)
                SetEntityInvincible(GetPlayerPed(-1), true)
                SetPedToRagdoll(ped, 1000, 1000, 0, 1, 1, 0)
                ResetPedRagdollTimer(ped)
                SetEntityInvincible(GetPlayerPed(-1), true)
                SetFollowPedCamViewMode(0)
                DisableControlAction(0, 0, true)
                if not IsPedAPlayer(entity) and IsPedHuman(entity) then
                    DeleteEntity(entity)
                end
                drawTxt(.16, .91, .4, "Origine: ~b~" .. (deathCause[2] or "Inconnue"), 4, nil, nil, 175)
                drawTxt(.16, .935, .4, "Cause: ~b~" .. (deathCause[3] or "Inconnue"), 4, nil, nil, 175)
                drawTxt(.16, .96, .4, "Blessure: ~b~" .. (deathCause[4] or "Inconnu"), 4, nil, nil, 175)
                deathTime = deathTime or GetGameTimer()
                local t = deathTime + waitTime

                local RespawnPressed, CallPressed = IsControlJustPressed(1, 246), IsControlJustPressed(1, 47)
                if t < GetGameTimer() then
                    ShowAboveRadarMessage('Appuyez sur ~b~Y~s~ pour contacter les internes.')
                end
                if (RespawnPressed or CallPressed) and canBeRevived() and (CallPressed or t < GetGameTimer()) then
                    if not CallPressed then
                        local playerPed = GetPlayerPed(-1)
                        dead = false
                        DoScreenFadeOut(800)
                        while not IsScreenFadedOut() do
                            Citizen.Wait(10)
                        end
                        entity = GetClosestPed2(GetEntityCoords(GetPlayerPed(-1)), 3.5)
                        if not IsPedAPlayer(entity) and IsPedHuman(entity) then
                            DeleteEntity(entity)
                        end
                        SetEntityInvincible(GetPlayerPed(-1), false)
                        SetEntityCoordsNoOffset(ped, 315.34, -580.97, 43.58, false, false, false, true)
                        ClearPedBloodDamage(ped)
                        SetPlayerInvincible(playerPed, false)
                        ESX.RemoveTimerBar()
                        entity = GetClosestPed2(GetEntityCoords(GetPlayerPed(-1)), 3.5)
                        if not IsPedAPlayer(entity) and IsPedHuman(entity) then
                            DeleteEntity(entity)
                        end
                        ClearPedBloodDamage(ped)
                        PlaySoundFrontend(-1, "1st_Person_Transition", "PLAYER_SWITCH_CUSTOM_SOUNDSET", 0)
                        TriggerEvent('skinchanger:getSkin', function(skin)
                            if skin.sex == 0 then
                                TriggerEvent("skinchanger:change", 'torso_2', 0)
                                TriggerEvent("skinchanger:change", 'torso_1', 26)
                                TriggerEvent("skinchanger:change", 'arms', 15)
                                TriggerEvent("skinchanger:change", 'pants', 73)
                            end
                        end)
                        DoScreenFadeIn(800)
                        Citizen.Wait(10)
                        ClearPedTasksImmediately(playerPed)
                        createAnEffect("damage", true, 30000)
                        --SetPedMotionBlur(playerPed, true)
                        SetEntityHealth(playerPed, 200)
                        RequestAnimSet("move_m@drunk@verydrunk")
                        while not HasAnimSetLoaded("move_m@drunk@verydrunk") do
                            Citizen.Wait(0)
                        end
                        LocalPlayer():Set("Dead", false)
                        TriggerEvent("esx_basicneeds:resetStatus")
                        TriggerServerEvent('clp_death:removeweapon')
                        SetPedMovementClipset(playerPed, "move_m@drunk@verydrunk", true)
                        PlaySoundFrontend(-1, "1st_Person_Transition", "PLAYER_SWITCH_CUSTOM_SOUNDSET", 0)
                        Citizen.Wait(300)
                        ShowAboveRadarMessage("~b~Réanimation\n~w~Toutes vos armes ont été confisqués.")
                        ShowAboveRadarMessage("~b~Réanimation\n~w~Vous venez d\'être réanimé par les internes.")
                        SetEntityInvincible(GetPlayerPed(-1), false)
                        Wait(31000)
                        ESX.TriggerServerCallback('esx_skin:getPlayerSkin', function(skin)
                            TriggerEvent('skinchanger:loadSkin', skin)
                        end)
                    else
                        ShowAboveRadarMessage("~b~Vous avez appelé le 911.")
                        local x, y, z = table.unpack(GetOffsetFromEntityInWorldCoords(PlayerPedId(), 0.0, 0.0, 0.0))
                        local coords = { x = x, y = y, z = z }
                        TriggerServerEvent("call:makeCall", "ambulance", coords, "Accident mortel")
                    end
                end
                Citizen.Wait(0)
            end
        end
    end
end)

RegisterCommand('clearped', function()
    if not canDoIt() then return print('Peux pas maik') end
    entity = GetClosestPed2(GetEntityCoords(GetPlayerPed(-1)), 5.0)
    if not IsPedAPlayer(entity) and IsPedHuman(entity) then
        DeleteEntity(entity)
    end
end)


function drawTxt(x, y, scale, text, f, c, n, a, r, g, b)
    a = a or 255
    if not r then
        r = 255
        g = 255
        b = 255
    end
    if not f then
        f = 4
    end
    SetTextFont(f)
    SetTextScale(scale, scale)
    SetTextColour(r, g, b, a)
    SetTextCentre(c)
    if not n then
        SetTextDropShadow()
        SetTextOutline()
        SetTextDropShadow(0, 0, 0, 0, 255)
        SetTextEdge(2, 0, 0, 0, 255)
    end
    SetTextEntry("STRING")
    AddTextComponentString(text)
    DrawText(x, y)
end

AddEventHandler('cmvn_death:onPlayerKilled', function(_, tab)
    if not KO then
        Player = GetPlayerPed(-1)
        local ped = GetPlayerPed(-1)
        weapon = tab.weaponhash
        deathCause = table.pack(GetAllCauseOfDeath(GetPlayerPed(-1)))
        if GetWeapontypeGroup(weapon) == -728555052 or weapon == -1569615261 or weapon == -1600701090 or weapon == 126349499 or weapon == 4194021054 or weapon == -100946242 or weapon == -656458692
                or weapon == -1810795771 or weapon == 1737195953 or weapon == 1317494643 or weapon == -1786099057 or weapon == -2067956739 or weapon == 1141786504 or weapon == -102323637 or weapon == -1834847097
                or weapon == -102973651 or weapon == -581044007 or weapon == -1951375401 or weapon == -538741184 or weapon == 419712736 or weapon == -853065399 or weapon == -1716189206 then
            KO = true
            LocalPlayer():Set("Ko", true)
            entity = GetClosestPed2(GetEntityCoords(GetPlayerPed(-1)), 3.5)
            if not IsPedAPlayer(entity) and IsPedHuman(entity) then
                DeleteEntity(entity)
            end
        else
            dead = true
            isDead = true
            LocalPlayer():Set("Dead", true)
            ShowAboveRadarMessage("Voulez-vous contacter le ~b~911 ~s~?")
            ShowAboveRadarMessage("Accepter : ~b~G")
            deathTime = GetGameTimer() or 0
        end

        local ped = GetPlayerPed(-1)

        NetworkResurrectLocalPlayer(GetEntityCoords(ped), 0, true, true, false)
        SetEntityInvincible(GetPlayerPed(-1), true)
        SetEntityHealth(ped, 120)
        SetPedToRagdollWithFall(ped, 1500, 2000, 0, -GetEntityForwardVector(ped), 1.0, 0.0, .0, .0, .0, .0, .0)
    end
end)

function GetAllCauseOfDeath(ped)
    local exist, lastBone = GetPedLastDamageBone(ped)
    local cause, what, timeDeath = GetPedCauseOfDeath(ped), Citizen.InvokeNative(0x93C8B64DEB84728C, ped), Citizen.InvokeNative(0x1E98817B311AE98A, ped)
    if what and DoesEntityExist(what) then
        if IsEntityAPed(what) then
            what = "Traces de combat"
        elseif IsEntityAVehicle(what) then
            what = "Écrasé par un véhicule"
        elseif IsEntityAnObject(what) then
            what = "Semble s'être pris un objet"
        end
    end
    what = type(what) == "string" and what or "Inconnue"

    if cause then
        if IsWeaponValid(cause) then
            cause = weaponHashType[GetWeaponDamageType(cause)] or "Inconnue"
        elseif IsModelInCdimage(cause) then
            cause = "Véhicule"
        end
    end
    cause = type(cause) == "string" and cause or "Mêlée"

    local boneName = "Dos"
    if exist and lastBone then
        for k, v in pairs(boneTypes) do
            if tableHasValue(v, lastBone) then
                boneName = k
                break
            end
        end
    end

    return timeDeath, what, cause, boneName
end

AddEventHandler('cmvn_death:onPlayerDied', function(_, _)
    if not KO then
        deathCause = table.pack(GetAllCauseOfDeath(GetPlayerPed(-1)))
        dead = true
        isDead = true
        LocalPlayer():Set("Dead", true)
        local ped = GetPlayerPed(-1)
        ShowAboveRadarMessage("Voulez-vous contacter le ~b~911~s~?")
        ShowAboveRadarMessage("Accepter : ~b~G")
        deathTime = GetGameTimer() or 0
        NetworkResurrectLocalPlayer(GetEntityCoords(ped), 0, true, true, false)
        SetEntityInvincible(ped, true)
        SetEntityHealth(ped, 120)
    end
end)

function setSobre()
    local ped = GetPlayerPed(-1)
    ClearPedBloodDamage(ped)
    ClearTimecycleModifier()
    ResetScenarioTypesEnabled()
    ResetPedMovementClipset(ped, 0)
    SetPedIsDrunk(ped, false)
    SetCamEffect(0)
end

Citizen.CreateThread(function()
    local isDead = false
    local hasBeenDead = false
    local diedAt

    while true do
        Wait(0)

        local player = PlayerId()

        if NetworkIsPlayerActive(player) then
            local ped = PlayerPedId()

            if IsPedFatallyInjured(ped) and not isDead then
                dead = true
                if not diedAt then
                    diedAt = GetGameTimer()
                end

                local killer, killerweapon = NetworkGetEntityKillerOfPlayer(player)
                local killerentitytype = GetEntityType(killer)
                local killertype = -1
                local killerinvehicle = false
                local killervehiclename = ''
                local killervehicleseat = 0
                if killerentitytype == 1 then
                    killertype = GetPedType(killer)
                    if IsPedInAnyVehicle(killer, false) == 1 then
                        killerinvehicle = true
                        killervehiclename = nil
                    else
                        killerinvehicle = false
                    end
                end

                local killerid = GetPlayerByEntityID(killer)
                if killer ~= ped and killerid ~= nil and NetworkIsPlayerActive(killerid) then
                    killerid = GetPlayerServerId(killerid)
                else
                    killerid = -1
                end

                if killer ~= ped then
                    CreateCinematicShot(-1096069633, 2000, 0, killer)
                end

                if killer == ped or killer == -1 then
                    TriggerEvent('cmvn_death:onPlayerDied', killertype, { table.unpack(GetEntityCoords(ped)) })
                    hasBeenDead = true
                else
                    TriggerEvent('cmvn_death:onPlayerKilled', killerid, { killertype = killertype, weaponhash = killerweapon, killerinveh = killerinvehicle, killervehseat = killervehicleseat, killervehname = killervehiclename, killerpos = table.unpack(GetEntityCoords(ped)) })
                    hasBeenDead = true
                end
            elseif not IsPedFatallyInjured(ped) then
                isDead = false
                diedAt = nil
            end

            if not hasBeenDead and diedAt ~= nil and diedAt > 0 then
                TriggerEvent('cmvn_death:onPlayerWasted', { table.unpack(GetEntityCoords(ped)) })
                print('Je sais pas la mort')

                hasBeenDead = true
            elseif hasBeenDead and diedAt ~= nil and diedAt <= 0 then
                hasBeenDead = false
            end
        end
    end
end)

function GetPlayerByEntityID(id)
    for i = 0, 255 do
        if (NetworkIsPlayerActive(i) and GetPlayerPed(i) == id) then
            return i
        end
    end
    return nil
end

RegisterNetEvent('esx_ambulancejob:useItem')
AddEventHandler('esx_ambulancejob:useItem', function(itemName)
    if itemName == 'medikit' then
        local playerPed = PlayerPedId()
        forceAnim({ "CODE_HUMAN_MEDIC_KNEEL" })
        createProgressBar("Soins en cours", 0, 255, 185, 120, 10000)
        Citizen.Wait(10000)
        ClearPedTasks(playerPed)
        TriggerEvent('esx_ambulancejob:heal', 'big', true)
        ShowAboveRadarMessage("~g~Vous venez d'utiliser un kit de soin.")
    elseif itemName == 'bandage' then
        local playerPed = PlayerPedId()
        forceAnim({ "CODE_HUMAN_MEDIC_KNEEL" })
        createProgressBar("Soins en cours", 0, 255, 185, 120, 10000)
        Citizen.Wait(10000)
        ClearPedTasks(playerPed)
        TriggerEvent('esx_ambulancejob:heal', 'small', true)
        ShowAboveRadarMessage("~g~Vous venez d'utiliser un bandage.")
    end
end)

RegisterNetEvent('clp:useparacetamol')
AddEventHandler('clp:useparacetamol', function()
    local playerPed = PlayerPedId()
    forceAnim({ "CODE_HUMAN_MEDIC_KNEEL" })
    createProgressBar("Soins en cours", 0, 255, 185, 120, 10000)
    Citizen.Wait(10000)
    ClearPedTasks(playerPed)
    ShowAboveRadarMessage("~g~Vous venez d'utiliser un paracétamol.")
    SetEntityHealth(GetPlayerPed(-1), GetEntityHealth(GetPlayerPed(-1)) + 15)
end)

----------------------Blesser = Boiter--------------------------

local hurt = false
Citizen.CreateThread(function()
    while true do
        local attente = 500
        if GetEntityHealth(GetPlayerPed(-1)) <= 118 then
            attente = 1
            SetTimecycleModifier("damage")
            setHurt()
        elseif hurt and GetEntityHealth(GetPlayerPed(-1)) > 119 then
            setNotHurt()
            SetTimecycleModifier("")
        end
        Wait(attente)
    end
end)

function setHurt()
    SetTimecycleModifier("damage")
    hurt = true
    RequestAnimSet("move_m@injured")
    SetPedMoveRateOverride(GetPlayerPed(-1), 0.8)
    SetPedMovementClipset(GetPlayerPed(-1), "move_m@injured", true)
end

function setNotHurt()
    SetTimecycleModifier("")
    hurt = false
    SetPedMoveRateOverride(GetPlayerPed(-1), 1.0)
    ResetPedMovementClipset(GetPlayerPed(-1))
    ResetPedWeaponMovementClipset(GetPlayerPed(-1))
    ResetPedStrafeClipset(GetPlayerPed(-1))
end

Citizen.CreateThread(function()
    while true do
        local attente = 500
        if GetEntityHealth(GetPlayerPed(-1)) <= 110 then
            attente = 1
            DisableControlAction(0, 22, true)
            DisableControlAction(0, 21, true)
        end
        Wait(attente)
    end
end)

RegisterNetEvent('esx_ambulancejob:reviveplayer')
AddEventHandler('esx_ambulancejob:reviveplayer', function()
    DoScreenFadeOut(1000)
    Citizen.Wait(1000)
    DoScreenFadeIn(1000)
    local playerPed = PlayerPedId()
    createAnEffect("damage", false, 5000)
    KO = false
    Ko1 = false
    pouvoireeload = false
    hasnoko = false
    isDead = false
    dead = false
    TaskSetBlockingOfNonTemporaryEvents(GetPlayerPed(-1), false)
    NetworkResurrectLocalPlayer(GetEntityCoords(playerPed), 0, true, true, false)
    SetEntityInvincible(playerPed, false)
    SetEntityHealth(playerPed, 200)
    ESX.RemoveTimerBar()
    LocalPlayer():Set("Ko", false)
    LocalPlayer():Set("Dead", false)
    killProgressBar()
    ClearPedBloodDamage(playerPed)
    ResetScenarioTypesEnabled()
    SetEntityInvincible(playerPed, false)
    ClearTimecycleModifier()
    SetEntityInvincible(GetPlayerPed(-1), false)
    SetPedIsDrunk(playerPed, false)
    SetCamEffect(0)
    RequestAnimSet("move_m@injured")
    SetPedMovementClipset(playerPed, "move_m@injured", true)
    ShowAboveRadarMessage("~b~Réanimation\n~w~Vous venez d\'être réanimé par un médecin.")
    SetEntityInvincible(GetPlayerPed(-1), false)
    createAnEffect("damage", true, 25000)
end)

RegisterNetEvent('esx_ambulancejob:heal')
AddEventHandler('esx_ambulancejob:heal', function(healType, quiet)
    local playerPed = PlayerPedId()
    local maxHealth = GetEntityMaxHealth(playerPed)

    if healType == 'small' then
        local health = GetEntityHealth(playerPed)
        local newHealth = math.min(maxHealth, math.floor(health + maxHealth / 6))
        SetEntityHealth(playerPed, newHealth)
        SetEntityInvincible(GetPlayerPed(-1), false)
    elseif healType == 'big' then
        SetEntityHealth(playerPed, maxHealth)
        SetEntityInvincible(GetPlayerPed(-1), false)
    end

    if not quiet then
        ShowAboveRadarMessage(_U('healed'))
    end
end)

RegisterCommand("debug", function()
    if not isDead then
        DoScreenFadeOut(500)
        TriggerEvent('skinchanger:getSkin', function(skin)
            local sex = skin.sex
            TriggerEvent('skinchanger:change', 'sex', sex + 1)
            Citizen.Wait(500)
            TriggerEvent('skinchanger:change', 'sex', sex)
        end)
        Citizen.Wait(500)
        DoScreenFadeIn(500)
        TriggerEvent('c_inv:relaodinv')
        ClearFocus()
        TriggerServerEvent('vSync:requestSync')
        SetFocusEntity(GetPlayerPed(PlayerId()))
        local pPed = GetPlayerPed(-1)
        FreezeEntityPosition(GetPlayerPed(-1), false)
        SetNuiFocus(false, false)
        entity = GetClosestPed2(GetEntityCoords(GetPlayerPed(-1)), 5.0)
        if not IsPedAPlayer(entity) and IsPedHuman(entity) then
            DeleteEntity(entity)
        end
        SetEnableScuba(playerPed, false)
        SetEnableScubaGearLight(playerPed, false)
        DetachEntity(pPed, true, false)
        PrepareMusicEvent("FM_SUDDEN_DEATH_STOP_MUSIC")
        TriggerMusicEvent("FM_SUDDEN_DEATH_STOP_MUSIC")
        SetKeepInputMode(false)
        TriggerScreenblurFadeOut(0)
        FreezeEntityPosition(pPed, false)
        ClearPedTasksImmediately(pPed)
        --TriggerEvent('instance:close')
        TriggerEvent('instance:leave')
        killProgressBar()
        SetPedMoveRateOverride(GetPlayerPed(-1), 1.0)
        --ResetEntityAlpha(pPed)
        SetEntityCollision(pPed, 1, 1)
        SetEntityVisible(pPed, true, false)
        TriggerEvent('es:setMoneyDisplay', 1.0)
        TriggerEvent('esx_status:setDisplay', 0.0)
        RemoveLoadingPrompt()
        TriggerEvent('anim:pouvoir', true)
        ClearAllBrokenGlass()
        ClearAllHelpMessages()
        LeaderboardsReadClearAll()
        ClearBrief()
        ClearGpsFlags()
        ClearPrints()
        ClearSmallPrints()
        ClearReplayStats()
        LeaderboardsClearCacheData()
        ClearFocus()
        ClearHdArea()
        ClearThisPrint()
        ClearPedInPauseMenu()
        ClearFloatingHelp()
        ClearGpsRaceTrack()
        ClearOverrideWeather()
        ClearCloudHat()
        ClearHelp(true)
        SetTimecycleModifier('')
        ESX.RemoveTimerBar()
        SetFakeWantedLevel(0)
        TriggerEvent("playerSpawned")
        Wait(1000)
        TriggerServerEvent('c_health:upstarhe')
        TriggerEvent('esx_health:pl')
    end
end)




local function vestiaire(Ped, Select)
	if Select == 1 then 
		TriggerServerEvent("tenueems")
	end
end

local VestiaireEms ={
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
		local vestiaire = Vdist(plyCoords.x, plyCoords.y, plyCoords.z, 301.660, -599.290, 43.2840)

		if vestiaire <= 8.0 then
			interval = 150
		end
		
		if vestiaire <= 7.0 then
			interval = 0
            if ESX.PlayerData.job.name == "ambulance" then
			    DrawText3D(301.660, -599.290, 43.2840+0.50, 'Appuyez sur ~b~E~s~ pour accéder au ~b~Vestiaire~s~')
			    DrawMarker(25, 301.660, -599.290, 43.2840-0.98 , 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 1.0, 1.0, 1.0, 46, 134, 193, 120)
            end
		end

		if vestiaire <= 1.5 then
			if IsControlJustPressed(0, 51) then
                if ESX.PlayerData.job.name == "ambulance" then
				    CreateRoue(VestiaireEms)
                end
			end
		end
		Wait(1)
	end
end)



RegisterNetEvent('c_ems:usetenue')
AddEventHandler('c_ems:usetenue', function()
  if not UseTenu then

    cleanPlayer(playerPed)
    local dict, anim = "mp_clothing@female@shoes", "try_shoes_negative_a"
    ESX.Streaming.RequestAnimDict(dict)
    TaskPlayAnim(GetPlayerPed(-1),dict,anim,8.0, -8.0, -1, 0, 0, false, false, false)
    Citizen.Wait(6500)
    
    TriggerEvent('skinchanger:getSkin', function(skin)

      if skin.sex == 0 then
		ExecuteCommand('me change sa tenue.')
		TriggerServerEvent("player:serviceOn")
		enService = true
		local clothesSkin = {
			['tshirt_1'] = 16,  ['tshirt_2'] = 0,
			['torso_1'] = 27,   ['torso_2'] = 6,
			['decals_1'] = 0,   ['decals_2'] = 0,
			['arms'] = 85,
			['pants_1'] = 37,   ['pants_2'] = 2,
			['shoes_1'] = 89,   ['shoes_2'] = 0,
			['helmet_1'] = -1,  ['helmet_2'] = 0,
			['bags_1'] = 16,
			['chain_1'] = 22,    ['chain_2'] = 0,
			}
			TriggerEvent('skinchanger:loadClothes', skin, clothesSkin)
		  else
			ExecuteCommand('me change sa tenue.')
			servicepolice = true
			local clothesSkin = {
				['tshirt_1'] = 16,  ['tshirt_2'] = 0,
				['torso_1'] = 36,   ['torso_2'] = 6,
				['decals_1'] = 0,   ['decals_2'] = 0,
				['arms'] = 100,
				['pants_1'] = 40,  ['pants_2'] = 2,
				['shoes_1'] = 58,   ['shoes_2'] = 0,
				['helmet_1'] = -1,  ['helmet_2'] = 0,
				['bags_1'] = 13,
				['chain_1'] = 10,    ['chain_2'] = 0,
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
		  enService = false

          TriggerEvent('skinchanger:loadSkin', skin)
          TriggerEvent('esx:restoreLoadout')
        end
      end)
    end)
  end
  UseTenu = not UseTenu
end)