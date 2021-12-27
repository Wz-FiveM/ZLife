local Radio = {
	Open = false,
	on = {
		F1 = false,
		F2 = false
	},
	FSelect = nil,
	FEnter = false,
	FSaisi = 0,
	Enabled = true,
	Handle = nil,
	Prop = `prop_cs_hand_radio`,
	Bone = 28422,
	Offset = vector3(0.0, 0.0, 0.0),
	Rotation = vector3(0.0, 0.0, 0.0),
	Dictionary = {
		"cellphone@",
		"cellphone@in_car@ds",
		"cellphone@str",    
		"random@arrests",  
	},
	Animation = {
		"cellphone_text_in",
		"cellphone_text_out",
		"cellphone_call_listen_a",
		"generic_radio_chatter",
	},
	Focus = false,
}
local haveactivater = false

local RadioTouch = {
	--key_showRadio = {name = "Sortir/Ranger la Radio", active = false, type = "keyboard", defaultKey = "f2"},
	--key_selectF = {name = "Selectionner Fréquence", active = false, type = "", defaultKey = ""},
	--key_startF1 = {name = "Allumer/Eteindre F1", active = false, type = "", defaultKey = ""},
	--key_startF2 = {name = "Allumer/Eteindre F2", active = false, type = "", defaultKey = ""},
	--key_volumeUp = {name = "Augmenter le volume", active = false, type = "", defaultKey = ""},
	--key_volumeDown = {name = "Baisser le volume", active = false, type = "", defaultKey = ""},
	key_ParlerF1 = {name = "Parler sur F1", active = false, type = "keyboard", defaultKey = "CAPITAL"},
	key_ParlerF2 = {name = "Parler sur F2", active = false, type = "keyboard", defaultKey = "o"},
	--key_MouseMode = {name = "Passer en mode souris", active = false, type = "keyboard", defaultKey = "RCONTROL"},
	key_ParlerF1Pad = {name = "Radio (Manettes)", active = false, type = "pad_digitalbutton", defaultKey = "f"},
}

local Menu21JCScaleform = nil
local Menu21JCHelper = nil

AddEventHandler("onClientResourceStart", function(resName)
	if GetCurrentResourceName() ~= resName and "mumble-voip" ~= resName then
		return
	end
	
	exports["mumble-voip"]:SetMumbleProperty("radioEnabledF1", false) -- Disable radio control
	exports["mumble-voip"]:SetMumbleProperty("radioEnabledF2", false) -- Disable radio control

end)

local h;
local DsjQx = false
RegisterNetEvent('useradiomumble')
AddEventHandler('useradiomumble', function(j, k, l)
    if not DsjQx then
        if h then
            RemoveNotification(h)
        end
        h = ShowAboveRadarMessage("~w~Vous avez ~g~allumé~w~ votre radio.")
        DsjQx = true
    elseif DsjQx then
        if h then
            RemoveNotification(h)
        end
        h = ShowAboveRadarMessage("~w~Vous avez ~r~éteint~w~ votre radio.")
        DsjQx = false
    end
end)

RegisterControlKey("openradio", "Ouvrir votre radio", "P", function()
	if DsjQx then
		if Radio.Open then
			TriggerEvent("randPickupAnim")
			OpencloseRadio(false)
			SetNuiFocus(false, false)
			SetKeepInputMode(false)
			Radio.Focus = false
		else
			local frequence = GetResourceKvpString("freqQ")
			TriggerEvent("randPickupAnim")
			OpencloseRadio(true)
			Radio.FSelect = nil
			if frequence ~= nil and frequence ~= 0 and not haveactivater then 
				changeRadioScreen("F1", "OFF - "..frequence)
				radioConfig.Frequency.Current["F1"] = frequence
			else
				changeRadioScreen("bot", "FREQUENCES")
			end
			SetNuiFocus(true, true)
			SetKeepInputMode(true)
			Radio.Focus = true
		end
    else
        ShowAboveRadarMessage("~r~Vous n'avez pas de radio équipée.")
    end
end)

Citizen.CreateThread(function()
	RegisterKeyMap()
	OpencloseRadio(false)

	Menu21JCScaleform = RequestScaleformMovie("instructional_buttons")
    while not HasScaleformMovieLoaded(Menu21JCScaleform) do
        Citizen.Wait(0)
    end

	while true do      

		Citizen.Wait(0)
		-- Init local vars
		-- players infos
		local playerPed = PlayerPedId()
		local isFalling = IsPedFalling(playerPed)
		local isDead = IsEntityDead(playerPed)
		-- radio infos
		--local isActivatorPressed = RadioTouch["key_showRadio"].active
		--local isSelectFPressed = RadioTouch["key_selectF"].active
		--local isStartF1Pressed = RadioTouch["key_startF1"].active
		--local isStartF2Pressed = RadioTouch["key_startF2"].active
		--local isVolumeUpPressed = RadioTouch["key_volumeUp"].active
		--local isVolumeDownPressed = RadioTouch["key_volumeDown"].active
		local isMousePower = IsControlJustReleased(0, radioConfig.Controls.MouseFocus.Key)
		--local isMouseMode = RadioTouch["key_MouseMode"].active
		local isParlerF1 = RadioTouch["key_ParlerF1"].active or RadioTouch["key_ParlerF1Pad"].active
		local isParlerF2 = RadioTouch["key_ParlerF2"].active

		-- annimation infos
		local broadcastType = 4 + (Radio.Open and -1 or 0)
		local broadcastDictionary = Radio.Dictionary[broadcastType]
		local broadcastAnimation = Radio.Animation[broadcastType]
		local isBroadcasting = (isParlerF1 or isParlerF2)
		local isPlayingBroadcastAnim = IsEntityPlayingAnim(playerPed, broadcastDictionary, broadcastAnimation, 3)
		local dictionaryType = 1 + (IsPedInAnyVehicle(playerPed, false) and 1 or 0)
		local animationType = 1 + (Radio.Open and 0 or 1)
		local dictionary = Radio.Dictionary[dictionaryType]
		local animation = Radio.Animation[animationType]

		RequestAnimDict(dictionary)
		while not HasAnimDictLoaded(dictionary) do
			Citizen.Wait(150)
		end

		if isDead and (Radio.Focus or Radio["on"]["F1"] or Radio["on"]["F2"]) then
			SetNuiFocus(false, false)
			SetKeepInputMode(false)
			Radio.Focus = false
			changeRadioScreen("F1", "OFF - "..radioConfig.Frequency.Current["F1"])
			Radio["on"]["F1"] = false
			changeRadioScreen("F2", "OFF - "..radioConfig.Frequency.Current["F2"])
			Radio["on"]["F2"] = false

			exports["mumble-voip"]:SetRadioChannel("F1", 0)
			exports["mumble-voip"]:SetRadioChannel("F2", 0)
			exports["mumble-voip"]:SetMumbleProperty("radioEnabledF1", false)
			exports["mumble-voip"]:SetMumbleProperty("radioEnabledF2", false)
		end

		-- IF RADIO OPEN
		if Radio.Open then
			local dictionaryType = 1 + (IsPedInAnyVehicle(playerPed, false) and 1 or 0)
			local openDictionary = Radio.Dictionary[dictionaryType]
			local openAnimation = Radio.Animation[1]
			local isPlayingOpenAnim = IsEntityPlayingAnim(playerPed, openDictionary, openAnimation, 3)

			if isFalling or isDead then
				OpencloseRadio(false)
				SetNuiFocus(false, false)
				SetKeepInputMode(false)
				Radio.Focus = false
				--------- ANNIMATION --------
				TaskPlayAnim(playerPed, dictionary, animation, 4.0, -1, -1, 48, 0, false, false, false)
				Citizen.Wait(700)
				StopAnimTask(playerPed, dictionary, animation, 1.0)
				NetworkRequestControlOfEntity(Radio.Handle)
				while not NetworkHasControlOfEntity(Radio.Handle) and count < 5000 do
					Citizen.Wait(0)
					count = count + 1
				end
				DetachEntity(Radio.Handle, true, false)
				DeleteEntity(Radio.Handle)
				------------ END ------------
			end

			if isVolumeUpPressed and not radioConfig.Controls.Input.Pressed then
				if Radio.FSelect ~= nil and Radio["on"][Radio.FSelect] then
					if radioConfig["Frequency"]["volume"][Radio.FSelect] < 100 then
						radioConfig["Frequency"]["volume"][Radio.FSelect] = radioConfig["Frequency"]["volume"][Radio.FSelect] + 5
					end
					changeRadioScreen(Radio.FSelect, radioConfig.Frequency.Current[Radio.FSelect].."MHz "..radioConfig["Frequency"]["volume"][Radio.FSelect].."%")
					exports["mumble-voip"]:setRadioVolume(Radio.FSelect, radioConfig["Frequency"]["volume"][Radio.FSelect])
				end
				--RadioTouch["key_volumeUp"].active = false
			end 

			if isVolumeDownPressed and not radioConfig.Controls.Input.Pressed then
				if Radio.FSelect ~= nil and Radio["on"][Radio.FSelect] then
					if radioConfig["Frequency"]["volume"][Radio.FSelect] > 0 then
						radioConfig["Frequency"]["volume"][Radio.FSelect] = radioConfig["Frequency"]["volume"][Radio.FSelect] - 5
					end
					changeRadioScreen(Radio.FSelect, radioConfig.Frequency.Current[Radio.FSelect].."MHz "..radioConfig["Frequency"]["volume"][Radio.FSelect].."%")
					exports["mumble-voip"]:setRadioVolume(Radio.FSelect, radioConfig["Frequency"]["volume"][Radio.FSelect])
				end
				--RadioTouch["key_volumeDown"].active = false
			end 

			if isMouseMode then
				SetNuiFocus(true, true)
				SetKeepInputMode(true)
				Radio.Focus = true
			end

			if not radioConfig.Controls.Input.Pressed then
				if IsControlJustPressed(0, radioConfig.Controls.Input.Key) and Radio.FSelect ~= nil and not Radio["on"][Radio.FSelect] then
					changeRadioScreen("freq", "")
					radioConfig.Controls.Input.Pressed = true
					Citizen.CreateThread(function()
						AddTextEntry('RADIO_FREQ_ENTER', "Entrer une frequence "..Radio.FSelect)
						DisplayOnscreenKeyboard(1, "RADIO_FREQ_ENTER", "test", radioConfig.Frequency.Current[Radio.FSelect], "", "", "", 3)

						TriggerEvent("21_interaction:allowEmote", false)
						while UpdateOnscreenKeyboard() ~= 1 and UpdateOnscreenKeyboard() ~= 2 do
							Citizen.Wait(150)
						end
						TriggerEvent("21_interaction:allowEmote", true)

						local input = nil

						if UpdateOnscreenKeyboard() ~= 2 then
							input = GetOnscreenKeyboardResult()
						end

						Citizen.Wait(500)

						input = tonumber(input)
						if input ~= nil then
							if input > 0 and input <= 800 and input == math.floor(input) then
								radioConfig.Frequency.Current[Radio.FSelect] = input
								changeRadioScreen(Radio.FSelect, "OFF - "..input)
							else
								changeRadioScreen("freq", "ERREUR FREQ \nINVALIDE")
								changeRadioScreen("red", "true")
							end
						else
							changeRadioScreen("freq", "ERREUR FREQ \nINVALIDE")
							changeRadioScreen("red", "true")
						end
						
						radioConfig.Controls.Input.Pressed = false
					end)
				end
			end

			if Radio["on"]["F1"] and isParlerF1 and not isPlayingBroadcastAnim then
				exports["mumble-voip"]:TalkRadio("F1","+")
				--------- ANNIMATION --------
				RequestAnimDict(broadcastDictionary)
				while not HasAnimDictLoaded(broadcastDictionary) do
					Citizen.Wait(150)
				end
				PlaySoundFrontend(-1, "Off_High", "MP_RADIO_SFX", 0)
				TaskPlayAnim(playerPed, broadcastDictionary, broadcastAnimation, 8.0, -8, -1, 49, 0, 0, 0, 0)
				------------ END ------------
			end
			if Radio["on"]["F2"] and isParlerF2 and not isParlerF1 and not isPlayingBroadcastAnim then
				exports["mumble-voip"]:TalkRadio("F2","+")
				--------- ANNIMATION --------
				RequestAnimDict(broadcastDictionary)
				while not HasAnimDictLoaded(broadcastDictionary) do
					Citizen.Wait(150)
				end
				PlaySoundFrontend(-1, "Off_High", "MP_RADIO_SFX", 0)
				TaskPlayAnim(playerPed, broadcastDictionary, broadcastAnimation, 8.0, -8, -1, 49, 0, 0, 0, 0)
				------------ END ------------
			end
			if not isBroadcasting and isPlayingBroadcastAnim then
				exports["mumble-voip"]:EndTalkRadio()
				--------- ANNIMATION --------
				PlaySoundFrontend(-1, "Start_Squelch", "CB_RADIO_SFX", 0)
				StopAnimTask(playerPed, broadcastDictionary, broadcastAnimation, -4.0)
				------------ END ------------
			end

		else
			if Radio["on"]["F1"] and isParlerF1 and not isPlayingBroadcastAnim then
				exports["mumble-voip"]:TalkRadio("F1","+")
				--------- ANNIMATION --------
				RequestAnimDict(broadcastDictionary)
				while not HasAnimDictLoaded(broadcastDictionary) do
					Citizen.Wait(150)
				end
				PlaySoundFrontend(-1, "Off_High", "MP_RADIO_SFX", 0)
				TaskPlayAnim(playerPed, broadcastDictionary, broadcastAnimation, 8.0, 0.0, -1, 49, 0, 0, 0, 0)
				------------ END ------------
			end
			if Radio["on"]["F2"] and isParlerF2 and not isParlerF1 and not isPlayingBroadcastAnim then
				exports["mumble-voip"]:TalkRadio("F2","+")
				--------- ANNIMATION --------
				RequestAnimDict(broadcastDictionary)
				while not HasAnimDictLoaded(broadcastDictionary) do
					Citizen.Wait(150)
				end
				PlaySoundFrontend(-1, "Off_High", "MP_RADIO_SFX", 0)
				TaskPlayAnim(playerPed, broadcastDictionary, broadcastAnimation, 8.0, 0.0, -1, 49, 0, 0, 0, 0)
				------------ END ------------
			end
			if not isBroadcasting and isPlayingBroadcastAnim then
				exports["mumble-voip"]:EndTalkRadio()
				--------- ANNIMATION --------
				PlaySoundFrontend(-1, "Start_Squelch", "CB_RADIO_SFX", 0)
				StopAnimTask(playerPed, broadcastDictionary, broadcastAnimation, -4.0)
				------------ END ------------
			end
		end
	end
end)
local notifRadio1Id
function StartRadio(FREQ)
	if Radio["on"][FREQ] then
		changeRadioScreen(FREQ, "OFF - "..radioConfig.Frequency.Current[FREQ])
		Radio["on"][FREQ] = false
	else
		changeRadioScreen(FREQ, radioConfig.Frequency.Current[FREQ].."MHz "..radioConfig["Frequency"]["volume"][FREQ].."%")
		Radio["on"][FREQ] = true
	end

	exports["mumble-voip"]:SetMumbleProperty("radioEnabled"..FREQ, Radio["on"][FREQ])

	if Radio["on"][FREQ] then
		SendNUIMessage({type = "radiosound", sound = "audio_on", volume = 0.3})
		TriggerEvent('clp_radioopenui', true, "true")
		if notifRadio1Id then 
			RemoveNotification(notifRadio1Id) 
		end
		notifRadio1Id = ShowAboveRadarMessage("Vous avez ~g~activé~s~ la radio avec la fréquence ~g~"..radioConfig.Frequency.Current[FREQ].."Hz~s~.")
		ExecuteCommand('me active sa radio')
		haveactivater = true
		Radio:Add(FREQ, radioConfig.Frequency.Current[FREQ])
		SetResourceKvp("freqQ", radioConfig.Frequency.Current[FREQ])
	else
		SendNUIMessage({type = "radiosound", sound = "audio_off", volume = 0.5})
		TriggerEvent('clp_radioopenui', false, "fasle")
		if notifRadio1Id then 
			RemoveNotification(notifRadio1Id) 
		end
		notifRadio1Id = ShowAboveRadarMessage("Vous avez ~r~désactivé~s~ la radio avec la fréquence ~r~"..radioConfig.Frequency.Current[FREQ].."Hz~s~.")
		haveactivater = false
		ExecuteCommand('me désactive sa radio')
		Radio:Remove(FREQ)
	end
	changeRadioScreen("freq", "")
end

RegisterNetEvent("leaveRadio")
AddEventHandler("leaveRadio", function()
	OpencloseRadio(false)
	SetNuiFocus(false, false)
	SetKeepInputMode(false)
	Radio.Focus = false
	TriggerEvent('clp_radioopenui', false, "fasle")
	Radio:Remove("F1")
	Radio:Remove("F2")
	changeRadioScreen("F1", "OFF - "..radioConfig.Frequency.Current["F1"])
	Radio["on"]["F1"] = false
	changeRadioScreen("F2", "OFF - "..radioConfig.Frequency.Current["F2"])
	Radio["on"]["F2"] = false
	DsjQx = false
end)

function RegisterKeyMap()
	for Radio,value in pairs(RadioTouch) do
	    RegisterKeyMapping("+"..Radio, value.name, value.type, value.defaultKey)
	    RegisterCommand("+"..Radio, function() 
	        RadioTouch[Radio].active = true
	    end, false)
	    RegisterCommand("-"..Radio, function() 
	        RadioTouch[Radio].active = false
	    end, false)
	end
end

function OpencloseRadio(display)
	Radio.Open = display
	changeRadioScreen("freq", "")
	SendNUIMessage({
        type = "radionui",
		displayRadionui = display
    })
end

function changeRadioScreen(who, content)
	SendNUIMessage({
        type = "radionuiMsg",
		radionuiMsgWho = who,
		radionuicontent = content
    })
end

-- Add player to radio channel
function Radio:Add(freq, id)
	exports["mumble-voip"]:SetRadioChannel(freq, id)
end

-- Remove player from radio channel
function Radio:Remove(freq)
	exports["mumble-voip"]:SetRadioChannel(freq, 0)
end

AddEventHandler('onResourceStop', function(name)
    if name == GetCurrentResourceName() then
		SetNuiFocus(false, false)
		SetKeepInputMode(false)
    end
end)

function updateMenu21JCScaleform(_scaleform, _data)
    if _data ~= nil then
        Citizen.InvokeNative(0xF6E48914C7A8694E, _scaleform, "CLEAR_ALL") -- BeginScaleformMovieMethod
        Citizen.InvokeNative(0xC6796A8FFA375E53) -- EndScaleformMovieMethod
        for k,v in ipairs(_data) do 
            Citizen.InvokeNative(0xF6E48914C7A8694E, _scaleform, "SET_DATA_SLOT") -- BeginScaleformMovieMethod
            Citizen.InvokeNative(0xC3D0841A0CC546A6, k) -- ScaleformMovieMethodAddParamInt
            Citizen.InvokeNative(0xBA7148484BD90365, v.input) -- PushScaleformMovieMethodParameterString
            Citizen.InvokeNative(0xBA7148484BD90365, v.text) -- PushScaleformMovieMethodParameterString
            Citizen.InvokeNative(0xC6796A8FFA375E53) -- EndScaleformMovieMethod
        end
        Citizen.InvokeNative(0xF6E48914C7A8694E, _scaleform, "DRAW_INSTRUCTIONAL_BUTTONS") -- BeginScaleformMovieMethod
        Citizen.InvokeNative(0xC3D0841A0CC546A6, 0) -- ScaleformMovieMethodAddParamInt
        Citizen.InvokeNative(0xC6796A8FFA375E53) -- EndScaleformMovieMethod
        DrawScaleformMovieFullscreen(Menu21JCScaleform, 255, 255, 255, 255, 0)
    end
    return _scaleform
end

RegisterNUICallback("CloseCursorMode", function ( data,cb )
	SetNuiFocus(false, false)
	SetKeepInputMode(false)
	OpencloseRadio(false)
	Radio.Focus = false
end)

RegisterNUICallback("ClickTouchRadio", function ( data,cb )
	if not Radio.FEnter then
		if data["touch"] == "b1" then
			StartRadio("F1")
		end
		if data["touch"] == "b2" then
			StartRadio("F2")
		end

		if data["touch"] == "f1" then
			changeRadioScreen("bot", "Actif : F1")
			Radio.FSelect = "F1"
			changeRadioScreen("freq", "")
		end
		if data["touch"] == "f2" then
			changeRadioScreen("bot", "Actif : F2")
			Radio.FSelect = "F2"
			changeRadioScreen("freq", "")
		end
	end
	if Radio.FSelect ~= nil then
		if data["touch"] == "top" and not Radio.FEnter and not Radio["on"][Radio.FSelect] then
			if radioConfig.Frequency.Current[Radio.FSelect] < 800 then
				local newFreq = radioConfig.Frequency.Current[Radio.FSelect] + 1
				radioConfig.Frequency.Current[Radio.FSelect] = newFreq
				changeRadioScreen(Radio.FSelect, "OFF - "..newFreq)
			end
		end
		if data["touch"] == "bot" and not Radio.FEnter and not Radio["on"][Radio.FSelect] then
			if radioConfig.Frequency.Current[Radio.FSelect] > 1 then
				local newFreq = radioConfig.Frequency.Current[Radio.FSelect] - 1
				radioConfig.Frequency.Current[Radio.FSelect] = newFreq
				changeRadioScreen(Radio.FSelect, "OFF - "..newFreq)
			end
		end

		if data["touch"] == "top" and not Radio.FEnter and Radio["on"][Radio.FSelect] then
			if Radio.FSelect ~= nil and Radio["on"][Radio.FSelect] then
				if radioConfig["Frequency"]["volume"][Radio.FSelect] < 100 then
					radioConfig["Frequency"]["volume"][Radio.FSelect] = radioConfig["Frequency"]["volume"][Radio.FSelect] + 5
				end
				changeRadioScreen(Radio.FSelect, radioConfig.Frequency.Current[Radio.FSelect].."MHz "..radioConfig["Frequency"]["volume"][Radio.FSelect].."%")
				exports["mumble-voip"]:setRadioVolume(Radio.FSelect, radioConfig["Frequency"]["volume"][Radio.FSelect])
				PlaySoundFrontend(-1, "End_Squelch", "CB_RADIO_SFX", 0)
				drawCenterText("Volume de la radio à "..radioConfig["Frequency"]["volume"][Radio.FSelect].."%", 2000)
			end
		end
		if data["touch"] == "bot" and not Radio.FEnter and Radio["on"][Radio.FSelect] then
			if Radio.FSelect ~= nil and Radio["on"][Radio.FSelect] then
				if radioConfig["Frequency"]["volume"][Radio.FSelect] > 0 then
					radioConfig["Frequency"]["volume"][Radio.FSelect] = radioConfig["Frequency"]["volume"][Radio.FSelect] - 5
				end
				changeRadioScreen(Radio.FSelect, radioConfig.Frequency.Current[Radio.FSelect].."MHz "..radioConfig["Frequency"]["volume"][Radio.FSelect].."%")
				exports["mumble-voip"]:setRadioVolume(Radio.FSelect, radioConfig["Frequency"]["volume"][Radio.FSelect])
				PlaySoundFrontend(-1, "End_Squelch", "CB_RADIO_SFX", 0)
				drawCenterText("Volume de la radio à "..radioConfig["Frequency"]["volume"][Radio.FSelect].."%", 2000)
			end
		end

		if data["touch"] == "ok" and Radio.FEnter then
			if Radio.FSaisi ~= nil then
				if Radio.FSaisi > 0 and Radio.FSaisi <= 800 and Radio.FSaisi == math.floor(Radio.FSaisi) then
					radioConfig.Frequency.Current[Radio.FSelect] = Radio.FSaisi
					changeRadioScreen(Radio.FSelect, "OFF - "..Radio.FSaisi)
					changeRadioScreen("freq", "")
				else
					changeRadioScreen("freq", "ERREUR FREQ \nINVALIDE")
					changeRadioScreen("red", "true")
				end
			else
				changeRadioScreen("freq", "ERREUR FREQ \nINVALIDE")
				changeRadioScreen("red", "true")
			end
			Radio.FEnter = false
			Radio.FSaisi = 0
		end
		if data["touch"] == "set" and not Radio.FEnter  and not Radio["on"][Radio.FSelect] then
			Radio.FEnter = true
			changeRadioScreen("freq", "ENTER "..Radio.FSelect.." :")
			changeRadioScreen("red", "false")
		end
		if Radio.FEnter and Radio.FSaisi < 100 then
			if data["touch"] == "1" then
				Radio.FSaisi = Radio.FSaisi*10
				Radio.FSaisi = Radio.FSaisi + 1
				changeRadioScreen("freq", "ENTER "..Radio.FSelect.." : "..tostring(Radio.FSaisi))
			end
			if data["touch"] == "2" then
				Radio.FSaisi = Radio.FSaisi*10
				Radio.FSaisi = Radio.FSaisi + 2
				changeRadioScreen("freq", "ENTER "..Radio.FSelect.." : "..tostring(Radio.FSaisi))
			end
			if data["touch"] == "3" then
				Radio.FSaisi = Radio.FSaisi*10
				Radio.FSaisi = Radio.FSaisi + 3
				changeRadioScreen("freq", "ENTER "..Radio.FSelect.." : "..tostring(Radio.FSaisi))
			end
			if data["touch"] == "4" then
				Radio.FSaisi = Radio.FSaisi*10
				Radio.FSaisi = Radio.FSaisi + 4
				changeRadioScreen("freq", "ENTER "..Radio.FSelect.." : "..tostring(Radio.FSaisi))
			end
			if data["touch"] == "5" then
				Radio.FSaisi = Radio.FSaisi*10
				Radio.FSaisi = Radio.FSaisi + 5
				changeRadioScreen("freq", "ENTER "..Radio.FSelect.." : "..tostring(Radio.FSaisi))
			end
			if data["touch"] == "6" then
				Radio.FSaisi = Radio.FSaisi*10
				Radio.FSaisi = Radio.FSaisi + 6
				changeRadioScreen("freq", "ENTER "..Radio.FSelect.." : "..tostring(Radio.FSaisi))
			end
			if data["touch"] == "7" then
				Radio.FSaisi = Radio.FSaisi*10
				Radio.FSaisi = Radio.FSaisi + 7
				changeRadioScreen("freq", "ENTER "..Radio.FSelect.." : "..tostring(Radio.FSaisi))
			end
			if data["touch"] == "8" then
				Radio.FSaisi = Radio.FSaisi*10
				Radio.FSaisi = Radio.FSaisi + 8
				changeRadioScreen("freq", "ENTER "..Radio.FSelect.." : "..tostring(Radio.FSaisi))
			end
			if data["touch"] == "9" then
				Radio.FSaisi = Radio.FSaisi*10
				Radio.FSaisi = Radio.FSaisi + 9
				changeRadioScreen("freq", "ENTER "..Radio.FSelect.." : "..tostring(Radio.FSaisi))
			end
			if data["touch"] == "0" then
				Radio.FSaisi = Radio.FSaisi*10
				changeRadioScreen("freq", "ENTER "..Radio.FSelect.." : "..tostring(Radio.FSaisi))
			end
		end
	end
end)