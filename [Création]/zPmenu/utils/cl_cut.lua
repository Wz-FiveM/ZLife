local dT7iYD3 = false
local LUF = {
    vector3(1154.0, -661.28, 57.76-0.98), vector3(1133.28, -628.08, 57.24-0.98), vector3(1134.64, -603.0, 57.6-0.98),
    vector3(1149.24, -594.72, 60.76-0.98), vector3(1146.36, -554.64, 63.08-0.98), vector3(1157.84, -532.4, 65.12-0.98),
    vector3(1145.96, -531.88, 64.4-0.98), vector3(1109.04, -508.28, 63.6-0.98), vector3(1094.6, -528.52, 62.88-0.98),
    vector3(1073.44, -535.72, 61.56-0.98), vector3(1050.08, -532.88, 61.4-0.98), vector3(1076.28, -545.68, 58.56-0.98),
    vector3(1077.16, -558.52, 56.84-0.98), vector3(1069.84, -589.92, 56.8-0.98), vector3(1018.48, -559.64, 59.92-0.98),
    vector3(1044.32, -515.64, 61.84-0.98), vector3(1005.4, -532.0, 60.32-0.98), vector3(975.64, -543.44, 59.44-0.98),
    vector3(949.76, -600.64, 59.16-0.98), vector3(973.4, -679.84, 57.44-0.98), vector3(1016.84, -752.68, 57.96-0.98),
    vector3(1171.84, -774.36, 57.36-0.98), vector3(1170.72, -792.08, 56.44-0.98), vector3(1234.96, -775.32, 60.28-0.98),

    vector3(-387.96, 1163.72, 325.8-0.98),  --#1
    
    vector3(-396.2, 1148.76, 325.84-0.98), vector3(-397.52, 1139.2, 325.8-0.98),
    vector3(-414.96, 1109.08, 325.88-0.98), vector3(-398.36, 1102.76, 325.88-0.98), vector3(-387.6, 1100.24, 325.6-0.98),
    vector3(-401.88, 1075.4, 323.84-0.98), vector3(-401.56, 1083.52, 327.68-0.98), vector3(-465.8, 1101.44, 327.68-0.98),
    vector3(-459.84, 1119.48, 325.88-0.98), vector3(-441.8, 1115.68, 325.96-0.98), vector3(-421.6, 1112.72, 326.76-0.98),
    vector3(-434.4, 1116.28, 326.76-0.98), vector3(-421.48, 1150.56, 325.88-0.98), vector3(-415.96, 1158.24, 325.88-0.98),
    vector3(-411.72, 1152.16, 325.84-0.98), vector3(-437.76, 1201.12, 325.68-0.98), vector3(-381.2, 1231.04, 326.0-0.98),
    vector3(-358.04, 1154.2, 325.6-0.98), vector3(-341.16, 1158.64, 325.52-0.98), vector3(-339.48, 1151.04, 325.72-0.98),
    vector3(-317.16, 1213.16, 322.2-0.98), vector3(-475.0, 1181.96, 325.2-0.98), vector3(-499.68, 1181.44, 324.8-0.98),
    vector3(-517.04, 1186.96, 324.92-0.98), 
    
    vector3(-1300.24, -1418.52, 4.56-0.98), --#2
    
    vector3(-1295.64, -1431.44, 4.8-0.98),
    vector3(-1295.64, -1431.44, 4.8-0.98), vector3(-1305.4, -1449.48, 4.6-0.98), vector3(-1285.12, -1459.44, 4.52-0.98),
    vector3(-1285.24, -1498.24, 4.48-0.98), vector3(-1291.8, -1516.28, 4.64-0.98), vector3(-1301.36, -1538.44, 4.6-0.98),
    vector3(-1272.72, -1553.8, 4.88-0.98), vector3(-1266.28, -1563.48, 4.68-0.98), vector3(-1234.44, -1550.8, 4.64-0.98),
    vector3(-1288.12, -1582.0, 4.36-0.98), vector3(-1334.04, -1520.4, 4.4-0.98), vector3(-1341.4, -1504.92, 4.52-0.98),
    vector3(-1361.16, -1504.52, 5.0-0.98), vector3(-1366.8, -1463.84, 5.0-0.98), vector3(-1389.24, -1412.4, 4.2-0.98),
    vector3(-1393.12, -1381.44, 3.84-0.98), vector3(-1357.12, -1372.76, 3.44-0.98), vector3(-1346.64, -1324.2, 4.96-0.98),
    vector3(-1351.72, -1294.72, 5.12-0.98), vector3(-1372.2, -1223.56, 5.32-0.98), vector3(-1373.36, -1192.96, 4.64-0.98),
    vector3(-1370.32, -1142.36, 4.76-0.98), vector3(-1378.92, -1111.0, 4.6-0.98), 
    
    vector3(-1639.08, -195.12, 55.24-0.98), --#3
    
    vector3(-1612.6, -183.72, 55.56-0.98),
    vector3(-1625.04, -152.04, 57.04-0.98), vector3(-1655.28, -121.2, 60.52-0.98), vector3(-1677.92, -133.72, 59.92-0.98),
    vector3(-1706.2, -142.0, 58.4-0.98), vector3(-1713.24, -159.84, 58.12-0.98), vector3(-1747.28, -175.48, 57.64-0.98),
    vector3(-1761.68, -187.44, 58.24-0.98), vector3(-1781.32, -169.24, 64.72-0.98), vector3(-1790.96, -141.4, 73.44-0.98),
    vector3(-1813.12, -127.56, 78.68-0.98), vector3(-1815.12, -210.24, 49.44-0.98), vector3(-1823.28, -235.72, 42.04-0.98),
    vector3(-1790.72, -286.16, 44.0-0.98), vector3(-1778.96, -298.88, 44.44-0.98), vector3(-1770.8, -307.44, 44.72-0.98),
    vector3(-1760.04, -314.32, 45.76-0.98), vector3(-1736.76, -324.8, 47.32-0.98), vector3(-1723.68, -324.44, 48.52-0.98),
    vector3(-1700.64, -327.96, 49.4-0.98), vector3(-1680.24, -319.88, 50.88-0.98), 
    
    vector3(1054.36, -541.88, 60.88-0.98), --#4

    vector3(1049.76, -604.96, 57.64-0.98), vector3(1039.76, -691.76, 57.32-0.98), vector3(1044.44, -704.16, 57.2-0.98),
    vector3(1039.36, -734.36, 58.08-0.98), vector3(1072.96, -748.04, 57.8-0.98), vector3(1118.48, -746.12, 57.4-0.98),
    vector3(1158.52, -751.0, 58.12-0.98), vector3(1179.16, -723.0, 59.0-0.98), vector3(1153.44, -691.52, 57.92-0.98)
}
local WRH936;
local cJoBcud = false;
local e = false;
local B6zKx2;
local O3_X3;
local DVs8kf2
local vms5 = GetHashKey("WEAPON_GARBAGEBAG")

local ngzOjWHO

function attachObjectPedHand(_u,aLgiy,mvi,g4KV,dT7iYD3)
    local L=LocalPlayer().Ped
    if ngzOjWHO and DoesEntityExist(ngzOjWHO)then 
        DeleteEntity(ngzOjWHO)
    end;
    local WRH936,cJoBcud=false,GetGameTimer()
    while not WRH936 and cJoBcud+3000 >GetGameTimer()do
        Wait(500)
    end;
    ngzOjWHO=CreateObject(GetHashKey(_u),LocalPlayer().Pos,not dT7iYD3)
    SetNetworkIdCanMigrate(ObjToNet(ngzOjWHO),false)
    AttachEntityToEntity(ngzOjWHO,L,GetPedBoneIndex(L,g4KV and 60309 or 28422),.0,.0,.0,.0,.0,.0,true,true,false,true,1,not mvi)
    if aLgiy then 
        Citizen.Wait(aLgiy)
        if ngzOjWHO and DoesEntityExist(ngzOjWHO)then 
            DeleteEntity(ngzOjWHO)
        end
        ClearPedTasks(LocalPlayer().Ped)
    end
    return ngzOjWHO 
end

local function M7(v3, ihKb)
    SetPedCanSwitchWeapon(v3, ihKb)
    if not ihKb then
        doAnim("WORLD_HUMAN_GARDENER_LEAF_BLOWER", nil, 0)
        if DVs8kf2 and DoesEntityExist(DVs8kf2) then
            DeleteEntity(DVs8kf2)
        end
        Wait(2000)
        DVs8kf2 = attachObjectPedHand("hei_prop_heist_binbag", nil, true)
        ClearPedTasksImmediately(v3)
        RemoveBlip(B6zKx2)
        GiveDelayedWeaponToPed(v3, vms5, 0, true)
        O3_X3 = O3_X3 + 1 >= #LUF and 1 or O3_X3 + 1
        local x,y,z = table.unpack(GetOffsetFromEntityInWorldCoords(PlayerPedId(), 0.0, 0.0, 0.0))
		ClearAreaOfObjects(x, y, z, 15.0, true)
		ClearAreaOfProjectiles(x, y, z, 15.0, 0)
    else
        if HasPedGotWeapon(v3, vms5) then
            RemoveWeaponFromPed(v3, vms5)
            GiveDelayedWeaponToPed(v3, "WEAPON_UNARMED", 0, true)
        end
        Citizen.Wait(300)
        if B6zKx2 then
            RemoveBlip(B6zKx2)
            SetEntityAsMissionEntity(DVs8kf2, true, true)
            DeleteEntity(DVs8kf2)
        end
    end
    cJoBcud = not ihKb
end
Citizen.CreateThread(function()
    while true do
        Citizen.Wait(10000)
        if cJoBcud and (LocalPlayer().InVehicle or not dT7iYD3) then
            M7(GetPlayerPed(-1), true)
        end
    end
end)
RegisterCommand("jardinier", function()
    dT7iYD3 = not dT7iYD3
    ShowAboveRadarMessage(string.format("Vous avez %s~w~ votre ~b~service jardinier.",dT7iYD3 and "~g~activé" or "~r~désactivé"))
    if B6zKx2 then
        RemoveBlip(B6zKx2)
    end
end)

Citizen.CreateThread(function()
    while true do 
        local attente = 1000
        if dT7iYD3 then
            attente = 5
            local rA5U = LocalPlayer()
            local Uc06, lcBL = rA5U.Ped, rA5U.Pos
            if not O3_X3 then
                if not WRH936 then
                    WRH936 = {}
                    ShowAboveRadarMessage("Récupérez votre camion à la ~b~'Casse'~s~ puis allez sur les ~b~points de départs~s~ notés sur la carte.")
                    for DHPxI = 0, #LUF, 25 do
                        if LUF[DHPxI] then
                            WRH936[DHPxI] = createBlip(LUF[DHPxI], 441, 33, "Point de départ")
                        end
                    end
                else
                    for dx, RRuSHnxf in pairs(WRH936) do
                        if LUF[dx] and GetDistanceBetweenCoords(lcBL, LUF[dx], true) < 32 then
                            O3_X3 = dx
                            for mcYOuT, Rr in pairs(WRH936) do
                                RemoveBlip(Rr)
                            end
                            WRH936 = nil
                        end
                    end
                end
            elseif O3_X3 then
                local scRP0 = LUF[O3_X3]
                if not DoesBlipExist(B6zKx2) then
                    B6zKx2 = createBlip(scRP0, 365, 60, "Buissons", true)
                else
                    if not cJoBcud then
                        local AI0R2TQ6 = GetDistanceBetweenCoords(lcBL, scRP0, true)
                        if AI0R2TQ6 < 64 then
                            DrawMarker(0, scRP0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 1.0, 1.0, 0.25, 53, 162, 53, 112, 0, 0, 2, 0,0, 0, 0)
                            if AI0R2TQ6 < 2 and not rA5U.InVehicle then
                                DrawText3D(scRP0.x, scRP0.y, scRP0.z+1.0, "Appuyez sur ~b~E ~w~pour ~g~récuperer les feuilles~w~.", 9)
                                if IsControlJustPressed(1, 51) then
                                    M7(Uc06, false)
                                end
                            end
                        end
                    else
                        DrawTopNotification("Appuyez sur ~INPUT_CONTEXT~ près du camion pour ~b~jeter les feuilles~w~.")
                        if IsControlJustPressed(1, 51) and not e then
                            local yA = getVehInSight()
                            if (GetDistanceBetweenCoords(lcBL, GetEntityCoords(yA) - GetEntityForwardVector(yA) * 5) < 2 or
                                rA5U.InVehicle) and GetEntityModel(yA) == 2132890591 then
                                e = true
                                Citizen.CreateThread(function()
                                    SetVehicleDoorOpen(yA, 5)
                                    Citizen.Wait(1000)
                                    SetVehicleDoorShut(yA, 5)
                                    e = false
                                    TriggerServerEvent("clp:giveitemchill", "feuilles", 1)
                                    drawCenterText("Vous avez récupérez un sac de ~b~Feuilles~s~. (~b~+1~s~)", 3500)
                                    PlaySoundFrontend(-1, 'Bus_Schedule_Pickup', 'DLC_PRISON_BREAK_HEIST_SOUNDS', false)
                                    M7(Uc06, true)
                                end)
                            end
                        end
                    end
                end
            end
        elseif O3_X3 or (cJoBcud and GetSelectedPedWeapon(GetPlayerPed(-1)) ~= vms5) or WRH936 then
            e = false;
            if WRH936 then
                for XmVolesU, eZ0l3ch in pairs(WRH936) do
                    RemoveBlip(eZ0l3ch)
                end
                WRH936 = nil
            end
        end
        Wait(attente)
    end
end)