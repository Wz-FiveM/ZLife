local a = {
    r = 114,
    g = 114,
    b = 246,
    alpha = 255
}
local b = 8;
local c = 5500;
local d = 1;
local e = false;
RegisterCommand('me', function(f, g)
    local h = "* L'individu"
    for i = 1, #g do
        h = h .. ' ' .. g[i]
    end
    h = h .. ' *'
    TriggerServerEvent('3dme:shareDisplay', h)
end)
local j;
RegisterCommand("me", function(f, g, k)
    local l = 5500;
    if j and j > GetGameTimer() then
        return
    end
    local m = 0 + l;
    j = GetGameTimer() + m;
    local n = ""
    for o, p in pairs(g) do
        n = n .. p .. " "
    end
    if not n or string.len(n) <= 1 or string.len(n) > 100 then
        ShowAboveRadarMessage("~r~Le message est trop long.")
        return
    end
    TriggerServerEvent("3dme:shareDisplay", "* L'individu " .. n .. "*", true)
end)
RegisterNetEvent('3dme:triggerDisplay')
AddEventHandler('3dme:triggerDisplay', function(h, f)
    local q = 1 + d * 0.12;
    if not e then
        e = true;
        Display(GetPlayerFromServerId(f), h, q)
    end
end)
function Display(r, h, q)
    local s = true;
    Citizen.CreateThread(function()
        Wait(c)
        e = false;
        s = false
    end)
    Citizen.CreateThread(function()
        d = d + 1;
        while s do
            Wait(0)
            local t = GetEntityCoords(GetPlayerPed(r), false)
            local u = GetEntityCoords(PlayerPedId(), false)
            local v = GetDistanceBetweenCoords(t['x'], t['y'], t['z'], u['x'], u['y'], u['z'], true)
            if v < 10 then
                DrawText3DMe(t['x'], t['y'], t['z'] + q, h)
            end
        end
        d = d - 1
    end)
end
function DrawText3DMe(w, x, y, h)
    local z, A, B = World3dToScreen2d(w, x, y)
    local C, D, E = table.unpack(GetGameplayCamCoord())
    local v = GetDistanceBetweenCoords(C, D, E, w, x, y, 1)
    local F = 1 / v * 2;
    local G = 1 / GetGameplayCamFov() * 100;
    local F = F * G;
    if z then
        SetTextScale(0.0 * F, 0.45 * F)
        SetTextFont(b)
        SetTextProportional(1)
        SetTextColour(a.r, a.g, a.b, a.alpha)
        SetTextDropshadow(0, 0, 0, 0, 255)
        SetTextEdge(2, 0, 0, 0, 150)
        SetTextEntry("STRING")
        SetTextCentre(true)
        AddTextComponentString(h)
        EndTextCommandDisplayText(A, B)
    end
end
