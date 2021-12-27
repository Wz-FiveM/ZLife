Clothes = Clothes or {}

ESX = nil
Citizen.CreateThread(function()
	while ESX == nil do
		TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
		Citizen.Wait(0)
	end

	while ESX.GetPlayerData().job == nil do
		Citizen.Wait(100)
	end

	ESX.PlayerData = ESX.GetPlayerData()
end)

RegisterNetEvent('esx:playerLoaded')
AddEventHandler('esx:playerLoaded', function(xPlayer)
	ESX.PlayerData = xPlayer
end)

RegisterNetEvent('esx:setJob')
AddEventHandler('esx:setJob', function(job)
	ESX.PlayerData.job = job
end)

-- functions
function Clothes:SavePlayerSkin()
    TriggerEvent('skinchanger:getSkin', function(skin)
        TriggerServerEvent('esx_skin:save', skin)
    end)
end 

Clothes.Cam = nil
function Clothes:CloseCamera()
    local pPed = PlayerPedId()
    ClearPedTasks(pPed)
    TriggerEvent('skinchanger:modelLoaded')
    ESX.TriggerServerCallback('esx_skin:getPlayerSkin', function(skin)
        TriggerEvent('skinchanger:loadSkin', skin)
    end)
    DestroyCam(Clothes.Cam)
    RenderScriptCams(false, 0, 1, false, false)

    for _, i in pairs(GetActivePlayers()) do
        NetworkConcealPlayer(i, false, false)
    end
end

function Clothes:OpenCamera()
    for k, v in pairs(GetActivePlayers()) do 
		if v ~= GetPlayerIndex() then 
			NetworkConcealPlayer(v, true, true) 
		end 
	end

    local pPed = PlayerPedId()
    Clothes.Cam = CreateCam("DEFAULT_SCRIPTED_CAMERA", true)
    SetCamRot(Clothes.Cam, 0.0, 0.0, 270.0, true)
    local pCoords, pHeading = GetEntityCoords(pPed), GetEntityHeading(pPed)
    local cCoords = pHeading * math.pi / 180.0
    SetCamCoord(Clothes.Cam, pCoords.x - 1.5 * math.sin(cCoords), pCoords.y + 1.5 * math.cos(cCoords), pCoords.z + .5)
    SetCamRot(Clothes.Cam, .0, .0, 120.0, 2)
    PointCamAtEntity(Clothes.Cam, pPed, .0, .0, .0, true)
    SetCamActive(Clothes.Cam, true)
    RenderScriptCams(1, 0, 500, 1, 0)
end
Clothes.ControlDisable = {24, 27, 178, 177, 189, 190, 187, 188, 202, 239, 240, 201, 172, 173, 174, 175}
function OnRenderCam()
    DisableAllControlActions(0)
    for k, v in pairs(Clothes.ControlDisable) do
        EnableControlAction(0, v, true)
    end
    local Control1, Control2 = IsDisabledControlPressed(1, 44), IsDisabledControlPressed(1, 51)
    if Control1 or Control2 then
        local pPed = PlayerPedId()
        SetEntityHeading(pPed, Control1 and GetEntityHeading(pPed) - 2.0 or Control2 and GetEntityHeading(pPed) + 2.0)

        for k, v in pairs(GetActivePlayers()) do 
            if v ~= GetPlayerIndex() then 
                NetworkConcealPlayer(v, true, true) 
            end 
        end
    end
end

Clothes.maxVals = nil

Clothes.Menu = {
    Base = { Title = "", Header = {"shopui_title_midfashion", "shopui_title_midfashion"} },
    Data = { currentMenu = "Magasin de vêtements" },
    Events = {
        onOpened = function()
            TriggerEvent('skinchanger:getData', function(components, maxVals2)
                Clothes.maxVals = maxVals2
            end)

            Clothes:OpenCamera()
        end,
        onExited = function()
            ESX.TriggerServerCallback('esx_skin:getPlayerSkin', function(skin, jobSkin)
                TriggerEvent('skinchanger:loadSkin', skin)
            end)    
            
            Clothes:CloseCamera()
        end,
        onRender = OnRenderCam,
        onBack = function()
            ESX.TriggerServerCallback('esx_skin:getPlayerSkin', function(skin, jobSkin)
                TriggerEvent('skinchanger:loadSkin', skin)
            end)        
        end,
        onSelected = function(self, menuData, btnData, currentSlt, allButtons)
            local slide = btnData.slidenum
            local btn = btnData.name

            if not btnData.dontSave then
                ESX.TriggerServerCallback("cClothes:PayMoney", function(payMoney) -- Todo
                    if payMoney then
                        Clothes:SavePlayerSkin()
                        ESX.ShowNotification("Vous avez acheté ~b~x1 "..btnData.name.."~s~.")
                        TriggerServerEvent("cClothes:saveClothes", btnData.clothe, btnData.number or currentSlt-1, (btnData.slidenum - 1) or 0, btnData.name)   
                    else
                        ESX.ShowNotification("~r~Vous n'avez pas assez d'argent.")
                        ESX.TriggerServerCallback('esx_skin:getPlayerSkin', function(skin, jobSkin)
                            TriggerEvent('skinchanger:loadSkin', skin)
                        end)        
                    end    
                end, 20)
            end
            if btn == "~g~Sauvegarder ma tenue" then
                AskEntry(function(msg)
                    if msg then
                        TriggerEvent('skinchanger:getSkin', function(skin) 
                            TriggerServerEvent("cClothes:saveClothes", "tenue", skin, 0, msg)  
                            ESX.ShowNotification("Vous venez de sauvegarder votre tenue (~b~"..msg.."~s~).")
                        end)          
                    end
                end, "Nom de la tenue")

            elseif btn == "~g~Sauvegarder plusieurs exemplaires de ma tenue" then 
                AskEntry(function(name)
                    if name then
                        AskEntry(function(count)
                            local count = tonumber(count)
                            if count then
                                TriggerEvent('skinchanger:getSkin', function(skin) 
                                    for i = 1, count, 1 do 
                                        TriggerServerEvent("cClothes:saveClothes", "tenue", skin, 0, name)  
                                        Wait(100)
                                    end
                                    ESX.ShowNotification("Vous venez de sauvegarder votre tenue (~b~x"..count.." "..name.."~s~).")
                                end)          
                            end
                        end, "Nombre de tenues")
                    end
                end, "Nom de la tenue")
            end
        end,
        onButtonSelected = function(currentMenu, currentBtn, menuData, btnData, self)
            local btn = btnData.name
        
            if btnData.clothe then
                if btnData.clothe == "arms" then 
                    TriggerEvent("skinchanger:change", btnData.clothe, btnData.number or currentBtn - 1)
                elseif btnData.clothe == "torso" then
                    TriggerEvent("skinchanger:change", "tshirt_1", -1)
                    TriggerEvent("skinchanger:change", "tshirt_2", -1)
                end
                TriggerEvent("skinchanger:change", btnData.clothe .. "_1", btnData.number or currentBtn - 1)
                TriggerEvent("skinchanger:change", btnData.clothe .. "_2", 0)
            end
        end,
        onSlide = function(menuData, btnData, currentSlt, self)
            local currentMenu = menuData.currentMenu
            local slide = btnData.slidenum
            local btn = btnData.name
        
            if btnData.clothe then
                TriggerEvent("skinchanger:change", btnData.clothe .. "_2", slide - 1)
            end
        end,
    },
    Menu = {
        ["Magasin de vêtements"] = {
            b = {
                { name = "Vêtements", ask = ">", askX = true, dontSave = true},
                { name = "Accessoires", ask = ">", askX = true, dontSave = true},
                { name = "~g~Sauvegarder ma tenue", ask = ">", askX = true, dontSave = true },
                { name = "~g~Sauvegarder plusieurs exemplaires de ma tenue", ask = ">", askX = true, dontSave = true },
            }
        },
        ["vêtements"] = {
            b = {
                { name = "Hauts", ask = ">", askX = true, dontSave = true },
                { name = "Sous-hauts", ask = ">", askX = true, dontSave = true },
                { name = "Bras", ask = ">", askX = true, dontSave = true },
                { name = "Bas", ask = ">", askX = true, dontSave = true },
                { name = "Chaussures", ask = ">", askX = true, dontSave = true },
                { name = "Calques", ask = ">", askX = true, dontSave = true },
            }
        },
        ["accessoires"] = {
            b = {
                { name = "Chapeaux", ask = ">", askX = true, dontSave = true},
                { name = "Lunettes", ask = ">", askX = true, dontSave = true},
                { name = "Sacs", ask = ">", askX = true, dontSave = true },
                { name = "Chaines", ask = ">", askX = true, dontSave = true },
                { name = "Oreilles", ask = ">", askX = true, dontSave = true },
                { name = "Montres", ask = ">", askX = true, dontSave = true },
                { name = "Bracelets", ask = ">", askX = true, dontSave = true },
                { name = "Autres", ask = ">", askX = true, dontSave = true },
            }
        },
        ["autres"] = {
            b = function()
                local tblHauts = {}

                for i = 0, Clothes.maxVals.bproof_1, 1 do
                    if Clothes.Blacklist.bproof_1[i] then
                        tblHauts[#tblHauts+1] = { name = "Autres #" .. i, slidemax = GetNumberOfPedTextureVariations(PlayerPedId(), 9, i-1) - 1, number = i - 1, clothe = "bproof"}
                    end
                end

                return tblHauts
            end,
        },
        ["oreilles"] = {
            b = function()
                local tblHauts = {}

                for i = 0, Clothes.maxVals.ears_1, 1 do
                    if not Clothes.Blacklist.ears_1[i] then
                        tblHauts[#tblHauts+1] = { name = "Oreille #" .. i, slidemax = 5, number = i - 1, clothe = "ears"}
                    end
                end

                return tblHauts
            end,
        },
        ["calques"] = {
            b = function()
                local tblHauts = {}

                for i = 0, Clothes.maxVals.decals_1, 1 do
                    if ESX.PlayerData.job ~= "police" and ESX.PlayerData.job ~= "ambulance" then 
                        if IsPedPeds(PlayerPedId()) then 
                            if not Clothes.Blacklist.decals_1.m[i] then
                                tblHauts[#tblHauts+1] = { name = "Calques #" .. i, number = i, slidemax = 15, clothe = "decals"}
                            end
                        else
                            if not Clothes.Blacklist.decals_1.f[i] then
                                tblHauts[#tblHauts+1] = { name = "Calques #" .. i, number = i, slidemax = 15, clothe = "decals"}
                            end
                        end
                    else
                        tblHauts[#tblHauts+1] = { name = "Calques #" .. i, number = i, slidemax = 15, clothe = "decals"}
                    end
                end

                return tblHauts
            end,
        },
        ["montres"] = {
            b = function()
                local tblHauts = {}

                for i = 0, Clothes.maxVals.watches_1, 1 do
                    if not Clothes.Blacklist.watches_1[i] then
                        tblHauts[#tblHauts+1] = { name = "Montre #" .. i, slidemax = 3, number = i - 1, clothe = "watches"}
                    end
                end

                return tblHauts
            end,
        },
        ["bracelets"] = {
            b = function()
                local tblHauts = {}

                for i = 0, Clothes.maxVals.bracelets_1, 1 do
                    if not Clothes.Blacklist.bracelets_1[i] then
                        tblHauts[#tblHauts+1] = { name = "Bracelet #" .. i, slidemax = 3, clothe = "bracelets"}
                    end
                end

                return tblHauts
            end,
        },
        ["hauts"] = {
            b = function()
                local tblHauts = {}

                for i = 0, Clothes.maxVals.torso_1, 1 do
                    if ESX.PlayerData.job ~= "police" and ESX.PlayerData.job ~= "ambulance" then 
                        if IsPedPeds(PlayerPedId()) then 
                            if not Clothes.Blacklist.torso_1.m[i] then
                                tblHauts[#tblHauts+1] = { name = "Haut #" .. i, number = i, slidemax = GetNumberOfPedTextureVariations(PlayerPedId(), 11, i) - 1, clothe = "torso"}
                            end
                        else
                            if not Clothes.Blacklist.torso_1.f[i] then
                                tblHauts[#tblHauts+1] = { name = "Haut #" .. i, number = i, slidemax = GetNumberOfPedTextureVariations(PlayerPedId(), 11, i) - 1, clothe = "torso"}
                            end
                        end
                    else
                        tblHauts[#tblHauts+1] = { name = "Haut #" .. i, number = i, slidemax = GetNumberOfPedTextureVariations(PlayerPedId(), 11, i) - 1, clothe = "torso"}
                    end
                end

                return tblHauts
            end,
        },
        ["sous-hauts"] = {
            b = function()
                local tblHauts2 = {}

                for i = 0, Clothes.maxVals.tshirt_1, 1 do
                    if ESX.PlayerData.job ~= "police" and ESX.PlayerData.job ~= "ambulance" then 
                        if IsPedPeds(PlayerPedId()) then 
                            if not Clothes.Blacklist.tshirt_1.m[i] then
                                tblHauts2[#tblHauts2+1] = { name = "Sous-hauts #" .. i, number = i, slidemax = GetNumberOfPedTextureVariations(PlayerPedId(), 8, i) - 1, clothe = "tshirt"}
                            end
                        else
                            if not Clothes.Blacklist.tshirt_1.f[i] then
                                tblHauts2[#tblHauts2+1] = { name = "Sous-hauts #" .. i, number = i, slidemax = GetNumberOfPedTextureVariations(PlayerPedId(), 8, i) - 1, clothe = "tshirt"}
                            end
                        end
                    else
                        tblHauts2[#tblHauts2+1] = { name = "Sous-hauts #" .. i, number = i, slidemax = GetNumberOfPedTextureVariations(PlayerPedId(), 8, i) - 1, clothe = "tshirt"}
                    end
                end

                return tblHauts2
            end,
        },
        ["bras"] = {
            b = function()
                local tblBras = {}

                for i = 0, Clothes.maxVals.arms, 1 do
                    if not Clothes.Blacklist.arms[i] then
                        tblBras[#tblBras+1] = { name = "Bras #" .. i, slidemax = 10, clothe = "arms" }
                    end
                end

                return tblBras
            end,
        },
        ["bas"] = {
            b = function()
                local tblBas = {}

                for i = 0, Clothes.maxVals.pants_1, 1 do
                    if ESX.PlayerData.job ~= "police" and ESX.PlayerData.job ~= "ambulance" then 
                        if IsPedPeds(PlayerPedId()) then 
                            if not Clothes.Blacklist.pants_1.m[i] then
                                tblBas[#tblBas+1] = { name = "Bas #" .. i, number = i, slidemax = GetNumberOfPedTextureVariations(PlayerPedId(), 4, i) - 1, clothe = "pants" }
                            end
                        else
                            if not Clothes.Blacklist.pants_1.f[i] then
                                tblBas[#tblBas+1] = { name = "Bas #" .. i, number = i, slidemax = GetNumberOfPedTextureVariations(PlayerPedId(), 4, i) - 1, clothe = "pants" }
                            end
                        end
                    else
                        tblBas[#tblBas+1] = { name = "Bas #" .. i, number = i, slidemax = GetNumberOfPedTextureVariations(PlayerPedId(), 4, i) - 1, clothe = "pants" }
                    end
                end

                return tblBas
            end,
        },
        ["chaussures"] = {
            b = function()
                local tblShoes = {}

                for i = 0, Clothes.maxVals.shoes_1, 1 do
                    if not Clothes.Blacklist.shoes_1[i] then
                        tblShoes[#tblShoes+1] = { name = "Chaussures #" .. i, slidemax = GetNumberOfPedTextureVariations(PlayerPedId(), 6, i) - 1, clothe = "shoes" }
                    end
                end

                return tblShoes
            end,
        },
        ["chapeaux"]= {
            b = function()
                local tblHats = {}

                for i = 0, Clothes.maxVals.helmet_1, 1 do
                    if ESX.PlayerData.job ~= "police" and ESX.PlayerData.job ~= "ambulance" then 
                        if IsPedPeds(PlayerPedId()) then 
                            if not Clothes.Blacklist.helmet_1.m[i] then
                                tblHats[#tblHats+1] = { name = "Chapeau #" .. i, number = i, slidemax = GetNumberOfPedPropTextureVariations(PlayerPedId(), 0, i-1) - 1, number = i - 1, clothe = "helmet" }
                            end
                        else
                            if not Clothes.Blacklist.helmet_1.f[i] then
                                tblHats[#tblHats+1] = { name = "Chapeau #" .. i, number = i, slidemax = GetNumberOfPedPropTextureVariations(PlayerPedId(), 0, i-1) - 1, number = i - 1, clothe = "helmet" }
                            end
                        end
                    else
                        tblHats[#tblHats+1] = { name = "Chapeau #" .. i, number = i, slidemax = GetNumberOfPedPropTextureVariations(PlayerPedId(), 0, i-1) - 1, number = i - 1, clothe = "helmet" }
                    end
                end

                return tblHats
            end,
        },
        ["chaines"]= {
            b = function()
                local tblHats = {}

                for i = 0, Clothes.maxVals.chain_1, 1 do
                    if ESX.PlayerData.job ~= "police" and ESX.PlayerData.job ~= "ambulance" then 
                        if IsPedPeds(PlayerPedId()) then 
                            if not Clothes.Blacklist.chain_1.m[i] then
                                tblHats[#tblHats+1] = { name = "Chaines #" .. i, number = i, slidemax = GetNumberOfPedTextureVariations(PlayerPedId(), 7, i) - 1, clothe = "chain" }
                            end
                        else
                            if not Clothes.Blacklist.chain_1.f[i] then
                                tblHats[#tblHats+1] = { name = "Chaines #" .. i, number = i, slidemax = GetNumberOfPedTextureVariations(PlayerPedId(), 7, i) - 1, clothe = "chain" }
                            end
                        end
                    else
                        tblHats[#tblHats+1] = { name = "Chaines #" .. i, number = i, slidemax = GetNumberOfPedTextureVariations(PlayerPedId(), 7, i) - 1, clothe = "chain" }
                    end
                end

                return tblHats
            end,
        },
        ["lunettes"]= {
            b = function()
                local tblGlasses = {}

                for i = 0, Clothes.maxVals.glasses_1, 1 do
                    if not Clothes.Blacklist.glasses_1[i] then
                        tblGlasses[#tblGlasses+1] = { name = "Lunettes #" .. i, slidemax = GetNumberOfPedPropTextureVariations(PlayerPedId(), 1, i-1) - 1, number = i-1, clothe = "glasses" }
                    end
                end

                return tblGlasses
            end,
        },
        ["sacs"]= {
            b = function()
                local tblBags = {}

                for i = 0, Clothes.maxVals.bags_1, 1 do

                    if ESX.PlayerData.job ~= "police" and ESX.PlayerData.job ~= "ambulance" then 
                        if IsPedPeds(PlayerPedId()) then 
                            if not Clothes.Blacklist.bags_1.m[i] then
                                tblBags[#tblBags+1] = { name = "Sac #" .. i, number = i, slidemax = GetNumberOfPedTextureVariations(PlayerPedId(), 5, i) - 1, clothe = "bags" }
                            end
                        else
                            if not Clothes.Blacklist.bags_1.f[i] then
                                tblBags[#tblBags+1] = { name = "Sac #" .. i, number = i, slidemax = GetNumberOfPedTextureVariations(PlayerPedId(), 5, i) - 1, clothe = "bags" }
                            end
                        end
                    else
                        tblBags[#tblBags+1] = { name = "Sac #" .. i, number = i, slidemax = GetNumberOfPedTextureVariations(PlayerPedId(), 5, i) - 1, clothe = "bags" }
                    end
                end

                return tblBags
            end,
        }
    }
}

Clothes.tableValue = {
    {id = 0, name = "ped"},
    {id = 1, name = "mask"},
    {id = 2, name = "hair"},
    {id = 3, name = "arms"},
    {id = 4, name = "pants"},
    {id = 5, name = "bags"},
    {id = 6, name = "shoes"},
    {id = 7, name = "chain"},
    {id = 8, name = "tshirt"},
    {id = 9, name = "bproof"},
    {id = 10, name = "decals"},
    {id = 11, name = "torso"},
}

Clothes.tableValueProps = {
    {id = 0, name = "helmet"},
    {id = 1, name = "glasses"},
    {id = 2, name = "ears"},
    {id = 6, name = "watches"},
    {id = 7, name = "bracelets"},
}

Clothes.MenuPed = {
    Base = { Title = "", Header = {"shopui_title_midfashion", "shopui_title_midfashion"} },
    Data = { currentMenu = "Magasin de vêtements" },
    Events = {
        onBack = function()
            ESX.TriggerServerCallback('esx_skin:getPlayerSkin', function(skin, jobSkin)
                TriggerEvent('skinchanger:loadSkin', skin)
            end)     
            
            Clothes:OpenCamera()
        end,
        onExited = function()
            ESX.TriggerServerCallback('esx_skin:getPlayerSkin', function(skin, jobSkin)
                TriggerEvent('skinchanger:loadSkin', skin)
            end)     
            
            Clothes:CloseCamera()
        end,
        onRender = OnRenderCam,
        onAdvSlide = function(menuData, value, btnData, zed, horang)
            local btn = btnData.name
            local advSlide = btnData.advSlider[3]
            local opacity = btnData.opacity
            local advSlide2 = advSlide / 20 - 1

            if value.currentMenu == "vêtements" then
                for k,v in pairs(Clothes.tableValue) do
                    if v.id == btnData.id then
                        TriggerEvent('skinchanger:change', v.name.."_2", advSlide)
                    end
                end
            elseif value.currentMenu == "accessoires" then
                for k,v in pairs(Clothes.tableValueProps) do
                    if v.id == btnData.id then
                        TriggerEvent('skinchanger:change', v.name.."_2", advSlide)
                    end
                end
            end
        end,
    },
    Menu = {
        ["Magasin de vêtements"] = {
            b = {
                { name = "Vêtements" },
                { name = "Accessoires" },
            },
        },
        ["vêtements"] = {
            extra = true,
            slidemax = function(slide)
                return GetNumberOfPedDrawableVariations(GetPlayerPed(-1), slide.id) - 1
            end,
            slide = function(value, btn)
                local slide, pPed = btn.slidenum and btn.slidenum - 1 or 0, GetPlayerPed(-1)
                btn.advSlider = {0, math.max(GetNumberOfPedTextureVariations(pPed, btn.id, slide) - 1, 0), 0}
                for k,v in pairs(Clothes.tableValue) do
                    if v.id == btn.id then
                        local name = v.name ~= "arms" and v.name.."_1" or v.name
                        TriggerEvent('skinchanger:change', name, slide)
                    end
                end
            end,
            b = function()
                local table, pPed = {}, GetPlayerPed(-1)
                for i = 0, 12 do
                    local MaxVaria = GetNumberOfPedTextureVariations(pPed, i, GetPedDrawableVariation(pPed, i)) - 1
                    if GetNumberOfPedDrawableVariations(pPed, i) - 1 > 0 or MaxVaria > 0 then
                        table[#table + 1] = {
                            name = "Variation #" .. i,
                            id = i,
                            advSlider = {0, math.max(MaxVaria, 0), 0}
                        }
                    end
                end
                return table
            end
        },
        ["accessoires"] = {
            extra = true,
            slidemax = function(b) return GetNumberOfPedPropDrawableVariations(GetPlayerPed(-1), b.id) end,
            slide = function(d, b)
                local ped = GetPlayerPed(-1)
                if not ped then return end

                local newCo = b.slidenum and b.slidenum or 0
                b.advSlider = {0, math.max(GetNumberOfPedPropTextureVariations(ped, b.id, newCo - 2) -1, 0), 0}
                for k,v in pairs(Clothes.tableValueProps) do
                    if v.id == b.id then
                        local name = v.name.."_1"
                        TriggerEvent('skinchanger:change', name, newCo - 2)
                    end
                end
            end,
            b = function()
                local tbl, ped = {}, GetPlayerPed(-1)
                for i = 0, 5 do
                    local totalTexture = GetNumberOfPedPropTextureVariations(ped, i, GetPedPropIndex(ped, i) ) - 1
                    if GetNumberOfPedPropDrawableVariations(ped, i) > 0 or totalTexture > 0 then
                        tbl[#tbl + 1] = { name = "Variations".. " #" .. i, id = i, advSlider = {0, math.max(totalTexture, 0), 0} }
                    end
                end
                return tbl
            end
        },
    }        
}

Clothes.MenuMask = {
    Base = { Title = "", Header = {"shopui_title_midfashion", "shopui_title_midfashion"} },
    Data = { currentMenu = "Magasin de masques" },
    Events = {
        onOpened = function()
            TriggerEvent('skinchanger:getData', function(components, maxVals2)
                Clothes.maxVals = maxVals2
            end)

            Clothes:OpenCamera()
        end,
        onExited = function()
            ESX.TriggerServerCallback('esx_skin:getPlayerSkin', function(skin, jobSkin)
                TriggerEvent('skinchanger:loadSkin', skin)
            end)    
            
            Clothes:CloseCamera()
        end,
        onRender = OnRenderCam,
        onBack = function()
            ESX.TriggerServerCallback('esx_skin:getPlayerSkin', function(skin, jobSkin)
                TriggerEvent('skinchanger:loadSkin', skin)
            end)        
        end,
        onSelected = function(self, menuData, btnData, currentSlt, allButtons)
            local slide = btnData.slidenum
            local btn = btnData.name

            if not btnData.dontSave then
                ESX.TriggerServerCallback("cClothes:PayMoney", function(payMoney) -- Todo
                    if payMoney then
                        Clothes:SavePlayerSkin()
                        ESX.ShowNotification("Vous avez acheté ~b~x1 "..btnData.name.."~s~.")
                        TriggerServerEvent("cClothes:saveClothes", btnData.clothe, btnData.number or currentSlt-1, (btnData.slidenum - 1) or 0, btnData.name)   
                    else
                        ESX.ShowNotification("~r~Vous n'avez pas assez d'argent.")
                        ESX.TriggerServerCallback('esx_skin:getPlayerSkin', function(skin, jobSkin)
                            TriggerEvent('skinchanger:loadSkin', skin)
                        end)        
                    end    
                end, 20)
            end
        end,
        onButtonSelected = function(currentMenu, currentBtn, menuData, btnData, self)
            local btn = btnData.name
        
            if btnData.clothe then
                TriggerEvent("skinchanger:change", btnData.clothe .. "_1", btnData.number or currentBtn - 1)
                TriggerEvent("skinchanger:change", btnData.clothe .. "_2", 0)
            end
        end,
        onSlide = function(menuData, btnData, currentSlt, self)
            local currentMenu = menuData.currentMenu
            local slide = btnData.slidenum
            local btn = btnData.name
        
            if btnData.clothe then
                TriggerEvent("skinchanger:change", btnData.clothe .. "_2", slide - 1)
            end
        end,
    },
    Menu = {
        ["Magasin de masques"] = {
            b = {
                { name = "Masques", ask = ">", askX = true, dontSave = true},
            }
        },
        ["masques"] = {
            b = function()
                local tblHauts = {}

                for i = 0, Clothes.maxVals.mask_1, 1 do
                    if not Clothes.Blacklist.mask_1[i] then
                        tblHauts[#tblHauts+1] = { name = "Masque #" .. i, slidemax = GetNumberOfPedTextureVariations(PlayerPedId(), 1, i-1) - 1, number = i - 1, clothe = "mask"}
                    end
                end

                return tblHauts
            end,
        }
    }
}

function CreateBlips(vector3Pos, intSprite, intColor, stringText, boolRoad, floatScale, intDisplay, intAlpha) -- Créer un blips
	local blip = AddBlipForCoord(vector3Pos.x, vector3Pos.y, vector3Pos.z)
	SetBlipSprite(blip, intSprite)
	SetBlipAsShortRange(blip, true)
	if intColor then 
		SetBlipColour(blip, intColor) 
	end
	if floatScale then 
		SetBlipScale(blip, floatScale) 
	end
	if boolRoad then 
		SetBlipRoute(blip, boolRoad) 
	end
	if intDisplay then 
		SetBlipDisplay(blip, intDisplay) 
	end
	if intAlpha then 
		SetBlipAlpha(blip, intAlpha) 
	end
	if stringText and (not intDisplay or intDisplay ~= 8) then
		BeginTextCommandSetBlipName("STRING")
		AddTextComponentString(stringText)
		EndTextCommandSetBlipName(blip)
	end
	return blip
end

Citizen.CreateThread(function()
    Wait(5000)

    for k,v in pairs(Clothes.Pos) do 
        if v.name == "clothes" then 
            CreateBlips(v.pos, 73, 38, "Magasin de vêtements", false, 0.7, nil, nil)
        elseif v.name == "mask" then 
            CreateBlips(v.pos, 362, 38, "Magasin de masques", false, 0.7, nil, nil)
        end
    end
    while true do 
        local pPed = PlayerPedId()
        local pPos = GetEntityCoords(pPed)
        local wait = 1000

        if not IsPedInAnyVehicle(pPed, false) then 
            for k,v in pairs(Clothes.Pos) do 
                local dist = Vdist(pPos, v.pos)

                if dist <= 2.5 then 
                    wait = 5
                    ESX.ShowHelpNotification("Appuyez sur ~INPUT_CONTEXT~ pour accéder au ~b~magasin~s~.")
                    if IsControlJustPressed(0, 51) then 
                        if v.name == "clothes" then 
                            local player = PlayerPedId()
                            if player == "ped" then 
                                CreateMenu(Clothes.MenuPed)
                            else
                                CreateMenu(Clothes.Menu)
                            end
                        elseif v.name == "mask" then 
                            CreateMenu(Clothes.MenuMask)
                        end
                    end
                end
            end
        end
        Wait(wait)
    end
end)