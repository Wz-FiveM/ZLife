Anticheat = Anticheat or {}
if GetCurrentResourceName() ~= "ClippyGeek" then
    return print("Don't rename ClippyGeek")
end
print("^1ClippyGeek Initialized")
local a = function()
    return Citizen.InvokeNative(0x048746E388762E11, Citizen.ReturnResultAnyway())
end;
Anticheat.ArmorPlayer = 0;
Anticheat.HealthPlayer = 0;
function CreateCam(...)
    local b = Anticheat.AntiCreateCam(...)
    Anticheat.CamerasEdit[b] = true;
    return b
end
AddEventHandler('onClientMapStart', function()
    Wait(5000)
    Anticheat.IsSpawned = true
end)
AddEventHandler('playerSpawned', function()
    Anticheat.IsSpawned = true
end)
function CreateCamera(...)
    local b = Anticheat.AntiCreateCamera(...)
    Anticheat.CamerasEdit[b] = true;
    return b
end
function DestroyCam(c, ...)
    if Anticheat.CamerasEdit[c] then
        Anticheat.CamerasEdit[c] = nil
    end
    return Anticheat.AntiDestroyCam(c, ...)
end
function DestroyAllCams()
    Anticheat.CamerasEdit = {}
    return Anticheat.AntiDestroyAllCams()
end
Anticheat.RateLimitsList = {}
function CreateRameLimit(d, e, f)
    Anticheat.RateLimitsList[d] = {
        threshold = e,
        time = f,
        data = {}
    }
end
CreateRameLimit("health", 4, 2)
CreateRameLimit("armor", 4, 2)
function RefreshRateLimit(d)
    if not Anticheat.RateLimitsList[d] then
        return
    end
    table.insert(Anticheat.RateLimitsList[d].data, GetGameTimer())
    local g = Anticheat.RateLimitsList[d].threshold + 1;
    if Anticheat.RateLimitsList[d].data[g] then
        table.remove(Anticheat.RateLimitsList[d].data, 1)
    end
end
function GetRateLimit(d)
    if not Anticheat.RateLimitsList[d] or #Anticheat.RateLimitsList[d].data < Anticheat.RateLimitsList[d].threshold then
        return false
    end
    local h = Anticheat.RateLimitsList[d].data[1]
    return h + Anticheat.RateLimitsList[d].time * 1000 >= GetGameTimer()
end
local i = SetEntityHealth;
local j = SetPedArmour;
function Anticheat:SetPedHealth(k, l, m)
    Anticheat.HealthPlayer = l;
    if not m then
        Anticheat.lastHealthData.health = GetGameTimer()
    end
    return i(k, l)
end
function Anticheat:SetEntityArmour(k, n, m)
    Anticheat.ArmorPlayer = n;
    if not m then
        Anticheat.lastHealthData.armor = GetGameTimer()
    end
    return j(k, math.floor(n))
end
function Anticheat:ReportCheat(o, p, q, r, s)
    if not o or Anticheat.ReportsDone[o] then
        return
    end
    if q then
        Anticheat.ReportsDone[o] = true
    end
    if r then
    end
    Wait(2 * 1000)
    TriggerServerEvent("Anticheat:ReportCheatServer", p, GetPlayerName(PlayerId()), s)
end
RegisterNetEvent('anticheat:reportCheat')
AddEventHandler("anticheat:reportCheat", function(t, p, q, u, s)
    Anticheat:ReportCheat(t or 99, p or "Inconnu", q or false, u or false, s or false)
end)
Citizen.CreateThread(function()
    SetMaxHealthHudDisplay(199)
    Wait(5000)
    Anticheat.IsSpawned = true;
    while true do
        Citizen.Wait(0)
        local k, v = PlayerPedId(), GetVehiclePedIsIn(PlayerPedId(), false)
        local w = GetVehiclePedIsIn(k, false)
        if Anticheat.AntiCarkill then
            for v in EnumerateVehicles() do
                local x = 1;
                if DoesEntityExist(v) and v ~= w and GetEntitySpeed(v) * 3.6 >= x and
                    not IsThisModelABoat(GetEntityModel(v)) then
                    SetEntityNoCollisionEntity(v, k, true)
                end
            end
        end
        if Anticheat.BlockWheelWeapons then
            HudWeaponWheelIgnoreSelection()
            HideHudComponentThisFrame(19)
            HideHudComponentThisFrame(20)
            DisableControlAction(0, 37, true)
            DisableControlAction(0, 12, true)
            DisableControlAction(0, 13, true)
            DisableControlAction(0, 14, true)
            DisableControlAction(0, 15, true)
            DisableControlAction(0, 16, true)
            DisableControlAction(0, 17, true)
        end
        if Anticheat.BlockTiny then
            if GetPedConfigFlag(k, 223, true) then
                Anticheat:ReportCheat(57, "Tiny", true, true, false)
            end
        end
        if Anticheat.Superjump then
            if IsControlJustPressed(1, 22) and GetPedConfigFlag(k, 60, true) and not IsPedJumping(k) then
                local y = GetEntityCoords(k).z;
                Citizen.CreateThread(function()
                    local z = y;
                    while IsPedJumping(k) or IsPedFalling(k) do
                        local A = GetEntityCoords(k).z;
                        if z > A then
                            return
                        elseif A - y > 5.0 and A - z < 20.0 then
                            Anticheat:ReportCheat(100, "Superjump (" .. y .. " / " .. A .. " / " .. z .. ")", true,
                                true, false)
                            return
                        end
                        z = A;
                        Citizen.Wait(100)
                    end
                end)
            end
        end
        if Anticheat.AntiGodmod then
            if GetPedMaxHealth(k) > 200 then
                Anticheat:ReportCheat(3, "Health higher: " .. GetEntityHealth(k), true, true, true)
                SetPedMaxHealth(k, 200, true, true)
            end
            local B = GetPlayerInvincible(k) or GetPlayerInvincible_2(k)
            if B and not IsEntityDead(k) then
                SetPlayerInvincible(k, false)
                Anticheat:ReportCheat(4, "Godmode", true, true, false)
            end
        end
        if not IsEntityDead(k) and Anticheat.IsSpawned and Anticheat.AntiHeal then
            local n, C = Anticheat.ArmorPlayer, GetPedArmour(k)
            local l, D = Anticheat.HealthPlayer, GetEntityHealth(k)
            if l > 0 and D > l then
                Anticheat:SetPedHealth(k, l)
                RefreshRateLimit("health")
                if GetRateLimit("health") then
                    Anticheat:ReportCheat(47, "Health recharge: " .. l .. " | " .. D, true, true, true)
                end
            elseif l ~= D then
                Anticheat.HealthPlayer = D
            end
            if C > 0 and C > n then
                Anticheat:SetEntityArmour(k, n, true)
                Anticheat.ArmorPlayer = n;
                RefreshRateLimit("armor")
                if GetRateLimit("armor") or C == 99 then
                    Anticheat:ReportCheat(6, "Armor recharge: " .. n .. " | " .. C, true, true, true)
                else
                    Anticheat:ReportCheat(6, "Armor recharge: " .. n .. " | " .. C, true, true, true)
                end
            elseif n ~= C then
                Anticheat.ArmorPlayer = C
            end
        end
        if Anticheat.AntiAmmoComplete then
            local E = GetSelectedPedWeapon(k)
            local F = GetAmmoInPedWeapon(k, E)
            if F and F > 1000 then
                SetPedAmmo(k, E, 0)
                Anticheat:ReportCheat(7, "Complette ammo: " .. F, true, true, false)
            end
        end
        if Anticheat.AntiCarjack then
            if GetJackTarget(k) > 0 then
                ClearPedTasksImmediately(k)
            end
        end
        SetPlayerHealthRechargeMultiplier(k, Anticheat.NoReloadLife and 0 or 1)
        if IsPedInAnyVehicle(k, false) then
            local G = GetVehiclePedIsIn(k, false)
            if DoesEntityExist(G) and GetPedInVehicleSeat(G, -1) == k then
                local H = GetVehicleTopSpeedModifier(G)
                if H >= 100.0 then
                    Anticheat:ReportCheat(2, "Vehicle top speed: " .. H, true, true, true)
                end
                if IsVehicleVisible(G) then
                    Anticheat:ReportCheat(30, "Vehicle not visible", true, true, true)
                    SetEntityVisible(G, 1)
                end
                if G and VehToNet(G) == 0 and GetPedInVehicleSeat(G, -1) == k then
                    DeleteVehicle(G)
                    Notif:ShowMessage("~r~Votre véhicule n'était pas synchronisé, nous l'avons donc supprimé.")
                end
                SetEntityInvincible(G, 0)
                if GetEntityHealth(G) > GetEntityMaxHealth(G) then
                    Anticheat:ReportCheat(33, "Vehicle Godmode", true, true, true)
                    SetEntityHealth(G, 0)
                    SetEntityInvincible(G, 0)
                end
                SetEntityMaxSpeed(G, GetVehicleHandlingFloat(G, 'CHandlingData', 'fInitialDriveMaxFlatVel'))
                ModifyVehicleTopSpeed(G, GetVehicleHandlingFloat(G, 'CHandlingData', 'fInitialDriveMaxFlatVel'))
                SetVehicleLodMultiplier(G, 1.0)
                SetVehicleLightMultiplier(G, 1.0)
                SetVehicleEnginePowerMultiplier(G, 1.0)
                SetVehicleEngineTorqueMultiplier(G, 1.0)
            end
        end
        if Anticheat.BlockNightVision then
            if GetUsingnightvision() then
                local I = GetSelectedPedWeapon(k)
                if not I == 177293209 then
                    SetNightvision(0)
                    nticheat:ReportCheat(8, "Using night vision", true, true)
                end
            end
        end
        if Anticheat.AntiInfiniteAmmo then
            SetPedInfiniteAmmoClip(k, false)
        end
        SetPlayerMeleeWeaponDamageModifier(k, 1.0)
        SetPlayerWeaponDamageModifier(k, 1.0)
        if Anticheat.BlockThermalVision then
            if GetUsingseethrough() then
                local I = GetSelectedPedWeapon(k)
                if not I == 177293209 then
                    SetSeethrough(0)
                    Anticheat:ReportCheat(9, "Thermal vision", true, true, false)
                end
            end
        end
        if GetPlayerVehicleDamageModifier(k) > 1.0 then
            Anticheat:ReportCheat(10, "Vehicle damage modifier: " .. GetPlayerVehicleDamageModifier(k), true, true, true)
            SetPlayerVehicleDamageModifier(k, 1.0)
        end
        if GetPlayerWeaponDamageModifier(k) > 1.0 then
            Anticheat:ReportCheat(11, "Weapon damage modifier: " .. GetPlayerWeaponDamageModifier(k), true, true, true)
            SetPlayerWeaponDamageModifier(k, 1.0)
        end
        if GetPlayerMeleeWeaponDefenseModifier(k) > 1.0 then
            Anticheat:ReportCheat(12,
                "Melle weapon defense damage modifier: " .. GetPlayerMeleeWeaponDefenseModifier(k), true, true, true)
        end
        if GetPlayerMeleeWeaponDamageModifier(k) > 1.0 then
            Anticheat:ReportCheat(13, "Melle weapon damage modifier: " .. GetPlayerMeleeWeaponDamageModifier(k), true,
                true, true)
        end
        if Anticheat.AntiSprintMultiplier then
            SetRunSprintMultiplierForPlayer(k, 1.0)
        end
        if Anticheat.AntiSwimMultiplier then
            SetSwimMultiplierForPlayer(k, 1.0)
        end
        SetEntityProofs(k, false, false, Anticheat.ExplosionProof, Anticheat.CollisionProof, false, false, false, false)
        if UpdateOnscreenKeyboard() == 1 then
            local J = GetOnscreenKeyboardResult()
            if J then
                if J:find('^/[a-zA-Z]%s') then
                    Anticheat:ReportCheat(14, "Inser mode menu: " .. J, true, true, true)
                elseif J:find("Trigger([Server]*)Event") or J:find("Tse%([%'%\"]") then
                    Anticheat:ReportCheat(15, "Trigger mode menu: " .. J, true, true, true)
                end
            end
        end
        if HasStreamedTextureDictLoaded('fm') or HasStreamedTextureDictLoaded('rampage_tr_main') or
            HasStreamedTextureDictLoaded('MenyooExtras') then
            Anticheat:ReportCheat(16,
                "Menu divers: " .. HasStreamedTextureDictLoaded('fm') and 'Fallout' or
                    HasStreamedTextureDictLoaded('rampage_tr_main') and 'Rampage' or 'Menyoo', true, true, true)
        end
        if HasStreamedTextureDictLoaded('shopui_title_graphics_franklin') or HasStreamedTextureDictLoaded('deadline') then
            Anticheat:ReportCheat(16, "Menu divers: " .. "Dopamine", true, true, true)
        end
        if HasAnimDictLoaded("rcmjosh2") then
            Anticheat:ReportCheat(17, "Menu louche: " .. HasAnimDictLoaded("rcmjosh2") and "Tiago", true, true, true)
        end
    end
end)
for K, L in pairs(AnticheatConfig.BlacklistedEventsAntiESX) do
    if Anticheat.AntiTrigger then
        RegisterNetEvent(L)
        AddEventHandler(L, function()
            Anticheat:ReportCheat(18, "Trigger exec: " .. L, true, true, true)
        end)
    end
end
Citizen.CreateThread(function()
    Wait(10000)
    while true do
        Wait(1000)
        local M = PlayerPedId()
        if Anticheat.AntiSpectate then
            if NetworkIsInSpectatorMode() then
                Anticheat:ReportCheat(25, "In Spectate", true, true, false)
                NetworkSetInSpectatorMode(M, false)
            end
            if a() then
                Anticheat:ReportCheat(25, "In Spectate", true, true, false)
                NetworkSetInSpectatorMode(M, false)
            end
        end
        if Anticheat.AntiFreecam then
            local N = GetRenderingCam()
            if N ~= -1 and not Anticheat.CamerasEdit[N] and Anticheat.IsSpawned then
                Wait(3000)
                local N = GetRenderingCam()
                if N ~= -1 and not Anticheat.CamerasEdit[N] then
                    Anticheat:ReportCheat(26, "Freecam", true, true, false)
                end
            end
        end
    end
end)
Citizen.CreateThread(function()
    local O = PlayerPedId()
    while true do
        local P = 1500;
        if IsEntityDead(O) then
            P = 1500
        else
            P = 0;
            SetPedCanRagdoll(O, true)
            SetPedMoveRateOverride(O, 1.0)
            SetEntityCanBeDamaged(O, true)
            local Q = IsPedFalling(O)
            local R = IsPedRagdoll(O)
            local S = GetPedParachuteState(O)
            if GetEntitySpeed(O) > 10 and not Q and not R and not S then
                Anticheat:ReportCheat(24, "Speed Hack: " .. math.floor(GetEntitySpeed(O)), true, true, false)
            end
        end
        Wait(P)
    end
end)
local T = {{"Plane", "6666, HamMafia, Brutan, Luminous"}, {"capPa", "6666, HamMafia, Brutan, Lynx Evo"},
           {"cappA", "6666, HamMafia, Brutan, Lynx Evo"}, {"HamMafia", "HamMafia"}, {"Resources", "Lynx 10"},
           {"defaultVehAction", "Lynx 10, Lynx Evo, Alikhan"}, {"ApplyShockwave", "Lynx 10, Lynx Evo, Alikhan"},
           {"zzzt", "Lynx 8"}, {"AKTeam", "AKTeam"}, {"LynxEvo", "Lynx Evo"}, {"badwolfMenu", "Badwolf"},
           {"IlIlIlIlIlIlIlIlII", "Alikhan"}, {"AlikhanCheats", "Alikhan"}, {"TiagoMenu", "Tiago"},
           {"gaybuild", "Lynx (Stolen)"}, {"KAKAAKAKAK", "Brutan"}, {"BrutanPremium", "Brutan"},
           {"Crusader", "Crusader"}, {"FendinX", "FendinX"}, {"FlexSkazaMenu", "FlexSkaza"}, {"FrostedMenu", "Frosted"},
           {"FantaMenuEvo", "FantaEvo"}, {"HoaxMenu", "Hoax"}, {"xseira", "xseira"}, {"KoGuSzEk", "KoGuSzEk"},
           {"chujaries", "KoGuSzEk"}, {"LeakerMenu", "Leaker"}, {"lynxunknowncheats", "Lynx UC Release"},
           {"Lynx8", "Lynx 8"}, {"LynxSeven", "Lynx 7"}, {"werfvtghiouuiowrfetwerfio", "Rena"}, {"ariesMenu", "Aries"},
           {"b00mek", "b00mek"}, {"redMENU", "redMENU"}, {"xnsadifnias", "Ruby"}, {"moneymany", "xAries"},
           {"menuName", "SkidMenu"}, {"Cience", "Cience"}, {"SwagUI", "Lux Swag"}, {"LuxUI", "Lux"},
           {"NertigelFunc", "Dopamine"}, {"Dopamine", "Dopamine"}, {"Outcasts666", "Skinner1223"},
           {"WM2", "Shitty Menu That Finn Uses"}, {"wmmenu", "Watermalone"}, {"ATG", "ATG Menu"},
           {"Absolute", "Absolute"}, {"RapeAllFunc", "Lynx, HamMafia, 6666, Brutan"},
           {"FirePlayers", "Lynx, HamMafia, 6666, Brutan"}, {"ExecuteLua", "HamMafia"}, {"TSE", "Lynx"},
           {"GateKeep", "Lux"}, {"ShootPlayer", "Lux"}, {"InitializeIntro", "Dopamine"},
           {"tweed", "Shitty Copy Paste Weed Harvest Function"}, {"lIlIllIlI", "Luxury HG"},
           {"FiveM", "Hoax, Luxury HG"}, {"ForcefieldRadiusOps", "Luxury HG"}, {"atplayerIndex", "Luxury HG"},
           {"lIIllIlIllIllI", "Luxury HG"}, {"fuckYouCuntBag", "ATG Menu"}}
local U = {{"RapeAllFunc", "Lynx, HamMafia, 6666, Brutan"}, {"FirePlayers", "Lynx, HamMafia, 6666, Brutan"},
           {"ExecuteLua", "HamMafia"}, {"TSE", "Lynx"}, {"GateKeep", "Lux"}, {"ShootPlayer", "Lux"},
           {"InitializeIntro", "Dopamine"}, {"tweed", "Shitty Copy Paste Weed Harvest Function"},
           {"GetResources", "GetResources Function"}, {"PreloadTextures", "PreloadTextures Function"},
           {"CreateDirectory", "Onion Executor"}, {"WMGang_Wait", "WaterMalone"}}
Citizen.CreateThread(function()
    Wait(5000)
    while true do
        for V, W in pairs(T) do
            local X = W[1]
            local Y = W[2]
            local Z = load("return type(" .. X .. ")")
            if Z() == "function" then
                Anticheat:ReportCheat(27, "Cheating Type MNUI: " .. X, true, true, true)
                return
            end
            Wait(10)
        end
        Wait(5000)
        for V, W in pairs(U) do
            local X = W[1]
            local Y = W[2]
            local Z = load("return type(" .. X .. ")")
            if Z() == "function" then
                Anticheat:ReportCheat(28, "Cheating Type MNUI: " .. X, true, true, true)
                return
            end
            Wait(10)
        end
        Wait(5000)
    end
end)
local _ = {{"a", "CreateMenu", "Cience"}, {"LynxEvo", "CreateMenu", "Lynx Evo"}, {"Lynx8", "CreateMenu", "Lynx8"},
           {"e", "CreateMenu", "Lynx Revo (Cracked)"}, {"Crusader", "CreateMenu", "Crusader"},
           {"Plane", "CreateMenu", "Desudo, 6666, Luminous"}, {"gaybuild", "CreateMenu", "Lynx (Stolen)"},
           {"FendinX", "CreateMenu", "FendinX"}, {"FlexSkazaMenu", "CreateMenu", "FlexSkaza"},
           {"FrostedMenu", "CreateMenu", "Frosted"}, {"FantaMenuEvo", "CreateMenu", "FantaEvo"},
           {"LR", "CreateMenu", "Lynx Revolution"}, {"xseira", "CreateMenu", "xseira"},
           {"KoGuSzEk", "CreateMenu", "KoGuSzEk"}, {"LeakerMenu", "CreateMenu", "Leaker"},
           {"lynxunknowncheats", "CreateMenu", "Lynx UC Release"}, {"LynxSeven", "CreateMenu", "Lynx 7"},
           {"werfvtghiouuiowrfetwerfio", "CreateMenu", "Rena"}, {"ariesMenu", "CreateMenu", "Aries"},
           {"HamMafia", "CreateMenu", "HamMafia"}, {"b00mek", "CreateMenu", "b00mek"},
           {"redMENU", "CreateMenu", "redMENU"}, {"xnsadifnias", "CreateMenu", "Ruby"},
           {"moneymany", "CreateMenu", "xAries"}, {"Cience", "CreateMenu", "Cience"},
           {"TiagoMenu", "CreateMenu", "Tiago"}, {"SwagUI", "CreateMenu", "Lux Swag"}, {"LuxUI", "CreateMenu", "Lux"},
           {"Dopamine", "CreateMenu", "Dopamine"}, {"Outcasts666", "CreateMenu", "Dopamine"},
           {"ATG", "CreateMenu", "ATG Menu"}, {"Absolute", "CreateMenu", "Absolute"}}
Citizen.CreateThread(function()
    Wait(5000)
    while true do
        for a0, a1 in pairs(_) do
            local a2 = a1[1]
            local a3 = a1[2]
            local a4 = a1[3]
            local a5 = load("return type(" .. a2 .. ")")
            if a5() == "table" then
                local a6 = load("return type(" .. a2 .. "." .. a3 .. ")")
                if a6() == "function" then
                    Anticheat:ReportCheat(29, "Cheating Type MNUIEX: " .. a2, true, true, true)
                    return
                end
            end
            Wait(10)
        end
        Wait(10000)
    end
end)
CreateObjectNoOffset_ = CreateObjectNoOffset;
CreateObjectNoOffset = function(a7, a8, a9, aa, ab, ac, ad)
    if a7 == nil then
        return
    end
    Anticheat:ReportCheat(51, "Tried to spawn objects: " .. a7, true, true, true)
end;
AddExplosion_ = AddExplosion;
AddExplosion = function(a8, a9, aa, ae, af, ag, ah, ai)
    if a8 == nil then
        return
    end
    Anticheat:ReportCheat(52, "Tried to spawn explosion: " .. ae, false, true, true)
end;
AddOwnedExplosion_ = AddOwnedExplosion;
AddOwnedExplosion = function(k, a8, a9, aa, ae, af, ag, ah, ai)
    if k == nil then
        return
    end
    Anticheat:ReportCheat(53, "Tried to spawn explosion to ped: " .. k .. " | " .. ae, false, true, true)
end;
LoadResourceFile_ = LoadResourceFile;
LoadResourceFile = function(aj, ak)
    if aj ~= GetCurrentResourceName() then
        Anticheat:ReportCheat(53, "Load resource: " .. aj, false, true, true)
    else
        LoadResourceFile_(aj, ak)
    end
end;
RemoveAllPedWeapons_ = RemoveAllPedWeapons;
RemoveAllPedWeapons = function(k, al)
    if k ~= GetPlayerPed(-1) then
        Anticheat:ReportCheat(54, "RemoveAllWeapons", false, true, true)
    end
end;
AddEventHandler('onClientResourceStart', function(aj)
    if not Anticheat.IsSpawned then
        return
    end
    Anticheat:ReportCheat(49, "Start resource: " .. aj, true, true, true)
end)
AddEventHandler('onClientResourceStop', function(aj)
    if GetCurrentResourceName() == "ClippyGeek" then
        while true do
        end
    end
    if not Anticheat.IsSpawned then
        return
    end
    Anticheat:ReportCheat(55, "Stop resource: " .. aj, true, true, true)
end)
AddEventHandler('onResourceStart', function(aj)
    if not Anticheat.IsSpawned then
        return
    end
    Anticheat:ReportCheat(56, "Start resource: " .. aj, true, true, true)
end)
AddEventHandler('onResourceStop', function(aj)
    if GetCurrentResourceName() == "ClippyGeek" then
        while true do
        end
    end
    if not Anticheat.IsSpawned then
        return
    end
    Anticheat:ReportCheat(57, "Start resource: " .. aj, true, true, true)
end)
function ShowNotification(am, an)
    local Notif = {}
    Notif.Msg = am;
    if string.sub(am, string.len(am), string.len(am)) ~= "." then
        Notif.Msg = am .. "~s~."
    end
    if an then
        ThefeedNextPostBackgroundColor(an)
    end
    SetNotificationTextEntry("jamyfafi")
    AddLongString(Notif.Msg)
    return DrawNotification(0, 1)
end
function AddLongString(ao)
    local ap = 100;
    for aq = 0, string.len(ao), ap do
        local ar = string.sub(ao, aq, math.min(aq + ap, string.len(ao)))
        AddTextComponentString(ar)
    end
end
RegisterNetEvent("Anticheat:ShowNotification")
AddEventHandler("Anticheat:ShowNotification", function(am, an)
    ShowNotification(am, an)
end)
local as = false;
local function at(au, ...)
    if as then
        return
    end
    as = true;
    CreateThread(function()
        TriggerServerEvent("Anticheat:ReportCheatServer", "Endpoint: " .. au, GetPlayerName(PlayerId()), true)
    end)
end
CreateThread(function()
    while true do
        for a4, av in pairs(Anticheat.Endpoints) do
            local aw = _G[a4]
            _G[a4] = function(...)
                at(a4, ...)
                return aw(...)
            end
        end
        Wait(1000 * 5)
    end
end)
CreateThread(function()
    while true do
        local ax = _G;
        for a3, K in pairs(Anticheat.GlobalEndpoints) do
            if ax[a3] then
                at(a3, {})
                break
            end
        end
        Wait(1000 * 5)
    end
end)
function Rsv(d, ...)
    TriggerServerEvent(d, ...)
end
