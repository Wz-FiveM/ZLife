TriggerEvent("es:addGroup", "mod", "user", function(group) end)

ESX              = nil


TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
-- Modify if you want, btw the _admin_ needs to be able to target the group and it will work
local groupsRequired = {
	slay = "mod",
	noclip = "superadmin",
	crash = "superadmin",
	freeze = "mod",
	bring = "mod",
	["goto"] = "mod",
	slap = "superadmin",
	slay = "mod",
	kick = "mod",
	ban = "superadmin"
}

local banned = ""
local bannedTable = {}

function loadBans()
	banned = LoadResourceFile("es_admin2", "data/bans.txt") or ""
	if banned then
		local b = stringsplit(banned, "\n")
		for k,v in ipairs(b) do
			bannedTable[v] = true
		end
	end

	if GetConvar("es_admin2_globalbans", "0") == "1" then
		PerformHttpRequest("http://essentialmode.com/bans.txt", function(err, rText, headers)
			local b = stringsplit(rText, "\n")
			for k,v in pairs(b)do
				bannedTable[v] = true
			end
		end)
	end
end

function isBanned(id)
	return bannedTable[id]
end

function banUser(id)
	banned = banned .. id .. "\n"
	SaveResourceFile("es_admin2", "data/bans.txt", banned, -1)
	bannedTable[id] = true
end

AddEventHandler('playerConnecting', function(user, set)
	for k,v in ipairs(GetPlayerIdentifiers(source))do
		if isBanned(v) then
			set(GetConvar("es_admin_banreason", "Vous êtes banni du serveur."))
			CancelEvent()
			break
		end
	end
end)

RegisterServerEvent('es_admin:all')
AddEventHandler('es_admin:all', function(type)
	local Source = source
	TriggerEvent('es:getPlayerFromId', source, function(user)
		TriggerEvent('es:canGroupTarget', user.getGroup(), "superadmin", function(available)
			if available or user.getGroup() == "superadmin" then
				if type == "slay_all" then TriggerClientEvent('es_admin:quick', -1, 'slay') end
				if type == "bring_all" then TriggerClientEvent('es_admin:quick', -1, 'bring', Source) end
				if type == "slap_all" then TriggerClientEvent('es_admin:quick', -1, 'slap') end
			--else
				--TriggerClientEvent('chatMessage', Source, "SYSTEM", {255, 0, 0}, "You do not have permission to do this")
			end
		end)
	end)
end)

RegisterServerEvent('es_admin:quick')
AddEventHandler('es_admin:quick', function(id, type)
	local Source = source
	TriggerEvent('es:getPlayerFromId', source, function(user)
		TriggerEvent('es:getPlayerFromId', id, function(target)
			TriggerEvent('es:canGroupTarget', user.getGroup(), groupsRequired[type], function(available)
				print('Available?: ' .. tostring(available))
				TriggerEvent('es:canGroupTarget', user.getGroup(), target.getGroup(), function(canTarget)
					if canTarget and available then
						if type == "slay" then TriggerClientEvent('es_admin:quick', id, type) end
						if type == "noclip" then TriggerClientEvent('es_admin:quick', id, type) end
						if type == "freeze" then TriggerClientEvent('es_admin:quick', id, type) end
						if type == "crash" then TriggerClientEvent('es_admin:quick', id, type) end
						if type == "bring" then TriggerClientEvent('es_admin:quick', id, type, Source) end
						if type == "goto" then TriggerClientEvent('es_admin:quick', Source, type, id) end
						if type == "slap" then TriggerClientEvent('es_admin:quick', id, type) end
						if type == "slay" then TriggerClientEvent('es_admin:quick', id, type) end
						if type == "kick" then DropPlayer(id, 'Kicked by es_admin GUI') end
					
						if type == "ban" then
							for k,v in ipairs(GetPlayerIdentifiers(id))do
								banUser(v)
							end
							DropPlayer(id, GetConvar("es_admin_banreason", "Vous êtes banni du serveur."))
						end
					else
						if not available then
							TriggerClientEvent('chatMessage', Source, 'Staff', {255, 0, 0}, "Vous ne pouvez pas executer cette commande.")
						else
							TriggerClientEvent('chatMessage', Source, 'Staff', {255, 0, 0}, "Vous n'avez pas les bonne persmissions.")
						end
					end
				end)
			end)
		end)
	end)
end)

AddEventHandler('es:playerLoaded', function(Source, user)
	TriggerClientEvent('es_admin:setGroup', Source, user.getGroup())
end)

RegisterServerEvent('es_admin:set')
AddEventHandler('es_admin:set', function(t, USER, GROUP)
	local Source = source
	TriggerEvent('es:getPlayerFromId', source, function(user)
		TriggerEvent('es:canGroupTarget', user.getGroup(), "admin", function(available)
			if available then
			if t == "group" then
				if(GetPlayerName(USER) == nil)then
					TriggerClientEvent('chatMessage', source, 'Staff', {255, 0, 0}, "Aucun joueur trouvé")
				else
					TriggerEvent("es:getAllGroups", function(groups)
						if(groups[GROUP])then
							TriggerEvent("es:setPlayerData", USER, "group", GROUP, function(response, success)
								TriggerClientEvent('es_admin:setGroup', USER, GROUP)
								--TriggerClientEvent('chatMessage', -1, "CONSOLE", {0, 0, 0}, "Group of ^2^*" .. GetPlayerName(tonumber(USER)) .. "^r^0 has been set to ^2^*" .. GROUP)
							end)
						--else
							--TriggerClientEvent('chatMessage', source, 'SYSTEM', {255, 0, 0}, "Group not found")
						end
					end)
				end
			elseif t == "level" then
				if(GetPlayerName(USER) == nil)then
					TriggerClientEvent('chatMessage', source, 'Staff', {255, 0, 0}, "Aucun joueur trouvé")
				else
					GROUP = tonumber(GROUP)
					if(GROUP ~= nil and GROUP > -1)then
						TriggerEvent("es:setPlayerData", USER, "permission_level", GROUP, function(response, success)
							if(true)then
								--TriggerClientEvent('chatMessage', -1, "CONSOLE", {0, 0, 0}, "Permission level of ^2" .. GetPlayerName(tonumber(USER)) .. "^0 has been set to ^2 " .. tostring(GROUP))
							end
						end)	
					--else
						--TriggerClientEvent('chatMessage', source, 'SYSTEM', {255, 0, 0}, "Invalid integer entered")
					end
				end
			elseif t == "money" then
				if(GetPlayerName(USER) == nil)then
					TriggerClientEvent('chatMessage', source, 'Staff', {255, 0, 0}, "Aucun joueur trouvé")
				else
					GROUP = tonumber(GROUP)
					if(GROUP ~= nil and GROUP > -1)then
						TriggerEvent('es:getPlayerFromId', USER, function(target)
							target.setMoney(GROUP)
						end)
					--else
						--TriggerClientEvent('chatMessage', source, 'SYSTEM', {255, 0, 0}, "Invalid integer entered")
					end
				end
			elseif t == "bank" then
				if(GetPlayerName(USER) == nil)then
					TriggerClientEvent('chatMessage', source, 'Staff', {255, 0, 0}, "Aucun joueur trouvé")
				else
					GROUP = tonumber(GROUP)
					if(GROUP ~= nil and GROUP > -1)then
						TriggerEvent('es:getPlayerFromId', USER, function(target)
							target.setBankBalance(GROUP)
						end)
					else
						--TriggerClientEvent('chatMessage', source, 'SYSTEM', {255, 0, 0}, "Invalid integer entered")
					end
				end
			end
			--else
				--TriggerClientEvent('chatMessage', source, 'SYSTEM', {255, 0, 0}, "superadmin required to do this")
			end
		end)
	end)	
end)

-- Rcon commands
AddEventHandler('rconCommand', function(commandName, args)
	if commandName == 'setadmin' then
		if #args ~= 2 then
				RconPrint("Usage: setadmin [user-id] [permission-level]\n")
				CancelEvent()
				return
		end

		if(GetPlayerName(tonumber(args[1])) == nil)then
			RconPrint("Player not ingame\n")
			CancelEvent()
			return
		end

		TriggerEvent("es:setPlayerData", tonumber(args[1]), "permission_level", tonumber(args[2]), function(response, success)
			RconPrint(response)

			if(true)then
				print(args[1] .. " " .. args[2])
				TriggerClientEvent('es:setPlayerDecorator', tonumber(args[1]), 'rank', tonumber(args[2]), true)
				--TriggerClientEvent('chatMessage', -1, "CONSOLE", {0, 0, 0}, "Permission level of ^2" .. GetPlayerName(tonumber(args[1])) .. "^0 has been set to ^2 " .. args[2])
			end
		end)

		CancelEvent()
	elseif commandName == 'setgroup' then
		if #args ~= 2 then
				RconPrint("Usage: setgroup [user-id] [group]\n")
				CancelEvent()
				return
		end

		if(GetPlayerName(tonumber(args[1])) == nil)then
			RconPrint("Player not ingame\n")
			CancelEvent()
			return
		end

		TriggerEvent("es:getAllGroups", function(groups)

			if(groups[args[2]])then
				TriggerEvent("es:setPlayerData", tonumber(args[1]), "group", args[2], function(response, success)

					if(true)then
						TriggerClientEvent('es:setPlayerDecorator', tonumber(args[1]), 'group', tonumber(args[2]), true)
						--TriggerClientEvent('chatMessage', -1, "CONSOLE", {0, 0, 0}, "Group of ^2^*" .. GetPlayerName(tonumber(args[1])) .. "^r^0 has been set to ^2^*" .. args[2])
					end
				end)
			else
				RconPrint("This group does not exist.\n")
			end
		end)

		CancelEvent()
	elseif commandName == 'giverole' then
		if #args < 2 then
				RconPrint("Usage: giverole [user-id] [role]\n")
				CancelEvent()
				return
		end

		if(GetPlayerName(tonumber(args[1])) == nil)then
			RconPrint("Player not ingame\n")
			CancelEvent()
			return
		end

			TriggerEvent("es:getPlayerFromId", tonumber(args[1]), function(user)
				table.remove(args, 1)
				user.giveRole(table.concat(args, " "))
				--TriggerClientEvent("chatMessage", user.get('source'), "SYSTEM", {255, 0, 0}, "You've been given a role: ^2" .. table.concat(args, " "))
			end)

		CancelEvent()
	elseif commandName == 'removerole' then
		if #args < 2 then
				RconPrint("Usage: removerole [user-id] [role]\n")
				CancelEvent()
				return
		end

		if(GetPlayerName(tonumber(args[1])) == nil)then
			RconPrint("Player not ingame\n")
			CancelEvent()
			return
		end

			TriggerEvent("es:getPlayerFromId", tonumber(args[1]), function(user)
				table.remove(args, 1)
				user.removeRole(table.concat(args, " "))
				--TriggerClientEvent("chatMessage", user.get('source'), "SYSTEM", {255, 0, 0}, "A role was removed: ^2" .. table.concat(args, " "))
			end)

		CancelEvent()
	elseif commandName == 'setmoney' then
			if #args ~= 2 then
					RconPrint("Usage: setmoney [user-id] [money]\n")
					CancelEvent()
					return
			end

			if(GetPlayerName(tonumber(args[1])) == nil)then
				RconPrint("Player not ingame\n")
				CancelEvent()
				return
			end

			TriggerEvent("es:getPlayerFromId", tonumber(args[1]), function(user)
				if(user)then
					user.setMoney(tonumber(args[2]))

					RconPrint("Money set")
					--TriggerClientEvent('chatMessage', tonumber(args[1]), "CONSOLE", {0, 0, 0}, "Your money has been set to: ^2^*$" .. tonumber(args[2]))
				end
			end)

			CancelEvent()
		end
end)

-- Default commands
--[[ TriggerEvent('es:addCommand', 'report', function(source, args, user)
	TriggerClientEvent('chatMessage', source, "(REPORT) ", {255, 0, 0}, " [^2" .. GetPlayerName(source) .." - "..source.."^0] " .. table.concat(args, " "))

	TriggerEvent("es:getPlayers", function(pl)
		for k,v in pairs(pl) do
			TriggerEvent("es:getPlayerFromId", k, function(user)
				if(user.getPermissions() > 0 and k ~= source)then
					TriggerClientEvent('chatMessage', k, "(REPORT) ", {255, 0, 0}, " [^2" .. GetPlayerName(source) .." - "..source.."^0] " .. table.concat(args, " "))
				end
			end)
		end
	end)
end, {help = "Report a player or an issue", params = {{name = "report", help = "What you want to report"}}}) ]]

-- Kicking
TriggerEvent('es:addGroupCommand', 'kick', "mod", function(source, args, user)
	if args[1] then
		if(GetPlayerName(tonumber(args[1])))then
			local player = tonumber(args[1])

			-- User permission check
			TriggerEvent("es:getPlayerFromId", player, function(target)

				local reason = args
				table.remove(reason, 1)
				if(#reason == 0)then
					reason = "Kick: Vous avez été Kick du serveur."
				else
					reason = "Kick: " .. table.concat(reason, " ")
				end

				--TriggerClientEvent('chatMessage', -1, "SYSTEM", {255, 0, 0}, "Player ^2" .. GetPlayerName(player) .. "^0 has been kicked(^2" .. reason .. "^0)")
				DropPlayer(player, reason)
			end)
		else
			TriggerClientEvent('chatMessage', source, "Staff", {255, 0, 0}, "ID Incorrect")
		end
	else
		TriggerClientEvent('chatMessage', source, "Staff", {255, 0, 0}, "ID Incorrect")
	end
end, function(source, args, user)
	TriggerClientEvent('chatMessage', source, "Staff", {255, 0, 0}, "Mauvaises permissions")
end, {help = "Kick a user with the specified reason or no reason", params = {{name = "userid", help = "The ID of the player"}, {name = "reason", help = "The reason as to why you kick this player"}}})

-- Announcing
TriggerEvent('es:addGroupCommand', 'annonce', "mod", function(source, args, user)
	TriggerClientEvent('chatMessage', -1, "ZLife", {0, 102, 104}, "" .. table.concat(args, " "))
end, function(source, args, user)
	TriggerClientEvent('chatMessage', source, "Staff", {255, 0, 0}, "Mauvaises permissions")
end, {help = "Le message de l'annonce", params = {{name = "Message", help = "Le message de l'annonce"}}})

TriggerEvent('es:addGroupCommand', 'annoncejob', "user", function(source, args, user)
	local _source = source
	local xPlayer = ESX.GetPlayerFromId(source)
	if xPlayer.getMoney() >= 500 then 
		xPlayer.removeMoney(500)
		TriggerClientEvent('chatMessage', -1, "Publicité", {0, 240, 0}, "" .. table.concat(args, " "))
		else
			TriggerClientEvent('esx:showNotification', source, "~r~Vous n'avez pas assez d'argent.")
		end
end, function(source, args, user)
	TriggerClientEvent('chatMessage', source, "Staff", {255, 0, 0}, "Mauvaises permissions")
end, {help = "Message (500$)", params = {{name = "Message", help = "Message (500$)"}}})


-- Freezing
local frozen = {}
TriggerEvent('es:addGroupCommand', 'freeze', "mod", function(source, args, user)
	if args[1] then
		if(GetPlayerName(tonumber(args[1])))then
			local player = tonumber(args[1])

			-- User permission check
			TriggerEvent("es:getPlayerFromId", player, function(target)

				if(frozen[player])then
					frozen[player] = false
				else
					frozen[player] = true
				end

				TriggerClientEvent('es_admin:freezePlayer', player, frozen[player])

				local state = "dé-freeze"
				if(frozen[player])then
					state = "freeze"
				end

				TriggerClientEvent('chatMessage', player, "Staff", {255, 0, 0}, "Vous êtes " .. state .. "")
				--TriggerClientEvent('chatMessage', source, "SYSTEM", {255, 0, 0}, "Player ^2" .. GetPlayerName(player) .. "^0 has been " .. state)
			end)
		else
			TriggerClientEvent('chatMessage', source, "Staff", {255, 0, 0}, "ID Incorrect")
		end
	else
		TriggerClientEvent('chatMessage', source, "Staff", {255, 0, 0}, "ID Incorrect")
	end
end, function(source, args, user)
	TriggerClientEvent('chatMessage', source, "Staff", {255, 0, 0}, "Mauvaises permissions")
end, {help = "Freeze or unfreeze a user", params = {{name = "userid", help = "The ID of the player"}}})

-- Bring
local frozen = {}
TriggerEvent('es:addGroupCommand', 'bring', "mod", function(source, args, user)
	if args[1] then
		if(GetPlayerName(tonumber(args[1])))then
			local player = tonumber(args[1])

			-- User permission check
			TriggerEvent("es:getPlayerFromId", player, function(target)

				TriggerClientEvent('es_admin:teleportUser', target.get('source'), user.getCoords().x, user.getCoords().y, user.getCoords().z)

				TriggerClientEvent('chatMessage', player, "Staff", {255, 0, 0}, "Vous avez été téléporté par ^2" .. GetPlayerName(source))
				--TriggerClientEvent('chatMessage', source, "SYSTEM", {255, 0, 0}, "Player ^2" .. GetPlayerName(player) .. "^0 has been brought")
			end)
		else
			TriggerClientEvent('chatMessage', source, "Staff", {255, 0, 0}, "ID Incorrect")
		end
	else
		TriggerClientEvent('chatMessage', source, "Staff", {255, 0, 0}, "ID Incorrect")
	end
end, function(source, args, user)
	TriggerClientEvent('chatMessage', source, "Staff", {255, 0, 0}, "Mauvaises permissions")
end, {help = "Teleport a user to you", params = {{name = "userid", help = "The ID of the player"}}})

-- Bring
local frozen = {}
TriggerEvent('es:addGroupCommand', 'slap', "admin", function(source, args, user)
	if args[1] then
		if(GetPlayerName(tonumber(args[1])))then
			local player = tonumber(args[1])

			-- User permission check
			TriggerEvent("es:getPlayerFromId", player, function(target)

				TriggerClientEvent('es_admin:slap', player)

				--TriggerClientEvent('chatMessage', player, "SYSTEM", {255, 0, 0}, "You have slapped by ^2" .. GetPlayerName(source))
				--TriggerClientEvent('chatMessage', source, "SYSTEM", {255, 0, 0}, "Player ^2" .. GetPlayerName(player) .. "^0 has been slapped")
			end)
		else
			TriggerClientEvent('chatMessage', source, "Staff", {255, 0, 0}, "ID Incorrect")
		end
	else
		TriggerClientEvent('chatMessage', source, "Staff", {255, 0, 0}, "ID Incorrect")
	end
end, function(source, args, user)
	TriggerClientEvent('chatMessage', source, "Staff", {255, 0, 0}, "Mauvaises permissions")
end, {help = "Slap a user", params = {{name = "userid", help = "The ID of the player"}}})

-- Freezing
local frozen = {}
TriggerEvent('es:addGroupCommand', 'goto', "mod", function(source, args, user)
	if args[1] then
		if(GetPlayerName(tonumber(args[1])))then
			local player = tonumber(args[1])

			-- User permission check
			TriggerEvent("es:getPlayerFromId", player, function(target)
				if(target)then

					TriggerClientEvent('es_admin:teleportUser', source, target.getCoords().x, target.getCoords().y, target.getCoords().z)

					--TriggerClientEvent('chatMessage', player, "SYSTEM", {255, 0, 0}, "You have been teleported to by ^2" .. GetPlayerName(source))
					--TriggerClientEvent('chatMessage', source, "SYSTEM", {255, 0, 0}, "Teleported to player ^2" .. GetPlayerName(player) .. "")
				end
			end)
		else
			TriggerClientEvent('chatMessage', source, "Staff", {255, 0, 0}, "ID Incorrect")
		end
	else
		TriggerClientEvent('chatMessage', source, "Staff", {255, 0, 0}, "ID Incorrect")
	end
end, function(source, args, user)
	TriggerClientEvent('chatMessage', source, "Staff", {255, 0, 0}, "Mauvaises permissions")
end, {help = "Teleport to a user", params = {{name = "userid", help = "The ID of the player"}}})

-- Killing
TriggerEvent('es:addGroupCommand', 'slay', "admin", function(source, args, user)
	if args[1] then
		if(GetPlayerName(tonumber(args[1])))then
			local player = tonumber(args[1])

			-- User permission check
			TriggerEvent("es:getPlayerFromId", player, function(target)

				TriggerClientEvent('es_admin:kill', player)

				--TriggerClientEvent('chatMessage', player, "SYSTEM", {255, 0, 0}, "You have been killed by ^2" .. GetPlayerName(source))
				--TriggerClientEvent('chatMessage', source, "SYSTEM", {255, 0, 0}, "Player ^2" .. GetPlayerName(player) .. "^0 has been killed.")
			end)
		else
			TriggerClientEvent('chatMessage', source, "Staff", {255, 0, 0}, "ID Incorrect")
		end
	else
		TriggerClientEvent('chatMessage', source, "Staff", {255, 0, 0}, "ID Incorrect")
	end
end, function(source, args, user)
	TriggerClientEvent('chatMessage', source, "Staff", {255, 0, 0}, "Mauvaises permissions")
end, {help = "Slay a user", params = {{name = "userid", help = "The ID of the player"}}})

-- Crashing
TriggerEvent('es:addGroupCommand', 'crash', "superadmin", function(source, args, user)
	if args[1] then
		if(GetPlayerName(tonumber(args[1])))then
			local player = tonumber(args[1])

			-- User permission check
			TriggerEvent("es:getPlayerFromId", player, function(target)

				TriggerClientEvent('es_admin:crash', player)

				--TriggerClientEvent('chatMessage', source, "SYSTEM", {255, 0, 0}, "Player ^2" .. GetPlayerName(player) .. "^0 has been crashed.")
			end)
		else
			TriggerClientEvent('chatMessage', source, "Staff", {255, 0, 0}, "ID Incorrect")
		end
	else
		TriggerClientEvent('chatMessage', source, "Staff", {255, 0, 0}, "ID Incorrect")
	end
end, function(source, args, user)
	TriggerClientEvent('chatMessage', source, "Staff", {255, 0, 0}, "Mauvaises permissions")
end, {help = "Crash a user, no idea why this still exists", params = {{name = "userid", help = "The ID of the player"}}})


function stringsplit(inputstr, sep)
	if sep == nil then
		sep = "%s"
	end
	local t={} ; i=1
	for str in string.gmatch(inputstr, "([^"..sep.."]+)") do
		t[i] = str
		i = i + 1
	end
	return t
end

loadBans()