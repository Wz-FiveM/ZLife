ESX = nil

Citizen.CreateThread(function()
    while ESX == nil do
        TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
        Citizen.Wait(0)
	end

end)


RMenu.Add('pGarage', 'main', RageUI.CreateMenu("Garage personnel", ""))
RMenu:Get('pGarage', 'main'):SetSubtitle("Liste de vos véhicules")
RMenu:Get('pGarage', 'main').EnableMouse = false
RMenu:Get('pGarage', 'main').Closed = function()


end;

local GarageData = {}

function RecupGarageId(id)
    TriggerServerEvent("pPublipGarage:GetVehicles", id)
end

RegisterNetEvent("pPublipGarage:GetVehicles")
AddEventHandler("pPublipGarage:GetVehicles", function(data)
    GarageData = data
end)

function SetFuel(vehicle, fuel)
	if type(fuel) == 'number' and fuel >= 0 and fuel <= 100 then
		SetVehicleFuelLevel(vehicle, fuel + 0.0)
		DecorSetFloat(vehicle, "_FUEL_LEVEL", GetVehicleFuelLevel(vehicle))
    end
end

local function Collision(veh)
    FreezeEntityPosition(veh, 1)
    SetEntityNoCollisionEntity(veh, 0, false)
    SetEntityAlpha(veh, 150, 150)
    SetEntityCollision(veh, 0, 0)
    Wait(1500)

    local AllVeh = GetVehicles()
    for k,v in pairs(AllVeh) do
        local pPed = GetPlayerPed(-1)
        pVeh = GetVehiclePedIsIn(pPed, false)
        SetEntityNoCollisionEntity(pVeh, v, true)
        SetEntityNoCollisionEntity(v, pVeh, true)
        SetEntityCollision(v, 1, 1)
        FreezeEntityPosition(pVeh, 0)
        ResetEntityAlpha(v)
    end
    PlaySoundFrontend(-1, "OPENING", "MP_PROPERTIES_ELEVATOR_DOORS", 0)
	PlaySoundFrontend(-1, "OPENED", "DOOR_GARAGE", 0)
end

local function ApplyDamage(veh,engineHealth,bodyhealth,fuelhealth,petrolcanhealth)
    SetVehicleFuelLevel(veh,fuelhealth)
    SetVehicleDoorsLocked(veh, 1)
    SetVehicleDoorsLockedForAllPlayers(veh, false)
    SetEntityAsMissionEntity(veh,true,true)
    SetVehicleHasBeenOwnedByPlayer(veh,true)
    PlaySoundFrontend(-1, "HIT_OUT", "PLAYER_SWITCH_CUSTOM_SOUNDSET", 0)
    if engineHealth <= 900 then 
        TriggerServerEvent("clp_car:removemoneyengine", 20)
    elseif engineHealth <= 800 then 
        TriggerServerEvent("clp_car:removemoneyengine", 30)
    elseif engineHealth <= 700 then 
        TriggerServerEvent("clp_car:removemoneyengine", 40)
    elseif engineHealth <= 600 then 
        TriggerServerEvent("clp_car:removemoneyengine", 50)
    elseif engineHealth <= 500 then 
        TriggerServerEvent("clp_car:removemoneyengine", 70)
    elseif engineHealth <= 400 then 
        TriggerServerEvent("clp_car:removemoneyengine", 85)
    elseif engineHealth <= 300 then 
        TriggerServerEvent("clp_car:removemoneyengine", 100)
    elseif engineHealth <= 200 then 
        TriggerServerEvent("clp_car:removemoneyengine", 125)
    elseif engineHealth <= 100 then 
        TriggerServerEvent("clp_car:removemoneyengine", 150)
    end
end

RageUI.CreateWhile(1.0, true, function()
    if RageUI.Visible(RMenu:Get('pGarage', 'main')) then 
        RageUI.DrawContent({ header = true, glare = true, instructionalButton = true}, function()
                for k,v in pairs(GarageData) do 
                    RageUI.Button(GetLabelText(GetDisplayNameFromVehicleModel(v.props.model)), nil, { RightLabel = "Plaque : "..v.props.plate}, true, function(_, _, Selected)
                        local pCoords = GetEntityCoords(GetPlayerPed(-1))
                        if (Selected) then 
                            if not IsAnyVehicleNearPoint(pCoords ,5.0) then 
                                TriggerServerEvent("pPublipGarage:RetireVehicule", v.props.plate)
                                TriggerServerEvent('esx_advancedgarage:setVehicleState', v.props.plate, false)
                                if v.props.model ~= nil then 
                                    local props = ESX.Game.GetVehicleProperties(vehicule)
                                    local vehicle = GetVehiclePedIsIn(GetPlayerPed(-1), false)
                                    RequestModel(v.props.model)
                                    while not HasModelLoaded(v.props.model) do Wait(10) end 
                                    local veh = CreateVehicle(v.props.model, GetEntityCoords(GetPlayerPed(-1)), GetEntityHeading(GetPlayerPed(-1)), 1, 0)
                                    ESX.Game.SetVehicleProperties(veh, v.props)
                                    TaskWarpPedIntoVehicle(GetPlayerPed(-1), veh, -1)
                                    SetVehRadioStation(veh, "OFF")

                                    Collision(veh)
                                    Wait(1000)
                                    ApplyDamage(veh, v.engineHealth, v.bodyhealth, v.fuelhealth, v.petrolcanhealth)
                                    TriggerEvent('persistent-vehicles/register-vehicle', veh)
                                    RageUI.CloseAll()
                                end
                            else 
                                ESX.ShowNotification("Vous ne pouvez pas sortir le véhicule du garage.\n~r~Il y a un véhicule devant l'entrée.")
                            end
                        end
                    end)
                end
        end, function()
        end)
    end
end, 1)

function RangerVeh(id, engineHealth, bodyhealth, fuelhealth, petrolcanhealth)
    local playerPed = GetPlayerPed(-1)
    local vehicle = GetVehiclePedIsIn(playerPed, false)
    local props = ESX.Game.GetVehicleProperties(vehicle)
    local current = GetPlayersLastVehicle(GetPlayerPed(-1), true)
    local engineHealth = GetVehicleEngineHealth(vehicle)
    local bodyhealth = GetVehicleBodyHealth(vehicle)
    local fuelhealth = GetVehicleFuelLevel(vehicle)
    local petrolcanhealth = GetVehiclePetrolTankHealth(vehicle)

    if IsPedInAnyVehicle(GetPlayerPed(-1), true) and GetPedInVehicleSeat(vehicle, -1) == playerPed then 
        TriggerEvent('persistent-vehicles/forget-vehicle', vehicle)
        Wait(50)
        SetEntityAsMissionEntity(vehicle)
        DeleteEntity(vehicle)
        TriggerServerEvent("pPublipGarage:SaveVehicule", id, props, engineHealth, bodyhealth, fuelhealth, petrolcanhealth)
        TriggerServerEvent('esx_advancedgarage:setVehicleState', props.plate, true)
        ESX.ShowNotification("~g~Vous avez rangé le véhicule.")
    end
end