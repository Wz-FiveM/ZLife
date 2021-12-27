local isInSeat = false
local contentData, maxVals = {}, {}
local tempName = ""
local currentBarber = 0
local instructionsClothes = nil

-- functions
local function SavePlayerSkin()
    TriggerEvent('skinchanger:getSkin', function(skin)
        TriggerEvent('esx_skin:save', skin)
    end)
end 

local Player = nil
local cam = nil
local function CloseCamera()
    ClearPedTasks(PlayerPedId())
    TriggerEvent('skinchanger:modelLoaded')
    ESX.TriggerServerCallback('esx_skin:getPlayerSkin', function(skin)
        TriggerEvent('skinchanger:loadSkin', skin)
    end)
    DestroyCam(cam)
    RenderScriptCams(false, true, 500, false, false)

    for _, i in pairs(GetActivePlayers()) do
        NetworkConcealPlayer(i, false, false)
    end
end
local function OpenCamera()

    Player = GetPlayerPed(-1)
    for k, v in pairs(GetActivePlayers()) do 
		if v ~= GetPlayerIndex() then 
			NetworkConcealPlayer(v, true, true) 
		end 
	end

    --instructionsClothes = Instructions({{key = 44, message = "Rotation gauche"}, {key = 51, message = "Rotation droite"}})

    local pPed = GetPlayerPed(-1)
    cam = CreateCam("DEFAULT_SCRIPTED_CAMERA", true)
    SetCamRot(cam, 0.0, 0.0, 270.0, true)
    local pCoords, pHeading = GetEntityCoords(pPed), GetEntityHeading(pPed)
    local cCoords = pHeading * math.pi / 180.0
    SetCamCoord(cam, pCoords.x - 1.5 * math.sin(cCoords), pCoords.y + 1.5 * math.cos(cCoords), pCoords.z + .5)
    SetCamRot(cam, .0, .0, 120.0, 2)
    PointCamAtEntity(cam, pPed, .0, .0, .0, true)
    SetCamActive(cam, true)
    RenderScriptCams(1, 0, 500, 1, 0)
end
local ControlDisable = {24, 27, 178, 177, 189, 190, 187, 188, 202, 239, 240, 201, 172, 173, 174, 175}
local function OnRenderCam()
    DisableAllControlActions(0)
    for k, v in pairs(ControlDisable) do
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

    DrawScaleformMovieFullscreen(instructionsClothes, 255, 255, 255, 255, 0)
end





local tableValue = {
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

local tableValueProps = {
    {id = 0, name = "helmet"},
    {id = 1, name = "glasses"},
    {id = 2, name = "ears"},
    {id = 6, name = "watches"},
    {id = 7, name = "bracelets"},
}


Clothes = {
    Base = { Title = "", Header = {"shopui_title_midfashion", "shopui_title_midfashion"} },
    Data = { currentMenu = "Magasin de vêtements" },
    Events = {
        onOpened = function()
            TriggerEvent('skinchanger:getData', function(components, maxVals2)
                maxVals = maxVals2
            end)

            OpenCamera()
        end,
        onExited = function()
            ESX.TriggerServerCallback('ESX_skin:getPlayerSkin', function(skin, jobSkin)
                TriggerEvent('skinchanger:loadSkin', skin)
            end)    
            
            CloseCamera()
        end,
        onRender=OnRenderCam,
        onBack = function()
            ESX.TriggerServerCallback('ESX_skin:getPlayerSkin', function(skin, jobSkin)
                TriggerEvent('skinchanger:loadSkin', skin)
            end)        
        end,
        onSelected = function(self, menuData, btnData, currentSlt, allButtons)
            local slide = btnData.slidenum
            local btn = btnData.name

            if not btnData.dontSave then
                ESX.TriggerServerCallback("ESX:PayMoney", function(payMoney)
                    if payMoney then
                        SavePlayerSkin()
                        ESX.ShowNotification("Vous avez payé ~b~20$~s~.")
                        if btnData.clothe ~= "arms" then
                            TriggerEvent('skinchanger:getSkin', function(skin) 
                                TriggerServerEvent("ESX:saveClothes", btnData.clothe, skin, btn)
                            end)   
                        else
                            TriggerEvent('skinchanger:getSkin', function(skin) 
                                TriggerServerEvent("ESX:saveClothes", "torso", skin, tempName)
                            end)
                            CloseMenu(true)
                            CreateMenu(Shops.Menus.Clothes)
                        end     
                    else
                        ESX.ShowNotification("~r~Vous n'avez pas assez d'argent.")
                        ESX.TriggerServerCallback('ESX_skin:getPlayerSkin', function(skin, jobSkin)
                            TriggerEvent('skinchanger:loadSkin', skin)
                        end)        
                    end    
                end, 20)
            else
                if menuData.currentMenu == "hauts" then
                    tempName = btn
                    OpenMenu("Sous-hauts")
                    Wait(25)
                elseif menuData.currentMenu == "Sous-hauts" then
                    OpenMenu("Bras")
                    Wait(50)
                end
            end
            if btn == "~g~Sauvegarder ma tenue" then
                AskEntry(function(msg)
                    if msg then
                        TriggerEvent('skinchanger:getSkin', function(skin) 
                            TriggerServerEvent("esx:saveClothes", "tenue", skin, msg)
                            ShowNotification("Vous venez de sauvegarder votre tenue (~b~"..msg.."~s~).")
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
                                    for i = 0, count, 1 do 
                                        Rsv("ESX:saveClothes", "tenue", skin, name)
                                        Wait(100)
                                    end
                                    ShowNotification("Vous venez de sauvegarder votre tenue (~b~x"..count.." "..name.."~s~).")
                                end)          
                            end
                        end, "Nombre de tenues")
                    end
                end, "Nom de la tenue")
            end
            if menuData.currentMenu == "mes tenues" and btnData.skin then
                TriggerEvent('skinchanger:getSkin', function(skin)
                    TriggerEvent('skinchanger:loadClothes', skin, json.decode(btnData.skin))
                    SavePlayerSkin()
                    BeginTextCommandThefeedPost("STRING")
                    AddTextComponentSubstringPlayerName("Vous avez enfilé la tenue ~b~" .. btn .."~s~.")
                    EndTextCommandThefeedPostTickerForced(true, true)            
                end)
            end
            if menuData.currentMenu == "~r~supprimer une tenue" then
                Rsv("ESX:deleteClothe", btnData.tenueId)
                CloseMenu(true)
                CreateMenu(Shops.Menus.Clothes)
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
            else
                if currentMenu == "mes tenues" and btnData.skin then
                    TriggerEvent('skinchanger:getSkin', function(skin)
                        TriggerEvent('skinchanger:loadClothes', skin, json.decode(btnData.skin))
                    end)
                end
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
                { separator = "Tenues", sepColor = "~b~", dontSave = true },
                { name = "Mes tenues", ask = ">", askX = true, dontSave = true},
                { name = "~g~Sauvegarder ma tenue", ask = ">", askX = true, dontSave = true },
                { name = "~g~Sauvegarder plusieurs exemplaires de ma tenue", ask = ">", askX = true, dontSave = true },
            }
        },
        ["vêtements"] = {
            b = {
                { name = "Hauts", ask = ">", askX = true, dontSave = true },
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
        ["oreilles"] = {
            b = function()
                local tblHauts = {}

                for i = 0, maxVals.ears_1, 1 do
                    if not Shops.Clothes.Blacklist.ears_1[i] then
                        tblHauts[#tblHauts+1] = { name = "Oreille #" .. i, slidemax = 5, number = i - 1, clothe = "ears"}
                    end
                end

                return tblHauts
            end,
        },
        ["calques"] = {
            b = function()
                local tblHauts = {}

                for i = 0, maxVals.decals_1, 1 do
                    if Player.Job ~= "police" and Player.Job ~= "ambulance" then 
                        if IsPedMale(PlayerPedId()) then 
                            if not Shops.Clothes.Blacklist.decals_1.m[i] then
                                tblHauts[#tblHauts+1] = { name = "Calques #" .. i, number = i, slidemax = 15, clothe = "decals"}
                            end
                        else
                            if not Shops.Clothes.Blacklist.decals_1.f[i] then
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

                for i = 0, maxVals.watches_1, 1 do
                    if not Shops.Clothes.Blacklist.watches_1[i] then
                        tblHauts[#tblHauts+1] = { name = "Montre #" .. i, slidemax = 3, number = i - 1, clothe = "watches"}
                    end
                end

                return tblHauts
            end,
        },
        ["bracelets"] = {
            b = function()
                local tblHauts = {}

                for i = 0, maxVals.bracelets_1, 1 do
                    if not Shops.Clothes.Blacklist.bracelets_1[i] then
                        tblHauts[#tblHauts+1] = { name = "Bracelet #" .. i, slidemax = 3, clothe = "bracelets"}
                    end
                end

                return tblHauts
            end,
        },
        ["hauts"] = {
            b = function()
                local tblHauts = {}

                for i = 0, maxVals.torso_1, 1 do
                    --if Player.Job ~= "police" and Player.Job ~= "ambulance" then 
                        if IsPedMale(PlayerPedId()) then 
                            if not Shops.Clothes.Blacklist.torso_1.m[i] then
                                tblHauts[#tblHauts+1] = { name = "Haut #" .. i, number = i, slidemax = 30, clothe = "torso", dontSave = true }
                            end
                        else
                            if not Shops.Clothes.Blacklist.torso_1.f[i] then
                                tblHauts[#tblHauts+1] = { name = "Haut #" .. i, number = i, slidemax = 30, clothe = "torso", dontSave = true }
                            end
                        end
                    -- else
                    --     tblHauts[#tblHauts+1] = { name = "Haut #" .. i, number = i, slidemax = 30, clothe = "torso", dontSave = true }
                    -- -end
                end

                return tblHauts
            end,
        },
        ["Sous-hauts"] = {
            b = function()
                local tblHauts2 = {}

                for i = 0, maxVals.tshirt_1, 1 do
                    --if Player.Job ~= "police" and Player.Job ~= "ambulance" then 
                        if IsPedMale(PlayerPedId()) then 
                            if not Shops.Clothes.Blacklist.tshirt_1.m[i] then
                                tblHauts2[#tblHauts2+1] = { name = "Sous-hauts #" .. i, number = i, slidemax = 30, clothe = "tshirt", dontSave = true }
                            end
                        else
                            if not Shops.Clothes.Blacklist.tshirt_1.f[i] then
                                tblHauts2[#tblHauts2+1] = { name = "Sous-hauts #" .. i, number = i, slidemax = 30, clothe = "tshirt", dontSave = true }
                            end
                        end
                    -- else
                    --     tblHauts2[#tblHauts2+1] = { name = "Sous-hauts #" .. i, number = i, slidemax = 30, clothe = "tshirt", dontSave = true }
                    -- end
                end

                return tblHauts2
            end,
        },
        ["Bras"] = {
            b = function()
                local tblBras = {}

                for i = 0, maxVals.arms, 1 do
                    if not Shops.Clothes.Blacklist.arms[i] then
                        tblBras[#tblBras+1] = { name = "Bras #" .. i, slidemax = 15, clothe = "arms" }
                    end
                end

                return tblBras
            end,
        },
        ["bas"] = {
            b = function()
                local tblBas = {}

                for i = 0, maxVals.pants_1, 1 do
                    --if Player.Job ~= "police" and Player.Job ~= "ambulance" then 
                        if IsPedMale(PlayerPedId()) then 
                            if not Shops.Clothes.Blacklist.pants_1.m[i] then
                                tblBas[#tblBas+1] = { name = "Bas #" .. i, number = i, slidemax = 30, clothe = "pants" }
                            end
                        else
                            if not Shops.Clothes.Blacklist.pants_1.f[i] then
                                tblBas[#tblBas+1] = { name = "Bas #" .. i, number = i, slidemax = 30, clothe = "pants" }
                            end
                        end
                    -- else
                    --     tblBas[#tblBas+1] = { name = "Bas #" .. i, number = i, slidemax = 30, clothe = "pants" }
                    -- end
                end

                return tblBas
            end,
        },
        ["chaussures"] = {
            b = function()
                local tblShoes = {}

                for i = 0, maxVals.shoes_1, 1 do
                    if not Shops.Clothes.Blacklist.shoes_1[i] then
                        tblShoes[#tblShoes+1] = { name = "Chaussures #" .. i, slidemax = 30, clothe = "shoes" }
                    end
                end

                return tblShoes
            end,
        },
        ["chapeaux"]= {
            b = function()
                local tblHats = {}

                for i = 0, maxVals.helmet_1, 1 do
                    --if Player.Job ~= "police" and Player.Job ~= "ambulance" then 
                        if IsPedMale(PlayerPedId()) then 
                            if not Shops.Clothes.Blacklist.helmet_1.m[i] then
                                tblHats[#tblHats+1] = { name = "Chapeau #" .. i, number = i, slidemax = 30, number = i - 1, clothe = "helmet" }
                            end
                        else
                            if not Shops.Clothes.Blacklist.helmet_1.f[i] then
                                tblHats[#tblHats+1] = { name = "Chapeau #" .. i, number = i, slidemax = 30, number = i - 1, clothe = "helmet" }
                            end
                        end
                    -- else
                    --     tblHats[#tblHats+1] = { name = "Chapeau #" .. i, number = i, slidemax = 30, number = i - 1, clothe = "helmet" }
                    -- end
                end

                return tblHats
            end,
        },
        ["chaines"]= {
            b = function()
                local tblHats = {}

                for i = 0, maxVals.chain_1, 1 do
                    --if Player.Job ~= "police" and Player.Job ~= "ambulance" then 
                        if IsPedMale(PlayerPedId()) then 
                            if not Shops.Clothes.Blacklist.chain_1.m[i] then
                                tblHats[#tblHats+1] = { name = "Chaines #" .. i, number = i, slidemax = 20, clothe = "chain" }
                            end
                        else
                            if not Shops.Clothes.Blacklist.chain_1.f[i] then
                                tblHats[#tblHats+1] = { name = "Chaines #" .. i, number = i, slidemax = 20, clothe = "chain" }
                            end
                        end
                    -- else
                    --     tblHats[#tblHats+1] = { name = "Chaines #" .. i, number = i, slidemax = 20, clothe = "chain" }
                    -- end
                end

                return tblHats
            end,
        },
        ["autres"]= {
            b = function()
                local tblHats = {}

                for i = 0, maxVals.bproof_1, 1 do
                    if IsPedMale(PlayerPedId()) then 
                        if Shops.Clothes.Blacklist.bproof_1[i] then
                            tblHats[#tblHats+1] = { name = "Autres #" .. i, slidemax = 15, number = i - 1, clothe = "bproof" }
                        end
                    end
                end

                return tblHats
            end,
        },
        ["lunettes"]= {
            b = function()
                local tblGlasses = {}

                for i = 0, maxVals.glasses_1, 1 do
                    if not Shops.Clothes.Blacklist.glasses_1[i] then
                        tblGlasses[#tblGlasses+1] = { name = "Lunettes #" .. i, slidemax = 30, clothe = "glasses" }
                    end
                end

                return tblGlasses
            end,
        },
        ["sacs"]= {
            b = function()
                local tblBags = {}

                for i = 0, maxVals.bags_1, 1 do

                    if Player.Job ~= "police" and Player.Job ~= "ambulance" then 
                        if IsPedMale(PlayerPedId()) then 
                            if not Shops.Clothes.Blacklist.bags_1.m[i] then
                                tblBags[#tblBags+1] = { name = "Sac #" .. i, number = i, slidemax = 30, clothe = "bags" }
                            end
                        else
                            if not Shops.Clothes.Blacklist.bags_1.f[i] then
                                tblBags[#tblBags+1] = { name = "Sac #" .. i, number = i, slidemax = 30, clothe = "bags" }
                            end
                        end
                    else
                        tblBags[#tblBags+1] = { name = "Sac #" .. i, number = i, slidemax = 30, clothe = "bags" }
                    end
                end

                return tblBags
            end,
        },
        ["mes tenues"] = {
            b = function()
                local tblTenues = {}
                tblTenues[#tblTenues+1] = { name = "~r~Supprimer une tenue", dontSave = true}

                ESX.TriggerServerCallback("ESX:getClothes", function(cb)
                    for k, v in pairs(cb) do 
                        if v.type == "tenue" then   
                            tblTenues[#tblTenues+1] = { name = v.name, skin = v.skin, dontSave = true }
                        end
                    end
                end)

                Wait(500)

                return tblTenues
            end,
        },
        ["~r~supprimer une tenue"] = {
            b = function()
                local tblTenues = {}

                ESX.TriggerServerCallback("ESX:getClothes", function(cb)
                    for k, v in pairs(cb) do 
                        if v.type == "tenue" then   
                            tblTenues[#tblTenues+1] = { name = v.name, tenueId = v.id, dontSave = true }
                        end
                    end
                end)

                Wait(500)

                return tblTenues
            end,
        },
    }
}

function OpenOtherMenuShops(data)
    contentData = data
    Shops.Menus.Content.Base.Title = data.Name or "Shops"
    Shops.Menus.Content.Base.Header = data.Header or {"commonmenu", "interaction_bgd"}
    CreateMenu(Shops.Menus.Content)
end

function OpenReselMenuShops(data)
    contentData = data
    Shops.Menus.Content.Base.Title = data.Name or "Reseller"
    Shops.Menus.Content.Base.Header = data.Header or {"commonmenu", "interaction_bgd"}
    CreateMenu(Shops.Menus.Resel)
end

function OpenBarberMenuShops(data, pos)
    seatPlayer(data, pos)
    Shops.Menus.Barber.Base.Header = data.Header or {"commonmenu", "interaction_bgd"}
    CreateMenu(Shops.Menus.Barber)
end

function OpenClotheMenuShops(data)
    ESX.TriggerServerCallback('esx_skin:getPlayerSkin', function(skin)
        TriggerEvent('skinchanger:getSkin', function(skin)
            if skin.sex == 0 or skin.sex == 1 then
                CreateMenu(Clothes)
            else
                CreateMenu(Clothes)
            end
        end)
    end)
end

function OpenMaskMenuShops(data)
    Shops.Menus.Mask.header = data.Header or {"commonmenu", "interaction_bgd"}
    CreateMenu(Shops.Menus.Mask)
end

function OpenTattooMenuShops(data)
    Shops.Menus.Tattoos.header = data.Header or {"commonmenu", "interaction_bgd"}
    CreateMenu(Shops.Menus.Tattoos)
end

local InMarker = {} 
-- menus
Citizen.CreateThread(function()
    local player = GetPlayerPed()
    while true do
        local time = 1000
        local pPed = GetPlayerPed()
        local pPos = GetEntityCoords(PlayerPedId())
        for k, v in pairs(Config.Shops) do
            -- while ESX.PlayerData.job == nil do
            --     Citizen.Wait(100)
            -- end
            if v.JobRequired and (ESX.PlayerData.job.name ~= v.JobRequired) then
            else
                if v.Pos then
                    for k, v2 in pairs(v.Pos) do
                        local dist = Vdist(pPos, v2)
                        if dist < v.Size and not isInSeat then
                            time = 5
                            InMarker[k] = true  
                            ESX.ShowHelpNotification(v.Notif or "Merci de signaler au Admins: " .. v.name)
                            --SendNUIMessage({response = "OpenEyes"})
                            --SendNUIMessage({response = "CloseEyes"})
                            if IsControlJustPressed(0, 51) then 
                                Wait(100)
                                if v.Type == "Other" then
                                    RandPickupAnim()
                                    OpenOtherMenuShops(v)
                                elseif v.Type == "Clothe" then
                                    OpenClotheMenuShops(v)
                                elseif v.Type == "Mask" then
                                    OpenMaskMenuShops(v)
                                elseif v.Type == "Barber" then
                                    OpenBarberMenuShops(v, v2)
                                elseif v.Type == "Tattoo" then
                                    OpenTattooMenuShops(v)
                                elseif v.Type == "Weapon" then
                                    RandPickupAnim()
                                    OpenOtherMenuShops(v)
                                elseif v.Type == "Resel" then 
                                    RandPickupAnim()
                                    OpenReselMenuShops(v)
                                elseif v.Type == "Event" then
                                    TriggerEvent(v.Event)
                                end
                            end
                        end
                    end
                elseif v.Props then 
                    local props = GetClosestObjectOfType(pPos.x, pPos.y, pPos.z, v.Size, GetHashKey(v.Props), false, false, false)
                    if props ~= 0 and DoesEntityExist(props) then 
                        time = 5 
                        InMarker[k] = true 
                        ShowHelpNotification(v.Notif or "Merci de signaler au Admins: " .. v.name)
                        if IsControlJustPressed(0, 51) then 
                            TaskAnim({"anim@mp_radio@high_apment","button_press_bedroom"}, 1000, 49)
                            OpenOtherMenuShops(v)
                        end
                    end
                end
            end
        end
        Wait(time)
    end
end)

-- blip
Citizen.CreateThread(function()
    Wait(5000)
    local player = GetPlayerPed()
    while true do 
        for _,v2 in pairs(Config.Shops) do 
            if v2.Blip then 
                if not v2.Blip.exist and not v2.Blip.blip then
                    v2.Blip.exist, v2.Blip.blip = {}, {}
                end
                while ESX.PlayerData.job == nil do
                    Citizen.Wait(100)
                end
                if v2.Blip then
                    for k, v in pairs(v2.Pos) do 
                        if v2.JobRequired then
                            if ESX.PlayerData.job.name == v2.JobRequired then 
                                if v2.Blip and not v2.Blip.exist[k] and not v2.Blip.blip[k] then 
                                    local blipAction = CreateBlips(v, v2.Blip.display, v2.Blip.colour, v2.Name, false, v2.Blip.size)
                                    v2.Blip.exist[k] = true
                                    v2.Blip.blip[k] = blipAction
                                    Wait(100)
                                end
                            else
                                if v2.Blip.exist[k] and v2.Blip.blip[k] then 
                                    if DoesBlipExist(v2.Blip.blip[k]) then 
                                        RemoveBlip(v2.Blip.blip[k])
                                        v2.Blip.exist[k] = false
                                        v2.Blip.blip[k] = nil
                                    end
                                end
                            end
                        end
                    end
                end
            end
        end
        Wait(15*1000)
    end
end)