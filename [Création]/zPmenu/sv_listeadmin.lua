ESX = nil

TriggerEvent('esx:getSharedObject', function(obj)
    ESX = obj
end)


Players = {}

ESX.RegisterServerCallback('kxzeriia:getPlayersInfos', function(source, cb)
	cb(Players)
end)

AddEventHandler('esx:setJob', function(playerId, job, lastJob)
	Players[playerId].job = job.name

	TriggerClientEvent('kxzeriia:updatePlayers', -1, Players)
end)

AddEventHandler('esx:playerLoaded', function(playerId, xPlayer)
	if xPlayer then
		AddPlayerToTable(xPlayer, true)
	end
end)

AddEventHandler('esx:playerDropped', function(playerId)
	Players[playerId] = nil
	
	TriggerClientEvent('kxzeriia:updatePlayers', -1, Players)
end)

AddEventHandler('onResourceStart', function(resource)
	if resource == GetCurrentResourceName() then
		Citizen.CreateThread(function()
			Citizen.Wait(1000)
			AddPlayersToTable()
		end)
	end
end)

ESX.RegisterServerCallback('kxzeriia:isAdmin', function(source, cb)
	local playerId = source
	local xPlayer = ESX.GetPlayerFromId(playerId)

	if xPlayer then
		local playergroup = xPlayer.getGroup()
		
		if playergroup == "admin" or playergroup == "superadmin" then
			cb(true)
		else
			cb(false)
		end
	end
end)


function AddPlayerToTable(xPlayer, update)
	local playerId = xPlayer.source

	Players.Count = GetNumPlayerIndices()

	Players[playerId]			 = {}
	Players[playerId].id		 = playerId

	Players[playerId].position	 = GetEntityCoords(GetPlayerPed(playerId))
	Players[playerId].heading	 = GetEntityHeading(GetPlayerPed(playerId))

	Players[playerId].steamName  = GetPlayerName(playerId)
	Players[playerId].name  	 = xPlayer.getName()

	Players[playerId].group		 = xPlayer.getGroup()
	Players[playerId].job		 = xPlayer.getJob()

	if update then
		TriggerClientEvent('kxzeriia:updatePlayers', -1, Players)
	end
end

function AddPlayersToTable()
	local players = ESX.GetPlayers()

	for i=1, #players, 1 do
		local xPlayer = ESX.GetPlayerFromId(players[i])
		AddPlayerToTable(xPlayer, false)
	end

	TriggerClientEvent('kxzeriia:updatePlayers', -1, Players)
end

ESX.RegisterServerCallback('kxzeriia:updatePlyPos', function(source, cb, id)
	cb(GetEntityCoords(GetPlayerPed(id)))
end)

ESX.RegisterServerCallback('kxzeriia_menuperso:getUsergroup', function(source, cb)
	local playerId = source
	local xPlayer = ESX.GetPlayerFromId(playerId)

	if xPlayer then
		local group = xPlayer.getGroup()
		
		cb(group)
	end
end)

RegisterServerEvent("kxzeriia:spectate")
AddEventHandler('kxzeriia:spectate', function(playerId)
	local source = source
	local xPlayer = ESX.GetPlayerFromId(source)

	if xPlayer then	
		TriggerClientEvent("kxzeriia:spectate", source, NetworkGetNetworkIdFromEntity(GetPlayerPed(playerId)), playerId, GetPlayerName(playerId))
	end
end)

local playersHealing, deadPlayers = {}, {}

RegisterServerEvent('kxzeriia:revive')
AddEventHandler('kxzeriia:revive', function(playerId)
	local xPlayer = ESX.GetPlayerFromId(source)

	if xPlayer then
		local xTarget = ESX.GetPlayerFromId(playerId)

		if xTarget then
			if deadPlayers[playerId] then
				xTarget.triggerEvent('ambujob:revive')
				deadPlayers[playerId] = nil
			else
				TriggerClientEvent('esx:showNotification', source, "La personne est déjà ~g~vivante")
			end
		else
			TriggerClientEvent('esx:showNotification', source, "La personne est hors ligne")
		end
	end
end)

RegisterServerEvent('kxzeriia:msgprive')
AddEventHandler('kxzeriia:msgprive', function(message,player)
	local nameJoueur = GetPlayerName(player)
	
	--TriggerClientEvent('esx:showNotification', source, "~b~"..nameJoueur.."~s~ a reçu votre message avec ~g~succès~s~.")
    TriggerClientEvent('esx:showAdvancedNotification', player, "Administration", "~g~Message", ""..message.."", "CHAR_DEFAULT", 1)
end)

RegisterServerEvent("kxzeriia:FreezePlayer")
AddEventHandler('kxzeriia:FreezePlayer', function(playerId, toggle)
	local source = source
	local xPlayer = ESX.GetPlayerFromId(source)

	if xPlayer then
		if toggle then
			TriggerClientEvent('esx:showNotification', source, '~b~['..playerId..'] '..GetPlayerName(playerId)..'~s~ est désormais ~g~freeze')
		else
			TriggerClientEvent('esx:showNotification', source, '~b~['..playerId..'] '..GetPlayerName(playerId)..'~s~ n\'est désormais plus ~r~freeze')
		end
		TriggerClientEvent("kxzeriia:FreezePlayer", playerId, toggle)
	end
end)

RegisterServerEvent("kxzeriia:tp")
AddEventHandler('kxzeriia:tp', function(playerId, px, py, pz)
	local source = source
	local xPlayer = ESX.GetPlayerFromId(source)

	if xPlayer then
		TriggerClientEvent("kxzeriia:RequestTp", playerId, px, py, pz)
	end
end)

RegisterServerEvent("kxzeriia:kick")
AddEventHandler("kxzeriia:kick", function(playerID, reason)
	local source = source
	local xPlayer = ESX.GetPlayerFromId(source)

	if xPlayer then
		TriggerClientEvent('esx:showNotification', source, '~b~['..playerID..'] '..GetPlayerName(playerID).."~s~ a été kick\nRaison: ~g~"..reason.."~w~")
		DropPlayer(playerID, reason)
	end
end)