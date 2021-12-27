local CanDo = nil
RegisterNetEvent("clp_mission:pouvoir")
AddEventHandler("clp_mission:pouvoir", function(status)
    CanDo = status
end)

function braquo(data)
    CanDo = nil
    TriggerServerEvent("clp_mission:pouvoir")
    while CanDo == nil do Wait(10) end
    if CanDo then
        TriggerServerEvent("clp_mission:SetStatus")
        SetAudioFlag("LoadMPData", 1)
        DoScreenFadeOut(500)
        Wait(500)
        ESX.TriggerServerCallback('esx_skin:getPlayerSkin', function(skin)
            TriggerEvent('skinchanger:loadSkin', skin)
            TriggerEvent('esx:restoreLoadout')
        end)
        StartMusicEvent("MP_MC_ASSAULT_ADV_START")
        StartMusicEvent("MP_MC_ASSAULT_ADV_SUSPENSE")
        DoScreenFadeIn(500)
        PlaySoundFrontend(-1, "ROUND_ENDING_STINGER_CUSTOM", "CELEBRATION_SOUNDSET", 0)
        
        ShowAboveRadarMessage("~r~Bugstars.\n~b~"..data.LongText)
        local blip = AddBlipForCoord(data.spawnVeh)

        local pPed = GetPlayerPed(-1)
        local pCoords = GetEntityCoords(pPed)
        local dst = GetDistanceBetweenCoords(data.spawnVeh, pCoords, true)
        AddTextEntry("TRANSPORT_VEH", "Sortir le véhicule.")
        while dst > 2.5 do
            Wait(1)
            pCoords = GetEntityCoords(pPed)
            dst = GetDistanceBetweenCoords(data.spawnVeh, pCoords, true) 
            ShowFloatingHelp("TRANSPORT_VEH", data.spawnVeh)
            DrawMarker(36, data.spawnVeh.x, data.spawnVeh.y, data.spawnVeh.z+0.5, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.7, 0.7, 0.7, 0, 110, 120, 170, 0, 0, 0, 1, nil, nil, 0)
        end
        local clicked = false
        while not clicked do
            Wait(1)
            DrawMarker(36, data.spawnVeh.x, data.spawnVeh.y, data.spawnVeh.z+0.5, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.7, 0.7, 0.7, 0, 110, 120, 170, 0, 0, 0, 1, nil, nil, 0)
            DrawTopNotification("Appuyer sur ~INPUT_PICKUP~ pour ~g~sortir le véhicule.")
            if IsControlJustReleased(1, 38) then
                clicked = true
                ShowAboveRadarMessage("~r~Bugstars.\n~b~Maintenant dirigez-vous au lieu indiqué.")
                SpawnVeh(data.vehicule, data.spawnVeh, data.headingStart)
            end
        end
        RemoveBlip(blip)

        local blip = createBlip(data.stopVehicule ,616,3,"Braquage",true,1.0)
        local SurZone = false
        while not SurZone do
            Wait(1)
            RageUI.Text({message = "Dirigez vous vers ~b~la destination~s~."})
            local pPed = GetPlayerPed(-1)
            local pCoords = GetEntityCoords(pPed)
            local dst = GetDistanceBetweenCoords(pCoords, data.stopVehicule, true)
            DrawMarker(36, data.stopVehicule.x, data.stopVehicule.y, data.stopVehicule.z, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.9, 0.9, 0.9, 0, 110, 120, 170, 0, 0, 0, 1, nil, nil, 0)
            if dst <= 2.0 then
                if GetVehicleNumberPlateText(GetVehiclePedIsIn(GetPlayerPed(-1), 1), 0) == "BRAQU911" then
                    SurZone = true
                end
            end
        end

        SetEntityCoords(GetVehiclePedIsIn(GetPlayerPed(-1), 0), data.stopVehicule.x, data.stopVehicule.y, data.stopVehicule.z, 0.0, 0.0, 0.0, 0.0)
        SetEntityHeading(GetVehiclePedIsIn(GetPlayerPed(-1), 0), data.headingStop)
        TaskLeaveAnyVehicle(GetPlayerPed(-1), 0, 0)
        Wait(500)
        while IsPedInAnyVehicle(GetPlayerPed(-1), 0) do Wait(10) end
        local pCoords = GetEntityCoords(pPed)
        local dst = GetDistanceBetweenCoords(data.ChangementDeTenu, pCoords, true)
        while dst > 1.0 do
            Wait(1)
            pCoords = GetEntityCoords(pPed)
            dst = GetDistanceBetweenCoords(data.ChangementDeTenu, pCoords, true) 
            DrawMarker(41, data.ChangementDeTenu.x, data.ChangementDeTenu.y, data.ChangementDeTenu.z+0.5, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.5, 0.5, 0.5, 0, 110, 120, 170, 0, 0, 0, 1, nil, nil, 0)
            RageUI.Text({message = "Dirigez vous vers ~b~le coffre~s~."})
        end
        local clicked = false
        while not clicked do
            Wait(1)
            DrawTopNotification("Appuyer sur ~INPUT_PICKUP~ pour ~b~ouvrir le coffre du véhicule.")
            if IsControlJustReleased(1, 38) then
                clicked = true
            end
        end
        RemoveBlip(blip)
        NetworkRequestControlOfEntity(GetVehiclePedIsIn(GetPlayerPed(-1), 1))
        while not NetworkHasControlOfEntity(GetVehiclePedIsIn(GetPlayerPed(-1), 1)) do Wait(10) end
        SetVehicleDoorOpen(GetVehiclePedIsIn(GetPlayerPed(-1), 1), 3, 0, 0)
        SetVehicleDoorOpen(GetVehiclePedIsIn(GetPlayerPed(-1), 1), 2, 0, 0)

        local clicked = false
        while not clicked do
            Wait(1)
            DrawTopNotification("Appuyer sur ~INPUT_PICKUP~ pour ~r~s'habiller.")
            if IsControlJustReleased(1, 38) then
                clicked = true
            end
        end

        TriggerEvent("skinchanger:change", 'mask_1', 85)
        TriggerEvent("skinchanger:change", 'bags_1', 12)
        TriggerEvent("skinchanger:change", 'bags_2', 0)
        TriggerEvent("skinchanger:change", 'decals_1', 76)
        TriggerEvent("skinchanger:change", 'tshirt_1', 15)
        TriggerEvent("skinchanger:change", 'tshirt_2', 0)
        TriggerEvent("skinchanger:change", 'torso_1', 143)
        TriggerEvent("skinchanger:change", 'torso_2', 0)
        TriggerEvent("skinchanger:change", 'pants_1', 69)
        TriggerEvent("skinchanger:change", 'pants_2', 0)
        TriggerEvent("skinchanger:change", 'shoes_1', 35)
        TriggerEvent("skinchanger:change", 'shoes_2', 0)
        TriggerEvent("skinchanger:change", 'arms', 22)
        TriggerEvent("skinchanger:change", 'helmet_1', 139)
        TriggerEvent("skinchanger:change", 'helmet_2', 0)
        PlaySoundFrontend(-1, "Object_Collect_Player", "GTAO_FM_Events_Soundset", 0)
        local x,y,z = table.unpack(GetOffsetFromEntityInWorldCoords(PlayerPedId(), 0.0, 0.0, 0.0))
        local coords = {x=x,y=y,z=z}
        TriggerServerEvent("call:makeCall","police",coords,"Braquage en cours (Bugstars).")

        local EnCours = true
        local blips = {}

        local money = 0
        local objets = 0
        while EnCours do
            Wait(1)
            local pPed = GetPlayerPed(-1)
            local pCoords = GetEntityCoords(pPed)
            local x,y,z = table.unpack(GetEntityCoords(pPed))
            local prop_name = "hei_prop_heist_box"
            RageUI.Text({message = "Volez ~r~les objets~s~ et ~g~l'argent~s~ !"})
            for k,v in pairs(data.possibleVole) do
                DrawMarker(20, v.pos.x, v.pos.y, v.pos.z, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.25, 0.25, 0.25, 0, 110, 120, 170, 0, 0, 0, 1, nil, nil, 0)
                local dst = GetDistanceBetweenCoords(pCoords, v.pos, true)
                if dst <= 0.8 then
                    PlaySoundFrontend(-1, 'Bus_Schedule_Pickup', 'DLC_PRISON_BREAK_HEIST_SOUNDS', 0)
                    local dict, anim = 'anim@heists@box_carry@', 'idle'
					ESX.Streaming.RequestAnimDict(dict)
					TaskPlayAnim(pPed, dict, anim, 1.0, -1.0,-1,49,0,0, 0,0)
                    if not HasModelLoaded(prop_name) then
                        while not HasModelLoaded(GetHashKey(prop_name)) do
                            RequestModel(GetHashKey(prop_name))
                            Wait(10)
                        end
                    end
                    prop = CreateObject(GetHashKey(prop_name), x, y, z+0.2,  true,  true, true)
                    AttachEntityToEntity(prop, pPed, GetPedBoneIndex(pPed, 60309), 0.025, 0.08, 0.255, -145.0, 290.0, 0.0, true, true, false, true, 1, true)
                    table.remove(data.possibleVole, k)
                    local dst = GetDistanceBetweenCoords(data.ChangementDeTenu, pCoords, true)
                    while dst > 1.0 do
                        Wait(1)
                        pCoords = GetEntityCoords(pPed)
                        dst = GetDistanceBetweenCoords(data.ChangementDeTenu, pCoords, true) 
                        DrawMarker(39, data.ChangementDeTenu.x, data.ChangementDeTenu.y, data.ChangementDeTenu.z+0.5, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.42, 0.42, 0.42, 0, 110, 120, 170, 0, 0, 0, 1, nil, nil, 0)
                        RageUI.Text({message = "Allez déposer ~b~les objets~s~ dans le coffre."})
                    end

                    objets = objets + math.random(2,6)
                    if notifobj then 
                        RemoveNotification(notifobj)
                    end
                    notifobj = ShowAboveRadarMessage("~r~Bugstars.\n~s~Vous avez (~b~"..objets.."~s~) objets dans votre van.")
                    ClearPedTasks(pPed)
                    DeleteEntity(prop)
                    DeleteObject(prop)
                    PlaySoundFrontend(-1, "Object_Dropped_Remote", "GTAO_FM_Events_Soundset", 0)
                    for k,v in pairs(blips) do
                        RemoveBlip(v)
                    end
                end
            end
            for k,v in pairs(data.Caisse) do
                DrawMarker(29, v.pos.x, v.pos.y, v.pos.z, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.25, 0.25, 0.25, 0, 110, 120, 170, 0, 0, 0, 1, nil, nil, 0)
                local dst = GetDistanceBetweenCoords(pCoords, v.pos, true)
                if dst <= 0.8 then
                    PlaySoundFrontend(-1, 'Bus_Schedule_Pickup', 'DLC_PRISON_BREAK_HEIST_SOUNDS', 0)
                    local dict, anim = 'anim@heists@box_carry@', 'idle'
					ESX.Streaming.RequestAnimDict(dict)
					TaskPlayAnim(pPed, dict, anim, 1.0, -1.0,-1,49,0,0, 0,0)
                    if not HasModelLoaded(prop_name) then
                        while not HasModelLoaded(GetHashKey(prop_name)) do
                            RequestModel(GetHashKey(prop_name))
                            Wait(10)
                        end
                    end
                    prop = CreateObject(GetHashKey(prop_name), x, y, z+0.2,  true,  true, true)
                    AttachEntityToEntity(prop, pPed, GetPedBoneIndex(pPed, 60309), 0.025, 0.08, 0.255, -145.0, 290.0, 0.0, true, true, false, true, 1, true)
                    table.remove(data.Caisse, k)
                    local dst = GetDistanceBetweenCoords(data.ChangementDeTenu, pCoords, true)
                    while dst > 1.0 do
                        Wait(1)
                        pCoords = GetEntityCoords(pPed)
                        dst = GetDistanceBetweenCoords(data.ChangementDeTenu, pCoords, true) 
                        DrawMarker(39, data.ChangementDeTenu.x, data.ChangementDeTenu.y, data.ChangementDeTenu.z+0.5, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.42, 0.42, 0.42, 0, 110, 120, 170, 0, 0, 0, 1, nil, nil, 0)
                        RageUI.Text({message = "Déposez les objets dans le coffre."})
                    end

                    ClearPedTasks(pPed)
                    DeleteEntity(prop)
                    DeleteObject(prop)
                    PlaySoundFrontend(-1, "Object_Dropped_Remote", "GTAO_FM_Events_Soundset", 0)
                    local random = math.random(500, 1500)
                    money = money + random
                    ShowAboveRadarMessage("~r~Bugstars.\n~s~Vous avez volé (~b~"..money.."$~s~).")
                    for k,v in pairs(blips) do
                        RemoveBlip(v)
                    end
                end
            end

            if #data.possibleVole + #data.Caisse == 0 then
                EnCours = false
                SetVehicleDoorsShut(GetVehiclePedIsIn(GetPlayerPed(-1), 1), 0)
            end
        end

        for k,v in pairs(blips) do
            RemoveBlip(v)
        end

        PlaySoundFrontend(-1, "Out_Of_Bounds_Timer", "DLC_HEISTS_GENERAL_FRONTEND_SOUNDS", 0)
        DistantCopCarSirens(1)
        SetFakeWantedLevel(2)
        local dst = GetDistanceBetweenCoords(data.ChangementDeTenu, pCoords, true)
        while dst <= 100.0 do
            Wait(1)
            pCoords = GetEntityCoords(pPed)
            dst = GetDistanceBetweenCoords(data.ChangementDeTenu, pCoords, true) 
            ShowAboveRadarMessage("~r~Bugstars.\n~b~La police a été averti ! Fuyez !")
        end
        DistantCopCarSirens(0)
        RemoveBlip(blip)
        local blip = AddBlipForCoord(data.stop)
        SetBlipRoute(blip, 1)

        PlaySoundFrontend(-1, "ROUND_ENDING_STINGER_CUSTOM", "CELEBRATION_SOUNDSET", 0)
        local dst = GetDistanceBetweenCoords(data.stop, pCoords, true)
        while dst > 3.0 do
            Wait(1)
            pCoords = GetEntityCoords(pPed)
            dst = GetDistanceBetweenCoords(data.stop, pCoords, true) 
            DrawMarker(36, data.stop.x, data.stop.y, data.stop.z+0.5, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.9, 0.9, 0.9, 0, 110, 120, 170, 0, 0, 0, 1, nil, nil, 0)
            ShowAboveRadarMessage("~r~Bugstars.\n~b~Ok, maintenant rend toi au reseller.")
            RageUI.Text({message = "Dirigez vous vers ~b~le reseller~s~."})
        end
        SetVehicleDoorsLocked(GetVehiclePedIsIn(GetPlayerPed(-1), 1), 1)
        local finalMoney = 0
        for i = 1,objets do
            finalMoney = finalMoney + math.random(50, 160)
        end
        finalMoney = finalMoney + money

        DeleteVehi()
        SetFakeWantedLevel(0)
        DoScreenFadeOut(1000)
        Wait(1000)
        StartMusicEvent("MP_MC_ASSAULT_ADV_STOP")
        Wait(1000)
        SetEntityCoords(PlayerPedId(), -97.24, 2811.32, 53.24-0.98)
        SetEntityHeading(PlayerPedId(), 248.16)
        SetGameplayCamRelativeHeading(0.0)

        local Camera = CreateCam('DEFAULT_SCRIPTED_CAMERA', true)
        ShakeCam(Camera,"HAND_SHAKE",0.3)
        SetCamActive(Camera, true)
        RenderScriptCams(true, true, 10, true, true)

        SetCamFov(Camera,50.0)
        SetCamCoord(Camera, -86.44, 2804.96, 53.32-0.93)
        PointCamAtEntity(Camera,GetPlayerPed(-1))
        DoScreenFadeIn(3500)
        local dir = vector3(-87.04, 2805.36, 53.32)
        TaskGoToCoordAnyMeans(PlayerPedId(), dir, 1.0, 0, 0, 786603, 0xbf800000)

        Wait(1000)
        TriggerServerEvent("clp_mission:givemoney", finalMoney)
        ShowAboveRadarMessage("~r~Bugstars.\n~s~Félicitation, vous avez réussi la mission, vous avez reçu (~b~"..finalMoney.."$~s~).")
        TriggerServerEvent("clp_mission:SetStatus", data.id)
        gain = finalMoney
        displayDoneMission = true
        RemoveBlip(blip)
        Wait(3000)
        RenderScriptCams(false, true, 4000, true, true)
        DestroyCam(Camera)
        Wait(2000)
        ESX.TriggerServerCallback('esx_skin:getPlayerSkin', function(skin)
            TriggerEvent('skinchanger:loadSkin', skin)
            TriggerEvent('esx:restoreLoadout')
        end)
        TriggerEvent('esx_xp:Add',  1500)
    else
        ShowAboveRadarMessage("~r~Bugstars.\nDésolé, un braquo à déja eu lieu il y à pas longtemps.")
    end
end