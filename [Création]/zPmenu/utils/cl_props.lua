ESX = nil
local PlayerData              = {}
local WRH9 = {}
local cJoBcud = 400.0
local e = {
    {x = 1410.96,  y = 3614.68,  z = 34.92,a = 49.46}, 
    {x = -689.12,  y = -945.52,  z = 20.44,a = 197.45}
}
local B6zKxgVs = {
    ["table"] = {
        "hei_prop_yah_table_01",
        "hei_prop_yah_table_03",
        "prop_chateau_table_01", 
        "prop_patio_lounger1_table",
        "prop_proxy_chateau_table", 
        "prop_rub_table_02", 
        "prop_rub_table_01", 
        "prop_table_01", 
        "prop_table_02", 
        "prop_table_03", 
        "prop_table_04", 
        "prop_table_05", 
        "prop_table_06", 
        "prop_table_07", 
        "prop_table_08",
        "prop_ven_market_table1", 
        "prop_yacht_table_01", 
        "prop_yacht_table_02", 
        "v_ret_fh_dinetable",
        "v_ret_fh_dinetble", 
        "v_res_mconsoletrad", 
        "prop_rub_table_02", 
        "ba_prop_int_trad_table",
        "xm_prop_x17_desk_cover_01a", 
        "xm_prop_lab_desk_02", 
        "xm_prop_lab_desk_01", 
        "ex_mp_h_din_table_05",
        "hei_prop_yah_table_02", 
        "prop_ld_farm_table02", 
        "prop_t_coffe_table", 
        "prop_t_coffe_table_02",
        "prop_ld_greenscreen_01",
        "prop_tv_cam_02",
        "prop_v_cam_01",
        "p_ing_microphonel_01"
    },
    ["rangement"] = {
        "p_pharm_unit_02", 
        "p_pharm_unit_01", 
        "p_v_43_safe_s", 
        "prop_bin_03a", 
        "prop_bin_07c",
        "prop_bin_08open", 
        "prop_bin_10a", 
        "prop_devin_box_01", 
        "prop_ld_int_safe_01",
        "prop_dress_disp_01", 
        "prop_dress_disp_02", 
        "prop_dress_disp_03", 
        "prop_dress_disp_04",
        "v_ret_fh_displayc"
    },

    ["lit"] = {
        "apa_mp_h_bed_double_08", 
        "apa_mp_h_bed_double_09", 
        "apa_mp_h_bed_wide_05",
        "imp_prop_impexp_sofabed_01a", 
        "apa_mp_h_bed_with_table_02", 
        "bka_prop_biker_campbed_01",
        "apa_mp_h_yacht_bed_01", 
        "apa_mp_h_yacht_bed_02", 
        "p_lestersbed_s", 
        "p_mbbed_s", 
        "v_res_d_bed",
        "v_res_tre_bed2", 
        "v_res_tre_bed1", 
        "v_res_mdbed", 
        "v_res_msonbed", 
        "v_res_tt_bed"
    },
    ["canapé"] = {
        "hei_prop_yah_lounger", 
        "hei_prop_yah_seat_01", 
        "hei_prop_yah_seat_02", 
        "hei_prop_yah_seat_03",
        "miss_rub_couch_01", 
        "p_armchair_01_s", 
        "p_ilev_p_easychair_s", 
        "p_lev_sofa_s", 
        "p_patio_lounger1_s",
        "p_res_sofa_l_s", 
        "p_v_med_p_sofa_s", 
        "prop_bench_01a", 
        "prop_bench_06", 
        "prop_ld_farm_chair01",
        "prop_ld_farm_couch01", 
        "prop_ld_farm_couch02", 
        "prop_rub_couch04", 
        "prop_t_sofa", 
        "prop_t_sofa_02",
        "v_ilev_m_sofa", 
        "v_res_tre_sofa_s", 
        "v_tre_sofa_mess_a_s", 
        "v_tre_sofa_mess_b_s",
        "v_tre_sofa_mess_c_s"
    },
    ["lspd"] = {
        "prop_barrier_work05",
        "prop_boxpile_07d",
        "p_ld_stinger_s",
        "prop_roadcone02a",
    },
    ["ls custom's"] = {
            "prop_cs_trolley_01",
            "gr_prop_gr_tool_chest_01a",
            "gr_prop_gr_tool_draw_01a",
            "prop_carcreeper",
            "prop_stockade_wheel_flat",
            "prop_toolchest_01",
            "prop_wheel_rim_02",
            "prop_wheel_tyre",
            "prop_car_engine_01",
            "imp_prop_engine_hoist_02a",
            "prop_engine_hoist",
    }, 
    ["ems"] = {
            "bkr_prop_duffel_bag_01a",
            "v_med_emptybed",
            "v_med_cor_emblmtable",
            "v_ret_gc_bag01",
            "xm_prop_body_bag",
    },
    ["chaise"] = {
        "prop_chair_01a", 
        "prop_chair_01b", 
        "prop_chair_02", 
        "prop_chair_03", 
        "prop_chair_04",
        "prop_chair_05", 
        "prop_chair_06", 
        "prop_chair_07", 
        "prop_chair_08", 
        "prop_chair_09", 
        "prop_chair_10",
        "apa_mp_h_din_chair_04", 
        "apa_mp_h_din_chair_08", 
        "apa_mp_h_din_chair_09", 
        "apa_mp_h_din_chair_12",
        "apa_mp_h_stn_chairarm_01", 
        "apa_mp_h_stn_chairarm_02", 
        "apa_mp_h_stn_chairarm_09",
        "apa_mp_h_stn_chairarm_11", 
        "apa_mp_h_stn_chairarm_12", 
        "apa_mp_h_stn_chairarm_13",
        "apa_mp_h_stn_chairarm_23", 
        "apa_mp_h_stn_chairarm_24", 
        "apa_mp_h_stn_chairarm_25",
        "apa_mp_h_stn_chairarm_26", 
        "apa_mp_h_stn_chairstrip_08", 
        "apa_mp_h_stn_chairstrip_04",
        "apa_mp_h_stn_chairstrip_05", 
        "apa_mp_h_stn_chairstrip_06", 
        "apa_mp_h_yacht_armchair_03",
        "apa_mp_h_yacht_armchair_04", 
        "ba_prop_battle_club_chair_02", 
        "apa_mp_h_yacht_strip_chair_01",
        "ba_prop_battle_club_chair_01", 
        "ba_prop_battle_club_chair_03", 
        "bka_prop_biker_boardchair01",
        "bka_prop_biker_chairstrip_01", 
        "bka_prop_biker_chairstrip_02"}
}
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
local function DVs8kf2w()
    WRH9.cam = CreateCamera("DEFAULT_SCRIPTED_CAMERA", false)
    WRH9.propHandle = nil
end
local function vms5(eZ0l3ch, W_63_9, h9dyA_4T)
    if h9dyA_4T then
        DestroyCam(WRH9.cam, false)
        WRH9.cam = nil;
        if WRH9.propHandle then
            DeleteEntity(WRH9.propHandle)
            WRH9.propHandle = nil
        end
    end
    RenderScriptCams(false, false, 0, false, false)
    ClearFocus()
end
local function M7(oh, DZXGTh, Su9Koz, Uk7e, KwQCk_G)
    local ptZa = false;
    if WRH9.propHandle then
        ptZa = true;
        DeleteEntity(WRH9.propHandle)
        WRH9.propHandle = nil
    end
    local PEqsd = oh;
    if not B6zKxgVs[PEqsd] then
        return
    end
    local iSj = B6zKxgVs[PEqsd][DZXGTh]
    RequestAndWaitModel(iSj)
    if not HasModelLoaded(iSj) then
        return
    end
    local iXxD6s = GetHashKey(iSj)
    WRH9.propHandle = CreateObjectNoOffset(iXxD6s, 0.0, 0.0, cJoBcud, false, true, false)
    SetModelAsNoLongerNeeded(iXxD6s)
    SetFocusArea(0.0, 0.0, cJoBcud)
    local oiY, FsYIVlkf = GetModelDimensions(iXxD6s)
    SetCamCoord(WRH9.cam, FsYIVlkf.x - oiY.x * 4, 0.0, cJoBcud + FsYIVlkf.z - oiY.z * 3)
    PointCamAtEntity(WRH9.cam, WRH9.propHandle, false, false, false, false)
    SetEntityHeading(WRH9.propHandle, 90.0)
    SetCamActive(WRH9.cam, true)
    RenderScriptCams(true, ptZa, ptZa and 1000 or 0, false, false)
end
local function v3(HLXS0Q_, Kw, nvaIsNv7, vDnoL55, xlAK)
    if Kw.currentMenu ~= "magasin" and nvaIsNv7.props then
        TriggerServerEvent('clp:giveitem', nvaIsNv7.props, nvaIsNv7.price, 1)
    end
end
local ihKb = {
	Base = { Header = {"shopui_title_gasstation", "shopui_title_gasstation"}, HeaderColor = {255, 255, 255}},
	Data = { currentMenu = "Magasin"},
	Events = {         
        onOpened = DVs8kf2w,
        onSelected = v3,
        onButtonSelected = M7,
        onExited = vms5,
        onBack = vms5,
    },
	Menu = {
		["Magasin"] = {
			b = {
				{name = "Table",ask = ">", askX = true},
				{name = "Rangement",ask = ">", askX = true},
				{name = "Lit",ask = ">", askX = true},
				{name = "Chaise",ask = ">", askX = true},
				{name = "Canapé",ask = ">", askX = true},
				{name = "LSPD",ask = ">", askX = true, canSee = function() return PlayerData.job ~= nil and PlayerData.job.name == 'police' end,},
				{name = "EMS",ask = ">", askX = true, canSee = function() return PlayerData.job ~= nil and PlayerData.job.name == 'ambulance' end,},
				{name = "Ls Custom's",ask = ">", askX = true, canSee = function() return PlayerData.job ~= nil and PlayerData.job.name == 'lscustoms' end,},
			}
		},
		["chaise"] = {
			useFilter = true,
			b = { 
				{name = "Chaise 01", props = "prop_chair_01a", price = 50},
				{name = "Chaise 02", props = "prop_chair_01b", price = 50},
				{name = "Chaise 03", props = "prop_chair_02", price = 50},
				{name = "Chaise 04", props = "prop_chair_03", price = 50},
				{name = "Chaise 05", props = "prop_chair_04", price = 50},
				{name = "Chaise 06", props = "prop_chair_05", price = 50},
				{name = "Chaise 07", props = "prop_chair_06", price = 50},
				{name = "Chaise 08", props = "prop_chair_07", price = 50},
				{name = "Chaise 09", props = "prop_chair_08", price = 50},
				{name = "Chaise 10", props = "prop_chair_09", price = 50},
				{name = "Chaise 11", props = "prop_chair_10", price = 50},
				{name = "Chaise 12", props = "apa_mp_h_din_chair_04", price = 50},
				{name = "Chaise 13", props = "apa_mp_h_din_chair_08", price = 50},
				{name = "Chaise 14", props = "apa_mp_h_din_chair_09", price = 50},
				{name = "Chaise 15", props = "apa_mp_h_din_chair_12", price = 50},
				{name = "Chaise 16", props = "apa_mp_h_stn_chairarm_01", price = 50},
				{name = "Chaise 17", props = "apa_mp_h_stn_chairarm_02", price = 50},
				{name = "Chaise 18", props = "apa_mp_h_stn_chairarm_09", price = 50},
				{name = "Chaise 19", props = "apa_mp_h_stn_chairarm_11", price = 50},
				{name = "Chaise 20", props = "apa_mp_h_stn_chairarm_12", price = 50},
				{name = "Chaise 21", props = "apa_mp_h_stn_chairarm_13", price = 50},
				{name = "Chaise 22", props = "apa_mp_h_stn_chairarm_23", price = 50},
				{name = "Chaise 23", props = "apa_mp_h_stn_chairarm_24", price = 50},
				{name = "Chaise 24", props = "apa_mp_h_stn_chairarm_25", price = 50},
				{name = "Chaise 25", props = "apa_mp_h_stn_chairarm_26", price = 50},
				{name = "Chaise 26", props = "apa_mp_h_stn_chairstrip_08", price = 50},
				{name = "Chaise 27", props = "apa_mp_h_stn_chairstrip_04", price = 50},
				{name = "Chaise 28", props = "apa_mp_h_stn_chairstrip_05", price = 50},
				{name = "Chaise 29", props = "apa_mp_h_stn_chairstrip_06", price = 50},
				{name = "Chaise 30", props = "apa_mp_h_yacht_armchair_03", price = 50},
				{name = "Chaise 31", props = "apa_mp_h_yacht_armchair_04", price = 50},
				{name = "Chaise 32", props = "ba_prop_battle_club_chair_02", price = 50},
				{name = "Chaise 33", props = "apa_mp_h_yacht_strip_chair_01", price = 50},
				{name = "Chaise 34", props = "ba_prop_battle_club_chair_01", price = 50},
				{name = "Chaise 35", props = "ba_prop_battle_club_chair_03", price = 50},
				{name = "Chaise 36", props = "bka_prop_biker_boardchair01", price = 50},
				{name = "Chaise 37", props = "bka_prop_biker_chairstrip_01", price = 50},
				{name = "Chaise 38", props = "bka_prop_biker_chairstrip_02", price = 50},
			}
		},
		["canapé"] = {
			useFilter = true,
			b = { 
				{name = "Canapé 01", props = "hei_prop_yah_lounger", price = 50},
				{name = "Canapé 02", props = "hei_prop_yah_seat_01", price = 50},
				{name = "Canapé 03", props = "hei_prop_yah_seat_02", price = 50},
				{name = "Canapé 04", props = "hei_prop_yah_seat_03", price = 50},
				{name = "Canapé 05", props = "miss_rub_couch_01", price = 50},
				{name = "Canapé 06", props = "p_armchair_01_s", price = 50},
				{name = "Canapé 07", props = "p_ilev_p_easychair_s", price = 50},
				{name = "Canapé 08", props = "p_lev_sofa_s", price = 50},
				{name = "Canapé 09", props = "p_patio_lounger1_s", price = 50},
				{name = "Canapé 10", props = "p_res_sofa_l_s", price = 50},
				{name = "Canapé 11", props = "p_v_med_p_sofa_s", price = 50},
				{name = "Canapé 12", props = "prop_bench_01a", price = 50},
				{name = "Canapé 13", props = "prop_bench_06", price = 50},
				{name = "Canapé 14", props = "prop_ld_farm_chair01", price = 50},
				{name = "Canapé 15", props = "prop_ld_farm_couch01", price = 50},
				{name = "Canapé 16", props = "prop_ld_farm_couch02", price = 50},
				{name = "Canapé 17", props = "prop_rub_couch04", price = 50},
				{name = "Canapé 18", props = "prop_t_sofa", price = 50},
				{name = "Canapé 19", props = "prop_t_sofa_02", price = 50},
				{name = "Canapé 20", props = "v_ilev_m_sofa", price = 50},
				{name = "Canapé 21", props = "v_res_tre_sofa_s", price = 50},
				{name = "Canapé 22", props = "v_tre_sofa_mess_a_s", price = 50},
				{name = "Canapé 23", props = "v_tre_sofa_mess_b_s", price = 50},
				{name = "Canapé 24", props = "v_tre_sofa_mess_c_s", price = 50},
			}
		},
		["table"] = {
			useFilter = true,
			b = { 
				{name = "Table 01", props = "hei_prop_yah_table_01", price = 50},
				{name = "Table 02", props = "hei_prop_yah_table_03", price = 50},
				{name = "Table 03", props = "prop_chateau_table_01", price = 50},
				{name = "Table 04", props = "prop_patio_lounger1_table", price = 50},
				{name = "Table 05", props = "prop_proxy_chateau_table", price = 50},
				{name = "Table 06", props = "prop_rub_table_02", price = 50},
				{name = "Table 07", props = "prop_rub_table_01", price = 50},
				{name = "Table 08", props = "prop_table_01", price = 50},
				{name = "Table 09", props = "prop_table_02", price = 50},
				{name = "Table 10", props = "prop_table_03", price = 50},
				{name = "Table 11", props = "prop_table_04", price = 50},
				{name = "Table 12", props = "prop_table_05", price = 50},
				{name = "Table 13", props = "prop_table_06", price = 50},
				{name = "Table 14", props = "prop_table_07", price = 50},
				{name = "Table 15", props = "prop_table_08", price = 50},
				{name = "Table 16", props = "prop_ven_market_table1", price = 50},
				{name = "Table 17", props = "prop_yacht_table_01", price = 50},
				{name = "Table 18", props = "prop_yacht_table_02", price = 50},
				{name = "Table 19", props = "v_ret_fh_dinetable", price = 50},
				{name = "Table 20", props = "v_ret_fh_dinetble", price = 50},
				{name = "Table 21", props = "v_res_mconsoletrad", price = 50},
				{name = "Table 22", props = "prop_rub_table_02", price = 50},
				{name = "Table 23", props = "ba_prop_int_trad_table", price = 50},
				{name = "Table 24", props = "xm_prop_x17_desk_cover_01a", price = 50},
				{name = "Table 25", props = "xm_prop_lab_desk_02", price = 50},
				{name = "Table 26", props = "xm_prop_lab_desk_01", price = 50},
				{name = "Table 27", props = "ex_mp_h_din_table_05", price = 50},
				{name = "Table 28", props = "hei_prop_yah_table_02", price = 50},
				{name = "Table 29", props = "prop_ld_farm_table02", price = 50},
				{name = "Table 30", props = "prop_t_coffe_table", price = 50},
                {name = "Table 31", props = "prop_t_coffe_table_02", price = 50},
                {name = "Fon vert", props = "prop_ld_greenscreen_01", price = 50},
                {name = "Caméra de film", props = "prop_tv_cam_02", price = 50},
                {name = "Caméra", props = "camera", price = 50},
                {name = "Micro", props = "micro", price = 50},
			}
		},
		["rangement"] = {
			useFilter = true,
			b = { 
				{name = "Rangement 01", props = "p_pharm_unit_02", price = 50},
				{name = "Rangement 02", props = "p_pharm_unit_01", price = 50},
				{name = "Rangement 03", props = "p_v_43_safe_s", price = 50},
				{name = "Rangement 04", props = "prop_bin_03a", price = 50},
				{name = "Rangement 05", props = "prop_bin_07c", price = 50},
				{name = "Rangement 06", props = "prop_bin_08open", price = 50},
				{name = "Rangement 07", props = "prop_bin_10a", price = 50},
				{name = "Rangement 08", props = "prop_devin_box_01", price = 50},
				{name = "Rangement 09", props = "prop_ld_int_safe_01", price = 50},
				{name = "Rangement 10", props = "prop_dress_disp_01", price = 50},
				{name = "Rangement 11", props = "prop_dress_disp_02", price = 50},
				{name = "Rangement 12", props = "prop_dress_disp_03", price = 50},
				{name = "Rangement 13", props = "prop_dress_disp_04", price = 50},
				{name = "Rangement 14", props = "v_ret_fh_displayc", price = 50},
			}
		},
		["lit"] = {
			useFilter = true,
			b = { 
				{name = "Lit 01", props = "apa_mp_h_bed_double_08", price = 50},
				{name = "Lit 02", props = "apa_mp_h_bed_double_09", price = 50},
				{name = "Lit 03", props = "apa_mp_h_bed_wide_05", price = 50},
				{name = "Lit 04", props = "imp_prop_impexp_sofabed_01a", price = 50},
				{name = "Lit 05", props = "apa_mp_h_bed_with_table_02", price = 50},
				{name = "Lit 06", props = "apa_mp_h_yacht_bed_01", price = 50},
				{name = "Lit 07", props = "apa_mp_h_yacht_bed_02", price = 50},
				{name = "Lit 08", props = "p_lestersbed_s", price = 50},
				{name = "Lit 09", props = "p_mbbed_s", price = 50},
				{name = "Lit 10", props = "v_res_d_bed", price = 50},
				{name = "Lit 11", props = "v_res_tre_bed2", price = 50},
				{name = "Lit 12", props = "v_res_tre_bed1", price = 50},
				{name = "Lit 13", props = "v_res_mdbed", price = 50},
				{name = "Lit 14", props = "v_res_msonbed", price = 50},
				{name = "Lit 15", props = "v_res_tt_bed", price = 50},
			}
		},
		["lspd"] = {
			useFilter = true,
			b = { 
				{name = "Barrière", props = "prop_barrier_work05", price = 50},
				{name = "Boîte en carton", props = "prop_boxpile_07d", price = 50},
				{name = "Herse", props = "p_ld_stinger_s", price = 50},
				{name = "Cône", props = "prop_roadcone02a", price = 50},
			}
		},
		["ls custom's"] = {
			useFilter = true,
			b = { 
				{name = "Etabli", props = "prop_cs_trolley_01", price = 50},
				{name = "Petite trousse à outils", props = "gr_prop_gr_tool_chest_01a", price = 50},
				{name = "Etabli carré", props = "gr_prop_gr_tool_draw_01a", price = 50},
				{name = "Carcéral", props = "prop_carcreeper", price = 50},
				{name = "Roue", props = "prop_stockade_wheel_flat", price = 50},
				{name = "Sacoche à outils", props = "prop_toolchest_01", price = 50},
				{name = "Jante", props = "prop_wheel_rim_02", price = 50},
				{name = "Pneu", props = "prop_wheel_tyre", price = 50},
				{name = "Moteur", props = "prop_car_engine_01", price = 50},
				{name = "Poulie 1", props = "imp_prop_engine_hoist_02a", price = 50},
				{name = "Poulie 2", props = "prop_engine_hoist", price = 50},
			}
		}, 
		["ems"] = {
			useFilter = true,
			b = { 
				{name = "Sac EMS", props = "bkr_prop_duffel_bag_01a", price = 50},
				{name = "Lit d'hôpital", props = "v_med_emptybed", price = 50},
				{name = "Lit d'hôpital en fer", props = "v_med_cor_emblmtable", price = 50},
				{name = "Gros sac", props = "v_ret_gc_bag01", price = 50},
				{name = "Sac de mort", props = "xm_prop_body_bag", price = 50},
			}
		}
	}
}
local JGSK = false
local function rA5U(zr1y)
    CreateThread(function()
        while JGSK do
            Wait(0)
            DrawTopNotification("Appuyez sur ~INPUT_CONTEXT~ pour intéragir ~o~avec le magasin~w~.")
            if IsControlJustPressed(0, 51) then
                CreateMenu(ihKb)
                setheader("Magasin de meuble")
            end
        end
    end)
end
CreateThread(function()
    local Hs
    while true do
        Wait(1000)
        local jk = LocalPlayer().Pos
        for qzSFyIO, Z65 in pairs(e) do
            if GetDistanceBetweenCoords(Z65.x, Z65.y, Z65.z, jk) < 1.5 then
                if not JGSK then
                    Hs = qzSFyIO;
                    JGSK = true;
                    rA5U(Hs)
                end
            elseif JGSK and Hs == qzSFyIO then
                JGSK = false;
                Hs = nil
            end
        end
    end
end)


--[[ INSERT INTO `items` (`name`, `label`, `limit`, `rare`, `can_remove`) VALUES
    ('prop_chair_01a', 'Chaise 01', -1, 0, 1),  
    ('prop_chair_01b', 'Chaise 02', -1, 0, 1),
    ('prop_chair_02', 'Chaise 03', -1, 0, 1),
    ('prop_chair_03', 'Chaise 04', -1, 0, 1),
    ('prop_chair_04', 'Chaise 05', -1, 0, 1),
    ('prop_chair_05', 'Chaise 06', -1, 0, 1),
    ('prop_chair_06', 'Chaise 07', -1, 0, 1),
    ('prop_chair_07', 'Chaise 08', -1, 0, 1),
    ('prop_chair_08', 'Chaise 09', -1, 0, 1),
    ('prop_chair_09', 'Chaise 10', -1, 0, 1),
    ('prop_chair_10', 'Chaise 11', -1, 0, 1),
    ('apa_mp_h_din_chair_04', 'Chaise 12', -1, 0, 1),
    ('apa_mp_h_din_chair_08', 'Chaise 13', -1, 0, 1),
    ('apa_mp_h_din_chair_09', 'Chaise 14', -1, 0, 1),
    ('apa_mp_h_din_chair_12', 'Chaise 15', -1, 0, 1),
    ('apa_mp_h_stn_chairarm_01', 'Chaise 16', -1, 0, 1),
    ('apa_mp_h_stn_chairarm_02', 'Chaise 17', -1, 0, 1),
    ('apa_mp_h_stn_chairarm_09', 'Chaise 18', -1, 0, 1),
    ('apa_mp_h_stn_chairarm_11', 'Chaise 19', -1, 0, 1),
    ('apa_mp_h_stn_chairarm_12', 'Chaise 20', -1, 0, 1),
    ('apa_mp_h_stn_chairarm_13', 'Chaise 21', -1, 0, 1),
    ('apa_mp_h_stn_chairarm_23', 'Chaise 22', -1, 0, 1),
    ('apa_mp_h_stn_chairarm_24', 'Chaise 23', -1, 0, 1),
    ('apa_mp_h_stn_chairarm_25', 'Chaise 24', -1, 0, 1),
    ('apa_mp_h_stn_chairarm_26', 'Chaise 25', -1, 0, 1),
    ('apa_mp_h_stn_chairstrip_08', 'Chaise 26', -1, 0, 1),
    ('apa_mp_h_stn_chairstrip_04', 'Chaise 27', -1, 0, 1),
    ('apa_mp_h_stn_chairstrip_05', 'Chaise 28', -1, 0, 1),
    ('apa_mp_h_stn_chairstrip_06', 'Chaise 29', -1, 0, 1),
    ('apa_mp_h_yacht_armchair_03', 'Chaise 30', -1, 0, 1),
    ('apa_mp_h_yacht_armchair_04', 'Chaise 31', -1, 0, 1),
    ('ba_prop_battle_club_chair_02', 'Chaise 32', -1, 0, 1),
    ('apa_mp_h_yacht_strip_chair_01', 'Chaise 33', -1, 0, 1),
    ('ba_prop_battle_club_chair_01', 'Chaise 34', -1, 0, 1),
    ('ba_prop_battle_club_chair_03', 'Chaise 35', -1, 0, 1),
    ('bka_prop_biker_boardchair01', 'Chaise 36', -1, 0, 1),
    ('bka_prop_biker_chairstrip_01', 'Chaise 37', -1, 0, 1),
    ('bka_prop_biker_chairstrip_02', 'Chaise 38', -1, 0, 1),

    ('hei_prop_yah_lounger', 'Canapé 01', -1, 0, 1),
    ('hei_prop_yah_seat_01', 'Canapé 02', -1, 0, 1),
    ('hei_prop_yah_seat_02', 'Canapé 03', -1, 0, 1),
    ('hei_prop_yah_seat_03', 'Canapé 04', -1, 0, 1),
    ('miss_rub_couch_01', 'Canapé 05', -1, 0, 1),
    ('p_armchair_01_s', 'Canapé 06', -1, 0, 1),
    ('p_ilev_p_easychair_s', 'Canapé 07', -1, 0, 1),
    ('p_lev_sofa_s', 'Canapé 08', -1, 0, 1),
    ('p_patio_lounger1_s', 'Canapé 09', -1, 0, 1),
    ('p_res_sofa_l_s', 'Canapé 10', -1, 0, 1),
    ('p_v_med_p_sofa_s', 'Canapé 11', -1, 0, 1),
    ('prop_bench_01a', 'Canapé 12', -1, 0, 1),
    ('prop_bench_06', 'Canapé 13', -1, 0, 1),
    ('prop_ld_farm_chair01', 'Canapé 14', -1, 0, 1),
    ('prop_ld_farm_couch01', 'Canapé 15', -1, 0, 1),
    ('prop_ld_farm_couch02', 'Canapé 16', -1, 0, 1),
    ('prop_rub_couch04', 'Canapé 17', -1, 0, 1),
    ('prop_t_sofa', 'Canapé 18', -1, 0, 1),
    ('prop_t_sofa_02', 'Canapé 19', -1, 0, 1),
    ('v_ilev_m_sofa', 'Canapé 20', -1, 0, 1),
    ('v_res_tre_sofa_s', 'Canapé 21', -1, 0, 1),
    ('v_tre_sofa_mess_a_s', 'Canapé 22', -1, 0, 1),
    ('v_tre_sofa_mess_b_s', 'Canapé 23', -1, 0, 1),
    ('v_tre_sofa_mess_c_s', 'Canapé 24', -1, 0, 1),

    ('p_pharm_unit_02', 'Rangement 01', -1, 0, 1),
    ('p_pharm_unit_01', 'Rangement 02', -1, 0, 1),
    ('p_v_43_safe_s', 'Rangement 03', -1, 0, 1),
    ('prop_bin_03a', 'Rangement 04', -1, 0, 1),
    ('prop_bin_07c', 'Rangement 05', -1, 0, 1),
    ('prop_bin_08open', 'Rangement 06', -1, 0, 1),
    ('prop_bin_10a', 'Rangement 07', -1, 0, 1),
    ('prop_devin_box_01', 'Rangement 08', -1, 0, 1),
    ('prop_ld_int_safe_01', 'Rangement 09', -1, 0, 1),
    ('prop_dress_disp_01', 'Rangement 10', -1, 0, 1),
    ('prop_dress_disp_02', 'Rangement 11', -1, 0, 1),
    ('prop_dress_disp_03', 'Rangement 12', -1, 0, 1),
    ('prop_dress_disp_04', 'Rangement 13', -1, 0, 1),
    ('v_ret_fh_displayc', 'Rangement 14', -1, 0, 1),

    ('apa_mp_h_bed_double_08', 'Lit 01', -1, 0, 1),
    ('apa_mp_h_bed_double_09', 'Lit 02', -1, 0, 1),
    ('apa_mp_h_bed_wide_05', 'Lit 03', -1, 0, 1),
    ('imp_prop_impexp_sofabed_01a', 'Lit 04', -1, 0, 1),
    ('apa_mp_h_bed_with_table_02', 'Lit 05', -1, 0, 1),
    ('apa_mp_h_yacht_bed_01', 'Lit 06', -1, 0, 1),
    ('apa_mp_h_yacht_bed_02', 'Lit 07', -1, 0, 1),
    ('p_lestersbed_s', 'Lit 08', -1, 0, 1),
    ('p_mbbed_s', 'Lit 09', -1, 0, 1),
    ('v_res_d_bed', 'Lit 10', -1, 0, 1),
    ('v_res_tre_bed2', 'Lit 11', -1, 0, 1),
    ('v_res_tre_bed1', 'Lit 12', -1, 0, 1),
    ('v_res_mdbed', 'Lit 13', -1, 0, 1),
    ('v_res_msonbed', 'Lit 14', -1, 0, 1),
    ('v_res_tt_bed', 'Lit 15', -1, 0, 1),

    ('hei_prop_yah_table_01', 'Table 01', -1, 0, 1),
    ('hei_prop_yah_table_03', 'Table 02', -1, 0, 1),
    ('prop_chateau_table_01', 'Table 03', -1, 0, 1),
    ('prop_patio_lounger1_table', 'Table 04', -1, 0, 1),
    ('prop_proxy_chateau_table', 'Table 05', -1, 0, 1),
    ('prop_rub_table_02', 'Table 06', -1, 0, 1),
    ('prop_rub_table_01', 'Table 07', -1, 0, 1),
    ('prop_table_01', 'Table 08', -1, 0, 1),
    ('prop_table_02', 'Table 09', -1, 0, 1),
    ('prop_table_03', 'Table 10', -1, 0, 1),
    ('prop_table_04', 'Table 11', -1, 0, 1),
    ('prop_table_05', 'Table 12', -1, 0, 1),
    ('prop_table_06', 'Table 13', -1, 0, 1),
    ('prop_table_07', 'Table 14', -1, 0, 1),
    ('prop_table_08', 'Table 15', -1, 0, 1),
    ('prop_ven_market_table1', 'Table 16', -1, 0, 1),
    ('prop_yacht_table_01', 'Table 17', -1, 0, 1),
    ('prop_yacht_table_02', 'Table 18', -1, 0, 1),
    ('v_ret_fh_dinetable', 'Table 19', -1, 0, 1),
    ('v_ret_fh_dinetble', 'Table 20', -1, 0, 1),
    ('v_res_mconsoletrad', 'Table 21', -1, 0, 1),
    ('ba_prop_int_trad_table', 'Table 23', -1, 0, 1),
    ('xm_prop_x17_desk_cover_01a', 'Table 24', -1, 0, 1),
    ('xm_prop_lab_desk_02', 'Table 25', -1, 0, 1),
    ('xm_prop_lab_desk_01', 'Table 26', -1, 0, 1),
    ('ex_mp_h_din_table_05', 'Table 27', -1, 0, 1),
    ('hei_prop_yah_table_02', 'Table 28', -1, 0, 1),
    ('prop_ld_farm_table02', 'Table 29', -1, 0, 1),
    ('prop_t_coffe_table', 'Table 30', -1, 0, 1),
    ('prop_t_coffe_table_02', 'Table 31', -1, 0, 1),

    ('prop_barrier_work05', 'Barrière', -1, 0, 1),
    ('prop_boxpile_07d', 'Boîte en carton', -1, 0, 1),
    ('p_ld_stinger_s', 'Herse', -1, 0, 1),
    ('prop_roadcone02a', 'Cône', -1, 0, 1),

    ('prop_cs_trolley_01', 'Etabli', -1, 0, 1),
    ('gr_prop_gr_tool_chest_01a', 'Petite trousse à outils', -1, 0, 1),
    ('gr_prop_gr_tool_draw_01a', 'Etabli carré', -1, 0, 1),
    ('prop_carcreeper', 'Carcéral', -1, 0, 1),
    ('prop_stockade_wheel_flat', 'Roue', -1, 0, 1),
    ('prop_toolchest_01', 'Sacoche à outils', -1, 0, 1),
    ('prop_wheel_rim_02', 'Jante', -1, 0, 1),
    ('prop_wheel_tyre', 'Pneu', -1, 0, 1),
    ('prop_car_engine_01', 'Moteur', -1, 0, 1),
    ('imp_prop_engine_hoist_02a', 'Poulie 1', -1, 0, 1),
    ('prop_engine_hoist', 'Poulie 2', -1, 0, 1),

    ('bkr_prop_duffel_bag_01a', 'Sac EMS', -1, 0, 1),
    ('v_med_emptybed', "Lit d'hôpital", -1, 0, 1),
    ('v_med_cor_emblmtable', "Lit d'hôpital en fer", -1, 0, 1),
    ('v_ret_gc_bag01', 'Gros sac', -1, 0, 1),
    ('xm_prop_body_bag', 'Sac de mort', -1, 0, 1),
; ]]

