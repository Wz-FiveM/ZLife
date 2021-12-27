Citizen.CreateThread(function()
	while true do
        Citizen.Wait(10000)
        local name = GetPlayerName(PlayerId())
        local id = GetPlayerServerId(PlayerId())
        Citizen.InvokeNative(GetHashKey("ADD_TEXT_ENTRY"), 'FE_THDR_GTAO', '~b~Zlife ~s~| ID: ' .. id)
        SetRichPresence(id .. " | ".. name .. "")
        SetDiscordAppId(851107899055931423)
        SetDiscordRichPresenceAsset('zlife')
        SetDiscordRichPresenceAssetText('Zlife')
        SetDiscordRichPresenceAssetSmall('discord')
        SetDiscordRichPresenceAssetSmallText('discord.gg//zlife')
        AddTextEntry('PM_PANE_LEAVE', '~r~Se déconnecter');
        AddTextEntry('PM_PANE_QUIT', '~r~Quitter FiveM');
        AddTextEntry('PM_PANE_CFX', '~b~Zlife');
        AddTextEntry("INPUT_HUD_SPECIAL","Ouvrir téléphone/Zoom Radar");
        AddTextEntry("INPUT_SELECT_CHARACTER_FRANKLIN","Menu métiers");
        AddTextEntry("INPUT_SELECT_CHARACTER_MICHAEL","Menu personnel");
        AddTextEntry("INPUT_CINEMATIC_SLOWMO","Mode son radio");
        AddTextEntry("INPUT_DETONATE","Interaction joueur");
    end
end)