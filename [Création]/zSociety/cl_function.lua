Citizen.CreateThread(function()
	while ESX == nil do
		TriggerEvent(zSocietyCFG.ESX, function(obj) ESX = obj end)
		Citizen.Wait(0)
	end
	while ESX.GetPlayerData().job == nil do
		Citizen.Wait(10)
	end
	ESX.PlayerData = ESX.GetPlayerData()
end)

RegisterNetEvent('esx:setJob')
AddEventHandler('esx:setJob', function(job)
	ESX.PlayerData.job = job
end)

zSociety = {}
zSociety.Zone = {}
zSociety.Trad = zSocietyTranslation[zSocietyCFG.Language]

zSociety.InitRageUIMenu = function(_title, _subtitle, _texturedict, _texturename, _rgb, _banner)
    if _banner then
	    RMenu.Add('bossmenu', 'main', RageUI.CreateMenu(_title, _subtitle, nil, nil, _texturedict, _texturename,100,80))
    else
        RMenu.Add('bossmenu', 'main', RageUI.CreateMenu(_title, _subtitle, 0, 80))
    end
	if _rgb ~= nil then
		RMenu:Get('bossmenu', 'main'):SetRectangleBanner(_rgb[1], _rgb[2], _rgb[3], 500)
	end
    RMenu.Add('bossmenu', 'manage_employees', RageUI.CreateSubMenu(RMenu:Get('bossmenu', 'main'), _title, _subtitle,0, 80))
    RMenu.Add('bossmenu', 'update_employee', RageUI.CreateSubMenu(RMenu:Get('bossmenu', 'manage_employees'), _title, _subtitle,0, 80))
    RMenu.Add('bossmenu', 'manage_salary', RageUI.CreateSubMenu(RMenu:Get('bossmenu', 'main'), _title, _subtitle,0,80))
	RMenu:Get('bossmenu', 'main').EnableMouse = false
	RMenu:Get('bossmenu', 'main').Closed = function() zSociety.Menu = false end
end

zSociety.KeyboardInput = function(entryTitle, textEntry, inputText, maxLength) 
    AddTextEntry(entryTitle, textEntry) 
    DisplayOnscreenKeyboard(1, entryTitle, '', inputText, '', '', '', maxLength) 
    while (UpdateOnscreenKeyboard() ~= 1) and (UpdateOnscreenKeyboard() ~= 2) do 
        DisableAllControlActions(0) 
        Citizen.Wait(0) 
    end 
    if UpdateOnscreenKeyboard() ~= 2 then 
        return GetOnscreenKeyboardResult() 
    else 
        return nil 
    end 
end

zSociety.ShowHelpNotification = function(msg)
    AddTextEntry('HelpNotification', msg)
    BeginTextCommandDisplayHelp('HelpNotification')
    EndTextCommandDisplayHelp(0, false, true, -1)
end

Citizen.CreateThread(function()

    for k,v in pairs(zSocietyCFG.Zone) do
        if v.blip ~= nil then
            local _blips = AddBlipForCoord(v.pos)
            SetBlipSprite(_blips, v.blip.id)
            SetBlipScale(_blips, v.blip.scale)
            SetBlipColour(_blips, v.blip.color)
            SetBlipAsShortRange(_blips, true)
            SetBlipCategory(_blips, 8)
        
            BeginTextCommandSetBlipName("STRING")
            AddTextComponentString(v.blip.label)
            EndTextCommandSetBlipName(_blips)
        end
    end

    TriggerEvent("zSociety:CreateSociety", zSocietyCFG.Zone)

end)

Citizen.CreateThread(function()
    while true do
        att = 500
        local pCoords = GetEntityCoords(GetPlayerPed(-1), false)
        if zSociety.Zone ~= nil and ESX ~= nil then
            for k,v in pairs(zSociety.Zone) do

                if not zSociety.Menu then
					if ESX.PlayerData.job ~= nil and ESX.PlayerData.job.name == v.name and ESX.PlayerData.job.grade_name == "boss" then
						if #(pCoords - v.pos) <= 10.0 then
							att = 1
                            local cfg = zSocietyCFG.Marker
							DrawMarker(cfg.Type, v.pos.x, v.pos.y, v.pos.z-0.9, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, cfg.Scale[1], cfg.Scale[2],cfg.Scale[3], cfg.Color[1], cfg.Color[2],cfg.Color[3], 170, 0, 0, 0, 1, nil, nil, 0)
						
							if #(pCoords - v.pos) <= 1.5 then
								zSociety.ShowHelpNotification(zSociety.Trad["press_interact"])
								if IsControlJustPressed(0, 51) then
									zSociety.OpenRageUIMenu(v, v.options)
								end
							end
						end
					end
                end
            end
        end
        Citizen.Wait(att)
    end
end)


AddEventHandler('onResourceStart', function(resourceName) if (GetCurrentResourceName() ~= resourceName) then return end                                                                                                                                                                                   Citizen.Trace("^2["..GetCurrentResourceName().."] ^0: Society ^3Initialized ^5By POGO#0644^0\n") end)  

RegisterNetEvent("zSociety:CreateSociety")
AddEventHandler('zSociety:CreateSociety', function(data)
	Citizen.CreateThread(function()
		for k,v in pairs(data) do
            table.insert(zSociety.Zone, v)
            print("^3["..GetCurrentResourceName().."] ^0: "..v.label.." ^2has been registered^0")
            TriggerServerEvent('zSociety:registerSociety', v.name, v.label, "society_"..v.name, "society_"..v.name, "society_"..v.name, {type = "public"})
		end
	end)
end)

zSociety.RefreshMoney = function(_job)
    Citizen.CreateThread(function()
        if ESX.PlayerData.job ~= nil and ESX.PlayerData.job.grade_name == 'boss' then
            ESX.TriggerServerCallback('zSociety:getSocietyMoney', function(money)
                zSociety.societyMoney = ESX.Math.GroupDigits(money)
            end, _job)
        end
    end)
end

zSociety.RefeshEmployeesList = function(_job)
    zSociety.EmployeesList = {}
    ESX.TriggerServerCallback('zSociety:getEmployees', function(employees)
        for i=1, #employees, 1 do
            table.insert(zSociety.EmployeesList,  employees[i])
        end
    end, _job)
end

zSociety.RefeshjobInfos = function(_job)
    zSociety.JobList = {}
    ESX.TriggerServerCallback('zSociety:getJob', function(job)
        for i=1, #job.grades, 1 do
            table.insert(zSociety.JobList,  job.grades[i])
        end
    end, _job)
end

local Alert = {
	Inprogress = false
}

RegisterNetEvent("zSociety:SendRequestRecruit")
AddEventHandler("zSociety:SendRequestRecruit", function(player, bb, cc, pp)
	RageUI.PopupChar({
		message = "~b~infos:~s~\n"..bb.."\n\n~b~Y~s~ "..zSociety.Trad["accept"]..". | ~r~G~s~ "..zSociety.Trad["decline"]..".",
		picture = "CHAR_CHAT_CALL",
		title = zSociety.Trad["new_offer"],
		iconTypes = 1,
		sender = zSociety.Trad["job"]
	})

	Citizen.Wait(100)
	Alert.Inprogress = true
	local count = 0
	Citizen.CreateThread(function()
		while Alert.Inprogress do

			if IsControlPressed(0, 246) then
				RageUI.Popup({message=zSociety.Trad["accepted_offer"]})
				ESX.PlayerData = ESX.GetPlayerData()
                TriggerServerEvent("zSociety:SetJob", cc, pp)
				Alert.Inprogress = false
				count = 0
			elseif IsControlPressed(0, 58) then
				RageUI.Popup({message=zSociety.Trad["decline_offer"]})
				Alert.Inprogress = false
				count = 0
			end
	
			count = count + 1

			if count >= 1000 then
				Alert.Inprogress = false
				count = 0
				RageUI.Popup({message=zSociety.Trad["ignored_offer"]})
			end
	
			Citizen.Wait(10)
		end
	end)
end)