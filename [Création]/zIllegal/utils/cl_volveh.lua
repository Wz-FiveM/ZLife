local TimeMissionLimit = 60*1000*20

function createped(model,pos,heading,pPed,weapon)
    local playerped = GetPlayerPed(-1)
    RequestModel(model)
        while not HasModelLoaded(model) do
        Wait(10)
    end
    AddRelationshipGroup('MissionNPC')
	AddRelationshipGroup('PlayerPed')
	pedy = CreatePed(4, model, pos.x, pos.y+5, pos.z, heading, false, false)
	SetPedRelationshipGroupHash(pedy, 'MissionNPC')
    GiveWeaponToPed(pedy,GetHashKey(weapon),250,false,true)
    SetPedInfiniteAmmo(pedy,true,GetHashKey(weapon))
    SetCurrentPedWeapon(pedy,GetHashKey(weapon),true)
	SetPedArmour(pedy,100)
	SetPedDropsWeaponsWhenDead(pedy, false) 
	SetRelationshipBetweenGroups(5,GetPedRelationshipGroupDefaultHash(playerped),'MissionNPC')
	SetRelationshipBetweenGroups(5,'MissionNPC',GetPedRelationshipGroupDefaultHash(playerped))
    TaskAimGunAtEntity(pedy,playerped,2000,false)
    TaskShootAtEntity(pedy,playerped,6000,-957453492)
end
function VoleDeVehicule(LongText, vehicule, possibleSpawn, stop, prix, id)
    StartMusicEvent("MP_MC_ASSAULT_ADV_START")
    StartMusicEvent("MP_MC_ASSAULT_ADV_SUSPENSE")
    ESX.AddTimerBar("TEMPS RESTANT :",{endTime=GetGameTimer()+TimeMissionLimit})
    ShowAboveRadarMessage("~b~Simeon\n~s~"..LongText)
    local i = math.random(1, #possibleSpawn)
    local spawn = possibleSpawn[i].pos
    local heading = possibleSpawn[i].heading

    local blip = createBlip(spawn ,326,3,"Véhicule",true,1.0)
    local pPed = GetPlayerPed(-1)
    local pVeh = GetVehiclePedIsIn(pPed, false)
    local pCoords = GetEntityCoords(pPed)
    local dst = GetDistanceBetweenCoords(spawn, pCoords, true)
    while dst >= 30.0 do
        Wait(100)
        pCoords = GetEntityCoords(pPed)
        dst = GetDistanceBetweenCoords(spawn, pCoords, true)
        RageUI.Text({message = "Dirigez vous vers ~b~la destination~s~."})
    end
    local coords = {x=spawn.x,y=spawn.y,z=spawn.z}
    TriggerServerEvent("call:makeCall","police",coords,"Transaction bizarre.")
    AddTextEntry("VOLE_VEH_MISSION", "Véhicule à récupérer.")
    SpawnVehNotIn(vehicule, spawn, heading, "SIMEONYE")
    createped("s_m_y_robber_01",spawn,heading,GetPlayerPed(-1),"weapon_poolcue")
    createped("mp_m_g_vagfun_01",spawn,heading,GetPlayerPed(-1),"weapon_battleaxe")

    while dst >= 3.0 do
        Wait(1)
        DistantCopCarSirens(1)
        ShowFloatingHelp("VOLE_VEH_MISSION", spawn)
        RageUI.Text({message = "Le ~r~véhicule ~s~n'est pas loin."})
        pCoords = GetEntityCoords(pPed)
        DrawMarker(0,spawn.x,spawn.y,spawn.z+2.6,0.0,0.0,0.0,0.0,0.0,0.0,1.0,1.0,0.7,0,192,255,70,0,0,2,0,0,0,0)
        dst = GetDistanceBetweenCoords(spawn, pCoords, true)
    end

    RemoveBlip(blip)

    local blip = AddBlipForCoord(stop)
    SetBlipRoute(blip, 1)
    
    local dst = GetDistanceBetweenCoords(stop, pCoords, true)
    PlaySoundFrontend(-1, "Object_Dropped_Remote", "GTAO_FM_Events_Soundset", 0)
    ShowAboveRadarMessage("~b~Simeon\n~s~Crochetez le véhicule avec vos lockpick.")
    SetFakeWantedLevel(2)
    while dst >= 5.0 do
        Wait(1)
        RageUI.Text({message = "Livrez le véhicule ~y~à destination~s~."})
        pCoords = GetEntityCoords(pPed)
        dst = GetDistanceBetweenCoords(pCoords, stop, true)
    end

    local plate = GetVehicleNumberPlateText(GetVehiclePedIsIn(GetPlayerPed(-1), 0))
    local pEngine = GetVehicleEngineHealth(GetVehiclePedIsIn(GetPlayerPed(-1)))
    if plate == "SIMEONYE" then 
        if pEngine > 750 then 
            ESX.RemoveTimerBar()
            PlaySoundFrontend(-1, "Out_Of_Bounds_Timer", "DLC_HEISTS_GENERAL_FRONTEND_SOUNDS", 0)
            ShowAboveRadarMessage("~b~Simeon\n~s~Vous avez reçu de l'argent. (~r~"..prix.."$~s~).")
            DistantCopCarSirens(0)
            RemoveBlip(blip)
            SetBlipRoute(blip, 0)
            TaskVehicleTempAction(GetPlayerPed(-1), GetVehiclePedIsIn(GetPlayerPed(-1), 0), 6, 2000)
            Wait(2000)
            TaskLeaveAnyVehicle(GetPlayerPed(-1), 0, 0)
            SetVehicleDoorsLocked(GetVehiclePedIsIn(GetPlayerPed(-1), 1), 1)
            StartMusicEvent("MP_MC_ASSAULT_ADV_STOP")
            TriggerServerEvent("clp_mission:givemoney", prix)
            TriggerServerEvent("clp_mission:SetStatus", id)
            gain = prix
            d()
            DeleteVehi()
            SetFakeWantedLevel(0)
            TriggerEvent('esx_xp:Add', 500)
        else 
            ShowAboveRadarMessage("~b~Simeon\n~s~Votre véhicule est trop abimé.")
            ESX.RemoveTimerBar()
            PlaySoundFrontend(-1, "Out_Of_Bounds_Timer", "DLC_HEISTS_GENERAL_FRONTEND_SOUNDS", 0)
            DistantCopCarSirens(0)
            RemoveBlip(blip)
            SetBlipRoute(blip, 0)
            TaskVehicleTempAction(GetPlayerPed(-1), GetVehiclePedIsIn(GetPlayerPed(-1), 0), 6, 2000)
            Wait(2000)
            TaskLeaveAnyVehicle(GetPlayerPed(-1), 0, 0)
            SetVehicleDoorsLocked(GetVehiclePedIsIn(GetPlayerPed(-1), 1), 1)
            StartMusicEvent("MP_MC_ASSAULT_ADV_STOP")
            TriggerServerEvent("clp_mission:SetStatus", id)
            Wait(3500)
            DeleteVehi()
            SetFakeWantedLevel(0)
        end
    else
        ESX.RemoveTimerBar()
        DistantCopCarSirens(0)
        PlaySoundFrontend(-1, "Out_Of_Bounds_Timer", "DLC_HEISTS_GENERAL_FRONTEND_SOUNDS", 0)
        RemoveBlip(blip)
        SetBlipRoute(blip, 0)
        ShowAboveRadarMessage("~b~Simeon\n~s~T'a essayé de me niquer ? T'aurais pas dû !")
        StartMusicEvent("MP_MC_ASSAULT_ADV_STOP")
        TriggerServerEvent("clp_mission:SetStatus", id)
        SetEntityHealth(GetPlayerPed(-1), 125)
        DeleteVehi()
        SetFakeWantedLevel(0)
        TriggerEvent('esx_xp:Add',  -500)
    end
end

function VoleDeVehiculeLamar(LongText, vehicule, possibleSpawn, stop, prix, id)
    local pVehSdq = GetVehiclePedIsIn(GetPlayerPed(-1), false)
    StartMusicEvent("MP_MC_ASSAULT_ADV_START")
    StartMusicEvent("MP_MC_ASSAULT_ADV_SUSPENSE")
    ESX.AddTimerBar("TEMPS RESTANT :",{endTime=GetGameTimer()+TimeMissionLimit})
    ShowAboveRadarMessage("~g~Lamar\n~s~"..LongText)
    local i = math.random(1, #possibleSpawn)
    local spawn = possibleSpawn[i].pos
    local heading = possibleSpawn[i].heading

    local blip = createBlip(spawn ,326,2,"Véhicule",true,1.0)
    local pPed = GetPlayerPed(-1)
    local pVeh = GetVehiclePedIsIn(pPed, false)
    local pCoords = GetEntityCoords(pPed)
    local dst = GetDistanceBetweenCoords(spawn, pCoords, true)
    while dst >= 30.0 do
        Wait(100)
        pCoords = GetEntityCoords(pPed)
        dst = GetDistanceBetweenCoords(spawn, pCoords, true)
        RageUI.Text({message = "Dirigez vous vers ~y~la destination~s~."})
    end
    local coords = {x=spawn.x,y=spawn.y,z=spawn.z}
    TriggerServerEvent("call:makeCall","police",coords,"Transaction bizarre.")
    AddTextEntry("VOLE_VEH_MISSION", "Véhicule à récupérer.")
    SpawnVehNotIn(vehicule, spawn, heading, "LOWRIDER")
    createped("ig_g",spawn,heading,GetPlayerPed(-1),"weapon_bat")
    createped("s_m_y_dealer_01",spawn,heading,GetPlayerPed(-1),"weapon_machete")

    while dst >= 3.0 do
        Wait(1)
        DistantCopCarSirens(1)
        ShowFloatingHelp("VOLE_VEH_MISSION", spawn)
        RageUI.Text({message = "Le ~r~véhicule ~s~n'est pas loin."})
        pCoords = GetEntityCoords(pPed)
        DrawMarker(0,spawn.x,spawn.y,spawn.z+2.6,0.0,0.0,0.0,0.0,0.0,0.0,1.0,1.0,0.7,6,214,20,70,0,0,2,0,0,0,0)
        dst = GetDistanceBetweenCoords(spawn, pCoords, true)
    end

    RemoveBlip(blip)

    local blip = AddBlipForCoord(stop)
    SetBlipRoute(blip, 1)
    
    local dst = GetDistanceBetweenCoords(stop, pCoords, true)
    PlaySoundFrontend(-1, "Object_Dropped_Remote", "GTAO_FM_Events_Soundset", 0)
    ShowAboveRadarMessage("~g~Lamar\n~s~Crochetez le véhicule avec vos lockpick.")
    SetFakeWantedLevel(2)
    while dst >= 5.0 do
        Wait(1)
        RageUI.Text({message = "Livrez le véhicule ~g~à destination~s~."})
        pCoords = GetEntityCoords(pPed)
        dst = GetDistanceBetweenCoords(pCoords, stop, true)
    end

    local plate = GetVehicleNumberPlateText(GetVehiclePedIsIn(GetPlayerPed(-1), 0))
    local pEngine = GetVehicleEngineHealth(GetVehiclePedIsIn(GetPlayerPed(-1)))
    if plate == "LOWRIDER" then 
        if pEngine > 750 then 
            ESX.RemoveTimerBar()
            PlaySoundFrontend(-1, "Out_Of_Bounds_Timer", "DLC_HEISTS_GENERAL_FRONTEND_SOUNDS", 0)
            ShowAboveRadarMessage("~g~Lamar\n~s~Vous avez reçu de l'argent. (~r~"..prix.."$~s~).")
            DistantCopCarSirens(0)
            RemoveBlip(blip)
            SetBlipRoute(blip, 0)
            TaskVehicleTempAction(GetPlayerPed(-1), GetVehiclePedIsIn(GetPlayerPed(-1), 0), 6, 2000)
            Wait(2000)
            TaskLeaveAnyVehicle(GetPlayerPed(-1), 0, 0)
            SetVehicleDoorsLocked(GetVehiclePedIsIn(GetPlayerPed(-1), 1), 1)
            StartMusicEvent("MP_MC_ASSAULT_ADV_STOP")
            TriggerServerEvent("clp_mission:givemoney", prix)
            TriggerServerEvent("clp_mission:SetStatus", id)
            gain = prix
            d()
            DeleteVehi()
            SetFakeWantedLevel(0)
            TriggerEvent('esx_xp:Add',  500)
        else 
            ShowAboveRadarMessage("~g~Lamar\n~s~Votre véhicule est trop abimé.")
            ESX.RemoveTimerBar()
            PlaySoundFrontend(-1, "Out_Of_Bounds_Timer", "DLC_HEISTS_GENERAL_FRONTEND_SOUNDS", 0)
            DistantCopCarSirens(0)
            RemoveBlip(blip)
            SetBlipRoute(blip, 0)
            TaskVehicleTempAction(GetPlayerPed(-1), GetVehiclePedIsIn(GetPlayerPed(-1), 0), 6, 2000)
            Wait(2000)
            TaskLeaveAnyVehicle(GetPlayerPed(-1), 0, 0)
            SetVehicleDoorsLocked(GetVehiclePedIsIn(GetPlayerPed(-1), 1), 1)
            StartMusicEvent("MP_MC_ASSAULT_ADV_STOP")
            TriggerServerEvent("clp_mission:SetStatus", id)
            DeleteVehi()
            SetFakeWantedLevel(0)
        end
    else
        ESX.RemoveTimerBar()
        DistantCopCarSirens(0)
        PlaySoundFrontend(-1, "Out_Of_Bounds_Timer", "DLC_HEISTS_GENERAL_FRONTEND_SOUNDS", 0)
        RemoveBlip(blip)
        SetBlipRoute(blip, 0)
        ShowAboveRadarMessage("~g~Lamar\n~s~T'a essayé de me niquer ? T'aurais pas dû !")
        StartMusicEvent("MP_MC_ASSAULT_ADV_STOP")
        TriggerServerEvent("clp_mission:SetStatus", id)
        SetEntityHealth(GetPlayerPed(-1), 125)
        DeleteVehi()
        SetFakeWantedLevel(0)
        TriggerEvent('esx_xp:Add',  -500)
    end
end
function Voledemarchandise(LongText, vehicule, possibleSpawn, stop, prix, id)
    local pVehSdq = GetVehiclePedIsIn(GetPlayerPed(-1), false)
    StartMusicEvent("MP_MC_ASSAULT_ADV_START")
    StartMusicEvent("MP_MC_ASSAULT_ADV_SUSPENSE")
    ESX.AddTimerBar("TEMPS RESTANT :",{endTime=GetGameTimer()+TimeMissionLimit})
    ShowAboveRadarMessage("~r~Cargaison\n~s~"..LongText)
    local i = math.random(1, #possibleSpawn)
    local spawn = possibleSpawn[i].pos
    local heading = possibleSpawn[i].heading

    local blip = createBlip(spawn ,514,1,"Cargaison",true,1.0)
    local pPed = GetPlayerPed(-1)
    local pVeh = GetVehiclePedIsIn(pPed, false)
    local pCoords = GetEntityCoords(pPed)
    local dst = GetDistanceBetweenCoords(spawn, pCoords, true)
    while dst >= 30.0 do
        Wait(100)
        pCoords = GetEntityCoords(pPed)
        dst = GetDistanceBetweenCoords(spawn, pCoords, true)
        RageUI.Text({message = "La ~r~cargaison ~s~ne vas pas t'attendre, dépêche toi !"})
    end
    local coords = {x=spawn.x,y=spawn.y,z=spawn.z}
    TriggerServerEvent("call:makeCall","police",coords,"Transaction bizarre.")
    AddTextEntry("VOLE_VEH_MISSION", "Cargaison à récupérer.")
    SpawnVehNotIn(vehicule, spawn, heading, "MARCH911")
    PlaySoundFrontend(-1, "CAR_BIKE_WHOOSH", "MP_LOBBY_SOUNDS", 0)
    createped("ig_dreyfuss",spawn,heading,GetPlayerPed(-1),"weapon_pistol50")

    while dst >= 3.0 do
        Wait(1)
        DistantCopCarSirens(1)
        ShowFloatingHelp("VOLE_VEH_MISSION", spawn)
        RageUI.Text({message = "La ~r~cargaison ~s~n'est pas loin."})
        pCoords = GetEntityCoords(pPed)
        DrawMarker(0,spawn.x,spawn.y,spawn.z+5,0.0,0.0,0.0,0.0,0.0,0.0,1.0,1.0,0.7,255,0,0,70,0,0,2,0,0,0,0)
        dst = GetDistanceBetweenCoords(spawn, pCoords, true)
    end

    RemoveBlip(blip)

    local blip = AddBlipForCoord(stop)
    SetBlipRoute(blip, 1)
    
    local dst = GetDistanceBetweenCoords(stop, pCoords, true)
    PlaySoundFrontend(-1, "Object_Dropped_Remote", "GTAO_FM_Events_Soundset", 0)
    ShowAboveRadarMessage("~r~Cargaison\n~s~Je t'attend avec la cargaison complète !")
    ShowAboveRadarMessage("~r~Cargaison\n~s~Crochetez le véhicule avec vos lockpick.")
    SetFakeWantedLevel(2)
    while dst >= 5.0 do
        Wait(1)
        RageUI.Text({message = "Livrez la cargaison ~y~à destination~s~."})
        pCoords = GetEntityCoords(pPed)
        dst = GetDistanceBetweenCoords(pCoords, stop, true)
    end

    local plate = GetVehicleNumberPlateText(GetVehiclePedIsIn(GetPlayerPed(-1), 0))
    local pEngine = GetVehicleEngineHealth(GetVehiclePedIsIn(GetPlayerPed(-1)))
    if plate == "MARCH911" then 
        if pEngine > 750 then 
            ESX.RemoveTimerBar()
            PlaySoundFrontend(-1, "Out_Of_Bounds_Timer", "DLC_HEISTS_GENERAL_FRONTEND_SOUNDS", 0)
            ShowAboveRadarMessage("~r~Cargaison terminé.\n~s~Vous avez reçu une partie de la ~r~cargaison~s~.")
            DistantCopCarSirens(0)
            RemoveBlip(blip)
            SetBlipRoute(blip, 0)
            TaskVehicleTempAction(GetPlayerPed(-1), GetVehiclePedIsIn(GetPlayerPed(-1), 0), 6, 2000)
            Wait(2000)
            TaskLeaveAnyVehicle(GetPlayerPed(-1), 0, 0)
            SetVehicleDoorsLocked(GetVehiclePedIsIn(GetPlayerPed(-1), 1), 1)
            StartMusicEvent("MP_MC_ASSAULT_ADV_STOP")
            TriggerServerEvent("clp_mission:giveitemmission")
            TriggerServerEvent("clp_mission:SetStatus", id)
            d()
            DeleteVehi()
            SetFakeWantedLevel(0)
            TriggerEvent('esx_xp:Add', 1000)
        else 
            ShowAboveRadarMessage("~r~Cargaison\n~s~Votre véhicule est trop abimé.")
            ESX.RemoveTimerBar()
            PlaySoundFrontend(-1, "Out_Of_Bounds_Timer", "DLC_HEISTS_GENERAL_FRONTEND_SOUNDS", 0)
            DistantCopCarSirens(0)
            RemoveBlip(blip)
            SetBlipRoute(blip, 0)
            TaskVehicleTempAction(GetPlayerPed(-1), GetVehiclePedIsIn(GetPlayerPed(-1), 0), 6, 2000)
            Wait(2000)
            TaskLeaveAnyVehicle(GetPlayerPed(-1), 0, 0)
            SetVehicleDoorsLocked(GetVehiclePedIsIn(GetPlayerPed(-1), 1), 1)
            StartMusicEvent("MP_MC_ASSAULT_ADV_STOP")
            TriggerServerEvent("clp_mission:SetStatus", id)
            DeleteVehi()
            SetFakeWantedLevel(0)
        end
    else
        ESX.RemoveTimerBar()
        DistantCopCarSirens(0)
        PlaySoundFrontend(-1, "Out_Of_Bounds_Timer", "DLC_HEISTS_GENERAL_FRONTEND_SOUNDS", 0)
        RemoveBlip(blip)
        SetBlipRoute(blip, 0)
        ShowAboveRadarMessage("~r~Cargaison\n~s~T'a essayé de me niquer ? T'aurais pas dû !")
        StartMusicEvent("MP_MC_ASSAULT_ADV_STOP")
        TriggerServerEvent("clp_mission:SetStatus", id)
        SetEntityHealth(GetPlayerPed(-1), 125)
        DeleteVehi()
        SetFakeWantedLevel(0)
        TriggerEvent('esx_xp:Add', -1000)
    end
end