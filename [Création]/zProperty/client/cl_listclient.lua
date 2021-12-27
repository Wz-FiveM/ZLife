function Property:OpenClientListMenu()
    if not Properties.List then return ESX.ShowNotification("~r~La liste des propriétés n'a pas encore chargée. Veuillez réessayer.") end
    CreateMenu(Properties.Menus.Clients)
end

function Property:GetInteriorLabel2(name)
    for k, v in pairs(Properties.Interiors) do
        if name == v.name then
            return v.label 
        end
    end
end

Properties.Menus.Clients = {
    Base = { Title = "Liste des clients", Header = {"commonmenu", "interaction_bgd"} },
    Data = { currentMenu = "Agence immobilière" },
    Events = {
        onOpened = function()
            if not Properties.Filter then Properties.Filter = "all" end
        end,
        onSelected = function(self, menuData, btnData, currentSlt, allButtons)
            local slide = btnData.slidenum
            local btn = btnData.name

            if btn == "Filtre" then 
                if slide == 1 then
                    Properties.Filter = "all"
                elseif slide == 2 then
                    Properties.Filter = "bought"
                elseif slide == 3 then
                    Properties.Filter = "rented"
                elseif slide == 4 then
                    Properties.Filter = "free"
                end
                CloseMenu(true)
                CreateMenu(Properties.Menus.Clients)
            elseif btn == "Mettre un point sur le GPS" then
                SetNewWaypoint(btnData.pos.x, btnData.pos.y)
                ESX.ShowNotification("La position a été ajoutée sur votre radar")
            else
                Property.Selected = Properties.List[btnData.i]
                OpenMenu("Gestion propriété")
            end
        end,
    },
    Menu = {
        ["Agence immobilière"] = {
            -- refresh = true,
            b = function()
                tblMenu = {
                    { name = "Filtre", slidemax = { "Toutes les propriétés", "Propriétés achetées", "Propriétés louées", "Propriétés libres" }},
                    { separator = "Liste des propriétés", sepColor = "~b~"}
                }

                if Properties.Filter == "all" then
                    for k, v in pairs(Properties.List) do 
                        tblMenu[#tblMenu+1] = { name = v.property_name, identifier = v.property_owner, price = v.property_price, i = k }
                    end
                elseif Properties.Filter == "bought" then
                    for k, v in pairs(Properties.List) do
                        if v.property_status == "bought" then
                            tblMenu[#tblMenu+1] = { name = v.property_name, identifier = v.property_owner, price = v.property_price, i = k }
                        end
                    end
                elseif Properties.Filter == "rented" then
                    for k, v in pairs(Properties.List) do
                        if v.property_status == "rented" then
                            tblMenu[#tblMenu+1] = { name = v.property_name, identifier = v.property_owner, price = v.property_price, i = k }
                        end
                    end
                elseif Properties.Filter == "free" then
                    for k, v in pairs(Properties.List) do
                        if v.property_status == "free" then
                            tblMenu[#tblMenu+1] = { name = v.property_name, identifier = v.property_owner, price = v.property_price, i = k }
                        end
                    end
                end

                return tblMenu
            end
        },
        ["Gestion propriété"] = {
            b = function()
                local tblMenu = {}

                tblMenu[#tblMenu+1] = { name = "Intérieur", ask = "~b~" .. Property:GetInteriorLabel2(Property.Selected.property_type), askX = true }
                tblMenu[#tblMenu+1] = { name = "Places dans le garage", ask = "~b~" .. (Property.Selected.garage_max and Property.Selected.garage_max .. " places") or "Aucun garage", askX = true }
                tblMenu[#tblMenu+1] = { name = "Mettre un point sur le GPS", pos = json.decode(Property.Selected.property_pos) } 

                return tblMenu
            end
        }
    }
}

RegisterCommand(Property.CommandClients, function()
    if ESX.PlayerData.job and ESX.PlayerData.job.name ~= Property.JobRequired then return end
    CreateMenu(Properties.Menus.Clients)
end)