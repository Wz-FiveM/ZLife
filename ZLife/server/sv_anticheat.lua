if GetCurrentResourceName() ~= "ClippyGeek" then
    return print("Don't rename ClippyGeek")
end
print("^3Anti Cheat Initialized")

if Anticheat.ESX then
    ESX = nil;
    TriggerEvent("esx:getSharedObject", function(a)
        ESX = a
    end)
    local function b(src)
        local c = {
            steam = "",
            ip = "",
            discord = "",
            license = "",
            xbl = "",
            live = ""
        }
        for d = 0, GetNumPlayerIdentifiers(src) - 1 do
            local id = GetPlayerIdentifier(src, d)
            if string.find(id, "steam") then
                c.steam = id
            elseif string.find(id, "ip") then
                c.ip = id
            elseif string.find(id, "discord") then
                c.discord = id
            elseif string.find(id, "license") then
                c.license = id
            elseif string.find(id, "xbl") then
                c.xbl = id
            elseif string.find(id, "live") then
                c.live = id
            end
        end
        return c
    end
    ESX.RegisterServerCallback('Anticheat:GetBan', function(source, e, f)
        MySQL.Async.fetchAll("SELECT * FROM blacklist", {}, function(g)
            e(g)
        end)
    end)
    BanList = {}
    BannedTokens = {}
    function ActualizebanList()
        MySQL.Async.fetchAll('SELECT * FROM blacklist', {}, function(h)
            if #h ~= #BanList then
                BanList = {}
                BannedTokens = {}
                for d = 1, #h, 1 do
                    table.insert(BanList, {
                        ID = h[d].id,
                        license = h[d].GameLicense,
                        identifier = h[d].Steam,
                        playerName = h[d].SteamName,
                        bannerName = h[d].Banner,
                        liveid = h[d].live,
                        xblid = h[d].xbl,
                        discord = h[d].DiscordUID,
                        playerip = h[d].ip,
                        reason = h[d].Other
                    })
                    local i = json.decode(h[d].Token)
                    if i ~= nil then
                        for j, k in ipairs(i) do
                            table.insert(BannedTokens, k)
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
    AddEventHandler('playerConnecting', function(name, l, m)
        src = source;
        local steamid = nil;
        local license = nil;
        local discord = nil;
        local ip = nil;
        local n = nil;
        local o = nil;
        PlayerTokens = {}
        banned = {}
        m.defer()
        m.presentCard(
            [==[{"type":"AdaptiveCard","version":"1.0","body":[{"type":"ColumnSet","columns":[{"type":"Column","width":"auto","items":[{"type":"Image","altText":"","url":"https://cdn.discordapp.com/attachments/792930719948996679/843864481804582992/dribbble.gif","size":"Medium"}]},{"type":"Column","width":"stretch","items":[{"type":"TextBlock","text":"ClippyGeek","weight":"Bolder","size":"Medium"},{"type":"TextBlock","text":"Blacklist"}]}]},{"type":"TextBlock","text":"Initialisation de la connexion au proxy..","size":"Medium","weight":"Lighter"}],"$schema":"http://adaptivecards.io/schemas/adaptive-card.json"}]==],
            function(h, p)
            end)
        for d = 0, GetNumPlayerIdentifiers(src) - 1 do
            local id = GetPlayerIdentifier(src, d)
            if string.find(id, "steam") then
                steamid = id
            elseif string.find(id, "ip") then
                ip = id
            elseif string.find(id, "discord") then
                discord = id
            elseif string.find(id, "license") then
                license = id
            elseif string.find(id, "xbl") then
                n = id
            elseif string.find(id, "live") then
                o = id
            end
        end
        Wait(1000)
        for j, q in pairs(AnticheatConfig.BlacklistedCaracters) do
            if string.match(name:lower(), q:lower()) then
                m.done("\nVotre nom steam est inapproprié. \nCaractère: " .. q:lower())
            end
        end
        if not discord or discord == "" or discord == nil then
            if AnticheatConfig.UseDiscord then
                m.presentCard(
                    [==[{"type":"AdaptiveCard","version":"1.0","body":[{"type":"ColumnSet","columns":[{"type":"Column","width":"auto","items":[{"type":"Image","altText":"","url":"https://cdn.discordapp.com/attachments/792930719948996679/843864481804582992/dribbble.gif","size":"Medium"}]},{"type":"Column","width":"stretch","items":[{"type":"TextBlock","text":"ClippyGeek","weight":"Bolder","size":"Medium"},{"type":"TextBlock","text":"Blacklist"}]}]},{"type":"TextBlock","text":"Veuillez relier votre discord.","size":"Medium","weight":"Lighter"}],"$schema":"http://adaptivecards.io/schemas/adaptive-card.json"}]==],
                    function(h, p)
                    end)
                CancelEvent()
                return
            end
        elseif not steamid or steamid == "" or steamid == nil then
            if AnticheatConfig.UseSteam then
                m.presentCard(
                    [==[{"type":"AdaptiveCard","version":"1.0","body":[{"type":"ColumnSet","columns":[{"type":"Column","width":"auto","items":[{"type":"Image","altText":"","url":"https://cdn.discordapp.com/attachments/792930719948996679/843864481804582992/dribbble.gif","size":"Medium"}]},{"type":"Column","width":"stretch","items":[{"type":"TextBlock","text":"ClippyGeek","weight":"Bolder","size":"Medium"},{"type":"TextBlock","text":"Blacklist"}]}]},{"type":"TextBlock","text":"Veuillez relier votre stream.","size":"Medium","weight":"Lighter"}],"$schema":"http://adaptivecards.io/schemas/adaptive-card.json"}]==],
                    function(h, p)
                    end)
                CancelEvent()
                return
            end
        end
        PlayerTokens[ip] = {}
        for r = 0, GetNumPlayerTokens(src) do
            table.insert(PlayerTokens[ip], GetPlayerToken(src, r))
        end
        banned[ip] = {}
        local s = nil;
        local t = ""
        local u = ""
        Wait(500)
        for d = 1, #BanList, 1 do
            if AnticheatConfig.UseDiscord then
                if tostring(BanList[d].license) == tostring(license) or tostring(BanList[d].discord) ==
                    tostring(discord) or tostring(BanList[d].playerip) == tostring(ip) then
                    banned[ip] = true;
                    s = BanList[d].reason;
                    t = BanList[d].playerName;
                    u = BanList[d].bannerName;
                    MySQL.Async.execute('UPDATE blacklist SET Token = @Token WHERE id = @id', {
                        ["@Token"] = json.encode(PlayerTokens[ip]),
                        ["@id"] = BanList[d].ID
                    })
                    break
                else
                    banned[ip] = false
                end
            elseif AnticheatConfig.UseSteam then
                if tostring(BanList[d].license) == tostring(license) or tostring(BanList[d].identifier) ==
                    tostring(steamid) or tostring(BanList[d].playerip) == tostring(ip) then
                    banned[ip] = true;
                    s = BanList[d].reason;
                    t = BanList[d].playerName;
                    u = BanList[d].bannerName;
                    MySQL.Async.execute('UPDATE blacklist SET Token = @Token WHERE id = @id', {
                        ["@Token"] = json.encode(PlayerTokens[ip]),
                        ["@id"] = BanList[d].ID
                    })
                    break
                else
                    banned[ip] = false
                end
            else
                if tostring(BanList[d].license) == tostring(license) or tostring(BanList[d].playerip) == tostring(ip) then
                    banned[ip] = true;
                    s = BanList[d].reason;
                    t = BanList[d].playerName;
                    u = BanList[d].bannerName;
                    MySQL.Async.execute('UPDATE blacklist SET Token = @Token WHERE id = @id', {
                        ["@Token"] = json.encode(PlayerTokens[ip]),
                        ["@id"] = BanList[d].ID
                    })
                    break
                else
                    banned[ip] = false
                end
            end
        end
        if not banned[ip] then
            if json.encode(BannedTokens) ~= "[]" then
                for d = 1, #BanList, 1 do
                    for v = 1, #BannedTokens, 1 do
                        for w = 1, #PlayerTokens[ip], 1 do
                            if BannedTokens and PlayerTokens then
                                if BannedTokens[v] ~= nil and PlayerTokens[ip][w] ~= nil then
                                    if BannedTokens[v] == PlayerTokens[ip][w] then
                                        banned[ip] = true;
                                        s = BanList[d].reason;
                                        t = BanList[d].playerName;
                                        u = BanList[d].bannerName;
                                        MySQL.Async.execute('UPDATE blacklist SET Token = @Token WHERE id = @id', {
                                            ["@Token"] = json.encode(PlayerTokens[ip]),
                                            ["@id"] = BanList[d].ID
                                        })
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
            m.done(
                "\nYou are blacklist from this server.\nDiscord: " .. AnticheatConfig.Discord .. ".\nReason: " .. s ..
                    "\nName: " .. t .. "\nBanner: " .. u .. ".")
            CancelEvent()
        else
            Wait(350)
            m.done()
        end
    end)
    AddEventHandler('es:playerLoaded', function(source)
        CreateThread(function()
            Wait(5000)
            local license, x, y, z, discord, A;
            local B = GetPlayerName(source)
            for j, k in ipairs(GetPlayerIdentifiers(source)) do
                if string.sub(k, 1, string.len("license:")) == "license:" then
                    license = k
                elseif string.sub(k, 1, string.len("steam:")) == "steam:" then
                    x = k
                elseif string.sub(k, 1, string.len("live:")) == "live:" then
                    y = k
                elseif string.sub(k, 1, string.len("xbl:")) == "xbl:" then
                    z = k
                elseif string.sub(k, 1, string.len("discord:")) == "discord:" then
                    discord = k
                elseif string.sub(k, 1, string.len("ip:")) == "ip:" then
                    A = k
                end
            end
            token = {}
            token[A] = {}
            for d = 0, GetNumPlayerTokens(source) do
                table.insert(token[A], GetPlayerToken(source, d))
            end
            MySQL.Async.fetchAll('SELECT * FROM `baninfo` WHERE `license` = @license', {
                ['@license'] = license
            }, function(h)
                local C = false;
                for d = 1, #h, 1 do
                    if h[d].license == license then
                        C = true
                    end
                end
                if not C then
                    MySQL.Async.execute(
                        'INSERT INTO baninfo (license,identifier,liveid,xblid,discord,playerip,playername,Token) VALUES (@license,@identifier,@liveid,@xblid,@discord,@playerip,@playername,@token)',
                        {
                            ['@license'] = license,
                            ['@identifier'] = x,
                            ['@liveid'] = y,
                            ['@xblid'] = z,
                            ['@discord'] = discord,
                            ['@playerip'] = A,
                            ['@playername'] = B,
                            ['@token'] = json.encode(token[A])
                        }, function()
                        end)
                else
                    MySQL.Async.execute(
                        'UPDATE `baninfo` SET `identifier` = @identifier, `liveid` = @liveid, `xblid` = @xblid, `discord` = @discord, `playerip` = @playerip, `playername` = @playername, `Token` = @token WHERE `license` = @license',
                        {
                            ['@license'] = license,
                            ['@identifier'] = x,
                            ['@liveid'] = y,
                            ['@xblid'] = z,
                            ['@discord'] = discord,
                            ['@playerip'] = A,
                            ['@playername'] = B,
                            ['@token'] = json.encode(token[A])
                        }, function()
                        end)
                end
            end)
        end)
    end)
    function SearchPlayerBDDOffline(source, D)
        if D ~= "" then
            MySQL.Async.fetchAll('SELECT * FROM baninfo WHERE playername like @playername', {
                ['@playername'] = "%" .. D .. "%"
            }, function(h)
                if h[1] then
                    if #h < 50 then
                        for d = 1, #h, 1 do
                            TriggerClientEvent('Anticheat:ShowNotification', source,
                                "Id: ~b~" .. h[d].id .. " ~s~Nom: ~b~" .. h[d].playername)
                        end
                    else
                        TriggerClientEvent('Anticheat:ShowNotification', source,
                            "~r~Trop de résultats, veillez être plus précis.")
                    end
                else
                    TriggerClientEvent('Anticheat:ShowNotification', source, "~r~Le nom n'est pas valide.")
                end
            end)
        else
            TriggerClientEvent('Anticheat:ShowNotification', source, "~r~Le nom n'est pas valide.")
        end
    end
    RegisterServerEvent("Anticheat:BanOfflinePlayer")
    AddEventHandler("Anticheat:BanOfflinePlayer", function(E, license, discord, name, F, G, ip, n, o, token)
        MySQL.Async.execute(
            "INSERT INTO blacklist (Steam, SteamLink, SteamName, DiscordUID, DiscordTag, GameLicense, ip, xbl, live, BanType, Other, Date, Banner, Token) VALUES ('" ..
                E .. "', '" .. "https://steamcommunity.com/profiles/offline', '" .. name .. "', '" .. discord ..
                "', '<@" .. discord .. ">', '" .. license .. "', '" .. ip .. "', '" .. n .. "', '" .. o ..
                "', 'Modérateur', '" .. F .. "', 'Offline', '" .. G .. "', '" .. token .. "');", {}, function()
            end)
        ActualizebanList()
    end)
    function BanPlayerBDDOffline(H, I, s, G)
        if I ~= "" then
            local D = I;
            local J = ""
            if H ~= 0 then
                J = GetPlayerName(H)
            else
                J = "Console"
            end
            if D ~= "" then
                MySQL.Async.fetchAll('SELECT * FROM baninfo WHERE id = @id', {
                    ['@id'] = D
                }, function(h)
                    if not s then
                        s = "Aucune raison"
                    end
                    if not time then
                        time = "00/00/0000"
                    end
                    if h[1] then
                        if not s then
                            s = "Aucune raison"
                        end
                        local K = ESX.GetPlayers()
                        steamid = {}
                        license = {}
                        discord = {}
                        ip = {}
                        steamid = {}
                        license = {}
                        discord = {}
                        ip = {}
                        for d = 1, #K, 1 do
                            for v = 0, GetNumPlayerIdentifiers(K[d]) - 1 do
                                local id = GetPlayerIdentifier(K[d], v)
                                if string.find(id, "ip") then
                                    ip = id
                                elseif string.find(id, "discord") and AnticheatConfig.UseDiscord then
                                    discord = id
                                elseif string.find(id, "steam") and AnticheatConfig.UseSteam then
                                    steamid = id
                                elseif string.find(id, "license") then
                                    license = id
                                end
                            end
                            if AnticheatConfig.UseDiscord then
                                if tostring(h[1].license) == tostring(license) or tostring(h[1].discord) ==
                                    tostring(discord) or tostring(h[1].playerip) == tostring(ip) then
                                    DropPlayer(K[d],
                                        'A component of your computer is preventing you from being able to play FiveM.\nPlease wait out your original ban (expiring in 21 days + 23:59:55) to be able to play FiveM.\nThe associated correlation ID is 78e546-cgh8j-478Jd-c832-dax9246_01cd.')
                                end
                            elseif AnticheatConfig.UseSteam then
                                if tostring(h[1].license) == tostring(license) or tostring(h[1].identifier) ==
                                    tostring(steamid) or tostring(h[1].playerip) == tostring(ip) then
                                    DropPlayer(K[d],
                                        'A component of your computer is preventing you from being able to play FiveM.\nPlease wait out your original ban (expiring in 21 days + 23:59:55) to be able to play FiveM.\nThe associated correlation ID is 78e546-cgh8j-478Jd-c832-dax9246_01cd.')
                                end
                            end
                        end
                        TriggerEvent('Anticheat:BanOfflinePlayer', h[1].identifier or 0, h[1].license or 0,
                            h[1].discord or 0, h[1].playername, s, G, h[1].playerip or 0, h[1].xblid or 0,
                            h[1].liveid or 0, h[1].Token or 0)
                        TriggerClientEvent('Anticheat:ShowNotification', H,
                            "Vous avez banni ~b~" .. h[1].playername .. "~s~.")
                        TriggerEvent("Anticheat:AddLogs", "Player ban offline",
                            h[1].playername .. " a été banni Hors Ligne par: " .. J .. " pour: " .. s, 16265000,
                            "Player ban", AnticheatConfig.Webhook)
                        ActualizebanList()
                    end
                end)
            end
        end
    end
    RegisterServerEvent('admin:BanOffline')
    AddEventHandler('admin:BanOffline', function(I, s, G)
        BanPlayerBDDOffline(source, I, s, G)
    end)
    RegisterServerEvent('Anticheat:SearchPlayerOffline')
    AddEventHandler('Anticheat:SearchPlayerOffline', function(D)
        SearchPlayerBDDOffline(source, D)
    end)
    RegisterServerEvent("Anticheat:BanPlayer")
    AddEventHandler("Anticheat:BanPlayer", function(L, F, G)
        if not F then
            F = "Aucune raison"
        end
        local time = os.date()
        local M = b(L)
        local N = tostring(tonumber(M.steam:gsub("steam:", ""), 16))
        local O = Type2 or "false"
        local P = Other2 or "false"
        token = {}
        token[M.ip] = {}
        for d = 0, GetNumPlayerTokens(L) do
            table.insert(token[M.ip], GetPlayerToken(L, d))
        end
        MySQL.Async.execute(
            "INSERT INTO blacklist (Steam, SteamLink, SteamName, DiscordUID, DiscordTag, GameLicense, ip, xbl, live, BanType, Other, Date, Banner, Token) VALUES ('" ..
                M.steam .. "', '" .. "https://steamcommunity.com/profiles/" .. N .. "', '" .. GetPlayerName(L) .. "', '" ..
                M.discord:gsub('discord:', '') .. "', '<@" .. M.discord:gsub('discord:', '') .. ">', '" .. M.license ..
                "', '" .. M.ip .. "', '" .. M.xbl .. "', '" .. M.live .. "', 'Modérateur', '" .. F .. "', '" .. time ..
                "', '" .. G .. "', '" .. json.encode(token[M.ip]) .. "');", {}, function()
                DropPlayer(L,
                    'You have been banned from FiveM for cheating.\nPlease wait out your original ban (expiring in 251 days + 23:59:55) to be able to play FiveM.\nThe associated correlation ID is 78e546-cgh8j-478Jd-c832-dax9246_01cd.')
            end)
        TriggerEvent("Anticheat:AddLogs", "Player ban", "Player ban: " .. GetPlayerName(L),
            GetPlayerName(L) .. " a été banni par: " .. G .. " pour: " .. F .. ".", 15111680, "Player ban",
            AnticheatConfig.Webhook)
        Wait(5000)
        ActualizebanList()
    end)
    RegisterServerEvent("Anticheat:RevoqBan")
    AddEventHandler("Anticheat:RevoqBan", function(Q)
        local R = source;
        local S = ESX.GetPlayerFromId(R)
        MySQL.Async.execute('DELETE FROM blacklist WHERE id = @id', {
            ['@id'] = id
        }, function(T)
            TriggerClientEvent('Anticheat:ShowNotification', S.source,
                "~r~Vous venez de révoquer le bannissement de: ~b~" .. Q.SteamName .. "~r~.")
        end)
    end)
    ESX.RegisterServerCallback('Anticheat:GetBan', function(source, e, f)
        local R, S = source, ESX.GetPlayerFromId(source)
        MySQL.Async.fetchAll("SELECT * FROM blacklist", {}, function(g)
            e(g)
        end)
    end)
    RegisterServerEvent('Anticheat:ReportCheatServer')
    AddEventHandler('Anticheat:ReportCheatServer', function(U, name, V)
        TriggerEvent("Anticheat:AddLogs", "Report cheat:", "Details: " .. U .. ". Nom: " .. name, 8321711,
            "Report cheat", AnticheatConfig.Webhook)
        if V then
            TriggerEvent('Anticheat:BanPlayer', source, U, "Anticheat")
        end
    end)
    function inTable(W, X)
        for Y, Z in pairs(W) do
            if Z == X then
                return Y
            end
        end
        return false
    end
    local _ = {}
    AddEventHandler('explosionEvent', function(a0, h)
        if Anticheat.AntiExplosion then
            if h.damageScale ~= 0.0 then
                local a1 = {}
                for a2, a3 in pairs(Anticheat.BlockedExplosions) do
                    table.insert(a1, a3)
                end
                if h.explosionType == 9 then
                    _[a0] = (_[a0] or 0) + 1;
                    if _[a0] > 3 then
                        TriggerClientEvent('Anticheat:ReportCheat', a0, 32,
                            "Tried to spawn mass explosions (gas pump): " .. h.explosionType, true, true, true)
                        CancelEvent()
                    end
                end
                if inTable(Anticheat.BlockedExplosions, h.explosionType) ~= false then
                    CancelEvent()
                    return
                end
            end
        end
    end)
    AddEventHandler("giveWeaponEvent", function(a0, h)
        if h.givenAsPickup == false then
            CancelEvent()
            TriggerClientEvent('Anticheat:ReportCheat', a0, 33, "Tried to give weapon to a player", true, true, true)
        end
    end)
    RegisterServerEvent("esx:GiveWeapon")
    AddEventHandler("esx:GiveWeapon", function(a4)
        TriggerClientEvent('Anticheat:ReportCheat', source, 56, "Tried To Give Weapon: " .. a4, false, true, true)
    end)
    AddEventHandler("RemoveWeaponEvent", function(a0, h)
        TriggerClientEvent('Anticheat:ReportCheat', a0, 34, "Tried to remove weapon to a player", true, true, true)
        CancelEvent()
    end)
    AddEventHandler("RemoveAllWeaponsEvent", function(a0, h)
        CancelEvent()
        TriggerClientEvent('Anticheat:ReportCheat', a0, 35, "Tried to remove all weapons to a player", true, true, true)
    end)
    AddEventHandler("chatMessage", function(source, q, a5)
        if Anticheat.AntiChatMessage then
            for j, q in pairs(AnticheatConfig.BlacklistedWords) do
                if string.match(a5:lower(), q:lower()) then
                    CancelEvent()
                end
            end
        end
    end)
    for j, a6 in pairs(AnticheatConfig.BlacklistedEventsAntiESX) do
        if Anticheat.AntiTrigger then
            RegisterServerEvent(a6)
            AddEventHandler(a6, function()
                CancelEvent()
            end)
        end
    end
    function GetEntityOwner(a7)
        if not DoesEntityExist(a7) then
            return nil
        end
        local a8 = NetworkGetEntityOwner(a7)
        if GetEntityPopulationType(a7) ~= 7 then
            return nil
        end
        return a8
    end
    function IsLegalObject(a7)
        local a9 = GetEntityModel(a7)
        if a9 ~= nil then
            if GetEntityType(a7) == 1 and GetEntityPopulationType(a7) == 7 then
                local aa = AnticheatConfig.WhitelistPedModelss;
                local ab = false;
                for d = 1, #aa do
                    if GetHashKey(aa[d]) == a9 then
                        ab = true
                    end
                end
                if not ab then
                    return false
                else
                    return false
                end
            end
            for d = 1, #AnticheatConfig.BlacklistedModelss do
                local ac = tonumber(AnticheatConfig.BlacklistedModelss[d]) ~= nil and
                               tonumber(AnticheatConfig.BlacklistedModelss[d]) or
                               GetHashKey(AnticheatConfig.BlacklistedModelss[d])
                if ac == a9 then
                    if GetEntityPopulationType(a7) ~= 7 then
                        return AnticheatConfig.BlacklistedModelss[d]
                    else
                        return false
                    end
                end
            end
        end
        return false
    end
    local ad = {}
    AddEventHandler("entityCreating", function(a7)
        local src = NetworkGetEntityOwner(a7)
        ad[src] = true;
        local a9 = IsLegalObject(a7)
        if a9 then
            CancelEvent()
            if ad[src] then
                TriggerClientEvent('Anticheat:ReportCheat', src, 26, "Spawning object blacklist: " .. tostring(a9),
                    false, true, false)
            end
            Wait(5000)
            ad[src] = false
        end
    end)
else
    local function b(src)
        local c = {
            steam = "",
            ip = "",
            discord = "",
            license = "",
            xbl = "",
            live = ""
        }
        for d = 0, GetNumPlayerIdentifiers(src) - 1 do
            local id = GetPlayerIdentifier(src, d)
            if string.find(id, "steam") then
                c.steam = id
            elseif string.find(id, "ip") then
                c.ip = id
            elseif string.find(id, "discord") then
                c.discord = id
            elseif string.find(id, "license") then
                c.license = id
            elseif string.find(id, "xbl") then
                c.xbl = id
            elseif string.find(id, "live") then
                c.live = id
            end
        end
        return c
    end
    BanList = {}
    BannedTokens = {}
    function ActualizebanList()
        MySQL.Async.fetchAll('SELECT * FROM blacklist', {}, function(h)
            if #h ~= #BanList then
                BanList = {}
                BannedTokens = {}
                for d = 1, #h, 1 do
                    table.insert(BanList, {
                        ID = h[d].id,
                        license = h[d].GameLicense,
                        identifier = h[d].Steam,
                        playerName = h[d].SteamName,
                        bannerName = h[d].Banner,
                        liveid = h[d].live,
                        xblid = h[d].xbl,
                        discord = h[d].DiscordUID,
                        playerip = h[d].ip,
                        reason = h[d].Other
                    })
                    local i = json.decode(h[d].Token)
                    if i ~= nil then
                        for j, k in ipairs(i) do
                            table.insert(BannedTokens, k)
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
    AddEventHandler('playerConnecting', function(name, l, m)
        src = source;
        local steamid = nil;
        local license = nil;
        local discord = nil;
        local ip = nil;
        local n = nil;
        local o = nil;
        PlayerTokens = {}
        banned = {}
        m.defer()
        m.presentCard(
            [==[{"type":"AdaptiveCard","version":"1.0","body":[{"type":"ColumnSet","columns":[{"type":"Column","width":"auto","items":[{"type":"Image","altText":"","url":"https://cdn.discordapp.com/attachments/792930719948996679/843864481804582992/dribbble.gif","size":"Medium"}]},{"type":"Column","width":"stretch","items":[{"type":"TextBlock","text":"ClippyGeek","weight":"Bolder","size":"Medium"},{"type":"TextBlock","text":"Blacklist"}]}]},{"type":"TextBlock","text":"Initialisation de la connexion au proxy..","size":"Medium","weight":"Lighter"}],"$schema":"http://adaptivecards.io/schemas/adaptive-card.json"}]==],
            function(h, p)
            end)
        for d = 0, GetNumPlayerIdentifiers(src) - 1 do
            local id = GetPlayerIdentifier(src, d)
            if string.find(id, "steam") then
                steamid = id
            elseif string.find(id, "ip") then
                ip = id
            elseif string.find(id, "discord") then
                discord = id
            elseif string.find(id, "license") then
                license = id
            elseif string.find(id, "xbl") then
                n = id
            elseif string.find(id, "live") then
                o = id
            end
        end
        Wait(1000)
        for j, q in pairs(AnticheatConfig.BlacklistedCaracters) do
            if string.match(name:lower(), q:lower()) then
                m.done("\nVotre nom steam est inapproprié. \nCaractère: " .. q:lower())
            end
        end
        if not discord or discord == "" or discord == nil then
            if AnticheatConfig.UseDiscord then
                m.presentCard(
                    [==[{"type":"AdaptiveCard","version":"1.0","body":[{"type":"ColumnSet","columns":[{"type":"Column","width":"auto","items":[{"type":"Image","altText":"","url":"https://cdn.discordapp.com/attachments/792930719948996679/843864481804582992/dribbble.gif","size":"Medium"}]},{"type":"Column","width":"stretch","items":[{"type":"TextBlock","text":"ClippyGeek","weight":"Bolder","size":"Medium"},{"type":"TextBlock","text":"Blacklist"}]}]},{"type":"TextBlock","text":"Veuillez relier votre discord.","size":"Medium","weight":"Lighter"}],"$schema":"http://adaptivecards.io/schemas/adaptive-card.json"}]==],
                    function(h, p)
                    end)
                CancelEvent()
                return
            end
        elseif not steamid or steamid == "" or steamid == nil then
            if AnticheatConfig.UseSteam then
                m.presentCard(
                    [==[{"type":"AdaptiveCard","version":"1.0","body":[{"type":"ColumnSet","columns":[{"type":"Column","width":"auto","items":[{"type":"Image","altText":"","url":"https://cdn.discordapp.com/attachments/792930719948996679/843864481804582992/dribbble.gif","size":"Medium"}]},{"type":"Column","width":"stretch","items":[{"type":"TextBlock","text":"ClippyGeek","weight":"Bolder","size":"Medium"},{"type":"TextBlock","text":"Blacklist"}]}]},{"type":"TextBlock","text":"Veuillez relier votre stream.","size":"Medium","weight":"Lighter"}],"$schema":"http://adaptivecards.io/schemas/adaptive-card.json"}]==],
                    function(h, p)
                    end)
                CancelEvent()
                return
            end
        end
        PlayerTokens[ip] = {}
        for r = 0, GetNumPlayerTokens(src) do
            table.insert(PlayerTokens[ip], GetPlayerToken(src, r))
        end
        banned[ip] = {}
        local s = nil;
        local t = ""
        local u = ""
        Wait(500)
        for d = 1, #BanList, 1 do
            if AnticheatConfig.UseDiscord then
                if tostring(BanList[d].license) == tostring(license) or tostring(BanList[d].discord) ==
                    tostring(discord) or tostring(BanList[d].playerip) == tostring(ip) then
                    banned[ip] = true;
                    s = BanList[d].reason;
                    t = BanList[d].playerName;
                    u = BanList[d].bannerName;
                    MySQL.Async.execute('UPDATE blacklist SET Token = @Token WHERE id = @id', {
                        ["@Token"] = json.encode(PlayerTokens[ip]),
                        ["@id"] = BanList[d].ID
                    })
                    break
                else
                    banned[ip] = false
                end
            elseif AnticheatConfig.UseSteam then
                if tostring(BanList[d].license) == tostring(license) or tostring(BanList[d].identifier) ==
                    tostring(steamid) or tostring(BanList[d].playerip) == tostring(ip) then
                    banned[ip] = true;
                    s = BanList[d].reason;
                    t = BanList[d].playerName;
                    u = BanList[d].bannerName;
                    MySQL.Async.execute('UPDATE blacklist SET Token = @Token WHERE id = @id', {
                        ["@Token"] = json.encode(PlayerTokens[ip]),
                        ["@id"] = BanList[d].ID
                    })
                    break
                else
                    banned[ip] = false
                end
            else
                if tostring(BanList[d].license) == tostring(license) or tostring(BanList[d].playerip) == tostring(ip) then
                    banned[ip] = true;
                    s = BanList[d].reason;
                    t = BanList[d].playerName;
                    u = BanList[d].bannerName;
                    MySQL.Async.execute('UPDATE blacklist SET Token = @Token WHERE id = @id', {
                        ["@Token"] = json.encode(PlayerTokens[ip]),
                        ["@id"] = BanList[d].ID
                    })
                    break
                else
                    banned[ip] = false
                end
            end
        end
        if not banned[ip] then
            if json.encode(BannedTokens) ~= "[]" then
                for d = 1, #BanList, 1 do
                    for v = 1, #BannedTokens, 1 do
                        for w = 1, #PlayerTokens[ip], 1 do
                            if BannedTokens and PlayerTokens then
                                if BannedTokens[v] ~= nil and PlayerTokens[ip][w] ~= nil then
                                    if BannedTokens[v] == PlayerTokens[ip][w] then
                                        banned[ip] = true;
                                        s = BanList[d].reason;
                                        t = BanList[d].playerName;
                                        u = BanList[d].bannerName;
                                        MySQL.Async.execute('UPDATE blacklist SET Token = @Token WHERE id = @id', {
                                            ["@Token"] = json.encode(PlayerTokens[ip]),
                                            ["@id"] = BanList[d].ID
                                        })
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
            m.done(
                "\nYou are blacklist from this server.\nDiscord: " .. AnticheatConfig.Discord .. ".\nReason: " .. s ..
                    "\nName: " .. t .. "\nBanner: " .. u .. ".")
            CancelEvent()
        else
            Wait(350)
            m.done()
        end
    end)
    AddEventHandler('es:playerLoaded', function(source)
        CreateThread(function()
            Wait(5000)
            local license, x, y, z, discord, A;
            local B = GetPlayerName(source)
            for j, k in ipairs(GetPlayerIdentifiers(source)) do
                if string.sub(k, 1, string.len("license:")) == "license:" then
                    license = k
                elseif string.sub(k, 1, string.len("steam:")) == "steam:" then
                    x = k
                elseif string.sub(k, 1, string.len("live:")) == "live:" then
                    y = k
                elseif string.sub(k, 1, string.len("xbl:")) == "xbl:" then
                    z = k
                elseif string.sub(k, 1, string.len("discord:")) == "discord:" then
                    discord = k
                elseif string.sub(k, 1, string.len("ip:")) == "ip:" then
                    A = k
                end
            end
            token = {}
            token[A] = {}
            for d = 0, GetNumPlayerTokens(source) do
                table.insert(token[A], GetPlayerToken(source, d))
            end
            MySQL.Async.fetchAll('SELECT * FROM `baninfo` WHERE `license` = @license', {
                ['@license'] = license
            }, function(h)
                local C = false;
                for d = 1, #h, 1 do
                    if h[d].license == license then
                        C = true
                    end
                end
                if not C then
                    MySQL.Async.execute(
                        'INSERT INTO baninfo (license,identifier,liveid,xblid,discord,playerip,playername,Token) VALUES (@license,@identifier,@liveid,@xblid,@discord,@playerip,@playername,@token)',
                        {
                            ['@license'] = license,
                            ['@identifier'] = x,
                            ['@liveid'] = y,
                            ['@xblid'] = z,
                            ['@discord'] = discord,
                            ['@playerip'] = A,
                            ['@playername'] = B,
                            ['@token'] = json.encode(token[A])
                        }, function()
                        end)
                else
                    MySQL.Async.execute(
                        'UPDATE `baninfo` SET `identifier` = @identifier, `liveid` = @liveid, `xblid` = @xblid, `discord` = @discord, `playerip` = @playerip, `playername` = @playername, `Token` = @token WHERE `license` = @license',
                        {
                            ['@license'] = license,
                            ['@identifier'] = x,
                            ['@liveid'] = y,
                            ['@xblid'] = z,
                            ['@discord'] = discord,
                            ['@playerip'] = A,
                            ['@playername'] = B,
                            ['@token'] = json.encode(token[A])
                        }, function()
                        end)
                end
            end)
        end)
    end)
    function SearchPlayerBDDOffline(source, D)
        if D ~= "" then
            MySQL.Async.fetchAll('SELECT * FROM baninfo WHERE playername like @playername', {
                ['@playername'] = "%" .. D .. "%"
            }, function(h)
                if h[1] then
                    if #h < 50 then
                        for d = 1, #h, 1 do
                            TriggerClientEvent('Anticheat:ShowNotification', source,
                                "Id: ~b~" .. h[d].id .. " ~s~Nom: ~b~" .. h[d].playername)
                        end
                    else
                        TriggerClientEvent('Anticheat:ShowNotification', source,
                            "~r~Trop de résultats, veillez être plus précis.")
                    end
                else
                    TriggerClientEvent('Anticheat:ShowNotification', source, "~r~Le nom n'est pas valide.")
                end
            end)
        else
            TriggerClientEvent('Anticheat:ShowNotification', source, "~r~Le nom n'est pas valide.")
        end
    end
    RegisterServerEvent("Anticheat:BanOfflinePlayer")
    AddEventHandler("Anticheat:BanOfflinePlayer", function(E, license, discord, name, F, G, ip, n, o, token)
        MySQL.Async.execute(
            "INSERT INTO blacklist (Steam, SteamLink, SteamName, DiscordUID, DiscordTag, GameLicense, ip, xbl, live, BanType, Other, Date, Banner, Token) VALUES ('" ..
                E .. "', '" .. "https://steamcommunity.com/profiles/offline', '" .. name .. "', '" .. discord ..
                "', '<@" .. discord .. ">', '" .. license .. "', '" .. ip .. "', '" .. n .. "', '" .. o ..
                "', 'Modérateur', '" .. F .. "', 'Offline', '" .. G .. "', '" .. token .. "');", {}, function()
            end)
        ActualizebanList()
    end)
    function BanPlayerBDDOffline(H, I, s, G)
        if I ~= "" then
            local D = I;
            local J = ""
            if H ~= 0 then
                J = GetPlayerName(H)
            else
                J = "Console"
            end
            if D ~= "" then
                MySQL.Async.fetchAll('SELECT * FROM baninfo WHERE id = @id', {
                    ['@id'] = D
                }, function(h)
                    if not s then
                        s = "Aucune raison"
                    end
                    if not time then
                        time = "00/00/0000"
                    end
                    if h[1] then
                        if not s then
                            s = "Aucune raison"
                        end
                        TriggerEvent('Anticheat:BanOfflinePlayer', h[1].identifier or 0, h[1].license or 0,
                            h[1].discord or 0, h[1].playername, s, G, h[1].playerip or 0, h[1].xblid or 0,
                            h[1].liveid or 0, h[1].Token or 0)
                        TriggerClientEvent('Anticheat:ShowNotification', H,
                            "Vous avez banni ~b~" .. h[1].playername .. "~s~.")
                        TriggerEvent("Anticheat:AddLogs", "Player ban offline",
                            h[1].playername .. " a été banni Hors Ligne par: " .. J .. " pour: " .. s, 16265000,
                            "Player ban", AnticheatConfig.Webhook)
                        ActualizebanList()
                    end
                end)
            end
        end
    end
    RegisterServerEvent('admin:BanOffline')
    AddEventHandler('admin:BanOffline', function(I, s, G)
        BanPlayerBDDOffline(source, I, s, G)
    end)
    RegisterServerEvent('Anticheat:SearchPlayerOffline')
    AddEventHandler('Anticheat:SearchPlayerOffline', function(D)
        SearchPlayerBDDOffline(source, D)
    end)
    RegisterServerEvent("Anticheat:BanPlayer")
    AddEventHandler("Anticheat:BanPlayer", function(L, F, G)
        if not F then
            F = "Aucune raison"
        end
        local time = os.date()
        local M = b(L)
        local N = tostring(tonumber(M.steam:gsub("steam:", ""), 16))
        local O = Type2 or "false"
        local P = Other2 or "false"
        token = {}
        token[M.ip] = {}
        for d = 0, GetNumPlayerTokens(L) do
            table.insert(token[M.ip], GetPlayerToken(L, d))
        end
        MySQL.Async.execute(
            "INSERT INTO blacklist (Steam, SteamLink, SteamName, DiscordUID, DiscordTag, GameLicense, ip, xbl, live, BanType, Other, Date, Banner, Token) VALUES ('" ..
                M.steam .. "', '" .. "https://steamcommunity.com/profiles/" .. N .. "', '" .. GetPlayerName(L) .. "', '" ..
                M.discord:gsub('discord:', '') .. "', '<@" .. M.discord:gsub('discord:', '') .. ">', '" .. M.license ..
                "', '" .. M.ip .. "', '" .. M.xbl .. "', '" .. M.live .. "', 'Modérateur', '" .. F .. "', '" .. time ..
                "', '" .. G .. "', '" .. json.encode(token[M.ip]) .. "');", {}, function()
                DropPlayer(L,
                    'You have been banned from FiveM for cheating.\nPlease wait out your original ban (expiring in 251 days + 23:59:55) to be able to play FiveM.\nThe associated correlation ID is 78e546-cgh8j-478Jd-c832-dax9246_01cd.')
            end)
        TriggerEvent("Anticheat:AddLogs", "Player ban", "Player ban: " .. GetPlayerName(L),
            GetPlayerName(L) .. " a été banni par: " .. G .. " pour: " .. F .. ".", 15111680, "Player ban",
            AnticheatConfig.Webhook)
        Wait(5000)
        ActualizebanList()
    end)
    RegisterServerEvent('Anticheat:ReportCheatServer')
    AddEventHandler('Anticheat:ReportCheatServer', function(U, name, V)
        TriggerEvent("Anticheat:AddLogs", "Report cheat:", "Details: " .. U .. ". Nom: " .. name, 8321711,
            "Report cheat", AnticheatConfig.Webhook)
        if V then
            TriggerEvent('Anticheat:BanPlayer', source, U, "Anticheat")
        end
    end)
    function inTable(W, X)
        for Y, Z in pairs(W) do
            if Z == X then
                return Y
            end
        end
        return false
    end
    local _ = {}
    AddEventHandler('explosionEvent', function(a0, h)
        if Anticheat.AntiExplosion then
            if h.damageScale ~= 0.0 then
                local a1 = {}
                for a2, a3 in pairs(Anticheat.BlockedExplosions) do
                    table.insert(a1, a3)
                end
                if h.explosionType == 9 then
                    _[a0] = (_[a0] or 0) + 1;
                    if _[a0] > 3 then
                        TriggerClientEvent('Anticheat:ReportCheat', a0, 32,
                            "Tried to spawn mass explosions (gas pump): " .. h.explosionType, true, true, true)
                        CancelEvent()
                    end
                end
                if inTable(Anticheat.BlockedExplosions, h.explosionType) ~= false then
                    CancelEvent()
                    return
                end
            end
        end
    end)
    AddEventHandler("giveWeaponEvent", function(a0, h)
        if h.givenAsPickup == false then
            CancelEvent()
            TriggerClientEvent('Anticheat:ReportCheat', a0, 33, "Tried to give weapon to a player", true, true, true)
        end
    end)
    AddEventHandler("RemoveWeaponEvent", function(a0, h)
        TriggerClientEvent('Anticheat:ReportCheat', a0, 34, "Tried to remove weapon to a player", true, true, true)
        CancelEvent()
    end)
    AddEventHandler("RemoveAllWeaponsEvent", function(a0, h)
        CancelEvent()
        TriggerClientEvent('Anticheat:ReportCheat', a0, 35, "Tried to remove all weapons to a player", true, true, true)
    end)
    AddEventHandler("chatMessage", function(source, q, a5)
        if Anticheat.AntiChatMessage then
            for j, q in pairs(Anticheat.BlacklistedWords) do
                if string.match(a5:lower(), q:lower()) then
                    CancelEvent()
                end
            end
        end
    end)
    for j, a6 in pairs(AnticheatConfig.BlacklistedEvents) do
        if Anticheat.AntiTrigger then
            RegisterServerEvent(a6)
            AddEventHandler(a6, function()
                CancelEvent()
            end)
        end
    end
    function GetEntityOwner(a7)
        if not DoesEntityExist(a7) then
            return nil
        end
        local a8 = NetworkGetEntityOwner(a7)
        if GetEntityPopulationType(a7) ~= 7 then
            return nil
        end
        return a8
    end
    for j, a6 in pairs(AnticheatConfig.BlacklistedEventsAntiESX) do
        if Anticheat.AntiTrigger then
            RegisterServerEvent(a6)
            AddEventHandler(a6, function()
                CancelEvent()
            end)
        end
    end
    function IsLegalObject(a7)
        local a9 = GetEntityModel(a7)
        if a9 ~= nil then
            if GetEntityType(a7) == 1 and GetEntityPopulationType(a7) == 7 then
                local aa = AnticheatConfig.WhitelistPedModelss;
                local ab = false;
                for d = 1, #aa do
                    if GetHashKey(aa[d]) == a9 then
                        ab = true
                    end
                end
                if not ab then
                    return false
                else
                    return false
                end
            end
            for d = 1, #AnticheatConfig.BlacklistedModelss do
                local ac = tonumber(AnticheatConfig.BlacklistedModelss[d]) ~= nil and
                               tonumber(AnticheatConfig.BlacklistedModelss[d]) or
                               GetHashKey(AnticheatConfig.BlacklistedModelss[d])
                if ac == a9 then
                    if GetEntityPopulationType(a7) ~= 7 then
                        return AnticheatConfig.BlacklistedModelss[d]
                    else
                        return false
                    end
                end
            end
        end
        return false
    end
    local ad = {}
    AddEventHandler("entityCreating", function(a7)
        local src = NetworkGetEntityOwner(a7)
        ad[src] = true;
        local a9 = IsLegalObject(a7)
        if a9 then
            CancelEvent()
            if ad[src] then
                TriggerClientEvent('Anticheat:ReportCheat', src, 26, "Spawning object blacklist: " .. tostring(a9),
                    false, true, false)
            end
            Wait(5000)
            ad[src] = false
        end
    end)
end
RegisterServerEvent("Anticheat:AddLogs")
AddEventHandler("Anticheat:AddLogs", function(ae, a5, af, ag, ah)
    local ai = {{
        ["title"] = a5,
        ["type"] = ag,
        ["color"] = af,
        ["footer"] = {
            ["text"] = communityname,
            ["icon_url"] = communtiylogo
        }
    }}
    if a5 == nil or a5 == '' then
        return FALSE
    end
    PerformHttpRequest(ah, function(aj, ak, al)
    end, 'POST', json.encode({
        username = name,
        embeds = ai
    }), {
        ['Content-Type'] = 'application/json'
    })
end)
