ESX = nil
local PlayerData              = {}

local isPlayerSpawned = false

Citizen.CreateThread(function()
	while ESX == nil do
		TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
		Citizen.Wait(0)
	end
	while ESX.GetPlayerData().job == nil do
		Citizen.Wait(10)
	end
	PlayerData = ESX.GetPlayerData()






RegisterNetEvent('esx:playerLoaded')
AddEventHandler('esx:playerLoaded', function(xPlayer)
	ESX.PlayerData = xPlayer
end)

RegisterNetEvent('esx:setJob')
AddEventHandler('esx:setJob', function(job)
	ESX.PlayerData.job = job
end)



local notifserv

function startAttitude(lib, anim)
	ESX.Streaming.RequestAnimSet(lib, function()
		SetPedMovementClipset(PlayerPedId(), anim, true)
	end)
end

local entityEnumerator = {
	__gc = function(enum)
		if enum.destructor and enum.handle then
			enum.destructor(enum.handle)
		end

		enum.destructor = nil
		enum.handle = nil
	end
}

local name = GetPlayerName(PlayerId())
local id = GetPlayerServerId(PlayerId())
local isPlayerSpawned = false

local demarches = {
	"Normale",
	"Blessé(e)",
	"Arrogant(e)",
	"Arrogant(e) 2",
	"Arrogant(e) Abusé",
	"Déterminé(e)",
	"Marche Ralenti bras écartés",
	"Marche Ralenti",
	"Marche Lente",
	"Marche Lente bras écartés",
	"Marche Moyenne",
	"Marche Moyenne bras écartés",
	"Marche Rapide",
	"Trottiner",
	"Constipé(e)",
	"Police Gainé",
	"Police Rapide",
	"Légèrement Bourré(e)",
	"Bourré(e)",
	"Défoncé(e)",
	"Femme",
	"Femme Difficile",
	"Sexi",
	"Feu",
	"Feu 1",
	"Feu 2",
	"Franklin",
	"Lamar",
	"Lester",
	"Lester 2",
	"Michael",
	"Shady",
	"Gangster",
	"Gangster 1",
	"Gangster 2",
	"Gangster 3",
	"Gangster 4",
	"Garde Armé",
	"Menotté(e)",
	"Hipster",
	"Désespéré(e)",
	"Brute",
	"Brute 2",
	"Argent",
	"Triste",
	"Travailleur",
	"Insolent",
	"Effrayé(e)",
	"Swag",
	"Difficile",
	"Trainer",
	"Trainer 2",
	"Large",
	"Intimide"
}

local humeurs = {
	"Normale",
	"En colère",
	"Ivre",
	"Stupide",
	"Électrocuté",
	"Grincheux",
	"Grincheux 1",
	"Grincheux 2",
	"Heureux",
	"Blessée",
	"Joyeux",
	"Mouthbreather",
	"Jamais cligner des yeux",
	"Un oeil",
	"Choqué",
	"Choqué 2",
	"Dormir",
	"Dormir 2",
	"Dormir 3",
	"Suffisant",
	"Spéculatif",
	"Stresser",
	"Bouder",
	"Bizarre",
	"Bizarre 2",
}


local function opendre(data)
	CloseMenu(force)
	if data == 1 then 
		ExecuteCommand("simcard")	
	end
end

local function OnSelected(self, _, btn, PMenu, menuData, currentButton, currentBtn, currentSlt, result, slide)
	local slide = btn.slidenum
	local btn = btn.name
	local check = btn.unkCheckbox
	local MenuSelect = menuData.currentMenu
	if btn == "Options" then 
		OpenMenu("Options")
	elseif btn == "Réglage des filtres" then
		OpenMenu("Filtres")
	elseif btn == "Violet & Bleu" then
		SetTimecycleModifier('PPPurple01')
	elseif btn == "Couleur Amplifiée" then
		SetTimecycleModifier('BombCamFlash')
	elseif btn == "Vue normal" then
		SetTimecycleModifier('default')
	elseif slide == 1 and btn == "Humeurs" then 
		ClearFacialIdleAnimOverride(GetPlayerPed(-1))
	elseif slide == 2 and btn == "Humeurs" then 
		SetFacialIdleAnimOverride(PlayerPedId(), "mood_angry_1", 0)
	elseif slide == 3 and btn == "Humeurs" then 
		SetFacialIdleAnimOverride(PlayerPedId(), "mood_drunk_1", 0)
	elseif slide == 4 and btn == "Humeurs" then 
		SetFacialIdleAnimOverride(PlayerPedId(), "pose_injured_1", 0)
	elseif slide == 5 and btn == "Humeurs" then 
		SetFacialIdleAnimOverride(PlayerPedId(), "electrocuted_1", 0)
	elseif slide == 6 and btn == "Humeurs" then 
		SetFacialIdleAnimOverride(PlayerPedId(), "effort_1", 0)
	elseif slide == 7 and btn == "Humeurs" then 
		SetFacialIdleAnimOverride(PlayerPedId(), "mood_drivefast_1", 0)
	elseif slide == 8 and btn == "Humeurs" then 
		SetFacialIdleAnimOverride(PlayerPedId(), "pose_angry_1", 0)
	elseif slide == 9 and btn == "Humeurs" then 
		SetFacialIdleAnimOverride(PlayerPedId(), "mood_happy_1", 0)
	elseif slide == 10 and btn == "Humeurs" then 
		SetFacialIdleAnimOverride(PlayerPedId(), "mood_injured_1", 0)
	elseif slide == 11 and btn == "Humeurs" then 
		SetFacialIdleAnimOverride(PlayerPedId(), "mood_dancing_low_1", 0)
	elseif slide == 12 and btn == "Humeurs" then 
		SetFacialIdleAnimOverride(PlayerPedId(), "smoking_hold_1", 0)
	elseif slide == 13 and btn == "Humeurs" then 
		SetFacialIdleAnimOverride(PlayerPedId(), "pose_normal_1", 0)
	elseif slide == 14 and btn == "Humeurs" then 
		SetFacialIdleAnimOverride(PlayerPedId(), "pose_aiming_1", 0)
	elseif slide == 15 and btn == "Humeurs" then 
		SetFacialIdleAnimOverride(PlayerPedId(), "shocked_1", 0)
	elseif slide == 16 and btn == "Humeurs" then 
		SetFacialIdleAnimOverride(PlayerPedId(), "shocked_2", 0)
	elseif slide == 17 and btn == "Humeurs" then 
		SetFacialIdleAnimOverride(PlayerPedId(), "mood_sleeping_1", 0)
	elseif slide == 18 and btn == "Humeurs" then 
		SetFacialIdleAnimOverride(PlayerPedId(), "dead_1", 0)
	elseif slide == 19 and btn == "Humeurs" then 
		SetFacialIdleAnimOverride(PlayerPedId(), "dead_2", 0)
	elseif slide == 20 and btn == "Humeurs" then 
		SetFacialIdleAnimOverride(PlayerPedId(), "mood_smug_1", 0)
	elseif slide == 21 and btn == "Humeurs" then 
		SetFacialIdleAnimOverride(PlayerPedId(), "mood_aiming_1", 0)
	elseif slide == 22 and btn == "Humeurs" then 
		SetFacialIdleAnimOverride(PlayerPedId(), "mood_stressed_1", 0)
	elseif slide == 23 and btn == "Humeurs" then 
		SetFacialIdleAnimOverride(PlayerPedId(), "mood_sulk_1", 0)
	elseif slide == 24 and btn == "Humeurs" then 
		SetFacialIdleAnimOverride(PlayerPedId(), "effort_2", 0)
	elseif slide == 25 and btn == "Humeurs" then 
		SetFacialIdleAnimOverride(PlayerPedId(), "effort_3", 0)
	elseif btn == "Animations" then 
		OpenMenu("Animations")
	elseif btn == "Menu animations" then
		CloseMenu(force)
		ExecuteCommand('+animmenu')
	elseif btn == "Réglage Hud" then 
		OpenMenu("Réglage Hud")
	elseif btn == "Enlever le compteur de vitesse" then 
		TriggerEvent('optionshudcar')
	elseif btn == "Contrastes" then 
		OpenMenu("Contraste")
	elseif btn == "Eclaircissement" then 
		SetTimecycleModifier('canyon_mission')
	elseif btn == "Contraste" then 
		SetTimecycleModifier('player_transition_no_scanlines')
	elseif btn == "Fin du Monde" then 
		OpenMenu("Fin du Monde")
	elseif btn == "Fin du Monde 1" then 
		SetTimecycleModifier('New_sewers')
	elseif btn == "Gris Fin du Monde" then 
		SetTimecycleModifier('NG_filmic20')
	elseif btn == "Grésillement" then 
		OpenMenu("Grésillement")
	elseif btn == "Grésillement 1" then 
		SetTimecycleModifier('BeastIntro01')
	elseif btn == "Grésillement 2" then 
		SetTimecycleModifier('spectator2')
	elseif btn == "Brouillard" then 
		OpenMenu("Brouillard")
	elseif btn == "Brouillard 1" then 
		SetTimecycleModifier('v_abattoir')
	elseif btn == "Brouillard Eclairci" then 
		SetTimecycleModifier('v_bahama')
	elseif btn == "Gros Brouillard" then 
		SetTimecycleModifier('v_cashdepot')
	elseif btn == "Vue / Couleur Amplifié" then 
		OpenMenu("Vue / Couleur Amplifié")
	elseif btn == "Vue & lumières améliorées" then 
		SetTimecycleModifier('Tunnel')
	elseif btn == "Repose les yeux" then 
		SetTimecycleModifier('phone_cam6')
	elseif btn == "Couleurs amplifiées" then 
		SetTimecycleModifier('rply_saturation')
	elseif btn == "Couleurs amplifiées 2" then 
		SetTimecycleModifier('BombCamFlash')
	elseif btn == "Mode cinéma" then 
		SetTimecycleModifier('cinema')
	elseif btn == "Couleurs" then 
		OpenMenu("Couleurs")
	elseif btn == "Noir & Blanc" then 
		SetTimecycleModifier('rply_saturation_neg')
	elseif btn == "Violet et Bleu" then 
		SetTimecycleModifier('PPPurple01')
	elseif btn == "Rouge" then 
		SetTimecycleModifier('li')
	elseif btn == "Sous l'Eau" then 
		SetTimecycleModifier('SALTONSEA')
	elseif btn == "Divers" then 
		OpenMenu("Divers")
	elseif btn == "Synchroniser son personnage" then 
		local health = GetEntityHealth(GetPlayerPed(-1))
		TriggerServerEvent('esx_health:update', health)
		TriggerServerEvent('SavellPlayer')
		TriggerEvent('skinchanger:getSkin', function(skin)
			TriggerServerEvent('esx_skin:save', skin)
		end)
	elseif MenuSelect == "Carte Sim" then

	elseif slide == 1 and btn == "Démarches" then 
		ResetPedMovementClipset(PlayerPedId()) return
	elseif slide == 2 and btn == "Démarches" then 
		WalkMenuStart("move_m@injured")
	elseif slide == 3 and btn == "Démarches" then 
		WalkMenuStart("move_f@arrogant@a")
	elseif slide == 4 and btn == "Démarches" then 
		WalkMenuStart("move_f@chichi")
	elseif slide == 5 and btn == "Démarches" then 
		WalkMenuStart("move_f@maneater")
	elseif slide == 6 and btn == "Démarches" then 
		WalkMenuStart("move_m@brave")
	elseif slide == 7 and btn == "Démarches" then 
		WalkMenuStart("move_characters@jimmy@slow@")
	elseif slide == 8 and btn == "Démarches" then 
		WalkMenuStart("move_m@casual@d")
	elseif slide == 9 and btn == "Démarches" then 
		WalkMenuStart("move_m@casual@a")
	elseif slide == 10 and btn == "Démarches" then 
		WalkMenuStart("move_m@casual@e")
	elseif slide == 11 and btn == "Démarches" then 
		WalkMenuStart("move_m@casual@b")
	elseif slide == 12 and btn == "Démarches" then 
		WalkMenuStart("move_m@casual@f")
	elseif slide == 13 and btn == "Démarches" then 
		WalkMenuStart("move_m@casual@c")
	elseif slide == 14 and btn == "Démarches" then 
		WalkMenuStart("move_m@quick")
	elseif slide == 15 and btn == "Démarches" then 
		WalkMenuStart("move_m@confident")
	elseif slide == 16 and btn == "Démarches" then 
		WalkMenuStart("move_m@business@a")
	elseif slide == 17 and btn == "Démarches" then 
		WalkMenuStart("move_m@business@c")
	elseif slide == 18 and btn == "Démarches" then 
		WalkMenuStart("move_m@business@b")
	elseif slide == 19 and btn == "Démarches" then 
		WalkMenuStart("move_m@buzzed")
	elseif slide == 20 and btn == "Démarches" then 
		WalkMenuStart("move_m@drunk@a")
	elseif slide == 21 and btn == "Démarches" then 
		WalkMenuStart("move_f@femme@")
	elseif slide == 22 and btn == "Démarches" then 
		WalkMenuStart("move_f@tough_guy@")
	elseif slide == 23 and btn == "Démarches" then 
		WalkMenuStart("move_f@sexy@a")
	elseif slide == 24 and btn == "Démarches" then 
		WalkMenuStart("move_characters@franklin@fire")
	elseif slide == 25 and btn == "Démarches" then 
		WalkMenuStart("move_characters@michael@fire")
	elseif slide == 26 and btn == "Démarches" then  
		WalkMenuStart("move_m@fire")
	elseif slide == 27 and btn == "Démarches" then 
		WalkMenuStart("move_p_m_one")
	elseif slide == 28 and btn == "Démarches" then 
		WalkMenuStart("anim_group_move_lemar_alley")
	elseif slide == 29 and btn == "Démarches" then 
		WalkMenuStart("move_heist_lester")
	elseif slide == 30 and btn == "Démarches" then 
		WalkMenuStart("move_lester_caneup")
	elseif slide == 31 and btn == "Démarches" then 
		WalkMenuStart("move_ped_bucket")
	elseif slide == 32 and btn == "Démarches" then 
		WalkMenuStart("move_m@shadyped@a")
	elseif slide == 33 and btn == "Démarches" then 
		WalkMenuStart("move_m@gangster@generic")
	elseif slide == 34 and btn == "Démarches" then 
		WalkMenuStart("move_m@gangster@ng")
	elseif slide == 35 and btn == "Démarches" then 
		WalkMenuStart("move_m@gangster@var_e")
	elseif slide == 36 and btn == "Démarches" then 
		WalkMenuStart("move_m@gangster@var_f")
	elseif slide == 37 and btn == "Démarches" then 
		WalkMenuStart("move_m@gangster@var_i")
	elseif slide == 38 and btn == "Démarches" then 
		WalkMenuStart("move_m@prison_gaurd")
	elseif slide == 39 and btn == "Démarches" then 
		WalkMenuStart("move_m@prisoner_cuffed")
	elseif slide == 40 and btn == "Démarches" then 
		WalkMenuStart("move_m@hipster@a")
	elseif slide == 41 and btn == "Démarches" then 
		WalkMenuStart("move_m@hobo@a")
	elseif slide == 42 and btn == "Démarches" then 
		WalkMenuStart("move_p_m_zero_janitor")
	elseif slide == 43 and btn == "Démarches" then 
		WalkMenuStart("move_p_m_zero_slow")
	elseif slide == 44 and btn == "Démarches" then 
		WalkMenuStart("move_m@money")
	elseif slide == 45 and btn == "Démarches" then 
		WalkMenuStart("move_m@sad@a")
	elseif slide == 46 and btn == "Démarches" then 
		WalkMenuStart("move_m@sassy")
	elseif slide == 47 and btn == "Démarches" then 
		WalkMenuStart("move_f@sassy")
	elseif slide == 48 and btn == "Démarches" then 
		WalkMenuStart("move_f@scared")
	elseif slide == 49 and btn == "Démarches" then 
		WalkMenuStart("move_m@swagger")
	elseif slide == 50 and btn == "Démarches" then 
		WalkMenuStart("move_m@tough_guy@")
	elseif slide == 51 and btn == "Démarches" then
		WalkMenuStart("clipset@move@trash_fast_turn")
	elseif slide == 52 and btn == "Démarches" then
		WalkMenuStart("missfbi4prepp1_garbageman")
	elseif slide == 53 and btn == "Démarches" then
		WalkMenuStart("move_m@bag")
	elseif slide == 54 and btn == "Démarches" then
		startAttitude("move_m@hurry@a","move_m@hurry@a")
	elseif btn == "Poses" then 
		OpenMenu("Poses")
	elseif btn == "Annuler animations" then 
		ClearPedTasks(GetPlayerPed(-1))
	elseif btn == "Actions anim" then 
		OpenMenu("Actions anim")
	elseif btn == "Actions" then 
		OpenMenu("Actions")
	elseif btn == "Du sex lo" then 
		OpenMenu("Du sex lo")
	elseif btn == "Festives" then 
		OpenMenu("Festives")
	elseif btn == "Activer la revente de drogue" then 
		ExecuteCommand('drogue')
	elseif btn == "Activer les animations quand vous parlez" then 
		ExecuteCommand('voiceanim')
	elseif btn == "Citoyen" then
		OpenMenu("Citoyen")
	elseif btn == "Faction" then
		OpenMenu("Faction")
	elseif btn == "LSPD" then
		OpenMenu("LSPD")
	elseif btn == "EMS" then
		OpenMenu("EMS")
	elseif btn == "Ls Custom's" then
		OpenMenu("Ls Custom's")
	elseif btn == "Activer son service" then 

		local pJob = ESX.PlayerData.job.name
		if pJob == 'unemployed' then 
			return ShowAboveRadarMessage("~r~Vous n'avez pas de métier assigné.")
		end
		enservice = not enservice
		if enservice then 
			TriggerServerEvent("player:serviceOn", pJob)
			if notifserv then 
				RemoveNotification(notifserv)
			end
			notifserv = ShowAboveRadarMessage("~g~Vous êtes désormais considéré en service.")
		elseif not enservice then 
			TriggerServerEvent("player:serviceOff", pJob)
			if notifserv then 
				RemoveNotification(notifserv)
			end
			notifserv = ShowAboveRadarMessage("~r~Vous êtes désormais considéré hors-service.")
		end
	elseif btn == "Annuler l'appel en cours" then 
		TriggerEvent('call:cancelCall')
	end 
end

local filtres={
	{name="Normale"},
	{name="Mode cinéma",dict="cinema"},
	{name="Couleur Amplifiée",dict="BombCamFlash"},
	{name="Eclaircissement",dict="canyon_mission"},
	{name="Contraste",dict="player_transition_no_scanlines"},
	{name="Fin du Monde 1",dict="New_sewers"},
	{name="Gris Fin du Monde",dict="NG_filmic20"},
	{name="Grésillement 1",dict="BeastIntro01"},
	{name="Grésillement 2",dict="spectator2"},
	{name="Brouillard 1",dict="v_abattoir"},
	{name="Brouillard Eclairci",dict="v_bahama"},
	{name="Gros Brouillard",dict="v_cashdepot"},
	{name="Vue & lumières améliorées",dict="Tunnel"},
	{name="Repose les yeux",dict="phone_cam6"},
	{name="Couleurs amplifiées",dict="rply_saturation"},
	{name="Couleurs amplifiées 2",dict="BombCamFlash"},
	{name="Noir & Blanc",dict="rply_saturation_neg"},
	{name="Rouge",dict="li"},
	{name="Violet & Bleu",dict="PPPurple01"},
}


local MyMenus = {
	Base = { Header = {"commonmenu", "interaction_bgd"}, Title = "Divers"},
	Data = { currentMenu = "Catégories"},
	Events = { 
		onSelected = OnSelected,
		onSlide=function(dc61,aguhyl,p)
			if dc61.currentMenu == "Options"then
			local gOPDv,aSdZU3=aguhyl.name~="Humeurs",GetPlayerPed(-1)
			if gOPDv then
				local YKDL,oFyb6OLp=tableHasValue(filtres,aguhyl.slidename,"name")
				local oGdh_mv=YKDL and filtres[oFyb6OLp].dict
				ClearTimecycleModifier()
				if aguhyl.slidenum~=1 then 
					SetTimecycleModifier(oGdh_mv)
				end 
				else
					local WjvvK,TASVwBgU=tableHasValue(filtres,aguhyl.slidename,"name")
					ClearTimecycleModifier()
					if WjvvK and aguhyl.slidenum~=1 then
						ClearTimecycleModifier()
					end 
				end 
			end
		end,  
	},
	Menu = {
		["Catégories"] = {
			b = {
				--{name = "Animations",ask = ">", askX = true},
				{name = "Options",ask = ">", askX = true},
				{name = "Actions",ask = ">", askX = true},
				{name = "Carte Sim", ask = ">", askX = true}
			}
		},
		["Actions"] = {
			b = { 
				--{name = "Synchroniser son personnage"},
				--{separator = "Mes Informations", sepColor = "~b~" },
                --{name = "Métier", ask =  ESX.PlayerData.job.label .. " - " .. ESX.PlayerData.job.grade_label},
				--{name = "Argent", ask =  ESX.Math.GroupDigits(ESX.PlayerData.money .. "$")},
				--{separator = "Mes Actions", sepColor = "~b~" },
				{name = "Activer son service", checkbox = false},
				{name = "Annuler l'appel en cours", ask = ">", askX = true},
			}
		},
		["Options"] = {
			b = { 
				{name = "Activer la revente de drogue", checkbox = false},
				{name = "Activer les animations quand vous parlez", checkbox = false},
				{name = "Filtres", slidemax = filtres},
				{name = "Mes cartes sim",ask = ">", askX = true},
			}
		},
		["carte sim"] = {
			b = function()
				opendre(1)
			end,
		}
	}
}

RegisterControlKey("menuf5divers","Ouvrir le menu divers","F5",function()
	CreateMenu(MyMenus)
	setheader("Divers")
end)

function RequestWalking(set)
	RequestAnimSet(set)
	while not HasAnimSetLoaded(set) do
	  Citizen.Wait(1)
	end 
end
function WalkMenuStart(name)
	RequestWalking(name)
	SetPedMovementClipset(PlayerPedId(), name, 0.2)
	RemoveAnimSet(name)
end

end)