ESX = nil

local playerGender

Citizen.CreateThread(function()
	while ESX == nil do
		TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
		Citizen.Wait(0)
	end

	while ESX.GetPlayerData().job == nil do
		Citizen.Wait(100)
	end

	ESX.PlayerData = ESX.GetPlayerData()
	TriggerEvent('skinchanger:getSkin', function(skin)
		playerGender = skin.sex
	end)

	PlayerData = ESX.GetPlayerData()
end)

local oPlayer = false
local InVehicle = false
local playerpos = false
local canSellDrugs = false
local candrugssell = false
local afficehtext = false

local notifDrugsId
RegisterCommand('drogue', function()
	if not candrugssell then 
		candrugssell = true
		canSellDrugs = true
		if notifDrugsId then 
			RemoveNotification(notifDrugsId) 
		end
		notifDrugsId = ShowAboveRadarMessage("Vous avez ~g~activé~s~ la revente de drogue.")
	elseif candrugssell then 
		if notifDrugsId then 
			RemoveNotification(notifDrugsId) 
		end
		notifDrugsId = ShowAboveRadarMessage("Vous avez ~r~désactivé~s~ la revente de drogue.")
		candrugssell = false
		canSellDrugs = false
	end
end)

local dT7iYDf4 = {"AIRP", "SANAND", "BEACH", "DELBE", "STAD","WVINE", "SANDY", "MIRR", "CYPRE"}

RequestAnimDict("mp_common")
Citizen.CreateThread(function(prop_name)
	local prop_name = 'p_meth_bag_01_s'
    while true do
		local attente = 500
		
		local handle, ped = FindFirstPed()
		local success
		repeat
			success, ped = FindNextPed(handle)
			local playerpos = GetEntityCoords(GetPlayerPed(-1))
			local pos = GetEntityCoords(ped)
			local oPlayer = GetPlayerPed(-1)
			local InVehicle = IsPedInAnyVehicle(oPlayer, true)
			local playerpos = GetEntityCoords(oPlayer)
			local distance = GetDistanceBetweenCoords(pos, playerpos, true)
			local scRP0, AI0R2TQ6 = GetEntityCoords(oPlayer), oPlayer
				if distance < 5.0 and CanSellToPed(ped) and canSellDrugs and not InVehicle and candrugssell and tableHasValue(dT7iYDf4, GetNameOfZone(scRP0.x, scRP0.y, scRP0.z))then
					attente = 1
					SetBlockingOfNonTemporaryEvents(L, true)
					SetPedRelationshipGroupHash(L, GetHashKey("PLAYER"))
					PlayAmbientSpeech2(ped, "GENERIC_HI", "SPEECH_PARAMS_FORCE")
					drawCenterText("~b~Client~s~: Salut, c'est quoi ton truc ?", 3000)
					SetPedCanRagdollFromPlayerImpact(ped,false)
					if distance < 1.25 and CanSellToPed(ped) and canSellDrugs and candrugssell then
						if canSellDrugs and not InVehicle and candrugssell then
							DrawText3D(pos.x, pos.y, pos.z, "Appuyez sur ~b~E ~w~pour ~g~vendre votre drogue.", 9)
							if IsControlJustPressed(1,38) then	
								if not tableHasValue(dT7iYDf4, GetNameOfZone(scRP0.x, scRP0.y, scRP0.z)) then
									ShowAboveRadarMessage("~r~Vous ne pouvez pas vendre ici.")
								else
									oldped = ped
									SetEntityHeading(ped,GetHeadingFromVector_2d(pos.x-playerpos.x,pos.y-playerpos.y)+180)
									SetEntityHeading(oPlayer,GetHeadingFromVector_2d(pos.x-playerpos.x,pos.y-playerpos.y))
										TaskPlayAnim(oPlayer, "mp_common", "givetake2_a", 2.0, 2.0, 1000, 51, 0, false, false, false)
										TaskPlayAnim(ped, "mp_common", "givetake2_a", 2.0, 2.0, 1000, 51, 0, false, false, false)
										local x,y,z = table.unpack(GetEntityCoords(playerPed))
										prop = CreateObject(GetHashKey(prop_name), x, y, z+0.2,  true,  true, true)
										AttachEntityToEntity(prop, GetPlayerPed(-1), GetPedBoneIndex(GetPlayerPed(-1), 57005), 0.15, 0.01, -0.06, 185.0, 215.0, 180.0, true, true, false, true, 1, true)
										Citizen.Wait(1000)
										TriggerServerEvent("esx_newDrugs:sellDrugs")
										Citizen.Wait(500)
										TaskWanderStandard(ped, 10.0, 10)
										PlayAmbientSpeech2(ped, "GENERIC_HI", "SPEECH_PARAMS_FORCE")
										TaskPlayAnim(ped,"gestures@m@standing@casual","gesture_easy_now",1.0, 1.0, -1, 48, 0, false, false, false)
										DeleteObject(prop)
										SetEntityAsMissionEntity(ped,true,true)
										ClearPedTasks(ped)
										SetPedCanRagdollFromPlayerImpact(ped,true)
										local chance = math.random(0, 99);
										local x,y,z = table.unpack(GetOffsetFromEntityInWorldCoords(PlayerPedId(), 0.0, 0.0, 0.0))
										local coords = {x=x,y=y,z=z}
										if chance >= 0 and chance <= 28 then
											TriggerEvent('esx_xp:Add', 10)
											TaskPlayAnim(ped, "missfbi3_steve_phone", "steve_phone_idle_b", 2.0, 2.0, -1, 51, 0, false, false, false)
											TriggerServerEvent("call:makeCall","police",coords,"Dealer de drogues.")
										end
									afficehtext = true
									break
									Wait(10000)
								end	
							end
						end
					end
				elseif InVehicle then 
					attente = 2500
			end
		until not success
		EndFindPed(handle)
		Wait(attente)
	end
end)

Citizen.CreateThread(function()
	while true do
		local attente = 500
		if candrugssell then 
			attente = 1
			if not IsPedSittingInAnyVehicle(GetPlayerPed(-1)) then
				TriggerServerEvent("esx_newDrugs:canSellDrugs")
				Citizen.Wait(3000)
			end
		end
		Wait(attente)
	end
end)


function CanSellToPed(ped)
	if not IsPedAPlayer(ped) and not IsEntityAMissionEntity(ped) and not IsPedInAnyVehicle(ped,false) and not IsEntityDead(ped) and IsPedHuman(ped) and GetEntityModel(ped) ~= GetHashKey("s_m_y_cop_01") and GetEntityModel(ped) ~= GetHashKey("s_m_y_dealer_01") and GetEntityModel(ped) ~= GetHashKey("mp_m_shopkeep_01") and ped ~= oldped and canSellDrugs then 
		return true
	end
	return false
end


RegisterNetEvent("esx_newDrugs:canSellDrugs")
AddEventHandler("esx_newDrugs:canSellDrugs", function(soldAmount)
	canSellDrugs = soldAmount
end)

RegisterNetEvent("c_drugs:activate_meth")
AddEventHandler("c_drugs:activate_meth",function()
    local ped = GetPlayerPed(-1)
	if not IsPedInAnyVehicle(GetPlayerPed(-1)) then
		TaskStartScenarioInPlace(PlayerPedId(), "WORLD_HUMAN_SMOKING_POT", 0, true)
		Citizen.Wait(10000)
		ClearPedTasks(PlayerPedId())
	end	
    SetTimecycleModifier("spectator5")
	SetPedMotionBlur(playerPed, true)
    if GetEntityHealth(ped) <= 180 then
        SetEntityHealth(ped,GetEntityHealth(ped)+20)
    elseif GetEntityHealth(ped) <= 199 then
        SetEntityHealth(ped,200)
    end
	Citizen.Wait(30000)
    SetTimecycleModifier("default")
	SetPedMotionBlur(playerPed, false)
end)

RegisterNetEvent("c_drugs:activate_weed")
AddEventHandler("c_drugs:activate_weed",function()
    local ped = GetPlayerPed(-1)
	if not IsPedInAnyVehicle(GetPlayerPed(-1)) then
		TaskStartScenarioInPlace(PlayerPedId(), "WORLD_HUMAN_SMOKING_POT", 0, true)
		Citizen.Wait(10000)
		ClearPedTasks(PlayerPedId())
	end	
    SetTimecycleModifier("spectator5")
	SetPedMotionBlur(playerPed, true)
    if GetPedArmour(ped) <= 90 then
        AddArmourToPed(ped,10)
    elseif GetPedArmour(ped) <= 99 then
        SetPedArmour(ped,100)
    end
	Citizen.Wait(55000)
    SetTimecycleModifier("default")
	SetPedMotionBlur(playerPed, false)
end)

RegisterNetEvent("c_drugs:activate_coke")
AddEventHandler("c_drugs:activate_coke",function()
	local playerPed = PlayerId()
	if not IsPedInAnyVehicle(GetPlayerPed(-1)) then
		local playerPedId = PlayerPedId()
		--TaskStartScenarioInPlace(PlayerPedId(), "WORLD_HUMAN_SMOKING_POT", 0, true)
		local dict, anim = "missfbi3_party","snort_coke_b_male3" --Animation cocaine
		ESX.Streaming.RequestAnimDict(dict)
		TaskPlayAnim(playerPedId, dict, anim, 8.0, 8.0, -1, 48, 1, 0, 0, 0)
		Citizen.Wait(10000)
		ClearPedTasks(PlayerPedId())
	end
	local timer = 0
	while timer < 60 do
    SetRunSprintMultiplierForPlayer(playerPed,1.2)
    SetTimecycleModifier("spectator5")
	SetPedMotionBlur(playerPed, true)
	ResetPlayerStamina(PlayerId())
	Citizen.Wait(2000)
	timer = timer + 2
	end
    SetTimecycleModifier("default")
	SetPedMotionBlur(playerPed, false)
    SetRunSprintMultiplierForPlayer(playerPed,1.0)
end)