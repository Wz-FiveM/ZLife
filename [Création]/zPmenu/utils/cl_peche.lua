local TimerBar;
local inFishing = false;
local HavePechet
local canStart = false;
local ScalFish;
local Pourcent = .0;
local timepeche = 0;
local inRecup = false;

---@class Actor
---@field public id number
---@field public name string

local pospechet = {
    {pos = vec3(2388.2, 4296.92, 35.16)},
}

local ChanceFish = function()
    return
    math.random(30 * 1000, 120 * 1000)
end

---@game Props
---@game Props
local fProps = GetHashKey("prop_dock_float_1b")
local prop_namepech = GetHashKey("prop_fishing_rod_01")

---@game Dict
---@game Dict
local dictOne = "amb@world_human_stand_fishing@base"
local distFish = "amb@world_human_stand_fishing@idle_a"

local objectprop;
local notifPecheId
local ScalDeform = { { "INPUT_CONTEXT", 51 }, { "INPUT_ENTER", 23 }, { "INPUT_SPECIAL_ABILITY_SECONDARY", 29 }, { "INPUT_COVER", 44 }, { "INPUT_VEH_HEADLIGHT", 74 }, { "INPUT_CELLPHONE_CAMERA_FOCUS_LOCK", 182 }, { "INPUT_FRONTEND_ACCEPT", 201 }, { "INPUT_PUSH_TO_TALK", 249 } }
local notifPecheId1

---@game GetZones
---@game GetZones
local function getPos(pPedCoords)
    for _, v in pairs(pospechet) do
        if GetDistanceBetweenCoords(pPedCoords, v.pos) < 60 then
            return true
        end
    end
end

---@game Init Blips
---@game Init Blips
for _, v in pairs(pospechet) do
    createBlip(v.pos,68,15,"Zone de pêche",false,0.9)
end

---@game CreateFishing
---@game CreateFishing
local function createIntroFish(bool)
    if not bool and HavePechet and DoesEntityExist(HavePechet) then
        SetEntityAsMissionEntity(HavePechet, 1, 1)
        DeleteObject(HavePechet)
        HavePechet = nil
    end
    if not bool and objectprop and DoesEntityExist(objectprop) then
        SetEntityAsMissionEntity(objectprop, 1, 1)
        DeleteObject(objectprop)
        hookfishingRodEntity = nil
    end
    if notifPecheId then
        RemoveNotification(notifPecheId)
        notifPecheId = nil
    end
    if not bool then
        inFishing = false;
        ClearPedTasks(GetPlayerPed(-1))
        if HasScaleformMovieLoaded(ScalFish) then
            SetScaleformMovieAsNoLongerNeeded(ScalFish)
            ScalFish = nil
        end ;
        ESX.RemoveTimerBar()
        RemoveAnimDict(dictOne)
        RemoveAnimDict(distFish)
        SetStreamedTextureDictAsNoLongerNeeded("Hunting")
    else
        TaskPlayAnim(GetPlayerPed(-1), dictOne, "base", 8.0, -8.0, -1, 1, .0, false, false, false)
    end ;
    inRecup = false;
    Pourcent = .0;
    timepeche = 0;
    canStart = bool;
    StopAllScreenEffects()
end

---@game Request Wait
---@game Request Wait
local function requestAnims()
    RequestAndWaitDict(dictOne)
    RequestAndWaitDict(distFish)
    RequestAndWaitModel(prop_namepech)
    RequestAndWaitModel(fProps)
    RequestStreamedTextureDict("Hunting", 0)
end

---@game Set Scalform
---@game Set Scalform
function SetScaleformParams(scaleform, data)
    data = data or {}
    for k, v in pairs(data) do
        PushScaleformMovieFunction(scaleform, v.name)
        if v.param then
            for _, par in pairs(v.param) do
                if math.type(par) == "integer" then
                    PushScaleformMovieFunctionParameterInt(par)
                elseif type(par) == "boolean" then
                    PushScaleformMovieFunctionParameterBool(par)
                elseif math.type(par) == "float" then
                    PushScaleformMovieFunctionParameterFloat(par)
                elseif type(par) == "string" then
                    PushScaleformMovieFunctionParameterString(par)
                end
            end
        end
        if v.func then
            v.func()
        end
        PopScaleformMovieFunctionVoid()
    end
end

---@game Create Scalform
---@game Create Scalform
function createScaleform(name, data)
    if not name or string.len(name) <= 0 then
        return
    end
    local scaleform = RequestScaleformMovie(name)

    while not HasScaleformMovieLoaded(scaleform) do
        Citizen.Wait(0)
    end

    SetScaleformParams(scaleform, data)
    return scaleform
end

---@game params Scalform
---@game params Scalform
local function scalFishS()
    ScalFish = createScaleform(
            "INSTRUCTIONAL_BUTTONS",
            {
                { name = "CLEAR_ALL", param = {} },
                { name = "TOGGLE_MOUSE_BUTTONS", param = { 0 } },
                { name = "CREATE_CONTAINER", param = {} },
                { name = "SET_DATA_SLOT", param = { 0, GetControlInstructionalButton(2, 24, 0), "Ferrer" } },
                { name = "SET_DATA_SLOT", param = { 1, GetControlInstructionalButton(2, 172, 0), "Déplacer le bouchon" } },
                { name = "SET_DATA_SLOT", param = { 2, GetControlInstructionalButton(2, 73, 0), "Annuler" } },
                { name = "DRAW_INSTRUCTIONAL_BUTTONS", param = { -1 } }
            }
    )
    return ScalFish
end

---@game Fishing starting
---@game Fishing starting
function PecheStarting()
    local coord = GetEntityCoords(PlayerPedId())
    local ped = PlayerPedId()
    local pPed, pCoords = ped, coord

    ---@game Verif not action
    ---@game Verif not action
    if inFishing then
        if notifPecheId1 then
            RemoveNotification(notifPecheId1)
        end
        notifPecheId1 = ShowAboveRadarMessage("~r~Vous êtes déjà entrain de pêcher.")
        return
    end

    ---@game Verif zone
    ---@game Verif zone
    if not getPos(pCoords) then
        if notifPecheId1 then
            RemoveNotification(notifPecheId1)
        end
        notifPecheId1 = ShowAboveRadarMessage("~r~Vous n'êtes pas dans la zone de pêche.")
        return
    end

    ---@game Start
    ---@game Start
    createIntroFish()
    inFishing = true
    requestAnims()
    canStart = true
    TaskPlayAnim(pPed, dictOne, "base", 8.0, -8.0, -1, 1, .0, false, false, false)
    local verif, GTimers = false, GetGameTimer()
    while not verif and GTimers + 3000 > GetGameTimer() do
        Wait(1000)
    end

    ---@game Create Object Fishing
    ---@game Create Object Fishing
    objectprop = CreateObject(prop_namepech, GetEntityCoords(pPed), true, false, true)
    SetNetworkIdCanMigrate(ObjToNet(objectprop), false)
    SetModelAsNoLongerNeeded(prop_namepech)
    AttachEntityToEntity(objectprop, pPed, GetPedBoneIndex(pPed, 60309), .0, .0, .0, .0, .0, .0, false, false, false, false, false, true)
    SetPedKeepTask(pPed, true)
    SetBlockingOfNonTemporaryEvents(pPed, true)

    ---@game Create Object Apa
    ---@game Create Object Apa
    HavePechet = CreateObject(fProps, pCoords.x, pCoords.y, pCoords.z, false, false, true)
    SetModelAsNoLongerNeeded(fProps)
    SetEntityVisible(HavePechet, false, false)
    PlaceObjectOnGroundProperly(HavePechet)
    Citizen.Wait(1000)
    SetEntityAsMissionEntity(HavePechet, 1, 1)
    SetEntityCoordsNoOffset(HavePechet, GetEntityCoords(HavePechet) + GetEntityForwardVector(pPed) * 8, false, false, false)
    SetEntityVisible(HavePechet, true, true)

    ---@game Thread
    ---@game Thread
    ScalFish = scalFishS()
    TimerBar = ESX.AddTimerBar("Distance:", { percentage = 0.0, bg = { 0, 60, 100, 255 }, fg = { 0, 120, 200, 255 } })
    local ChanceDropFish = ChanceFish()
    Citizen.CreateThread(function()
        while inFishing do
            Citizen.Wait(0)
            if HavePechet and DoesEntityExist(HavePechet) then
                DrawMarker(0, GetEntityCoords(HavePechet) + vector3(.0, .0, 1.0), 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.4, 0.4, 0.25, 0, 110, 180, 225, 0, 0, 2, 0, 0, 0, 0)
            else
                createIntroFish()
                ChanceDropFish = ChanceFish()
            end

            ---@game Pressed Control
            ---@game Pressed Control
            local press172, press187, press175, press174 = IsControlPressed(1, 172), IsControlPressed(1, 173), IsControlPressed(1, 175), IsControlPressed(1, 174)
            if (press172 or press187 or press175 or press174) and canStart then
                local pPedCoords = GetEntityCoords(HavePechet)
                local pPedWat, pPedWat1 = GetWaterHeightNoWaves(pPedCoords.x, pPedCoords.y, pPedCoords.z)
                if pPedWat then
                    SetEntityHeading(HavePechet, GetEntityHeading(pPed))
                    local pPedMa1, pPedMatrix = GetEntityMatrix(pPed)
                    local Presses = press172 and pPedMa1 or press187 and -pPedMa1 or press174 and -pPedMatrix or press175 and pPedMatrix;
                    Presses = Presses * .025;
                    local getPedCords = pPedCoords + Presses
                    SetEntityCoordsNoOffset(HavePechet, getPedCords.x, getPedCords.y, pPedWat1, false, false, false)
                    TaskLookAtEntity(pPed, HavePechet, -1, 2048, 3)
                end
            end

            ---@game Spam Give
            ---@game Spam Give
            if inRecup and ScalFish and HasScaleformMovieLoaded(ScalFish) and TimerBar then
                ESX.UpdateTimerBar(TimerBar, { percentage = Pourcent })
                if IsControlJustPressed(1, 24) then
                    Pourcent = math.max(0, math.min(1.0, Pourcent + .02))
                    local s = GetDistanceBetweenCoords(GetEntityCoords(pPed), GetEntityCoords(HavePechet), true)
                    if s > 6 then
                        local YAtG_LV3 = GetEntityCoords(HavePechet)
                        SetEntityCoordsNoOffset(HavePechet, YAtG_LV3 - GetEntityForwardVector(pPed) * 0.075, false, false, false)
                    end
                end
            end ;

            ---@game ScalDeform
            ---@game ScalDeform
            if HasScaleformMovieLoaded(ScalFish) then
                DrawScaleformMovieFullscreen(ScalFish, 255, 255, 255, 255, 0)
            end ;

            ---@game Stop Fishing
            ---@game Stop Fishing
            if IsControlJustPressed(1, 73) then
                if notifPecheId1 then
                    RemoveNotification(notifPecheId1)
                end
                ESX.UpdateTimerBar(TimerBar, { percentage = 0 })
                notifPecheId1 = ShowAboveRadarMessage("~r~Vous avez abandonné.")
                createIntroFish()
                ChanceDropFish = ChanceFish()
            end
        end
    end)

    local GetTimerThread;
    local bJfct

    ---@game CreateThread
    ---@game CreateThread
    Citizen.CreateThread(function()
        local ChanceGood = 200
        while inFishing do
            Citizen.Wait(ChanceDropFish)
            if not inFishing then
                break
            end
            if not inRecup then
                if ChanceDropFish == ChanceGood then
                    ChanceDropFish = ChanceFish()
                elseif ChanceDropFish ~= ChanceGood then
                    canStart = false;
                    inRecup = true;
                    GetTimerThread = nil
                    StartScreenEffect()
                    ChanceDropFish = ChanceGood;
                    Pourcent = .2;
                    timepeche = GetGameTimer()
                    TaskPlayAnim(GetPlayerPed(-1), distFish, "idle_c", 8.0, -8.0, -1, 1, .0, false, false, false)
                    StartScreenEffect("MP_Celeb_Preload_Fade", 1500)
                end
            else

                if Pourcent <= 0 or (Pourcent < 1 and timepeche + 30000 < GetGameTimer()) then

                    ---@game Fish dead
                    ---@game Fish dead
                    createIntroFish(true)
                    PlaySoundFrontend(-1, "LOSER", "HUD_AWARDS", 1)
                    ESX.UpdateTimerBar(TimerBar, { percentage = 0 })
                    ShowAboveRadarMessage("~r~Le poisson s'est échappé.")
                    ChanceDropFish = ChanceFish()

                elseif Pourcent >= 1 then

                    ---@game Fish good
                    ---@game Fish good
                    if not GetTimerThread then
                        bJfct = ScalDeform[math.random(1, #ScalDeform)]
                        if notifPecheId then
                            RemoveNotification(notifPecheId)
                            notifPecheId = nil
                        end
                        notifPecheId = ShowNotificationWithButton("~" .. bJfct[1] .. "~", "Appuyez sur la touche.")
                        ChanceDropFish = 10;
                        GetTimerThread = nil;
                        bJfct = nil
                        PlaySoundFrontend(-1, "UNDER_THE_BRIDGE", "HUD_AWARDS", 1)
                        ESX.UpdateTimerBar(TimerBar, { percentage = 0 })
                        createIntroFish(true)
                        ChanceDropFish = ChanceFish()
                        TriggerServerEvent("clippy:pechepoisson") -- Give l'item
                        GetTimerThread = GetGameTimer()
                    else
                        if GetTimerThread ~= nil and GetTimerThread + 2500 < GetGameTimer() then

                            ---@game Fish exit
                            ---@game Fish exit
                            ShowAboveRadarMessage("~r~Le poisson s'est échappé.")
                            ESX.UpdateTimerBar(TimerBar, { percentage = 0 })
                            GetTimerThread = nil;
                            bJfct = nil
                            PlaySoundFrontend(-1, "LOSER", "HUD_AWARDS", 1)
                            ChanceDropFish = ChanceGood;
                            createIntroFish(true)
                        end
                    end
                else
                    Pourcent = Pourcent - .01
                end
            end
        end
    end)
end

RegisterNetEvent('clp:usecanne')
AddEventHandler('clp:usecanne', function()
    PecheStarting()
end)