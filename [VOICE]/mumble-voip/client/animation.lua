local a = { { lib = "anim@heists@ornate_bank@chat_manager", anim = "disrupt" }, { lib = "anim@heists@ornate_bank@chat_manager", anim = "nice_clothes" }, { lib = "anim@heists@ornate_bank@chat_manager", anim = "no_speak" }, { lib = "anim@heists@ornate_bank@chat_manager", anim = "not_nice_car" }, { lib = "gestures@f@standing@casual", anim = "gesture_bye_soft" }, { lib = "gestures@f@standing@casual", anim = "gesture_why" }, { lib = "gestures@f@standing@casual", anim = "gesture_hello" }, { lib = "gestures@f@standing@casual", anim = "gesture_nod_yes_soft" }, { lib = "gestures@f@standing@casual", anim = "gesture_hand_right" }, { lib = "gestures@f@standing@casual", anim = "gesture_hand_left" } }
local b = false;
local c = nil;
local d = false;
local e = true;
local f = false;
local g = -1;
local h = false;
local i = false;
local j = false;
local k;
RegisterCommand('voiceanim', function()
    if not i then
        i = true;
        j = true;
        if k then
            RemoveNotification(k)
        end ;
        k = ShowAboveRadarMessage("Vous avez ~g~activé~s~ les animations quand vous parlez.")
    elseif i then
        if k then
            RemoveNotification(k)
        end ;
        k = ShowAboveRadarMessage("Vous avez ~r~désactivé~s~ les animations quand vous parlez.")
        i = false;
        j = false
    end
end)
Citizen.CreateThread(function()
    while true do
        Citizen.Wait(1)
        g = -1;
        if f then
            g = 0
        end ;
        local l = GetPlayerPed(-1)
        if not e or GetSelectedPedWeapon(l) ~= GetHashKey("WEAPON_UNARMED") or IsPedInAnyVehicle(l) or IsPedRunning(l) or IsPedSprinting(l) then
            g = 1
        end ;
        if NetworkIsPlayerTalking(PlayerId()) and not b and g == -1 then
            if not d then
                b = true;
                if j then
                    restartAnim()
                end
            end
        elseif not NetworkIsPlayerTalking(PlayerId()) and b or g == 1 then
            d = true;
            if c ~= nil then
                StopAnimTask(GetPlayerPed(-1), c.lib, c.anim, 2.0)
            end ;
            b = false;
            SetTimeout(500, function()
                d = false
            end)
        end
    end
end)
local q = 0;
function restartAnim()
    Citizen.CreateThread(function()
        Wait(500)
        local r = math.random(1, #a)
        while r == q do
            Wait(0)
            r = math.random(1, #a)
        end ;
        c = a[r]
        q = r;
        if not HasAnimDictLoaded(c.lib) then
            RequestAnimDict(c.lib)
            while not HasAnimDictLoaded(c.lib) do
                Citizen.Wait(0)
            end
        end ;
        TaskPlayAnim(GetPlayerPed(-1), c.lib, c.anim, 1.5, 1.0, -1, 48, 0.0, 0, 0, 0)
        local s = true;
        while s do
            Wait(0)
            s = IsEntityPlayingAnim(GetPlayerPed(-1), c.lib, c.anim, 3)
            if not b then
                s = false
            end
        end ;
        StopAnimTask(GetPlayerPed(-1), c.lib, c.anim, 2.0)
        local t = math.random(500, 1000)
        Wait(t)
        if not b then
            return
        end ;
        restartAnim()
    end)
end