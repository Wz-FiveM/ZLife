local function GetPlayers()
	local players = {}

	for _,player in ipairs(GetActivePlayers()) do
		if DoesEntityExist(GetPlayerPed(player)) then
			table.insert(players, player)
		end
	end

	return players
end

local QxpoV = true

local function GetClosestPlayer(distance)
    for k, v in pairs(GetPlayers()) do
        local target = GetPlayerPed(v)

        if target ~= PlayerPedId() and GetDistanceBetweenCoords(GetEntityCoords(target), GetEntityCoords(PlayerPedId())) <= distance and IsEntityVisible(target) then
            return v
        end
    end

    return false
end

local TableKeyAnim, PlayerProps, PlayerParticles = {}, {}, {}
local PtfxWhile = false

local function DestroyAllProps()
    if #PlayerProps > 0 then
        for _,v in pairs(PlayerProps) do
            DeleteEntity(v)
        end
    end
end

local function AddPropToPlayer(prop1, bone, off1, off2, off3, rot1, rot2, rot3)
    local hash = GetHashKey(prop1)

    while not HasModelLoaded(hash) do
        RequestModel(hash)
        Wait(10)
    end
  
    prop = CreateObject(hash, GetEntityCoords(PlayerPedId()),  true,  true, true)
    SetEntityAsMissionEntity(prop, true, false)
    AttachEntityToEntity(prop, PlayerPedId(), GetPedBoneIndex(PlayerPedId(), bone), off1, off2, off3, rot1, rot2, rot3, true, true, false, true, 1, true)
    table.insert(PlayerProps, prop)
    SetModelAsNoLongerNeeded(hash)
end

local function StopAnimation()
    PtfxWhile = false
    DestroyAllProps()
end

local function PtfxStart(PtfxWait, PtfxInfo, PtfxAsset, PtfxName, PtfxNoProp, Ptfx1, Ptfx2, Ptfx3, Ptfx4, Ptfx5, Ptfx6, PtfxScale)
    PtfxWhile = true
    while PtfxWhile do
        Wait(5)
        if IsControlPressed(0, 47) then
            while not HasNamedPtfxAssetLoaded(PtfxAsset) do
                RequestNamedPtfxAsset(PtfxAsset)
                Wait(10)
            end
            UseParticleFxAssetNextCall(PtfxAsset)
        
            local Ptfx = StartNetworkedParticleFxLoopedOnEntityBone(PtfxName, PtfxNoProp and PlayerPedId() or prop, Ptfx1, Ptfx2, Ptfx3, Ptfx4, Ptfx5, Ptfx6, GetEntityBoneIndexByName(PtfxName, "VFX"), 1065353216, 0, 0, 0, 1065353216, 1065353216, 1065353216, 0)
            SetParticleFxLoopedColour(Ptfx, 1.0, 1.0, 1.0)
            table.insert(PlayerParticles, Ptfx)

            Wait(PtfxWait)
            
            for a, b in pairs(PlayerParticles) do
                StopParticleFxLooped(b, false)
                table.remove(PlayerParticles, a)
            end
        else
            DrawTopNotification(PtfxInfo)
        end
    end
end

local function ActionKeyAnim(Infos)
    if Infos ~= false then
        local MovType, EmoteDuration = 0, -1
        local Dict, Animation, Name = table.unpack(Infos)

        StopAnimation()

        if Dict == "Expression" then
            TriggerEvent("demarche:upstar", false, true, false, Animation)
            SetFacialIdleAnimOverride(PlayerPedId(), Animation, 0)
            if Animation == "default" then 
                ClearFacialIdleAnimOverride(PlayerPedId())
                TriggerEvent("demarche:upstar", false, false, false, "rien")
            end
            return
        end
        
        if (Dict == "MaleScenario" or "Scenario") and not IsPedInAnyVehicle(PlayerPedId(), false) then 
            if Dict == "MaleScenario" then 
                if GetEntityModel(PlayerPedId()) == GetHashKey("mp_m_freemode_01") then --Check Male
                    doAnim(Animation, nil, 0)
                else
                    ShowAboveRadarMessage("~r~Cet emote est réservé aux hommes.")
                end 
                return
            elseif Dict == "ScenarioObject" then
                TaskStartScenarioAtPosition(PlayerPedId(), Animation, GetOffsetFromEntityInWorldCoords(PlayerPedId(), 0.0, 0 - 0.5, -0.5), GetEntityHeading(PlayerPedId()), 0, 1, false)
                return
            elseif Dict == "Scenario" then
                doAnim(Animation, nil, 0)
                return 
            end 
        end

        while not HasAnimDictLoaded(Dict) do
            RequestAnimDict(Dict)
            Wait(10)
        end

        if Infos.AnimationOptions then
            if IsPedInAnyVehicle(PlayerPedId(), false) then
                MovType = 51
            elseif Infos.AnimationOptions.EmoteMoving then
                MovType = 51
            elseif Infos.AnimationOptions.EmoteLoop then
                MovType = 1
            elseif Infos.AnimationOptions.EmoteStuck then
                MovType = 50
            end
            if Infos.AnimationOptions.EmoteDuration ~= nil then
                EmoteDuration = Infos.AnimationOptions.EmoteDuration
            end
        end
        local anim = {Dict, Animation}
        doAnim(anim, nil, MovType)
        RemoveAnimDict(Dict)
        if Infos.AnimationOptions then
            if Infos.AnimationOptions.Prop then
                Wait(EmoteDuration)
                AddPropToPlayer(Infos.AnimationOptions.Prop, Infos.AnimationOptions.PropBone, table.unpack(Infos.AnimationOptions.PropPlacement))
                if Infos.AnimationOptions.SecondProp then
                    AddPropToPlayer(Infos.AnimationOptions.SecondProp, Infos.AnimationOptions.SecondPropBone, table.unpack(Infos.AnimationOptions.SecondPropPlacement))
                end
            end
            if Infos.AnimationOptions.PtfxAsset then
                Wait(1000)
                PtfxStart(Infos.AnimationOptions.PtfxWait, Infos.AnimationOptions.PtfxInfo, Infos.AnimationOptions.PtfxAsset, Infos.AnimationOptions.PtfxName, Infos.AnimationOptions.PtfxNoProp, table.unpack(Infos.AnimationOptions.PtfxPlacement))
            end
        end
    end
end

local function WalkStart(Infos)
    RequestAnimSet(Infos[1])
    while not HasAnimSetLoaded(Infos[1]) do
        Citizen.Wait(1)
    end
    SetPedMovementClipset(PlayerPedId(), Infos[1], 0.2)
    RemoveAnimSet(Infos[1])
    TriggerEvent("demarche:upstar", true, false, Infos[1])
    if Infos[1] == "move_f@multiplayer" or Infos[1] == "move_m@multiplayer" then 
        ResetPedMovementClipset(PlayerPedId(),0)
        TriggerEvent("demarche:upstar", false, false, "rien")
    end
end

local function AnimShared(Infos, ListId)
    local target = GetClosestPlayer(3)
    if target then
        TriggerServerEvent("ServerEmoteRequest", GetPlayerServerId(target), ListId, Infos[3])
    else
        ShowAboveRadarMessage("~b~Distance\n~w~Rapprochez-vous.")
    end
end  

RegisterNetEvent("ClientEmoteRequestReceive")
AddEventHandler("ClientEmoteRequestReceive", function(emoteanim, emotename)
    PlaySound(-1, "NAV", "HUD_AMMO_SHOP_SOUNDSET", 0, 0, 1)
    ShowAboveRadarMessage("~y~Y~w~ accepter, ~r~L~w~ refuser (~g~" .. emotename .."~w~)")
    local isRequestAnim = 1
    while isRequestAnim <= 100 do
        Citizen.Wait(5)
        isRequestAnim = isRequestAnim + 1
        if IsControlJustPressed(1, 246) then
            TriggerServerEvent("ServerValidEmote", GetPlayerServerId(GetClosestPlayer(3)), emoteanim)
        elseif IsControlJustPressed(1, 182) then
            ShowAboveRadarMessage("~r~Emote refusée.")
        end
    end
end)

RegisterNetEvent("SyncPlayEmote")
AddEventHandler("SyncPlayEmote", function(emote, sourceP)
    local pedInFront = GetPlayerPed(GetClosestPlayer(3))
    local coords = GetOffsetFromEntityInWorldCoords(pedInFront, 0.0, 1.0, 0.0)
    if AnimList.Partage[emote].AnimationOptions.SyncOffsetFront then
        coords = GetOffsetFromEntityInWorldCoords(pedInFront, 0.0, AnimList.Partage[emote].AnimationOptions.SyncOffsetFront, 0.0)
    end
    SetEntityHeading(PlayerPedId(), GetEntityHeading(pedInFront) - 180.1)
    SetEntityCoordsNoOffset(PlayerPedId(), coords.x, coords.y, coords.z, 0)

    ActionKeyAnim(AnimList.Partage[emote])
end)

local function AddAnimToKeyBinding(nameKeyBind, Infos)
    if not Infos then
        DeleteResourceKvp(string.format('animBind%s', nameKeyBind))
    else
        SetResourceKvp(string.format('animBind%s', nameKeyBind), tostring(Infos.Dict) .. "," .. tostring(Infos.ListId))
    end

    local tableValue = {}
    local GetKey = GetResourceKvpString(string.format('animBind%s', nameKeyBind))
    if GetKey ~= nil then
        for value in GetKey:gmatch('([^,]+)') do
            table.insert(tableValue, value)
        end

        if tableValue[1] and tableValue[2] then
            TableKeyAnim[nameKeyBind] = {Assign = true, Anim = AnimList[tableValue[1]][tableValue[2]]}
        else
            TableKeyAnim[nameKeyBind] = {Assign = false, Anim = false}
        end
    else
        TableKeyAnim[nameKeyBind] = {Assign = false, Anim = false}
    end
end

RegisterNetEvent('anim:pouvoir')
AddEventHandler('anim:pouvoir', function(pov)
    QxpoV = pov
end)

local function KeysRegister()
    for i=1, 9 do
        local tableValue = {}
        local GetKey = GetResourceKvpString(string.format('animBind%s', i))
        if GetKey ~= nil then
            for value in GetKey:gmatch('([^,]+)') do
                table.insert(tableValue, value)
            end

            if tableValue[1] and tableValue[2] then
                AddAnimToKeyBinding(i, {Dict = tableValue[1], ListId = tableValue[2]})
            else
                AddAnimToKeyBinding(i, false)
            end
        else
            AddAnimToKeyBinding(i, false)
        end

        RegisterControlKey(string.format('animBind%s', i),string.format("Jouer l'animation n°%s", i), string.format("NUMPAD%s", i),function()
            if TableKeyAnim[i].Assign then
                if TableKeyAnim[i].Anim.Dict == "Demarches" then
                    WalkStart(TableKeyAnim[i].Anim)
                else
                    local Info = TableKeyAnim[i].Anim
                    local MovType, EmoteDuration = 0, -1
                    local Dict, Animation, Name = table.unpack(Info)

                    if not QxpoV then return end 

                    if Dict == "Expression" then
                        SetFacialIdleAnimOverride(PlayerPedId(), Animation, 0)
                        return
                    end
                    
                    if (Dict == "MaleScenario" or "Scenario") and not IsPedInAnyVehicle(PlayerPedId(), false) then 
                        if Dict == "MaleScenario" then 
                            if GetEntityModel(PlayerPedId()) == GetHashKey("mp_m_freemode_01") then --Check Male
                                doAnim(Animation, nil, 0)
                            else
                                ShowAboveRadarMessage("~r~Cet emote est réservé aux hommes.")
                            end 
                            return
                        elseif Dict == "ScenarioObject" then
                            TaskStartScenarioAtPosition(PlayerPedId(), Animation, GetOffsetFromEntityInWorldCoords(PlayerPedId(), 0.0, 0 - 0.5, -0.5), GetEntityHeading(PlayerPedId()), 0, 1, false)
                            return
                        elseif Dict == "Scenario" then
                            doAnim(Animation, nil, 0)
                            return 
                        end 
                    end

                    if Info.AnimationOptions then
                        if IsPedInAnyVehicle(PlayerPedId(), false) then
                            MovType = 51
                        elseif Info.AnimationOptions.EmoteMoving then
                            MovType = 51
                        elseif Info.AnimationOptions.EmoteLoop then
                            MovType = 1
                        elseif Info.AnimationOptions.EmoteStuck then
                            MovType = 50
                        end
                        if Info.AnimationOptions.EmoteDuration ~= nil then
                            EmoteDuration = Info.AnimationOptions.EmoteDuration
                        end
                    end
                    local anim = {Dict, Animation}
                    doAnim(anim, nil, MovType)
                end
            end
        end)
    end
end

local function OpenMenuMain()
    local menu = RMenu.Add('anim', 'main', RageUI.CreateMenu("Animations", "Animations"), true)
    local submenu = RMenu.Add('anim', "submenu", RageUI.CreateSubMenu(menu, "Animations", "Animations"), true)
    local submenu2 = RMenu.Add('anim', "submenu2", RageUI.CreateSubMenu(submenu, "Animations", "Animations"), true)
    local submenu3 = RMenu.Add('anim', "submenu3", RageUI.CreateSubMenu(submenu2, "Animations", "Animations"), true)
    local Table = {
        {name = "Jouer l'animation", submenu = false},
        {name = "Annuler l'animation", submenu = false},
        {name = "Bind l'animation", submenu = submenu3},
        {name = "Supprimer l'animation des binds", submenu = submenu3}
    }
    RageUI.Visible(menu, not RageUI.Visible(menu))
    while menu ~= nil do
        RageUI.IsVisible(menu, function()
            RageUI.Item.Button("Annuler l'animation", "Annuler l'animation", {RightBadge = nil}, true, {
                onSelected = function()
                    ClearPedTasks(GetPlayerPed(-1))
                    PtfxWhile = false
                    DestroyAllProps()
                end
            })
            for animDict_id, animDict in pairs(AnimList) do
                RageUI.Item.Button(animDict_id, animDict_id, {RightLabel = ">"}, true, {
                    onSelected = function()
                        --submenu:SetTitle(animDict_id)
                        Infos = {Dict = animDict_id}
                    end
                }, submenu)
            end
        end)
        RageUI.IsVisible(submenu, function()
            if Infos ~= nil then
                for animList_id, animList in pairs(AnimList[Infos.Dict]) do
                    RageUI.Item.Button((Infos.Dict == "Expressions" or Infos.Dict == "Demarches") and animList_id or animList[3], animList_id, {RightLabel = ">"}, true, {
                        onSelected = function()
                            --submenu2:SetTitle(animList[3])
                            Infos = {Dict = Infos.Dict, ListId = animList_id, infos = AnimList[Infos.Dict][animList_id]}
                            --[[ if Infos.Dict == "Demarches" then
                                WalkStart(Infos.infos)
                            elseif Infos.Dict == "Partage" then
                                AnimShared(Infos.infos, Infos.ListId)
                            else
                                ActionKeyAnim(Infos.infos)
                            end    ]]   
                        end
                    }, submenu2)
                end
            end
        end)
        RageUI.IsVisible(submenu2, function()
            for line, action in pairs(Table) do
                RageUI.Item.Button(action.name, action.name, {RightLabel = ">"}, true, {
                    onSelected = function()
                        if action.name == "Annuler l'animation" then
                            ClearPedTasks(GetPlayerPed(-1))
                            PtfxWhile = false
                            DestroyAllProps()
                            if Infos.Dict == "Demarches" then
                                ResetPedMovementClipset(PlayerPedId(),0)
                                TriggerEvent("demarche:upstar", false, false, "rien")
                            elseif Infos.Dict == "Expression" then 
                                ClearFacialIdleAnimOverride(PlayerPedId())
                                TriggerEvent("demarche:upstar", false, false, false, "rien")
                            end
                        elseif action.name == "Jouer l'animation" then 
                            if Infos.Dict == "Demarches" then
                                WalkStart(Infos.infos)
                            elseif Infos.Dict == "Partage" then
                                AnimShared(Infos.infos, Infos.ListId)
                            else
                                ActionKeyAnim(Infos.infos)
                            end
                        else
                            Infos = {NameMenu = action.name, Dict = Infos.Dict, ListId = Infos.ListId, infos = Infos.infos}
                        end
                    end
                }, action.submenu)
            end
        end)
        RageUI.IsVisible(submenu3, function()
            for nameKeyBind, action in ipairs(TableKeyAnim) do
                if Infos.NameMenu == "Bind l'animation" and not action.Assign then
                    RageUI.Item.Button("Touches n°" .. nameKeyBind, "Assigner l'animation à cette touche", {RightLabel = ">"}, true, {
                        onSelected = function()
                            RageUI.GoBack()
                            ShowAboveRadarMessage("Vous avez bind l'animations: ~b~"..Infos.ListId.."~s~ sur la touche: ~b~"..nameKeyBind.."~s~.")
                            AddAnimToKeyBinding(nameKeyBind, {Dict = Infos.Dict, ListId = Infos.ListId})
                        end
                    })
                elseif Infos.NameMenu == "Supprimer l'animation des binds" and action.Assign then
                    RageUI.Item.Button("Touches n°" .. nameKeyBind, "Supprimer l'animation à cette touche", {RightLabel = ">"}, true, {
                        onSelected = function()
                            ShowAboveRadarMessage("~r~Vous avez supprimé une animations sur la tocuhe: ~b~"..nameKeyBind.."~s~.")
                            AddAnimToKeyBinding(nameKeyBind, false)
                        end
                    })
                end
            end
		end)
        if not RageUI.Visible(menu) and not RageUI.Visible(submenu) and not RageUI.Visible(submenu2) and not RageUI.Visible(submenu3) then
            menu = RMenu:DeleteType('anim', true)
		end
		Citizen.Wait(5)
    end
end

RegisterControlKey("animmenu","Ouvrir le menu des animations (Bind)","F2",function()
	OpenMenuMain()
end)

KeysRegister()




