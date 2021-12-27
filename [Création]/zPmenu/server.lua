-- notWhitelisted = "Vous n'êtes pas whitelist sur ce serveur. discord.gg/84eb9eS" -- Message displayed when they are not whitelist with the role
-- noDiscord = "Le serveur n'a pas réussi à trouver votre discord (Essayé de redémarer votre FiveM + Discord)." -- Message displayed when discord is not found

-- roles = {
-- 	--"Offline",
-- 	"Whitelist",
-- }

-- AddEventHandler("playerConnecting", function(name, setCallback, deferrals)
--     local src = source
--     deferrals.defer()
--     deferrals.update("Vérification..")

--     for k, v in ipairs(GetPlayerIdentifiers(src)) do
--         if string.sub(v, 1, string.len("discord:")) == "discord:" then
--             identifierDiscord = v
--         end
--     end

--     if identifierDiscord then
--         for i = 1, #roles do
--             if IsRolePresent(src, roles[i]) then
--                 deferrals.done()
--             else
--                 deferrals.done(notWhitelisted)
--             end
--         end
--     else
--         deferrals.done(noDiscord)
--     end
-- end)

-- local FormattedToken = "Bot "..Config.DiscordToken

-- function DiscordRequest(method, endpoint, jsondata)
--     local data = nil
--     PerformHttpRequest("https://discordapp.com/api/"..endpoint, function(errorCode, resultData, resultHeaders)
-- 		data = {data=resultData, code=errorCode, headers=resultHeaders}
--     end, method, #jsondata > 0 and json.encode(jsondata) or "", {["Content-Type"] = "application/json", ["Authorization"] = FormattedToken})

--     while data == nil do
--         Citizen.Wait(0)
--     end
	
--     return data
-- end

-- function GetRoles(user)
-- 	local discordId = nil
-- 	for _, id in ipairs(GetPlayerIdentifiers(user)) do
-- 		if string.match(id, "discord:") then
-- 			discordId = string.gsub(id, "discord:", "")
-- 			--print("Found discord id: "..discordId)
-- 			break
-- 		end
-- 	end

-- 	if discordId then
-- 		local endpoint = ("guilds/%s/members/%s"):format(Config.GuildId, discordId)
-- 		local member = DiscordRequest("GET", endpoint, {})
-- 		if member.code == 200 then
-- 			local data = json.decode(member.data)
-- 			local roles = data.roles
-- 			local found = true
-- 			return roles
-- 		else
-- 			--print("An error occured, maybe they arent in the discord? Error: "..member.data)
-- 			return false
-- 		end
-- 	else
-- 		--print("missing identifier")
-- 		return false
-- 	end
-- end

-- function IsRolePresent(user, role)
-- 	local discordId = nil
-- 	for _, id in ipairs(GetPlayerIdentifiers(user)) do
-- 		if string.match(id, "discord:") then
-- 			discordId = string.gsub(id, "discord:", "")
-- 			--print("Found discord id: "..discordId)
-- 			break
-- 		end
-- 	end

-- 	local theRole = nil
-- 	if type(role) == "number" then
-- 		theRole = tostring(role)
-- 	else
-- 		theRole = Config.Roles[role]
-- 	end

-- 	if discordId then
-- 		local endpoint = ("guilds/%s/members/%s"):format(Config.GuildId, discordId)
-- 		local member = DiscordRequest("GET", endpoint, {})
-- 		if member.code == 200 then
-- 			local data = json.decode(member.data)
-- 			local roles = data.roles
-- 			local found = true
-- 			for i=1, #roles do
-- 				if roles[i] == theRole then
-- 					--print("Found role")
-- 					return true
-- 				end
-- 			end
-- 			--print("Not found!")
-- 			return false
-- 		else
-- 			--print("An error occured, maybe they arent in the discord? Error: "..member.data)
-- 			return false
-- 		end
-- 	else
-- 		--print("missing identifier")
-- 		return false
-- 	end
-- end

-- Citizen.CreateThread(function()
-- 	local guild = DiscordRequest("GET", "guilds/"..Config.GuildId, {})
-- 	if guild.code == 200 then
-- 		local data = json.decode(guild.data)
-- 		print("Permission system guild set to: "..data.name.." ("..data.id..")")
-- 	else
-- 		print("An error occured, please check your config and ensure everything is correct. Error: "..(guild.data or guild.code)) 
-- 	end
-- end)
