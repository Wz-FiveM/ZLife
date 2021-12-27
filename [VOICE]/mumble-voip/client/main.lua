local IsAnimated = false
ESX = nil

Citizen.CreateThread(function()
    while ESX == nil do
        TriggerEvent('esx:getSharedObject', function(obj)
            ESX = obj
        end)
        Citizen.Wait(0)
    end

    PlayerData = ESX.GetPlayerData()
end)


RegisterNetEvent('esx_basicneeds:resetStatus')
AddEventHandler('esx_basicneeds:resetStatus', function()
	TriggerEvent('esx_status:set', 'hunger', 500000)
	TriggerEvent('esx_status:set', 'thirst', 500000)
end)

RegisterNetEvent('esx_basicneeds:healPlayer')
AddEventHandler('esx_basicneeds:healPlayer', function()
	-- restore hunger & thirst
	TriggerEvent('esx_status:set', 'hunger', 1000000)
	TriggerEvent('esx_status:set', 'thirst', 1000000)

	-- restore hp
	local playerPed = PlayerPedId()
	SetEntityHealth(playerPed, GetEntityMaxHealth(playerPed))
end)


AddEventHandler('esx_status:loaded', function(status)
	TriggerEvent('esx_status:registerStatus', 'hunger', 1000000, '#107303', function(status)
		return true
	end, function(status)
		status.remove(75)
	end)
	TriggerEvent('esx_status:registerStatus', 'thirst', 1000000, '#005791', function(status)
		return true
	end, function(status)
		status.remove(75)
	end)
	Citizen.CreateThread(function()
		while true do
			Citizen.Wait(1000)
			local playerPed  = PlayerPedId()
			local prevHealth = GetEntityHealth(playerPed)
			local health     = prevHealth
			TriggerEvent('esx_status:getStatus', 'hunger', function(status)
				if status.val <= 100000 then
					ESX.ShowNotification("~r~Vous avez mal au ventre.")
				end
				if status.val == 0 then
					if prevHealth <= 150 then
						ESX.ShowNotification("~r~Vous avez très mal au ventre.")
						health = health - 2
					else
						health = health - 1
					end
				end
			end)
			TriggerEvent('esx_status:getStatus', 'thirst', function(status)
				if status.val <= 75000 then
					ESX.ShowNotification("~r~Vous avez mal au ventre.")
				end
				if status.val == 0 then
					if prevHealth <= 150 then
						ESX.ShowNotification("~r~Vous avez très mal au ventre.")
						health = health - 2
					else
						health = health - 1
					end
				end
			end)
			if health ~= prevHealth then
				SetEntityHealth(playerPed, health)
			end
		end
	end)
end)

AddEventHandler('esx_basicneeds:isEating', function(cb)
	cb(IsAnimated)
end)


local ngzOjWHO = {
    {dict="mp_player_inteat@burger",intro="mp_player_int_eat_burger_enter",loop="mp_player_int_eat_burger",outro="mp_player_int_eat_exit_burger",sound="Knuckle_Crack_Soft"},
    {dict="mp_player_inteat@pnq",intro="intro",loop="loop",outro="outro",sound="Slow_Clap_Cel"},
    {dict="mp_player_intdrink",intro="intro_bottle",loop="loop_bottle",outro="outro_bottle",sound="Bottle_Initial"},
    {dict="mp_player_intdrink",intro="intro",loop="loop",outro="outro",sound="Can_Gulp"}
}
local function dM(_u,aLgiy)
    local mvi,g4KV=GetPlayerPed(-1),ngzOjWHO[aLgiy]
    local dT7iYDf4,L=mvi,GetEntityCoords(mvi)
    RequestAndWaitModel(_u)
    RequestAndWaitDict(g4KV.dict)
    TaskSynchronizedTasks(dT7iYDf4,{{anim={g4KV.dict,g4KV.intro},flag=48},{anim={g4KV.dict,g4KV.loop},flag=49}})
    Citizen.Wait(50)
    local WRH9=CreateObjectNoOffset(GetHashKey(_u),L,0,0,0)
    AttachEntityToEntity(WRH9,dT7iYDf4,GetPedBoneIndex(dT7iYDf4,60309),.0,.0,.0,.0,.0,.0,true,true,false,true,1,1)
    Citizen.Wait(4000)
    TaskSynchronizedTasks(dT7iYDf4,{{anim={g4KV.dict,g4KV.loop},flag=48},{anim={g4KV.dict,g4KV.outro},flag=48}})
    if aLgiy<=2 then 
        DeleteEntity(WRH9)
    end
    Citizen.Wait((GetAnimDuration(g4KV.dict,g4KV.outro)*1000)-100)
    if aLgiy>2 then 
        DeleteEntity(WRH9,0,0)
    end 
end
local U={
    ["Hamburger"]={anim=1,p="prop_cs_burger_01"},
    ["drinkItem"]={anim=2},
    ["eatItem"]={anim=2},
    ["Eau de source"]={anim=3,p="prop_ld_flow_bottle"},
    ["Soda"]={anim=4,p="prop_ecola_can"},
    ["Donut"]={anim={"amb@code_human_wander_eating_donut@male@idle_a","idle_c"},p="prop_donut_02"},
    ["Viande crue"]={anim={"amb@code_human_wander_eating_donut@male@idle_a","idle_c"},p="prop_cs_steak"},
    ["Chocolat"]={anim=1,p="prop_choc_ego"},
    ["Bière sans alcool"]={anim=3,p="prop_amb_beer_bottle"},
    ["Bière"]={anim=3,p="prop_amb_beer_bottle"},
    ["Champagne"]={anim=3,p="prop_drink_whtwine"},
    ["Magnum"]={anim=3,p="prop_vodka_bottle"},
    ["Cocktail"]={anim=3,p="prop_cocktail"},
    ["Tequila"]={anim=3,p="prop_tequila"},
    ["Whisky"]={anim=3,p="prop_drink_whisky"},
    ["Bourbon"]={anim=3,p="prop_whiskey_bottle"},
    ["Tapas"]={anim=1,p="prop_taco_01"},
    ["Hot-dog"]={anim=2,p="prop_cs_hotdog_01"},
    ["Chips"]={anim=2,p="prop_choc_pq"},
    ["Vin"]={anim=3,p="prop_wine_bot_01"},
    ["Café"]={anim="WORLD_HUMAN_AA_COFFEE",time=10000},
    ["Thé vert"]={anim=3,p="v_res_fa_pottea"},
    ["Jus de Leechi"]={anim=3,p="p_w_grass_gls_s"},
    ["Maki"]={anim=1,p="prop_food_cb_burg02"},
    ["Bol de nouilles"]={anim=2,p="prop_ff_noodle_01"},
    ["Assiette de sushis"]={anim={"amb@code_human_wander_eating_donut@male@idle_a","idle_c"},p="prop_cs_plate_01"},
    ["Rouleau de printemps"]={anim=1,p="prop_taco_02"},
    ["Soupe de nouille"]={anim=2,p="v_ret_247_noodle1"},
    ["Pain"]={anim=1,p="v_ret_247_bread1"},
    ["Saumon frais"]={anim={"amb@code_human_wander_eating_donut@male@idle_a","idle_c"},p="prop_cs_steak"},
    ["Cannabis"]={anim={"WORLD_HUMAN_SMOKING_POT"},time=-1},
    ["Cocaïne"]={anim={"missfbi3_party","snort_coke_b_male3"},time=-1},
    ["Méthamphétamine"]={anim={"WORLD_HUMAN_SMOKING_POT"},time=-1},
    ["Cigarette"]={anim={"WORLD_HUMAN_SMOKING"},time=-1},
    ["Truite arc-en-ciel"]={anim={"amb@code_human_wander_eating_donut@male@idle_a","idle_c"},p="prop_cs_steak"},
    ["Kokanee"]={anim={"amb@code_human_wander_eating_donut@male@idle_a","idle_c"},p="prop_cs_steak"},
    ["Ombre de l'arctique"]={anim={"amb@code_human_wander_eating_donut@male@idle_a","idle_c"},p="prop_cs_steak"},
    ["Perche rock"]={anim={"amb@code_human_wander_eating_donut@male@idle_a","idle_c"},p="prop_cs_steak"},
    ["Petite bouche"]={anim={"amb@code_human_wander_eating_donut@male@idle_a","idle_c"},p="prop_cs_steak"},
    ["Grande bouche"]={anim={"amb@code_human_wander_eating_donut@male@idle_a","idle_c"},p="prop_cs_steak"},
    ["Truite bull"]={anim={"amb@code_human_wander_eating_donut@male@idle_a","idle_c"},p="prop_cs_steak"},
    ["Truite de lac"]={anim={"amb@code_human_wander_eating_donut@male@idle_a","idle_c"},p="prop_cs_steak"},
    ["Chinook"]={anim={"amb@code_human_wander_eating_donut@male@idle_a","idle_c"},p="prop_cs_steak"},
    ["Esturgeon pâle"]={anim={"amb@code_human_wander_eating_donut@male@idle_a","idle_c"},p="prop_cs_steak"},
    ["Spatules"]={anim={"amb@code_human_wander_eating_donut@male@idle_a","idle_c"},p="prop_cs_steak"},
    ["Gardon"]={anim={"amb@code_human_wander_eating_donut@male@idle_a","idle_c"},p="prop_cs_steak"},
    ["Frites"]={anim=2,p="prop_food_cb_chips"},
    ["Fricadelle"]={anim=2,p="prop_food_cb_chips"},
    ["L'américain"]={anim=2,p="prop_cs_burger_01"},
    ["Ch'ti burger"]={anim=2,p="prop_cs_burger_01"},
    ["Kebab"]={anim=2,p="prop_food_bs_burger2"},
    ["Tender"]={anim=2,p="ng_prop_food_bag01a"},
    ["Jupiler"]={anim=3,p="prop_beer_jakey"},
    ["Triple bière"]={anim=3,p="prop_beer_logger"}
}
function mangerItem(cJoBcud,e,B6zKxgVs)
    local O3_X=U[e]or U[cJoBcud.OnUse]
    if type(O3_X.anim)=="number"then
        dM(O3_X.p or"prop_cs_burger_01",O3_X.anim)
    else 
        local DVs8kf2w = not O3_X.time and 6000 or O3_X.time>0 and O3_X.time or nil doAnim(O3_X.anim,DVs8kf2w,48)
        if O3_X.p then 
            Citizen.Wait(750)
            attachObjectPedHand(O3_X.p,4000)
            Citizen.Wait(750)
        elseif not O3_X.time or O3_X.time>0 then 
            Citizen.Wait(O3_X.time or 5000)
        elseif not O3_X.anim[2]then
            Citizen.Wait(1000)
            while IsPedUsingScenario(GetPlayerPed(-1),O3_X.anim[1])do
                Citizen.Wait(1000)
            end 
        end 
    end
end
RegisterNetEvent('clp_nour:gry')
AddEventHandler('clp_nour:gry', function(Item, nItem, Type, Montant)
    mangerItem(Item, nItem, true)
    TriggerEvent('esx_status:add', Type, Montant)
end)