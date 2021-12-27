RegisterNetEvent('esx:setJob') 
AddEventHandler('esx:setJob', function(job)       
    PlayerData.job = job        
    Citizen.Wait(5000) 
end)


RegisterNetEvent('pl_askforentryingaragecl')
AddEventHandler('pl_askforentryingaragecl', function(identifier, id, places, k, entering)
    local message = true
    Citizen.CreateThread( function()
        while message do
            if IsControlJustPressed(0, 246) then 
                ESX.ShowNotification("~g~Vous avez accepter que la personne rentre dans votre garage")
                TriggerServerEvent("pl_sendmessageback", "accepted", identifier, id, places, k, entering)
                message = false
            elseif IsControlJustPressed(0, 49) then 
                ESX.ShowNotification("~r~Vous avez refuser la demande")
                TriggerServerEvent("pl_sendmessageback", "not_accepted", identifier)
                message = false
            end
            Wait(0)
        end
    end)
end)



RegisterNetEvent('pl_refreshgaragecl')
AddEventHandler('pl_refreshgaragecl', function(id, places)
    spawned = true
    if id == currentgarageid and spawned and inGarage then 
        deletevehicles() 
        loadvehicles(id, places)   
        spawned = false
    end 
end)


RegisterNetEvent('pl_insertmanuellementcl')
AddEventHandler('pl_insertmanuellementcl', function(name, places, entree, rangement, prix, id, cr)
    table.insert(shared.garagelist, {name = name, places = places, inside = entree, price = prix, rangement = rangement, owner = nil, colocataire = false, owned = false, id = id, creator = cr})
end)

RegisterNetEvent('pl_givegaragetoplayercl')
AddEventHandler('pl_givegaragetoplayercl', function(type, k, owner)
    if type == "everyone" then 
        shared.garagelist[k].owner = owner   
    elseif type == "solo" then 
        shared.garagelist[k].owned = true  
    end
end)

RegisterNetEvent('pf_givegaragelocationdate')
AddEventHandler('pf_givegaragelocationdate', function(type, k, date, owner)
    print(k)
    if type == "everyone" then 
        shared.garagelist[k].owner = owner 
        shared.garagelist[k].locationdate = date
        print(shared.garagelist[k].locationdate, shared.garagelist[k].owner)   
    elseif type == "solo" then 
        shared.garagelist[k].owned = true 
        print(shared.garagelist[k].owned)
    end 
end)


RegisterNetEvent('pl_deletelocokeyscl')
AddEventHandler('pl_deletelocokeyscl', function(k)
    shared.garagelist[k].colocataire = false  
end)


RegisterNetEvent('pl_removegarage')
AddEventHandler('pl_removegarage', function(id)
    for k, v in pairs(shared.garagelist) do 
        if v.id == id then 
            TriggerServerEvent('pl_changementgarage', "Reset", v.iterator, false)
        end 
    end 
end)



RegisterNetEvent('pl_changementgaragecl')
AddEventHandler('pl_changementgaragecl', function(type, iterator, value)
    if type == "Name" then 
        shared.garagelist[iterator].name = value
    elseif type == "Places" then 
        shared.garagelist[iterator].places = value
    elseif type == "Price" then 
        shared.garagelist[iterator].price = value
    elseif type == "Inside" then 
        shared.garagelist[iterator].inside = value
    elseif type == "Rangement" then 
        shared.garagelist[iterator].rangement = value
    elseif type == "Reset" then 
        shared.garagelist[iterator].owned = value 
        shared.garagelist[iterator].owner = nil
    end 
end)

RegisterNetEvent('pl_givekeysmanuelement')
AddEventHandler('pl_givekeysmanuelement', function(iterator)
    shared.garagelist[iterator].colocataire = true
end)



local vanishedUser = {}

RegisterNetEvent('pl_acceptplayerinhouse')
AddEventHandler('pl_acceptplayerinhouse', function(id, places, k, entering)
    TriggerServerEvent('pl_entergarage', k, {name = "dfs", propid = k, player = GetPlayerServerId(PlayerId())})
    entergarage(id, places, k, entering)
end)

RegisterCommand('def', function()
    SetEntityVisible(PlayerPedId(), true, 0)
end)

RegisterNetEvent('myProperties:setPlayerInvisible')
AddEventHandler('myProperties:setPlayerInvisible', function(type, playerEnter, instanceId)
    if type == "enter" then 
        local otherPlayer = GetPlayerFromServerId(playerEnter)
        if otherPlayer ~= nil then
            local otherPlayerPed = GetPlayerPed(otherPlayer)
            table.insert(vanishedUser, otherPlayerPed)
        end
    elseif type == "exit" then 
        vanishedUser = {}
    end 
end)


Citizen.CreateThread(function()
	while true do
		Citizen.Wait(0)
		time = 500
		if inGarage then
            time = 0
            local playerPed = PlayerPedId()
			for k, user in pairs(vanishedUser) do
				if user ~= playerPed then
					SetEntityLocallyInvisible(user)
                    SetEntityVisible(user, false, 0)
                    SetEntityNoCollisionEntity(playerPed, user, true)
                       
				end
			end
		end
        Citizen.Wait(time)
	end
end)