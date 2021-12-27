RegisterServerEvent('cAdmin:PlayerEvent')
AddEventHandler("cAdmin:PlayerEvent",function(name, source, r, a, b, c)
    TriggerClientEvent(name, source, r, a, b, c)
end)

RegisterServerEvent("cAdmin:KickPlayer")
AddEventHandler("cAdmin:KickPlayer", function(player, reason)
    DropPlayer(player, reason)
end)

ESX = nil
TriggerEvent("esx:getSharedObject", function(result)
    ESX = result
end)

ESX.RegisterServerCallback('cAdmin:GetBan', function(source, cb, f)
    MySQL.Async.fetchAll("SELECT * FROM blacklist", {}, function(result)
        cb(result)
    end)
end)

ESX.RegisterServerCallback('cAdmin:GetGroup', function(source, cb)
	local xPlayer = ESX.GetPlayerFromId(source)

	if xPlayer ~= nil then
		local playerGroup = xPlayer.getGroup()

        if playerGroup ~= nil then 
            cb(playerGroup)
        else
            cb(nil)
        end
	else
		cb(nil)
	end
end)

local function ExtractIdentifiers(src)
    local identifiers = {
        steam = "",
        ip = "",
        discord = "",
        license = "",
        xbl = "",
        live = ""
    }

    for i = 0, GetNumPlayerIdentifiers(src) - 1 do
        local id = GetPlayerIdentifier(src, i)

        if string.find(id, "steam") then
            identifiers.steam = id
        elseif string.find(id, "ip") then
            identifiers.ip = id
        elseif string.find(id, "discord") then
            identifiers.discord = id
        elseif string.find(id, "license") then
            identifiers.license = id
        elseif string.find(id, "xbl") then
            identifiers.xbl = id
        elseif string.find(id, "live") then
            identifiers.live = id
        end
    end

    return identifiers
end

RegisterServerEvent("cAdmin:DeleteBan")
AddEventHandler("cAdmin:DeleteBan", function(banId, name)
    local _source = source
    local xPlayer = ESX.GetPlayerFromId(_source)
    MySQL.Async.execute('DELETE FROM blacklist WHERE id = @id', {
        ['@id'] = banId
    }, function(rowsChanged)
        TriggerClientEvent('esx:showNotification', xPlayer.source, "~r~Vous venez de révoquer le bannissement de: ~b~" .. name .. "~r~.")
    end)
end)

RegisterServerEvent("cAdmin:Ban")
AddEventHandler("cAdmin:Ban", function(player, raison, pName)
    if not raison then
        raison = "Aucune raison"
    end
    local time = os.date()
    local IDS = ExtractIdentifiers(player)
    local SteamDec = tostring(tonumber(IDS.steam:gsub("steam:", ""), 16));
    local Type = Type2 or "false"
    local Other = Other2 or "false"
    local token = {}
    token[IDS.discord] = {}

    for i = 0, GetNumPlayerTokens(player) do 
        table.insert(token[IDS.discord], GetPlayerToken(player, i))
    end

    MySQL.Async.execute("INSERT INTO blacklist (Steam, SteamLink, SteamName, DiscordUID, DiscordTag, GameLicense, ip, xbl, live, BanType, Other, Date, Banner, Token) VALUES ('" .. IDS.steam .. "', '" .. "https://steamcommunity.com/profiles/" .. SteamDec .. "', '" .. GetPlayerName(player) .. "', '" .. IDS.discord .. "', '<@" .. IDS.discord:gsub('discord:', '') .. ">', '" .. IDS.license .. "', '".. IDS.ip .."', '".. IDS.xbl .."', '".. IDS.live .."', 'Modérateur', '" .. raison .. "', '" .. time .. "', '"..pName.."', '"..json.encode(token[IDS.discord]).."');", {}, function()
        DropPlayer(player, 'A component of your computer is preventing you from being able to play FiveM.\nPlease wait out your original ban (expiring in 21 days + 23:59:55) to be able to play FiveM.\nThe associated correlation ID is 78e546-cgh8j-478Jd-c832-dax9246_01cd.')
    end)
    ActualizebanList()
end)

function SearchBDDBan(source, target)
    if target ~= "" then
        MySQL.Async.fetchAll('SELECT * FROM baninfo WHERE playername like @playername',
        {
            ['@playername'] = ("%"..target.."%")
        }, function(data)
            if data[1] then
                if #data < 50 then
                    for i=1, #data, 1 do
                        TriggerClientEvent('esx:showNotification', source, "Id: ~b~"..data[i].id.." ~s~Nom: ~b~"..data[i].playername)
                    end
                else
                    TriggerClientEvent('esx:showNotification', source, "~r~Trop de résultats, veillez être plus précis.")
                end
            else
                TriggerClientEvent('esx:showNotification', source, "~r~Le nom n'est pas valide.")
            end
        end)
    else
        TriggerClientEvent('esx:showNotification', source, "~r~Le nom n'est pas valide.")
    end
end

RegisterServerEvent('cAdmin:SearchBanOffline')
AddEventHandler('cAdmin:SearchBanOffline', function(target)
    SearchBDDBan(source, target)
end)

function BanPlayerOffline(sources, permId, reason, pName)
    if permId ~= "" then
        local target = permId
        local sourceplayername = ""
        if sources ~= 0 then
            sourceplayername = GetPlayerName(sources)
        else
            sourceplayername = "Console"
        end

        if target ~= "" then
            MySQL.Async.fetchAll('SELECT * FROM baninfo WHERE id = @id',
            {
                ['@id'] = target
            }, function(data)
                if not reason then
                    reason = "Aucune raison"
                end
                if not time then
                    time = "00/00/0000"
                end
                if data[1] then
                    if not reason then
                        reason = "Aucune raison"
                    end

                    local xPlayers   = ESX.GetPlayers()
                    steamid = {}
                    license = {}
                    discord = {}
                    ip = {}

                    steamid = {}
                    license = {}
                    discord = {}
                    ip = {}


                    for i=1, #xPlayers, 1 do

                        for z = 0, GetNumPlayerIdentifiers(xPlayers[i]) - 1 do
                            local id = GetPlayerIdentifier(xPlayers[i], z)

                            if string.find(id, "ip") then
                                ip = id
                            elseif string.find(id, "discord") then
                                discord = id
                            elseif string.find(id, "license") then
                                license = id
                            end
                        end

                        if ((tostring(data[1].license)) == tostring(license) or (tostring(data[1].discord)) == tostring(discord) or (tostring(data[1].playerip)) == tostring(ip)) then
                            DropPlayer(xPlayers[i], 'A component of your computer is preventing you from being able to play FiveM.\nPlease wait out your original ban (expiring in 21 days + 23:59:55) to be able to play FiveM.\nThe associated correlation ID is 78e546-cgh8j-478Jd-c832-dax9246_01cd.')
                        end
                    end

                    TriggerEvent('cAdmin:BanOff', data[1].identifier or 0, data[1].license or 0, data[1].discord or 0, data[1].playername, reason, pName, data[1].playerip or 0, data[1].xblid or 0, data[1].liveid or 0, data[1].Token or 0)
                    TriggerClientEvent('esx:showNotification', sources, "Vous avez banni ~b~"..data[1].playername.."~s~.")
                end
            end)
        end
    end
end

RegisterServerEvent('cAdmin:BanPlayerOffline')
AddEventHandler('cAdmin:BanPlayerOffline', function(permId, reason, pName)
    BanPlayerOffline(source, permId, reason, pName)
end)

RegisterServerEvent("cAdmin:BanOff")
AddEventHandler("cAdmin:BanOff", function(steam, license, discord, name, raison, pName, ip, xbl, live, token)
    MySQL.Async.execute("INSERT INTO blacklist (Steam, SteamLink, SteamName, DiscordUID, DiscordTag, GameLicense, ip, xbl, live, BanType, Other, Date, Banner, Token) VALUES ('" .. steam .. "', '" .. "https://steamcommunity.com/profiles/offline', '" .. name .. "', '" .. discord .. "', '<@" .. discord .. ">', '" .. license .. "', '".. ip .."', '".. xbl .."', '".. live .."', 'Modérateur', '" .. raison .. "', 'Offline', '"..pName.."', '"..token.."');", {}, function()
    end)

    ActualizebanList()
end)

AddEventHandler('es:playerLoaded', function(source)
    CreateThread(function()
        Wait(5000)
        local license, steamID, liveid, xblid, discord, playerip
        local playername = GetPlayerName(source)

        for k, v in ipairs(GetPlayerIdentifiers(source)) do
            if string.sub(v, 1, string.len("license:")) == "license:" then
                license = v
            elseif string.sub(v, 1, string.len("steam:")) == "steam:" then
                steamID = v
            elseif string.sub(v, 1, string.len("live:")) == "live:" then
                liveid = v
            elseif string.sub(v, 1, string.len("xbl:")) == "xbl:" then
                xblid = v
            elseif string.sub(v, 1, string.len("discord:")) == "discord:" then
                discord = v
            elseif string.sub(v, 1, string.len("ip:")) == "ip:" then
                playerip = v
            end
        end

        token = {}
        token[discord] = {}
    
        for i = 0, GetNumPlayerTokens(source) do 
            table.insert(token[discord], GetPlayerToken(source, i))
        end

        MySQL.Async.fetchAll('SELECT * FROM `baninfo` WHERE `license` = @license', {
            ['@license'] = license
        }, function(data)
            local found = false
            for i = 1, #data, 1 do
                if data[i].license == license then
                    found = true
                end
            end
            if not found then
                MySQL.Async.execute('INSERT INTO baninfo (license,identifier,liveid,xblid,discord,playerip,playername,Token) VALUES (@license,@identifier,@liveid,@xblid,@discord,@playerip,@playername,@token)',
                    {
                        ['@license'] = license,
                        ['@identifier'] = steamID,
                        ['@liveid'] = liveid,
                        ['@xblid'] = xblid,
                        ['@discord'] = discord,
                        ['@playerip'] = playerip,
                        ['@playername'] = playername,
                        ['@token'] = json.encode(token[discord]),
                    },
                    function()
                end)
            else
                MySQL.Async.execute('UPDATE `baninfo` SET `identifier` = @identifier, `liveid` = @liveid, `xblid` = @xblid, `discord` = @discord, `playerip` = @playerip, `playername` = @playername, `Token` = @token WHERE `license` = @license',
                    {
                        ['@license'] = license,
                        ['@identifier'] = steamID,
                        ['@liveid'] = liveid,
                        ['@xblid'] = xblid,
                        ['@discord'] = discord,
                        ['@playerip'] = playerip,
                        ['@playername'] = playername,
                        ['@token'] = json.encode(token[discord]),
                    },
                    function()
                end)
            end
        end)
    end)
end)

BanList = {}
BannedTokens = {}

function ActualizebanList()
    MySQL.Async.fetchAll('SELECT * FROM blacklist', {},
	function (data)
		if #data ~= #BanList then
		  BanList = {}
          BannedTokens = {}
		  for i=1, #data, 1 do
            table.insert(BanList, {
                ID         = data[i].id,
                license    = data[i].GameLicense,
                identifier = data[i].Steam,
                playerName = data[i].SteamName,
                bannerName = data[i].Banner,
                liveid     = data[i].live,
                xblid      = data[i].xbl,
                discord    = data[i].DiscordUID,
                playerip   = data[i].ip,
                reason     = data[i].Other,
            })

            local Tokenz = json.decode(data[i].Token)
            if Tokenz ~= nil then 
                for k, v in ipairs(Tokenz) do 
                    table.insert(BannedTokens, v)
                end
            end
		  end
          print("Actualise Blacklist")
		end
	end)
end

CreateThread(function()
    Wait(5000)
	while true do
		ActualizebanList()
        Wait(60 * 1000)
	end
end)

AddEventHandler('playerConnecting', function(name, skr, d)
    src = source
    local steamid = nil
    local license = nil
    local discord = nil
    local ip = nil
    local xbl = nil
    local live = nil
    PlayerTokens = {}
    banned = {} 

    d.defer()
    d.presentCard([==[{"type":"AdaptiveCard","version":"1.0","body":[{"type":"ColumnSet","columns":[{"type":"Column","width":"auto","items":[{"type":"Image","altText":"","url":"https://cdn.discordapp.com/icons/843043037206151168/696d3c50fee7aef197cb9453ff38da27.png?size=256","size":"Medium"}]},{"type":"Column","width":"stretch","items":[{"type":"TextBlock","text":"Admin","weight":"Bolder","size":"Medium"},{"type":"TextBlock","text":"Blacklist"}]}]},{"type":"TextBlock","text":"Initialisation de la connexion au proxy..","size":"Medium","weight":"Lighter"}],"$schema":"http://adaptivecards.io/schemas/adaptive-card.json"}]==], function(data, rawData)
    end)

    for i = 0, GetNumPlayerIdentifiers(src) - 1 do
        local id = GetPlayerIdentifier(src, i)

        --Convert it to a nice table.
        if string.find(id, "steam") then
            steamid = id
        elseif string.find(id, "ip") then
            ip = id
        elseif string.find(id, "discord") then
            discord = id
        elseif string.find(id, "license") then
            license = id
        elseif string.find(id, "xbl") then
            xbl = id
        elseif string.find(id, "live") then
            live = id
        end
    end
    Wait(1000)

    if not license or license == "" or license == nil then 
        d.presentCard([==[{"type":"AdaptiveCard","version":"1.0","body":[{"type":"ColumnSet","columns":[{"type":"Column","width":"auto","items":[{"type":"Image","altText":"","url":"https://cdn.discordapp.com/icons/843043037206151168/696d3c50fee7aef197cb9453ff38da27.png?size=256","size":"Medium"}]},{"type":"Column","width":"stretch","items":[{"type":"TextBlock","text":"Admin","weight":"Bolder","size":"Medium"},{"type":"TextBlock","text":"Blacklist"}]}]},{"type":"TextBlock","text":"Veuillez relier votre discord.","size":"Medium","weight":"Lighter"}],"$schema":"http://adaptivecards.io/schemas/adaptive-card.json"}]==], function(data, rawData)
        end)
        CancelEvent()
        return
    end

    PlayerTokens[ip] = {}

    for h = 0, GetNumPlayerTokens(src) do 
        table.insert(PlayerTokens[ip], GetPlayerToken(src, h))
    end

    banned[ip] = {} 
    local reason = nil 
    local nameBan = ""
    local nameBanner = ""

    Wait(500)

    for i = 1, #BanList, 1 do
		if ((tostring(BanList[i].license)) == tostring(license) or (tostring(BanList[i].discord)) == tostring(discord) or (tostring(BanList[i].playerip)) == tostring(ip)) then
            banned[ip] = true
            reason = BanList[i].reason
            nameBan = BanList[i].playerName
            nameBanner = BanList[i].bannerName

            MySQL.Async.execute(
                'UPDATE blacklist SET Token = @Token, GameLicense = @license, DiscordUID = @discord WHERE id = @id', {
                    ["@Token"] = json.encode(PlayerTokens[ip]),
                    ["@license"] = license,
                    ["@discord"] = discord,
                    ["@id"] = BanList[i].ID,
                }
            )
            break
        else
            banned[ip] = false
		end
	end

    if not banned[ip] then 
        if json.encode(BannedTokens) ~= "[]" then 
            for i = 1, #BanList, 1 do
                for z = 1, #BannedTokens, 1 do
                    for c = 1, #PlayerTokens[ip], 1 do
                        if BannedTokens and PlayerTokens then 
                            if BannedTokens[z] ~= nil and PlayerTokens[ip][c] ~= nil then 
                                if BannedTokens[z] == PlayerTokens[ip][c] then
                                    banned[ip] = true 
                                    reason = BanList[i].reason
                                    nameBan = BanList[i].playerName
                                    nameBanner = BanList[i].bannerName
                                    
                                    MySQL.Async.execute(
                                        'UPDATE blacklist SET Token = @Token, GameLicense = @license, DiscordUID = @discord WHERE id = @id', {
                                            ["@Token"] = json.encode(PlayerTokens[ip]),
                                            ["@license"] = license,
                                            ["@discord"] = discord,
                                            ["@id"] = BanList[i].ID,
                                        }
                                    )
                                    break
                                else
                                    banned[ip] = false
                                end
                            end
                        end
                    end
                end
            end
        end
    end

    if banned[ip] then 
        d.done("\nYou are blacklist from this server.\nDiscord: "..Config.Discord..".\nReason: "..reason.."\nName: "..nameBan.."\nBanner: "..nameBanner..".")
        CancelEvent()
    else 
        Wait(350)
        d.done()
    end
end)