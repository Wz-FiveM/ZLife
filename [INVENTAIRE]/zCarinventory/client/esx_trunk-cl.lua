ESX = nil;
local a = {}
local b = {}
local c = nil;
local d = false;
b.Time = 0;
local e = {}
local f = Config.localWeight;
local g = false;
local h = nil;
local i = nil;
local j = 0;
Citizen.CreateThread(function()
    while ESX == nil do
        TriggerEvent('esx:getSharedObject', function(k)
            ESX = k
        end)
        Citizen.Wait(0)
    end
    while ESX.GetPlayerData().job == nil do
        Citizen.Wait(10)
    end
    a = ESX.GetPlayerData()
end)
RegisterNetEvent("esx:playerLoaded")
AddEventHandler("esx:playerLoaded", function(xPlayer)
    a = xPlayer;
    TriggerServerEvent("esx_trunk_inventory:getOwnedVehicule")
    j = GetGameTimer()
end)
AddEventHandler("onResourceStart", function()
    a = xPlayer;
    TriggerServerEvent("esx_trunk_inventory:getOwnedVehicule")
    j = GetGameTimer()
end)
RegisterNetEvent("esx:setJob")
AddEventHandler("esx:setJob", function(l)
    a.job = l
end)
RegisterNetEvent("esx_trunk_inventory:setOwnedVehicule")
AddEventHandler("esx_trunk_inventory:setOwnedVehicule", function(m)
    e = m
end)
function getItemyWeight(n)
    local o = 0;
    local p = 0;
    if n ~= nil then
        p = Config.DefaultWeight;
        if f[n] ~= nil then
            p = f[n]
        end
    end
    return p
end
function VehicleInFront()
    local q = GetEntityCoords(GetPlayerPed(-1))
    local h = GetOffsetFromEntityInWorldCoords(GetPlayerPed(-1), 0.0, 4.0, 0.0)
    local r = CastRayPointToPoint(q.x, q.y, q.z, h.x, h.y, h.z, 10, GetPlayerPed(-1), 0)
    local s, t, u, v, w = GetRaycastResult(r)
    return w
end
local x = 0;
function openmenuvehicle()
    local y = GetPlayerPed(-1)
    local z = GetEntityCoords(y)
    local m = VehicleInFront()
    if IsPedInAnyVehicle(y, false) then
        m = GetVehiclePedIsIn(y, false)
    end
    i = GetVehicleNumberPlateText(m)
    myVeh = false;
    local A = VehicleInFront()
    a = ESX.GetPlayerData()
    --for B = 1, #e do
        local C = all_trim(GetVehicleNumberPlateText(A))
        local D = all_trim(GetVehicleNumberPlateText(A))
        if C == D then
            myVeh = true
        elseif j < GetGameTimer() - 60000 then
            TriggerServerEvent("esx_trunk_inventory:getOwnedVehicule")
            j = GetGameTimer()
            Wait(150)
            --for B = 1, #e do
                local C = all_trim(GetVehicleNumberPlateText(A))
                local D = all_trim(GetVehicleNumberPlateText(A))
                if C == D then
                    myVeh = true
                end
            --end
        end
        if not Config.CheckOwnership or Config.AllowPolice and a.job.name == "police" or Config.CheckOwnership and myVeh then
            if i ~= nil or i ~= "" or i ~= " " then
                g = true;
                local E = VehicleInFront()
                local F, G, H = table.unpack(GetEntityCoords(GetPlayerPed(-1), true))
                local I = GetClosestVehicle(F, G, H, 4.0, 0, 71)
                if IsPedInAnyVehicle(y, false) then
                    I = GetVehiclePedIsIn(y, false)
                    E = GetVehiclePedIsIn(y, false)
                end
                if not I or not DoesEntityExist(I) then
                    return ESX.ShowNotification('~r~Aucun véhicule.')
                end
                c = E;
                local J = GetDisplayNameFromVehicleModel(GetEntityModel(I))
                local K = GetVehicleDoorLockStatus(I)
                local L = GetVehicleClass(E)
                if K == 1 or L == 15 or L == 16 or L == 14 or L == 18 then
                    SetVehicleDoorOpen(E, 5, false, false)
                    if i ~= nil or i ~= "" or i ~= " " then
                        g = true;
                        OpenCoffreInventoryMenu(GetVehicleNumberPlateText(E), Config.VehicleLimit[L], myVeh)
                    end
                else
                    ESX.ShowNotification(_U("trunk_closed"))
                end
                d = true;
                b.Time = GetGameTimer()
            end
        else
            ESX.ShowNotification(_U("nacho_veh"))
        end
    --end
end
RegisterKeyMapping('+opencoffre', 'Ouvrir le coffre de véhicule', 'keyboard', 'L')
RegisterCommand('+opencoffre', function()
    openmenuvehicle()
    Citizen.Wait(2000)
end)
Citizen.CreateThread(function()
    while true do
        Wait(0)
        local q = GetEntityCoords(GetPlayerPed(-1))
        if g then
            local m = GetClosestVehicle(q["x"], q["y"], q["z"], 2.0, 0, 70)
            if DoesEntityExist(m) then
                g = true
            else
                g = false;
                d = false;
                SetVehicleDoorShut(c, 5, false)
            end
        end
    end
end)
RegisterNetEvent("esx:playerLoaded")
AddEventHandler("esx:playerLoaded", function(xPlayer)
    a = xPlayer;
    TriggerServerEvent("esx_trunk_inventory:getOwnedVehicule")
    j = GetGameTimer()
end)
function OpenCoffreInventoryMenu(M, N, myVeh)
    ESX.TriggerServerCallback("esx_trunk:getInventoryV", function(O)
        text = _U("trunk_info", O.weight / 1000, N / 1000)
        data = {
            plate = M,
            max = N,
            myVeh = myVeh,
            text = text
        }
        TriggerEvent("c_inventaire:openTrunkInventory", data, O.blackMoney, O.items, O.weapons)
    end, M)
end
function all_trim(P)
    if P then
        return P:match "^%s*(.*)":match "(.-)%s*$"
    else
        return "noTagProvided"
    end
end
function dump(Q)
    if type(Q) == "table" then
        local P = "{ "
        for R, S in pairs(Q) do
            if type(R) ~= "number" then
                R = '"' .. R .. '"'
            end
            P = P .. "[" .. R .. "] = " .. dump(S) .. ","
        end
        return P .. "} "
    else
        return tostring(Q)
    end
end
