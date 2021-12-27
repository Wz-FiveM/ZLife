ESX = nil
local PlayerData = {}

Citizen.CreateThread(function()
	while ESX == nil do
		TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
		Citizen.Wait(0)
	end

	while ESX.GetPlayerData().job == nil do
		Citizen.Wait(100)
	end

	ESX.PlayerData = ESX.GetPlayerData()
end)

RegisterNetEvent('esx:playerLoaded')
AddEventHandler('esx:playerLoaded', function(xPlayer)
    ESX.PlayerData = xPlayer
end)

RegisterNetEvent('esx:setJob')
AddEventHandler('esx:setJob', function(job)
    ESX.PlayerData.job = job
end)

function GetPlayers()
    local players = {}

    for _,player in ipairs(GetActivePlayers()) do
        local ped = GetPlayerPed(player)

        if DoesEntityExist(ped) then
            table.insert(players, player)
        end
    end

    return players
end

RegisterCommand('facture', function()
    local pPedJob = ESX.PlayerData.job.name
    CreateFacture("society_"..pPedJob.."")
end)

RegisterNetEvent("facture:get")
AddEventHandler("facture:get",function(_facture)
    ShowAboveRadarMessage("Facture :\n~b~Motif : ~s~".._facture.title.."\n~b~Montant : ~s~".._facture.montant.."~b~$")
    ShowAboveRadarMessage("Accepter : ~b~E")
    local veuxpayer = false
    local paied = false
    veuxpayer = true
    Citizen.CreateThread(function()
        while true do 
            Wait(1)
            if veuxpayer and IsControlJustPressed(1, 51) then 
                veuxpayer = false
                TriggerServerEvent("facture:pay",_facture.montant, _facture.account)
                TriggerPlayerEvent("esx:showNotification",_facture.source,"~g~La personne a accepté de payer.")
                local dict, anim = "mp_common", "givetake2_a"
                ESX.Streaming.RequestAnimDict(dict)
                TaskPlayAnim(GetPlayerPed(-1), dict, anim, 2.0, 2.0, 1000, 51, 0, false, false, false)
                PlaySoundFrontend(-1, 'Bus_Schedule_Pickup', 'DLC_PRISON_BREAK_HEIST_SOUNDS', false)
                paied = true
            end
            if veuxpayer and IsControlJustPressed(1, 73) then 
                veuxpayer = false
                ShowAboveRadarMessage("~r~Vous avez refusé de payer.")
                TriggerPlayerEvent("esx:showNotification",_facture.source,"~r~La personne a refusé de payer.")
                paied = true
            end
        end
    end)
    Wait(6000)
    if not paied then
        ShowAboveRadarMessage("~r~Vous avez refusé de payer.")
        TriggerPlayerEvent("esx:showNotification",_facture.source,"~r~La personne n'a pas payé.")
    end
    veuxpayer = false
    _facture = {}
end)