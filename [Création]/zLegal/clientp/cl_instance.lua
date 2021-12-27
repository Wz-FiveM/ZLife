local instance, instancedPlayers, registeredInstanceTypes, playersToHide = {}, {}, {}, {}
local instanceInvite, insideInstance
local inInstance = false
ESX = nil

Citizen.CreateThread(function()
	while ESX == nil do
		TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
		Citizen.Wait(0)
	end
end)

local ihKb = {
	{
		model = "v_ilev_rc_door2",
		pos = vec3(1005.292, -2998.266, -47.49689)
	}, {
		model = "v_ilev_fa_frontdoor",
		pos = vec3(-14.86892, -1441.182, 31.19323)
	}, {
		model = "v_ilev_epsstoredoor",
		pos = vec3(241.3621, 361.047, 105.8883)
	}, {
		model = "v_ilev_mm_doorm_l",
		pos = vec3(-816.716, 179.098, 72.82738)
	}, {
		model = "v_ilev_mm_doorm_r",
		pos = vec3(-816.1068, 177.5109, 72.82738)
	}, {
		model = "prop_bh1_48_backdoor_r",
		pos = vec3(-794.1853, 182.568, 73.04045)
	}, {
		model = "prop_bh1_48_backdoor_l",
		pos = vec3(-793.3943, 180.5075, 73.04045)
	}, {
		model = "prop_bh1_48_backdoor_r",
		pos = vec3(-794.5051, 178.0124, 73.04045)
	}, {
		model = "prop_bh1_48_backdoor_l",
		pos = vec3(-796.5657, 177.2214, 73.04045)
	}, {
		model = "v_ilev_trevtraildr",
		pos = vec3(1972.769, 3815.366, 33.66326)
	}, {
		model = "v_ilev_trev_doorfront",
		pos = vec3(-1149.709, -1521.088, 10.78267)
	}, {
		model = "v_ilev_mm_door",
		pos = vec3(-806.287, 185.785, 72.48)
	}, {
		model = "v_ilev_lester_doorfront",
		pos = vec3(1273.82, -1720.7, 54.92)
	}, {
		model = "v_ilev_fh_frontdoor",
		pos = vec3(7.52, 539.53, 176.18)
	}, {
		model = "v_ilev_trev_doorfront",
		pos = vec3(-1149.71, -1521.09, 10.78)
	}, {
		model = "v_ilev_janitor_frontdoor",
		pos = vec3(-107.54, -9.02, 70.67)
	}
}
local M7 = 0
function JGSK(AI0R2TQ6, yA)
	local XmVolesU = "OFFLINE_DOOR_" .. (yA and "PEM_" or "") .. (AI0R2TQ6.id or M7)
	if not IsDoorRegisteredWithSystem(XmVolesU) then
		local eZ0l3ch = AI0R2TQ6.pos or AI0R2TQ6.position
		AddDoorToSystem(XmVolesU, AI0R2TQ6.model, eZ0l3ch.x, eZ0l3ch.y, eZ0l3ch.z, false, false, false)
	end
	AI0R2TQ6.hash = XmVolesU;
	M7 = M7 + 1
end
local function rA5U(W_63_9, h9dyA_4T)
	DoorSystemSetDoorState(W_63_9.hash, h9dyA_4T and 1 or 0, false, false)
end
local function lcBL()
	for Su9Koz, Uk7e in pairs(ihKb) do
		rA5U(Uk7e, true)
	end
end
function DoorInitialize()
	for pE, RSjapQ in pairs(ihKb) do
		JGSK(RSjapQ, true)
	end
	lcBL()
end

DoorInitialize()

CreateThread(function()
    while true do
        Wait(3000)
        local sVBxyy = LocalPlayer()
        if not inInstance then
            for N9d, S7 in pairs(GetActivePlayers()) do
                local bJtvRSR = GetPlayerPed(S7)
				if bJtvRSR ~= sVBxyy.Ped then
                    NetworkConcealPlayer(S7, false, false)
                end
            end
        end
    end
end)

local notifInstanceId

function GetInstance()
	return instance
end

function CreateInstance(type, data)
	TriggerServerEvent('instance:create', type, data)
end

function CloseInstance()
	instance = {}
	TriggerServerEvent('instance:close')
	insideInstance = false

	SetEntityCollision(GetPlayerPed(-1), true, true)
	for k, v in pairs(GetActivePlayers()) do 
		if NetworkIsPlayerConcealed(v) then
			print('sortie instance')
			NetworkConcealPlayer(v, false, false) 
		end 
	end
end

function EnterInstance(instance)
	insideInstance = true
	TriggerServerEvent('instance:enter', instance.host)

	if registeredInstanceTypes[instance.type].enter then
		registeredInstanceTypes[instance.type].enter(instance)
	end
end

function LeaveInstance()
	if instance.host then
		if #instance.players > 1 then

		end
		inInstance = false
		if registeredInstanceTypes[instance.type].exit then
			registeredInstanceTypes[instance.type].exit(instance)
		end
		inInstance = false

		print('sortie instance')
		for k, v in pairs(GetActivePlayers()) do 
			if v ~= GetPlayerIndex() then 
				NetworkConcealPlayer(v, false, false) 
			end 
		end

		TriggerServerEvent('instance:leave', instance.host)
	end

	insideInstance = false
end

function InviteToInstance(type, player, data)
	TriggerServerEvent('instance:invite', instance.host, type, player, data)
end

function RegisterInstanceType(type, enter, exit)
	registeredInstanceTypes[type] = {
		enter = enter,
		exit  = exit
	}
end

AddEventHandler('instance:get', function(cb)
	cb(GetInstance())
end)

AddEventHandler('instance:create', function(type, data)
	if notifInstanceId then 
		RemoveNotification(notifInstanceId)
	end
	inInstance = true 
	notifInstanceId = ShowAboveRadarMessage("~g~Vous êtes rentré dans l'habitation.")
	CreateInstance(type, data)
end)

AddEventHandler('instance:close', function()
	inInstance = false
	CloseInstance()
end)

AddEventHandler('instance:enter', function(_instance)
	if notifInstanceId then 
		RemoveNotification(notifInstanceId)
	end
	inInstance = true
	notifInstanceId = ShowAboveRadarMessage("~g~Vous êtes rentré dans l'habitation.")
	EnterInstance(_instance)
end)

AddEventHandler('instance:leave', function()
	inInstance = false
	LeaveInstance()
end)

AddEventHandler('instance:invite', function(type, player, data)
	InviteToInstance(type, player, data)
end)

AddEventHandler('instance:registerType', function(name, enter, exit)
	RegisterInstanceType(name, enter, exit)
end)

RegisterNetEvent('instance:onInstancedPlayersData')
AddEventHandler('instance:onInstancedPlayersData', function(_instancedPlayers)
	instancedPlayers = _instancedPlayers
end)

RegisterNetEvent('instance:onCreate')
AddEventHandler('instance:onCreate', function(_instance)
	instance = {}
end)

RegisterNetEvent('instance:onEnter')
AddEventHandler('instance:onEnter', function(_instance)
	instance = _instance

	print('enter instance1')

	for k, v in pairs(GetActivePlayers()) do 
		if v ~= GetPlayerIndex() then 
			NetworkConcealPlayer(v, true, true) 
		end 
	end
end)

RegisterNetEvent('instance:onLeave')
AddEventHandler('instance:onLeave', function(_instance)
	inInstance = false
	instance = {}

	SetEntityCollision(GetPlayerPed(-1), true, true)
    for iPL3B4cr, GI2hz6SK in pairs(GetActivePlayers()) do
		if NetworkIsPlayerConcealed(GI2hz6SK) then
			print('sortie instance')
            NetworkConcealPlayer(GI2hz6SK, true, true)
        end
    end
end)

RegisterNetEvent('instance:onClose')
AddEventHandler('instance:onClose', function(_instance)
	inInstance = false
	instance = {}

	SetEntityCollision(GetPlayerPed(-1), true, true)
    for iPL3B4cr, GI2hz6SK in pairs(GetActivePlayers()) do
		if NetworkIsPlayerConcealed(GI2hz6SK) then
			print('sortie instance')
            NetworkConcealPlayer(GI2hz6SK, true, true)
        end
    end
end)

RegisterNetEvent('instance:onPlayerEntered')
AddEventHandler('instance:onPlayerEntered', function(_instance, player)
	instance = _instance
	local playerName = GetPlayerName(GetPlayerFromServerId(player))

	if notifInstanceId then 
		RemoveNotification(notifInstanceId)
	end
	inInstance = true 
	notifInstanceId = ShowAboveRadarMessage("~b~"..playerName.." ~g~est rentré dans l\'habitation.")
end)

RegisterNetEvent('instance:onPlayerLeft')
AddEventHandler('instance:onPlayerLeft', function(_instance, player)
	instance = _instance
	local playerName = GetPlayerName(GetPlayerFromServerId(player))

	ESX.ShowNotification("~b~"..playerName.." ~r~est sorti de l\'habitation.")
end)

RegisterNetEvent('instance:onInvite')
AddEventHandler('instance:onInvite', function(_instance, type, data)
	instanceInvite = {
		type = type,
		host = _instance,
		data = data
	}

	Citizen.CreateThread(function()
		Citizen.Wait(10000)

		if instanceInvite then
			if notifInstanceId then 
				RemoveNotification(notifInstanceId)
			end
			notifInstanceId = ShowAboveRadarMessage("~r~Invitation expirée")
			instanceInvite = nil
		end
	end)
end)

RegisterInstanceType('default')

-- Controls for invite
Citizen.CreateThread(function()
	while true do
		local attente = 500

		if instanceInvite then
			attente = 1
			ShowAboveRadarMessage("Appuyez sur ~b~E ~s~pour ~g~entrer~s~ dans la propriété.")

			if IsControlJustReleased(0, 38) then
				EnterInstance(instanceInvite)
				if notifInstanceId then 
					RemoveNotification(notifInstanceId)
				end
				notifInstanceId = ShowAboveRadarMessage("~g~Vous êtes rentré dans l'habitation.")
				inInstance = true
				instanceInvite = nil
			end
		end
		if inInstance then
			attente = 1
            DisablePlayerFiring(PlayerId(), true)
            DisableControlAction(0, 22, true)
            DisableControlAction(0, 24, true)
            DisableControlAction(0, 25, true)
            DisableControlAction(0, 257, true)
            DisableControlAction(0, 263, true)
            DisableControlAction(0, 264, true)
            DisableControlAction(0, 140, true)
		end
		Wait(attente)
	end
end)

-- Instance players
Citizen.CreateThread(function()
	while true do
		Citizen.Wait(1000)
		playersToHide = {}

		if instance.host then
			-- Get players and sets them as pairs
			for k,v in ipairs(GetActivePlayers()) do
				playersToHide[GetPlayerServerId(v)] = true
			end

			-- Dont set our instanced players invisible
			for _,player in ipairs(instance.players) do
				playersToHide[player] = nil
			end
		else
			for player,_ in pairs(instancedPlayers) do
				playersToHide[player] = true
			end
		end
	end
end)

Citizen.CreateThread(function()
	TriggerEvent('instance:loaded')
end)

local function OnSelected(self, _, btn, PMenu, menuData, currentButton, currentBtn, currentSlt, result, slide)
	local slide = btn.slidenum
	local btn = btn.name
	local check = btn.unkCheckbox
	local MenuSelect = menuData.currentMenu
	if btn == "Donner les clés de la propriété" then 
		ExecuteCommand("givepropertykey")
	elseif btn == "Retirer les clés de la propriété" then 
		ExecuteCommand("removepropertykey")
	end
end

local MenuInstance = {
	Base = { Header = {"commonmenu", "interaction_bgd"}, Color = {color_black}, HeaderColor = {50, 160, 205}, Title = "Propriété"},
	Data = { currentMenu = "Actions :"},
	Events = { onSelected = OnSelected},
	Menu = {
		["Actions :"] = {
			b = {
				{name = "Donner les clés de la propriété",ask = "→", askX = true},
				{name = "Retirer les clés de la propriété",ask = "→", askX = true}
			}
		}
	}
}

RegisterControlKey("onemenuinstance","Ouvrir le menu des propriétés","O",function()
	if inInstance then 
		CreateMenu(MenuInstance)
	end
end)