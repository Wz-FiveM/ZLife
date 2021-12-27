Citizen.CreateThread(function()
    N_0x4757f00bc6323cfe(GetHashKey("WEAPON_UNARMED"), 0.5)
    N_0x4757f00bc6323cfe(GetHashKey("WEAPON_KNUCKLE"), 0.4)
    N_0x4757f00bc6323cfe(GetHashKey("WEAPON_HAMMER"), 0.6)
    N_0x4757f00bc6323cfe(GetHashKey("WEAPON_FLASHLIGHT"), 0.6)
    N_0x4757f00bc6323cfe(GetHashKey("WEAPON_GOLFCLUB"), 0.6)
    N_0x4757f00bc6323cfe(GetHashKey("WEAPON_BAT"), 0.6)
    N_0x4757f00bc6323cfe(GetHashKey("WEAPON_NIGHTSTICK"), 0.6)
    N_0x4757f00bc6323cfe(GetHashKey("WEAPON_WRENCH"), 0.6)
    N_0x4757f00bc6323cfe(GetHashKey("WEAPON_POOLCUE"), 0.4)
    N_0x4757f00bc6323cfe(GetHashKey("WEAPON_DAGGER"), 0.6)
    N_0x4757f00bc6323cfe(GetHashKey("WEAPON_BOTTLE"), 0.6)
    N_0x4757f00bc6323cfe(GetHashKey("WEAPON_HATCHET"), 0.6)
    N_0x4757f00bc6323cfe(GetHashKey("WEAPON_KNIFE"), 0.6)
    N_0x4757f00bc6323cfe(GetHashKey("WEAPON_MACHETE"), 0.6)
    N_0x4757f00bc6323cfe(GetHashKey("WEAPON_SWITCHBLADE"), 0.6)
    N_0x4757f00bc6323cfe(GetHashKey("WEAPON_BATTLEAXE"), 0.6)
    N_0x4757f00bc6323cfe(GetHashKey("WEAPON_STONE_HATCHET"), 0.6)
    N_0x4757f00bc6323cfe(-1553120962, 0.2)
    Wait(0)
end)
Citizen.CreateThread(function()
    while true do
        local a = 250;
        local b = PlayerPedId()
        if IsPedArmed(b, 6) then
            a = 1;
            DisableControlAction(1, 140, true)
            DisableControlAction(1, 141, true)
            DisableControlAction(1, 142, true)
        end
        if IsPedArmed(b, 5) then
            a = 1;
            DisableControlAction(1, 26, true)
        end
        Wait(a)
    end
end)
Citizen.CreateThread(function()
    while true do
        local a = 100;
        DisableControlAction(1, 140, true)
        if IsPlayerFreeAiming(PlayerId()) then
            a = 1;
            DisableControlAction(0, 22, true)
            DisableControlAction(0, 36, true)
            DisableControlAction(1, 141, true)
            DisableControlAction(1, 142, true)
        end
        Wait(a)
    end
end)
