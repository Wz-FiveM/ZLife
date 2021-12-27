ESX = nil

TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

local GarageData = {}


Citizen.CreateThread(function()
    RecupGarage()
end)


function UpdateGarage()
    SaveResourceFile(GetCurrentResourceName(), "garageproperties.json", json.encode(GarageData))
    Wait(50)
    RecupGarage()
end

function SaveVehicleGarage(_id, _props, _engineHealth, _bodyhealth, _fuelhealth, _petrolcanhealth)
    table.insert(GarageData, {id = _id, props = _props, engineHealth = _engineHealth, bodyhealth = _bodyhealth, fuelhealth = _fuelhealth, petrolcanhealth = _petrolcanhealth})

    SaveResourceFile(GetCurrentResourceName(), "garageproperties.json", json.encode(GarageData))
    UpdateGarage()
end

RegisterServerEvent('clp_car:removemoneyengine')
AddEventHandler('clp_car:removemoneyengine', function(price)
	local xPlayer = ESX.GetPlayerFromId(source)
	xPlayer.removeMoney(price)
	TriggerClientEvent('esx:showNotification', source, "Vous avez payé ~b~"..price.."$~s~ car votre moteur était abimé.")
end)

function RetireVehicleGarage(plaque)
    for k,v in pairs(GarageData) do 
        if v.props.plate == plaque then 
            table.remove(GarageData, k)
        end
    end
    UpdateGarage()
end

function RecupGarage()
    local data = LoadResourceFile(GetCurrentResourceName(), "garageproperties.json")
    GarageData = json.decode(data)
end

RegisterNetEvent("pPublipGarage:SaveVehicule")
AddEventHandler("pPublipGarage:SaveVehicule", function(id, props, engineHealth, bodyhealth, fuelhealth, petrolcanhealth)
    SaveVehicleGarage(id, props, engineHealth, bodyhealth, fuelhealth, petrolcanhealth)
end)

RegisterNetEvent("pPublipGarage:RetireVehicule")
AddEventHandler("pPublipGarage:RetireVehicule", function(plaque)
    RetireVehicleGarage(plaque)
end)

RegisterNetEvent("pPublipGarage:GetVehicles")
AddEventHandler("pPublipGarage:GetVehicles", function(id)
    local data = {}
    for k,v in pairs(GarageData) do
        if v.id == id then 
            table.insert(data, v)
        end
    end
    TriggerClientEvent("pPublipGarage:GetVehicles", source, data)
end)
