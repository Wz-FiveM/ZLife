
local crvehicle = nil

Citizen.CreateThread(function()
    while true do
        time = 500
        if inGarage and shared.scaleform then 
            time = 0
            local playerpos = GetEntityCoords(PlayerPedId())
            local vehicle, distance = ESX.Game.GetClosestVehicle({x = playerpos.x,y = playerpos.y,z = playerpos.z})
            scaleform  = Initialize("mp_car_stats_01", GetEntityModel(vehicle))
            x,y,z = table.unpack(GetEntityCoords(vehicle))
            local value = GetEntityHeight(vehicle, x, y, z, true, false)
            if distance < 5 and IsPedOnFoot(PlayerPedId()) then 
                if crvehicle ~= vehicle then 
                    crvehicle = vehicle
                end
                DrawScaleformMovie_3dNonAdditive(scaleform, x,y,z + 2.4 + value, GetGameplayCamRot(0), 0.0, 1.0, 0.0, 7.2, 4.8, 0.9, 2)
            end
     
        end
        Wait(time)
    end
end)




function Initialize(scaleform, hash)
    scaleform = RequestScaleformMovie(scaleform)
    while not HasScaleformMovieLoaded(scaleform) do
        Citizen.Wait(0)
    end
    vehiclemaxspeed = nil
    local vehicle = hash
    local K = GetDisplayNameFromVehicleModel(vehicle)

    
    local vehicle = hash
    local zz1QI = GetVehicleModelMaxSpeed(vehicle) * 1.25
    local kFTAh = GetVehicleModelAcceleration(vehicle) * 200
    local LBf = GetVehicleModelMaxBraking(vehicle) * 100
    local dijn4Ph = GetVehicleModelMaxTraction(vehicle) * 25

    PushScaleformMovieFunction(scaleform, "SET_VEHICLE_INFOR_AND_STATS")
    PushScaleformMovieFunctionParameterString(GetDisplayNameFromVehicleModel(hash))
    PushScaleformMovieFunctionParameterString(""..GetVehicleModelMaxNumberOfPassengers(vehicle).." sièges")
    PushScaleformMovieFunctionParameterString("MPCarHUD")
    PushScaleformMovieFunctionParameterString("Annis")
    PushScaleformMovieFunctionParameterString("Vitesse max")
    PushScaleformMovieFunctionParameterString("Acceleration")
    PushScaleformMovieFunctionParameterString("Braking")
    PushScaleformMovieFunctionParameterString("Traction")
    PushScaleformMovieFunctionParameterInt(math.floor(zz1QI))
    PushScaleformMovieFunctionParameterInt(math.floor(kFTAh))
    PushScaleformMovieFunctionParameterInt(math.floor(LBf))
    PushScaleformMovieFunctionParameterInt(math.floor(dijn4Ph))
    PopScaleformMovieFunctionVoid()
    return scaleform
end




function entergarage(id, places, iterator, pos)
    NetworkSetVoiceChannel(id)    
    loadvehicles(id, places)
    inGarage, currentid, currentgarageid = true, iterator, id
    SetEntityCoords(PlayerPedId(), pos.x, pos.y, pos.z-0.90)
    CloseMenu(true)
end


function loadvehicles(id, currentPlaces)
    ESX.TriggerServerCallback('pl_checkcars', function(result)
        if result ~= "[]" then 
            shared.currentVehicleingarage = {}
            for k, v in pairs(result) do 
                local vehicleProps = json.decode(v.vehicleprops)
                ESX.Game.SpawnLocalVehicle(vehicleProps.model, shared.GarageList[currentPlaces..'place'].CarSpots[k].Pos, shared.GarageList[currentPlaces..'place'].CarSpots[k].Heading, function(vehicle) 
                    ESX.Game.SetVehicleProperties(vehicle, vehicleProps)
                    table.insert(shared.currentVehicleingarage, {vehicle = vehicle, carid = v.id, garageid = id, props = vehicleProps})
                    FreezeEntityPosition(vehicle, true)
                end)  
            end 
        end 
    end, id)
end
     
function getoutvehicle(result) 
    local vehicle = GetVehiclePedIsIn(GetPlayerPed(-1), false)
    local vehicleProps = ESX.Game.GetVehicleProperties(vehicle)
    TriggerEvent('esx:deleteVehicle') 
    SetEntityCoords(PlayerPedId(), result.x, result.y, result.z)
    ESX.Game.SpawnVehicle(vehicleProps.model, vector3(result.x, result.y, result.z), result.h, function(vehicle) 
        ESX.Game.SetVehicleProperties(vehicle, vehicleProps)
        SetPedIntoVehicle(PlayerPedId(), vehicle, -1)
    end)   
    deletevehicles()
    for k, v in pairs(shared.currentVehicleingarage) do 
        if v.vehicle == vehicle then 
           TriggerServerEvent("pl_deletegaragevehicle", v.carid)
        end 
    end 
    TriggerServerEvent('pl_leavegarage')
    Citizen.InvokeNative(0xE036A705F989E049)
    NetworkSetTalkerProximity(2.5) 
    inGarage = false
    cooldown = true
    Wait(2000)
    cooldown = false
end

function deletevehicles()
    for k, v in pairs(shared.currentVehicleingarage) do 
        DeleteVehicle(v.vehicle)
    end 
end

local currenthealth = nil




function rangementvehicule(id)
    local vehicle = GetVehiclePedIsIn(GetPlayerPed(-1), false)
    local vehicleProps = ESX.Game.GetVehicleProperties(vehicle) 
    ESX.TriggerServerCallback("pl_checkcarsid", function(cb)
        if cb ~= nil then 
            ESX.ShowNotification("~r~Il y a déja une plaque enregistrers au même nom.")
        else
            TriggerServerEvent("pl_insertintogarage", id, vehicleProps)
            TriggerEvent('esx:deleteVehicle') 
        end
    end, id, vehicleProps.plate)    
end

function fade()
    DoScreenFadeOut(1000) 
    Citizen.Wait(1000)
    DoScreenFadeIn(1000)
end
