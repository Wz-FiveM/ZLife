zSociety.OpenRageUIMenu = function(_society, _options)
    if ESX.PlayerData.job ~= nil and ESX.PlayerData.job.name == _society.name and ESX.PlayerData.job.grade_name == "boss" then
        if zSociety.Menu then
            zSociety.Menu = false
        else
            zSociety.InitRageUIMenu(zSocietyCFG.Title, zSocietyCFG.SubTitle, zSocietyCFG.Banner.Texture, zSocietyCFG.Banner.Name, zSocietyCFG.ColorMenu, zSocietyCFG.Banner.Display)
            zSociety.Menu = true
            local options = {money = true, wash = false,employees = true,grades = true}
            for k,v in pairs(options) do if _options[k] == nil then _options[k] = v end  end
            zSociety.RefreshMoney(_society.name)
            RageUI.Visible(RMenu:Get('bossmenu', 'main'), true)

            Citizen.CreateThread(function()
                local closestPlayer, closestDistance = ESX.Game.GetClosestPlayer()
                while zSociety.Menu do
                    RageUI.IsVisible(RMenu:Get('bossmenu', 'main'), zSocietyCFG.Banner.Display, true, true, function()
                        RageUI.Separator(zSociety.Trad["society"].." :~y~ " .._society.label)

                        if closestPlayer ~= -1  and closestDistance <= 5.0 then
                            RageUI.Button(zSociety.Trad["recruit"], zSociety.Trad["recruit_desc"], {}, true, function(Hovered, Active, Selected)
                                if Active then
                                    local pCoords = GetEntityCoords(GetPlayerPed(closestPlayer))
                                    DrawMarker(2, pCoords.x, pCoords.y, pCoords.z+1.1, 0, 0, 0, 180.0, nil, nil, 0.2, 0.2, 0.2, 255, 255, 255, 170, 0, 1, 0, 0, nil, nil, 0)
                                    if Selected then
                                        TriggerServerEvent("zSociety:RequestSetRecruit", GetPlayerServerId(closestPlayer), _society.name)
                                    end
                                end
                            end)
                        end

                        if _options.money then
                            if zSociety.societyMoney ~= nil then
                                RageUI.Separator(zSociety.Trad["society_money"].." :~b~" ..zSociety.societyMoney.." "..zSociety.Trad["money_symbol"])
                            end
                            RageUI.Button(zSociety.Trad["withdraw_money"], false, {}, true, function(Hovered, Active, Selected)
                                if Selected then
                                    result = zSociety.KeyboardInput("pick", zSociety.Trad["how_much"], "", 8)
                                    if result ~= nil and result ~= "" then
                                        result = ESX.Math.Round(tonumber(result))
                                        if result > 0 then
                                            TriggerServerEvent('zSociety:withdrawMoney', _society.name, result)
                                            SetTimeout(100, function()
                                                zSociety.RefreshMoney(_society.name)
                                            end)
                                        else
                                            RageUI.Popup({message = zSociety.Trad["impossible_action"]})
                                        end
                                    end
                                end
                            end)
    
                            RageUI.Button(zSociety.Trad["deposit_money"], false, {}, true, function(Hovered, Active, Selected)
                                if Selected then
                                    result = zSociety.KeyboardInput("deposit", zSociety.Trad["how_much"], "", 8)
                                    if result ~= nil and result ~= "" then
                                        result = ESX.Math.Round(tonumber(result))
                                        if result > 0 then
                                            TriggerServerEvent('zSociety:depositMoney', _society.name, result)
                                            SetTimeout(100, function()
                                                zSociety.RefreshMoney(_society.name)
                                            end)
                                        else
                                            RageUI.Popup({message = zSociety.Trad["impossible_action"]})
                                        end
                                    end
                                end
                            end)
                        end

                        if _options.wash and _society.percent then
                            RageUI.Button(zSociety.Trad["wash_money"], zSociety.Trad["wash_money_desc"].." (".._society.percent.."%).", {}, true, function(Hovered, Active, Selected)
                                if Selected then
                                    local tax = tonumber("0.".._society.percent)
                                    result = zSociety.KeyboardInput("wash", zSociety.Trad["how_much"], "", 8)
                                    result = tonumber(result)
                                    if result ~= nil and result ~= "" then
                                        if result >= 2 then
                                            TriggerServerEvent('zSociety:washMoney', _society.name, result, tax)
                                            SetTimeout(100, function()
                                                zSociety.RefreshMoney(_society.name)
                                            end)
                                        else
                                            RageUI.Popup({message = "~b~Action impossible"})
                                        end
                                    end
                                end
                            end)
                        end

                        if _options.employees then
                            RageUI.Button(zSociety.Trad["manage_employees"], false, {RightLabel = "→→→"}, true, function(Hovered, Active, Selected)
                                if Selected then
                                    zSociety.RefeshEmployeesList(_society.name)
                                    filterstring = ""
                                end
                            end, RMenu:Get('bossmenu', 'manage_employees'))
                        end
    
                        if _options.grades then
                            RageUI.Button(zSociety.Trad["manage_salary"], zSociety.Trad["manage_salary_desc"], {RightLabel = "→→→"}, true, function(Hovered, Active, Selected)
                                if Selected then
                                    zSociety.RefeshjobInfos(_society.name)
                                end
                            end, RMenu:Get('bossmenu', 'manage_salary'))
                        end
                    end)

                    RageUI.IsVisible(RMenu:Get('bossmenu', 'manage_employees'), zSocietyCFG.Banner.Display, true, true, function()
                        RageUI.Button(zSociety.Trad["search"], false, {RightLabel = filterstring}, true, function(Hovered, Active, Selected)
                            if Selected then
                                filterstring = zSociety.KeyboardInput("entysearch", "~b~"..zSociety.Trad["search"], "", 50)
                            end
                        end)
                        RageUI.Separator("↓↓ ~b~"..zSociety.Trad["list"].."~s~ ↓↓")
    
                        for i=1, #zSociety.EmployeesList do
                            local ply = zSociety.EmployeesList[i]
    
                            if filterstring == nil or string.find(ply.name, filterstring) or string.find(ply.job.grade_label, filterstring) then
                                RageUI.Button(ply.name, false, {RightLabel = "~b~"..ply.job.grade_label.."~s~ →"}, true, function(Hovered, Active, Selected)
                                    if Selected then
                                        zSociety.RefeshjobInfos(_society.name)
                                        SelectedEmployee = ply
                                    end
                                end, RMenu:Get('bossmenu', 'update_employee'))
                            end
                        end
                    end)

                    RageUI.IsVisible(RMenu:Get('bossmenu', 'update_employee'), zSocietyCFG.Banner.Display, true, true, function()

                        RageUI.Separator("↓↓ ~b~"..SelectedEmployee.name.."~s~ ↓↓")
    
                        for i=1, #zSociety.JobList, 1 do
                            local jb = zSociety.JobList[i]
    
                            if SelectedEmployee.job.grade ~= jb.grade then
                                RageUI.Button(jb.label, false, {RightLabel = zSociety.Trad["choose"]}, true, function(Hovered, Active, Selected)
                                    if Selected then
                                        ESX.TriggerServerCallback('zSociety:setJob', function(data)
                                            if data ~= false then
                                                SelectedEmployee.job.grade = jb.grade
                                            end
                                        end, SelectedEmployee.identifier, _society.name, jb.grade)
                                    end
                                end)
                            else
                                RageUI.Button(jb.label, false, {RightLabel = zSociety.Trad["current"]}, true, function(Hovered, Active, Selected)
                                end)
                            end
                        end
    
                        RageUI.Button(zSociety.Trad["kick_society"], false, {RightBadge = RageUI.BadgeStyle.Alert}, true, function(Hovered, Active, Selected)
                            if Selected then
                                result = zSociety.KeyboardInput("valid", zSociety.Trad["sure"].." ("..zSociety.Trad["yes"]..")", "", 8)
                                if result == zSociety.Trad["yes"] then
                                    ESX.TriggerServerCallback('zSociety:setJob', function()
                                        RageUI.GoBack()
                                    end, SelectedEmployee.identifier, 'unemployed', 0)
                                end
                            end
                        end)
                    end)

                    RageUI.IsVisible(RMenu:Get('bossmenu', 'manage_salary'), zSocietyCFG.Banner.Display, true, true, function()
                        RageUI.Separator("↓↓ ~b~".._society.label.."~s~ ↓↓")
    
                        for i=1, #zSociety.JobList, 1 do
                            local jb = zSociety.JobList[i]
    
                            RageUI.Button(jb.grade..". "..jb.label, false, {RightLabel = "~g~"..jb.salary.." "..zSociety.Trad["money_symbol"]}, true, function(Hovered, Active, Selected)
                                if Selected then
                                    result = zSociety.KeyboardInput("pick", zSociety.Trad["how_much"], "", 4)
                                    result = ESX.Math.Round(tonumber(result))
                                    if result >= 0 and result <= _society.salary_max then
                                        ESX.TriggerServerCallback('zSociety:setJobSalary', function()
                                            SetTimeout(100, function()
                                                zSociety.RefeshjobInfos(_society.name)
                                            end)
                                        end, _society.name, jb.grade, result)
                                        print(_society.name, jb.grade, result)
                                    else
                                        RageUI.Popup({message = zSociety.Trad["impossible_action"]})
                                    end
                                end
                            end)
                        end
                    end)

                    Citizen.Wait(0)
                end
            end)
        end
    end
end