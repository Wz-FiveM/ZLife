local Kw = {}

---@class Actor
---@field public id number
---@field public name string

local nvaIsNv7 = {
    {
        name = "UUID",
        var = "id"
    }, {
        name = "Server Id",
        var = "source"
    }, {
        name = "ID personnage",
        var = "charID"
    }, {
        name = "Argent",
        var = "money"
    }, {
        name = "Argent sale",
        var = "salemoney"
    }, {
        name = "Argent en banque",
        var = "bankmoney"
    }, {
        name = "ID Organisation",
        var = "orgID"
    }, {
        name = "ID Crew",
        var = "crewID"
    }, {
        name = "Rôle",
        var = "group"
    }
}
local vDnoL55;
local xlAK = false;
local players = {}
local playersM = {}
local jk = 0.1;
local qzSFyIO;
local Z65 = 0;
local umyCNfj = {}
local FT = 0;
local YVLXYq = {}
local bJfct = {}
local OhuFpq_N
local _4O = {}
local C;
local fLI2zRe = IsControlPressed;
local _Fr2YU = IsControlJustPressed
local Xfn = GetDisabledControlNormal
local U = {
    ["mult_edit"] = {
        control = 178,
        label = "Vitesse"
    },
    ["spec_select"] = {
        control = 24,
        label = "Spectate le joueur"
    },
    ["back_pos"] = {
        control = 51,
        label = "Venir ici"
    },
    ["sprint"] = {
        control = 21,
        label = "Rapide"
    },
    ["walk"] = {
        control = 36,
        label = "Lent"
    }
}
local Ebsw = {
    ["exit_spec"] = {
        control = 45,
        label = "Quitter"
    },
    ["menu_spec"] = {
        control = 51,
        label = "Ouvrir le menu"
    }
}
local function JtAjijkG(nvCiFt7r)
    local xSebv5Jc = GetFirstBlipInfoId(8)
    if not xSebv5Jc or xSebv5Jc == 0 then
        return
    end
    local mMp = nvCiFt7r:GetVehicle() or nvCiFt7r.Ped
    local rDtVf = GetBlipInfoIdCoord(xSebv5Jc)
    setEntCoords(rDtVf, mMp)
end

local function s(y36Aetn)
    local iPL3B4cr = { {
                           name = "CLEAR_ALL",
                           param = {}
                       }, {
                           name = "TOGGLE_MOUSE_BUTTONS",
                           param = { 0 }
                       }, {
                           name = "CREATE_CONTAINER",
                           param = {}
                       } }
    local GI2hz6SK = 0
    for Oh, PG in pairs(y36Aetn and Ebsw or U) do
        iPL3B4cr[#iPL3B4cr + 1] = {
            name = "SET_DATA_SLOT",
            param = { GI2hz6SK, GetControlInstructionalButton(2, PG.control, 0), PG.label }
        }
        GI2hz6SK = GI2hz6SK + 1
    end
    iPL3B4cr[#iPL3B4cr + 1] = {
        name = "DRAW_INSTRUCTIONAL_BUTTONS",
        param = { -1 }
    }
    return iPL3B4cr
end
local function YAtG_LV3(n)
    local O, N5UjTN = fLI2zRe(1, 10), fLI2zRe(1, 11)
    local qLH5, tE = fLI2zRe(1, U["sprint"].control), fLI2zRe(1, U["walk"].control)
    if O or N5UjTN then
        jk = math.max(0, math.min(100, round(jk + (O and 0.01 or -0.01), 2)))
    end
    if qzSFyIO == nil then
        if qLH5 then
            qzSFyIO = jk * 2.0
        elseif tE then
            qzSFyIO = jk * 0.1
        end
    elseif not qLH5 and not tE then
        if qzSFyIO ~= nil then
            qzSFyIO = nil
        end
    end
    if _Fr2YU(0, U["mult_edit"].control) then
        DisplayOnscreenKeyboard(false, "FMMC_KEY_TIP8", "", jk, "", "", "", 5)
        while UpdateOnscreenKeyboard() == 0 do
            Citizen.Wait(10)
            if UpdateOnscreenKeyboard() == 1 and GetOnscreenKeyboardResult() and string.len(GetOnscreenKeyboardResult()) >=
                    1 then
                jk = tonumber(GetOnscreenKeyboardResult()) or 1.0;
                break
            end
        end
    end
end
local function LfEJbh_(VcV0EuD)
    local pX4gCR, gad4ZcL, dk, E = fLI2zRe(1, 32), fLI2zRe(1, 33), fLI2zRe(1, 35), fLI2zRe(1, 34)
    local OO, y = Xfn(0, 220), Xfn(0, 221)
    if OO ~= 0.0 or y ~= 0.0 then
        local cR6rJlAl = GetCamRot(vDnoL55, 2)
        new_z = cR6rJlAl.z + OO * -1.0 * 10.0;
        new_x = cR6rJlAl.x + y * -1.0 * 10.0
        SetCamRot(vDnoL55, new_x, 0.0, new_z, 2)
        SetEntityHeading(VcV0EuD.Ped, new_z)
    end
    if pX4gCR or gad4ZcL or dk or E then
        local M6ilzGJ, iW6CD, wZdg = GetCamMatrix(vDnoL55)
        if lockEntity then
            M6ilzGJ, iW6CD, wZdg = GetEntityMatrix(vDnoL55)
        end
        local BaX = (lockEntity and GetEntityCoords(lockEntity) or GetCamCoord(vDnoL55)) +

                ((pX4gCR and iW6CD or gad4ZcL and -iW6CD or vector3(.0, .0, .0)) +
                        (dk and M6ilzGJ or E and -M6ilzGJ or vector3(.0, .0, .0))) *
                        (qzSFyIO ~= nil and qzSFyIO or jk)
        if lockEntity then
            SetEntityCoords(lockEntity, BaX.x, BaX.y, BaX.z)
        else
            SetCamCoord(vDnoL55, BaX)
            SetFocusPosAndVel(BaX)
        end
    end
end
local function JD(SJsW11k)
    umyCNfj = SJsW11k;
    umyCNfj.pedHandle = GetPlayerPed(SJsW11k.id)
    if not DoesEntityExist(umyCNfj.pedHandle) then
        ShowAboveRadarMessage("Vous êtes trop loin de la cible.")
        return
    end
    NetworkSetInSpectatorMode(1, umyCNfj.pedHandle)
    SetCamActive(vDnoL55, false)
    RenderScriptCams(false, false, 0, false, false)
    SetScaleformParams(OhuFpq_N, s(true))
    ClearFocus()
end
local function u()
    if DoesEntityExist(umyCNfj.pedHandle) then
        SetCamCoord(vDnoL55, GetEntityCoords(umyCNfj.pedHandle))
    else
        SetCamCoord(freecam, PLAYER.Pos)
    end
    NetworkSetInSpectatorMode(0, PlayerPedId())
    SetCamActive(vDnoL55, true)
    RenderScriptCams(true, false, 0, true, true)
    umyCNfj = {}
    SetScaleformParams(OhuFpq_N, s(false))
end
local function pzDMZwG(Ki1HJT)
    if _Fr2YU(0, Ebsw["exit_spec"].control) then
        u()
    end
    if _Fr2YU(0, Ebsw["menu_spec"].control) then
        local wjim8xCV = GetPlayerServerId(umyCNfj.id)
        if wjim8xCV and wjim8xCV > 0 then
            CreateMenu(bJfct)
            Wait(0)
            OpenMenu("joueur")
        end
    end
    if GetGameTimer() > Z65 then
        Z65 = GetGameTimer() + 1000
        SetFocusPosAndVel(GetEntityCoords(GetPlayerPed(umyCNfj.id)))
    end
end
local function XPoQB(QLam)
    if not umyCNfj.id and _Fr2YU(0, U["spec_select"].control) then
        local qTDt = {}
        local v = GetCamCoord(vDnoL55)
        local Ta = PlayerId()
        for unArcvQl, h6Ub7U in pairs(GetActivePlayers()) do
            local Gm = GetPlayerPed(h6Ub7U)
            local YKA7cU = GetEntityCoords(Gm)
            local mCsewfX = GetDistanceBetweenCoords(YKA7cU, v)
            if h6Ub7U ~= Ta and Gm and mCsewfX <= 20 and
                    (not qTDt.pos or GetDistanceBetweenCoords(qTDt.pos, v) > mCsewfX) then
                qTDt = {
                    id = h6Ub7U,
                    pos = YKA7cU
                }
            end
        end
        if qTDt and qTDt.id then
            JD(qTDt)
        end
    end
    if _Fr2YU(1, U["back_pos"].control) then
        Hss = GetCamCoord(vDnoL55)
        el(Hss)
    end
end

local Kw = {}
local zr1y = false;
local Hs;
local YVLXYq = {}
local Dzg = { GAMER_NAME = 0, CREW_TAG = 1, healthArmour = 2, BIG_TEXT = 3, AUDIO_ICON = 4, MP_USING_MENU = 5, MP_PASSIVE_MODE = 6, WANTED_STARS = 7, MP_DRIVER = 8, MP_CO_DRIVER = 9, MP_TAGGED = 10, GAMER_NAME_NEARBY = 11, ARROW = 12, MP_PACKAGES = 13, INV_IF_PED_FOLLOWING = 14, RANK_TEXT = 15, MP_TYPING = 16 }
local C;
local Xfn = GetDisabledControlNormal
local o5sms = GetActivePlayers;
local JQi1jg = GetPlayerServerId;
local wVzn = GetPlayerPed
local pE = IsMpGamerTagActive;
local RSjapQ = SetMpGamerTagVisibility;
local QJf = DecorGetBool;
local zC = SetMpGamerTagAlpha
local pfZ3SPy_ = SetMpGamerTagName
local function UlikV(Qlmlet)
    if not Kw or not Kw.players then
        return
    end
    for _RkGFh6, hw18 in pairs(Kw.players) do
        if hw18.source == Qlmlet then
            return hw18
        end
    end
end
local function pDNa2ox6(UwFeA)
    local JQgI = GetEntityCoords(UwFeA)
    for N, fs52REi in pairs(o5sms()) do
        if fs52REi ~= GetPlayerServerId(UwFeA) or IS_DEV then
            local PUNkgaiM = JQi1jg(fs52REi)
            local s6FbB = UlikV(PUNkgaiM)
            local X = YVLXYq[PUNkgaiM]
            if not X or (X.tag and not pE(X.tag)) then
                local dc61 = wVzn(fs52REi)
                local aguhyl = CreateMpGamerTag(dc61, s6FbB and s6FbB.name or GetPlayerName(fs52REi), false, false, "", 0)
                RSjapQ(aguhyl, Dzg.GAMER_NAME, true)
                RSjapQ(aguhyl, Dzg.healthArmour, true)
                zC(aguhyl, Dzg.healthArmour, 255)
                YVLXYq[PUNkgaiM] = { tag = aguhyl, ped = dc61 }
            else
                local p = X.tag
                RSjapQ(p, Dzg.AUDIO_ICON, NetworkIsPlayerTalking(PlayerId()))
                zC(p, Dzg.AUDIO_ICON, 255)
                pfZ3SPy_(p, "[" .. GetPlayerServerId(fs52REi) .. "] - " .. GetPlayerName(fs52REi))
            end
        end
    end
end
local function Do6yo7nm()
    zr1y = not zr1y
    if zr1y then
        local gOPDv = GetPlayerPed(-1)
        CreateThread(function()
            while zr1y do
                pDNa2ox6(gOPDv)
                Wait(1000)
            end
        end)
    else
        for aSdZU3, YKDL in pairs(YVLXYq) do
            RemoveMpGamerTag(YKDL.tag)
        end ;
        YVLXYq = {}
    end
end
local function y06X3k(oFyb6OLp)
    if not NetworkIsInSpectatorMode() then
        YAtG_LV3(oFyb6OLp)
        LfEJbh_(oFyb6OLp)
        XPoQB(oFyb6OLp)
    else
        pzDMZwG(oFyb6OLp)
    end
    if OhuFpq_N then
        DrawScaleformMovieFullscreen(OhuFpq_N, 255, 255, 255, 255, 0)
    end
    if GetGameTimer() > FT then
        FT = GetGameTimer() + 15000
    end
end
local function ivnJjrA()
    vDnoL55 = CreateCam("DEFAULT_SCRIPTED_CAMERA", true)
    SetCamActive(vDnoL55, true)
    RenderScriptCams(true, false, 0, true, true)
    OhuFpq_N = createScaleform("INSTRUCTIONAL_BUTTONS", s())
end
function d3fMjkg()
    DestroyCam(vDnoL55)
    RenderScriptCams(false, false, 0, false, false)
    ClearFocus()
    SetScaleformMovieAsNoLongerNeeded(OhuFpq_N)
    if NetworkIsInSpectatorMode() then
        NetworkSetInSpectatorMode(false, umyCNfj.id and wVzn(umyCNfj.id) or 0)
    end
    OhuFpq_N = nil;
    vDnoL55 = nil;
    lockEntity = nil;
    umyCNfj = {}
end
function el(posA)
    local oGdh_mv = LocalPlayer()
    local WjvvK = oGdh_mv.Ped;
    xlAK = not xlAK
    --updateVar("SpectateMode", xlAK)
    Wait(0)
    if not xlAK then
        d3fMjkg()
        if _4O.wasVisible then
            oGdh_mv:Set("Visible", true)
        end
        SetEntityCollision(WjvvK, true, true)
        SetEntityHasGravity(WjvvK, true)

        if not _4O.wasInvincible then
            oGdh_mv:Set("Invincible", false)
        end
        oGdh_mv:Freeze(false)
        CloseMenu()
        if posA then
            SetEntityCoords(WjvvK, posA)
        end
        _4O = {}
    else
        ivnJjrA()
        _4O = {
            wasVisible = oGdh_mv.Visible,
            wasInvincible = oGdh_mv.Invincible
        }
        oGdh_mv:Set("Visible", false)
        SetEntityHasGravity(WjvvK, false)
        SetEntityCollision(WjvvK, false, false)
        oGdh_mv:Set("Invincible", true)
        oGdh_mv:Freeze(true)
        Hs = oGdh_mv.Pos
        SetCamCoord(vDnoL55, oGdh_mv.Pos)
        CreateThread(function()
            while xlAK do
                Wait(0)
                y06X3k(oGdh_mv)
            end
        end)
    end
end

RegisterNetEvent("cl_adm:spectate")
AddEventHandler("cl_adm:spectate", function()
    el()
end)

RegisterNetEvent('cl_adm:openad')
AddEventHandler('cl_adm:openad', function()
    CreateMenu(bJfct)
end)

RegisterNetEvent("onPlayerDropped")
AddEventHandler("onPlayerDropped", function(...)
    onPlayerDropped(...)
end)
function onPlayerDropped(KjUncMB)
    local XkT = YVLXYq[KjUncMB]
    if XkT then
        local c3dr = XkT.tag
        RemoveMpGamerTag(c3dr)
        YVLXYq[KjUncMB] = nil
    end
    if umyCNfj and umyCNfj.id == KjUncMB then
        u()
    end
end
local Wu_uIt = {
    ["joueur"] = function(MD2O, HQ, cng, lE, nI2F0id)
        local N4aMD_P = HQ.temp
        if cng == "envoyer un message privé" then
            AskEntry(function(NzeoQJ)
                if not NzeoQJ or string.len(NzeoQJ) == 0 then
                    return
                end
                TriggerServerEvent('kxzeriia:msgprive', NzeoQJ, N4aMD_P)
            end, "Message à envoyer", 255)
        elseif cng == "se téléporter sur le joueur" then
            ExecuteCommand("goto " .. N4aMD_P)
        elseif cng == "téléporter le joueur sur vous" then
            ExecuteCommand("bring " .. N4aMD_P)
        elseif cng == "réanimer" then
            ExecuteCommand("revive " .. N4aMD_P)
        elseif cng == "spectate le joueur" then
            if not xlAK then
                ShowAboveRadarMessage("~r~Vous devez être en mode spec pour faire ça.")
                return
            end
            if not DoesEntityExist(wVzn(GetPlayerFromServerId(N4aMD_P))) then
                ShowAboveRadarMessage("~r~Le joueur est trop loin.")
                return
            end
            local wCRY = {
                id = GetPlayerFromServerId(N4aMD_P)
            }
            if umyCNfj and umyCNfj.id then
                u()
            end
            JD(wCRY)
        elseif cng == "voir l'inventaire" then
            TriggerEvent("c_inventaire:openPlayerInventory", N4aMD_P)
            MD2O:CloseMenu()
        elseif cng == "kick" then
            AskEntry(function(d0uKSVw1)
                if not d0uKSVw1 or string.len(d0uKSVw1) == 0 then
                    return
                end
                ExecuteCommand("kick " .. N4aMD_P .. " " .. d0uKSVw1)
            end, "Rasion du kick", 255)
        elseif cng == "freeze" then
            ExecuteCommand("freeze " .. N4aMD_P)
        end
    end,
    ["mon joueur"] = function(lNOqUk8, YAnZNei, h8YWR44E, VF, fTrMe)
        local ypDndT8 = LocalPlayer()
        if h8YWR44E == "invincibilité" then
            ypDndT8:Set("Invincible", not ypDndT8.Invincible)
        elseif h8YWR44E == "visible" then
            ypDndT8:Set("Visible", not ypDndT8.Visible)
        elseif h8YWR44E == "réanimer" then
            ExecuteCommand("revive " .. JQi1jg(PlayerId()))
        elseif h8YWR44E == "s'octroyer du cash" then
            local amount = KeyboardInput1("Nom", "", "", 8)
            if amount ~= nil then
                amount = tonumber(amount)
                if type(amount) == 'number' then
                    TriggerServerEvent('c_admin:givecash', amount)
                end
            end
        elseif h8YWR44E == "s'octroyer de l'argent (banque)" then
            local amount = KeyboardInput1("Nom", "", "", 8)
            if amount ~= nil then
                amount = tonumber(amount)
                if type(amount) == 'number' then
                    TriggerServerEvent('c_admin:givecashbank', amount)
                end
            end
        elseif h8YWR44E == "s'octroyer de l'argent (sale)" then
            local amount = KeyboardInput1("Nom", "", "", 8)
            if amount ~= nil then
                amount = tonumber(amount)
                if type(amount) == 'number' then
                    TriggerServerEvent('c_admin:givecashsale', amount)
                end
            end
        elseif h8YWR44E == "changer d'apparence" then
            CloseMenu(true)
            TriggerEvent('esx_skin:openSaveableMenu')
        end
    end,
    ["monde"] = function(MV65, Y3D66Ym9, q, PhJ, h)
        local j2K = LocalPlayer()
        if q == "téléporter sur un point" then
            JtAjijkG(j2K)
        elseif q == "téléporter sur des coordonnées" then
            AskEntry(function(r8hgwQ)
                if r8hgwQ then
                    local _6U = stringsplit(r8hgwQ, ",")
                    if _6U and #_6U >= 2 then
                        for GLSzBQs, c in pairs(_6U) do
                            local xg, Id2KoP_G = c:gsub(" ", "")
                            _6U[GLSzBQs] = tonumber(xg)
                        end
                        setEntCoords(vec3(_6U[1] or 0.0, _6U[2] or 0.0, _6U[3] or 0.0), j2K:GetVehicle() or j2K.Ped)
                    end
                end
            end, "Entrez les coordonnées: (1402.0, 1463.0)")
        elseif q == "supprimer un véhicule" or q == "supprimer un objet" or q == "supprimer un ped" then
            local Y2or = q == "supprimer un véhicule" and (j2K:GetVehicle() or GetClosestVehicle2(j2K.Pos, 6.0)) or q == "supprimer un objet" and GetClosestObject(j2K.Pos, 6.0) or q == "supprimer un ped" and GetClosestPed2(j2K.Pos, 6.0)
            if Y2or then

                SetEntityAsMissionEntity(Y2or)
                TriggerEvent('persistent-vehicles/forget-vehicle', Y2or)
                Wait(50)
                DeleteObject(Y2or)
                DeleteEntity(Y2or)
                if notifdel then
                    RemoveNotification(notifdel)
                end
                notifdel = ShowAboveRadarMessage("Entitée : (~b~" .. Y2or .. "~s~)")

            end
        elseif q == "clear la zone" then
            local x, y, z = table.unpack(GetOffsetFromEntityInWorldCoords(PlayerPedId(), 0.0, 0.0, 0.0))
            ClearAreaOfPeds(x, y, z, 100.0, 1)
            ClearAreaOfEverything(x, y, z, 100.0, false, false, false, false)
            ClearAreaOfVehicles(x, y, z, 100.0, false, false, false, false, false)
            ClearAreaOfObjects(x, y, z, 100.0, true)
            ClearAreaOfProjectiles(x, y, z, 100.0, 0)
            ClearAreaOfCops(x, y, z, 100., 0)
        end
    end,
    ["véhicules"] = function(zN8ASHV5, iju, XsWgh, l4Hdz, NSXCgSH)
        local Wq = LocalPlayer()
        if XsWgh == "créer un véhicule" then
            AskEntry(function(IiuHGo)
                if not IsModelInCdimage(IiuHGo) then
                    ShowAboveRadarMessage("~r~Ce modèle de véhicule n'existe pas.")
                    return
                end
                local cGqxtYr = createPersoVeh(IiuHGo, {}, "H1Z1PUBG", 1)
                if cGqxtYr then
                    TaskWarpPedIntoVehicle(Wq.Ped, cGqxtYr, -1)
                end
            end, "Modèle du véhicule")
        elseif XsWgh == "réparer le moteur" then
            local bgJFKeeZ = getVehInSight()
            if IsPedInAnyVehicle(PlayerPedId(), true) then
                bgJFKeeZ = Wq:GetVehicle()
            end
            if bgJFKeeZ then
                SetVehicleEngineHealth(bgJFKeeZ, 1000.0)
            end
        elseif XsWgh == "corriger les déformations" then
            local yu9fg0nN = getVehInSight()
            if IsPedInAnyVehicle(PlayerPedId(), true) then
                yu9fg0nN = Wq:GetVehicle()
            end
            if yu9fg0nN then
                SetVehicleDeformationFixed(yu9fg0nN)
            end
        elseif XsWgh == "nettoyer le véhicule" then
            local wgx = getVehInSight()
            if IsPedInAnyVehicle(PlayerPedId(), true) then
                wgx = Wq:GetVehicle()
            end
            if wgx then
                WashDecalsFromVehicle(wgx, 1.0)
                SetVehicleDirtLevel(wgx, 0.0)
            end
        elseif XsWgh == "réparer entièrement le véhicule" then
            local zlU7X = getVehInSight()
            if IsPedInAnyVehicle(PlayerPedId(), true) then
                zlU7X = Wq:GetVehicle()
            end
            if zlU7X then
                SetVehicleFixed(zlU7X)
            end
        elseif XsWgh == "crocheter" then
            local t = getVehInSight()
            if t and DoesEntityExist(t) then
                NetworkRequestControlOfEntity(t)
                local f6qbO = GetGameTimer()
                while not NetworkHasControlOfEntity(t) and f6qbO + 2000 > GetGameTimer() do
                    Citizen.Wait(0)
                end
                ShowAboveRadarMessage("Vous avez ~g~crocheté~w~ le véhicule.")
                SetVehicleDoorsLockedForAllPlayers(t, false)
                SetEntityAsMissionEntity(t, true, true)
                SetVehicleHasBeenOwnedByPlayer(t, true)
            end
        end
    end,
    ["téléporter sur un point d'intérêt"] = function(kk, QrubIAv, bLHDW, YjFd7b, jZgPYb)
        if YjFd7b.pos then
            local zN2 = LocalPlayer()
            setEntCoords(YjFd7b.pos, zN2:GetVehicle() or zN2.Ped)
        end
    end,
    ["autres options"] = function(IN69pa5, UOWJ, WtalJw, JYrf2, KHDOUlRY)
        if WtalJw == "afficher les gamertags" then
            Do6yo7nm()
            zr1y = JYrf2.checkbox;

        end
    end,
}
local function w(kQ, EE9LAE, iVx, eg)
    local AQviNt = EE9LAE.currentMenu;
    local T6 = iVx.name:lower()
    if AQviNt == "liste des joueurs" then
        EE9LAE.temp = iVx.source;
        C = iVx.name;
        kQ:OpenMenu("joueur")
    else
        if Wu_uIt[AQviNt] then
            Wu_uIt[AQviNt](kQ, EE9LAE, T6, iVx, eg)
        end
    end
end
local function sgeP(NviN0i)
    players = {}
    for _, player in ipairs(GetActivePlayers()) do
        table.insert(playersM, player)
        table.insert(players, { name = "[" .. GetPlayerServerId(player) .. "] - " .. GetPlayerName(player), source = GetPlayerServerId(player) })
        C = GetPlayerName(player);
        temp = GetPlayerServerId(player)
    end
end
local function CM()
    if not xlAK then
        Kw = {}
    end
    C = nil
end
bJfct = {
    Base = {
        Title = "Administration",
        HeaderColor = { 120, 120, 120 }
    },
    Data = {
        currentMenu = "menu principal"
    },
    Events = {
        onSelected = w,
        onOpened = function()
            setheader("Menu Administration")
            sgeP,
        end,
        onExited = CM
    },
    Menu = {
        ["menu principal"] = {
            b = { {
                      name = "Liste des joueurs"
                  }, {
                      name = "Mon joueur"
                  }, {
                      name = "Véhicules"
                  }, {
                      name = "Monde"
                  }, {
                      name = "Autres options"
                  } }
        },
        ["liste des joueurs"] = {
            useFilter = true,
            b = function()
                return players
            end
        },
        ["joueur"] = {
            b = function()
                return {
                    {
                        name = "~r~" .. C
                    }, {
                        name = "Envoyer un message privé"
                    }, {
                        name = "Se téléporter sur le joueur"
                    }, {
                        name = "Téléporter le joueur sur vous"
                    }, {
                        name = "Réanimer"
                    }, {
                        name = "Spectate le joueur"
                    }, {
                        name = "Kick"
                    }, {
                        name = "Freeze"
                    }, {
                        name = "Voir l'inventaire"
                    }
                }
            end
        },
        ["mon joueur"] = {
            b = {
                {
                    name = "Invincibilité",
                    checkbox = LocalPlayer().Invincible
                }, {
                    name = "Visible",
                    checkbox = LocalPlayer().Visible
                }, {
                    name = "Réanimer"
                }, {
                    name = "S'octroyer du cash"
                }, {
                    name = "S'octroyer de l'argent (banque)"
                }, {
                    name = "S'octroyer de l'argent (sale)"
                }, {
                    name = "Changer d'apparence"
                }
            }
        },

        ["véhicules"] = {
            b = { {
                      name = "Créer un véhicule"
                  }, {
                      name = "Réparer le moteur"
                  }, {
                      name = "Corriger les déformations"
                  }, {
                      name = "Nettoyer le véhicule"
                  }, {
                      name = "Réparer entièrement le véhicule"
                  }, {
                      name = "Crocheter"
                  } }
        },

        ["monde"] = {
            b = {
                {
                    name = "Téléporter sur un point"
                }, {
                    name = "Téléporter sur des coordonnées"
                }, {
                    name = "Téléporter sur un point d'intérêt"
                }, {
                    name = "Supprimer un véhicule"
                }, {
                    name = "Supprimer un ped"
                }, {
                    name = "Supprimer un objet"
                }, {
                    name = "Clear la zone"
                }
            }
        },

        ["téléporter sur un point d'intérêt"] = {
            b = { {
                      name = "Fourrière",
                      pos = vector3(-338.31, -138.74, 38.01)
                  }, {
                      name = "LS Custom",
                      pos = vector3(-212.13, -1324.49, 29.89)
                  }, {
                      name = "Mugshot",
                      pos = vector3(402.5164, -1002.847, -99.2587)
                  }, {
                      name = "Parking",
                      pos = vector3(405.9228, -954.1149, -99.662)
                  }, {
                      name = "Avenger",
                      pos = vector3(520.0, 4750.0, -70.0)
                  }, {
                      name = "Facility",
                      pos = vector3(345.0041, 4842.001, -59.9997)
                  }, {
                      name = "Server",
                      pos = vector3(2168.0, 2920.0, -84.0)
                  }, {
                      name = "Submarine",
                      pos = vector3(514.33, 4886.18, -62.59)
                  }, {
                      name = "IAA Facility",
                      pos = vector3(2147.91, 2921.0, -61.9)
                  }, {
                      name = "Nightclub",
                      pos = vector3(-1604.664, -3012.583, -78.000)
                  }, {
                      name = "Nightclub Warehouse",
                      pos = vector3(-1505.783, -3012.587, -80.000)
                  }, {
                      name = "Terrobyte",
                      pos = vector3(-1421.015, -3012.587, -80.000)
                  }, {
                      name = "Garage tower",
                      pos = vector3(-191.0133, -579.1428, 135.0000)
                  }, {
                      name = "CEO Mod",
                      pos = vector3(-146.6166, -596.6301, 166.0000)
                  }, {
                      name = "Psychiatrist's Office",
                      pos = vector3(-1908.024, -573.4244, 19.09722)
                  }, {
                      name = "Cinéma",
                      pos = vector3(-1427.299, -245.1012, 16.8039)
                  }, {
                      name = "Omega's Garage",
                      pos = vector3(2331.344, 2574.073, 46.68137)
                  }
            }
        },
        ["autres options"] = {
            b = {
                {
                    name = "Afficher les gamertags",
                    checkbox = zr1y
                }
            }
        }
    }
}

RegisterCommand("unspectate", function()
    if xlAK and NetworkIsInSpectatorMode() then
        u()
    end
end)


