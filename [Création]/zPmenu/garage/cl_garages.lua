PlayerData = {}
inGarage, visiter, currentid, currentgarageid, cooldown = false, false, nil, nil, false

  
Citizen.CreateThread( function()
    while ESX == nil do
		TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
		Citizen.Wait(0)
	end
    while ESX.GetPlayerData().job == nil do
        Citizen.Wait(10)
    end
    PlayerData = ESX.GetPlayerData() 
    ESX.TriggerServerCallback("pl_getallgarages", function(result)
        for k, v in pairs(result) do
            local iterator = k
            table.insert(shared.garagelist, {name = v.name, places = v.places, inside = v.inside, price = v.price, rangement = v.rangement, owner = v.owner, colocataire = false, owned = false, id = v.id, creator = v.creator, locationdate = v.locationdate, iterator = k})
      
            ESX.TriggerServerCallback("pl_checkkeysbegin", function(cb)
                if cb ~= "[]" then  
                    if cb == "owned" then
                        shared.garagelist[k].colocataire = true
                    end
                end
            end, v.id)

            if v.owner ~= nil or v.owner ~= "" then 
                ESX.TriggerServerCallback('pl_checkowner', function(cb) 
                    if cb == "owned" then
                        shared.garagelist[k].owned = true
                    end 
                end, json.decode(v.owner))
            end
        end
    end)
    TriggerServerEvent("pl_checklocation")
end)

MenuSelection = { 
	Base = {Header = {"shopui_title_carmod2", "shopui_title_carmod2"}},
	Data = {currentMenu = "Action"},
	Events = {
		onSelected = function(self, _, Neo, Pmenu, menuData, currentButton, currentMenu, currentSlt, result)
			PlaySoundFrontend(-1, "SELECT", "HUD_FRONTEND_DEFAULT_SOUNDSET", 1) 
            if self.Data.currentMenu == "Action" then  
                if Neo.value ~= nil then
                    local vehicleProps = ESX.Game.GetVehicleProperties(Neo.value)
                    TriggerEvent('esx:deleteVehicle') 
                    SetEntityCoords(PlayerPedId(), Neo.result.x, Neo.result.y, Neo.result.z)
                        ESX.Game.SpawnVehicle(vehicleProps.model, vector3(Neo.result.x, Neo.result.y, Neo.result.z), Neo.result.h, function(vehicle) 
                            ESX.Game.SetVehicleProperties(vehicle, vehicleProps)
                            SetPedIntoVehicle(PlayerPedId(), vehicle, -1)
                        end)   
                    deletevehicles()
                    for k, v in pairs(shared.currentVehicleingarage) do 
                        if v.vehicle == Neo.value then 
                        TriggerServerEvent("pl_deletegaragevehicle", v.carid)
                        end    
                    end 
                    TriggerServerEvent('pl_leavegarage') 
                    TriggerServerEvent('pl_refreshgarage', currentgarageid, shared.garagelist[currentid].places)
                    NetworkClearVoiceChannel()   
                    inGarage = false
                    CloseMenu(true)
                    cooldown = true
                    Wait(2000)
                    cooldown = false
                end
            end 
            
        end,
        onOpened = function()
        end,
    },   
	Menu = {  
        ["Action"] = {useFilter=true,b = {}},
	}  
}

GestionGarage = { 
	Base = {Title = "Garage", Header = {"commonmenu", "interaction_bgd"}},
	Data = {currentMenu = "Action"},
	Events = {
		onSelected = function(self, _, Neo, Pmenu, menuData, currentButton, currentSlt, result)
			PlaySoundFrontend(-1, "SELECT", "HUD_FRONTEND_DEFAULT_SOUNDSET", 1) 

            if Neo.name == "Atribuer vente" then 
                local closestPlayer, closestDistance = ESX.Game.GetClosestPlayer()
                if closestPlayer ~= -1 and closestDistance <= 3.0 then
                    TriggerServerEvent("pl_givegaragetoplayer", Neo.id, GetPlayerServerId(closestPlayer), Neo.iterator)
                    CloseMenu(true)
                else
                    ESX.ShowNotification('~r~Personne a proximité')
                end
            elseif Neo.name == "Atribuer a sois même" then 
                TriggerServerEvent("pl_givegaragetoplayer", Neo.id, GetPlayerServerId(PlayerId()), Neo.iterator)
                CloseMenu(true)
            elseif Neo.name == "Atribuer location" then 
                local closestPlayer, closestDistance = ESX.Game.GetClosestPlayer()
                if closestPlayer ~= -1 and closestDistance <= 3.0 then
                    local result = KeyboardInput("Date exemple ~r~(mois/jour/21)", "", 10)
                    if result ~= nil then 
                        TriggerServerEvent("pl_givelocation", Neo.id, GetPlayerServerId(closestPlayer), Neo.iterator, result)
                        CloseMenu(true)
                    end
                else   
                    ESX.ShowNotification('~r~Personne a proximité')
                end
            elseif Neo.name == "Atribuer location a sois même" then 
                local result = KeyboardInput("Date exemple ~r~(mois/jour/21)", "", 10)
                if result ~= nil then 
                    TriggerServerEvent('pl_givelocation', Neo.id, GetPlayerServerId(PlayerId()), Neo.iterator, result)
                end
            end 

            if Neo.prefix == 1 and Neo.slidenum == 1 then 
                local result = KeyboardInput('Prix', Neo.prix, 10)
                if result ~= nil then 
                    GestionGarage.Menu["Changement"].b[1].name = "Prix ~b~"..result.."$"
                    GestionGarage.Menu["Changement"].b[1].prix = result
                end
            elseif Neo.slidenum == 2 and Neo.prefix == 1 then 
                if GestionGarage.Menu["Changement"].b[1].prix ~= nil then 
                    TriggerServerEvent("pl_changementgarage", "Price", Neo.iterator, GestionGarage.Menu["Changement"].b[1].prix) 
                    TriggerServerEvent("pl_updatetable", Neo.id, "price", GestionGarage.Menu["Changement"].b[1].prix)
                end
            end 

            if Neo.prefix == 2 and Neo.slidenum == 1 then 
                local result = KeyboardInput('Nom', Neo.value, 25)
                if result ~= nil then 
                    GestionGarage.Menu["Changement"].b[2].name = "Nom ~b~"..result..""
                    GestionGarage.Menu["Changement"].b[2].value = result
                end
            elseif Neo.prefix == 2 and Neo.slidenum == 2 then 
                if GestionGarage.Menu["Changement"].b[2].value ~= nil then
                    TriggerServerEvent("pl_changementgarage", "Name", Neo.iterator, GestionGarage.Menu["Changement"].b[2].value) 
                    TriggerServerEvent("pl_updatetable", Neo.id, "name", GestionGarage.Menu["Changement"].b[2].value)
                end
            end 

            if Neo.prefix == 3 and Neo.slidenum == 2 or Neo.slidenum == 3 or Neo.slidenum == 4 or Neo.slidenum == 5 or Neo.slidenum == 6 or Neo.slidenum == 7 or Neo.slidenum == 8 or Neo.slidenum == 9 then 
                GestionGarage.Menu["Changement"].b[3].name = "Places ~b~"..Neo.slidename
                GestionGarage.Menu["Changement"].b[3].value = Neo.slidename
            elseif Neo.prefix == 3 and Neo.slidenum == 10 then 
                if GestionGarage.Menu["Changement"].b[3].value ~= nil then
                    TriggerServerEvent("pl_changementgarage", "Places", Neo.iterator, GestionGarage.Menu["Changement"].b[3].value) 
                    TriggerServerEvent("pl_updatetable", Neo.id, "places", GestionGarage.Menu["Changement"].b[3].value)
                end
            end 

            if Neo.prefix == 4 and Neo.slidenum == 1 then 
                local PlayerPos = GetEntityCoords(PlayerPedId())
                local xpos,ypos,zpos = table.unpack(PlayerPos)
                GestionGarage.Menu["Changement"].b[4].Description = json.encode({x = round(xpos, 3), y = round(ypos, 3), z = round(zpos, 3)})
                GestionGarage.Menu["Changement"].b[4].value = json.encode({x = round(xpos, 3), y = round(ypos, 3), z = round(zpos, 3)})
            elseif Neo.prefix == 4 and Neo.slidenum == 2 then 
                if GestionGarage.Menu["Changement"].b[4].value ~= nil then
                    TriggerServerEvent("pl_changementgarage", "Inside", Neo.iterator, GestionGarage.Menu["Changement"].b[4].value) 
                    TriggerServerEvent("pl_updatetable", Neo.id, "inside", GestionGarage.Menu["Changement"].b[4].value)
                end   
            end 

            if Neo.prefix == 5 and Neo.slidenum == 1 then 
                local PlayerPos = GetEntityCoords(PlayerPedId())
                local PlayerHeading = GetEntityHeading(PlayerPedId())
                local xpos,ypos,zpos = table.unpack(PlayerPos)
                GestionGarage.Menu["Changement"].b[5].Description = json.encode({x = round(xpos, 3), y = round(ypos, 3), z = round(zpos, 3), h = round(PlayerHeading, 3)})
                GestionGarage.Menu["Changement"].b[5].value = json.encode({x = round(xpos, 3), y = round(ypos, 3), z = round(zpos, 3), h = round(PlayerHeading, 3)})
            elseif Neo.prefix == 5 and Neo.slidenum == 2 then 
                if GestionGarage.Menu["Changement"].b[5].value ~= nil then
                    TriggerServerEvent("pl_changementgarage", "Rangement", Neo.iterator, GestionGarage.Menu["Changement"].b[5].value) 
                    TriggerServerEvent("pl_updatetable", Neo.id, "rangement", GestionGarage.Menu["Changement"].b[5].value)
                end   
            end 

            if Neo.name == "Effectuer des changement" then 
                GestionGarage.Menu["Changement"].b = {}
                table.insert(GestionGarage.Menu["Changement"].b, {name = "Prix ~b~"..Neo.prix.."$", slidemax = {"Changement", "~g~Valider"}, prix = Neo.prix, id = Neo.id, prefix = 1, iterator = Neo.iterator})
                table.insert(GestionGarage.Menu["Changement"].b, {name = "Nom ~b~"..Neo.nom.."", slidemax = {"Changement", "~g~Valider"}, id = Neo.id, value = Neo.nom, prefix = 2, iterator = Neo.iterator})
                table.insert(GestionGarage.Menu["Changement"].b, {name = "Places ~b~"..Neo.places, slidemax = {"Changement", "2", "4", "6", "10", "11", "12", "24", "20", "94", "~g~Valider"}, id = Neo.id, value = nil, prefix = 3, iterator = Neo.iterator})
                table.insert(GestionGarage.Menu["Changement"].b, {name = "Entrée", slidemax = {"Changement", "~g~Valider"}, value = nil, Description = shared.garagelist[Neo.iterator].inside, prefix = 4, iterator = Neo.iterator, id = Neo.id})   
                table.insert(GestionGarage.Menu["Changement"].b, {name = "Sortille", slidemax = {"Changement", "~g~Valider"}, value = nil, Description = shared.garagelist[Neo.iterator].rangement, prefix = 5, iterator = Neo.iterator, id = Neo.id})
                OpenMenu('Changement')
            end 

            if Neo.name == "Prolonger la location" then 
                local result = KeyboardInput('Date exemple ~r~(mois/jour/21)', Neo.ask, 25)
                if result ~= nil then 
                    GestionGarage.Menu["Action"].b[3].ask = result
                    TriggerServerEvent('pl_updatetable', Neo.id, "locationdate", result)
                end 
            end 

            if Neo.prefix == "reset" and Neo.slidenum == 2 then
                TriggerServerEvent("pl_changementgarage", "Reset", Neo.iterator, false)
                TriggerServerEvent("pl_updatetable", Neo.id, "owner", DEFAULT) 
                TriggerServerEvent("pl_updatetable", Neo.id, "locationdate", DEFAULT) 
                ESX.ShowNotification("~r~Vous venez de revoquer le garage")
                CloseMenu(true)
            end 
     
        end,
    },   
	Menu = {  
        ["Action"] = {b = {}},
        ["Changement"] = {b = {}},
	}  
}

MenuAchat = { 
	Base = {Title = "Garage", Header = {"commonmenu", "interaction_bgd"}},
	Data = {currentMenu = "Action"},
	Events = {
		onSelected = function(self, _, Neo, Pmenu, menuData, currentButton, currentSlt, result)
			PlaySoundFrontend(-1, "SELECT", "HUD_FRONTEND_DEFAULT_SOUNDSET", 1) 
            if self.Data.currentMenu == "Liste des locataire" then 
                if Neo.slidenum == 1 then
                    TriggerServerEvent("pl_deletelocokeys", Neo.id, Neo.steam, currentid) 
                    MenuAchat.Menu["Liste des locataire"].b[Neo.iterator].name, MenuAchat.Menu["Liste des locataire"].b[Neo.iterator].slidemax = "vide", {}
                elseif Neo.slidenum == 2 then 
                    local closestPlayer, closestDistance = ESX.Game.GetClosestPlayer()
                    if closestPlayer ~= -1 and closestDistance <= 3.0 then
                        TriggerServerEvent("pl_givegaragetoplayer", currentgarageid, GetPlayerServerId(closestPlayer), currentid)
                        shared.garagelist[currentid].owned = false
                        CloseMenu(true)
                    else 
                        ESX.ShowNotification('~r~Personne ca proximité')
                    end 
                end 
            end 

            if Neo.name == "Visiter" or Neo.name == "Rentrer dans le garage" then
                fade()
                entergarage(Neo.id, Neo.places, Neo.iterator, Neo.entering)
                if Neo.name == "Visiter" then 
                    visiter = true
                end 
                TriggerServerEvent("pl_entergarage", Neo.iterator, {name = Neo.nameofgarage, propid = Neo.iterator, player = GetPlayerServerId(PlayerId())})
            elseif Neo.name == "Sonner au garage" then 
                ESX.ShowNotification('~g~Vous venez de sonner chez ~s~~b~~h~'..Neo.ownername)
                TriggerServerEvent("pl_askforentryingarage", Neo.owner, Neo.nameofgarage, Neo.id, Neo.places, Neo.iterator, Neo.entering)
            end

            if Neo.name == "Donner une paire de clé" then 
                local closestPlayer, closestDistance = ESX.Game.GetClosestPlayer()
                if closestPlayer ~= -1 and closestDistance <= 3.0 then
                    ESX.TriggerServerCallback('pl_checkifhasgotkeys', function(cb)
                        if cb == "true" then 
                            TriggerServerEvent("pl_givekeys", GetPlayerServerId(closestPlayer), Neo.id, Neo.iterator)
                        elseif cb == "false" then
                            ESX.ShowNotification('~r~La personne a déja une paire de clé.')
                        end 
                    end, Neo.id, GetPlayerServerId(closestPlayer))
                else
                    ESX.ShowNotification('~r~Personne ca proximité')
                end 
            elseif Neo.name == "Liste des locataire" then 
                MenuAchat.Menu["Liste des locataire"].b = {}
                ESX.TriggerServerCallback('pl_checkkeys', function(cb) 
                    for k, v in pairs(cb) do 
                        table.insert(MenuAchat.Menu["Liste des locataire"].b, {name = v.name, slidemax = {"Revoquer", " Mettre propriéraire"}, id = v.id, steam = v.identifier, iterator = k, garageid = Neo.id})
                    end
                    OpenMenu("Liste des locataire")
                end, Neo.id)   
            end 

        end,
    },
	Menu = {  
        ["Action"] = {b = {}},
        ["Liste des locataire"] = {b = {}},
	}  
}




Citizen.CreateThread( function()
    while true do 
        time = 1000
     
        local pp = GetEntityCoords(PlayerPedId()) 
        for k, v in pairs(shared.garagelist) do 
            local inside, rangement = json.decode(v.inside), json.decode(v.rangement)
            local name, price, places, owner, creator, loc = v.name, v.price, v.places, json.decode(v.owner), json.decode(v.creator), v.locationdate
            local entering, menu = shared.GarageList[places.."place"].Entering, shared.GarageList[places.."place"].Menu
            local distinside, distinsentering, distinsrangement, distinsmenu = Vdist(pp, inside.x, inside.y, inside.z), Vdist(pp, entering), Vdist(pp, rangement.x, rangement.y, rangement.z), Vdist(pp, menu)

       
         

            if distinside < 25 then 
                time = 0
                DrawMarker(25, inside.x, inside.y, inside.z-0.97, 0.0, 0.0, 0.0, 0.0,0.0,0.0, 1.0, 1.0, 0.2, 46, 134, 193, 120, false, false, false, false) 
            end
            if inGarage then 
                time = 0
                DrawMarker(25, entering.x, entering.y, entering.z-0.97, 0.0, 0.0, 0.0, 0.0,0.0,0.0, 1.0, 1.0, 0.2, 46, 134, 193, 120, false, false, false, false) 
                if shared.garagelist[currentid].owned and k == currentid then 
                    if IsControlJustPressed(0, 47) then 
                        MenuAchat.Menu["Action"].b = {}
                        table.insert(MenuAchat.Menu["Action"].b, {name = "Donner une paire de clé", ask = ">", askX = true, id = v.id, iterator = k})
                        table.insert(MenuAchat.Menu["Action"].b, {name = "Liste des locataire", ask = ">", askX = true, id = v.id})
                        CreateMenu(MenuAchat)
                    end  
                end 
            end
            if v.owned and distinsrangement < 25 or v.colocataire and distinsrangement < 25 then 
                time = 0
                DrawMarker(25, rangement.x, rangement.y, rangement.z-0.97, 0.0, 0.0, 0.0, 0.0,0.0,0.0, 1.0, 1.0, 0.2, 211, 84, 0, 120, false, false, false, false) 
            elseif inGarage and not visiter and distinsmenu < 25 then 
                time = 0
                DrawMarker(25, menu.x, menu.y, menu.z+0.10, 0.0, 0.0, 0.0, 0.0,0.0,0.0, 1.5, 1.5, 0.2, 34, 153, 84, 120, false, false, false, false) 
            end 


            if distinsmenu < 1.5 then 
                ESX.ShowHelpNotification("Appuyez sur ~INPUT_PICKUP~ pour ouvrir le menu du ~g~Garage")
                if IsControlJustPressed(0, 51) then 
                    if k == currentid then 
                        MenuSelection.Menu["Action"].b = {}
                        for k, v in pairs(shared.currentVehicleingarage) do
                            table.insert(MenuSelection.Menu["Action"].b, {name = ""..GetLabelText(GetDisplayNameFromVehicleModel(v.props.model)).." [~g~"..v.props.plate.."~s~]", value = v.vehicle, result = json.decode(shared.garagelist[currentid].rangement)})
                        end 
                        CreateMenu(MenuSelection)
                    end
                end 
            end
     

            if distinside < 1 then 
                ESX.ShowHelpNotification('Appuyez sur ~INPUT_PICKUP~ pour accéder au ~b~Garage')
                if IsControlJustPressed(0, 51) then
                    MenuAchat.Menu["Action"].b = {}

                    if loc == nil then
                        locprefix = "" 
                    else
                        locprefix = loc
                    end

                    if shared.garagelist[k].owner ~= nil then 
                        ESX.TriggerServerCallback('pl_checkowner', function(cb)
                            if cb == "owned" then 
                                --table.insert(MenuAchat.Menu["Action"].b, {name = "Propriétaire ~b~~h~"..owner.name, ask = "~b~~h~"..locprefix, askX = true})
                                table.insert(MenuAchat.Menu["Action"].b, {name = "Rentrer dans le garage",  Description = "Nom du Garage : " ..name .."", ask = ">", askX = true, entering = entering, id = v.id, places = v.places, iterator = k, nameofgarage = name})
                            elseif cb == "false" then 
                                if v.colocataire then 
                                    --table.insert(MenuAchat.Menu["Action"].b, {name = "Propriétaire ~b~~h~"..owner.name, ask = "~b~~h~"..locprefix, askX = true})
                                    table.insert(MenuAchat.Menu["Action"].b, {name = "Rentrer dans le garage",  Description = "Nom du Garage : " ..name .."", ask = ">", askX = true, entering = entering, id = v.id, places = v.places, iterator = k, nameofgarage = name})
                                else
                                    table.insert(MenuAchat.Menu["Action"].b, {name = "Expire le :",  Description = "Nom du Garage : " ..name .."", ask = "~b~~h~"..locprefix, askX = true})
                                    table.insert(MenuAchat.Menu["Action"].b, {name = "Sonner au garage",  Description = "Nom du Garage : " ..name .."", ask = ">", askX = true, owner = owner.steam, ownername = owner.name, nameofgarage = name, id = v.id, places = v.places, iterator = k, entering = shared.GarageList[places.."place"].Entering})
                                end
                            end   
                            CreateMenu(MenuAchat) 
                        end, owner)
                    else
                        table.insert(MenuAchat.Menu["Action"].b, {name = "Prix de l'achat", price = price, Description = "Nom du Garage : " ..name .."",})
                        table.insert(MenuAchat.Menu["Action"].b, {name = "Visiter", Description = "Nom du Garage : " ..name .."", ask = ">", askX = true, entering = entering, id = v.id, places = v.places, iterator = k, garagename = nameofgarage})
                        CreateMenu(MenuAchat)  
                    end
                end
                if PlayerData.job.name == "realestateagent" then 
                    if IsControlJustPressed(0, 47) then 
                        GestionGarage.Menu["Action"].b = {}
                        ESX.TriggerServerCallback('pl_checkifowned', function(cb)
                            if cb ~= nil then 
                                table.insert(GestionGarage.Menu["Action"].b, {name = "Créateur ~b~~h~"..creator.name})
                                table.insert(GestionGarage.Menu["Action"].b, {name = "Propriétaire ~o~~h~"..owner.name, slidemax = {"Selection", "Revoquer"}, askX = true, prix = v.price, nom = name, places = places, iterator = k, id = v.id, prefix = "reset"})
                                if loc ~= nil then 
                                    table.insert(GestionGarage.Menu["Action"].b, {name = "Prolonger la location",  Description = "Nom du Garage : " ..name .."", ask = loc, id = v.id, askX = true})
                                end
                                table.insert(GestionGarage.Menu["Action"].b, {name = "Effectuer des changement",  Description = "Nom du Garage : " ..name .."", ask = ">", askX = true, prix = v.price, nom = name, places = places, iterator = k, id = v.id})
                            else
                                table.insert(GestionGarage.Menu["Action"].b, {name = "Créateur ~b~~h~"..creator.name, Description = "Nom du Garage : " ..name ..""})
                                table.insert(GestionGarage.Menu["Action"].b, {name = "Atribuer vente", Description = "Nom du Garage : " ..name .."", ask = ">", askX = true, id = v.id, iterator = k})
                                table.insert(GestionGarage.Menu["Action"].b, {name = "Atribuer a sois même", Description = "Nom du Garage : " ..name .."", ask = ">", askX = true, id = v.id, iterator = k})
                                table.insert(GestionGarage.Menu["Action"].b, {name = "Atribuer location", Description = "Nom du Garage : " ..name .."", ask = ">", askX = true, id = v.id, iterator = k})
                                table.insert(GestionGarage.Menu["Action"].b, {name = "Atribuer location a sois même", Description = "Nom du Garage : " ..name .."" , ask = ">", askX = true, id = v.id, iterator = k})
                                table.insert(GestionGarage.Menu["Action"].b, {name = "Effectuer des changement", Description = "Nom du Garage : " ..name .."", ask = ">", askX = true, prix = v.price, nom = name, places = places, iterator = k, id = v.id})
                            end
                            CreateMenu(GestionGarage)
                        end, v.id)
                    end
                end
            elseif distinsentering < 1 and inGarage then 
                local inside = json.decode(shared.garagelist[currentid].inside)
                time = 0
                ESX.ShowHelpNotification('Appuyez sur ~INPUT_PICKUP~ pour sortir du ~b~garage')
                if IsControlJustPressed(0, 51) then 
                    fade()
                    deletevehicles()
                   
                    SetEntityCoords(PlayerPedId(), inside.x, inside.y, inside.z-1)
                    inGarage = false
                    visiter = false
                    TriggerServerEvent('pl_leavegarage')
                    NetworkClearVoiceChannel()
                end
            elseif v.owned and distinsrangement < 1.9 and not IsPedOnFoot(PlayerPedId()) or v.colocataire and distinsrangement < 1.9 and not IsPedOnFoot(PlayerPedId()) then 
                ESX.ShowHelpNotification('Appuez sur ~INPUT_PICKUP~ pour ranger votre ~b~vehicule')
                if IsControlJustPressed(0, 51) and not inGarage and not cooldown then 
                    ESX.TriggerServerCallback("pl_checkcars", function(result)
                        fade()
                        local paire = {}
                        local highest = 0
                        for k, v in pairs(result) do 
                            table.insert(paire, k)
                           
                        end
                        for i,v in pairs(paire)do
                            if v > highest then
                                highest = v
                            end
                        end
                        if highest ~= "[]" then 
                            if highest < tonumber(places) then 
                                rangementvehicule(v.id)
                                Wait(500)
                                entergarage(v.id, shared.garagelist[k].places, k, shared.GarageList[shared.garagelist[k].places.."place"].Entering)
                                TriggerServerEvent("pl_entergarage", k, {name = name, propid = k, player = GetPlayerServerId(PlayerId())})
                                TriggerServerEvent("pl_refreshgarage", v.id, shared.garagelist[k].places)
                                NetworkClearVoiceChannel()
                            else
                                ESX.ShowNotification("~r~Vous n'avez plus de place dans le garage")
                            end
                        else
                            rangementvehicule(v.id)
                        end
                    end, v.id)
                end
            end

            if inGarage and not visiter and IsPedInAnyVehicle(PlayerPedId(), false) and k == currentid then 
               time = 0
               local vehicle = GetVehiclePedIsIn(GetPlayerPed(-1), false)
               
               if (GetPedInVehicleSeat(vehicle, -1) == GetPlayerPed(-1)) then
                    if IsControlJustPressed(0, 32) then 
                        local plate = GetVehicleNumberPlateText(vehicle)
                        
                        if IsPedInAnyVehicle(PlayerPedId(), false) then 
                            ESX.TriggerServerCallback('pl_checkcarsid', function(cb)
                                if cb ~= nil then 
                                    Citizen.CreateThread( function()
                                        DoScreenFadeOut(900) 
                                        Citizen.Wait(1000)
                                        DoScreenFadeIn(900)
                                    end)
                                    Wait(1000)
                                    TriggerServerEvent('pl_refreshgarage', currentgarageid, shared.garagelist[currentid].places)
                                    getoutvehicle(json.decode(shared.garagelist[currentid].rangement))
                                    Wait(1000)
                                else
                                    ESX.ShowNotification("~r~Votre vehicule n'a pas d'id")
                                    TriggerEvent('esx:deleteVehicle') 
                                end                      
                            end, v.id, plate)
                        end
                    end
                end
               
            end 
        end
 
        Wait(time)
    end
end)


