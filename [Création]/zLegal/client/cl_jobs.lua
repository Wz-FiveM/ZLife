Jobs = Jobs or {}
Jobs.breakThread = false
local notifId = nil

print('[ ^2Module^0 ] ^2Jobs Farm Loaded')


RegisterNetEvent("rCore:CanFarm")
AddEventHandler("rCore:CanFarm", function(bool)
    Jobs.breakThread = bool
    RemoveProgressBar()
    ClearPedTasksImmediately(PlayerPedId())
    FreezeEntityPosition(PlayerPedId(), bool)
end) 


Citizen.CreateThread(function()
    local player = PlayerPedId()
    Wait(5*1000)
    while true do 
        local wait = 5000
        local pPed = PlayerPedId()
        if Jobs.breakThread then 
            wait = 5 
            ShowHelpNotification("Appuyez sur ~INPUT_CONTEXT~ pour ~r~arrêter~s~.")
            if IsControlJustPressed(0, 51) then 
                FreezeEntityPosition(pPed, false)
                Jobs.breakThread = false 
                RemoveProgressBar()
                ClearPedTasksImmediately(pPed)
                if notifId then 
                    RemoveNotification(notifId)
                end
                notifId = ShowNotification("~r~Vous avez arrêté de travailler.")
            end
        end
        Wait(wait)
    end
end)

-- Job Farm
Citizen.CreateThread(function()
    local player = PlayerPedId()
    Wait(5*1000)
    while true do 
        local wait = 500
        local pPed = PlayerPedId()
        local pPos = GetEntityCoords(pPed)
        for _,v in pairs(Jobs.JobsFarm) do 
            for z,j in pairs(v.actions) do 
                local distance = Vdist(j.pos, pPos)
                if distance < j.size and not ProgressBarExists() then 
                    wait = 5
                    ShowHelpNotification(j.notif or "Merci de signaler au Admins: "..j.name)
                    if IsControlJustPressed(0, 51) then 
                        if j.action == "farm" then 
                            if j.anim then 
                                TaskAnimForce({j.anim[1], j.anim[2]}, 1)
                            end
                            Jobs.breakThread = true
                            while distance < j.size and Jobs.breakThread do
                                if not ProgressBarExists() then
                                    ProgressBar(j.message.name, j.message.r, j.message.g, j.message.b, 200, j.time - 1000)
                                    if j.anim then 
                                        FreezeEntityPosition(pPed, true)
                                        if not IsEntityPlayingAnim(pPed, j.anim[1], j.anim[2], 3) or not IsPedActiveInScenario(pPed) then 
                                            TaskAnimForce({j.anim[1], j.anim[2]}, 1)
                                        end
                                    end
                                    pPos = GetEntityCoords(pPed)                
                                    distance = Vdist(pPos, j.pos)
                                    TriggerServerEvent("wCore:FarmItem", j.itemRequired or nil, j.itemwin or nil, j.countwin or 0, j.countrequired or 0, j.sell or false, j.money or nil)
                                else
                                    RemoveProgressBar()
                                    if notifId then 
                                        RemoveNotification(notifId)
                                    end
                                    notifId = ShowNotification("~r~Vous ne pouvez pas faire cela.")
                                    break
                                end
                                if distance > j.size then 
                                    Jobs.breakThread = false 
                                    RemoveProgressBar()
                                    ClearPedTasksImmediately(pPed)
                                    if notifId then 
                                        RemoveNotification(notifId)
                                    end
                                    notifId = ShowNotification("~r~Vous avez arrêté de travailler.")
                                    break
                                end
                                Wait(j.time)
                            end
                        elseif j.action == "vehicle" then 
                            --if not player.InVehicle then 
                            spawnCar(j.vehicle.model, j.vehicle.pos, j.vehicle.heading)
                            --end
                        elseif j.action == "delvehicle" then 
                            local pVeh = GetVehiclePedIsIn(pPed, false)
                            if pVeh then 
                                if GetEntityModel(pVeh) == GetHashKey(j.vehicle.model) then 
                                    ESX.Game.DeleteVehicle(pVeh)
                                    DeleteVehicle(pVeh)
                                    ShowNotification("~b~Vous venez de ranger votre véhicule.")
                                else
                                    ShowNotification("~r~Ce modèle de véhicule ne correspond pas au véhicule demandé.")
                                end
                            else
                                ShowNotification("~r~Vous devez être dans un véhicule.")
                            end
                        end
                    end
                end
            end
        end
        Wait(wait)
    end
end)



Citizen.CreateThread(function()
    Wait(5000)
    for _,v in pairs(Jobs.JobsFarm) do 
        if v.global.blips then 
            CreateBlips(v.global.pos, v.global.blips.display, v.global.blips.colour, v.name, false, v.global.blips.size)
        end
        for k2, v2 in pairs(v.actions) do 
            if v2.blips then 
                CreateBlips(v2.pos, v2.blips.display, v2.blips.colour, v2.name, false, v2.blips.size)
            end
        end
    end   
end)