
local GUI = {}
GUI.Time = 0
local HasAlreadyEnteredMarker = false
local LastZone = nil
local CurrentAction = nil
local CurrentActionMsg = ''
local CurrentActionData = {}
local OnJob = false
local Blipsltds = {}
local JobBlipsltds = {}
local JobBlipsltds2 = {}
local Blips2ltds = {}
local JobBlips2ltds = {}
local serviceuni = false

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



local function selectltdsmenu(Ped, Select)
	if Select == 1 then 
		messageltdsnotfinish = true
		local amount = KeyboardInput("Annonce", "", 250)
		if amount ~= nil then
			amount = string.len(amount)
			if amount >= 10 then 
				TriggerServerEvent('clp_taxi:annonceltds',result)  
				messageltdsnotfinish = false
			else
				ESX.ShowNotification("~r~Votre message est trop court.")
			end
		end
	elseif Select == 2 then 
		CreateFacture("society_taxi")
	end
end

local MenuTaxi ={
    onSelected=selectltdsmenu,
    params={close=true},
    menu={
        {
            {name="Passer une annonce",icon="fab fa-affiliatetheme"},
            {name="Faire une facture",icon="fas fa-file-invoice-dollar"}
        }
    }
}



RegisterNetEvent('esx:playerLoaded')
AddEventHandler('esx:playerLoaded', function(xPlayer)
	ESX.PlayerData = xPlayer
end)

RegisterNetEvent('esx:setJob')
AddEventHandler('esx:setJob', function(job)
	ESX.PlayerData.job = job
end)




-- Key Controls
Citizen.CreateThread(function()
    while true do
        local attente = 500
	
		if ESX.PlayerData.job ~= nil and ESX.PlayerData.job.name == 'taxi' then
			RegisterControlKey("ltdsmenu","Ouvrir le menu LTD","F6",function()
				if ESX.PlayerData.job ~= nil and ESX.PlayerData.job.name == 'taxi' then
					CreateRoue(MenuTaxi)
				end
			end)
		end
		Wait(attente)
	end
end)