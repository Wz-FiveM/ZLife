Citizen.CreateThread(function()
	while ESX == nil do
		TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
		Citizen.Wait(0)
	end
end)
  
function KeyboardInput(TextEntry, ExampleText, MaxStringLength)
	AddTextEntry("FMMC_KEY_TIP1", TextEntry)
	DisplayOnscreenKeyboard(1, "FMMC_KEY_TIP1", "", ExampleText, "", "", "", MaxStringLength)
	blockinput = true

	while UpdateOnscreenKeyboard() ~= 1 and UpdateOnscreenKeyboard() ~= 2 do
		Citizen.Wait(0)
	end

	if UpdateOnscreenKeyboard() ~= 2 then
		local result = GetOnscreenKeyboardResult()
		Citizen.Wait(500)
		blockinput = false
		return result
	else
		Citizen.Wait(500)
		blockinput = false
		return nil
	end
end


MenuCreator = {
	Base = {Title = "Création", Header = {"commonmenu", "interaction_bgd"}},
	Data = {currentMenu = "Action"},
	Events = {
		onSelected = function(self, _, Neo, Pmenu, menuData, currentButton, currentSlt, result)
			PlaySoundFrontend(-1, "SELECT", "HUD_FRONTEND_DEFAULT_SOUNDSET", 1) 

            if Neo.name == "Nom du garage" then 
      
             
                local result = KeyboardInput("Nom", "", 25)
                if result ~= nil then 
                    MenuCreator.Menu["Action"].b[1].ask = result
                end 
            elseif Neo.name == "Position de l'entrée" then 
                local menuTable = MenuCreator.Menu["Action"].b[3]
                if not entree then       
                    local pos = GetEntityCoords(PlayerPedId())
                    menuTable.ask = "~g~Engeristrer"
                    menuTable.prefix = {x = round(pos.x, 3), y = round(pos.y, 3), z = round(pos.z, 3)}
                    menuTable.Description = json.encode(menuTable.prefix)
                else  
                    menuTable.ask, menuTable.prefix, menuTable.Description = "vide", nil, nil
                end
                entree = not entree
            elseif Neo.name == "Position de rangement (vehicle)" then 
                local menuTable = MenuCreator.Menu["Action"].b[4]
                if not rangement then       
                    local pos = GetEntityCoords(PlayerPedId())
                    local heading = GetEntityHeading(PlayerPedId())
                    menuTable.ask = "~g~Engeristrer"
                    menuTable.prefix = {x = round(pos.x, 3), y = round(pos.y, 3), z = round(pos.z, 3), h = heading}
                    menuTable.Description = json.encode(menuTable.prefix)
                else 
                    menuTable.ask, menuTable.prefix, menuTable.Description = "vide", nil, nil
                end  
                rangement = not rangement
            elseif Neo.name == "Prix" then 
                 local result = KeyboardInput("Prix", math.floor(Neo.price), 25)
                 if result ~= nil then 
                    MenuCreator.Menu["Action"].b[5].price = round(result, 0)
                 end
            elseif Neo.name == "Valider" then 
                local menuTable = MenuCreator.Menu["Action"].b
                local str = ""
                string.gsub(json.encode(menuData[2].slidename),"%d+",function(e)
                    str = str .. e
                end) 
                if menuTable[1].ask ~= "vide" and menuTable[1].ask ~= nil and menuTable[3].prefix ~= nil and menuTable[4].prefix ~= nil and menuTable[5].price ~= 0 and menuTable[5].price ~= nil then
                    ESX.ShowNotification("~g~Vous venez d'engeristrer le garage") 
                    TriggerServerEvent('pl_creategarage', menuTable[1].ask, str, menuTable[3].prefix, menuTable[4].prefix, menuTable[5].price)
                    CloseMenu(true)
                end
            end 

        end,
        onOpened = function()
            setheader("Menu création")
        end,
    },   
	Menu = {  
        ["Action"] = {
            b = {
                {name = "Nom du garage", ask = "vide", askX = true}, 
                {name = "Type de garage", slidemax = {"2 places", "4 places", "6 places", "10 places", "11 places (helicoptaire)", "12 places (luxe)", "24 places", "20 places", "94 places"}}, 
                {name = "Position de l'entrée", ask = "vide", prefix = nil, askX = true, Description = nil}, 
                {name = "Position de rangement (vehicle)", ask = "vide", prefix = nil, askX = true, Description = nil}, 
                {name = "Prix", price = 0, askX = true}, 
                {name = "Valider", ask = ">", askX = true}, 
            }
        },
	}  
}



RegisterKeyMapping('opengrage', 'Ouverture du menu shop', 'keyboard', 'F9')

RegisterCommand('opengrage', function()
    if PlayerData.job.name == "realestateagent" then 
        CreateMenu(MenuCreator)
    end    
end)