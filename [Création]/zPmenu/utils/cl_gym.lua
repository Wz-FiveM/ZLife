-- local posallshops = {
-- 	{vector3(-1207.84375,-1562.7189941406,4.6079850196838),"~b~faire des pompes",{"WORLD_HUMAN_PUSH_UPS"}, 1},
-- 	{vector3(484.0, -986.68, 25.76),"~b~faire des pompes",{"WORLD_HUMAN_PUSH_UPS"}, 1},
-- 	{vector3(-1204.9451904297,-1560.203125,4.6142826080322),"~b~faire des abdos",{"WORLD_HUMAN_SIT_UPS"}, 1},
-- 	{vector3(479.64, -987.32, 25.72),"~b~faire des abdos",{"WORLD_HUMAN_SIT_UPS"}, 1},
-- 	{vector3(-1202.9279785156,-1565.1817626953,4.6117258071899),"~b~faire des altères",{"world_human_muscle_free_weights"}, 1},
-- 	{vector3(-1199.1712646484,-1574.4119873047,4.6096444129944),"~b~faire des altères",{"world_human_muscle_free_weights"}, 1},
-- 	{vector3(-1196.9864501953,-1572.9965820313,4.6125831604004),"~b~faire des altères",{"world_human_muscle_free_weights"}, 1},
-- 	{vector3(-1210.4117431641,-1561.2764892578,4.6079459190369),"~b~faire des altères",{"world_human_muscle_free_weights"}, 1},
-- 	{vector3(484.56, -984.6, 25.72),"~b~faire des altères",{"world_human_muscle_free_weights"}, 1},
-- 	{vector3(-1200.0131835938,-1571.2615966797,4.6094350814819),"~b~faire des tractions",{"prop_human_muscle_chin_ups"}, 1},
-- 	{vector3(-1204.6706542969,-1564.4265136719,4.6096215248108),"~b~faire des tractions",{"prop_human_muscle_chin_ups"}, 1},
-- 	{vector3(481.84, -988.68, 25.72),"~b~faire des tractions",{"prop_human_muscle_chin_ups"}, 1},
-- 	{vector3(-1200.3039550781,-1564.2701416016,4.6173677444458),"~b~faire du yoga",{"world_human_yoga"}, 1},
-- 	{vector3(483.48, -988.96, 25.72),"~b~faire du yoga",{"world_human_yoga"}, 1},
-- }

-- Citizen.CreateThread(function()
--     while true do
-- 		local attente = 500
		
--         for _,v in pairs(posallshops) do

-- 			if not IsPedInAnyVehicle(GetPlayerPed(-1), false) then 
-- 				if Vdist2(GetEntityCoords(PlayerPedId(), false), v[1]) < 1.5 then
-- 					attente = 5
-- 					DrawText3D(v[1].x, v[1].y, v[1].z, "Appuyez sur ~b~E ~w~pour "..v[2], 9)
-- 					if IsControlJustPressed(1,51) then 
-- 						doAnim(v[3], nil, v[4])
-- 					end
-- 				end
-- 			elseif IsPedInAnyVehicle(GetPlayerPed(-1), false) then 
-- 				attente = 2500
-- 			end
-- 		end
-- 		Wait(attente)
--     end
-- end)