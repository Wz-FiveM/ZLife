local rA5U = "v_ilev_gb_vauldr" or "v_ilev_bk_vaultdoor"
local Uc06 = "anim@heists@fleeca_bank@drilling"
local lcBL = 0;
local DHPxI = "FM_Mission_Controler"
local dx = 0;
local RRuSHnxf = 0;
local mcYOuT;
local Rr;
local scRP0;
local AI0R2TQ6;
local yA;
local XmVolesU
local eZ0l3ch = {
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
local function W_63_9(PEqsd)
    local iSj = GetPlayerPed(-1)
    if PEqsd == 1 then
        forceAnim({"anim@heists@humane_labs@emp@hack_door","hack_outro"}, 0)
        Citizen.Wait(GetAnimDuration("anim@heists@humane_labs@emp@hack_door", "hack_outro") * 800)
        ShowAboveRadarMessage("~r~Votre tentative de piratage a échoué.")
    elseif PEqsd == 2 then
        ClearPedTasks(iSj)
        ShowAboveRadarMessage("~r~Vous avez abandonné.")
    end
    if Rr then
        DeleteEntity(Rr)
        Rr = nil
    end
    if scRP0 then
        NetworkStopSynchronisedScene(scRP0)
        scRP0 = nil
    end
    if mcYOuT then
        DeleteEntity(mcYOuT)
        mcYOuT = nil
    end
    if XmVolesU then
        DeleteEntity(XmVolesU)
        XmVolesU = nil
    end
    if AI0R2TQ6 then
        SetScaleformMovieAsNoLongerNeeded(AI0R2TQ6)
        AI0R2TQ6 = nil
    end
    if helpScaleform then
        SetScaleformMovieAsNoLongerNeeded(helpScaleform)
        helpScaleform = nil
    end
    if drillSoundID then
        StopSound(drillSoundID)
        drillSoundID = nil
    end
    if yA then
        StopParticleFxLooped(yA, 0)
        yA = nil;
        RemoveNamedPtfxAsset(DHPxI)
    end
    RemoveAnimDict("anim@heists@humane_labs@emp@hack_door")
    RemoveAnimDict("anim@heists@fleeca_bank@bank_vault_door")
    RemoveAnimDict(Uc06)
    ReleaseScriptAudioBank([[DLC_MPHEIST\HEIST_FLEECA_DRILL]], false)
    ReleaseScriptAudioBank([[DLC_MPHEIST\HEIST_FLEECA_DRILL_2]], false)
    ReleaseScriptAudioBank("Vault_Door", false)
    SetModelAsNoLongerNeeded("prop_phone_ing_03")
    TriggerEvent("fleecac:HackingMinigame", 2)
    if lcBL ~= 0 then
        SetPedComponentVariation(iSj, 5, lcBL, 0, 2)
    end
    RRuSHnxf = 0;
    dx = 0;
    lcBL = 0
end
local function h9dyA_4T()
    dx = 3;
    local iXxD6s = GetPlayerPed(-1)
    local oiY = eZ0l3ch[RRuSHnxf.id]
    local FsYIVlkf = oiY.rewardAnim;
    local SqwPMon = oiY.moneywin
    local HLXS0Q_ = vec3(FsYIVlkf.x, FsYIVlkf.y, FsYIVlkf.z)
    DetachEntity(XmVolesU, 1, 1)
    StopEntityAnim(XmVolesU, "bag_drill_straight_idle", "anim@heists@fleeca_bank@drilling", 3)
    scRP0 = NetworkCreateSynchronisedScene(HLXS0Q_, 0.0, 0.0, FsYIVlkf.a, 2, true, false, 1065353216, 0, 1065353216)
    NetworkAddPedToSynchronisedScene(iXxD6s, scRP0, Uc06, "outro", 1000.0, -8.0, 3341, 16, 1148846080, 0)
    NetworkAddEntityToSynchronisedScene(XmVolesU, scRP0, Uc06, "bag_outro", 1000.0, -1.5, 0)
    NetworkForceLocalUseOfSyncedSceneCamera(scRP0, Uc06, "outro_cam")
    N_0xc9b43a33d09cada7(scRP0)
    NetworkStartSynchronisedScene(scRP0)
    Citizen.Wait(0)
    local Kw = NetworkConvertSynchronisedSceneToSynchronizedScene(scRP0)
    while IsSynchronizedSceneRunning(Kw) and GetSynchronizedScenePhase(Kw) <= 0.9 do
        Citizen.Wait(0)
    end
    if GetSynchronizedScenePhase(Kw) < 0.9 then
        Citizen.Wait(5000)
    end
    NetworkStopSynchronisedScene(scRP0)
    SetPedComponentVariation(iXxD6s, 5, lcBL or 0, 0, 2)
    FreezeEntityPosition(iXxD6s, false)
    W_63_9()
    TriggerEvent("fleecac:clientBankHeist", 3, SqwPMon)
end
local function oh(nvaIsNv7)
    if nvaIsNv7 then
        UseParticleFxAssetNextCall(DHPxI)
        yA = StartNetworkedParticleFxLoopedOnEntity("scr_drill_debris", mcYOuT, 0.0, -0.55, 0.01, -90.0, 0.0, 0.0, 0.5,1065353216, 1065353216, 0)
        SetParticleFxLoopedEvolution(yA, "power", 0.3, 0)
        drillSoundID = GetSoundId()
        PlaySoundFromEntity(drillSoundID, "Drill", mcYOuT, "DLC_HEIST_FLEECA_SOUNDSET", 1, 0)
    else
        StopSound(drillSoundID)
        drillSoundID = nil
        StopParticleFxLooped(yA, 0)
        yA = nil
    end
end
local function DZXGTh()
    local xlAK = GetPlayerPed(-1)
    local zr1y = eZ0l3ch[RRuSHnxf.id]
    RequestAndWaitDict(Uc06)
    RequestNamedPtfxAsset(DHPxI)
    while not HasNamedPtfxAssetLoaded(DHPxI) do
        Citizen.Wait(0)
    end
    dx = 2;
    local Hs = zr1y.rewardAnim;
    local jk = vec3(Hs.x, Hs.y, Hs.z)
    TriggerServerEvent("clp:removeitem", "drill", 0)
    RequestAndWaitModel("hei_prop_heist_drill")
    RequestAndWaitModel("hei_p_m_bag_var22_arm_s")
    local qzSFyIO, Z65 = false, GetGameTimer()
    while not qzSFyIO and Z65 + 3000 > GetGameTimer() do
        Wait(1000)
    end
    mcYOuT = CreateObject(GetHashKey("hei_prop_heist_drill"), GetEntityCoords(xlAK), true)
    SetNetworkIdCanMigrate(ObjToNet(mcYOuT), false)
    AttachEntityToEntity(mcYOuT, xlAK, GetPedBoneIndex(xlAK, 28422), 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, false, false, false,false, 2, true)
    XmVolesU = CreateObject(GetHashKey("hei_p_m_bag_var22_arm_s"), GetEntityCoords(xlAK), true)
    SetNetworkIdCanMigrate(ObjToNet(XmVolesU), false)
    SetEntityVisible(XmVolesU, 0, 0)
    TaskMoveNetworkAdvanced(xlAK, "minigame_drilling", jk, 0.0, 0.0, Hs.a, 2, 0.5, 0, Uc06, 4)
    FreezeEntityPosition(xlAK, true)
    N_0x2208438012482a1a(xlAK, 0, 1)
    SetEntityVisible(XmVolesU, 1, 1)
    FreezeEntityPosition(XmVolesU, 0)
    lcBL = GetPedDrawableVariation(xlAK, 5)
    SetPedComponentVariation(xlAK, 5, 0, 0, 2)
    scRP0 = NetworkCreateSynchronisedScene(jk, 0.0, 0.0, Hs.a, 2, true, false, 1065353216, 0, 1065353216)
    NetworkAddEntityToSynchronisedScene(XmVolesU, scRP0, Uc06, "bag_intro", 1000.0, -1.5, 0)
    NetworkForceLocalUseOfSyncedSceneCamera(scRP0, Uc06, "intro_cam")
    N_0xc9b43a33d09cada7(scRP0)
    NetworkStartSynchronisedScene(scRP0)
    Citizen.Wait(0)
    local umyCNfj = NetworkConvertSynchronisedSceneToSynchronizedScene(scRP0)
    while IsSynchronizedSceneRunning(umyCNfj) and GetSynchronizedScenePhase(umyCNfj) <= 0.9 do
        Citizen.Wait(0)
    end
    if GetSynchronizedScenePhase(umyCNfj) < 0.9 then
        W_63_9(2)
    end
    NetworkStopSynchronisedScene(scRP0)
    scRP0 = nil
    AttachEntityToEntity(XmVolesU, xlAK, GetPedBoneIndex(xlAK, 60309), 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0, 0, 0, 0, 2, 1)
    ClearPedTasks(xlAK)
    TaskPlayAnim(xlAK, Uc06, "drill_straight_idle", 1000.0, -1.5, -1, 1)
    PlayEntityAnim(XmVolesU, "bag_drill_straight_idle", "anim@heists@fleeca_bank@drilling", 1000.0, true, 0, 0, 0, 0)
    ForceEntityAiAndAnimationUpdate(XmVolesU)
    AI0R2TQ6 = createScaleform("drilling", {{name = "SET_SPEED",param = {0.1}},{name = "SET_HOLE_DEPTH",param = {0.6}},{name = "SET_DRILL_POSITION",param = {0.3}},{name = "SET_TEMPERATURE",param={0.0}}})
    helpScaleform = createScaleform("INSTRUCTIONAL_BUTTONS", {{name = "CLEAR_ALL",param = {}},{name = "TOGGLE_MOUSE_BUTTONS",param = {0}},{name = "CREATE_CONTAINER",param = {}},{name = "SET_DATA_SLOT",param = {0,GetControlInstructionalButton(2, 51, 0),"Alumer"}},
        {name = "SET_DATA_SLOT",param = {1,GetControlInstructionalButton(2, 237, 0),"Enfoncer"}},{name = "SET_DATA_SLOT",param = {2,GetControlInstructionalButton(2, 238, 0),"Relacher"}},
        {name = "DRAW_INSTRUCTIONAL_BUTTONS",param = {-1}}})
    dx = 2
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
local function Su9Koz(FT)
    local YVLXYq = eZ0l3ch[FT]
    local bJfct = YVLXYq.vaultPos
    local OhuFpq_N = GetClosestObjectOfType(bJfct.x, bJfct.y, bJfct.z, 8.0, GetHashKey(YVLXYq.vaultdoor))
    if OhuFpq_N and DoesEntityExist(OhuFpq_N) then
        local Dzg = "anim@heists@fleeca_bank@bank_vault_door"
        RequestAndWaitDict(Dzg)
        PlayEntityAnim(OhuFpq_N, "bank_vault_door_opens", Dzg, 4.0, false, true, false, 0.0, 8)
        SetEntityNoCollisionEntity(OhuFpq_N, LocalPlayer().Ped, true)
        ForceEntityAiAndAnimationUpdate(OhuFpq_N)
        TriggerEvent('ps_fleecavaultopen', OhuFpq_N)
        PlaySoundFromCoord(-1, "vault", bJfct.x, bJfct.y, bJfct.z, "HACKING_DOOR_UNLOCK_SOUNDS", 1, 30, 0)
    end
end
local function Uk7e(_4O)
    local C = eZ0l3ch[_4O]
    local fLI2zRe = C.vaultPos
    local _Fr2YU = GetClosestObjectOfType(fLI2zRe.x, fLI2zRe.y, fLI2zRe.z, 8.0, GetHashKey(C.vaultdoor))
    if _Fr2YU and DoesEntityExist(_Fr2YU) then
        StopEntityAnim(_Fr2YU, "anim@heists@fleeca_bank@bank_vault_door", "bank_vault_door_opens", -1000.0)
        SetEntityNoCollisionEntity(_Fr2YU, LocalPlayer().Ped, false)
        SetEntityRotation(_Fr2YU, 0.0, 0.0, fLI2zRe.w, 2, 1)
        ForceEntityAiAndAnimationUpdate(_Fr2YU)
    end
end
local IS_DEV = false
local function KwQCk_G(Xfn)
    local U = LocalPlayer()
    local Ebsw, UlikV = U.Ped, U.Pos
    if not Xfn then
        RequestAndWaitModel("prop_phone_ing_03")
        Rr = CreateObject(GetHashKey("prop_phone_ing_03"), UlikV, false, true, false)
        SetEntityAsMissionEntity(Rr, true, true)
        AttachEntityToEntity(Rr, Ebsw, GetPedBoneIndex(Ebsw, 28422), 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, false, false, false,false, 2, true)
        TaskSynchronizedTasks(Ebsw, {{ anim = {"anim@heists@humane_labs@emp@hack_door","hack_intro"},flag = 0},{anim = {"anim@heists@humane_labs@emp@hack_door","hack_loop"},flag = 1}})
        Citizen.Wait(5000)
    end
    Citizen.Wait(0)
    TaskSynchronizedTasks(Ebsw, {{anim = {"anim@heists@humane_labs@emp@hack_door","hack_outro"},flag = 0}})
    DeleteEntity(Rr)
    local ped = GetPlayerPed(-1)
    local o5sms = eZ0l3ch[RRuSHnxf.id]
    TriggerEvent("fleecac:clientBankHeist", 2, RRuSHnxf)
    dx = 1
end
local function ptZa()
    RequestScriptAudioBank([[DLC_MPHEIST\HEIST_FLEECA_DRILL]], false)
    RequestScriptAudioBank([[DLC_MPHEIST\HEIST_FLEECA_DRILL_2]], false)
    RequestScriptAudioBank("Vault_Door", false)
    KwQCk_G()
    Citizen.CreateThread(function()
        local YAtG_LV3 = 0.0;
        local LfEJbh_ = 0.0;
        local JD = 0.0;
        local u = 0.0;
        local pzDMZwG = false;
        local XPoQB = false;
        local XxJ = 1.0
        while RRuSHnxf ~= 0 do
            Citizen.Wait(0)
            local o5sms = eZ0l3ch[RRuSHnxf.id]
            local JQi1jg = LocalPlayer()
            local wVzn = JQi1jg.Pos
            if JQi1jg.Dead or not o5sms or GetDistanceBetweenCoords(wVzn, o5sms.hackPos) > 30 then
                W_63_9(2)
                return
            end
            if dx == 1 then
                DrawMarker(0, o5sms.rewardPos, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.4, 0.4, 0.25, 0, 141, 255, 70, 0, 0, 2, 0,0, 0, 0)
                local pE = GetDistanceBetweenCoords(wVzn, o5sms.rewardPos)
                if pE < 5.0 then
                    DrawText3D(o5sms.rewardPos.x,o5sms.rewardPos.y,o5sms.rewardPos.z+0.75, "Appuyez sur ~b~E ~w~pour utiliser votre ~b~perceuse.", 7)
                    if IsControlJustReleased(0, 51) and pE < 1.3 then
                        DZXGTh()
                    end
                end
            elseif dx == 2 and AI0R2TQ6 and HasScaleformMovieLoaded(AI0R2TQ6) then
                DrawScaleformMovieFullscreen(AI0R2TQ6, 255, 255, 255, 255)
                DrawScaleformMovieFullscreen(helpScaleform, 255, 255, 255, 255)
                HideHudAndRadarThisFrame()
                DisableControlAction(0, 24, true)
                DisableControlAction(0, 25, true)
                local RSjapQ, QJf = IsControlPressed(0, 237), IsControlPressed(0, 238)
                local zC = false
                if RSjapQ and
                    ((u >= 0.225 and u <= 0.325 and YAtG_LV3 <= 0.325) or (u >= 0.35 and u <= 0.45 and YAtG_LV3 <= 0.45) or
                        (u >= 0.5 and u <= 0.6 and YAtG_LV3 <= 0.6) or (u >= 0.625 and u <= 0.725 and YAtG_LV3 <= 0.725)) then
                    zC = true;
                    if XxJ ~= 0.5 then
                        XxJ = 0.5
                        SetVariableOnSound(drillSoundID, "DrillState", 0.5)
                    end
                end
                if not zC and XxJ == 0.5 then
                    XxJ = 0.0
                    SetVariableOnSound(drillSoundID, "DrillState", 0.0)
                end
                if IsControlJustPressed(0, 51) and not pzDMZwG then
                    XPoQB = not XPoQB;
                    oh(XPoQB)
                end
                if XPoQB and LfEJbh_ < 0.5 then
                    LfEJbh_ = math.max(0, math.min(0.5, LfEJbh_ + 0.005))
                elseif not XPoQB and LfEJbh_ > 0.0 then
                    LfEJbh_ = math.max(0, math.min(0.5, LfEJbh_ - 0.005))
                end
                if not pzDMZwG and RSjapQ and XPoQB then
                    u = math.max(0, math.min(1.0, u + 0.001 * (zC and 0.5 or 1.0)))
                    if u > YAtG_LV3 then
                        YAtG_LV3 = math.max(0, math.min(1.0, YAtG_LV3 + 0.001))
                    end
                    if YAtG_LV3 > 0.1 and YAtG_LV3 - u <= 0.01 then
                        JD = math.max(0, math.min(1.0, JD + (zC and 0.005 or 0.002)))
                    end
                end
                if not pzDMZwG and QJf and XPoQB then
                    u = math.max(0, math.min(1.0, u - 0.0025))
                end
                if not QJf and not RSjapQ and JD > 0.0 then
                    JD = math.max(0, math.min(1.0, JD - 0.0015))
                end
                if JD > 0.7 and not pzDMZwG then
                    pzDMZwG = true
                    PlaySoundFrontend(-1, "Drill_Pin_Break", "DLC_HEIST_FLEECA_SOUNDSET", true)
                    oh()
                elseif pzDMZwG then
                    if JD < 0.1 then
                        pzDMZwG = false
                    end
                    LfEJbh_ = 0.0
                    u = math.max(0, math.min(1.0, u - 0.0075))
                end
                if YAtG_LV3 >= 0.96 then
                    PlaySoundFromEntity(-1, "Drill_Jam", JQi1jg.Ped, "DLC_HEIST_FLEECA_SOUNDSET", 1, 20)
                    SetScaleformMovieAsNoLongerNeeded(AI0R2TQ6)
                    AI0R2TQ6 = nil
                    oh()
                    h9dyA_4T()
                end
                CallScaleformMovieFunctionFloatParams(AI0R2TQ6, "SET_SPEED", LfEJbh_ * (zC and 0.5 or 1.0), -1082130432,-1082130432, -1082130432, -1082130432)
                CallScaleformMovieFunctionFloatParams(AI0R2TQ6, "SET_HOLE_DEPTH", YAtG_LV3, -1082130432, -1082130432,-1082130432, -1082130432)
                CallScaleformMovieFunctionFloatParams(AI0R2TQ6, "SET_DRILL_POSITION", u, -1082130432, -1082130432,-1082130432, -1082130432)
                CallScaleformMovieFunctionFloatParams(AI0R2TQ6, "SET_TEMPERATURE", JD, -1082130432, -1082130432,-1082130432, -1082130432)
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

function StartFleecaHeist(pfZ3SPy_, pDNa2ox6, Do6yo7nm)
    local y06X3k, ivnJjrA = pfZ3SPy_.Ped, pfZ3SPy_.Pos;
    local d3fMjkg
    for w, sgeP in pairs(eZ0l3ch) do
        local CM = GetDistanceBetweenCoords(sgeP.hackPos, ivnJjrA)
        if CM < 3 and (not d3fMjkg or CM <= GetDistanceBetweenCoords(eZ0l3ch[d3fMjkg].hackPos, ivnJjrA)) then
            d3fMjkg = w
        end
    end
    if not d3fMjkg then
        ShowAboveRadarMessage("~r~Vous n'êtes pas dans une Fleeca Bank.")
        return
    end
    if not getbags(11) then return ShowAboveRadarMessage("~r~Vous n'avez pas de sac tactique.") end

    
    TriggerEvent("fleecac:clientBankHeist", 1, {
        id = d3fMjkg,
        county = GetCountyFromPlayer(pfZ3SPy_)
    })
    CloseMenu()
end
RegisterNetEvent("fleecac:StartDrill")
AddEventHandler("fleecac:StartDrill", function(Qlmlet, _)
    StartFleecaHeist(LocalPlayer())
end)
RegisterNetEvent("fleecac:clientBankHeist")
AddEventHandler("fleecac:clientBankHeist", function(Qlmlet, _)
    if Qlmlet == 1 then
        RRuSHnxf = _;
        ptZa()
    elseif Qlmlet == 2 then
        if _ then
            if _.start == GetPlayerServerId(PlayerId()) then
                dx = 1
            end
            Su9Koz(_.id)
        else
            Uk7e(_.id)
        end
    elseif Qlmlet == 3 then
        local moNeoe= math.random(_.a,_.b)
        TriggerServerEvent("fleecac:givemoney", moNeoe)
        drawCenterText("Vous avez récupéré ~r~"..moNeoe.."$.", 10000)
    end
end)




