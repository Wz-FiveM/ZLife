ESX = nil
local PlayerData = {}
local target = nil


RegisterNetEvent('esx:setJob')
AddEventHandler('esx:setJob', function(job)
    PlayerData.job = job
end)


Citizen.CreateThread(function()

    local blip = AddBlipForCoord(138.20, -1708.28, 29.30)
    SetBlipSprite(blip, 71)
    SetBlipColour(blip, 21)
    SetBlipAsShortRange(blip, true)

    BeginTextCommandSetBlipName('STRING')
    AddTextComponentString("Barber - Shop")
    EndTextCommandSetBlipName(blip)

end)

stock = {
    Base = {Header = {"commonmenu", "interaction_bgd"}, Color = {color_black}, HeaderColor = {255, 255, 255}}, 
    Data = {currentMenu = "Action"},
    Events = {
        onSelected = function(self, _, Neo, PMenu, menuData, currentButton, currentBtn, currentSlt, result, slide)
                if self.Data.currentMenu == "Déposer un objet" then 
                    local result = KeyboardInput('Nombre', '', 10)
                    if result ~= nil then
                        TriggerServerEvent('Neo:putStockItems', Neo.value, result)
                        OpenMenu("Action")
                    end 
                elseif self.Data.currentMenu == "Retirer un objet" then 
                    local result = KeyboardInput('Nombre :', '', 10)
                    if result ~= nil then 
                        TriggerServerEvent('Neo:getStockItem', Neo.value, result)
                        OpenMenu("Action")
                    end  
                end

                if Neo.name == "Déposer un objet" then 
                    stock.Menu["Déposer un objet"].b = {}
                    ESX.TriggerServerCallback('Neo:getinventory', function(Neo)
                        for i=1, #Neo.items, 1 do
                            local item = Neo.items[i]
                            if item.count > 0 then
                                table.insert(stock.Menu["Déposer un objet"].b,  {name = item.label .. ' x' .. item.count, askX = true, value = item.name})
                            end
                        end
                        OpenMenu("Déposer un objet")
                    end)
                elseif Neo.name == "Retirer un objet" then 
                    stock.Menu["Retirer un objet"].b = {}
                    ESX.TriggerServerCallback('Neo:getStockItems', function(items)  
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
            --setheader('Stock')
        end,
    },
    Menu = {
        ["Action"] = {
            b = {
                {name = "Déposer un objet", ask = ">", askX = true, id = 33},
                {name = "Retirer un objet", ask = ">", askX = true, id = 33},
                --{name = "Vestiaires", ask = ">", askX = true, id = 33}
            }
        },
        ["Déposer un objet"] = { b = {} },
        ["Retirer un objet"] = { b = {} },
       -- ["Vestiaires"] = { b = {} },
    }
}

garage = {
    Base = {Header = {"commonmenu", "interaction_bgd"}, Color = {color_black}, HeaderColor = {255, 255, 255}}, 
    Data = {currentMenu = "Action"},
    Events = {
        onSelected = function(self, _, Neo, PMenu, menuData, currentButton, currentBtn, currentSlt, result, slide)
            if self.Data.currentMenu == "Action" and Neo.name ~= "Ranger le vehicule" then 
                ESX.Game.SpawnVehicle(Neo.value, 130.64, -1717.35,29.06, 54.00, function(vehicle)
                    SetPedIntoVehicle(PlayerPedId(), vehicle, -1)       
				end)  
                CloseMenu(true)
            end 
            if Neo.name == "Ranger le vehicule" then 
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

menumain = {
    Base = {Header = {"commonmenu", "interaction_bgd"}, Color = {color_black}, HeaderColor = {255, 255, 255}}, 
    Data = {currentMenu = "Action"},
    Events = {
        onSelected = function(self, _, Neo, PMenu, menuData, currentButton, currentBtn, currentSlt, result, slide)
            if Neo.name == "Effectuer une annonce" then 
                local result = KeyboardInput('', '', 255)
                if result ~= nil then 
                    TriggerServerEvent('Neo:annoncebarber', result)
                end
            elseif Neo.name == "Effectuer une facture" then 
                local player, distance = ESX.Game.GetClosestPlayer() 
                if player ~= -1 and distance <= 3.0 then
                    CreateFacture("society_barber")
                else
                    ESX.ShowNotification('~r~Personne a proximité')
                end
            end 


            if Neo.name == "Recruter" then 
                local player, distance = ESX.Game.GetClosestPlayer()
                if distance ~= -1 and distance <= 3.0 then   
                    TriggerServerEvent('Neo:Boss_recruterplayer', GetPlayerServerId(player), PlayerData.job.name, 0)   
                end  
            elseif Neo.name == "Virer" then  
                local player, distance = ESX.Game.GetClosestPlayer()
                if distance ~= -1 and distance <= 3.0 then   
                    TriggerServerEvent('Neo:Boss_virerplayer', GetPlayerServerId(player))   
                end   
            elseif Neo.name == "Promouvoir" then
                local player, distance = ESX.Game.GetClosestPlayer()
                if distance ~= -1 and distance <= 3.0 then   
                    TriggerServerEvent('Neo:Boss_promouvoirplayer', GetPlayerServerId(player)) 
                end
            elseif Neo.name == "Destituer" then 
                local player, distance = ESX.Game.GetClosestPlayer()
                if distance ~= -1 and distance <= 3.0 then   
                    TriggerServerEvent('Neo:Boss_destituerplayer', GetPlayerServerId(player))
                end
            end 

            if Neo.id == 4164 and Neo.slidenum == 1 then 
                local reslut = KeyboardInput('Montant :', '', 10)
                if reslut ~= nil then
                    TriggerServerEvent("Neo:Dépot", PlayerData.job.name, reslut)
                    CloseMenu(true)
                end
            elseif Neo.id == 4164 and Neo.slidenum == 2 then 
                local reslut = KeyboardInput('Montant :', '', 10)
                if reslut ~= nil then
                    TriggerServerEvent("Neo:withdraw", PlayerData.job.name, reslut) 
                    CloseMenu(true)
                end
            end 

            if Neo.name == "Action patron" then 
                menumain.Menu["Action patron"].b = {}
                table.insert(menumain.Menu["Action patron"].b, {name = "Employer", ask = ">", askX = true})
                ESX.TriggerServerCallback('Neo:getsocietymoney', function(Neo)
                    for k, v in pairs(Neo) do
                        if v.account_name == "society_"..PlayerData.job.name.."" then 
                            table.insert(menumain.Menu["Action patron"].b, {name = "Argent de la société ~g~"..v.money.."$", slidemax = {"Déposer", "Retirer"}, askX = true, id = 4164})
                        end
                    end
                    OpenMenu("Action patron")  
                end)
            end 

            if Neo.name == "Employer" then 
                OpenMenu('Employer')
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
        },
        ["Action patron"] = {b = {}},
    }
}

local BarberNoPed = {
    Base = {Header = {"commonmenu", "interaction_bgd"}, Color = {color_black}, HeaderColor = {255, 255, 255}}, 
    Data = { currentMenu = "Coiffeurs" },
    Events = {
        onExited = function(self, _, Neo, CMenu, menuData, currentButton, currentBtn, currentSlt, result, slide, onSlide) 
			ClearPedTasks(PlayerPedId())
            TriggerEvent('skinchanger:modelLoaded')
        end,
        onOpened = function()
        end, 
        onSelected = function(self, _, Neo, PMenu, menuData, currentButton, currentBtn, currentSlt, result, slide)

            if Neo.id == 33 then 
                OpenMenu(Neo.name)
            end 

            if  Neo.name == "Selection" and Neo.slidenum == 2 then
                TriggerServerEvent('annulertarget', target)
                CloseMenu(true)
            elseif Neo.name == "Selection" and Neo.slidenum == 1 then
                SetEntityCoords(PlayerPedId(), 138.12, -1708.47, 28.30)
                SetEntityHeading(PlayerPedId(), 210.8189697)

                local x,y,z = table.unpack(GetEntityCoords(GetPlayerPed(-1)))
                local prop_name = "prop_cs_scissors"
                ciseau = CreateObject(GetHashKey(prop_name), x, y, z,  true,  true, true)
                AttachEntityToEntity(ciseau, GetPlayerPed(-1), GetPedBoneIndex(GetPlayerPed(-1), 28422), -0.0, 0.03, 0, 0, -270.0, -20.0, true, true, false, true, 1, true)
                startAnims("misshair_shop@barbers", "keeper_idle_b")
                    Wait(10500)
                    DeleteObject(ciseau)
                DetachEntity(ciseau, 1, true)
                ClearPedTasksImmediately(GetPlayerPed(-1))
                ClearPedSecondaryTask(GetPlayerPed(-1))


                TriggerServerEvent('saveskintarget', target)
                ESX.ShowNotification("~r~Coiffeurs~s~\nVous avez changer la coupe de votre client.")
                CloseMenu(true)
            end
        end,
        onSlide = function(menuData, Neo, currentButton, currentSlt, slide, PMenu)
            local slide = Neo.slidenum

            if Neo.name == "Coupes" and slide ~= -1 then
                coupe = slide - 1
                TriggerServerEvent('skinchanger:changetarget', target, 'hair_1', coupe)
            elseif Neo.name == "Teinture" and slide ~= -1 then
                teinture1 = slide - 1
                TriggerServerEvent('skinchanger:changetarget', target, 'hair_color_1', teinture1)
            elseif Neo.name == "Teinture 2" and slide ~= -1 then
                teinture2 = slide - 1
                TriggerServerEvent('skinchanger:changetarget', target, 'hair_color_2', teinture2)
            elseif Neo.name == "Barbes" and slide ~= -1 then
                barbe = slide - 1
                TriggerServerEvent('skinchanger:changetarget', target, 'beard_1', barbe)
            elseif Neo.name == "Taille" and slide ~= -1 then
                tbarbe = slide - 1
                TriggerServerEvent('skinchanger:changetarget', target, 'beard_2', tbarbe)
            elseif Neo.name == "Teinture Barbe" and slide ~= -1 then
                teinture1b = slide - 1
                TriggerServerEvent('skinchanger:changetarget', target, 'beard_3', teinture1b)
            elseif Neo.name == "Sourcil" and slide ~= -1 then
                sourciltype = slide - 1
                TriggerServerEvent('skinchanger:changetarget', target, 'eyebrows_1', sourciltype)
            elseif Neo.name == "Taille  " and slide ~= -1 then
                taillesourcilss = slide - 1
                TriggerServerEvent('skinchanger:changetarget', target, 'eyebrows_2', taillesourcilss)
            elseif Neo.name == "Teinture Sourcil" and slide ~= -1 then
                couleursourcil = slide - 1
                TriggerServerEvent('skinchanger:changetarget', target, 'eyebrows_3', couleursourcil)
            elseif Neo.name == "Maquillage " and slide ~= -1 then
                maquillage = slide - 1
                TriggerServerEvent('skinchanger:changetarget', target, 'makeup_1', maquillage)
            elseif Neo.name == "Taille " and slide ~= -1 then
                tmaquillage = slide - 1
                TriggerServerEvent('skinchanger:changetarget', target, 'makeup_2', tmaquillage)
            elseif Neo.name == "Couleur" and slide ~= -1 then
                cmaquillage = slide - 1
                TriggerServerEvent('skinchanger:changetarget', target, 'makeup_3', cmaquillage)
            end
        end
    },

    Menu = {
        ["Coiffeurs"] = {
            b = {
                {name = "Cheveux", ask = ">", askX = true, id = 33},
                {name = "Barbe", ask = ">", askX = true, id = 33},
                {name = "Sourcils", ask = ">", askX = true, id = 33},
                {name = "Maquillage", ask = ">", askX = true, id = 33},
                {name = "Selection", slidemax = {"~g~Valider", "~r~Annuler"}, askX = true, id = 33},
            }
        },
        ["Cheveux"] = {
            b = {
                {name = "Coupes", slidemax = 102},
                {name = "Teinture", slidemax = 63},
                {name = "Teinture 2", slidemax = 63},
            }
        },
        ["Barbe"] = {
            b = {
                {name = "Barbes", slidemax = 28},
                {name = "Taille", slidemax = 10},
                {name = "Teinture Barbe", slidemax = 63},
            }
        },
        ["Sourcils"] = {
            b = {
                {name = "Sourcil", slidemax = 28},
                {name = "Taille  ", slidemax = 10},
                {name = "Teinture Sourcil", slidemax = 63},
            }
        },
        ["Maquillage"] = {
            b = {
                {name = "Maquillage ", slidemax = 71},
                {name = "Taille ", slidemax = 10},
                {name = "Couleur", slidemax = 63},
            }
        },
    }
}

function opengarage()
    --setheader('Garage')
    garage.Menu["Action"].b = {}
   
    for k, v in pairs(Config.cars) do
        table.insert(garage.Menu["Action"].b, {name = v.label, value = v.name})
    end
    table.insert(garage.Menu["Action"].b, {name = "Ranger le vehicule"})

    CreateMenu(garage)
end 


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
        time = 200
            if PlayerData.job.name == "barber" then 
                time = 350
      
            local plyCoords = GetEntityCoords(GetPlayerPed(-1), false)
            local distcoiffure = Vdist(plyCoords, 138.20, -1708.28, 29.30-0.93)
            local distmenu = Vdist(plyCoords, 134.69, -1707.85, 29.30-0.93)
            local diststock = Vdist(plyCoords, 141.44, -1705.89, 29.30-0.93)
            local distgarage = Vdist(plyCoords, 130.42, -1712.11, 29.22-0.93)

      
                if distcoiffure < 20 or distmenu < 20 or diststock < 20 then
                    time = 0 
                    DrawMarker(25, 138.20, -1708.28, 29.30-0.93, 0.0, 0.0, 0.0, 0.0,0.0,0.0, 0.8, 0.8, 0.2, 40, 180, 99, 120, false, false, false, false) 
                    DrawMarker(25, 134.69, -1707.85, 29.30-0.93, 0.0, 0.0, 0.0, 0.0,0.0,0.0, 0.8, 0.8, 0.2, 52, 152, 219, 120, false, false, false, false) 
                    DrawMarker(25, 141.44, -1705.89, 29.30-0.93, 0.0, 0.0, 0.0, 0.0,0.0,0.0, 0.8, 0.8, 0.2, 52, 152, 219, 120, false, false, false, false) 
                    --DrawMarker(25, 130.42, -1712.11, 29.22-0.93, 0.0, 0.0, 0.0, 0.0,0.0,0.0, 0.8, 0.8, 0.2, 52, 152, 219, 120, false, false, false, false) 
                end

       
                if distcoiffure <= 1 then
                    ESX.ShowHelpNotification("Appuyez sur ~INPUT_TALK~ pour accéder au ~g~Coiffeur~w~.")
                    if IsControlJustPressed(1,51) then
                        TriggerEvent('skinchanger:getSkin', function(skin)
                            local closestPlayer, closestDistance = ESX.Game.GetClosestPlayer()
                            if closestDistance ~= -1 and closestDistance <= 3 then
                                TriggerServerEvent('sitchairtarget', GetPlayerServerId(closestPlayer))
                                DoScreenFadeIn(2200) DoScreenFadeOut(1250) 
                                Citizen.Wait(2200)
                                CreateMenu(BarberNoPed)
                                SetEntityCoords(PlayerPedId(), 138.12, -1708.47, 28.30)
                                SetEntityHeading(PlayerPedId(), 210.8189697)
                                DoScreenFadeIn(2000) DoScreenFadeOut(1550)  DoScreenFadeIn(1000)     
                                target = GetPlayerServerId(closestPlayer)
                            else
                                ESX.ShowNotification('~r~Personne a proximité')
                            end
                        end)
                    end
                elseif distmenu <= 1 then 
                    ESX.ShowHelpNotification("Appuyez sur ~INPUT_TALK~ pour accéder au ~b~menu")
                    if IsControlJustPressed(1,51) then
                        --setheader("Cointoire")
                        if PlayerData.job.grade_name == "boss" then 
                            table.remove(menumain.Menu["Action"].b, 3)
                            table.insert(menumain.Menu["Action"].b, {name = "Action patron", ask = ">", askX = true})
                        end 
                        CreateMenu(menumain)
                    end
                elseif diststock <= 1 then 
                    ESX.ShowHelpNotification("Appuyez sur ~INPUT_TALK~ pour accéder au ~b~stock")
                    if IsControlJustPressed(1,51) then
                        CreateMenu(stock)
                    end
                elseif distgarage <= 1.5 then 
                    ESX.ShowHelpNotification("Appuyez sur ~INPUT_TALK~ pour accéder au ~b~garage")
                    if IsControlJustPressed(1,51) then
                        
                        opengarage()
                    end
                end
        end
        Citizen.Wait(time)
    end
end)

RegisterCommand('sit', function()
    SetEntityCoords(PlayerPedId(), 137.77-0.03, -1710.74-0.58, 28.30-0.20)
    SetEntityHeading(PlayerPedId(), 236.5154)
end)

RegisterNetEvent('sitchairtargetcl') 
AddEventHandler('sitchairtargetcl', function(source)
    DoScreenFadeIn(2000) DoScreenFadeOut(1250) 
    Citizen.Wait(2000)
    SetEntityCoords(PlayerPedId(), 138.15, -1709.05, 28.10)
    SetEntityHeading(PlayerPedId(), 236.5154)
    DoScreenFadeIn(2000) DoScreenFadeOut(1550)  DoScreenFadeIn(1000)
    FreezeEntityPosition(GetPlayerPed(-1), true)
    TaskStartScenarioInPlace(GetPlayerPed(-1), 'PROP_HUMAN_SEAT_CHAIR_MP_PLAYER', 0, false)
end)



RegisterNetEvent('skinchanger:changetargetcl') 
AddEventHandler('skinchanger:changetargetcl', function(type, var)
    TriggerEvent('skinchanger:change', type, var)
end)

RegisterNetEvent('annulertargetcl') 
AddEventHandler('annulertargetcl', function(source)
    FreezeEntityPosition(GetPlayerPed(-1), false)
    ClearPedTasksImmediately(GetPlayerPed(-1))
    ClearPedSecondaryTask(GetPlayerPed(-1))
    ESX.TriggerServerCallback('esx_skin:getPlayerSkin', function(skin)
        TriggerEvent('skinchanger:loadSkin', skin)
    end)
end)

RegisterNetEvent('saveskintargetcl') 
AddEventHandler('saveskintargetcl', function(source)
    FreezeEntityPosition(GetPlayerPed(-1), false)
    ClearPedTasksImmediately(GetPlayerPed(-1))
    ClearPedSecondaryTask(GetPlayerPed(-1))
    TriggerEvent('skinchanger:getSkin', function(skin)
        TriggerServerEvent('esx_skin:save', skin)
    end)
end)


function startAnims(lib, anim)
	local lib, anim = lib,anim
	ESX.Streaming.RequestAnimDict(lib)
	TaskPlayAnim(GetPlayerPed(-1), lib, anim, 8.0, 8.0, -1, 1, 1, 0, 0, 0)
end