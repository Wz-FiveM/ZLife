function pedclothe()
    SetPedComponentVariation(ped, 11, 14, 2, 2) 
    SetPedComponentVariation(ped, 4, 1, 0, 2) 
    SetPedComponentVariation(ped, 3, 4, 0, 2)
    SetPedComponentVariation(ped, 6, 1, 0, 2)
    SetPedComponentVariation(ped, 8, 16, 9, 2) 
end

function pednoclothe()
    SetPedComponentVariation(ped, 11, 15, 2, 2) 
    SetPedComponentVariation(ped, 4, 14, 0, 2) 
    SetPedComponentVariation(ped, 3, 15, 0, 2)
    SetPedComponentVariation(ped, 6, 34, 0, 2)
    SetPedComponentVariation(ped, 8, 16, 9, 2) 
end

function stepin()
    SetEntityCollision(ped, ped, ped)
    FreezeEntityPosition(ped, false)
    TaskGoStraightToCoord(ped, -1151.01, -1425.59, 3.95, 2, -1, 112.0, 1);
    pednoclothe()
    Wait(2500) 
    SetEntityCollision(ped,not ped, ped)
    FreezeEntityPosition(ped, true)
end
function stepout()
    SetEntityCollision(ped, ped, ped)
    FreezeEntityPosition(ped, false)
    TaskGoStraightToCoord(ped, -1152.27, -1423.68, 3.95, 2, -1, 124.0, 1);
    pedclothe()
end