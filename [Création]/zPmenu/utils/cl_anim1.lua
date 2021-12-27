local function OnSelectedA(self, mMenu,Select, _, button, slt)
	local MenuSelect = mMenu.currentMenu
	local pPed = GetPlayerPed(-1)
	if MenuSelect == "s'asseoir" or MenuSelect == "actions anim" or MenuSelect == "casino" or MenuSelect == "gestures" or MenuSelect == "expressions" or MenuSelect == "poses" or MenuSelect == "festives" or MenuSelect == "insolentes" or MenuSelect == "du sex lo" or MenuSelect == "danses" or MenuSelect == "armes" then
		doAnim(Select.anim, nil, Select.func)
	elseif MenuSelect == "tenue des armes" then 
		SetWeaponAnimationOverride(pPed,GetHashKey(Select.type))
		ShowAboveRadarMessage("~r~Ne fonctionne pas avec toutes les armes.")
	elseif Select.name == "Annuler l'animation" then 
		ClearPedTasks(pPed)
	end 
end

local lcBL={{name="Normale"},{name="Blessé",dict="mood_injured_1"},{name="Chic",dict="mood_smug_1"},{name="Colère",dict="mood_angry_1"},{name="Concentration",dict="mood_aiming_1"},{name="Dormir",dict="mood_sleeping_1"},{name="Heureux",dict="mood_happy_1"},{name="Milou",dict="mood_sulk_1"},{name="Soul",dict="mood_drunk_1"},{name="Stressé",dict="mood_stressed_1"}}
local Uc06={{name="Normale"},{name="Gangster 1",dict="move_f@gangster@ng"},{name="Gangster 2",dict="move_m@fire"},{name="Gangster 3",dict="move_m@gangster@generic"},{name="Gangster 4",dict="move_m@gangster@ng"},{name="Apeuré",dict="move_f@scared@"},{name="Sexy",dict="move_f@sexy@a"},{name="Efféminé 1",dict="move_f@tough_guy@"},{name="Efféminé 2",dict="move_m@confident"},{name="Efféminé 3",dict="move_m@femme@"},{name="Efféminé 4",dict="move_m@sassy"},{name="Clochard 2",dict="move_m@buzzed"},{name="Brave 1",dict="move_m@brave"},{name="Brave 2",dict="move_m@brave@a"},{name="Bravo 3",dict="move_m@brave@b"},{name="Casu 1",dict="move_m@casual@a"},{name="Casu 2",dict="move_m@casual@b"},{name="Casu 3",dict="move_m@casual@c"},{name="Casu 4",dict="move_m@casual@d"},{name="Casu 5",dict="move_m@casual@e"},{name="Casu 6",dict="move_m@casual@f"},{name="Casu 7",dict="move_m@fat@"},{name="Déprimé",dict="move_m@depressed@a"},{name="Bourré 1",dict="move_m@drunk@moderatedrunk"},{name="Bourré 2",dict="move_m@drunk@slightlydrunk"},{name="Bourré 3",dict="move_m@drunk@verydrunk"},{name="Hipster",dict="move_m@hipster@a"},{name="Pressé 1",dict="move_m@hurry_butch@c"},{name="Blessé",dict="move_m@injured"},{name="Jogging 1",dict="move_m@jog@"},{name="Riche",dict="move_m@money"},{name="Musclé",dict="move_m@muscle@"},{name="Non chalant",dict="ove_m@non_chalant"},{name="Hautain",dict="move_m@posh@"},{name="Coincé",dict="move_m@quick"},{name="Triste 1",dict="move_m@sad@a"},{name="Triste 2",dict="move_m@sad@b"},{name="Triste 3",dict="move_m@sad@c"},{name="Triste 4",dict="move_m@leaf_blower"},{name="Efféminé 5",dict="move_m@sassy"},{name="Shady 1",dict="move_m@shadyped@a"},{name="Swag 1",dict="move_m@swagger"},{name="Swag 2",dict="move_m@swagger@b"},{name="Brute",dict="move_m@tough_guy@"},{name="Franklin 1",dict="move_p_m_one"},{name="Trevor 1",dict="move_p_m_two"},{name="Michael 1",dict="move_p_m_zero"},{name="Lent",dict="move_p_m_zero_slow"},{name="Jimmy 1",dict="move_characters@jimmy@slow@"},{name="Dave",dict="move_characters@dave_n@core"},{name="Grooving F1",dict="anim@move_f@grooving@slow@"},{name="Grooving F2",dict="anim@move_f@grooving@"},{name="Grooving H1",dict="anim@move_m@grooving@"},{name="Grooving H2",dict="anim@move_m@grooving@slow@"}}

local MenuAnisa = {
	Base = { Header = {"commonmenu", "interaction_bgd"}, Title = "Animations"},
	Data = { currentMenu = "Catégories"},
	Events = { 
		onSelected = OnSelectedA,
		onSlide=function(dc61,aguhyl,p)
			if dc61.currentMenu == "Catégories"then
			local gOPDv,aSdZU3,dSar=aguhyl.name~="Humeurs",GetPlayerPed(-1),aguhyl.name~="Démarches"
			if gOPDv then
				local YKDL,oFyb6OLp=tableHasValue(Uc06,aguhyl.slidename,"name")
				local oGdh_mv=YKDL and Uc06[oFyb6OLp].dict
				SetResourceKvp("demarcheAo", "rien")
				ResetPedMovementClipset(aSdZU3,0)
				if aguhyl.slidenum~=1 and oGdh_mv and DoesAnimDictExist(oGdh_mv)then 
					SetResourceKvp("demarcheAo", oGdh_mv)
					RequestAndWaitSet(oGdh_mv)
					SetPedMovementClipset(aSdZU3,oGdh_mv,0)
				end 
				else
					local WjvvK,TASVwBgU=tableHasValue(lcBL,aguhyl.slidename,"name")
					SetResourceKvp("humeurAo", "rien")
					ClearFacialIdleAnimOverride(aSdZU3)
					if WjvvK and aguhyl.slidenum~=1 then
						SetResourceKvp("humeurAo", lcBL[TASVwBgU].dict)
						SetFacialIdleAnimOverride(aSdZU3,lcBL[TASVwBgU].dict,0)
					end 
				end 
			end
		end,
	},
	Menu = {
		["Catégories"] = {
			b = {
				{name = "Annuler l'animation"},
				{name = "S'asseoir",ask = ">", askX = true},
				{name = "Actions anim",ask = ">", askX = true},
				{name = "Casino",ask = ">", askX = true},
				{name = "Gestures",ask = ">", askX = true},
				{name = "Expressions",ask = ">", askX = true},
				{name = "Poses",ask = ">", askX = true},
				{name = "Festives",ask = ">", askX = true},
				{name = "Insolentes",ask = ">", askX = true},
				{name = "Du sex lo",ask = ">", askX = true},
				{name = "Danses",ask = ">", askX = true},
				{name = "Armes",ask = ">", askX = true},
				{name = "Tenue des armes",ask = ">", askX = true},
				{name = "Démarches",slidemax = Uc06},
				{name = "Humeurs", slidemax = lcBL},
			}
		},
		["s'asseoir"] = {
			useFilter = true,
			b = { 
				{name="Accouder 01",anim={"missheistdockssetup1ig_12@base","talk_gantry_idle_base_worker2"},func=1},
				{name="Accouder 02",anim={"missheistdockssetup1ig_12@base","talk_gantry_idle_base_worker4"},func=1},
				{name="Accouder 03",anim={"anim@amb@clubhouse@bar@bartender@","base_bartender"},func=1},
				{name="Accouder 04",anim={"amb@prop_human_bum_shopping_cart@male@base","base"},func=1},
				{name="Accouder 05",anim={"switch@michael@sitting_on_car_bonnet","sitting_on_car_bonnet_loop"},func=1},
				{name="S'asseoir au sol",anim={"anim@heists@fleeca_bank@ig_7_jetski_owner","owner_idle"},func=1},
				{name="Se poser contre un mur",anim="WORLD_HUMAN_LEANING"},
				{name="S'asseoir par terre",anim="WORLD_HUMAN_PICNIC"},
				{name="S'asseoir cool 2",anim={"anim@heists@heist_safehouse_intro@phone_couch@male","phone_couch_male_idle"},func=1},
				{name="Méditation",anim={"rcmcollect_paperleadinout@","meditiate_idle"},func=1},
				{name="Genoux au sol",anim={"amb@medic@standing@kneel@base","base"},func=1},
				{name="S'asseoir chill",anim={"missheistpaletoscoresetupleadin","rbhs_mcs_1_leadin"},func=1},
				{name="S'asseoir cool",anim={"missfam2leadinoutmcs3","onboat_leadin_pornguy_a"},func=1}
			}
		},
		["casino"] = {
			useFilter = true,
			b = { 
				{name="Danse Families",anim={"anim@amb@casino@mini@dance@dance_solo@female@var_b@","high_right_down"}},
				{name="Danse Ballas",anim={"anim@amb@casino@mini@dance@dance_solo@female@var_b@","high_center"}},
				{name="Danse Marabunta",anim={"anim@amb@casino@mini@dance@dance_solo@female@var_b@","med_center_down"}},
				{name="Danse Vagos",anim={"anim@amb@casino@mini@dance@dance_solo@female@var_b@","high_left_up"}},
				{name="Main sur la hanche",anim={"anim@amb@casino@hangout@ped_male@stand@03b@base","base"}},
				{name="Mains croisé",anim={"anim@amb@casino@hangout@ped_male@stand@03a@base","base"}},
				{name="Réfléxion",anim={"anim@amb@casino@hangout@ped_male@stand@02b@base","base"}},
				{name="Bras croisé",anim={"anim@amb@casino@hangout@ped_male@stand@01b@base","base"}},
				{name="Mains sur le comptoir",anim={"anim@amb@casino@valet_scenario@pose_a@","base_a_m_y_vinewood_01"}},
				{name="Désespérer comptoir",anim={"anim@amb@casino@out_of_money@ped_male@02a@base","base"}},
				{name="Désespérer debout",anim={"anim@amb@casino@out_of_money@ped_male@01b@base","base"}},
				{name="Désespérer mur",anim={"anim@amb@casino@out_of_money@ped_female@02b@base","base"}},
				{name="Désespérer comptoir",anim={"anim@amb@casino@out_of_money@ped_female@02a@base","base"}},
				{name="Danse 1",anim={"anim@amb@casino@mini@dance@dance_solo@female@var_b@","med_center_down"}},
				{name="Danse 2",anim={"anim@amb@casino@mini@dance@dance_solo@female@var_b@","high_center_down"}},
				{name="Danse 3",anim={"anim@amb@casino@mini@dance@dance_solo@female@var_a@","med_center"}},
			}
		},
		["actions anim"] = {
			useFilter = true,
			b = { 
				{name="Bras Dans le dos",anim={"anim@miss@low@fin@vagos@","idle_ped06"}},

				{name="Slide",anim={"anim@arena@celeb@flat@solo@no_props@","slide_a_player_a"}},
				{name="Reverence ",anim={"anim@arena@celeb@podium@no_prop@","regal_c_1st"}},
				{name="Pleure a genoux",anim={"mp_bank_heist_1","f_cower_01"},func=1},
				{name="Sortir son carnet",anim="CODE_HUMAN_MEDIC_TIME_OF_DEATH"},
				{name="Noter des informations",anim="WORLD_HUMAN_CLIPBOARD"},
				{name="Sortir une torche",anim="WORLD_HUMAN_SECURITY_SHINE_TORCH"},
				{name="Siffler",anim={"rcmnigel1c","hailing_whistle_waive_a"},func=48},
				{name="Faire des pompes",anim="WORLD_HUMAN_PUSH_UPS"},
				{name="Je me sens pas bien",anim={"missfam5_blackout","pass_out"}},
				{name="Locoooo",anim={"anim@mp_player_intcelebrationmale@you_loco","you_loco"}},
				{name="Wank",anim={"anim@mp_player_intcelebrationmale@wank","wank"}},
				{name="Laché moi",anim={"anim@mp_player_intcelebrationmale@freakout","freakout"}},
				{name="Mendier",anim="WORLD_HUMAN_BUM_FREEWAY"},{name="Applaudir",anim="WORLD_HUMAN_CHEERING"},
				{name="Slow Clap",anim={"anim@mp_player_intcelebrationmale@slow_clap","slow_clap"}},
				{name="Appel téléphonique",anim={"cellphone@","cellphone_call_listen_base"},func=49},
				{name="Encouragement",anim={"mini@triathlon","male_one_handed_a"}},
				{name="Prendre une photo",anim="WORLD_HUMAN_MOBILE_FILM_SHOCKING"},
				{name="Bras tendu",anim={"nm@hands","flail"},func=1},
				{name="Yoga Pose",anim={"missfam5_yoga","f_yogapose_a"}},
				{name="Yoga",anim={"amb@world_human_yoga@male@base","base_a"}},
				{name="Yoga artistique",anim={"amb@world_human_yoga@female@base","base_c"}},
				{name="Mîme",anim={"special_ped@mime@monologue_5@monologue_5a","10_ig_1_wa_0"}},
				{name="Faire des abdos",anim="WORLD_HUMAN_SIT_UPS"},
				{name="Sortir votre carte",anim="WORLD_HUMAN_TOURIST_MAP"},
				{name="Acrobatie 1",anim={"anim@arena@celeb@flat@solo@no_props@","cap_a_player_a"}},
				{name="Acrobatie 2",anim={"anim@arena@celeb@flat@solo@no_props@","flip_a_player_a"}},
				{name="Acrobatie 3",anim={"anim@arena@celeb@flat@solo@no_props@","pageant_a_player_a"}},
			}
		},
		["gestures"] = {
			useFilter = true,
			b = { 
				{name="Bise au doigt",anim={"anim@mp_player_intcelebrationfemale@finger_kiss","finger_kiss"},func=48},
				{name="Quoi",anim={"gestures@f@standing@casual","gesture_bring_it_on"},func=48},
				{name="Casse-toi",anim={"gestures@f@standing@casual","gesture_bye_hard"},func=48},
				{name="Salut",anim={"gestures@f@standing@casual","gesture_bye_soft"},func=48},
				{name="Viens voir",anim={"gestures@f@standing@casual","gesture_come_here_hard"},func=48},
				{name="Allez viens..",anim={"gestures@f@standing@casual","gesture_come_here_soft"},func=48},
				{name="Damn",anim={"gestures@f@standing@casual","gesture_damn"},func=48},
				{name="Tsss",anim={"gestures@f@standing@casual","gesture_displeased"},func=48},
				{name="Hey calme",anim={"gestures@f@standing@casual","gesture_easy_now"},func=48},
				{name="ICI",anim={"gestures@f@standing@casual","gesture_hand_down"},func=48},
				{name="Gauche",anim={"gestures@f@standing@casual","gesture_hand_left"},func=48},
				{name="Droite",anim={"gestures@f@standing@casual","gesture_hand_right"},func=48},
				{name="Oh non",anim={"gestures@f@standing@casual","gesture_head_no"},func=48},
				{name="Hey toi",anim={"gestures@f@standing@casual","gesture_hello"},func=48},
				{name="Lourd",anim={"gestures@f@standing@casual","gesture_i_will"},func=48},
				{name="Moi ?!",anim={"gestures@f@standing@casual","gesture_me_hard"},func=48},
				{name="Moi",anim={"gestures@f@standing@casual","gesture_me"},func=48},
				{name="Pas moyen",anim={"gestures@f@standing@casual","gesture_no_way"},func=48},
				{name="Non non",anim={"gestures@f@standing@casual","gesture_nod_no_hard"},func=48},
				{name="Non soft",anim={"gestures@f@standing@casual","gesture_nod_no_soft"},func=48},
				{name="Oui fonce",anim={"gestures@f@standing@casual","gesture_nod_yes_hard"},func=48},
				{name="Mouai",anim={"gestures@f@standing@casual","gesture_nod_yes_soft"},func=48},
				{name="C'est ça",anim={"gestures@f@standing@casual","gesture_pleased"},func=48},
				{name="My man",anim={"gestures@f@standing@casual","gesture_point"},func=48},
				{name="Aucune idée",anim={"gestures@f@standing@casual","gesture_shrug_hard"},func=48},
				{name="Aucune idée soft",anim={"gestures@f@standing@casual","gesture_shrug_soft"},func=48},
				{name="Quoi ?!",anim={"gestures@f@standing@casual","gesture_what_hard"},func=48},
				{name="Quoi soft",anim={"gestures@f@standing@casual","gesture_what_soft"},func=48},
				{name="Toi",anim={"gestures@f@standing@casual","gesture_you_hard"},func=48},
				{name="Toi soft",anim={"gestures@f@standing@casual","gesture_you_soft"},func=48},
				{name="C'est à moi",anim={"gestures@f@standing@casual","getsure_its_mine"},func=48}
			}
		},
		["expressions"] = {
			useFilter = true,
			b = { 
				{name="Loose Thumbs 1",anim={"anim@arena@celeb@flat@solo@no_props@","thumbs_down_a_player_a"},func=48},
				{name="Mort de rire",anim={"anim@arena@celeb@flat@solo@no_props@","taunt_d_player_b"}},
				{name="Badmood 1",anim={"amb@world_human_stupor@male@base","base"},func=1},
				{name="Badmood 2",anim={"amb@world_human_stupor@male_looking_left@base","base"},func=1},
				{name="Bisou",anim={"mp_ped_interaction","kisses_guy_a"}},
				{name="Stressé",anim={"rcmme_tracey1","nervous_loop"},func=1},
				{name="Peace",anim={"anim@mp_player_intcelebrationmale@peace","peace"},func=48},
				{name="Clown teubé",anim={"move_clown@p_m_two_idles@","fidget_short_dance"}},
				{name="Face Palm",anim={"anim@mp_player_intcelebrationmale@face_palm","face_palm"}},
				{name="Patience",anim={"special_ped@impotent_rage@base","base"},func=1},
				{name="Respect",anim={"mp_player_int_upperbro_love","mp_player_int_bro_love_fp"},func=50},
				{name="Inspecter ses lunettes",anim={"clothingspecs","try_glasses_positive_a"},func=48},
				{name="Réflexion",anim={"misscarsteal4@aliens","rehearsal_base_idle_director"},func=49},
				{name="Check mon flow",anim={"clothingshirt","try_shirt_positive_d"},func=48},
				{name="Fear",anim={"move_duck_for_cover","loop"},func=1},
				{name="VICTOIRE",anim={"mini@tennisexit@","tennis_outro_win_01_female"}},
				{name="Le plus fort",anim={"rcmbarry","base"}},
				{name="Ta géré!",anim={"anim@mp_player_intcelebrationmale@thumbs_up","thumbs_up"}},
				{name="Mal de tête",anim={"misscarsteal4@actor","stumble"}},
				{name="Bro love",anim={"anim@mp_player_intcelebrationmale@bro_love","bro_love"}},
				{name="Craquer les poignets",anim={"anim@mp_player_intcelebrationmale@knuckle_crunch","knuckle_crunch"}},
				{name="Salut militaire",anim={"anim@mp_player_intuppersalute","idle_a"},func=49},
				{name="Signe F4L",anim={"amb@code_human_in_car_mp_actions@gang_sign_b@low@ps@base","idle_a"},func=50},
				{name="Signe Vagos",anim={"amb@code_human_in_car_mp_actions@v_sign@std@rds@base","idle_a"},func=50},
				{name="Signe Ballas",anim={"mp_player_int_uppergang_sign_b","mp_player_int_gang_sign_b"},func=50},
				{name="Signe Marabunta",anim={"mp_player_int_uppergang_sign_a","mp_player_int_gang_sign_a"},func=50},
				{name="Signe Ok!",anim={"anim@mp_player_intselfiedock","idle_a"},func=50},
				{name="Check moi ça !",anim={"mp_ped_interaction","handshake_guy_a"}},
				{name="Check moi ça 2",anim={"mp_ped_interaction","hugs_guy_a"}},
				{name="A vos marque ! Partez !",anim={"random@street_race","grid_girl_race_start"}},
				{name="Il a gagné !",anim={"random@street_race","_streetracer_accepted"}},
				{name="Ceinturons",anim={"amb@code_human_wander_idles_cop@male@static","static"},func=49},
				{name="On arrête tous !",anim={"anim@heists@ornate_bank@chat_manager","fail"},func=48}
			}
		},
		["poses"] = {
			useFilter = true,
			b = { 
				{name="Faire du stop",anim={"random@hitch_lift","idle_f"},func=1},
				{name="Se rendre, à genoux",anim={"random@arrests@busted","idle_a"},flag=0},
				{name="Dormir sur place",anim={"mp_sleep","sleep_loop"},func=49},
				{name="PLS",anim={"timetable@tracy@sleep@","idle_c"},func=1},
				{name="Roule au sol",anim={"missfinale_a_ig_2","trevor_death_reaction_pt"},func=2},
				{name="Blessé au sol",anim={"combat@damage@rb_writhe","rb_writhe_loop"},func=1},
				{name="Désespéré",anim={"rcmnigel1c","idle_d"},func=1},
				{name="Essouffler",anim={"re@construction","out_of_breath"}},
				{name="Faire la statue",anim="WORLD_HUMAN_HUMAN_STATUE"},
				{name="Montrer ses muscles",anim="WORLD_HUMAN_MUSCLE_FLEX"},
				{name="Zombie",anim={"special_ped@zombie@monologue_1@monologue_1c","iamundead_2"},func=1},
				{name="Pose garde",anim={"amb@world_human_stand_guard@male@base","base"},func=49},
				{name="Bras croisé lourd",anim={"anim@heists@heist_corona@single_team","single_team_loop_boss"},func=1},
				{name="Faire le maik",anim={"anim@heists@heist_corona@single_team","single_team_intro_two"},func=49},
				{name="Bras croisé",anim={"random@street_race","_car_b_lookout"},func=1},
				{name="Holster",anim={"reaction@intimidation@cop@unarmed","intro"},func=50},
				{name="Patauge",anim={"move_m@wading","walk"}}
			}
		},

		["festives"] = {
			useFilter = true,
			b = { 
				{name="Suspens",anim={"anim@amb@nightclub@dancers@black_madonna_entourage@","li_dance_facedj_11_v1_male^1"},f=1},
				{name="Coincé",anim={"anim@amb@nightclub@dancers@black_madonna_entourage@","li_dance_facedj_15_v2_male^2"},f=1},
				{name="Enchainé",anim={"anim@amb@nightclub@dancers@black_madonna_entourage@","hi_dance_facedj_09_v2_male^5"},f=1},
				{name="Hey man",anim={"anim@amb@nightclub@dancers@club_ambientpeds@","mi-hi_amb_club_09_v1_male^1"},f=1},
				{name="Move 01",anim={"anim@mp_player_intupperuncle_disco","idle_a"},func=1},
				{name="Move 02",anim={"anim@mp_player_intuppersalsa_roll","idle_a"},func=1},
				{name="Move 03",anim={"anim@mp_player_intupperraise_the_roof","idle_a"},func=1},
				{name="Move 04",anim={"anim@mp_player_intupperoh_snap","idle_a"},func=1},
				{name="Move 05",anim={"anim@mp_player_intupperheart_pumping","idle_a"},func=1},
				{name="Move 06",anim={"anim@mp_player_intupperfind_the_fish","idle_a"},func=1},
				{name="Move 07",anim={"anim@mp_player_intuppercats_cradle","idle_a"},func=1},
				{name="Move 08",anim={"anim@mp_player_intupperbanging_tunes","idle_a"},func=1},
				{name="Move 09",anim={"anim@mp_player_intupperbanging_tunes_right","idle_a"},func=1},
				{name="Move 10",anim={"anim@mp_player_intupperbanging_tunes_left","idle_a"},func=1},
				{name="DJ",anim={"anim@mp_player_intcelebrationmale@dj","dj"}},
				{name="Fausse guitare",anim={"anim@mp_player_intcelebrationmale@air_guitar","air_guitar"}},
				{name="Mains Jazz",anim={"anim@mp_player_intcelebrationfemale@jazz_hands","jazz_hands"}},
				{name="Rock'n roll",anim={"anim@mp_player_intcelebrationmale@rock","rock"}}
			}
		},
		["insolentes"] = {
			useFilter = true,
			b = { 
				{name="MDR",anim={"anim@arena@celeb@flat@solo@no_props@","giggle_a_player_a"}},
				{name="Se curer le nez",anim={"anim@mp_player_intcelebrationmale@nose_pick","nose_pick"}},
				{name="Bouffe mon doigt",anim={"anim@mp_player_intcelebrationmale@finger","finger"}},
				{name="Prend mon fuck",anim={"random@shop_gunstore","_negative_goodbye"}},
				{name="Mini Fuck",anim={"misscommon@response","screw_you"}},
				{name="Nananère",anim={"anim@mp_player_intcelebrationmale@thumb_on_ears","thumb_on_ears"}},
				{name="DTC",anim={"anim@mp_player_intcelebrationmale@dock","dock"}},
				{name="Chuuuuute",anim={"anim@mp_player_intcelebrationmale@shush","shush"}},
				{name="Poule Mouillé",anim={"anim@mp_player_intcelebrationmale@chicken_taunt","chicken_taunt"}},
				{name="Doigt d'honneur",anim={"mp_player_int_upperfinger","mp_player_int_finger_01"},func=49},
				{name="Uriner",anim={"misscarsteal2peeing","peeing_intro"}},
				{name="Se gratter le cul",anim={"mp_player_int_upperarse_pick","mp_player_int_arse_pick"},func=49},
				{name="Se gratter les couilles",anim={"mp_player_int_uppergrab_crotch","mp_player_int_grab_crotch"},func=49},
				{name="Pluie de fric",anim={"anim@arena@celeb@flat@solo@props@","make_it_rain_b_player_b"}},
				{name="Pluie de fric 2",anim={"anim@mp_player_intcelebrationmale@raining_cash","raining_cash"}}
			}
		},
		["du sex lo"] = {
			useFilter = true,
			b = { 
				{name="Fellation",anim={"misscarsteal2pimpsex","pimpsex_hooker"}},
				{name="Se faire sucer 01",anim={"misscarsteal2pimpsex","pimpsex_pimp"}},
				{name="Se faire sucer 02",anim={"misscarsteal2pimpsex","pimpsex_punter"}},
				{name="Baiser quelqu'un",anim={"rcmpaparazzo_2","shag_loop_a"}},
				{name="Se faire baiser",anim={"rcmpaparazzo_2","shag_loop_poppy"}},
				{name="Danse sexy",anim={"mp_safehouse","lap_dance_girl"}},
				{name="Danse Twerk",anim={"mini@strip_club@private_dance@part3","priv_dance_p3"}},
				{name="Montrer sa poitrine",anim={"mini@strip_club@backroom@","stripper_b_backroom_idle_b"}},
				{name="Montrer ses fesses",anim={"switch@trevor@mocks_lapdance","001443_01_trvs_28_idle_stripper"},func=49},
				{name="Se faire su*** en voiture",anim={"oddjobs@towing","m_blow_job_loop"},func=49},
				{name="Faire une gaterie en voiture",anim={"oddjobs@towing","f_blow_job_loop"},func=1},
				{name="***** en voiture",anim={"mini@prostitutes@sexlow_veh","low_car_sex_loop_player"},func=49},
				{name="Se ***** en voiture",anim={"mini@prostitutes@sexlow_veh","low_car_sex_loop_female"},func=1},
				{name="Mon coeur",anim={"mini@hookers_spvanilla","idle_a"}}
			}
		},
		["danses"] = {
			useFilter = true,
			b = { 
				{name="Danser",anim={"misschinese2_crystalmazemcs1_cs","dance_loop_tao"}},
				{name="Danser stylé",anim={"missfbi3_sniping","dance_m_default"},func=1},
				{name="Danse banale",anim={"rcmnigel1bnmt_1b","dance_loop_tyler"},func=1},
				{name="Danse spéciale 01",anim={"timetable@tracy@ig_5@idle_a","idle_a"},func=1},
				{name="Danse spéciale 02",anim={"timetable@tracy@ig_5@idle_a","idle_b"},func=1},
				{name="Danse spéciale 03",anim={"timetable@tracy@ig_5@idle_b","idle_e"},func=1},
				{name="Danse spéciale 04",anim={"timetable@tracy@ig_5@idle_b","idle_d"},func=1},
				{name="Danse de pecno ",anim={"special_ped@mountain_dancer@monologue_3@monologue_3a","mnt_dnc_buttwag"},func=1},
				{name="Danse basique",anim={"anim@amb@nightclub@lazlow@hi_podium@","danceidle_hi_06_base_laz"},func=1},
				{name="Danse turnaround",anim={"anim@amb@nightclub@lazlow@hi_podium@","danceidle_hi_11_turnaround_laz"},func=1},
				{name="Danse crotchgrab",anim={"anim@amb@nightclub@lazlow@hi_podium@","danceidle_hi_13_crotchgrab_laz"},func=1},
				{name="Danse flying",anim={"anim@amb@nightclub@lazlow@hi_podium@","danceidle_hi_13_flyingv_laz"},func=1},
				{name="Danse robot",anim={"anim@amb@nightclub@lazlow@hi_podium@","danceidle_mi_15_robot_laz"},func=1},
				{name="Danse shimmy",anim={"anim@amb@nightclub@lazlow@hi_podium@","danceidle_mi_15_shimmy_laz"},func=1},
				{name="Danse crazyrobot",anim={"anim@amb@nightclub@lazlow@hi_podium@","danceidle_hi_15_crazyrobot_laz"},func=1},
				{name="Danse smack",anim={"anim@amb@nightclub@lazlow@hi_podium@","danceidle_hi_17_smackthat_laz"},func=1},
				{name="Danse spider",anim={"anim@amb@nightclub@lazlow@hi_podium@","danceidle_hi_17_spiderman_laz"},func=1},
				{name="Danse hipswivel",anim={"anim@amb@nightclub@lazlow@hi_podium@","danceidle_li_13_hipswivel_laz"},func=1},
				{name="Danse Grind",anim={"anim@amb@nightclub@lazlow@hi_podium@","danceidle_li_15_sexygrind_laz"},func=1},
				{name="Danse point",anim={"anim@amb@nightclub@lazlow@hi_podium@","danceidle_mi_11_pointthrust_laz"},func=1},
				{name="Danse miturn",anim={"anim@amb@nightclub@lazlow@hi_podium@","danceidle_mi_13_turnaround_laz"},func=1},
				{name="Danse du ventre",anim={"mini@strip_club@private_dance@idle","priv_dance_idle"},func=1},
				{name="Dance Salsa Roll",anim={"anim@mp_player_intcelebrationmale@salsa_roll","salsa_roll"},func=1},
				{name="Danse de soirée 1",anim={"anim@amb@nightclub@dancers@crowddance_facedj@","hi_dance_facedj_09_v1_male^4"},func=1},
				{name="Danse de soirée 2",anim={"anim@amb@nightclub@dancers@crowddance_facedj@","hi_dance_facedj_09_v2_female^1"},func=1},
				{name="Danse de soirée 3",anim={"anim@amb@nightclub@dancers@crowddance_facedj@","hi_dance_facedj_09_v2_female^2"},func=1},
				{name="Danse de soirée 4",anim={"anim@amb@nightclub@dancers@crowddance_facedj@","hi_dance_facedj_09_v2_male^2"},func=1},
				{name="Danse de soirée 5",anim={"anim@amb@nightclub@dancers@crowddance_facedj@","hi_dance_facedj_11_v2_male^2"},func=1},
				{name="Danse de soirée 6",anim={"anim@amb@nightclub@dancers@crowddance_groups@","hi_dance_crowd_09_v1_female^1"},func=1},
				{name="Danse de soirée 7",anim={"anim@amb@nightclub@dancers@crowddance_groups@","hi_dance_crowd_09_v1_female^3"},func=1},
				{name="Danse de soirée 8",anim={"anim@amb@nightclub@djs@black_madonna@","dance_b_idle_a_blamadon"},func=1},
				{name="Danse de soirée 9",anim={"anim@amb@nightclub@mini@dance@dance_solo@female@var_a@","high_center"},func=1},
				{name="Danse de soirée 10",anim={"anim@amb@nightclub@mini@dance@dance_solo@female@var_a@","med_center"},func=1},
				{name="Danse de soirée 11",anim={"anim@amb@nightclub@mini@dance@dance_solo@female@var_b@","high_center_up"},func=1},
				{name="Dance Disco",anim={"anim@mp_player_intcelebrationmale@uncle_disco","uncle_disco"},func=1}
			}
		},
		["armes"] = {
			useFilter = true,
			b = { 
				{name="Animation execution",anim={"oddjobs@suicide","bystander_pointinto"},func=50},
				{name="Animation suicide",anim={"mp_suicide","pistol"},func=2},
				{name="Check arme",anim={"mp_corona@single_team","single_team_intro_one"}},
				{name="Arme pointé",anim={"random@arrests","cop_gunaimed_door_open_idle"},func=50},
				{name="Melée 1",anim={"anim@deathmatch_intros@melee@2h","intro_male_melee_2h_b"}},
				{name="Melée 2",anim={"anim@deathmatch_intros@melee@1h","intro_male_melee_1h_b"}},
				{name="Melée 3",anim={"anim@deathmatch_intros@melee@1h","intro_male_melee_1h_c"}},
				{name="Melée 4",anim={"mp_deathmatch_intros@melee@2h","intro_male_melee_2h_d"}},
				{name="Melée 5",anim={"mp_deathmatch_intros@melee@2h","intro_male_melee_2h_a_gclub"}},
				{name="Melée 6",anim={"mp_deathmatch_intros@melee@1h","intro_male_melee_1h_b"}},
				{name="Fight 1",anim={"anim@deathmatch_intros@unarmed","intro_male_unarmed_e"}},
				{name="Fight 2",anim={"anim@deathmatch_intros@unarmed","intro_male_unarmed_d"}},
				{name="Fight 3",anim={"anim@deathmatch_intros@unarmed","intro_male_unarmed_b"}}
			}
		},
		["tenue des armes"] = {
			useFilter = true,
			b = { 
				{name="Animation classique", type = "Default"},
				{name="Animation gangster", type = "Gang1H"},
				{name="Animation 007", type = "Hillbilly"},
				{name="Animation débutant", type = "FirstPersonAiming"},
			}
		},

	}
}

RegisterControlKey("animmenu2","Ouvrir le menu des animations","M",function()
	CreateMenu(MenuAnisa)
end)

RegisterNetEvent('demarche:loadsave')
AddEventHandler('demarche:loadsave', function(demarche, humeur)
	local demarcheAncien = GetResourceKvpString(string.format("demarcheAo"))
	local humeurAncien = GetResourceKvpString(string.format("humeurAo"))
	if demarche and demarcheAncien ~= "rien" then 
		RequestAndWaitSet(demarcheAncien)
		SetPedMovementClipset(GetPlayerPed(-1),demarcheAncien,0)
	end
	if humeur and humeurAncien ~= "rien" then 
		SetFacialIdleAnimOverride(GetPlayerPed(-1),humeurAncien,0)
	end
end)

RegisterNetEvent('demarche:upstar')
AddEventHandler('demarche:upstar', function(demarche, humeur, hm01, hm02)
	if demarche and hm01 ~= "rien" then 
		SetResourceKvp("demarcheAo", hm01)
	end
	if humeur and hm02 ~= "rien" then 
		SetResourceKvp("humeurAo", hm02)
	end
	if hm01 == "rien" then 
		SetResourceKvp("demarcheAo", "rien")
	end
	if hm02 == "rien" then 
		SetResourceKvp("humeurAo", "rien")
	end
end)

RegisterNetEvent('anims:start')
AddEventHandler('anims:start', function(anim)
	if anim.dict ~= nil then
		doAnim(anim.dict, nil, anim.func)
	end
end)