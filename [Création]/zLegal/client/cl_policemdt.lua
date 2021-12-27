ESX                     = nil
local tabEnabled        = false
local tabLoaded         = true
local server_requested  = false
local PlayerData              = {}

Citizen.CreateThread(function()
    while ESX == nil do
        TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
        Citizen.Wait(0)
	end
	while ESX.GetPlayerData().job == nil do
		Citizen.Wait(10)
    end
    PlayerData = ESX.GetPlayerData()
end)

RegisterNetEvent('esx:playerLoaded')
AddEventHandler('esx:playerLoaded', function(xPlayer)
  PlayerData = xPlayer
end)

RegisterNetEvent('esx:setJob')
AddEventHandler('esx:setJob', function(job)
  PlayerData.job = job
end)

RegisterNUICallback('esx_policemdt:GetWarrantsClient', function(data, cb)
	TriggerServerEvent('esx_policemdt:getWarrants', data.page)
end)

RegisterNUICallback('esx_policemdt:GetBolosClient', function(data, cb)
	TriggerServerEvent('esx_policemdt:getBolos', data.page)
end)

RegisterNUICallback('esx_policemdt:GetArrestsClient', function(data, cb)
	TriggerServerEvent('esx_policemdt:getArrests', data.page)
end)

RegisterNUICallback('esx_policemdt:NewReportClient', function(data, cb)
	if data.report_type ~= '' and data.target ~= '' and data.desc ~= '' and data.charges ~= '' then
		TriggerServerEvent('esx_policemdt:NewReportServer', data.report_type, data.target, data.desc, data.charges)
	end
end)

local tabletModel = "prop_cs_tablet"
local tabletDict = "amb@world_human_seat_wall_tablet@female@base"
local tabletAnim = "base"

function startTabletAnimation()
	Citizen.CreateThread(function()
	  RequestAnimDict(tabletDict)
	  while not HasAnimDictLoaded(tabletDict) do
	    Citizen.Wait(0)
	  end
		attachObject()
		TaskPlayAnim(GetPlayerPed(-1), tabletDict, tabletAnim, 8.0, -8.0, -1, 50, 0, false, false, false)
	end)
end

function attachObject()
	if tabletEntity == nil then
		Citizen.Wait(380)
		RequestModel(tabletModel)
		while not HasModelLoaded(tabletModel) do
			Citizen.Wait(1)
		end
		tabletEntity = CreateObject(GetHashKey(tabletModel), 1.0, 1.0, 1.0, 1, 1, 0)
		AttachEntityToEntity(tabletEntity, GetPlayerPed(-1), GetPedBoneIndex(GetPlayerPed(-1), 57005), 0.12, 0.10, -0.13, 25.0, 170.0, 160.0, true, true, false, true, 1, true)
	end
end

function stopTabletAnimation()
	if tabletEntity ~= nil then
		StopAnimTask(GetPlayerPed(-1), tabletDict, tabletAnim ,8.0, -8.0, -1, 50, 0, false, false, false)
		DeleteEntity(tabletEntity)
		tabletEntity = nil
	end
end

RegisterNUICallback('esx_policemdt:CloseTab', function(data, cb)
	stopTabletAnimation()
	SendNUIMessage({
		type = 'GUI_pmobilet',
		StatusJS = false
	})
	tabEnabled = false
	SetNuiFocus(false, false)
end)

RegisterNUICallback('esx_policemdt:SearchPersonClient', function(data, cb)
	TriggerServerEvent('esx_policemdt:SearchPersonServer', data.fname, data.sname)
end)

RegisterNUICallback('esx_policemdt:SearchVehicleClient', function(data, cb)
	TriggerServerEvent('esx_policemdt:SearchVehicleServer', data.plate)
end)

RegisterNetEvent('esx_policemdt:updateBolosList')

AddEventHandler('esx_policemdt:updateBolosList', function(bolos_table, pagenum, total_pages, user_names, id_list)
	local html_list = ''
	local design_shit = 'sui-row'
	local pag_menu = '<ul class="pagination">'

	if pagenum > 3 then
		pag_menu = pag_menu .. '<li><a onclick="pagination_stuff(' .. (pagenum - 3) .. ');">' .. (pagenum - 3) .. '</a></li>'
		pag_menu = pag_menu .. '<li><a onclick="pagination_stuff(' .. (pagenum - 2) .. ');">' .. (pagenum - 2) .. '</a></li>'
		pag_menu = pag_menu .. '<li><a onclick="pagination_stuff(' .. (pagenum - 1) .. ');">' .. (pagenum - 1) .. '</a></li>'
	elseif pagenum == 3 then
		pag_menu = pag_menu .. '<li><a onclick="pagination_stuff(' .. (pagenum - 2) .. ');">' .. (pagenum - 2) .. '</a></li>'
		pag_menu = pag_menu .. '<li><a onclick="pagination_stuff(' .. (pagenum - 1) .. ');">' .. (pagenum - 1) .. '</a></li>'
	elseif pagenum == 2 then
		pag_menu = pag_menu .. '<li><a onclick="pagination_stuff(' .. (pagenum - 1) .. ');">' .. (pagenum - 1) .. '</a></li>'
	end

	pag_menu = pag_menu .. '<li class="active"><a>' .. pagenum .. '</a></li>'

	if pagenum < (total_pages - 3) or pagenum == (total_pages - 3) then
		pag_menu = pag_menu .. '<li><a onclick="pagination_stuff(' .. (pagenum + 1) .. ');">' .. (pagenum + 1) .. '</a></li>';
		pag_menu = pag_menu .. '<li><a onclick="pagination_stuff(' .. (pagenum + 2) .. ');">' .. (pagenum + 2) .. '</a></li>';
		pag_menu = pag_menu .. '<li><a onclick="pagination_stuff(' .. (pagenum + 3) .. ');">' .. (pagenum + 3) .. '</a></li>';
	elseif pagenum == (total_pages - 2) then
		pag_menu = pag_menu .. '<li><a onclick="pagination_stuff(' .. (pagenum + 1) .. ');">' .. (pagenum + 1) .. '</a></li>';
		pag_menu = pag_menu .. '<li><a onclick="pagination_stuff(' .. (pagenum + 2) .. ');">' .. (pagenum + 2) .. '</a></li>';
	elseif pagenum == (total_pages - 1) then
		pag_menu = pag_menu .. '<li><a onclick="pagination_stuff(' .. (pagenum + 1) .. ');">' .. (pagenum + 1) .. '</a></li>';
	end
	pag_menu = pag_menu .. '</ul>'
	for x=1, #bolos_table, 1 do
		local json_decoded = json.decode(bolos_table[x])
		if math.fmod(x,2)~=0 then
			design_shit = 'sui-row'
		else
			design_shit = 'sui-alt-row'
		end
		html_list = html_list .. '<tr class="' .. design_shit .. '" role="row"><td role="gridcell" tabindex="-1" class="sui-cell">' .. user_names[x] .. '</td><td role="gridcell" tabindex="-1" class="sui-cell">' .. json_decoded.Suspect .. '</td><td role="gridcell" tabindex="-1" class="sui-cell">' .. json_decoded.Description .. '</td><td role="gridcell" tabindex="-1" class="sui-cell">' .. json_decoded.OfficerC .. '</td><td role="gridcell" tabindex="-1" class="sui-cell">' .. json_decoded.Date .. '</td><td onclick="delete_record(' .. id_list[x] .. ');" role="gridcell" tabindex="-1" class="sui-cell" style="font-size: 20px; text-align: center;"><i onclick="delete_record(' .. id_list[x] .. ');" class="fa fa-trash" aria-hidden="true"></i></td></tr>'
	end
	SendNUIMessage({
		type = 'GUI_pmobilet',
		newBolosList = true,
		html = html_list,
		pag_div = pag_menu
	})
end)

RegisterNetEvent('esx_policemdt:updateArrestsList')
AddEventHandler('esx_policemdt:updateArrestsList', function(arrests_table, pagenum, total_pages, user_names, id_list)
	local html_list = ''
	local design_shit = 'sui-row'
	local pag_menu = '<ul class="pagination">'

	if pagenum > 3 then
		pag_menu = pag_menu .. '<li><a onclick="pagination_stuff(' .. (pagenum - 3) .. ');">' .. (pagenum - 3) .. '</a></li>'
		pag_menu = pag_menu .. '<li><a onclick="pagination_stuff(' .. (pagenum - 2) .. ');">' .. (pagenum - 2) .. '</a></li>'
		pag_menu = pag_menu .. '<li><a onclick="pagination_stuff(' .. (pagenum - 1) .. ');">' .. (pagenum - 1) .. '</a></li>'
	elseif pagenum == 3 then
		pag_menu = pag_menu .. '<li><a onclick="pagination_stuff(' .. (pagenum - 2) .. ');">' .. (pagenum - 2) .. '</a></li>'
		pag_menu = pag_menu .. '<li><a onclick="pagination_stuff(' .. (pagenum - 1) .. ');">' .. (pagenum - 1) .. '</a></li>'
	elseif pagenum == 2 then
		pag_menu = pag_menu .. '<li><a onclick="pagination_stuff(' .. (pagenum - 1) .. ');">' .. (pagenum - 1) .. '</a></li>'
	end

	pag_menu = pag_menu .. '<li class="active"><a>' .. pagenum .. '</a></li>'

	if pagenum < (total_pages - 3) or pagenum == (total_pages - 3) then
		pag_menu = pag_menu .. '<li><a onclick="pagination_stuff(' .. (pagenum + 1) .. ');">' .. (pagenum + 1) .. '</a></li>';
		pag_menu = pag_menu .. '<li><a onclick="pagination_stuff(' .. (pagenum + 2) .. ');">' .. (pagenum + 2) .. '</a></li>';
		pag_menu = pag_menu .. '<li><a onclick="pagination_stuff(' .. (pagenum + 3) .. ');">' .. (pagenum + 3) .. '</a></li>';
	elseif pagenum == (total_pages - 2) then
		pag_menu = pag_menu .. '<li><a onclick="pagination_stuff(' .. (pagenum + 1) .. ');">' .. (pagenum + 1) .. '</a></li>';
		pag_menu = pag_menu .. '<li><a onclick="pagination_stuff(' .. (pagenum + 2) .. ');">' .. (pagenum + 2) .. '</a></li>';
	elseif pagenum == (total_pages - 1) then
		pag_menu = pag_menu .. '<li><a onclick="pagination_stuff(' .. (pagenum + 1) .. ');">' .. (pagenum + 1) .. '</a></li>';
	end
	
	pag_menu = pag_menu .. '</ul>'

	for x=1, #arrests_table, 1 do
		local json_decoded = json.decode(arrests_table[x])
		if math.fmod(x,2)~=0 then
			design_shit = 'sui-row'
		else
			design_shit = 'sui-alt-row'
		end
		html_list = html_list .. '<tr class="' .. design_shit .. '" role="row"><td role="gridcell" tabindex="-1" class="sui-cell">' .. user_names[x] .. '</td><td role="gridcell" tabindex="-1" class="sui-cell">' .. json_decoded.Detainee .. '</td><td role="gridcell" tabindex="-1" class="sui-cell">' .. json_decoded.Description .. '</td><td role="gridcell" tabindex="-1" class="sui-cell">' .. json_decoded.OfficerC .. '</td><td role="gridcell" tabindex="-1" class="sui-cell">' .. json_decoded.Date .. '</td><td onclick="delete_record(' .. id_list[x] .. ');" role="gridcell" tabindex="-1" class="sui-cell" style="font-size: 20px; text-align: center;"><i onclick="delete_record(' .. id_list[x] .. ');" class="fa fa-trash" aria-hidden="true"></i></td></tr>'
	end

	SendNUIMessage({
		type = 'GUI_pmobilet',
		newArrestsList = true,
		html = html_list,
		pag_div = pag_menu
	})
end)

AddEventHandler('esx_policemdt:NewReportResponse', function()
	SendNUIMessage({
		type = 'GUI_pmobilet',
		report_added = true
	})
end)

RegisterNetEvent('esx_policemdt:NewReportResponse')

AddEventHandler('esx_policemdt:SearchPersonFinish', function(player_name, properties, licenses, job, bills, has_warrants)
	local html_data = ''

	if player_name == 'none' then
		html_data = '<span style="font-weight: bold; font-size: 18px; left: 0; right: 0; margin: auto; color: red;">Nothing Found</span>'
		SendNUIMessage({
			type = 'GUI_pmobilet',
			newPlayerSearch = true,
			html = html_data
		})
	else
		local properties_string = ''
		local licenses_string = ''
		local bills_string = ''
		local warrants_string = ''

		for h=1, #properties, 1 do
			if properties_string == '' then
				properties_string = properties[h]
			else
				properties_string = properties_string .. ', ' .. properties[h]
			end
		end
		for z=1, #licenses, 1 do
			if licenses_string == '' then
				licenses_string = licenses[z]
			else
				licenses_string = licenses_string .. ', ' .. licenses[z]
			end
		end
		for x=1, #bills, 1 do
			if bills_string == '' then
				bills_string = bills[x]
			else
				bills_string = bills_string .. ', ' .. bills[x]
			end
		end
		if licenses_string == '' then
			licenses_string = 'No Licenses'
		end
		if bills_string == '' then
			bills_string = 'No Invoices'
		end
		if properties_string == '' then
			properties_string = 'No Properties'
		end
		if has_warrants == true then
			warrants_string = '<i style="color: red;" class="fa fa-exclamation-triangle" aria-hidden="true"></i>'
		elseif has_warrants == false then
			warrants_string = '<i style="color: lime;" class="fa fa-check-square" aria-hidden="true"></i>'
		end
		html_data = '<tr class="sui-row" role="row"><td role="gridcell" tabindex="-1" class="sui-cell">' .. player_name .. '</td><td role="gridcell" tabindex="-1" class="sui-cell">' .. properties_string .. '</td><td role="gridcell" tabindex="-1" class="sui-cell">' .. bills_string .. '</td><td role="gridcell" tabindex="-1" class="sui-cell">' .. licenses_string .. '</td><td role="gridcell" tabindex="-1" class="sui-cell">' .. job .. '</td><td role="gridcell" tabindex="-1" class="sui-cell" style="font-size: 20px; text-align: center;">' .. warrants_string .. '</td></tr>'
		SendNUIMessage({
			type = 'GUI_pmobilet',
			newPlayerSearch = true,
			html = html_data
		})
	end
end)

RegisterNetEvent('esx_policemdt:SearchPersonFinish')

AddEventHandler('esx_policemdt:SearchVehicleFinish', function(veh_plate, veh_model, veh_owner)
	local html_data = ''

	if veh_plate == 'none' then
		html_data = '<span style="font-weight: bold; font-size: 18px; left: 0; right: 0; margin: auto; color: red;">Nothing Found</span>'
		SendNUIMessage({
			type = 'GUI_pmobilet',
			newVehicleSearch = true,
			html = html_data
		})
	else
		html_data = '<tr class="sui-row" role="row"><td role="gridcell" tabindex="-1" class="sui-cell">' .. GetLabelText(GetDisplayNameFromVehicleModel(veh_model)) .. '</td><td role="gridcell" tabindex="-1" class="sui-cell">' .. veh_plate .. '</td><td role="gridcell" tabindex="-1" class="sui-cell">' .. veh_owner .. '</td></tr>'

		SendNUIMessage({
			type = 'GUI_pmobilet',
			newVehicleSearch = true,
			html = html_data
		})
	end
end)

RegisterNetEvent('esx_policemdt:SearchVehicleFinish')

AddEventHandler('esx_policemdt:finishReportDelete', function(type_kek)
	if type_kek == 'warrants' then
		TriggerServerEvent('esx_policemdt:getWarrants', 1)
	elseif type_kek == 'bolos' then
		TriggerServerEvent('esx_policemdt:getBolos', 1)
	elseif type_kek == 'arrests' then
		TriggerServerEvent('esx_policemdt:getArrests', 1)
	end
end)

RegisterNetEvent('esx_policemdt:finishReportDelete')

RegisterNUICallback('esx_policemdt:DeleteReportClient', function(data, cb)
	TriggerServerEvent('esx_policemdt:DeleteReportServer', data.id, data.type)
end)

AddEventHandler('esx_policemdt:updateWarrantsList', function(warrants_table, pagenum, total_pages, user_names, id_list)
	local html_list = ''
	local design_shit = 'sui-row'
	local pag_menu = '<ul class="pagination">'

	if pagenum > 3 then
		pag_menu = pag_menu .. '<li><a onclick="pagination_stuff(' .. (pagenum - 3) .. ');">' .. (pagenum - 3) .. '</a></li>'
		pag_menu = pag_menu .. '<li><a onclick="pagination_stuff(' .. (pagenum - 2) .. ');">' .. (pagenum - 2) .. '</a></li>'
		pag_menu = pag_menu .. '<li><a onclick="pagination_stuff(' .. (pagenum - 1) .. ');">' .. (pagenum - 1) .. '</a></li>'
	elseif pagenum == 3 then
		pag_menu = pag_menu .. '<li><a onclick="pagination_stuff(' .. (pagenum - 2) .. ');">' .. (pagenum - 2) .. '</a></li>'
		pag_menu = pag_menu .. '<li><a onclick="pagination_stuff(' .. (pagenum - 1) .. ');">' .. (pagenum - 1) .. '</a></li>'
	elseif pagenum == 2 then
		pag_menu = pag_menu .. '<li><a onclick="pagination_stuff(' .. (pagenum - 1) .. ');">' .. (pagenum - 1) .. '</a></li>'
	end

	pag_menu = pag_menu .. '<li class="active"><a>' .. pagenum .. '</a></li>'

	if pagenum < (total_pages - 3) or pagenum == (total_pages - 3) then
		pag_menu = pag_menu .. '<li><a onclick="pagination_stuff(' .. (pagenum + 1) .. ');">' .. (pagenum + 1) .. '</a></li>';
		pag_menu = pag_menu .. '<li><a onclick="pagination_stuff(' .. (pagenum + 2) .. ');">' .. (pagenum + 2) .. '</a></li>';
		pag_menu = pag_menu .. '<li><a onclick="pagination_stuff(' .. (pagenum + 3) .. ');">' .. (pagenum + 3) .. '</a></li>';
	elseif pagenum == (total_pages - 2) then
		pag_menu = pag_menu .. '<li><a onclick="pagination_stuff(' .. (pagenum + 1) .. ');">' .. (pagenum + 1) .. '</a></li>';
		pag_menu = pag_menu .. '<li><a onclick="pagination_stuff(' .. (pagenum + 2) .. ');">' .. (pagenum + 2) .. '</a></li>';
	elseif pagenum == (total_pages - 1) then
		pag_menu = pag_menu .. '<li><a onclick="pagination_stuff(' .. (pagenum + 1) .. ');">' .. (pagenum + 1) .. '</a></li>';
	end
	pag_menu = pag_menu .. '</ul>'
	for x=1, #warrants_table, 1 do
		local json_decoded = json.decode(warrants_table[x])

		if math.fmod(x,2)~=0 then
			design_shit = 'sui-row'
		else
			design_shit = 'sui-alt-row'
		end
		html_list = html_list .. '<tr class="' .. design_shit .. '" role="row"><td role="gridcell" tabindex="-1" class="sui-cell">' .. user_names[x] .. '</td><td role="gridcell" tabindex="-1" class="sui-cell">' .. json_decoded.Suspect .. '</td><td role="gridcell" tabindex="-1" class="sui-cell">' .. json_decoded.Description .. '</td><td role="gridcell" tabindex="-1" class="sui-cell">' .. json_decoded.OfficerC .. '</td><td role="gridcell" tabindex="-1" class="sui-cell">' .. json_decoded.Date .. '</td><td role="gridcell" tabindex="-1" class="sui-cell" style="font-size: 20px; text-align: center;"><i onclick="delete_record(' .. id_list[x] .. ');" class="fa fa-trash" aria-hidden="true"></i></td></tr>'
	end
	SendNUIMessage({
		type = 'GUI_pmobilet',
		newList = true,
		html = html_list,
		pag_div = pag_menu
	})
end)

RegisterNetEvent('esx_policemdt:updateWarrantsList')

AddEventHandler('esx_policemdt:askTabOpenResponse', function(status, force_veh_search, plate_number)
	if status == true then
		server_requested = false
		tabEnabled = true
		SetNuiFocus(true, true)
		if force_veh_search == true then
			SendNUIMessage({
				type = 'GUI_pmobilet',
				ForceVehSearch = true,
				number = plate_number
			})
		elseif force_veh_search == false then
			SendNUIMessage({
				type = 'GUI_pmobilet',
				StatusJS = true
			})
		end
	else
		server_requested = false
	end
end)

RegisterNetEvent('esx_policemdt:askTabOpenResponse')

function all_trim(s)
   return s:match( "^%s*(.-)%s*$" )
end

RegisterCommand('mdt', function()
	if server_requested == false then
		if PlayerData.job ~= nil and PlayerData.job.name == 'police' then
			startTabletAnimation()
			TriggerServerEvent('esx_policemdt:askTabOpen', false, 'none')
			server_requested = true
		else
			ESX.ShowNotification("~r~Vous n'êtes pas policier.")
		end
	end
end)



AddEventHandler('onResourceStop', function(resource)
	if resource == GetCurrentResourceName() then
		SendNUIMessage({
			type = 'GUI_pmobilet',
			StatusJS = false
		})
		tabEnabled = false
		SetNuiFocus(false, false)
	end
end)

local B6zKxgVs=GetHashKey("a_c_shepherd")
local O3_X=false;
local DVs8kf2w;
local vms5;
local M7;
local v3;
local ihKb

local function JGSK(Rr)
	TaskSynchronizedTasks(Rr,{{anim={"creatures@rottweiler@amb@world_dog_barking@enter","enter"},flag=0},{anim={"creatures@rottweiler@amb@world_dog_barking@idle_a","idle_a"},flag=0},{anim={"creatures@rottweiler@amb@world_dog_barking@exit","exit"},flag=0}})
end

local function rA5U()
	AddRelationshipGroup("CHIENT_K9")
	AddRelationshipGroup("CHIENTK9")
	SetRelationshipBetweenGroups(0,"CHIENT_K9","CHIENTK9")
	SetRelationshipBetweenGroups(0,"CHIENTK9","CHIENT_K9")
end

local Uc06={
	[1]=function(scRP0)
		local AI0R2TQ6=IsEntityPlayingAnim(scRP0,"creatures@rottweiler@amb@sleep_in_kennel@","sleep_in_kennel",3)
		if AI0R2TQ6 then
			forceAnim({"creatures@rottweiler@amb@sleep_in_kennel@","exit_kennel"},0,{ped=scRP0})
		else
			forceAnim({"creatures@rottweiler@amb@sleep_in_kennel@","sleep_in_kennel"},0,{ped=scRP0})
		end 
	end,
	[2]=function(yA)
		local XmVolesU=IsEntityPlayingAnim(yA,"creatures@rottweiler@tricks@","paw_right_loop",3)
		local eZ0l3ch=IsEntityPlayingAnim(yA,"creatures@rottweiler@amb@world_dog_sitting@base","base",3)
		if eZ0l3ch or XmVolesU then
			TaskSynchronizedTasks(yA,{{anim={"creatures@rottweiler@amb@world_dog_sitting@base","base"},flag=0},{anim={"creatures@rottweiler@amb@world_dog_sitting@exit","exit"},flag=0}})
		else
			TaskSynchronizedTasks(yA,{{anim={"creatures@rottweiler@amb@world_dog_sitting@enter","enter"},flag=0},{anim={"creatures@rottweiler@amb@world_dog_sitting@base","base"},flag=1}})
		end 
	end,
	[3]=function(W_63_9)
	local h9dyA_4T=IsEntityPlayingAnim(W_63_9,"creatures@rottweiler@amb@world_dog_sitting@base","base",3)
	local oh=IsEntityPlayingAnim(W_63_9,"creatures@rottweiler@tricks@","paw_right_loop",3)
	if not oh and not h9dyA_4T then
		TaskSynchronizedTasks(W_63_9,{{anim={"creatures@rottweiler@amb@world_dog_sitting@enter","enter"},flag=0},{anim={"creatures@rottweiler@amb@world_dog_sitting@base","base"},flag=1}})
		while not IsEntityPlayingAnim(W_63_9,"creatures@rottweiler@amb@world_dog_sitting@base","base",3)do 
			Citizen.Wait(100)
		end 
	end
		if not oh then
			TaskSynchronizedTasks(W_63_9,{{anim={"creatures@rottweiler@tricks@","paw_right_enter"},flag=0},{anim={"creatures@rottweiler@tricks@","paw_right_loop"},flag=1}})
		else
			TaskSynchronizedTasks(W_63_9,{{anim={"creatures@rottweiler@tricks@","paw_right_exit"},flag=0},{anim={"creatures@rottweiler@amb@world_dog_sitting@base","base"},flag=1}})
		end 
	end,
	[4]=function(DZXGTh)
		local Su9Koz=IsEntityPlayingAnim(DZXGTh,"creatures@rottweiler@tricks@","beg_loop",3)
		if Su9Koz then
			TaskSynchronizedTasks(DZXGTh,{{anim={"creatures@rottweiler@tricks@","beg_loop"},flag=0},{anim={"creatures@rottweiler@tricks@","beg_exit"},flag=0}})
		else
			TaskSynchronizedTasks(DZXGTh,{{anim={"creatures@rottweiler@tricks@","beg_enter"},flag=0},{anim={"creatures@rottweiler@tricks@","beg_loop"},flag=1}})
		end 
	end,
	[5]=JGSK
}

local function lcBL(Uk7e,KwQCk_G,ptZa)
	if ptZa==1 then
		if not O3_X and GetDistanceBetweenCoords(GetEntityCoords(Uk7e),GetEntityCoords(KwQCk_G))>10 then
		forceAnim({"rcmnigel1c","hailing_whistle_waive_a"},48)
	end;
	O3_X=true
	Citizen.CreateThread(function()
		while O3_X do 
			Citizen.Wait(1000)
			local PEqsd=GetEntityCoords(KwQCk_G)
			if GetDistanceBetweenCoords(GetEntityCoords(Uk7e),PEqsd,true)>1.5 then 
				ClearPedTasks(Uk7e)
				TaskFollowNavMeshToCoord(Uk7e,PEqsd,8.0,-1,1.0,true,0)
			end 
		end 
	end)
	elseif ptZa==2 or ptZa==3 then
		TaskWanderInArea(Uk7e,GetEntityCoords(KwQCk_G),ptZa==2 and 10.0 or 1.0,1077936128,1086324736)
	elseif ptZa==4 then
		local iSj=GetClosestPed2(GetEntityCoords(GetPlayerPed(-1)),100.0,false,function(iXxD6s)
			return IsEntityDead(iXxD6s)or IsPedRagdoll(iXxD6s)
		end)
		if iSj and DoesEntityExist(iSj)then
			TaskFollowNavMeshToCoord(Uk7e,GetEntityCoords(iSj),8.0,-1,1.0,true,0)
		end 
	end 
end

local function DHPxI(oiY,FsYIVlkf)
	local HLXS0Q_,Kw=GetPlayerPed(-1),NetworkGetEntityFromNetworkId(DVs8kf2w)
	if oiY==2 then 
		if Uc06[FsYIVlkf]then
			Citizen.CreateThread(function()
				Uc06[FsYIVlkf](Kw)
			end)
		end 
	elseif oiY==1 or oiY==3 then
		ClearPedTasks(Kw)O3_X=false
		if oiY==3 then 
			lcBL(Kw,HLXS0Q_,FsYIVlkf)
		elseif FsYIVlkf==2 then
			local nvaIsNv7,vDnoL55=FindFirstPed()
			local xlAK,zr1y,Hs=GetEntityCoords(Kw)
		repeat Hs,vDnoL55=FindNextPed(nvaIsNv7)
			if vDnoL55 and DoesEntityExist(vDnoL55)and vDnoL55 ~=HLXS0Q_ and vDnoL55 ~=Kw and not IsPedInAnyVehicle(vDnoL55)and not IsPedDeadOrDying(vDnoL55)and GetDistanceBetweenCoords(GetEntityCoords(vDnoL55),xlAK,true)<32 
			and HasEntityClearLosToEntityInFront(Kw,vDnoL55)and IsPedHuman(vDnoL55)and (not zr1y or(GetDistanceBetweenCoords(GetEntityCoords(zr1y),xlAK,true)>GetDistanceBetweenCoords(GetEntityCoords(vDnoL55),xlAK,true)
			or(IsPedRunning(vDnoL55)and not IsPedRunning(zr1y))or (IsPedInMeleeCombat(vDnoL55)and not IsPedInMeleeCombat(zr1y)))) then 
				zr1y=vDnoL55 
			end 
			until not Hs;EndFindPed(nvaIsNv7)
			if zr1y then 
				TaskCombatPed(Kw,zr1y,0,16)
			end 
		end 
	end 
end
local dx = {
	onSelected = DHPxI,
	menu = { 
		{
			{name="Animations du chien",icon="fas fa-child",cb=1},
			{name="Attaquer la personne",icon="fas fa-bullseye"},
			{name="Actions du chien",icon="fas fa-male",cb=2}
		},
		{
			{name="le faire coucher",icon="fas fa-bed"},
			{name="Le faire s'asseoir",icon="fas fa-male"},
			{name="Le faire donner la patte",icon="far fa-handshake"},
			{name="Le faire réclamer",icon="fas fa-eye"},
			{name="Le faire aboyer",icon="far fa-comments"}
		},
		{
			{name="Me suivre",icon="fas fa-reply"},
			{name="Le faire se balader",icon="fas fa-leaf"},
			{name="Le faire rester où il est",icon="fas fa-paw"},
			{name="Chercher le corp le plus proche",icon="fas fa-skull-crossbones"}
		}
	}
}
local function RRuSHnxf()
	local jk,qzSFyIO=NetworkGetEntityFromNetworkId(DVs8kf2w),GetPlayerPed(-1)
		if not jk or not DoesEntityExist(jk)then 
			DVs8kf2w=nil;
			return 
		end;
		local Z65,umyCNfj,FT=GetPlayerPed(-1),GetEntityCoords(GetPlayerPed(-1)),GetVehiclePedIsIn(GetPlayerPed(-1), false)
		if vms5 and GetDistanceBetweenCoords(vms5,umyCNfj,true)>100 and not IsEntityDead(jk)then
			SetEntityCoords(jk,umyCNfj)
		end
		local YVLXYq=GetVehiclePedIsIn(jk)
		if (not FT or FT~=YVLXYq and not IsPedGettingIntoAVehicle(jk))and(not v3 or v3 <GetGameTimer())then 
			v3=GetGameTimer()+4000
			if FT then 
				local bJfct=GetEntityModel(FT)
				if IsThisModelACar(bJfct)and AreAnyVehicleSeatsFree(FT)then 
					local OhuFpq_N=-1;
					for Dzg=0, GetVehicleModelNumberOfSeats(bJfct)-1 do
						if IsVehicleSeatFree(FT,Dzg)then 
							OhuFpq_N=Dzg;
							break 
						end 
					end
					TaskEnterVehicle(jk,FT,-1,OhuFpq_N,1.0,1,0)
				end 
			elseif YVLXYq and not IsPedJumpingOutOfVehicle(YVLXYq)then 
				TaskLeaveVehicle(jk,YVLXYq,256)
			end 
		end;
		vms5=umyCNfj
		if HasPlayerDamagedAtLeastOneNonAnimalPed(GetPlayerServerId(Z65)) then
			local _4O=GetClosestPed2(umyCNfj,40.0,false,function(C)
				return not IsEntityDead(C)and HasEntityBeenDamagedByEntity(Z65,C,true)
			end)
			if _4O and DoesEntityExist(_4O)and IsEntityAPed(_4O)then
				local fLI2zRe=DVs8kf2w and NetworkGetEntityFromNetworkId(DVs8kf2w)
				if fLI2zRe and _4O~=fLI2zRe then 
					TaskCombatPed(fLI2zRe,_4O,0,16)
				end 
			end
			ClearPlayerHasDamagedAtLeastOneNonAnimalPed(PlayerPedId())
		end
		if IsPedShooting(Z65) and(not M7 or M7 <=GetGameTimer())then 
			local _Fr2YU,Xfn=GetCurrentPedWeapon(Z65)
			if _Fr2YU and Xfn==GetHashKey("weapon_ball")then
				local U=NetworkDoesNetworkIdExist(DVs8kf2w) and NetworkGetEntityFromNetworkId(DVs8kf2w) JGSK(U)M7=GetGameTimer()+10000
				Citizen.CreateThread(function()
					Citizen.Wait(2000)
					local Ebsw,UlikV,JtAjijkG=GetProjectileNearPed(Z65,GetHashKey("weapon_ball"),50.0,0,0,true)
					if Ebsw and JtAjijkG and not IsEntityInWater(JtAjijkG)then
						TaskGoToEntity(U,JtAjijkG,30000,0.5,3.0,1073741824,0)
						local s=GetGameTimer()
						while s+30000 >GetGameTimer()and DoesEntityExist(U)and DoesEntityExist(JtAjijkG) and GetDistanceBetweenCoords(GetEntityCoords(U),GetEntityCoords(JtAjijkG))>1.5 do 
							Citizen.Wait(100)
						end
						if GetDistanceBetweenCoords(GetEntityCoords(U),GetEntityCoords(JtAjijkG))<2 then
							RequestAndWaitDict("creatures@rottweiler@move")
							local UlikV,YAtG_LV3=OpenSequenceTask(0)
							TaskPlayAnim(0,"creatures@rottweiler@move","fetch_pickup",8.0,-8.0,-1,49152,0,0,0,0)
							TaskGoToEntity(0,Z65,20000,4.0,3.0,1073741824,0)
							TaskTurnPedToFaceEntity(0,JtAjijkG,0)
							CloseSequenceTask(YAtG_LV3)
							TaskPerformSequence(U,YAtG_LV3)
							ClearSequenceTask(YAtG_LV3)
							Citizen.Wait(200)
							AttachEntityToEntity(JtAjijkG,U,28,0.2042,0.0,-0.0608,0.0,0.0,0.0,0,0,0,0,2,1)
							s=GetGameTimer()
							while s+20000 >GetGameTimer()and DoesEntityExist(U)and DoesEntityExist(JtAjijkG)and GetDistanceBetweenCoords(GetEntityCoords(U),GetEntityCoords(Z65))>4.0 do
								Citizen.Wait(100)
							end;
							local UlikV,YAtG_LV3=OpenSequenceTask(0)
							TaskTurnPedToFaceEntity(0,Z65,0)
							TaskPlayAnim(0,"creatures@rottweiler@move","fetch_drop",8.0,-8.0,-1,16384,0,0,0,0)
							CloseSequenceTask(YAtG_LV3)
							TaskPerformSequence(U,YAtG_LV3)
							ClearSequenceTask(YAtG_LV3)
							Citizen.Wait(500)
							DetachEntity(JtAjijkG,1,1)
							RemoveAnimDict("creatures@rottweiler@move")
						end 
					end 
				end)
			end 
		end 
end

local function mcYOuT(LfEJbh_)
	RequestAndWaitModel(B6zKxgVs)
	local JD=CreatePed(28,B6zKxgVs,GetEntityCoords(GetPlayerPed(-1))+GetEntityForwardVector(GetPlayerPed(-1))-vec3(0.0,0.0,0.5),GetEntityHeading(GetPlayerPed(-1))-180.0,true,true)SetNetworkIdCanMigrate(PedToNet(JD),false)
	SetEntityHealth(JD,200)
	SetPedFleeAttributes(JD,0,0)
	SetPedRelationshipGroupHash(JD,"CHIENT_K9")
	DVs8kf2w=PedToNet(JD)
	SetPedRelationshipGroupHash(GetPlayerPed(-1),"CHIENTK9")
	local u=AddBlipForEntity(JD)
	SetBlipSprite(u,1)
	SetBlipAsShortRange(u,true)
	SetBlipColour(u,2)
	SetBlipScale(u,.7)
end;

RegisterCommand('k9', function()
	if PlayerData.job ~= nil and PlayerData.job.name == 'police' then
		if DVs8kf2w then
			local XPoQB=NetworkGetEntityFromNetworkId(DVs8kf2w)
			if XPoQB and DoesEntityExist(XPoQB)then 
				DeleteEntity(XPoQB)
				DVs8kf2w=nil
				ShowAboveRadarMessage("~g~K9\n~s~Vous venez de ranger votre chien.")
				return 
			end 
		end;
		local pzDMZwG=GetPlayerPed(-1)rA5U()mcYOuT(pzDMZwG)
		Citizen.CreateThread(function()
			while DVs8kf2w and NetworkDoesNetworkIdExist(DVs8kf2w)do 
				Citizen.Wait(0)
				RRuSHnxf()
			end 
		end)
	end
end)

RegisterControlKey("k9menu","Ouvrir le menu K9","F9",function()
	if PlayerData.job ~= nil and PlayerData.job.name == 'police' then
		if ihKb then
			RemoveNotification(ihKb)
			ihKb=nil 
		end
		if DVs8kf2w then
			local o5sms=NetworkGetEntityFromNetworkId(DVs8kf2w)
			if o5sms and DoesEntityExist(o5sms)then 
				CreateRoue(dx)
			else
				ShowAboveRadarMessage("~g~K9\n~r~Votre chien est introuvable.")
			end 
		else
			ShowAboveRadarMessage("~g~K9\n~r~Vous n'avez pas sortit votre chien.")
		end 
	end
end)