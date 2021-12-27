ESX                           = nil
local ESXLoaded = false
local robbing = false
local B6zKxgVs,O3_X1=0,60*1000*1.40
local DHPxI = GetSoundId() 
local DHPxI
local ihKb1

Citizen.CreateThread(function ()
    while ESX == nil do
        TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
        Citizen.Wait(0)
    end

    while ESX.GetPlayerData().job == nil do
		Citizen.Wait(10)
	end

    ESXLoaded = true
end)

RegisterNetEvent('esx:playerLoaded')
AddEventHandler('esx:playerLoaded', function(xPlayer)
  ESX.PlayerData = xPlayer
end)

RegisterNetEvent('esx:setJob')
AddEventHandler('esx:setJob', function(job)
    ESX.PlayerData.job = job
end)

local peds = {}
local objects = {}

RegisterNetEvent('loffe_robbery:onPedDeath')
AddEventHandler('loffe_robbery:onPedDeath', function(store)
    SetEntityHealth(peds[store], 0)
end)

RegisterNetEvent('loffe_robbery:removePickup')
AddEventHandler('loffe_robbery:removePickup', function(bank)
    for i = 1, #objects do 
        if objects[i].bank == bank and DoesEntityExist(objects[i].object) then 
            DeleteObject(objects[i].object) 
        end 
    end
end)

RegisterNetEvent('loffe_robbery:robberyOver')
AddEventHandler('loffe_robbery:robberyOver', function()
    robbing = false
end)

RegisterNetEvent('loffe_robbery:rob')
AddEventHandler('loffe_robbery:rob', function(i)
    if not IsPedDeadOrDying(peds[i]) then
        SetEntityCoords(peds[i], Config.Shops[i].coords)
        loadDict('mp_am_hold_up')
        TaskPlayAnim(peds[i], "mp_am_hold_up", "holdup_victim_20s", 8.0, -8.0, -1, 2, 0, false, false, false)
        PlayAmbientSpeechWithVoice(peds[i], "SHOP_HURRYING", "MP_M_SHOPKEEP_01_PAKISTANI_MINI_01", "SPEECH_PARAMS_FORCE", 1)
        while not IsEntityPlayingAnim(peds[i], "mp_am_hold_up", "holdup_victim_20s", 3) do Wait(0) end
        local timer = GetGameTimer() + 10800
        while timer >= GetGameTimer() do
            if IsPedDeadOrDying(peds[i]) then
                break
            end
            if GetDistanceBetweenCoords(GetEntityCoords(GetPlayerPed(-1)), GetEntityCoords(peds[i]), true) >= 7.5 then
                --print('t')
                ClearPedTasks(peds[i])
                Wait(0)
                ESX.DrawMissionText("~r~Vous êtes partis du magasin.", 4500)
                RemoveLoadingPrompt()
                ReleaseScriptAudioBank("Alarms")
                StopSound(DHPxI)
                ESX.RemoveTimerBar()
                SetFakeWantedLevel(0)
                robbing = false
            end
            Wait(0)
        end

        if not IsPedDeadOrDying(peds[i]) then
            local cashRegister = GetClosestObjectOfType(GetEntityCoords(peds[i]), 5.0, GetHashKey('prop_till_01'))
            if DoesEntityExist(cashRegister) then
                CreateModelSwap(GetEntityCoords(cashRegister), 0.5, GetHashKey('prop_till_01'), GetHashKey('prop_till_01_dam'), false)
                PlayAmbientSpeechWithVoice(peds[i],"APOLOGY_NO_TROUBLE","MP_M_SHOPKEEP_01_PAKISTANI_MINI_01","SPEECH_PARAMS_FORCE",1)
            end

            timer = GetGameTimer() + 200 
            while timer >= GetGameTimer() do
                if IsPedDeadOrDying(peds[i]) then
                    break
                end
                if GetDistanceBetweenCoords(GetEntityCoords(GetPlayerPed(-1)), GetEntityCoords(peds[i]), true) >= 7.5 then
                    ClearPedTasks(peds[i])
                    Wait(0)
                    ESX.DrawMissionText("~r~Vous êtes partis du magasin.", 4500)
                    RemoveLoadingPrompt()
                    ReleaseScriptAudioBank("Alarms")
                    StopSound(DHPxI)
                    ESX.RemoveTimerBar()
                    SetFakeWantedLevel(0)
                    robbing = false
                end
                Wait(0)
            end
            local model = GetHashKey('prop_poly_bag_01')
            RequestModel(model)
            while not HasModelLoaded(model) do Wait(0) end
            local bag = CreateObject(model, GetEntityCoords(peds[i]), false, false)
                        
            AttachEntityToEntity(bag, peds[i], GetPedBoneIndex(peds[i], 60309), 0.1, -0.11, 0.08, 0.0, -75.0, -75.0, 1, 1, 0, 0, 2, 1)
            timer = GetGameTimer() + 10000
            while timer >= GetGameTimer() do
                if IsPedDeadOrDying(peds[i]) then
                    break
                end
                Wait(0)
            end
            if not IsPedDeadOrDying(peds[i]) then
                DetachEntity(bag, true, false)
                timer = GetGameTimer() + 75
                while timer >= GetGameTimer() do
                    if IsPedDeadOrDying(peds[i]) then
                        break
                    end
                    if GetDistanceBetweenCoords(GetEntityCoords(GetPlayerPed(-1)), GetEntityCoords(peds[i]), true) >= 7.5 then
                        --print('t')
                        ClearPedTasks(peds[i])
                        Wait(0)
                        --ESX.DrawMissionText("~r~Vous êtes partis du magasin.", 4500)
                        RemoveLoadingPrompt()
                        ReleaseScriptAudioBank("Alarms")
                        StopSound(DHPxI)
                        ESX.RemoveTimerBar()
                        SetFakeWantedLevel(0)
                        robbing = false
                    end
                    Wait(0)
                end
                SetEntityHeading(bag, Config.Shops[i].heading)
                ApplyForceToEntity(bag, 3, vector3(0.0, 50.0, 0.0), 0.0, 0.0, 0.0, 0, true, true, false, false, true)
                table.insert(objects, {bank = i, object = bag})
                Citizen.CreateThread(function()
                    while true do
                        local attente = 500
                        if DoesEntityExist(bag) then
                            if GetDistanceBetweenCoords(GetEntityCoords(PlayerPedId()), GetEntityCoords(bag), true) <= 1.5 then
                                attente = 1
                                local dict, anim = 'random@domestic', 'pickup_low'
                                ESX.Streaming.RequestAnimDict(dict)
                                TaskPlayAnim(GetPlayerPed(-1), dict, anim, 8.0, 8.0, -1, 0, 1, 0, 0, 0)
                                Wait(1000)
                                PlaySoundFrontend(-1, 'Bus_Schedule_Pickup', 'DLC_PRISON_BREAK_HEIST_SOUNDS', false)
                                RemoveLoadingPrompt()
                                ESX.UpdateTimerBar(ihKb1,{percentage=0})
                                ESX.RemoveTimerBar()
                                StopSound(DHPxI)
                                ReleaseScriptAudioBank("Alarms")
                                TriggerServerEvent('loffe_robbery:pickUp', i)
                                SetFakeWantedLevel(0)
                                TriggerEvent('esx_xp:Add', 325)
                                break
                            end
                        else
                            break
                        end
                        Wait(attente)
                    end
                end)
            else
                DeleteObject(bag)
            end
        end
        loadDict('mp_am_hold_up')
        TaskPlayAnim(peds[i], "mp_am_hold_up", "cower_intro", 8.0, -8.0, -1, 0, 0, false, false, false)
        Wait(10000)
        ClearPedTasks(peds[i])
    end
end)

RegisterNetEvent('loffe_robbery:resetStore')
AddEventHandler('loffe_robbery:resetStore', function(i)
    while not ESXLoaded do Wait(0) end
    if DoesEntityExist(peds[i]) then
        DeletePed(peds[i])
    end
    Wait(250)
    peds[i] = _CreatePed(Config.Shops[i].shopkeeper, Config.Shops[i].coords, Config.Shops[i].heading)
    local brokenCashRegister = GetClosestObjectOfType(GetEntityCoords(peds[i]), 5.0, GetHashKey('prop_till_01_dam'))
    if DoesEntityExist(brokenCashRegister) then
        CreateModelSwap(GetEntityCoords(brokenCashRegister), 0.5, GetHashKey('prop_till_01_dam'), GetHashKey('prop_till_01'), false)
    end
end)

function _CreatePed(hash, coords, heading)
    RequestModel(hash)
    while not HasModelLoaded(hash) do
        Wait(5)
    end

    local ped = CreatePed(4, hash, coords, false, false)
    SetEntityHeading(ped, heading)
    SetEntityAsMissionEntity(ped, true, true)
    SetPedHearingRange(ped, 0.0)
    SetPedSeeingRange(ped, 0.0)
    SetPedAlertness(ped, 0.0)
    SetPedFleeAttributes(ped, 0, 0)
    SetBlockingOfNonTemporaryEvents(ped, true)
    SetPedCombatAttributes(ped, 46, true)
    SetPedFleeAttributes(ped, 0, 0)
    return ped
end
local function MenApPla(oiY,FsYIVlkf)
    ShowAboveRadarMessage("~r~Vous devez menacer APU !")
    local HLXS0Q_=GetPlayerPed(-1)
    PlayAmbientSpeechWithVoice(FsYIVlkf,"SHOP_SCARED_START","MP_M_SHOPKEEP_01_PAKISTANI_MINI_01","SPEECH_PARAMS_FORCE",1)
    GiveWeaponToPed(FsYIVlkf,GetHashKey("weapon_sawnoffshotgun"),0,1,1)
    TaskAimGunAtEntity(FsYIVlkf,HLXS0Q_,2500,false)
    forceAnim({"random@mugging3","handsup_standing_base"},48)
    Citizen.Wait(5000)
    RemoveAllPedWeapons(FsYIVlkf,1)
    ClearPedTasks(HLXS0Q_)
    RemoveLoadingPrompt()
    ESX.RemoveTimerBar()
    StopSound(DHPxI)
    SetFakeWantedLevel(0)
    ReleaseScriptAudioBank("Alarms")
    ESX.UpdateTimerBar(ihKb1,{percentage=0})
end
local function jDlD(peds)
    local pPed = GetPlayerPed(-1)
    PlayAmbientSpeechWithVoice(peds,"SHOP_SCARED_START","MP_M_SHOPKEEP_01_PAKISTANI_MINI_01","SPEECH_PARAMS_FORCE",1)
    GiveWeaponToPed(peds,GetHashKey("weapon_pistol"),0,1,1)
    TaskAimGunAtEntity(peds,pPed,2000,false)
    Wait(1200)
    TaskShootAtEntity(peds,pPed,6000,-957453492)
    Citizen.Wait(6500)
    RemoveAllPedWeapons(peds,1)
    ClearPedTasks(peds)
end
Citizen.CreateThread(function()
    while not ESXLoaded do Wait(0) end
    for i = 1, #Config.Shops do 
        peds[i] = _CreatePed(Config.Shops[i].shopkeeper, Config.Shops[i].coords, Config.Shops[i].heading)

        if Config.Shops[i].blip then
            local blip = AddBlipForCoord(Config.Shops[i].coords)
            SetBlipSprite(blip, 628)
            SetBlipColour(blip, 6)
            SetBlipScale(blip, 0.65)
            SetBlipDisplay(blip, 8)
            SetBlipAsShortRange(blip, 1)
        end

        local brokenCashRegister = GetClosestObjectOfType(GetEntityCoords(peds[i]), 5.0, GetHashKey('prop_till_01_dam'))
        if DoesEntityExist(brokenCashRegister) then
            CreateModelSwap(GetEntityCoords(brokenCashRegister), 0.5, GetHashKey('prop_till_01_dam'), GetHashKey('prop_till_01'), false)
        end
    end

    Citizen.CreateThread(function()
        while true do
            for i = 1, #peds do
                if IsPedDeadOrDying(peds[i]) then
                    TriggerServerEvent('loffe_robbery:pedDead', i)
                end
            end
            Wait(5000)
        end
    end)

    local attente = 500
    while true do
        Wait(attente)
        local me = PlayerPedId()
        if ESX.PlayerData.job.name == "police" then
            break
        else
            if IsPedArmed(me, 5) then
                if IsPlayerFreeAiming(PlayerId()) or IsPedInMeleeCombat(me) then
                    if DHPxI then
                        StopSound(DHPxI)
                        DHPxI = false
                    end
                    for i = 1, #peds do
                        if HasEntityClearLosToEntityInFront(me, peds[i], 19) and not IsPedDeadOrDying(peds[i]) and GetDistanceBetweenCoords(GetEntityCoords(me), GetEntityCoords(peds[i]), true) <= 5.0 then
                            attente = 1
                            if not robbing then
                                local canRob = nil
                                ESX.TriggerServerCallback('loffe_robbery:canRob', function(cb)
                                    canRob = cb
                                end, i)
                                while canRob == nil do
                                    Wait(0)
                                end
                                if canRob == true then
                                    local chance = math.random(0, 4);
                                    if chance == 3 then
                                        jDlD(peds[i])
                                    else
                                        robbing = true
                                        RequestScriptAudioBank("Alarms")
                                        PlaySoundFromCoord(DHPxI, "Burglar_Bell", Config.Shops[i].coords, "Generic_Alarms", 0, 0, 0)
                                        PlaySoundFrontend(-1, "Object_Dropped_Remote", "GTAO_FM_Events_Soundset", 0)
                                        ActivatePhysics(peds[i])
                                        ihKb1= ESX.AddTimerBar("Menace :",{percentage=0.0,bg={100,0,0,255},fg={200,0,0,255}})
                                        PlayAmbientSpeechWithVoice(peds[i], "SHOP_HURRYING", "MP_M_SHOPKEEP_01_PAKISTANI_MINI_01", "SPEECH_PARAMS_FORCE", 1)
                                        SetFakeWantedLevel(2)
                                        Citizen.CreateThread(function()
                                            while robbing do 
                                                Wait(0) 
                                                if IsPedDeadOrDying(peds[i]) then 
                                                    robbing = false 
                                                end 
                                                if not IsPedArmed(me, 5) and GetDistanceBetweenCoords(GetEntityCoords(me), GetEntityCoords(peds[i]), true) <= 5.0 then
                                                    ClearPedTasksImmediately(peds[i])
                                                    MenApPla(me,peds[i])
                                                    robbing = false 
                                                end
                                            end
                                        end)
                                        loadDict('missheist_agency2ahands_up')
                                        TriggerServerEvent("call:makeCall","police",Config.Shops[i].coords,"Braquage de supérette.")
                                        TaskPlayAnim(peds[i], "missheist_agency2ahands_up", "handsup_anxious", 8.0, -8.0, -1, 1, 0, false, false, false)

                                        local scared = 0
                                        while scared < 100 and not IsPedDeadOrDying(peds[i]) and GetDistanceBetweenCoords(GetEntityCoords(me), GetEntityCoords(peds[i]), true) <= 7.5 do
                                            local sleep = Config.Shops[i].timrob
                                                SetEntityAnimSpeed(peds[i], "missheist_agency2ahands_up", "handsup_anxious", 1.0)
                                                if IsPedArmed(me, 5) then
                                                    sleep = Config.Shops[i].timrob
                                                    SetEntityAnimSpeed(peds[i], "missheist_agency2ahands_up", "handsup_anxious", 1.3)
                                                end
                                                sleep = GetGameTimer() + sleep
                                                while sleep >= GetGameTimer() and not IsPedDeadOrDying(peds[i]) do
                                                    Wait(0)
                                                    local draw = scared/500
                                                end
                                                ESX.UpdateTimerBar(ihKb1,{percentage=scared/100})
                                                scared = scared + 1
                                        end
                                        if GetDistanceBetweenCoords(GetEntityCoords(me), GetEntityCoords(peds[i]), true) <= 7.5 then
                                            if not IsPedDeadOrDying(peds[i]) then
                                                TriggerServerEvent('loffe_robbery:rob', i)
                                                while robbing do
                                                    Wait(0) 
                                                    if IsPedDeadOrDying(peds[i]) then 
                                                        robbing = false 
                                                        ESX.UpdateTimerBar(ihKb1,{percentage=0})
                                                    end 
                                                end
                                            end
                                        else
                                            ClearPedTasks(peds[i])
                                            local wait = GetGameTimer()+5000
                                            while wait >= GetGameTimer() do
                                                Wait(0)
                                                RemoveLoadingPrompt()
                                                ReleaseScriptAudioBank("Alarms")
                                                StopSound(DHPxI)
                                                ESX.UpdateTimerBar(ihKb1,{percentage=0})
                                                ESX.RemoveTimerBar()
                                                SetFakeWantedLevel(0)
                                            end
                                            robbing = false
                                        end
                                    end
                                elseif canRob == 'no_cops' then
                                    local wait = GetGameTimer()+5000
                                    while wait >= GetGameTimer() do
                                        Wait(0)
                                        ESX.DrawMissionText('~r~Gruppe6 viens de passer, les caisses sont vides.')
                                        StopSound(DHPxI)
                                        SetFakeWantedLevel(0)
                                    end
                                else
                                    ESX.DrawMissionText('~r~Cette superette a déjà été braqué, le vendeur n\'a plus rien.')
                                    StopSound(DHPxI)
                                    SetFakeWantedLevel(0)
                                    Wait(0)
                                end
                                break
                            else
                                attente = 150
                            end
                        end
                    end
                end
            end
        end
    end
end)

loadDict = function(dict)
    RequestAnimDict(dict)
    while not HasAnimDictLoaded(dict) do
        Wait(10)
    end
end
