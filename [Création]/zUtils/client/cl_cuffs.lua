ESX = nil
local IsHandcuffed = false
local havesactete = false

Citizen.CreateThread(function()
	while ESX == nil do
		TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
		Citizen.Wait(0)
    end
end)

RegisterNetEvent("fn_cuff_item:checkCuff")
AddEventHandler("fn_cuff_item:checkCuff", function()
    local player, distance = ESX.Game.GetClosestPlayer()
    if distance~=-1 and distance<=3.0 then
        ESX.TriggerServerCallback("fn_cuff_item:isCuffed",function(cuffed)
            if not cuffed then
                TaskPlayAnim(PlayerPedId(), "mp_arrest_paired", "cop_p2_back_right", 8.0, -8, 4000, 48, 0, 0, 0, 0) 
                TriggerServerEvent("fn_cuff_item:handcuff",GetPlayerServerId(player),true)
                ESX.ShowNotification("Vous avez menotté ~g~quelqu'un~w~.")
            else
                TaskPlayAnim(GetPlayerPed(-1), 'mp_arresting', 'idle', 8.0, -8, -1, 49, 0, 0, 0, 0)
                TriggerServerEvent("fn_cuff_item:handcuff",GetPlayerServerId(player),false)
            end
        end,GetPlayerServerId(player))
    else
        ESX.ShowNotification("~r~Aucune personne à menotter.")
    end
end)

RegisterNetEvent("fn_cuff_item:uncuff")
AddEventHandler("fn_cuff_item:uncuff",function()
    local player, distance = ESX.Game.GetClosestPlayer()
    if distance~=-1 and distance<=3.0 then
        TriggerServerEvent("fn_cuff_item:uncuff",GetPlayerServerId(player))
        ESX.ShowNotification("Vous avez demenotté ~g~quelqu'un~w~.")
    else
        ESX.ShowNotification("~r~Aucune personne à démenotter.")
    end
end)

RegisterNetEvent('fn_cuff_item:forceUncuff')
AddEventHandler('fn_cuff_item:forceUncuff',function()
    IsHandcuffed = false
    local playerPed = GetPlayerPed(-1)
    ClearPedTasks(playerPed)
    ESX.ShowNotification("Vous êtes ~g~démenotté~s~.")
    SetEnableHandcuffs(playerPed, false)
    DisablePlayerFiring(playerPed, false)
    SetPedCanPlayGestureAnims(playerPed, true)
    FreezeEntityPosition(playerPed, false)
    TriggerEvent('skinchanger:getSkin', function(skin)
        if skin.sex == 0 then
            local clothesSkin = {
            ['chain_1'] = 0,  ['chain_2'] = 0
            }
            TriggerEvent('skinchanger:loadClothes', skin, clothesSkin)
        else
            local clothesSkin = {
            ['chain_1'] = 0,  ['chain_2'] = 0
            }
            TriggerEvent('skinchanger:loadClothes', skin, clothesSkin)
        end
    end)

end)

RegisterNetEvent("fn_cuff_item:handcuff")
AddEventHandler("fn_cuff_item:handcuff",function()
    local playerPed = GetPlayerPed(-1)
    IsHandcuffed = not IsHandcuffed
    Citizen.CreateThread(function()
        if IsHandcuffed then
            ClearPedTasks(playerPed)
            SetPedCanPlayAmbientBaseAnims(playerPed, true)

            Citizen.Wait(10)
            RequestAnimDict('mp_arresting')
            while not HasAnimDictLoaded('mp_arresting') do
                Citizen.Wait(100)
            end
            RequestAnimDict('mp_arrest_paired')
            while not HasAnimDictLoaded('mp_arrest_paired') do
                Citizen.Wait(100)
            end
			TaskPlayAnim(playerPed, "mp_arrest_paired", "crook_p2_back_right", 8.0, -8, -1, 32, 0, 0, 0, 0)
            Citizen.Wait(5000)
            ESX.ShowNotification("Vous êtes ~r~menotté~s~.")
            DisablePlayerFiring(PlayerPedId(), true)

            TaskPlayAnim(playerPed, 'mp_arresting', 'idle', 8.0, -8, -1, 49, 0, 0, 0, 0)

            SetEnableHandcuffs(playerPed, true)
            DisablePlayerFiring(playerPed, true)
            SetEnableHandcuffs(playerPed,true)
            SetCurrentPedWeapon(playerPed, GetHashKey('WEAPON_UNARMED'), true)
            SetPedCanPlayGestureAnims(playerPed, false)
            TriggerEvent('skinchanger:getSkin', function(skin)
                if skin.sex == 0 then
                    local clothesSkin = {
                    ['chain_1'] = 54,  ['chain_2'] = 0
                    }
                    TriggerEvent('skinchanger:loadClothes', skin, clothesSkin)
                else
                    local clothesSkin = {
                    ['chain_1'] = 36,  ['chain_2'] = 0
                    }
                    TriggerEvent('skinchanger:loadClothes', skin, clothesSkin)
                end
            end)
        else
            SetEnableHandcuffs(playerPed,false)
            ClearPedSecondaryTask(playerPed)
            SetEnableHandcuffs(playerPed, false)
            DisablePlayerFiring(playerPed, false)
            SetPedCanPlayGestureAnims(playerPed, true)
            FreezeEntityPosition(playerPed, false)
        end
    end)
end)


----------------------------------------


RegisterNetEvent("fn_sachead_item:checksachead")
AddEventHandler("fn_sachead_item:checksachead", function()
    local player, distance = ESX.Game.GetClosestPlayer()
    if distance~=-1 and distance<=3.0 then
        ESX.TriggerServerCallback("fn_sachead_item:issacheaded",function(sacheaded)
            if not sacheaded then
                TriggerServerEvent("fn_sachead_item:handsachead",GetPlayerServerId(player),true)
                ShowAboveRadarMessage("~g~Vous avez mis un sac sur la tête de la personne.")
            else
                TriggerServerEvent("fn_sachead_item:handsachead",GetPlayerServerId(player),false)
            end
        end,GetPlayerServerId(player))
    else
        ShowAboveRadarMessage("~r~Aucune personne.")
    end
end)

RegisterNetEvent("fn_sachead_item:unsachead")
AddEventHandler("fn_sachead_item:unsachead",function()
    local player, distance = ESX.Game.GetClosestPlayer()
    if distance~=-1 and distance<=3.0 then
        TriggerServerEvent("fn_sachead_item:unsachead",GetPlayerServerId(player))
        ShowAboveRadarMessage("~r~Vous avez retiré un sac sur la tête de la personne.")
    else
        ShowAboveRadarMessage("~r~Aucune personne.")
    end
end)

RegisterNetEvent("fn_sachead_item:handsachead")
AddEventHandler("fn_sachead_item:handsachead",function()
    local playerPed = GetPlayerPed(-1)
    havesactete = not havesactete
    Citizen.CreateThread(function()
        if havesactete then
            ClearPedTasks(playerPed)
            SetPedCanPlayAmbientBaseAnims(playerPed, true)

            Citizen.Wait(10)

            ShowAboveRadarMessage("~r~Quelqu'un vous a mis un sac sur ta tête.")
            DisablePlayerFiring(PlayerPedId(), true)
            SetCurrentPedWeapon(playerPed, GetHashKey('WEAPON_UNARMED'), true)
            SetPedCanPlayGestureAnims(playerPed, false)
            TriggerEvent('skinchanger:getSkin', function(skin)
                if skin.sex == 0 then
                    local clothesSkin = {
                    ['mask_1'] = 98, ['mask_2'] = 25
                    }
                    TriggerEvent('skinchanger:loadClothes', skin, clothesSkin)
                else
                    local clothesSkin = {
                    ['mask_1'] = 86, ['mask_2'] = 0
                    }
                    TriggerEvent('skinchanger:loadClothes', skin, clothesSkin)
                end
            end)
        else
            ClearPedSecondaryTask(playerPed)
            DisablePlayerFiring(playerPed, false)
            SetPedCanPlayGestureAnims(playerPed, true)
            TriggerEvent('skinchanger:getSkin', function(skin)
                if skin.sex == 0 then
                    local clothesSkin = {
                        ['mask_1'] = 0, ['mask_2'] = 0
                    }
                    TriggerEvent('skinchanger:loadClothes', skin, clothesSkin)
                else
                    local clothesSkin = {
                        ['mask_1'] = 0, ['mask_2'] = 0
                    }
                    TriggerEvent('skinchanger:loadClothes', skin, clothesSkin)
                end
            end)
        end
    end)
end)
local controlDisabled = {21,22,24,25,257,263,264,140}
Citizen.CreateThread(function()
    local wasgettingup = false
    while true do
        local attente = 500
        if IsHandcuffed then
            attente = 1
            local ped = GetPlayerPed(-1)
            if not IsEntityPlayingAnim(ped, "mp_arresting", "idle", 3) and not IsEntityPlayingAnim(ped, "mp_arrest_paired", "crook_p2_back_right", 3) or (wasgettingup and not IsPedGettingUp(ped)) then ESX.Streaming.RequestAnimDict("mp_arresting", function() TaskPlayAnim(ped, 'mp_arresting', 'idle', 8.0, -8, -1, 49, 0, 0, 0, 0) end) end
            wasgettingup = IsPedGettingUp(ped)
            for _,v in pairs(controlDisabled) do
                DisableControlAction(0, v, true)
            end
        end
        if havesactete then
            attente = 1
            HideHudAndRadarThisFrame()
            DrawRect(.0,.0,2.0,2.0,0,0,0,255)
            SetPauseMenuActive(false)
            DrawNiceText(.4,.4,.7,"Vous avez un sac sur la tête !",4)
        end
        Wait(attente)
    end
end)
RegisterNetEvent("fn_ciseau_item:checkCiseau")
AddEventHandler("fn_ciseau_item:checkCiseau", function()
    local _=LocalPlayer().Ped
    local player = getClosePly()
    --if distance~=-1 and distance<=3.0 then
        ESX.TriggerServerCallback("fn_ciseau_item:isCiseau",function(ciseaut)
            if not ciseaut then
                if not player then ShowAboveRadarMessage("~r~Aucune cible localisée.") return end
                if not IsBehindPed(player) then ShowAboveRadarMessage("Vous devez être ~r~derrière~w~ l'individu et il doit être ~r~menotté~w~.") return end
                FreezeEntityPosition(_, true)
                playr = GetPlayerServerId(player)
                local xSebv5Jc=GetPlayerPed(GetPlayerFromServerId(playr))
                if not xSebv5Jc or not DoesEntityExist(xSebv5Jc)then
                    ShowAboveRadarMessage("~r~ERREUR.")
                    return 
                end
                local mMp,rDtVf,vj,z=GetEntityMatrix(xSebv5Jc)
                SetEntityCoords(_,z+rDtVf*.45-mMp*.1-vj*.9)
                local Zg=GetEntityHeading(xSebv5Jc)
                local hw18 = {"missfam6ig_8_ponytail", "ig_7_loop_michael"}
                SetEntityHeading(_,Zg+15.0)
                print(Zg+15.0)
                print(_,z+rDtVf*.45-mMp*.1-vj*.9)
                forceAnim(hw18, 1)
                TriggerServerEvent("fn_ciseau_item:handCiseau",GetPlayerServerId(player),true)
                ngzOjWHO = attachObjectPedHand("p_cs_scissors_s", 20000)
                TriggerServerEvent('clp_removeciseau')
                FreezeEntityPosition(_, false)
                ESX.ShowNotification("Vous avez ~r~coupé les cheveux~w~ de votre cible.")
            else
                TriggerServerEvent("fn_ciseau_item:handCiseau",GetPlayerServerId(player),false)
            end
        end,GetPlayerServerId(player))
    --else
        --ESX.ShowNotification("~r~Aucune personne à proximiter.")
    --end
end)

RegisterNetEvent("fn_ciseau_item:handCiseau")
AddEventHandler("fn_ciseau_item:handCiseau", function()
    local playerPed = GetPlayerPed(-1)
    IsHandciseaut = not IsHandciseaut
    if IsHandciseaut then
        ClearPedTasks(playerPed)
        SetPedCanPlayAmbientBaseAnims(playerPed, true)
        local dict, anim = "missfam6ig_8_ponytail","ig_7_loop_lazlow"
        ESX.Streaming.RequestAnimDict(dict)
        TaskPlayAnim(playerPed, dict, anim, 8.0, 8.0, -1, 1, 1, 0, 0, 0)
        Citizen.Wait(20000)
        ESX.ShowNotification("Vos cheveux ont été ~r~coupés~w~.")
        TriggerEvent('skinchanger:change', 'hair_1', 0)
        SetPedToRagdoll(playerPed,1000,1000,0,0,0,0)
        Citizen.Wait(200)
        ClearPedTasks(playerPed)
        TriggerEvent('skinchanger:getSkin', function(skin)
            TriggerServerEvent('esx_skin:save', skin)
        end)
    else
        ClearPedSecondaryTask(playerPed)
        SetEnableHandcuffs(playerPed, false)
        DisablePlayerFiring(playerPed, false)
        SetPedCanPlayGestureAnims(playerPed, true)
        FreezeEntityPosition(playerPed, false)
    end
end)

