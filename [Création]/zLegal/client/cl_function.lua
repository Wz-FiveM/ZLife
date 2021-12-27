function Notification(msg)
	SetNotificationTextEntry('STRING')
	AddTextComponentSubstringPlayerName(msg)
	DrawNotification(false, true)
end

RegisterNetEvent("report:Notification")
AddEventHandler("report:Notification", function(msg) 
	Notification(msg) 
end)

RegisterNetEvent("report:Open/CloseReport")
AddEventHandler("report:Open/CloseReport", function(type, nomdumec, raisondumec)
    if type == 1 then
        ESX.TriggerServerCallback('report:getUsergroup', function(group)
            if group == 'superadmin' or group == 'admin' or group == 'mod' then
                ESX.ShowNotification('Un nouveau report à été effectué !')
            end
        end)
    elseif type == 2 then
        ESX.TriggerServerCallback('report:getUsergroup', function(group)
            if group == 'superadmin' or group == 'admin' or group == 'mod' then
                ESX.ShowNotification('Le report de ~b~'..nomdumec..'~s~ à été fermé !')
            end
        end)
    end
end)

function TeleportInPlayer(iddumec) 
    if iddumec then
        local PlayerPos = GetEntityCoords(GetPlayerPed(GetPlayerFromServerId(iddumec)))
        SetEntityCoords(PlayerPedId(), PlayerPos.x, PlayerPos.y, PlayerPos.z)
    end
end

function TeleportPlayerInYou(iddugars)
    if iddugars then
        local plyPedCoords = GetEntityCoords(PlayerPedId())
        TriggerServerEvent('report:bring', iddugars, plyPedCoords, "bring")
    end
end

RegisterNetEvent('report:bring')
AddEventHandler('report:bring', function(plyPedCoords)
    plyPed = PlayerPedId()
	SetEntityCoords(plyPed, plyPedCoords)
end)




function keybord()
	local _return = nil

	DisplayOnscreenKeyboard(1,"FMMC_KEY_TIP8", "", "", "", "", "", 99)
	while true do
		DisableAllControlActions(0)
		HideHudAndRadarThisFrame()
		Citizen.Wait(0)

		if UpdateOnscreenKeyboard() == 1 then
			_return = GetOnscreenKeyboardResult()
			break
		elseif UpdateOnscreenKeyboard() == 2 or UpdateOnscreenKeyboard() == 3 then
			break
		end
	end

	return _return
end