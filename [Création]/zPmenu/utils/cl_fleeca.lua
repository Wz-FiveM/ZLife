local dict = "anim@heists@fleeca_bank@drilling"
local getVaria = 0
local prEffect = "FM_Mission_Controler"
local moove = 0
local nFleeca = 0
local ObjectDrill
local ObjectTel
local SynchroS
local ScalformMoov
local netScal
local ObjectBag
local posFleeca = {
    {
        hackPos = vec3(146.84, -1046.07, 28.37),
        vaultPos = vec4(148.03, -1044.36, 29.51, -110.15),
        rewardPos = vector3(150.22, -1050.13, 28.35),
        vaultdoor = "v_ilev_gb_vauldr",
        moneywin = {
            a = 15000,
            b = 25000,
        },
        rewardAnim = {
            x = 150.9,
            y = -1049.9,
            z = 29.6,
            a = 250.0
        }
    },
    {
        hackPos = vector3(-1210.83, -336.52, 36.78),
        vaultPos = vec4(-1211.26, -344.56, 37.92, -63.14),
        rewardPos = vector3(-1205.39, -336.79, 36.76),
        vaultdoor = "v_ilev_gb_vauldr",
        moneywin = {
            a = 15000,
            b = 25000,
        },
        rewardAnim = {
            x = -1205.23,
            y = -336.26,
            z = 38.0,
            a = 296.42
        }
    },
    {
        hackPos = vector3(311.2, -284.43, 53.16),
        vaultPos = vec4(312.36, -282.73, 54.3, -110.13),
        rewardPos = vector3(314.83, -288.41, 53.14),
        vaultdoor = "v_ilev_gb_vauldr",
        moneywin = {
            a = 15000,
            b = 25000,
        },
        rewardAnim = {
            x = 315.22,
            y = -288.3,
            z = 54.37,
            a = 246.55
        }
    },
    {
        hackPos = vector3(-353.86, -55.3, 48.04),
        vaultPos = vec4(-352.74, -53.57, 49.18, -109.14),
        rewardPos = vector3(-350.19, -59.44, 48.02),
        vaultdoor = "v_ilev_gb_vauldr",
        moneywin = {
            a = 15000,
            b = 25000,
        },
        rewardAnim = {
            x = -349.76,
            y = -59.05,
            z = 49.25,
            a = 248.0
        }
    },
    {
        hackPos = vector3(1176.08, 2712.88, 37.09),
        vaultPos = vec4(1175.54, 2710.86, 38.23, 90.0),
        rewardPos = vector3(1171.31, 2715.73, 37.07),
        vaultdoor = "v_ilev_gb_vauldr",
        moneywin = {
            a = 15000,
            b = 25000,
        },
        rewardAnim = {
            x = 1170.98,
            y = 2715.07,
            z = 38.325,
            a = 90.0
        }
    },
    {
        hackPos = vector3(253.24, 228.44, 101.68),
        vaultPos = vec4(254.04, 225.16, 101.88, 90.0),
        rewardPos = vector3(265.76, 213.52, 101.68-0.98),
        vaultdoor = "v_ilev_bk_vaultdoor",
        moneywin = {
            a = 200000,
            b = 400000,
        },
        rewardAnim = {
            x = 266.25,
            y = 213.0,
            z = 102.1,
            a = 249.73
        }
    },

    {
        hackPos = vector3(-105.52, 6470.84, 31.64),
        vaultPos = vec4(-105.28, 6472.92, 31.64, 90.0),
        rewardPos = vector3(-105.72, 6478.16, 31.64-0.98),
        vaultdoor = "v_ilev_cbankvaulgate01",
        moneywin = {
            a = 200000,
            b = 400000,
        },
        rewardAnim = {
            x = -105.88,
            y = 6478.95,
            z = 32.10,
            a = 45.17
        }
    }
}
local function AnimStartFin(PEqsd)
    local pPed = GetPlayerPed(-1)
    if PEqsd == 1 then
        forceAnim({"anim@heists@humane_labs@emp@hack_door","hack_outro"}, 0)
        Citizen.Wait(GetAnimDuration("anim@heists@humane_labs@emp@hack_door", "hack_outro") * 800)
        ShowAboveRadarMessage("~r~Votre tentative de piratage a échoué.")
    elseif PEqsd == 2 then
        ClearPedTasks(pPed)
        ShowAboveRadarMessage("~r~Vous avez abandonné.")
    end
    if ObjectTel then
        DeleteEntity(ObjectTel)
        ObjectTel = nil
    end
    if SynchroS then
        NetworkStopSynchronisedScene(SynchroS)
        SynchroS = nil
    end
    if ObjectDrill then
        DeleteEntity(ObjectDrill)
        ObjectDrill = nil
    end
    if ObjectBag then
        DeleteEntity(ObjectBag)
        ObjectBag = nil
    end
    if ScalformMoov then
        SetScaleformMovieAsNoLongerNeeded(ScalformMoov)
        ScalformMoov = nil
    end
    if helpScaleform then
        SetScaleformMovieAsNoLongerNeeded(helpScaleform)
        helpScaleform = nil
    end
    if drillSoundID then
        StopSound(drillSoundID)
        drillSoundID = nil
    end
    if netScal then
        StopParticleFxLooped(netScal, 0)
        netScal = nil;
        RemoveNamedPtfxAsset(prEffect)
    end
    RemoveAnimDict("anim@heists@humane_labs@emp@hack_door")
    RemoveAnimDict("anim@heists@fleeca_bank@bank_vault_door")
    RemoveAnimDict(dict)
    ReleaseScriptAudioBank([[DLC_MPHEIST\HEIST_FLEECA_DRILL]], false)
    ReleaseScriptAudioBank([[DLC_MPHEIST\HEIST_FLEECA_DRILL_2]], false)
    ReleaseScriptAudioBank("Vault_Door", false)
    SetModelAsNoLongerNeeded("prop_v_m_phone_01")
    TriggerEvent("fleecac:HackingMinigame", 2)
    if getVaria ~= 0 then
        SetPedComponentVariation(pPed, 5, getVaria, 0, 2)
    end
    nFleeca = 0;
    moove = 0;
    getVaria = 0
end
local function FinFleeca()
    moove = 3;
    local pPed1 = GetPlayerPed(-1)
    local nuFleeca = posFleeca[nFleeca.id]
    local fReward = nuFleeca.rewardAnim;
    local fMoneyWin = nuFleeca.moneywin
    local posReward = vec3(fReward.x, fReward.y, fReward.z)
    DetachEntity(ObjectBag, 1, 1)
    StopEntityAnim(ObjectBag, "bag_drill_straight_idle", "anim@heists@fleeca_bank@drilling", 3)
    SynchroS = NetworkCreateSynchronisedScene(posReward, 0.0, 0.0, fReward.a, 2, true, false, 1065353216, 0, 1065353216)
    NetworkAddPedToSynchronisedScene(pPed1, SynchroS, dict, "outro", 1000.0, -8.0, 3341, 16, 1148846080, 0)
    NetworkAddEntityToSynchronisedScene(ObjectBag, SynchroS, dict, "bag_outro", 1000.0, -1.5, 0)
    NetworkForceLocalUseOfSyncedSceneCamera(SynchroS, dict, "outro_cam")
    N_0xc9b43a33d09cada7(SynchroS)
    NetworkStartSynchronisedScene(SynchroS)
    Citizen.Wait(0)
    local NetCSy = NetworkConvertSynchronisedSceneToSynchronizedScene(SynchroS)
    while IsSynchronizedSceneRunning(NetCSy) and GetSynchronizedScenePhase(NetCSy) <= 0.9 do
        Citizen.Wait(0)
    end
    if GetSynchronizedScenePhase(NetCSy) < 0.9 then
        Citizen.Wait(5000)
    end
    NetworkStopSynchronisedScene(SynchroS)
    SetPedComponentVariation(pPed1, 5, getVaria or 0, 0, 2)
    FreezeEntityPosition(pPed1, false)
    AnimStartFin()
    TriggerEvent("fleecac:clientBankHeist", 3, fMoneyWin)
end
local function stopsoundandparticle(bool)
    if bool then
        UseParticleFxAssetNextCall(prEffect)
        netScal = StartNetworkedParticleFxLoopedOnEntity("scr_drill_debris", ObjectDrill, 0.0, -0.55, 0.01, -90.0, 0.0, 0.0, 0.5,1065353216, 1065353216, 0)
        SetParticleFxLoopedEvolution(netScal, "power", 0.3, 0)
        drillSoundID = GetSoundId()
        PlaySoundFromEntity(drillSoundID, "Drill", ObjectDrill, "DLC_HEIST_FLEECA_SOUNDSET", 1, 0)
    else
        StopSound(drillSoundID)
        drillSoundID = nil
        StopParticleFxLooped(netScal, 0)
        netScal = nil
    end
end
local function StartScalform()
    local pPed2 = GetPlayerPed(-1)
    local numFleeca = posFleeca[nFleeca.id]
    RequestAndWaitDict(dict)
    RequestNamedPtfxAsset(prEffect)
    while not HasNamedPtfxAssetLoaded(prEffect) do
        Citizen.Wait(0)
    end
    moove = 2;
    local PosRewards = numFleeca.rewardAnim;
    local posRewarvec = vec3(PosRewards.x, PosRewards.y, PosRewards.z)
    TriggerServerEvent("clp:removeitem", "drill", 0)
    RequestAndWaitModel("hei_prop_heist_drill")
    RequestAndWaitModel("hei_p_m_bag_var22_arm_s")
    local secur, getTime5 = false, GetGameTimer()
    while not secur and getTime5 + 3000 > GetGameTimer() do
        Wait(1000)
    end
    ObjectDrill = CreateObject(GetHashKey("hei_prop_heist_drill"), GetEntityCoords(pPed2), true)
    SetNetworkIdCanMigrate(ObjToNet(ObjectDrill), false)
    AttachEntityToEntity(ObjectDrill, pPed2, GetPedBoneIndex(pPed2, 28422), 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, false, false, false,false, 2, true)
    ObjectBag = CreateObject(GetHashKey("hei_p_m_bag_var22_arm_s"), GetEntityCoords(pPed2), true)
    SetNetworkIdCanMigrate(ObjToNet(ObjectBag), false)
    SetEntityVisible(ObjectBag, 0, 0)
    TaskMoveNetworkAdvanced(pPed2, "minigame_drilling", posRewarvec, 0.0, 0.0, PosRewards.a, 2, 0.5, 0, dict, 4)
    FreezeEntityPosition(pPed2, true)
    N_0x2208438012482a1a(pPed2, 0, 1)
    SetEntityVisible(ObjectBag, 1, 1)
    FreezeEntityPosition(ObjectBag, 0)
    getVaria = GetPedDrawableVariation(pPed2, 5)
    SetPedComponentVariation(pPed2, 5, 0, 0, 2)
    SynchroS = NetworkCreateSynchronisedScene(posRewarvec, 0.0, 0.0, PosRewards.a, 2, true, false, 1065353216, 0, 1065353216)
    NetworkAddEntityToSynchronisedScene(ObjectBag, SynchroS, dict, "bag_intro", 1000.0, -1.5, 0)
    NetworkForceLocalUseOfSyncedSceneCamera(SynchroS, dict, "intro_cam")
    N_0xc9b43a33d09cada7(SynchroS)
    NetworkStartSynchronisedScene(SynchroS)
    Citizen.Wait(0)
    local umyCNfj = NetworkConvertSynchronisedSceneToSynchronizedScene(SynchroS)
    while IsSynchronizedSceneRunning(umyCNfj) and GetSynchronizedScenePhase(umyCNfj) <= 0.9 do
        Citizen.Wait(0)
    end
    if GetSynchronizedScenePhase(umyCNfj) < 0.9 then
        AnimStartFin(2)
    end
    NetworkStopSynchronisedScene(SynchroS)
    SynchroS = nil
    AttachEntityToEntity(ObjectBag, pPed2, GetPedBoneIndex(pPed2, 60309), 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0, 0, 0, 0, 2, 1)
    ClearPedTasks(pPed2)
    TaskPlayAnim(pPed2, dict, "drill_straight_idle", 1000.0, -1.5, -1, 1)
    PlayEntityAnim(ObjectBag, "bag_drill_straight_idle", "anim@heists@fleeca_bank@drilling", 1000.0, true, 0, 0, 0, 0)
    ForceEntityAiAndAnimationUpdate(ObjectBag)
    ScalformMoov = createScaleform("drilling", {{name = "SET_SPEED",param = {0.1}},{name = "SET_HOLE_DEPTH",param = {0.6}},{name = "SET_DRILL_POSITION",param = {0.3}},{name = "SET_TEMPERATURE",param={0.0}}})
    helpScaleform = createScaleform("INSTRUCTIONAL_BUTTONS", {{name = "CLEAR_ALL",param = {}},{name = "TOGGLE_MOUSE_BUTTONS",param = {0}},{name = "CREATE_CONTAINER",param = {}},{name = "SET_DATA_SLOT",param = {0,GetControlInstructionalButton(2, 51, 0),"Alumer"}},
                                                              {name = "SET_DATA_SLOT",param = {1,GetControlInstructionalButton(2, 237, 0),"Enfoncer"}},{name = "SET_DATA_SLOT",param = {2,GetControlInstructionalButton(2, 238, 0),"Relacher"}},
                                                              {name = "DRAW_INSTRUCTIONAL_BUTTONS",param = {-1}}})
    moove = 2
end
Citizen.CreateThread(function ()
    RegisterNetEvent("ps_fleecavaultopen")
    AddEventHandler("ps_fleecavaultopen", function (prop)
        Citizen.Wait(800)
        local count = 0
        repeat
            local rotation = GetEntityHeading(prop) - 0.05
            SetEntityHeading(prop, rotation)
            count = count + 1
            Citizen.Wait(3)
        until count == 1800
        FreezeEntityPosition(prop, true)
    end)
end)
local function OpenDoorFl(id)
    local idFleeca = posFleeca[id]
    local doorpos = idFleeca.vaultPos
    local getObjdoor = GetClosestObjectOfType(doorpos.x, doorpos.y, doorpos.z, 8.0, GetHashKey(idFleeca.vaultdoor))
    if getObjdoor and DoesEntityExist(getObjdoor) then
        local ditDoor = "anim@heists@fleeca_bank@bank_vault_door"
        RequestAndWaitDict(ditDoor)
        PlayEntityAnim(getObjdoor, "bank_vault_door_opens", ditDoor, 4.0, false, true, false, 0.0, 8)
        SetEntityNoCollisionEntity(getObjdoor, LocalPlayer().Ped, true)
        ForceEntityAiAndAnimationUpdate(getObjdoor)
        TriggerEvent('ps_fleecavaultopen', getObjdoor)
        PlaySoundFromCoord(-1, "vault", doorpos.x, doorpos.y, doorpos.z, "HACKING_DOOR_UNLOCK_SOUNDS", 1, 30, 0)
    end
end
local function AnimPhone1(Xfn)
    local pPlayer = LocalPlayer()
    local pePed, pePos = pPlayer.Ped, pPlayer.Pos
    if not Xfn then
        RequestAndWaitModel("prop_v_m_phone_01")
        ObjectTel = CreateObject(GetHashKey("prop_v_m_phone_01"), pePos, false, true, false)
        SetEntityAsMissionEntity(ObjectTel, true, true)
        AttachEntityToEntity(ObjectTel, pePed, GetPedBoneIndex(pePed, 28422), 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, false, false, false,false, 2, true)
        TaskSynchronizedTasks(pePed, {{ anim = {"anim@heists@humane_labs@emp@hack_door","hack_intro"},flag = 0},{anim = {"anim@heists@humane_labs@emp@hack_door","hack_loop"},flag = 1}})
        Citizen.Wait(5000)
    end
    local plyPos = GetEntityCoords(GetPlayerPed(-1), true)
    local msg = "Braquage de banque"
    TriggerServerEvent("call:makeCall", "police", {x=plyPos.x,y=plyPos.y,z=plyPos.z}, msg)
    Citizen.Wait(0)
    TaskSynchronizedTasks(pePed, {{anim = {"anim@heists@humane_labs@emp@hack_door","hack_outro"},flag = 0}})
    DeleteEntity(ObjectTel)
    local ped = GetPlayerPed(-1)
    local FleecaIds = posFleeca[nFleeca.id]
    TriggerEvent("fleecac:clientBankHeist", 2, nFleeca)
    moove = 1
end
local function StartCallScal()
    RequestScriptAudioBank([[DLC_MPHEIST\HEIST_FLEECA_DRILL]], false)
    RequestScriptAudioBank([[DLC_MPHEIST\HEIST_FLEECA_DRILL_2]], false)
    RequestScriptAudioBank("Vault_Door", false)
    AnimPhone1()
    Citizen.CreateThread(function()
        local Scal1 = 0.0;
        local Scal2 = 0.0;
        local Scal3 = 0.0;
        local Scal4 = 0.0;
        local RaterScal = false;
        local SoundScal = false;
        local SoundId = 1.0
        while nFleeca ~= 0 do
            Citizen.Wait(0)
            local FleecaIds = posFleeca[nFleeca.id]
            local pedPD1 = LocalPlayer()
            local pedPDpos = pedPD1.Pos
            if pedPD1.Dead or not FleecaIds or GetDistanceBetweenCoords(pedPDpos, FleecaIds.hackPos) > 30 then
                AnimStartFin(2)
                return
            end
            if moove == 1 then
                DrawMarker(0, FleecaIds.rewardPos, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.4, 0.4, 0.25, 0, 141, 255, 70, 0, 0, 2, 0,0, 0, 0)
                local disTance = GetDistanceBetweenCoords(pedPDpos, FleecaIds.rewardPos)
                if disTance < 5.0 then
                    DrawText3D(FleecaIds.rewardPos.x,FleecaIds.rewardPos.y,FleecaIds.rewardPos.z+0.75, "Appuyez sur ~b~E ~w~pour utiliser votre ~b~perceuse.", 7)
                    if IsControlJustReleased(0, 51) and disTance < 1.3 then
                        StartScalform()
                    end
                end
            elseif moove == 2 and ScalformMoov and HasScaleformMovieLoaded(ScalformMoov) then
                DrawScaleformMovieFullscreen(ScalformMoov, 255, 255, 255, 255)
                DrawScaleformMovieFullscreen(helpScaleform, 255, 255, 255, 255)
                HideHudAndRadarThisFrame()
                DisableControlAction(0, 24, true)
                DisableControlAction(0, 25, true)
                local Press237, Press238 = IsControlPressed(0, 237), IsControlPressed(0, 238)
                local StartSca = false
                if Press237 and
                        ((Scal4 >= 0.225 and Scal4 <= 0.325 and Scal1 <= 0.325) or (Scal4 >= 0.35 and Scal4 <= 0.45 and Scal1 <= 0.45) or
                                (Scal4 >= 0.5 and Scal4 <= 0.6 and Scal1 <= 0.6) or (Scal4 >= 0.625 and Scal4 <= 0.725 and Scal1 <= 0.725)) then
                    StartSca = true;
                    if SoundId ~= 0.5 then
                        SoundId = 0.5
                        SetVariableOnSound(drillSoundID, "DrillState", 0.5)
                    end
                end
                if not StartSca and SoundId == 0.5 then
                    SoundId = 0.0
                    SetVariableOnSound(drillSoundID, "DrillState", 0.0)
                end
                if IsControlJustPressed(0, 51) and not RaterScal then
                    SoundScal = not SoundScal;
                    stopsoundandparticle(SoundScal)
                end
                if SoundScal and Scal2 < 0.5 then
                    Scal2 = math.max(0, math.min(0.5, Scal2 + 0.005))
                elseif not SoundScal and Scal2 > 0.0 then
                    Scal2 = math.max(0, math.min(0.5, Scal2 - 0.005))
                end
                if not RaterScal and Press237 and SoundScal then
                    Scal4 = math.max(0, math.min(1.0, Scal4 + 0.001 * (StartSca and 0.5 or 1.0)))
                    if Scal4 > Scal1 then
                        Scal1 = math.max(0, math.min(1.0, Scal1 + 0.001))
                    end
                    if Scal1 > 0.1 and Scal1 - Scal4 <= 0.01 then
                        Scal3 = math.max(0, math.min(1.0, Scal3 + (StartSca and 0.005 or 0.002)))
                    end
                end
                if not RaterScal and Press238 and SoundScal then
                    Scal4 = math.max(0, math.min(1.0, Scal4 - 0.0025))
                end
                if not Press238 and not Press237 and Scal3 > 0.0 then
                    Scal3 = math.max(0, math.min(1.0, Scal3 - 0.0015))
                end
                if Scal3 > 0.7 and not RaterScal then
                    RaterScal = true
                    PlaySoundFrontend(-1, "Drill_Pin_Break", "DLC_HEIST_FLEECA_SOUNDSET", true)
                    stopsoundandparticle()
                elseif RaterScal then
                    if Scal3 < 0.1 then
                        RaterScal = false
                    end
                    Scal2 = 0.0
                    Scal4 = math.max(0, math.min(1.0, Scal4 - 0.0075))
                end
                if Scal1 >= 0.96 then
                    PlaySoundFromEntity(-1, "Drill_Jam", pedPD1.Ped, "DLC_HEIST_FLEECA_SOUNDSET", 1, 20)
                    SetScaleformMovieAsNoLongerNeeded(ScalformMoov)
                    ScalformMoov = nil
                    stopsoundandparticle()
                    FinFleeca()
                end
                CallScaleformMovieFunctionFloatParams(ScalformMoov, "SET_SPEED", Scal2 * (StartSca and 0.5 or 1.0), -1082130432,-1082130432, -1082130432, -1082130432)
                CallScaleformMovieFunctionFloatParams(ScalformMoov, "SET_HOLE_DEPTH", Scal1, -1082130432, -1082130432,-1082130432, -1082130432)
                CallScaleformMovieFunctionFloatParams(ScalformMoov, "SET_DRILL_POSITION", Scal4, -1082130432, -1082130432,-1082130432, -1082130432)
                CallScaleformMovieFunctionFloatParams(ScalformMoov, "SET_TEMPERATURE", Scal3, -1082130432, -1082130432,-1082130432, -1082130432)
            end
        end
    end)
end


local function getbags(num)
    local getbags = true
    TriggerEvent('skinchanger:getSkin', function(skin)
        for k, v in pairs(skin) do
            if skin.bags_1 ~= num then
                getbags = false
            end
        end
    end)
    return getbags
end

function StartFleecaHeist(pPed)
    local pedpeds, pedPos = pPed.Ped, pPed.Pos;
    local FleecaIn

    for k, v in pairs(posFleeca) do
        local distanceF = GetDistanceBetweenCoords(v.hackPos, pedPos)
        if distanceF < 3 and (not FleecaIn or distanceF <= GetDistanceBetweenCoords(posFleeca[FleecaIn].hackPos, pedPos)) then
            ESX.TriggerServerCallback('zlife:canRob', function(cb)
                canRob = cb
            end, i)
            while canRob == nil do
                Wait(0)
            end
            if canRob == true then
                FleecaIn = k
            else
                ESX.DrawMissionText("~r~Action impossible (police)", 5000)
            end

        end
    end
    if not FleecaIn then
        ShowAboveRadarMessage("~r~Vous n'êtes pas dans une Fleeca Bank.")
        return
    end

    if not getbags(11) then return ShowAboveRadarMessage("~r~Vous n'avez pas de sac tactique.") end

    TriggerEvent("fleecac:clientBankHeist", 1, {id = FleecaIn})
    CloseMenu()
end
RegisterNetEvent("fleecac:StartDrill")
AddEventHandler("fleecac:StartDrill", function()
    StartFleecaHeist(LocalPlayer())
end)
RegisterNetEvent("fleecac:clientBankHeist")
AddEventHandler("fleecac:clientBankHeist", function(bool, _)
    if bool == 1 then
        nFleeca = _;
        StartCallScal()
    elseif bool == 2 then
        if _ then
            OpenDoorFl(_.id)
        end
    elseif bool == 3 then
        local moNeoe= math.random(_.a,_.b)
        TriggerServerEvent("fleecac:givemoney", moNeoe)
        drawCenterText("Vous avez récupéré ~r~"..moNeoe.."$.", 10000)
    end
end)

