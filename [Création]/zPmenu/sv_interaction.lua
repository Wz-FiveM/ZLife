ESX = nil

TriggerEvent('esx:getSharedObject', function(obj)
    ESX = obj
end)

RegisterServerEvent('clp_interact:drag')
AddEventHandler('clp_interact:drag', function(target)
	local xPlayer = ESX.GetPlayerFromId(source)

	TriggerClientEvent('clp_interact:drag', target, source)
end)

RegisterServerEvent('c_interaction:putInVehicle')
AddEventHandler('c_interaction:putInVehicle', function(target)
    TriggerClientEvent('c_interaction:putInVehicle', target)
end)

RegisterServerEvent('c_interaction:mettrecoffre')
AddEventHandler('c_interaction:mettrecoffre', function(target)
    TriggerClientEvent('c_interaction:mettrecoffre', target)
end)

RegisterServerEvent('c_interaction:outOfVehicle')
AddEventHandler('c_interaction:outOfVehicle', function(target)
    TriggerClientEvent('c_interaction:outOfVehicle', target)
end)