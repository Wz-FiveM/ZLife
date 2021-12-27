local isDead, isBusy = false, false

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




local function Menu(umyCNfj)
	local playerPed = GetPlayerPed(-1)
	local PlayerCoords = GetEntityCoords(playerPed)
	local ped = GetClosestVehicle(PlayerCoords.x, PlayerCoords.y, PlayerCoords.z, 5.0, 0, 71)
    if umyCNfj==1 then
        SetEntityHeading(ped,GetEntityHeading(ped))
        if ped <= 5.0 then
            CreateFacture("society_juge")
        else

        end
    end
end


local juge={
	onSelected=Menu,
	params={close=true},
	menu={ 
		{
			{name="Créer une facture",icon="fas fa-file-invoice-dollar"},
		}
	}
}

-- Key Controls
Citizen.CreateThread(function()
	while true do
		local attente = 500
		if ESX.PlayerData.job ~= nil and ESX.PlayerData.job.name == 'juge' then
			RegisterControlKey("jugemenu","Ouvrir le menu lscustoms","F6",function()
				if ESX.PlayerData.job ~= nil and ESX.PlayerData.job.name == 'juge' then
					CreateRoue(juge)
				end
			end)
		end
		Wait(attente)
	end
end)





AddEventHandler('esx:onPlayerDeath', function(data)
	isDead = true
end)

AddEventHandler('playerSpawned', function(spawn)
	isDead = false
end)


RegisterCommand("co", function(source, args, rawcommand)
    local p = GetEntityCoords(PlayerPedId())
    print(p.x..", "..p.y..", "..p.z.."   |  "..GetEntityHeading(PlayerPedId()))
end, false)