ESX = nil
Citizen.CreateThread(function()
	while ESX == nil do
	  TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
	  Citizen.Wait(0)
	end
end)

local Ascenseur = {
	Base = { Header = {"commonmenu", "interaction_bgd"}, Color = {color_black},  HeaderColor = {120, 230, 50},Title = "Ascenseur"},
	Data = { currentMenu = "ACTIONS DISPONIBLES", GetPlayerName() }, 
    Events = {
		onSelected = function(self, _, btn, PMenu, menuData, currentButton, currentBtn, currentSlt, result, slide)
			PlaySoundFrontend(-1, "SELECT", "HUD_FRONTEND_DEFAULT_SOUNDSET", 1)
			local slide = btn.slidenum
			local btn = btn.name
			local check = btn.unkCheckbox
			local closestPlayer, closestDistance = ESX.Game.GetClosestPlayer()
			local playerPed = PlayerPedId()
			local coords = GetEntityCoords(playerPed)
			
		if btn == "1er étage : accueil" then                                      			
              SetEntityCoords(GetPlayerPed(-1), -1097.6225,-848.6300, 19.0014)
       elseif btn == "2eme étage : cafétéria" then    
               SetEntityCoords(GetPlayerPed(-1), -1097.6768,-848.6515, 23.0384)
       elseif btn == "3eme étage : salle de sport - vestiaire" then    
               SetEntityCoords(GetPlayerPed(-1), -1097.5941,-848.5661, 26.8274)
	  elseif btn == "4eme étage : bureaux LAPD" then    
               SetEntityCoords(GetPlayerPed(-1), -1097.62,-848.5292, 30.7570)
	  elseif btn == "5eme étage : bureaux LAPD" then    
               SetEntityCoords(GetPlayerPed(-1), -1097.5253,-848.4591, 34.3610)
	  elseif btn == "-3 étage : garage LAPD - armurerie" then    
               SetEntityCoords(GetPlayerPed(-1), -1097.5985,-848.5132, 13.6870)
      elseif btn == "-2 étage : laboratoire" then    
               SetEntityCoords(GetPlayerPed(-1), -1097.6712,-848.5717, 10.2769) 
      elseif btn == "-1 étage : cellules de prison" then    
               SetEntityCoords(GetPlayerPed(-1), -1067.4903,-831.7894, 5.4797) 
 
end
end

	},
	
	Menu = { 
		["ACTIONS DISPONIBLES"] = { 
			b = { 
			    {name = "-1 étage : cellules de prison", ask = "", askX = true}, 
			    {name = "-2 étage : laboratoire", ask = "", askX = true}, 
			    {name = "-3 étage : garage LAPD - armurerie", ask = "", askX = true}, 
                {name = "1er étage : accueil", ask = "", askX = true}, 
                {name = "2eme étage : cafétéria", ask = "", askX = true}, 
				{name = "3eme étage : salle de sport - vestiaire", ask = "", askX = true}, 
				{name = "4eme étage : bureaux LAPD", ask = "", askX = true}, 
				{name = "5eme étage : bureaux LAPD", ask = "", askX = true}, 
			}
        }
	}
}


local ascenseurpos = {
    { x = -1097.69, y = -848.34, z = 4.88 },
	{ x = -1097.6225, y = -848.6300, z = 19.0014 },
	{ x = -1097.6768, y = -848.6515, z = 23.0384 },
	{ x = -1097.5941, y = -848.5661, z = 26.8274 },
	{ x = -1097.62, y = -848.5292, z = 30.7570 },
	{ x = -1097.5253, y = -848.4591, z = 34.3610 },
	{ x = -1097.5985, y = -848.5132, z = 13.6870 },
	{ x = -1097.6712, y = -848.5717, z = 10.2769 },
	{ x = -1067.4903, y = -831.7894, z = 5.4797 },
}

local interval = 5000

Citizen.CreateThread(function()
    while true do
		interval = 5000
        for k in pairs(ascenseurpos) do

            local plyCoords = GetEntityCoords(GetPlayerPed(-1), false)
            local dist = Vdist(plyCoords.x, plyCoords.y, plyCoords.z, ascenseurpos[k].x, ascenseurpos[k].y, ascenseurpos[k].z)

			if dist <= 5.0 then
				interval = 1
            	DrawMarker(25, ascenseurpos[k].x, ascenseurpos[k].y, ascenseurpos[k].z - 1.0001, 0, 0, 0, 0, 0, 0, 1.0001, 1.0001, 1, 0, 153, 234, 255, 0, 0, 1, 0, 0, 0, 0)
			end

			if dist <= 2.0 then
				interval = 1
				ESX.ShowHelpNotification("Appuyez sur ~INPUT_CONTEXT~ pour ~b~interagir avec l'ascenseur")
				if IsControlJustPressed(1,51) then 
                    CreateMenu(Ascenseur)
				end
            end

			if dist <= 8.0 then
				interval = 50000
			end
        end
		Wait(interval)
    end
end)



local Ascenseur2 = {
	Base = { Header = {"commonmenu", "interaction_bgd"}, Color = {color_black},  HeaderColor = {120, 230, 50},Title = "Ascenseur"},
	Data = { currentMenu = "ACTIONS DISPONIBLES", GetPlayerName() }, 
    Events = {
		onSelected = function(self, _, btn, PMenu, menuData, currentButton, currentBtn, currentSlt, result, slide)
			PlaySoundFrontend(-1, "SELECT", "HUD_FRONTEND_DEFAULT_SOUNDSET", 1)
			local slide = btn.slidenum
			local btn = btn.name
			local check = btn.unkCheckbox
			local closestPlayer, closestDistance = ESX.Game.GetClosestPlayer()
			local playerPed = PlayerPedId()
			local coords = GetEntityCoords(playerPed)
			
		if btn == "1er étage : accueil" then                                      			
              SetEntityCoords(GetPlayerPed(-1), 332.07,-595.70, 43.28)
       elseif btn == "2eme étage : toit" then    
               SetEntityCoords(GetPlayerPed(-1), 339.19,-584.04, 74.1684)
      elseif btn == "-1 étage : garage" then    
               SetEntityCoords(GetPlayerPed(-1), 339.36,-584.60, 28.79) 
 
end
end

	},
	
	Menu = { 
		["ACTIONS DISPONIBLES"] = { 
			b = { 
			    {name = "-1 étage : garage", ask = "", askX = true}, 
                {name = "1er étage : accueil", ask = "", askX = true}, 
                {name = "2eme étage : toit", ask = "", askX = true}, 
			}
        }
	}
}


local ascenseur2pos = {
    { x = 332.07, y = -595.70, z = 43.28 },
	{ x = 339.36, y = -584.60, z = 28.79 },
	{ x = 339.19, y = -584.04, z = 74.16 },
}


Citizen.CreateThread(function()
    local attente = 150
    while true do
        Wait(attente)

        for k in pairs(ascenseur2pos) do

            local plyCoords = GetEntityCoords(GetPlayerPed(-1), false)
            local dist = Vdist(plyCoords.x, plyCoords.y, plyCoords.z, ascenseur2pos[k].x, ascenseur2pos[k].y, ascenseur2pos[k].z)
            DrawMarker(25, ascenseur2pos[k].x, ascenseur2pos[k].y, ascenseur2pos[k].z - 1.0001, 0, 0, 0, 0, 0, 0, 1.0001, 1.0001, 1, 0, 153, 234, 255, 0, 0, 1, 0, 0, 0, 0)
			if dist <= 2.0 then
				attente = 1
				ESX.ShowHelpNotification("Appuyez sur ~INPUT_CONTEXT~ pour ~b~interagir avec l'ascenseur")
				if IsControlJustPressed(1,51) then 
                    CreateMenu(Ascenseur2)
				end
				break
            else
                attente = 150
            end
        end
    end
end)