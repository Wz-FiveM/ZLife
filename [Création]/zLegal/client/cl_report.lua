ESX = nil
Citizen.CreateThread(function()
	while ESX == nil do
		TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
		Citizen.Wait(0)
	end
end)


local reportlist = {}
local function getInfoReport()
    local info = {}
    ESX.TriggerServerCallback('report:infoReport', function(info)
        reportlist = info
    end)
end

local function openReport()
    if menuIsOpened then
        return
    end
    menuIsOpened = true
    RMenu.Add("cat", "main", RageUI.CreateMenu("  Report", " ", 50, 80))
    RMenu.Add("cat", "info", RageUI.CreateSubMenu(RMenu:Get("cat", "main"), nil, desc,50,80))
    RMenu:Get("cat", "main").Closed = function()
    end

    RageUI.Visible(RMenu:Get("cat", "main"), true)
    Citizen.CreateThread(function()
        while menuIsOpened do
            local shouldStayOpened = false
            local function tick()
                shouldStayOpened = true
            end
            getInfoReport()

            RageUI.IsVisible(RMenu:Get("cat", "main"), true, true, true, function()
                tick()
                if #reportlist >= 1 then
                    RageUI.Separator("↓ Nouveaux Report ↓")

                    for k,v in pairs(reportlist) do
                        RageUI.Button(k.." - Report de [~b~"..v.nom.."~s~] | Id : [~p~"..v.id.."~s~]", nil, {RightLabel = "→→"},true , function(_,_,s)
                            if s then
                                nom = v.nom
                                nbreport = k
                                id = v.id
                                raison = v.args
                            end
                        end, RMenu:Get("cat", "info"))
                    end
                else
                    RageUI.Separator("")
                    RageUI.Separator("~b~Aucun Report~s~")
                    RageUI.Separator("")
                end    
            end, function()end)

            RageUI.IsVisible(RMenu:Get("cat", "info"), true, true, true, function()
                tick()
                RageUI.Separator("Report numéro : ~b~"..nbreport)
                    RageUI.Separator("Auteur : ~b~"..nom.."~s~ [~b~"..id.."~s~]")
                    RageUI.Separator("Raison du report : ~b~"..raison)
                    RageUI.Separator("")
                    RageUI.Button("Se téléporter sur ~b~"..nom, nil, {RightLabel = "→→"}, true, function(_,_,s)
                        if s then
                            TeleportInPlayer(id)
                        end
                    end)

                    RageUI.Button("Téléporter ~b~"..nom.."~s~ sur moi", nil, {RightLabel = "→→"}, true, function(_,_,s)
                        if s then
                            TeleportPlayerInYou(id)
                        end
                    end)

                    RageUI.Button("Répondre au report", nil, {RightLabel = "→→"}, true, function(_, _, s)
                        if s then 
                            local reponse = keybord('~c~Entrez le message ici :', nil, 100)
                            local reponseReport = GetOnscreenKeyboardResult(reponse)
                            if reponseReport == "" then
                                ESX.ShowNotification("~b~Admin\n~r~Vous n'avez pas fourni de message")
                            else
                                if reponseReport then
                                    ESX.ShowNotification("Le message : ~b~"..reponseReport.."~s~ a été envoyer à ~b~"..GetPlayerName(GetPlayerFromServerId(id))) 
                                    TriggerServerEvent("report:message", id, "~b~Staff~s~\n"..reponseReport)
                                end
                            end
                        end
                    end)

                    RageUI.Button("Fermer le report de ~b~"..nom, nil, {RightLabel = "→→"}, true, function(_,_,s)
                        if s then
                            TriggerServerEvent('report:CloseReport', nom, raison)
                            TriggerServerEvent("report:message", id, "~b~Staff~s~\nVotre report à été fermé !")
                            reportMenu = false
                        end
                    end, RMenu:Get("cat", "main"))  
            end, function()end)

            if not shouldStayOpened and menuIsOpened then
                menuIsOpened = false
            end
            Wait(0)
        end
        RMenu:Delete("cat", "main")
        RMenu:Delete("cat", "sub")
    end)
end


Citizen.CreateThread(function()
    while true do
        if IsControlJustPressed(0, 344) then
            ESX.TriggerServerCallback('report:getUsergroup', function(group)
                if group == 'superadmin' or group == 'admin' or group == 'mod' then
                    openReport()
                end
            end) 
        end
        Wait(1)
    end
end)


