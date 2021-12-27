Clothes = Clothes or {}

ESX = nil
Citizen.CreateThread(function()
    while ESX == nil do
        TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
    end
end)

function TaskPlayAnimToPlayer(a,b,c,d,e)if type(a)~="table"then a={a}end;d,c=d or GetPlayerPed(-1),c and tonumber(c)or false;if not a or not a[1]or string.len(a[1])<1 then return end;if IsEntityPlayingAnim(d,a[1],a[2],3)or IsPedActiveInScenario(d)then ClearPedTasks(d)return end;Citizen.CreateThread(function()TaskForceAnimPlayer(a,c,{ped=d,time=b,pos=e})end)end;local f={"WORLD_HUMAN_MUSICIAN","WORLD_HUMAN_CLIPBOARD"}local g={["WORLD_HUMAN_BUM_WASH"]={"amb@world_human_bum_wash@male@high@idle_a","idle_a"},["WORLD_HUMAN_SIT_UPS"]={"amb@world_human_sit_ups@male@idle_a","idle_a"},["WORLD_HUMAN_PUSH_UPS"]={"amb@world_human_push_ups@male@base","base"},["WORLD_HUMAN_BUM_FREEWAY"]={"amb@world_human_bum_freeway@male@base","base"},["WORLD_HUMAN_CLIPBOARD"]={"amb@world_human_clipboard@male@base","base"},["WORLD_HUMAN_VEHICLE_MECHANIC"]={"amb@world_human_vehicle_mechanic@male@base","base"}}function TaskForceAnimPlayer(a,c,h)c,h=c and tonumber(c)or false,h or{}local d,b,i,j,k,l=h.ped or GetPlayerPed(-1),h.time,h.clearTasks,h.pos,h.ang;if IsPedInAnyVehicle(d)and(not c or c<40)then return end;if not i then ClearPedTasks(d)end;if not a[2]and g[a[1]]and GetEntityModel(d)==-1667301416 then a=g[a[1]]end;if a[2]and not HasAnimDictLoaded(a[1])then if not DoesAnimDictExist(a[1])then return end;RequestAnimDict(a[1])while not HasAnimDictLoaded(a[1])do Citizen.Wait(10)end end;if not a[2]then ClearAreaOfObjects(GetEntityCoords(d),1.0)TaskStartScenarioInPlace(d,a[1],-1,not TableHasValue(f,a[1]))else if not j then TaskPlayAnim(d,a[1],a[2],8.0,-8.0,-1,c or 44,1,0,0,0,0)else TaskPlayAnimAdvanced(d,a[1],a[2],j.x,j.y,j.z,k.x,k.y,k.z,8.0,-8.0,-1,1,1,0,0,0)end end;if b and type(b)=="number"then Citizen.Wait(b)ClearPedTasks(d)end;if not h.dict then RemoveAnimDict(a[1])end end;function TableHasValue(m,n,o)if not m or not n or type(m)~="table"then return end;for p,q in pairs(m)do if o and q[o]==n or q==n then return true,p end end end

Clothes.ListType = {
    {type = "tshirt", id = "tshirt_1", id2 = "tshirt_2", anim = {'clothingtie', 'try_tie_neutral_d'}},
    {type = "torso", id = "torso_1", id2 = "torso_2", anim = {'clothingtie', 'try_tie_neutral_d'}},
    {type = "arms", id = "arms", id2 = "arms_2", anim = {'clothingtie', 'try_tie_neutral_d'}},
    {type = "pants", id = "pants_1", id2 = "pants_2", anim = {'clothingtrousers', 'try_trousers_neutral_c'}},
    {type = "shoes", id = "shoes_1", id2 = "shoes_2", anim = {'clothingshoes', 'try_shoes_neutral_d'}},
    {type = "mask", id = "mask_1", id2 = "mask_2", anim = {'misscommon@van_put_on_masks', 'put_on_mask_ps'}},
    {type = "bproof", id = "bproof_1", id2 = "bproof_2", anim = {'clothingtie', 'try_tie_neutral_b'}},
    {type = "chain", id = "chain_1", id2 = "chain_2", anim = {'clothingtie', 'try_tie_neutral_d'}},
    {type = "helmet", id = "helmet_1", id2 = "helmet_2", anim = {'misscommon@van_put_on_masks', 'put_on_mask_ps'}},
    {type = "glasses", id = "glasses_1", id2 = "glasses_2", anim = {'clothingspecs', 'try_glasses_positive_a'}},
    {type = "watches", id = "watches_1", id2 = "watches_2", anim = {'clothingtie', 'try_tie_neutral_d'}},
    {type = "bracelets", id = "bracelets_1", id2 = "bracelets_2", anim = {'clothingtie', 'try_tie_neutral_d'}},
    {type = "bags", id = "bags_1", id2 = "bags_2", anim = {'clothingshirt', 'try_shirt_negative_a'}},
}

-- RegisterCommand("clothes", function()
--     TriggerServerEvent("cClothes:saveClothes", "torso", 250, 0, "T-Shirt #56")
-- end)


RegisterKeyMapping("getclothes", "Ouvrir le menu de vos vêtements", "keyboard", "F9")


function IsPedPeds() -- Si le joueur est un Homme
    local pPed = PlayerPedId()
    if IsPedModel(pPed, GetHashKey("mp_m_freemode_01")) then 
        return true 
    elseif IsPedModel(pPed, GetHashKey("mp_f_freemode_01")) then 
        return false 
    else
        return "ped"
    end
end

RegisterCommand("getclothes", function()
    ESX.TriggerServerCallback("cClothes:getPlayerClothes", function(clothes)
        if json.encode(clothes) ~= "[]" and clothes ~= nil then 
            local Menu = {
                Base = { Title = "Clothes", Header = {"shopui_title_midfashion", "shopui_title_midfashion"} },
                Data = { currentMenu = "Catégories" },
                Events = {
                    onSelected = function(self, menuData, btnData, currentSlt, allButtons)
                        local slide = btnData.slidenum
                        local btn = btnData.name
            
                        if btnData.id and btnData.type ~= "tenue" then 
                            for k,v in pairs(Clothes.ListType) do
                                if v.type == btnData.type then
                                    if not btnData.slidename then
                                        TaskForceAnimPlayer(v.anim, 49, {time = 2000 })
                                        if IsPedPeds() ~= "ped" then 
                                            if not IsPedPeds() then 
                                                TriggerEvent("skinchanger:change", v.id, tonumber(btnData.id2))
                                                TriggerEvent('skinchanger:change', v.id2, tonumber(btnData.color))
                                            else
                                                TriggerEvent("skinchanger:change", v.id, tonumber(btnData.id))
                                                TriggerEvent('skinchanger:change', v.id2, tonumber(btnData.color))
                                            end
                                        else
                                            ESX.ShowNotification("~r~Vous ne pouvez pas en tant que peds.")
                                        end
                                    elseif btnData.slidename then 
                                        if btnData.slidename == "Utiliser" then 
                                            TaskForceAnimPlayer(v.anim, 49, {time = 2000 })
                                            TriggerEvent("skinchanger:change", v.id, tonumber(btnData.id))
                                            TriggerEvent('skinchanger:change', v.id2, tonumber(btnData.color))
                                        elseif btnData.slidename == "Supprimer" then 
                                            TriggerServerEvent("cClothes:deleteClothes", btnData.k, btnData.name)
                                            if IsPedPeds() ~= "ped" then 
                                                if not IsPedPeds() then 
                                                    TriggerEvent("skinchanger:change", v.id, tonumber(btnData.id2))
                                                    TriggerEvent('skinchanger:change', v.id2, tonumber(btnData.color))
                                                else
                                                    TriggerEvent("skinchanger:change", v.id, tonumber(btnData.id2))
                                                    TriggerEvent('skinchanger:change', v.id2, tonumber(btnData.color))
                                                end
                                            else
                                                ESX.ShowNotification("~r~Vous ne pouvez pas en tant que peds.")
                                            end
                                            CloseMenu(true)
                                            Wait(50)
                                            ExecuteCommand("getclothes")
                                        elseif btnData.slidename == "Renommer" then 
                                            AskEntry(function(msg)
                                                if msg and msg ~= "" then 
                                                    TriggerServerEvent("cClothes:renameClothes", btnData.k, btnData.name, msg)
                                                    CloseMenu(true)
                                                    Wait(50)
                                                    ExecuteCommand("getclothes")
                                                else 
                                                    ESX.ShowNotification("~r~Veuillez entrer un nom valide.")
                                                end
                                            end, "Entrez le nom que vous souhaitez.")
                                        elseif btnData.slidename == "Donner" then
                                            local closestPlayer, closestDistance = ESX.Game.GetClosestPlayer()
                                            if closestPlayer and closestPlayer ~= -1 and closestDistance <= 2.5 then 
                                                TaskForceAnimPlayer({"mp_common", "givetake2_a"}, 49, {time = 2000 })
                                                TriggerServerEvent("cClothes:giveClothes", btnData.type, btnData.id, btnData.color, btnData.name, GetPlayerServerId(closestPlayer), btnData.k)
                                                if IsPedPeds() ~= "ped" then 
                                                    if not IsPedPeds() then 
                                                        TriggerEvent("skinchanger:change", v.id, tonumber(btnData.id2))
                                                        TriggerEvent('skinchanger:change', v.id2, tonumber(btnData.color))
                                                    else
                                                        TriggerEvent("skinchanger:change", v.id, tonumber(btnData.id2))
                                                        TriggerEvent('skinchanger:change', v.id2, tonumber(btnData.color))
                                                    end
                                                else
                                                    ESX.ShowNotification("~r~Vous ne pouvez pas en tant que peds.")
                                                end
                                                CloseMenu(true)
                                                Wait(50)
                                                ExecuteCommand("getclothes")
                                            else
                                                ESX.ShowNotification("~r~Aucun joueur à proximité.")
                                            end
                                        end
                                    end
                                end
                            end
                        elseif btnData.type == "tenue" then 
                            if btnData.slidename then 
                                if btnData.slidename == "Utiliser" then 
                                    TriggerEvent('skinchanger:getSkin', function(skin)
                                        TriggerEvent('skinchanger:loadClothes', skin, btnData.id)
                                        Clothes:SavePlayerSkin()
                                        ESX.ShowNotification("Vous avez enfilé la tenue ~b~" .. btn .."~s~.")
                                    end)
                                elseif btnData.slidename == "Supprimer" then 
                                    TriggerServerEvent("cClothes:deleteClothes", btnData.k, btnData.name)
                                    CloseMenu(true)
                                    Wait(50)
                                    ExecuteCommand("getclothes")
                                elseif btnData.slidename == "Renommer" then 
                                    AskEntry(function(msg)
                                        if msg and msg ~= "" then 
                                            TriggerServerEvent("cClothes:renameClothes", btnData.k, btnData.name, msg)
                                            CloseMenu(true)
                                            Wait(50)
                                            ExecuteCommand("getclothes")
                                        else 
                                            ESX.ShowNotification("~r~Veuillez entrer un nom valide.")
                                        end
                                    end, "Entrez le nom que vous souhaitez.")
                                elseif btnData.slidename == "Donner" then 
                                    local closestPlayer, closestDistance = ESX.Game.GetClosestPlayer()
                                    if closestPlayer and closestPlayer ~= -1 and closestDistance <= 2.5 then 
                                        TaskForceAnimPlayer({"mp_common", "givetake2_a"}, 49, {time = 2000 })
                                        TriggerServerEvent("cClothes:giveClothes", btnData.type, btnData.id, btnData.color, btnData.name, GetPlayerServerId(closestPlayer), btnData.k)
                                        CloseMenu(true)
                                        Wait(50)
                                        ExecuteCommand("getclothes")
                                    else
                                        ESX.ShowNotification("~r~Aucun joueur à proximité.")
                                    end
                                end
                            else 
                                ESX.ShowNotification("~r~Erreur de slide.")
                            end
                        end
                    end,
                },
                Menu = {
                    ["Catégories"] = {
                        b = {
                            { name = "Torse", ask = ">", askX = true },
                            { name = "T-Shirt", ask = ">", askX = true },
                            { name = "Bras", ask = ">", askX = true },
                            { name = "Pantalons", ask = ">", askX = true },
                            { name = "Chaussures", ask = ">", askX = true },
                            { name = "Masque", ask = ">", askX = true },
                            { name = "Gillet par balles", ask = ">", askX = true },
                            { name = "Chaine", ask = ">", askX = true },
                            { name = "Chapeau", ask = ">", askX = true },
                            { name = "Lunettes", ask = ">", askX = true },
                            { name = "Montres", ask = ">", askX = true },
                            { name = "Bracelets", ask = ">", askX = true },
                            { name = "Sacs", ask = ">", askX = true },
                            { name = "Tenue", ask = ">", askX = true },
                        }
                    },
                    ["t-shirt"] = {
                        b = function()
                            local table = {}
                            table[#table+1] = {name = "Retirer votre haut", ask = ">", askX = true, id = 15, id2 = 15, type = "tshirt", color = 0}
                            for k,v in pairs(clothes) do 
                                if v.type == "tshirt" then 
                                    table[#table+1] = {name = v.label, id = v.id, type = v.type, color = v.color, id2 = 15, slidemax = {"Utiliser", "Supprimer", "Donner", "Renommer"}, k = k}
                                end
                            end
                            return table
                        end,
                    },
                    ["torse"] = {
                        b = function()
                            local table = {}
                            table[#table+1] = {name = "Retirer votre haut", ask = ">", askX = true, id = 15, id2 = 15, type = "torso", color = 0}
                            for k,v in pairs(clothes) do 
                                if v.type == "torso" then 
                                    table[#table+1] = {name = v.label, id = v.id, type = v.type, color = v.color, id2 = 15, slidemax = {"Utiliser", "Supprimer", "Donner", "Renommer"}, k = k}
                                end
                            end
                            return table
                        end,
                    },
                    ["bras"] = {
                        b = function()
                            local table = {}
                            table[#table+1] = {name = "Mettre votre haut", ask = ">", askX = true, id = 15, id2 = 15, type = "arms", color = 0}
                            for k,v in pairs(clothes) do 
                                if v.type == "arms" then 
                                    table[#table+1] = {name = v.label, id = v.id, type = v.type, color = v.color, id2 = 15, slidemax = {"Utiliser", "Supprimer", "Donner", "Renommer"}, k = k}
                                end
                            end
                            return table
                        end,
                    },
                    ["pantalons"] = {
                        b = function()
                            local table = {}
                            table[#table+1] = {name = "Retirer votre bas", ask = ">", askX = true, id = 18, id2 = 14, type = "pants", color = 0}
                            for k,v in pairs(clothes) do 
                                if v.type == "pants" then 
                                    table[#table+1] = {name = v.label, id = v.id, type = v.type, color = v.color, id2 = 15, slidemax = {"Utiliser", "Supprimer", "Donner", "Renommer"}, k = k}
                                end
                            end
                            return table
                        end,
                    },
                    ["chaussures"] = {
                        b = function()
                            local table = {}
                            table[#table+1] = {name = "Retirer vos chaussures", ask = ">", askX = true, id = 34, id2 = 34, type = "shoes", color = 0}
                            for k,v in pairs(clothes) do 
                                if v.type == "shoes" then 
                                    table[#table+1] = {name = v.label, id = v.id, type = v.type, color = v.color, id2 = 15, slidemax = {"Utiliser", "Supprimer", "Donner", "Renommer"}, k = k}
                                end
                            end
                            return table
                        end,
                    },
                    ["masque"] = {
                        b = function()
                            local table = {}
                            table[#table+1] = {name = "Retirer votre masque", ask = ">", askX = true, id = 0, id2 = 0, type = "mask", color = 0}
                            for k,v in pairs(clothes) do 
                                if v.type == "mask" then 
                                    table[#table+1] = {name = v.label, id = v.id, type = v.type, color = v.color, id2 = 15, slidemax = {"Utiliser", "Supprimer", "Donner", "Renommer"}, k = k}
                                end
                            end
                            return table
                        end,
                    },
                    ["gillet par balles"] = {
                        b = function()
                            local table = {}
                            table[#table+1] = {name = "Retirer votre gillet par balles", ask = ">", askX = true, id = 0, id2 = 0, type = "bproof", color = 0}
                            for k,v in pairs(clothes) do 
                                if v.type == "bproof" then 
                                    table[#table+1] = {name = v.label, id = v.id, type = v.type, color = v.color, id2 = 15, slidemax = {"Utiliser", "Supprimer", "Donner", "Renommer"}, k = k}
                                end
                            end
                            return table
                        end,
                    },
                    ["chaine"] = {
                        b = function()
                            local table = {}
                            table[#table+1] = {name = "Retirer votre chaine", ask = ">", askX = true, id = 0, id2 = 0, type = "chain", color = 0}
                            for k,v in pairs(clothes) do 
                                if v.type == "chain" then 
                                    table[#table+1] = {name = v.label, id = v.id, type = v.type, color = v.color, id2 = 15, slidemax = {"Utiliser", "Supprimer", "Donner", "Renommer"}, k = k}
                                end
                            end
                            return table
                        end,
                    },
                    ["chapeau"] = {
                        b = function()
                            local table = {}
                            table[#table+1] = {name = "Retirer votre chapeau", ask = ">", askX = true, id = -1, id2 = -1, type = "helmet", color = 0}
                            for k,v in pairs(clothes) do 
                                if v.type == "helmet" then 
                                    table[#table+1] = {name = v.label, id = v.id, type = v.type, color = v.color, id2 = 15, slidemax = {"Utiliser", "Supprimer", "Donner", "Renommer"}, k = k}
                                end
                            end
                            return table
                        end,
                    },
                    ["lunettes"] = {
                        b = function()
                            local table = {}
                            table[#table+1] = {name = "Retirer vos lunettes", ask = ">", askX = true, id = 0, id2 = 0, type = "glasses", color = 0}
                            for k,v in pairs(clothes) do 
                                if v.type == "glasses" then 
                                    table[#table+1] = {name = v.label, id = v.id, type = v.type, color = v.color, id2 = 15, slidemax = {"Utiliser", "Supprimer", "Donner", "Renommer"}, k = k}
                                end
                            end
                            return table
                        end,
                    },
                    ["montres"] = {
                        b = function()
                            local table = {}
                            table[#table+1] = {name = "Retirer votre montre", ask = ">", askX = true, id = -1, id2 = -1, type = "watches", color = 0}
                            for k,v in pairs(clothes) do 
                                if v.type == "watches" then 
                                    table[#table+1] = {name = v.label, id = v.id, type = v.type, color = v.color, id2 = 15, slidemax = {"Utiliser", "Supprimer", "Donner", "Renommer"}, k = k}
                                end
                            end
                            return table
                        end,
                    },
                    ["bracelets"] = {
                        b = function()
                            local table = {}
                            table[#table+1] = {name = "Retirer votre bracelets", ask = ">", askX = true, id = -1, id2 = -1, type = "bracelets", color = 0}
                            for k,v in pairs(clothes) do 
                                if v.type == "bracelets" then 
                                    table[#table+1] = {name = v.label, id = v.id, type = v.type, color = v.color, id2 = 15, slidemax = {"Utiliser", "Supprimer", "Donner", "Renommer"}, k = k}
                                end
                            end
                            return table
                        end,
                    },
                    ["sacs"] = {
                        b = function()
                            local table = {}
                            table[#table+1] = {name = "Retirer votre sac", ask = ">", askX = true, id = 0, id2 = 0, type = "bags", color = 0}
                            for k,v in pairs(clothes) do 
                                if v.type == "bags" then 
                                    table[#table+1] = {name = v.label, id = v.id, type = v.type, color = v.color, id2 = 15, slidemax = {"Utiliser", "Supprimer", "Donner", "Renommer"}, k = k}
                                end
                            end
                            return table
                        end,
                    },
                    ["tenue"] = {
                        b = function()
                            local table = {}
                            for k,v in pairs(clothes) do 
                                if v.type == "tenue" then 
                                    table[#table+1] = {name = v.label, id = v.id, type = v.type, color = v.color, id2 = 15, slidemax = {"Utiliser", "Supprimer", "Donner", "Renommer"}, k = k}
                                end
                            end
                            return table
                        end,
                    }
                }
            }

            CreateMenu(Menu)
        else
            ESX.ShowNotification("~r~Vous n'avez aucun vêtements.")
        end
    end, GetPlayerServerId(PlayerId()))
end)