ESX 			    			= nil
local callActive = false
local haveTarget = false
local isCall = false
local work = {}
local target = {}

Citizen.CreateThread(function()
	while ESX == nil do
		TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
		Citizen.Wait(0)
	end
end)

local notifVdk
local blip
Citizen.CreateThread(function()
    while true do
        Citizen.Wait(1)
		if IsControlJustPressed(1, 38) and callActive then
			if blip then 
				RemoveBlip(blip)
			end
			TriggerServerEvent("call:getCall", work)
			if notifVdk then 
				RemoveNotification(notifVdk)
			end
			notifVdk = ShowAboveRadarMessage("~g~Vous avez accepté l'appel.")
			blip = createBlip(target.pos,4,2,"Destination",true,0.25)
			haveTarget = true
			isCall = true
			callActive = false
		elseif IsControlJustPressed(1, 73) and callActive then
			if notifVdk then 
				RemoveNotification(notifVdk)
			end
			notifVdk = ShowAboveRadarMessage("~r~Vous avez refusé l'appel.")
			callActive = false
			RemoveBlip(blip)
        end
		if haveTarget then
			local playerPos = GetEntityCoords(GetPlayerPed(-1), true)
			if Vdist(target.pos.x, target.pos.y, target.pos.z, playerPos.x, playerPos.y, playerPos.z) < 30.0 then
				DrawMarker(1, target.pos.x, target.pos.y, target.pos.z-1, 0, 0, 0, 0, 0, 0, 2.0, 2.0, 1.0, 0, 174, 255, 200, 0, 0, 0, 0)
				if Vdist(target.pos.x, target.pos.y, target.pos.z, playerPos.x, playerPos.y, playerPos.z) < 2.0 then
					if notifVdk then 
						RemoveNotification(notifVdk)
					end
					ShowAboveRadarMessage("~g~Vous êtes arrivé à destination.")
					RemoveBlip(blip)
					haveTarget = false
					isCall = false
					callActive = false
				end
			end
		end
    end
end)

RegisterNetEvent("call:cancelCall")
AddEventHandler("call:cancelCall", function()
	RemoveBlip(blip)
	if haveTarget then
		RemoveBlip(blip)
        haveTarget = false
		isCall = false
		callActive = false
	else
		ShowAboveRadarMessage("~r~Vous n'avez aucun appel en cours.")
	end
end)

RegisterNetEvent("call:callIncoming")
AddEventHandler("call:callIncoming", function(job, pos, msg)
    callActive = true
    work = job
    target.pos = pos
	coords = GetEntityCoords(GetPlayerPed(-1))
	dist = CalculateTravelDistanceBetweenPoints(coords.x,coords.y,coords.z,target.pos.x,target.pos.y,target.pos.z)
	namestreet = ""..GetStreetNameFromHashKey(GetStreetNameAtCoord(target.pos.x,target.pos.y,target.pos.z)).." ("..math.ceil(dist).."m)"
	
	if work == "police" then
		ShowAboveRadarMessageIcon("CHAR_CALL911",1,"Centrale","~b~Appel d'urgence: 911","~b~Identité : ~s~Centrale ~n~~b~Localisation : ~s~"..namestreet.."\n~b~Infos : ~s~"..msg.."")
		ShowAboveRadarMessage("Accepter: ~g~E~s~ ou ~r~X~s~")
		TriggerServerEvent('esx_addons_gcphone:startCall', "police", msg, {
			x = target.pos.x,
			y = target.pos.y,
			z = target.pos.z
		})
	elseif work == "taxi" then
		ShowAboveRadarMessageIcon("CHAR_TAXI",1,"Centrale","~b~Appel d'urgence","~b~Identité : ~s~Centrale ~n~~b~Localisation : ~s~"..namestreet.."\n~b~Infos : ~s~"..msg.."")
		ShowAboveRadarMessage("Accepter: ~g~E~s~ ou ~r~X~s~")
		TriggerServerEvent('esx_addons_gcphone:startCall', "taxi", msg, {
			x = target.pos.x,
			y = target.pos.y,
			z = target.pos.z
		})
	elseif work == "ambulance" then
		ShowAboveRadarMessageIcon("CHAR_CALL911",1,"Centrale","~b~Appel d'urgence: 911","~b~Identité : ~s~Centrale ~n~~b~Localisation : ~s~"..namestreet.."\n~b~Infos : ~s~"..msg.."")
		ShowAboveRadarMessage("Accepter: ~g~E~s~ ou ~r~X~s~")
		TriggerServerEvent('esx_addons_gcphone:startCall', "ambulance", msg, {
			x = target.pos.x,
			y = target.pos.y,
			z = target.pos.z
		})
	elseif work == "ltds" then
		ShowAboveRadarMessageIcon("CHAR_CALL911",1,"Centrale","~b~Appel d'urgence","~b~Identité : ~s~Centrale ~n~~b~Localisation : ~s~"..namestreet.."\n~b~Infos : ~s~"..msg.."")
		ShowAboveRadarMessage("Accepter: ~g~E~s~ ou ~r~X~s~")
		TriggerServerEvent('esx_addons_gcphone:startCall', "ltds", msg, {
			x = target.pos.x,
			y = target.pos.y,
			z = target.pos.z
		})
	elseif work == "lscustoms" then
		ShowAboveRadarMessageIcon("CHAR_LS_CUSTOMS",1,"Centrale","~b~Appel d'urgence","~b~Identité : ~s~Centrale ~n~~b~Localisation : ~s~"..namestreet.."\n~b~Infos : ~s~"..msg.."")
		ShowAboveRadarMessage("Accepter: ~g~E~s~ ou ~r~X~s~")
		TriggerServerEvent('esx_addons_gcphone:startCall', "lscustoms", msg, {
			x = target.pos.x,
			y = target.pos.y,
			z = target.pos.z
		})
	elseif work == "cardealer" then
		ShowAboveRadarMessageIcon("CHAR_CARSITE",1,"Centrale","~b~Appel d'urgence","~b~Identité : ~s~Centrale ~n~~b~Localisation : ~s~"..namestreet.."\n~b~Infos : ~s~"..msg.."")
		ShowAboveRadarMessage("Accepter: ~g~E~s~ ou ~r~X~s~")
		TriggerServerEvent('esx_addons_gcphone:startCall', "cardealer", msg, {
			x = target.pos.x,
			y = target.pos.y,
			z = target.pos.z
		})
	end
end)

RegisterNetEvent("call:taken")
AddEventHandler("call:taken", function(a)
	callActive = true
end)

AddEventHandler('playerDropped', function()
	TriggerServerEvent("player:serviceOff", nil)
end)

