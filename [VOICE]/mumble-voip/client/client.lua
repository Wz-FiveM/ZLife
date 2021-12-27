local voiceData = {}
local radioDataF1 = {}
local radioDataF2 = {}
local callData = {}

local Radio = {
	speak = {
		F1 = false,
		F2 = false
	},
}

local playerServerId = GetPlayerServerId(PlayerId())

-- Functions
function SetVoiceData(key, value)
	TriggerServerEvent("mumble:SetVoiceData", key, value)
end

-- Events
RegisterNetEvent("mumble:SetVoiceData")
AddEventHandler("mumble:SetVoiceData", function(voice, radioF1, radioF2, call)
	voiceData = voice

	if radioF1 then
		radioDataF1 = radioF1
	end

	if radioF2 then
		radioDataF2 = radioF2
	end

	if call then
		callData = call
	end
end)

RegisterNetEvent("mumble:RadioSound")
AddEventHandler("mumble:RadioSound", function(snd, channel)
	if channel <= mumbleConfig.radioClickMaxChannel then
		if mumbleConfig.micClicks then
			if (snd and mumbleConfig.micClickOn) or (not snd and mumbleConfig.micClickOff) then
				SendNUIMessage({ sound = (snd and "audio_on" or "audio_off"), volume = mumbleConfig.micClickVolume })
			end
		end
	end
end)

--[[ AddEventHandler("onClientResourceStart", function (resourceName)
	if GetCurrentResourceName() ~= resourceName then
		return
	end

	TriggerServerEvent("mumble:Initialise")
end) ]]
local p

-- Simulate PTT when radio is active
Citizen.CreateThread(function()
	while true do
		Citizen.Wait(0)
		local playerData = voiceData[playerServerId]
		local playerMode = 2
		local playerRadioF1 = 0
		local playerRadioActiveF1 = false
		local playerRadioF2 = 0
		local playerRadioActiveF2 = false
		local playerCall = 0
		local playerCallSpeaker = false

		if playerData ~= nil then
			playerMode = playerData.mode or 2
			playerRadioF1 = playerData.radioF1 or 0
			playerRadioActiveF1 = playerData.radioActiveF1 or false
			playerRadioF2 = playerData.radioF2 or 0
			playerRadioActiveF2 = playerData.radioActiveF2 or false
			playerCall = playerData.call or 0
			playerCallSpeaker = playerData.callSpeaker or false
		end

		if playerRadioActiveF1 or playerRadioActiveF2 then -- Force PTT enabled
			SetControlNormal(0, 249, 1.0)
			SetControlNormal(1, 249, 1.0)
			SetControlNormal(2, 249, 1.0)
		end

		if IsControlJustPressed(0, mumbleConfig.controls.proximity.key) then
			if mumbleConfig.controls.speaker.key == mumbleConfig.controls.proximity.key and not ((mumbleConfig.controls.speaker.secondary == nil) and true or IsControlPressed(0, mumbleConfig.controls.speaker.secondary)) then
				local voiceMode = playerMode
			
				local newMode = voiceMode + 1
			
				if newMode > #mumbleConfig.voiceModes then
					voiceMode = 1
				else
					voiceMode = newMode
				end
			
				SetVoiceData("mode", voiceMode)

				if p then
                    RemoveNotification(p)
                end
				p = ShowAboveRadarMessage(string.format("Vous avez réglé l'intensité de votre voix sur " ..mumbleConfig.voiceModes[voiceMode][3] .. "%s~w~.",mumbleConfig.voiceModes[voiceMode][4]))
				Citizen.SetTimeout(4000, function()
                    if p then
                        RemoveNotification(p)
                    end
                end)
			end
		end

		if mumbleConfig.radioEnabledF1 then
			if not mumbleConfig.controls.radioF1.pressed then
				if Radio.speak.F1 then
					if playerRadioF1 > 0 then
						SetVoiceData("radioActiveF1", true)
						playerData.radioActiveF1 = true
						mumbleConfig.controls.radioF1.pressed = true

						Citizen.CreateThread(function()
							while Radio.speak.F1 do
								Citizen.Wait(0)
							end

							SetVoiceData("radioActiveF1", false)
							playerData.radioActiveF1 = false
							mumbleConfig.controls.radioF1.pressed = false
						end)
					end
				end
			end
		else
			if playerRadioActiveF1 then
				SetVoiceData("radioActiveF1", false)
				playerData.radioActiveF1 = false
			end
		end

		if mumbleConfig.radioEnabledF2 then
			if not mumbleConfig.controls.radioF2.pressed then
				if Radio.speak.F2 then
					if playerRadioF2 > 0 then
						SetVoiceData("radioActiveF2", true)
						playerData.radioActiveF2 = true
						mumbleConfig.controls.radioF2.pressed = true

						Citizen.CreateThread(function()
							while Radio.speak.F2 do
								Citizen.Wait(0)
							end

							SetVoiceData("radioActiveF2", false)
							playerData.radioActiveF2 = false
							mumbleConfig.controls.radioF2.pressed = false
						end)
					end
				end
			end
		else
			if playerRadioActiveF2 then
				SetVoiceData("radioActiveF2", false)
				playerData.radioActiveF2 = false
			end
		end

		if ((mumbleConfig.controls.speaker.secondary == nil) and true or IsControlPressed(0, mumbleConfig.controls.speaker.secondary)) then
			if IsControlJustPressed(0, mumbleConfig.controls.speaker.key) then
				if playerCall > 0 then
					SetVoiceData("callSpeaker", not playerCallSpeaker)
				end
			end
		end
	end
end)

-- UI
Citizen.CreateThread(function()
	while true do
		Citizen.Wait(200)
		local playerId = PlayerId()
		local playerData = voiceData[playerServerId]
		local playerTalking = NetworkIsPlayerTalking(playerId)
		local playerMode = 2
		local playerRadioF1 = 0
		local playerRadioActiveF1 = false
		local playerRadioF2 = 0
		local playerRadioActiveF2 = false
		local playerCall = 0
		local playerCallSpeaker = false

		if playerData ~= nil then
			playerMode = playerData.mode or 2
			playerRadioF1 = playerData.radioF1 or 0
			playerRadioActiveF1 = playerData.radioActiveF1 or false
			playerRadioF2 = playerData.radioF2 or 0
			playerRadioActiveF2 = playerData.radioActiveF2 or false
			playerCall = playerData.call or 0
			playerCallSpeaker = playerData.callSpeaker or false
		end

		-- Update UI
		SendNUIMessage({
			talking = playerTalking,
			mode = mumbleConfig.voiceModes[playerMode][2],
			radioF1 = playerRadioF1,
			radioActiveF1 = playerRadioActiveF1,
			radioF2 = playerRadioF2,
			radioActiveF2 = playerRadioActiveF2,
			call = playerCall,
			speaker = playerCallSpeaker,
		})
	end
end)

-- Main thread
Citizen.CreateThread(function()
	local talkingAnim = { "mic_chatter", "mp_facial" }
	local normalAnim = { "mood_normal_1", "facials@gen_male@base" }

	RequestAnimDict(talkingAnim[3])

	while not HasAnimDictLoaded(talkingAnim[2]) do
		Citizen.Wait(150)
	end

	RequestAnimDict(normalAnim[2])

	while not HasAnimDictLoaded(normalAnim[2]) do
		Citizen.Wait(150)
	end

	while true do
		Citizen.Wait(500)

		local playerId = PlayerId()
		local playerPed = PlayerPedId()
		local playerPos = GetPedBoneCoords(playerPed, headBone)
		local playerList = GetActivePlayers()
		local playerData = voiceData[playerServerId]
		local playerRadioF1 = 0
		local playerRadioF2 = 0
		local playerCall = 0

		if playerData ~= nil then
			playerRadioF1 = playerData.radioF1 or 0
			playerRadioF2 = playerData.radioF2 or 0
			playerCall = playerData.call or 0
		end

		local voiceList = {}
		local muteList = {}
		local callList = {}
		local radioListF1 = {}
		local radioListF2 = {}

		local radioListF12 = {}
		local radioListF12 = {}

		for i = 1, #playerList do -- Proximity based voice (probably won't work for infinity?)
			local remotePlayerId = playerList[i]

			if playerId ~= remotePlayerId then
				local remotePlayerServerId = GetPlayerServerId(remotePlayerId)
				local remotePlayerPed = GetPlayerPed(remotePlayerId)
				local remotePlayerPos = GetPedBoneCoords(remotePlayerPed, headBone)
				local remotePlayerData = voiceData[remotePlayerServerId]

				local distance = #(playerPos - remotePlayerPos)
				local mode = 2
				local radioF1 = 0
				local radioActiveF1 = false
				local radioF2 = 0
				local radioActiveF2 = false
				local call = 0
				local callSpeaker = false

				if remotePlayerData ~= nil then
					mode = remotePlayerData.mode or 2
					radioF1 = remotePlayerData.radioF1 or 0
					radioActiveF1 = remotePlayerData.radioActiveF1 or false
					radioF2 = remotePlayerData.radioF2 or 0
					radioActiveF2 = remotePlayerData.radioActiveF2 or false
					call = remotePlayerData.call or 0
					callSpeaker = remotePlayerData.callSpeaker or false
				end

				-- Check if player is in range
				if distance < mumbleConfig.voiceModes[mode][1] then
					local volume = 1.0 - (distance / mumbleConfig.voiceModes[mode][1])^0.5

					if volume < 0 then
						volume = 0.0
					end

					voiceList[#voiceList + 1] = {
						id = remotePlayerServerId,
						player = remotePlayerId,
						volume = volume,
					}

					if mumbleConfig.callSpeakerEnabled then
						if call > 0 then -- Collect all players in the phone call
							if callSpeaker then
								local callParticipants = callData[call]
								if callParticipants ~= nil then
									for id, _ in pairs(callParticipants) do
										if id ~= remotePlayerServerId then
											callList[id] = true
										end
									end
								end
							end
						end
					end
					
					if mumbleConfig.radioSpeakerEnabledF1 then
						if radioF1 > 0 then -- Collect all players in the radio channel
							local radioParticipants = radioDataF1[radioF1]
							if radioParticipants then
								for id, _ in pairs(radioParticipants) do
									if id ~= remotePlayerServerId then
										radioListF1[id] = true
									end
								end
							end
						end
					end

					if mumbleConfig.radioSpeakerEnabledF2 then
						if radioF2 > 0 then -- Collect all players in the radio channel
							local radioParticipants = radioDataF2[radioF2]
							if radioParticipants then
								for id, _ in pairs(radioParticipants) do
									if id ~= remotePlayerServerId then
										radioListF2[id] = true
									end
								end
							end
						end
					end

				else
					muteList[#muteList + 1] = {
						id = remotePlayerServerId,
						player = remotePlayerId,
						volume = 0.0,
						radioF1 = radioF1,
						radioActiveF1 = radioActiveF1,
						radioF2 = radioF2,
						radioActiveF2 = radioActiveF2,
						distance = distance,
						call = call,
					}					
				end
			end
		end

		for j = 1, #voiceList do
			MumbleSetVolumeOverride(voiceList[j].player, voiceList[j].volume)
		end

		for j = 1, #muteList do
			if callList[muteList[j].id] or radioListF1[muteList[j].id] or radioListF2[muteList[j].id] then
				if muteList[j].distance < mumbleConfig.speakerRange then
					muteList[j].volume = 1.0 - (muteList[j].distance / mumbleConfig.speakerRange)^0.5
				end
			end

			if muteList[j].radioF1 > 0 and muteList[j].radioF1 == playerRadioF1 and muteList[j].radioActiveF1 then
				muteList[j].volume = mumbleConfig.volumeF1
			end

			if muteList[j].radioF2 > 0 and muteList[j].radioF2 == playerRadioF2 and muteList[j].radioActiveF2 then
				muteList[j].volume = mumbleConfig.volumeF2
			end

			if muteList[j].radioF1 > 0 and muteList[j].radioF1 == playerRadioF2 and muteList[j].radioActiveF1 then
				muteList[j].volume = mumbleConfig.volumeF2
			end

			if muteList[j].radioF2 > 0 and muteList[j].radioF2 == playerRadioF1 and muteList[j].radioActiveF2 then
				muteList[j].volume = mumbleConfig.volumeF1
			end

			if muteList[j].call > 0 and muteList[j].call == playerCall then
				muteList[j].volume = 1.2
			end
			
			MumbleSetVolumeOverride(muteList[j].player, muteList[j].volume)
		end
	end
end)

-- Exports
function SetRadioChannel(freq, channel)
	local channel = tonumber(channel)

	if channel ~= nil then
		if freq == "F1" then
			SetVoiceData("radioF1", channel)
		else
			SetVoiceData("radioF2", channel)
		end
	end
end

function SetRadioVolume(freq, volume)
	if freq == "F1" then
		mumbleConfig.volumeF1 = volume/100
	else
		mumbleConfig.volumeF2 = volume/100
	end
end

function SetCallChannel(channel)
	local channel = tonumber(channel)

	if channel ~= nil then
		SetVoiceData("call", channel)
	end
end

function TalkRadio(freq, status)
	Radio["speak"][freq] = true
end

function EndTalkRadio()
	Radio["speak"]["F1"] = false
	Radio["speak"]["F2"] = false
end

exports("TalkRadio", TalkRadio)
exports("EndTalkRadio", EndTalkRadio)

exports("SetRadioChannel", SetRadioChannel)
exports("addPlayerToRadio", SetRadioChannel)
exports("setRadioVolume", SetRadioVolume)

exports("SetCallChannel", SetCallChannel)
exports("addPlayerToCall", SetCallChannel)
exports("removePlayerFromCall", function()
	SetCallChannel(0)
end)