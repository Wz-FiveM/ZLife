-- Functions
ESX = nil
Citizen.CreateThread(function()
    while ESX == nil do 
        TriggerEvent('esx:getSharedObject', function(a)
            ESX = a 
        end)
    end 
end)

function Properties.Interior:GetSlideMaxFromConfig()
    local tblSlideMax = {}
    
    for k, v in pairs(Properties.Interiors) do
        if type(v) ~= "function" then
            tblSlideMax[#tblSlideMax+1] = v.label
        end
    end

    return tblSlideMax
end

function Properties.MaxChest:GetSlideMaxFromConfig()
    local tblSlideMax = {}

    for k, v in pairs(Properties.MaxChest) do
        if type(v) ~= "function" then
            tblSlideMax[#tblSlideMax+1] = v.Label
        end
    end

    return tblSlideMax
end

function Properties.Garage:GetSlideMaxFromConfig()
    local tblSlideMax = {}
    
    for k, v in pairs(Properties.Garages) do
        if type(v) ~= "function" then
            tblSlideMax[#tblSlideMax+1] = v.Label
        end
    end

    return tblSlideMax
end

function Properties:CreateProperty()
    if not Property.Pos then return ESX.ShowNotification("~r~Vous n'avez pas défini d'entrée.") end
    if not Property.Interior.Name then Property.Interior.Name = Properties.Interiors[1].name end 
    if not Property.Interior.Price then Property.Interior.Price = Properties.Interiors[1].price end 
    if not Property.Garage.Max then Property.Garage.Max = Properties.Garages[1].Space end 
    if not Property.MaxChest.Max then Property.MaxChest.Max = Properties.MaxChest[1].Max end 
    Property.Name = GetStreetNameFromHashKey(GetStreetNameAtCoord(Property.Pos.x, Property.Pos.y, Property.Pos.z)) .. " " .. math.random(1000, 7500)
    Property.Price = Property.Interior.Price * ((Property.Garage.Multiplier or 1) + (Property.MaxChest.Mutliplier or 1))

    TriggerServerEvent("ESX:createProperty", Property.Name, Property.Pos, Property.Garage.Pos, Property.Garage.Max, Property.Interior.Name, Property.Price, Property.MaxChest.Max)
    ESX.ShowNotification("Vous avez créé la propriété ~b~" .. Property.Name .. "~s~\nLoyer : ~b~" .. Property.Price .. "$")

    CloseMenu(true)
    Property.Name, Property.Pos, Property.Garage.Pos, Property.Garage.Max, Property.Interior.Name, Property.Price = nil, nil, nil, nil, nil, nil
end

-- Menus
Properties.Menus = {
    Creator = {
        Base = { Title = "Création de propriété", Header = {"commonmenu", "interaction_bgd"} },
        Data = { currentMenu = "Nouvelle propriété" },
        Events = {
            onSelected = function(self, menuData, btnData, currentSlt, allButtons)
                local slide = btnData.slidenum
                local btn = btnData.name
                local Player = PlayerPedId()

                if btn == "Placer une entrée" then
                    Property.Pos = GetEntityCoords(Player)
                    ESX.ShowNotification("~g~Position sauvegardée.")
                elseif btn == "Placer un garage" then
                    Property.Garage.Pos = GetEntityCoords(Player)
                    ESX.ShowNotification("~g~Position sauvegardée.")
                elseif btn == "~g~Créer la propriété" then
                    Properties:CreateProperty()
                end
            end,
            onSlide = function(menuData, btnData, currentSlt, self)
                local currentMenu = menuData.currentMenu
                local slide = btnData.slidenum
                local btn = btnData.name
                
                if btn == "Places dans le garage" then
                    Property.Garage.Max = Properties.Garages[slide].Space
                    Property.Garage.Multiplier = Properties.Garages[slide].Multiplier
                elseif btn == "Places dans le coffre" then
                    Property.MaxChest.Max = Properties.MaxChest[slide].Max
                    Property.MaxChest.Multiplier = Properties.MaxChest[slide].Mutliplier
                elseif btn == "Intérieur" then
                    Property.Interior.Name = Properties.Interiors[slide].name
                    Property.Interior.Price = Properties.Interiors[slide].price
                    btnData.sprite = Property.Interior.Name
                end
            end,
        },
        Menu = {
            ["Nouvelle propriété"] = {
                b = {
                    { name = "Placer une entrée", ask = ">", askX = true },
                    { name = "Placer un garage", ask = "~r~(Optionnel)", askX = true },
                    { name = "Places dans le garage", slidemax = Properties.Garage:GetSlideMaxFromConfig() },
                    { name = "Places dans le coffre", slidemax = Properties.MaxChest:GetSlideMaxFromConfig() },
                    { name = "Intérieur", slidemax = Properties.Interior:GetSlideMaxFromConfig()},
                    { name = "~g~Créer la propriété" },
                }
            }
        }
    }
}

function Properties:OpenCreateMenu()
    CreateMenu(Properties.Menus.Creator)
end

RegisterCommand(Property.CommandCreator, function()
    if ESX.PlayerData.job and ESX.PlayerData.job.name ~= Property.JobRequired then return end
    Properties:OpenCreateMenu()
end)