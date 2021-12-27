ESX = nil
local PlayerData = {}
local currentsex = nil

RegisterNetEvent('esx:setJob')
AddEventHandler('esx:setJob', function(job)
    PlayerData.job = job
end)


local currentTattoos = {}
local currentmenudisplay
local target

AddEventHandler('skinchanger:modelLoaded', function()
    ESX.TriggerServerCallback('zedkover:requestPlayerTattoos', function(tattooList)
        if json.encode(tattooList) ~= "[]" then 
    
            for k,v in pairs(tattooList) do
                print( v.collection)
                SetPedDecoration(PlayerPedId(), v.collection, v.texture)
            end
			currentTattoos = tattooList
		end
	end)
end)

cars = {
    -- {label = "Pony", value = "pony"},
    -- {label = "Manchez2", value = "manchez2"}
}

Citizen.CreateThread(function()

    local blip = AddBlipForCoord(-1155.39, -1427.40, 4.95)
    SetBlipSprite(blip, 75)
    SetBlipColour(blip, 1)
	SetBlipScale(blip, 0.6)
    SetBlipAsShortRange(blip, true)

    BeginTextCommandSetBlipName('STRING')
    AddTextComponentString("Tattoo - Shop")
    EndTextCommandSetBlipName(blip)

end)

stock = {
    Base = {Header = {"commonmenu", "interaction_bgd"}, Color = {color_black}, HeaderColor = {255, 255, 255}}, 
    Data = {currentMenu = "Action"},
    Events = {
        onSelected = function(self, _, zedkover, PMenu, menuData, currentButton, currentBtn, currentSlt, result, slide)
                if self.Data.currentMenu == "Déposer un objet" then 
                    local result = KeyboardInput('Nombre', '', 10)
                    if result ~= nil then
                        TriggerServerEvent('zedkover:putStockItemstattoo', zedkover.value, result)
                        OpenMenu("Action")
                    end 
                elseif self.Data.currentMenu == "Retirer un objet" then 
                    local result = KeyboardInput('Nombre :', '', 10)
                    if result ~= nil then 
                        TriggerServerEvent('zedkover:getStockItemtattoo', zedkover.value, result)
                        OpenMenu("Action")
                    end  
                end

                if zedkover.name == "Déposer un objet" then 
                    stock.Menu["Déposer un objet"].b = {}
                    ESX.TriggerServerCallback('zedkover:getinventorytattoo', function(zedkover)
                        for i=1, #zedkover.items, 1 do
                            local item = zedkover.items[i]
                            if item.count > 0 then
                                table.insert(stock.Menu["Déposer un objet"].b,  {name = item.label .. ' x' .. item.count, askX = true, value = item.name})
                            end
                        end
                        OpenMenu("Déposer un objet")
                    end)
                elseif zedkover.name == "Retirer un objet" then 
                    stock.Menu["Retirer un objet"].b = {}
                    ESX.TriggerServerCallback('zedkover:getStockItemstattoo', function(items)  
                        for i=1, #items, 1 do 
                            if items[i].count > 0 then
                                table.insert(stock.Menu["Retirer un objet"].b, {name = 'x' .. items[i].count .. ' ' .. items[i].label, askX = true, value = items[i].name})
                            end
                        end
                    OpenMenu('Retirer un objet')
                    end)
                end
        end,
        onOpened = function()
            setheader('Stock')
        end,
    },
    Menu = {
        ["Action"] = {
            b = {
                {name = "Déposer un objet", ask = ">", askX = true, id = 33},
                {name = "Retirer un objet", ask = ">", askX = true, id = 33},
            }
        },
        ["Déposer un objet"] = { b = {} },
        ["Retirer un objet"] = { b = {} },
    }
}

Menu = {
    Base = {Header = {"commonmenu", "interaction_bgd"}, Color = {color_black}, HeaderColor = {255, 255, 255}}, 
    Data = {currentMenu = "Action"},
    Events = {
        onSelected = function(self, _, zedkover, PMenu, menuData, currentButton, currentBtn, currentSlt, result, slide)
            if zedkover.id == 33 then 
                OpenMenu(zedkover.name)
            elseif zedkover.name == "Effectuer une annonce" then 
                local result = KeyboardInput('', '', 255)
                if result ~= nil then 
                    TriggerServerEvent('zedkover:annoncetattoo', result)
                end
            elseif zedkover.name == "Effectuer une facture" then 
                local player, distance = ESX.Game.GetClosestPlayer() 
                if player ~= -1 and distance <= 3.0 then
                    CreateFacture("society_tattoo")
                else
                    ESX.ShowNotification('~r~Personne a proximité')
                end
            end

        end,
    },
    Menu = {
        ["Action"] = {
            b = {
                {name = "Effectuer une facture", askX = true},
                {name = "Effectuer une annonce", askX = true}
            }
        },
        ["Employer"] = {
            b = {
                {name = "Recruter", ask = ">", askX = true},
                {name = "Virer", ask = ">", askX = true},
                {name = "Promouvoir", ask = ">", askX = true},
                {name = "Destituer", ask = ">", askX = true}
            }
        }
    }
}

garage = {
    Base = {Header = {"commonmenu", "interaction_bgd"}, Color = {color_black}, HeaderColor = {255, 255, 255}}, 
    Data = {currentMenu = "Action"},
    Events = {
        onSelected = function(self, _, zedkover, PMenu, menuData, currentButton, currentBtn, currentSlt, result, slide)
            if self.Data.currentMenu == "Action" and zedkover.name ~= "Ranger le vehicule" then 
                ESX.Game.SpawnVehicle(zedkover.value, {x = -1158.06 ,y = -1415.73, z = 4.75}, 66.76, function(vehicle)
                    SetPedIntoVehicle(PlayerPedId(), vehicle, -1)       
				end)  
                CloseMenu(true)
            end 
            if zedkover.name == "Ranger le vehicule" then 
                TriggerEvent('esx:deleteVehicle')  
            end 
        end,
    },
    Menu = {
        ["Action"] = {
            b = {}
        },
    }
}

TattooMenu = {
    Base = { Header = {"shopui_title_tattoos4", "shopui_title_tattoos4"}, Color = {color_black}, HeaderColor = {255, 255, 255}},
    Data = { currentMenu = "Action" },
    Events = {
        onSelected = function(self, _, zedkover, PMenu, menuData, currentButton, currentBtn, currentSlt, result, slide)
            if self.Data.currentMenu == "Action" and zedkover.name ~= "Allonger" and zedkover.name ~= "Sex" then 

                TattooMenu.Menu["Changement tattoo"].b = {}
                for k, v in pairs(Config.AllTattooList) do 
                    if v.Zone == zedkover.value then 
                        if currentsex == "homme" then 
                            print('homme')
                            if GetLabelText(v.Name) ~= "NULL" then 
                                tattooname = GetLabelText(v.Name)
                            else
                                tattooname = v.Name
                            end 
                            table.insert(TattooMenu.Menu["Changement tattoo"].b, {name = tattooname, value = v.HashNameMale, col = v.Collection, prefix = v.Name, iterator = k})
                        else
                            print('famme')
                            if GetLabelText(v.Name) ~= "NULL" then 
                                tattooname = GetLabelText(v.Name)
                            else
                                tattooname = v.Name
                            end 
                            table.insert(TattooMenu.Menu["Changement tattoo"].b, {name = tattooname, value = v.HashNameFemale, col = v.Collection, prefix = v.Name, iterator = k})
                        end
                    end 
                end 
                OpenMenu('Changement tattoo')
    


            elseif self.Data.currentMenu == "Changement tattoo" and currentmenudisplay ~= "catalogue" then 
                TriggerServerEvent('zedkover:changeclothe', target, "achetertattoo", zedkover.col, zedkover.value)  
                RequestAnimDict('anim@amb@clubhouse@tutorial@bkr_tut_ig3@')
        
                while not HasAnimDictLoaded('anim@amb@clubhouse@tutorial@bkr_tut_ig3@') do
                  Citizen.Wait(0)
                end
                local ped = GetPlayerPed(-1)
                FreezeEntityPosition(ped, true)
                local x,y,z = table.unpack(GetEntityCoords(ped))
                local prop_name = "v_ilev_ta_tatgun"
                Jointsupp = CreateObject(GetHashKey(prop_name), x, y, z,  true,  true, true)
                AttachEntityToEntity(Jointsupp, ped, GetPedBoneIndex(ped, 28422), -0.0, 0.03, 0, 0, -270.0, -20.0, true, true, false, true, 1, true)
                TaskPlayAnim(ped, "anim@amb@clubhouse@tutorial@bkr_tut_ig3@", "machinic_loop_mechandplayer", 8.00, -8.00, -1, (2 + 16 + 32), 0.00, 0, 0, 0)
                Wait(15000)
                DeleteObject(Jointsupp)
                DetachEntity(Jointsupp, 1, true)
                ClearPedTasksImmediately(ped)
                ClearPedSecondaryTask(ped)
                FreezeEntityPosition(ped, false)
            end 
            if zedkover.name == "Allonger" and zedkover.slidenum == 1 then
                TriggerServerEvent('zedkover:changeclothe', target, "dos")
            elseif  zedkover.name == "Allonger" and zedkover.slidenum == 2 then
                TriggerServerEvent('zedkover:changeclothe', target, "ventre")
            elseif zedkover.name == "Sex" and zedkover.slidenum == 1 then 
                currentsex = "homme"
            elseif zedkover.name == "Sex" and zedkover.slidenum == 2 then 
                currentsex = "famme"
            end 
        end,
        onButtonSelected = function(currentMenu, currentBtn, zedkover, menuData, newButtons, self)
            if currentMenu == "Changement tattoo" then  
                if currentmenudisplay ~= "catalogue" then 
                    print(menuData.col, menuData.value)
                    TriggerServerEvent('zedkover:changetattoo', target, menuData.col, menuData.value)   
                else
                    ClearPedDecorations(ped)
                    SetPedDecoration(ped, menuData.col, menuData.value)
                end
                    
            end
        end,
        onOpened = function()
            if currentmenudisplay ~= "catalogue" then 
                TriggerServerEvent('zedkover:changeclothe', target, "changeclothe")
            end
        end,
        onExited = function()
            if currentmenudisplay ~= "catalogue" then 
            TriggerServerEvent('zedkover:changeclothe', target, "getclothes")
            else
                stepout()
                Wait(2000)
                DeletePed(ped)
            end
        end, 

    },
    Menu = {
        ["Action"] = {b = {}},
        ["Changement tattoo"] = {useFilter = true,b = {}},
    }
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
    while true do
            time = 500
            local plyCoords = GetEntityCoords(GetPlayerPed(-1), false)
            if PlayerData.job.name == "tattoo" then 
                local menutattoo = Vdist(plyCoords, -1155.39, -1427.40, 4.95-0.93)
                local menumenu = Vdist(plyCoords, -1152.31, -1423.62, 4.95-0.93)
                local menustock = Vdist(plyCoords, -1150.10, -1428.27, 4.95-0.93)
                --local menugarage = Vdist(plyCoords, -1153.57, -1421.30, 4.78-0.93)
                if menutattoo < 20 then 
                    time = 0
                    DrawMarker(25, -1155.39, -1427.40, 4.95-0.93, 0.0, 0.0, 0.0, 0.0,0.0,0.0, 0.8, 0.8, 0.2, 40, 180, 99, 120, false, false, false, false) 
                    DrawMarker(25, -1152.31, -1423.62, 4.95-0.93, 0.0, 0.0, 0.0, 0.0,0.0,0.0, 0.8, 0.8, 0.2, 52, 152, 219, 120, false, false, false, false) 
                    DrawMarker(25, -1150.10, -1428.27, 4.95-0.93, 0.0, 0.0, 0.0, 0.0,0.0,0.0, 0.8, 0.8, 0.2, 52, 152, 219, 120, false, false, false, false) 
                    --DrawMarker(25, -1153.57, -1421.30, 4.78-0.93, 0.0, 0.0, 0.0, 0.0,0.0,0.0, 0.8, 0.8, 0.2, 52, 152, 219, 120, false, false, false, false) 
                end      
                if menutattoo <= 1 then
                    ESX.ShowHelpNotification("Appuyez sur ~INPUT_TALK~ pour ~b~tatouer une personne")
                    if IsControlJustPressed(1,51) then
                        currentmenudisplay = "menu"
                        local closestPlayer, closestDistance = ESX.Game.GetClosestPlayer()
                        if closestDistance ~= -1 and closestDistance <= 3 then
                            target = GetPlayerServerId(closestPlayer) 
                            TattooMenu.Menu["Action"].b = {}  
                            table.insert(TattooMenu.Menu["Action"].b, {name = "Allonger", slidemax = {" Sur le dos", " Sur le ventre"}})
                            table.insert(TattooMenu.Menu["Action"].b, {name = "Sex", slidemax = {"Homme", "Famme"}}) 
                            for k, v in pairs(Config.TattooCats) do
                                table.insert(TattooMenu.Menu["Action"].b, {name = v[2], value = v[1]})
                            end
                            CreateMenu(TattooMenu)
                        else
                            ESX.ShowNotification('~r~Personne a proximité')
                        end    
                    end
                elseif menumenu <= 1 then 
                    ESX.ShowHelpNotification("Appuyez sur ~INPUT_TALK~ pour accéder au ~b~menu")
                    if IsControlJustPressed(1,51) then
                        setheader('Menu')
                        CreateMenu(Menu) 
                    end
                elseif menustock <= 1 then 
                    ESX.ShowHelpNotification("Appuyez sur ~INPUT_TALK~ pour accéder au ~b~stock")
                    if IsControlJustPressed(1,51) then
                        setheader('Stock')
                        CreateMenu(stock) 
                    end
                -- elseif menugarage <= 1 then 
                    -- ESX.ShowHelpNotification("Appuyez sur ~INPUT_TALK~ pour accéder au ~b~garage")
                    -- if IsControlJustPressed(1,51) then
                        -- setheader('Garage')
                        -- garage.Menu["Action"].b = {}
                        -- for k, v in pairs(cars) do
                            -- table.insert(garage.Menu["Action"].b, {name = v.label, value = v.value})
                        -- end
                        -- table.insert(garage.Menu["Action"].b, {name = "Ranger le vehicule"})
                        -- CreateMenu(garage) 
                    -- end
                end
            elseif PlayerData.job.name ~= "tattoo" then
                local catalogue = Vdist(plyCoords, -1153.56, -1424.66, 4.95-0.93)
                if catalogue < 20 then 
                    time = 0
                    DrawMarker(25, -1153.54, -1424.60, 4.95-0.93, 0.0, 0.0, 0.0, 0.0,0.0,0.0, 0.8, 0.8, 0.2, 52, 152, 219, 120, false, false, false, false) 
                end      
                if catalogue <= 1 then 
                    ESX.ShowHelpNotification("Appuyez sur ~INPUT_TALK~ pour accéder au ~b~catalogue")
                    if IsControlJustPressed(1,51) then
                        TattooMenu.Menu["Action"].b = {}
                        for k, v in pairs(Config.TattooCats) do
                            table.insert(TattooMenu.Menu["Action"].b, {name = v[2], value = v[1]})
                        end
                        currentmenudisplay = "catalogue"
                        ped = CreatePed(4, "mp_m_freemode_01", -1152.27, -1423.68, 3.95, false, true)
                        SetEntityHeading(ped, 124.0) 
                        FreezeEntityPosition(ped, true)
                        SetEntityCollision(ped, not ped, ped)
                        SetEntityInvincible(ped, true)
                        SetBlockingOfNonTemporaryEvents(ped, true)
                        pedclothe()
                        SetEntityAsMissionEntity(ped, true, true)
                        NetworkRegisterEntityAsNetworked(ped)
                        SetPedComponentVariation(ped, 0, 10, 0, 2) 
                        SetPedComponentVariation(ped, 2, 7, 1, 2) 
                        local id      = NetworkGetNetworkIdFromEntity(ped)
    
                        SetNetworkIdCanMigrate(id, false)
                        stepin()
                        Wait(2000)
                        CreateMenu(TattooMenu)
                    end
                end
            end
        Citizen.Wait(time)
    end
end)

function startAnims(lib, anim)
	local lib, anim = lib,anim
	ESX.Streaming.RequestAnimDict(lib)
	TaskPlayAnim(GetPlayerPed(-1), lib, anim, 8.0, 8.0, -1, 1, 1, 0, 0, 0)
end

RegisterNetEvent('zedkover:changeclothecl') 
AddEventHandler('zedkover:changeclothecl', function(result, z, q)
    if result == "changeclothe" then 
        SetEntityCoords(PlayerPedId(), -1155.90, -1428.49, 4.58)
        SetEntityHeading(PlayerPedId(), 18.13)
        Wait(100)
        FreezeEntityPosition(PlayerPedId(), true)

       
        Wait(2000)
        ClearPedTasksImmediately(GetPlayerPed(-1))
        TriggerEvent('skinchanger:getSkin', function(skin)
            if skin.sex == 0 then
                TriggerEvent('skinchanger:loadSkin', {
                    sex      = 0,
                    tshirt_1 = 15,
                    tshirt_2 = 0,
                    arms     = 15,
                    torso_1  = 15,
                    torso_2  = 0,
                    pants_1  = 14,
                    pants_2  = 0
                })
            else
                TriggerEvent('skinchanger:loadSkin', {
                    sex      = 1,
                    tshirt_1 = 15,
                    tshirt_2 = 0,
                    arms     = 15,
                    torso_1  = 15,
                    torso_2  = 0,
                    pants_1  = 14,
                    pants_2  = 0
                })
            end
        end)
    elseif result == "getclothes" then 
        FreezeEntityPosition(PlayerPedId(), false) 
        ESX.TriggerServerCallback('esx_skin:getPlayerSkin', function(skin)
            TriggerEvent('skinchanger:loadSkin', skin)
        end)
        ClearPedTasksImmediately(PlayerPedId())
        ClearPedSecondaryTask(PlayerPedId())
        ClearPedDecorations(PlayerPedId())
        for k,v in pairs(currentTattoos) do
            SetPedDecoration(PlayerPedId(), v.collection, v.texture)
        end
        SetEntityCoords(PlayerPedId(), -1156.60, -1426.75, 3.95)
        SetEntityHeading(PlayerPedId(), 304.13)
    elseif result == "achetertattoo" then
        ESX.TriggerServerCallback('zedkover:purchaseTattoo', function(cb)
            if cb then
                table.insert(currentTattoos, {collection = z, texture = q})
            end
        end, currentTattoos, {collection = z, texture = q})
    elseif result == "dos" then 
        startAnims("switch@trevor@annoys_sunbathers", "trev_annoys_sunbathers_loop_girl")
    elseif result == "ventre" then 
        startAnims("missfbi3_sniping", "prone_dave")
    end
end)

RegisterNetEvent('zedkover:changetattoocl') 
AddEventHandler('zedkover:changetattoocl', function(cr, pr)
    for k,v in pairs(currentTattoos) do
        SetPedDecoration(PlayerPedId(), v.collection, v.texture)
    end
    ClearPedDecorations(PlayerPedId())
    SetPedDecoration(PlayerPedId(), cr, pr)
end)

