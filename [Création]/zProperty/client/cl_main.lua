-- Locales
local Multiple = .9
local PosScalform = {(10 * 0.8) * Multiple, (6 * 0.8) * Multiple, 1 * Multiple}

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

-- Functions
function Properties:GetProperties()
    -- Properties.List = {}
    Wait(500)

    ESX.TriggerServerCallback("ESX:getProperties", function(cb) 
        Properties.List = cb
    end)

    return Properties.List
end

RegisterNetEvent("cProperty:ActualizeProperties")
AddEventHandler("cProperty:ActualizeProperties", function(result)
    Properties.List = result

    while not Properties.List or json.encode(Properties.List) == "[]" do 
        Wait(500) 
    end
end)

function Property:CanAccess(v)
    propName = v and v.property_name or Property.Current.Name
    propOwner = v and v.property_owner or Property.Current.Owner
    propIdJobs = v and v.jobs or Property.Current.Jobs_Id
    propIdOrga = v and v.orga or Property.Current.Orga_Id
    propAccess = Property:GetAccess(propName)
    Wait(150) 

    local found = false
    if propAccess then
        for k, v in pairs(propAccess) do
            if v.player_identifier == ESX.PlayerData.identifier then
                found = true
            end
        end
    end

    if propOwner == ESX.PlayerData.identifier then
        found = true
    end

    if propIdJobs then
        if ESX.PlayerData.job.name and ESX.PlayerData.job.name == propIdJobs then 
            found = true
        end
    end

    if propIdOrga and Property.UseClippyOrga then 
        ESX.TriggerServerCallback("cOrga:getOrgaPlyListFromId", function(result) 
            for k, v in pairs(result) do
                if v.identifier == ESX.PlayerData.identifier then
                    found = true
                end
            end
        end, propIdOrga)
    end

    Wait(150)

    return found
end

function Properties:Init()
    Properties:GetProperties()
    -- while not Properties.List or json.encode(Properties.List) == "[]" do Wait(500) end
    -- for k, v in pairs(Properties.List) do
    --     if v.owner then
    --         Properties.Blips[k] = CreateBlips(json.decode(v.garage_pos), 414, 3, "Garage", false, 0.5, nil, nil, v.property_name)
    --         Properties.Blips[k] = CreateBlips(json.decode(v.property_pos), 414, 25, "Propriété", false, 0.5, nil, nil, v.property_name)
    --     end
    -- end
end

function Property:GetInteriorLabel(name)
    for k, v in pairs(Properties.Interiors) do
        if name == v.label then
            return v.name 
        end
    end
end

-- BLIPS INFOS
local BLIP_INFO_DATA = {}


function ensureBlipInfo(blip)
    if blip == nil then blip = 0 end
    SetBlipAsMissionCreatorBlip(blip, true)
    if not BLIP_INFO_DATA[blip] then BLIP_INFO_DATA[blip] = {} end
    if not BLIP_INFO_DATA[blip].title then BLIP_INFO_DATA[blip].title = "" end
    if not BLIP_INFO_DATA[blip].rockstarVerified then BLIP_INFO_DATA[blip].rockstarVerified = false end
    if not BLIP_INFO_DATA[blip].info then BLIP_INFO_DATA[blip].info = {} end
    if not BLIP_INFO_DATA[blip].money then BLIP_INFO_DATA[blip].money = "" end
    if not BLIP_INFO_DATA[blip].rp then BLIP_INFO_DATA[blip].rp = "" end
    if not BLIP_INFO_DATA[blip].dict then BLIP_INFO_DATA[blip].dict = "" end
    if not BLIP_INFO_DATA[blip].tex then BLIP_INFO_DATA[blip].tex = "" end
    return BLIP_INFO_DATA[blip]
end

--[[
    Export functions, use these via an export pls
]]

function ResetBlipInfo(blip)
    BLIP_INFO_DATA[blip] = nil
end

function SetBlipInfoTitle(blip, title, rockstarVerified)
    local data = ensureBlipInfo(blip)
    data.title = title or ""
    data.rockstarVerified = rockstarVerified or false
end

function SetBlipInfoImage(blip, dict, tex)
    local data = ensureBlipInfo(blip)
    data.dict = dict or ""
    data.tex = tex or ""
end

function SetBlipInfoEconomy(blip, rp, money)
    local data = ensureBlipInfo(blip)
    data.money = tostring(money) or ""
    data.rp = tostring(rp) or ""
end

function SetBlipInfo(blip, info)
    local data = ensureBlipInfo(blip)
    data.info = info
end

function AddBlipInfoText(blip, leftText, rightText)
    local data = ensureBlipInfo(blip)
    if rightText then
        table.insert(data.info, {1, leftText or "", rightText or ""})
    else
        table.insert(data.info, {5, leftText or "", ""})
    end
end

function AddBlipInfoName(blip, leftText, rightText)
    local data = ensureBlipInfo(blip)
    table.insert(data.info, {3, leftText or "", rightText or ""})
end

function AddBlipInfoHeader(blip, leftText, rightText)
    local data = ensureBlipInfo(blip)
    table.insert(data.info, {4, leftText or "", rightText or ""})
end

function AddBlipInfoIcon(blip, leftText, rightText, iconId, iconColor, checked)
    local data = ensureBlipInfo(blip)
    table.insert(data.info, {2, leftText or "", rightText or "", iconId or 0, iconColor or 0, checked or false})
end

--[[
    All that fancy decompiled stuff I've kinda figured out
]]

-- local Display = 1
-- function UpdateDisplay()
--     if PushScaleformMovieFunctionN("DISPLAY_DATA_SLOT") then
--         PushScaleformMovieFunctionParameterInt(Display)
--         PopScaleformMovieFunctionVoid()
--     end
-- end

-- function SetColumnState(column, state)
--     if PushScaleformMovieFunctionN("SHOW_COLUMN") then
--         PushScaleformMovieFunctionParameterInt(column)
--         PushScaleformMovieFunctionParameterBool(state)
--         PopScaleformMovieFunctionVoid()
--     end
-- end

-- function ShowDisplay(show)
--     SetColumnState(Display, show)
-- end

-- function func_36(fParam0)
--     BeginTextCommandScaleformString(fParam0)
--     EndTextCommandScaleformString()
-- end

-- function SetIcon(index, title, text, icon, iconColor, completed)
--     if PushScaleformMovieFunctionN("SET_DATA_SLOT") then
--         PushScaleformMovieFunctionParameterInt(Display)
--         PushScaleformMovieFunctionParameterInt(index)
--         PushScaleformMovieFunctionParameterInt(65)
--         PushScaleformMovieFunctionParameterInt(3)
--         PushScaleformMovieFunctionParameterInt(2)
--         PushScaleformMovieFunctionParameterInt(0)
--         PushScaleformMovieFunctionParameterInt(1)
--         func_36(title)
--         func_36(text)
--         PushScaleformMovieFunctionParameterInt(icon)
--         PushScaleformMovieFunctionParameterInt(iconColor)
--         PushScaleformMovieFunctionParameterBool(completed)
--         PopScaleformMovieFunctionVoid()
--     end
-- end

-- function SetText(index, title, text, textType)
--     if PushScaleformMovieFunctionN("SET_DATA_SLOT") then
--         PushScaleformMovieFunctionParameterInt(Display)
--         PushScaleformMovieFunctionParameterInt(index)
--         PushScaleformMovieFunctionParameterInt(65)
--         PushScaleformMovieFunctionParameterInt(3)
--         PushScaleformMovieFunctionParameterInt(textType or 0)
--         PushScaleformMovieFunctionParameterInt(0)
--         PushScaleformMovieFunctionParameterInt(0)
--         func_36(title)
--         func_36(text)
--         PopScaleformMovieFunctionVoid()
--     end
-- end

-- local _labels = 0
-- local _entries = 0
-- function ClearDisplay()
--     if PushScaleformMovieFunctionN("SET_DATA_SLOT_EMPTY") then
--         PushScaleformMovieFunctionParameterInt(Display)
--     end
--     PopScaleformMovieFunctionVoid()
--     _labels = 0
--     _entries = 0
-- end

-- function _label(text)
--     local lbl = "LBL" .. _labels
--     AddTextEntry(lbl, text)
--     _labels = _labels + 1
--     return lbl
-- end

-- function SetTitle(title, rockstarVerified, rp, money, dict, tex)
--     if PushScaleformMovieFunctionN("SET_COLUMN_TITLE") then
--         PushScaleformMovieFunctionParameterInt(Display)
--         func_36("")
--         func_36(_label(title))
--         PushScaleformMovieFunctionParameterInt(rockstarVerified)
--         PushScaleformMovieFunctionParameterString(dict)
--         PushScaleformMovieFunctionParameterString(tex)
--         PushScaleformMovieFunctionParameterInt(0)
--         PushScaleformMovieFunctionParameterInt(0)
--         if rp == "" then
--             PushScaleformMovieFunctionParameterBool(0)
--         else
--             func_36(_label(rp))
--         end
--         if money == "" then
--             PushScaleformMovieFunctionParameterBool(0)
--         else
--             func_36(_label(money))
--         end
--     end
--     PopScaleformMovieFunctionVoid()
-- end

-- function AddText(title, desc, style)
--     SetText(_entries, _label(title), _label(desc), style or 1)
--     _entries = _entries + 1
-- end

-- function AddIcon(title, desc, icon, color, checked)
--     SetIcon(_entries, _label(title), _label(desc), icon, color, checked)
--     _entries = _entries + 1
-- end

-- Citizen.CreateThread(function()
--     local current_blip = nil
--     while true do
--         Wait(0)
--         if N_0x3bab9a4e4f2ff5c7() then
--             local blip = DisableBlipNameForVar()
--             if N_0x4167efe0527d706e() then
--                 if DoesBlipExist(blip) then
--                     if current_blip ~= blip then
--                         current_blip = blip
--                         if BLIP_INFO_DATA[blip] then
--                             local data = ensureBlipInfo(blip)
--                             N_0xec9264727eec0f28()
--                             ClearDisplay()
--                             SetTitle(data.title, data.rockstarVerified, data.rp, data.money, data.dict, data.tex)
--                             for _, info in next, data.info do
--                                 if info[1] == 2 then
--                                     AddIcon(info[2], info[3], info[4], info[5], info[6])
--                                 else
--                                     AddText(info[2], info[3], info[1])
--                                 end
--                             end
--                             ShowDisplay(true)
--                             UpdateDisplay()
--                             N_0x14621bb1df14e2b2()
--                         else
--                             ShowDisplay(false)
--                         end
--                     end
--                 end
--             else
--                 if current_blip then
--                     current_blip = nil
--                     ShowDisplay(false)
--                 end
--             end
--         end
--     end
-- end)

function Property:GetEnterFromType(interior)
    for k, v in pairs(Properties.Interiors) do 
        if v.name == interior then
            return v.enter 
        end
    end
end

function Property:GetChestFromType(interior)
    for k, v in pairs(Properties.Interiors) do 
        if v.name == interior then
            return v.chest 
        end
    end
end

function Property:GetInteriorPrice(interior)
    for k, v in pairs(Properties.Interiors) do 
        if v.name == interior then
            return v.price 
        end
    end
end

function Property:GetEnterFromGarage(max)
    for k, v in pairs(Properties.Garages) do
        if v.Space == max then
            return v.Enter
        end
    end
end

function Property:GetGestionFromGarage(max)
    for k, v in pairs(Properties.Garages) do
        if v.Space == max then
            return v.Gestion or nil
        end
    end
end

function Property:GetSpacesFromGarage(max)
    for k, v in pairs(Properties.Garages) do
        if v.Space == max then
            return v.Spaces
        end
    end
end

function Property:GetMultiplierFromSpace(max)
    for k, v in pairs(Properties.Garages) do
        if v.Space == max then
            return v.Multiplier
        end
    end
end

function Property:GetAccess(name)
    ESX.TriggerServerCallback("ESX:getAccess", function(cb) 
        accessList = cb
    end, name)

    return accessList or {}
end

function Property:GetVehicles(name)
    ESX.TriggerServerCallback("ESX:getVehicles", function(cb) 
        vehiclesList = cb
    end, name)

    Wait(500)
    
    return vehiclesList
end

function CreateEffect(style, default, time) -- Créer un effet
    Citizen.CreateThread(function()
        DoScreenFadeOut(1000)
        Citizen.Wait(1000)
        SetTimecycleModifier(style or "spectator3")
        if default then 
            SetCamEffect(2)
        end
        DoScreenFadeIn(1000)
        Citizen.Wait(time or 20000)
        local pPed = GetPlayerPed(-1)
        DoScreenFadeOut(1000)
        Citizen.Wait(1000)
        DoScreenFadeIn(1000)
        ClearTimecycleModifier()
        ResetScenarioTypesEnabled()
        SetPedIsDrunk(pPed,false)
		SetCamEffect(0)
    end)
end

Property.ObjectsDetails = {
    bong = {
        pretime = 300,
        anim = {"anim@safehouse@bong", "bong_stage1"},
        txt = "pour ~b~utiliser le bong~s~",
        time = 8000,
        func = CreateEffect,
        dynamic = true
    },
    wine = {
        pretime = 300,
        anim = {"mp_safehousewheatgrass@", "ig_2_wheatgrassdrink_michael"},
        txt = "pour ~p~boire du vin~s~",
        time = 8000
    },
    whiskey = {
        pretime = 300,
        anim = {"mp_safehousewheatgrass@", "ig_2_wheatgrassdrink_michael"},
        txt = "pour ~o~boire du whisky~s~",
        time = 8000
    },
    apple = {
        pretime = 300,
        anim = {"mp_safehousewheatgrass@", "ig_2_wheatgrassdrink_michael"},
        txt = "pour ~g~boire du jus de pomme~s~",
        time = 8000
    }
}
Property.PropsInteract = {
    ["prop_bong_01"] = "bong",
    ["prop_bong_02"] = "bong",
    ["prop_sh_bong_01"] = "bong",
    ["hei_heist_sh_bong_01"] = "bong",

    ["p_wine_glass_s"] = "wine",
    ["prop_drink_champ"] = "wine",
    ["prop_drink_redwine"] = "wine",

    ["prop_drink_whtwine"] = "whiskey",
    ["prop_drink_whisky"] = "whiskey",
    ["prop_whiskey_01"] = "whiskey",
    ["p_whiskey_bottle_s"] = "whiskey",
    ["prop_whiskey_bottle"] = "whiskey",
    ["p_whiskey_notop_empty"] = "whiskey",
    ["prop_cs_whiskey_bottle"] = "whiskey",

    ["p_w_grass_gls_s"] = "apple",
    ["prop_wheat_grass_glass"] = "apple",
    ["prop_wheat_grass_half"] = "apple",
}

function TaskPlayAnimToPlayer(a,b,c,d,e)if type(a)~="table"then a={a}end;d,c=d or GetPlayerPed(-1),c and tonumber(c)or false;if not a or not a[1]or string.len(a[1])<1 then return end;if IsEntityPlayingAnim(d,a[1],a[2],3)or IsPedActiveInScenario(d)then ClearPedTasks(d)return end;Citizen.CreateThread(function()TaskForceAnimPlayer(a,c,{ped=d,time=b,pos=e})end)end;local f={"WORLD_HUMAN_MUSICIAN","WORLD_HUMAN_CLIPBOARD"}local g={["WORLD_HUMAN_BUM_WASH"]={"amb@world_human_bum_wash@male@high@idle_a","idle_a"},["WORLD_HUMAN_SIT_UPS"]={"amb@world_human_sit_ups@male@idle_a","idle_a"},["WORLD_HUMAN_PUSH_UPS"]={"amb@world_human_push_ups@male@base","base"},["WORLD_HUMAN_BUM_FREEWAY"]={"amb@world_human_bum_freeway@male@base","base"},["WORLD_HUMAN_CLIPBOARD"]={"amb@world_human_clipboard@male@base","base"},["WORLD_HUMAN_VEHICLE_MECHANIC"]={"amb@world_human_vehicle_mechanic@male@base","base"}}function TaskForceAnimPlayer(a,c,h)c,h=c and tonumber(c)or false,h or{}local d,b,i,j,k,l=h.ped or GetPlayerPed(-1),h.time,h.clearTasks,h.pos,h.ang;if IsPedInAnyVehicle(d)and(not c or c<40)then return end;if not i then ClearPedTasks(d)end;if not a[2]and g[a[1]]and GetEntityModel(d)==-1667301416 then a=g[a[1]]end;if a[2]and not HasAnimDictLoaded(a[1])then if not DoesAnimDictExist(a[1])then return end;RequestAnimDict(a[1])while not HasAnimDictLoaded(a[1])do Citizen.Wait(10)end end;if not a[2]then ClearAreaOfObjects(GetEntityCoords(d),1.0)TaskStartScenarioInPlace(d,a[1],-1,not TableHasValue(f,a[1]))else if not j then TaskPlayAnim(d,a[1],a[2],8.0,-8.0,-1,c or 44,1,0,0,0,0)else TaskPlayAnimAdvanced(d,a[1],a[2],j.x,j.y,j.z,k.x,k.y,k.z,8.0,-8.0,-1,1,1,0,0,0)end end;if b and type(b)=="number"then Citizen.Wait(b)ClearPedTasks(d)end;if not h.dict then RemoveAnimDict(a[1])end end;function TableHasValue(m,n,o)if not m or not n or type(m)~="table"then return end;for p,q in pairs(m)do if o and q[o]==n or q==n then return true,p end end end

-- Blips
function CreateBlips(vector3Pos, intSprite, intColor, stringText, boolRoad, floatScale, intDisplay, intAlpha, Title, Image, InfoName, Texts, InfoText, Header) -- Créer un blips
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
    if Title then
        SetBlipInfoTitle(blip, Title, false)
    end
    if Image then
        RequestStreamedTextureDict(Image[1], 1)
        while not HasStreamedTextureDictLoaded(Image[1]) do
            Wait(0)
        end
    
        SetBlipInfoImage(blip, Image[1], Image[2])
    end
    if InfoName then
        AddBlipInfoName(blip, InfoName[1], InfoName[2])
    end
    if Texts then
        for k, v in pairs (Texts) do
            AddBlipInfoText(blip, v[1], v[2])
        end
    end
    if InfoText then
        AddBlipInfoText(blip, InfoText)
    end
    if Header then
        AddBlipInfoHeader(blip, "") 
    end
	return blip
end

-- Objects player
function AttachObjectToHandsPeds(ped, hash, timer, rot, bone, dynamic) -- Attach un props sur la main d'un ped
    if props and DoesEntityExist(props)then 
        DeleteEntity(props)
    end
    props = CreateObject(GetHashKey(hash), GetEntityCoords(ped), not dynamic)
    AttachEntityToEntity(props, ped, GetPedBoneIndex(ped, bone and 60309 or 28422), 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, true, true, false, true, 1, not rot)
    if timer then 
        Citizen.Wait(timer)
        if props and DoesEntityExist(props)then 
            DeleteEntity(props)
        end
    	ClearPedTasks(ped)
    end
    return props
end

Property.isInAnim = fasle

function Property:UseProps(k, table, obj)
    local pPed = PlayerPedId()
    if table.anim then
        Property.isInAnim = true 
        TaskPlayAnimToPlayer(table.anim)
        FreezeEntityPosition(pPed, true)
        local ObjectAttach
        Citizen.Wait(table.pretime or 0)
        SetEntityVisible(obj, false)
        if k then
            ObjectAttach = AttachObjectToHandsPeds(pPed, k, nil, nil, table.dynamic)
        end
        Citizen.Wait(table.time or 5000)
        if table.func then
            table.func()
        end
        if ObjectAttach and DoesEntityExist(ObjectAttach) then
            DeleteEntity(ObjectAttach)
        end
        FreezeEntityPosition(pPed, false)
        SetEntityVisible(obj, true)
        Property.isInAnim = false 
    else
        if table.func then
            table.func()
        end
    end
end

function Property:Visit()
    local Player = PlayerPedId()
    Property.LastPos = GetEntityCoords(Player)
    Property.Current.Enter = Property:GetEnterFromType(Property.Current.Interior)
    Property.Current.Chest = Property:GetChestFromType(Property.Current.Interior)

    Property.Current.Ipl = GetInteriorAtCoords(Property.Current.Enter)
    if Property.Current.Ipl then LoadInterior(Property.Current.Ipl) end

    Property:TeleportCoords(Property.Current.Enter, Player)
    Property:StartInstance()
    Property.IsInProperty = true

    while Property.IsInProperty do
        local time = 1000
        if Vdist2(GetEntityCoords(Player), vector3(Property.Current.Enter.x, Property.Current.Enter.y, Property.Current.Enter.z)) <= 5.0 then
            ESX.ShowHelpNotification("Appuyez sur ~INPUT_CONTEXT~ pour ~r~sortir~s~.")

            if IsControlJustReleased(0, 51) then
                DoScreenFadeOut(1000)
                Wait(1000)        
                Property:Exit()
                Wait(200)
            end
            time = 5
        end

        for k, v in pairs(Property.PropsInteract) do
            local object = GetClosestObjectOfType(GetEntityCoords(Player), 1.0, GetHashKey(k), false, true, true)
            if object and DoesEntityExist(object) and GetDistanceBetweenCoords(GetEntityCoords(Player), GetEntityCoords(object), true) < 1.0 and Property.ObjectsDetails[v] and not Property.isInAnim then
                time = 5 
                ESX.ShowHelpNotification("Appuyez sur ~INPUT_CONTEXT~ ~s~"..Property.ObjectsDetails[v].txt.."~s~.")
                if IsControlJustPressed(0, 51) then 
                    RequestControl(object)
                    Property:UseProps(k, Property.ObjectsDetails[v], object)
                end
            end
        end

        Wait(time)
    end
end

function Property:Enter()
    local Player = PlayerPedId()
    Property.LastPos = GetEntityCoords(Player)
    Property.Current.Enter = Property:GetEnterFromType(Property.Current.Interior)
    Property.Current.Chest = Property:GetChestFromType(Property.Current.Interior)
    TriggerServerEvent('ESX:SavePlayer') 

    Property:TeleportCoords(Property.Current.Enter, Player)
    Property.IsInProperty = true
    Property:StartInstance()
    Wait(500)
    DoScreenFadeIn(1000)

    Citizen.CreateThread(function()
        while Property.IsInProperty do
            local time = 1000
            if Vdist(GetEntityCoords(Player), vector3(Property.Current.Enter.x, Property.Current.Enter.y, Property.Current.Enter.z)) <= 2.5 then
                ESX.ShowHelpNotification("Appuyez sur ~INPUT_CONTEXT~ pour ~r~sortir~s~.")
                if IsControlJustReleased(0, 51) then
                    DoScreenFadeOut(1000)
                    Wait(1000)        
                    Property:Exit()
                    Wait(200)
                end
                time = 5
            end

            if Vdist(GetEntityCoords(Player), vector3(Property.Current.Chest.x, Property.Current.Chest.y, Property.Current.Chest.z+1)) <= 2.5 then
                ESX.ShowHelpNotification("Appuyez sur ~INPUT_CONTEXT~ pour ~b~ouvrir~s~ le ~b~coffre~s~.")

                if IsControlJustReleased(0, 51) then
                    if Property.UseClippyOrga then
                        if Property.Current.Orga_Id then 
                            if Orga.Perms.see_chest then 
                                Property:OpenChest()
                                Wait(200)
                            else
                                ESX.ShowNotification("~r~Vous n'avez pas les permissions d'ouvrir le coffre.")
                            end
                        else
                            Property:OpenChest()
                            Wait(200)
                        end
                    else
                        Property:OpenChest()
                        Wait(200)
                    end
                end
                time = 5
            end

            for k, v in pairs(Property.PropsInteract) do
                local object = GetClosestObjectOfType(GetEntityCoords(Player), 1.0, GetHashKey(k), false, true, true)
                if object and DoesEntityExist(object) and GetDistanceBetweenCoords(GetEntityCoords(Player), GetEntityCoords(object), true) < 1.0 and Property.ObjectsDetails[v] and not Property.isInAnim then
                    time = 5 
                    ESX.ShowHelpNotification("Appuyez sur ~INPUT_CONTEXT~ ~s~"..Property.ObjectsDetails[v].txt.."~s~.")

                    if IsControlJustPressed(0, 51) then 
                        RequestControl(object)
                        Property:UseProps(k, Property.ObjectsDetails[v], object)
                    end
                end
            end
    
            Wait(time)
        end    
    end)
end

function Property:OpenChest()
    OpenPropertyChest("property_" .. Property.Current.Id, Property.Current.ChestMax, Property.Current.Name)
end

function Property:EnterGarage()
    local Player = PlayerPedId()
    Property.LastPos = GetEntityCoords(Player)
    Property:TeleportCoords(Property.Current.Garage.Enter, Player)
    Property.IsInGarage = true
    Property.Current.Garage.Vehicles = Property:GetVehicles(Property.Current.Name)
    Wait(500)
    Property.Current.Garage.Vehicles = Property:GetVehicles(Property.Current.Name)
    Property:StartInstance()
    DoScreenFadeIn(1000)

    Citizen.CreateThread(function()
        Property.Current.Garage.SpawnedVehicles = {}
        Property.Current.Garage.Vehicle = {}
        for k, v in pairs(Property.Current.Garage.Spaces) do
            if Property.Current.Garage.Vehicles[k] then
                Property:SpawnVehicles(k, v)
            end    
        end

        while Property.IsInGarage do
            local time = 1000
            if Vdist(GetEntityCoords(Player), vector3(Property.Current.Garage.Enter.x, Property.Current.Garage.Enter.y, Property.Current.Garage.Enter.z)) <= 2.5 then
                ESX.ShowHelpNotification("Appuyez sur ~INPUT_CONTEXT~ pour ~r~sortir~s~.")

                if IsControlJustReleased(0, 51) then
                    DoScreenFadeOut(1000)
                    Wait(1000)
                    Property:Exit()
                end
                time = 5
            end
            
            if Property.Current.Garage.Gestion then
                if Vdist(GetEntityCoords(Player), vector3(Property.Current.Garage.Gestion.x, Property.Current.Garage.Gestion.y, Property.Current.Garage.Gestion.z)) <= 2.5 then
                    ESX.ShowHelpNotification("Appuyez sur ~INPUT_CONTEXT~ pour ~b~ouvrir~s~ le ~b~menu de gestion~s~.")

                    if IsControlJustReleased(0, 51) then
                        Property:OpenGestionGarageMenu()
                    end
                    time = 5
                end
            end
            

            for k, v in pairs(Property.Current.Garage.Spaces) do
                if Vdist2(GetEntityCoords(Player), vector3(v.x, v.y, v.z)) <= 3.0 then
                    if Property.Current.Garage.Vehicles[k] then
                        Property:DrawVehicleDatas(Property.Current.Garage.Vehicle[k], k)
                        if IsPedInAnyVehicle(Player, false) then
                            if Property.UseClippyOrga then 
                                if Property.Current.Orga_Id then 
                                    if Orga.Perms.take_car then 
                                        Property:VehicleOut(k)
                                        Wait(500)
                                        CloseMenu(true)
                                    else
                                        ESX.ShowNotification("~r~Vous n'avez pas les permissions pour sortir un véhicule.")
                                    end
                                else 
                                    Property:VehicleOut(k)
                                    Wait(500)
                                    CloseMenu(true)
                                end
                            else
                                Property:VehicleOut(k)
                                Wait(500)
                                CloseMenu(true)
                            end
                        end
                    end
                    time = 5
                else
                    if Property.ScalformGarage[k] then 
                        if HasScaleformMovieLoaded(Property.ScalformGarage[k]) then
                            SetScaleformMovieAsNoLongerNeeded(Property.ScalformGarage[k])
                            Property.ScalformGarage[k] = nil
                        end
                    end
                end
            end

            Wait(time)
        end
    end)
end

function Property:CreateVehicle(modelName, coords, heading, cb)
	local model = (type(modelName) == 'number' and modelName or GetHashKey(modelName))

	if not IsModelValid(model) or not IsModelInCdimage(model) then ShowNotification("~r~Ce modèle de véhicule n'éxiste pas ("..model.." / "..modelName..")") return end

	local ped = PlayerPedId()

	ESX.Streaming.RequestModel(model)
	local vehicle = CreateVehicle(model, coords.x, coords.y, coords.z, heading, true, false, 3)
	local id = NetworkGetNetworkIdFromEntity(vehicle)
	SetNetworkIdCanMigrate(id, true)
	SetEntityAsMissionEntity(vehicle, true, false)
	SetVehicleHasBeenOwnedByPlayer(vehicle, true)
	SetVehicleNeedsToBeHotwired(vehicle, false)
	SetVehicleOnGroundProperly(vehicle)
	SetModelAsNoLongerNeeded(model)
	SetVehicleRadioLoud(vehicle, true)
	SetDisableVehiclePetrolTankFires(vehicle, true)
	SetVehicleCanLeakOil(vehicle, true)
	SetVehicleCanLeakPetrol(vehicle, true)
	local has, wep = GetCurrentPedVehicleWeapon(ped)
	if has then DisableVehicleWeapon(true, wep, vehicle, ped) end
	local netID
	--if not blLocal then
		local start = GetGameTimer()
		netID = NetworkGetNetworkIdFromEntity(vehicle)
		while (not netID or not NetworkDoesNetworkIdExist(netID)) and start + 5000 > GetGameTimer() and DoesEntityExist(vehicle) do
			Citizen.Wait(1000)
			NetworkRegisterEntityAsNetworked(vehicle)
			netID = NetworkGetNetworkIdFromEntity(vehicle)
		end
		if not netID then
			ShowNotification("~r~Ce véhicule ne possède pas de NetID", "danger")
			return
		end
		SetNetworkIdExistsOnAllMachines(netID, true)
	--end
	local maxFuel = math.floor(GetVehicleHandlingFloat(vehicle, "CHandlingData", "fPetrolTankVolume"))
	SetVehicleFuelLevel(vehicle, math.floor(maxFuel / 2) + 0.0)
	RequestCollisionAtCoord(coords.x, coords.y, coords.z)
	while not HasCollisionLoadedAroundEntity(vehicle) do
		RequestCollisionAtCoord(coords.x, coords.y, coords.z)
		Citizen.Wait(0)
	end
	return vehicle
end

function Property:DeleteVehicle(vehicle)
	SetEntityAsMissionEntity(vehicle, false, true)
	DeleteVehicle(vehicle)
end

function Property:Exit(vehProps)
    Property:StopInstance()
    if Property.Current.Garage.SpawnedVehicles then
        for k, v in pairs(Property.Current.Garage.SpawnedVehicles) do
            Property:DeleteVehicle(v)
        end
    end
    Property.IsInProperty = false
    Property.IsInGarage = false
    local Player = PlayerPedId()
    Property:TeleportCoords(Property.LastPos, Player)
    while Vdist(GetEntityCoords(Player), vector3(Property.LastPos.x, Property.LastPos.y, Property.LastPos.z)) >= 10.0 do 
        Wait(0)
    end
    Wait(500)
    if vehProps then
        local vehicle = Property:CreateVehicle(vehProps.model, vector3(Property.LastPos.x, Property.LastPos.y, Property.LastPos.z), GetEntityHeading(Player))

        Property:SetVehicleProperties(vehicle, vehProps)
        TaskWarpPedIntoVehicle(Player, vehicle, -1)
    end
    Wait(500)
    DoScreenFadeIn(1000)
end

-- Scalforms
function SetScaleformParams(scaleform, data) -- Set des éléments dans un scalform
	data = data or {}
	for k,v in pairs(data) do
		PushScaleformMovieFunction(scaleform, v.name)
		if v.param then
			for _,par in pairs(v.param) do
				if math.type(par) == "integer" then
					PushScaleformMovieFunctionParameterInt(par)
				elseif type(par) == "boolean" then
					PushScaleformMovieFunctionParameterBool(par)
				elseif math.type(par) == "float" then
					PushScaleformMovieFunctionParameterFloat(par)
				elseif type(par) == "string" then
					PushScaleformMovieFunctionParameterString(par)
				end
			end
		end
		if v.func then v.func() end
		PopScaleformMovieFunctionVoid()
	end
end
function CreateScaleform(name, data) -- Créer un scalform
	if not name or string.len(name) <= 0 then return end
	local scaleform = RequestScaleformMovie(name)

	while not HasScaleformMovieLoaded(scaleform) do
		Citizen.Wait(0)
	end

	SetScaleformParams(scaleform, data)
	return scaleform
end

function GetVehicleHealth(entityVeh) -- Get la vie d'un moteur (0-100%)
	return math.floor( math.max(0, math.min(100, GetVehicleEngineHealth(entityVeh) / 10 ) ) )
end

function CreateVehicleStatsScaleformLsCustoms(cars)
    local VehicleModel = GetEntityModel(cars)
    local VehicleSpeed = GetVehicleEstimatedMaxSpeed(cars) * 1.25
    local VehicleAcceleration = GetVehicleAcceleration(cars) * 200
    local VehicleBraking = GetVehicleMaxBraking(cars) * 100
    local VehicleTraction = GetVehicleMaxTraction(cars) * 25
    local VehicleHealth = GetVehicleHealth(cars)
    return CreateScaleform("mp_car_stats_01", {{
        name = "SET_VEHICLE_INFOR_AND_STATS",
        param = {GetLabelText(GetDisplayNameFromVehicleModel(VehicleModel)), "État du véhicule: "..VehicleHealth.."%", "MPCarHUD","Annis", "Vitesse max", "Accélération", "Frein", "Suspension", VehicleSpeed, VehicleAcceleration, VehicleBraking, VehicleTraction}
    }})
end

function Property:SpawnLocalVehicle(modelName, coords, heading, cb)
	local model = (type(modelName) == 'number' and modelName or GetHashKey(modelName))

	Citizen.CreateThread(function()
		ESX.Streaming.RequestModel(model)

		local vehicle = CreateVehicle(model, coords.x, coords.y, coords.z, heading, false, false)

		SetEntityAsMissionEntity(vehicle, true, false)
		SetVehicleHasBeenOwnedByPlayer(vehicle, true)
		SetVehicleNeedsToBeHotwired(vehicle, false)
		SetModelAsNoLongerNeeded(model)
		RequestCollisionAtCoord(coords.x, coords.y, coords.z)

		while not HasCollisionLoadedAroundEntity(vehicle) do
			RequestCollisionAtCoord(coords.x, coords.y, coords.z)
			Citizen.Wait(100) --base 0
		end

		SetVehRadioStation(vehicle, 'OFF')

		if cb ~= nil then
			cb(vehicle)
		end
	end)
end

function Property:SpawnVehicles(k, v)
    local vehProps = json.decode(Property.Current.Garage.Vehicles[k].vehicle_property)
    Property:SpawnLocalVehicle(vehProps.model, vector3(v.x, v.y, v.z+1), v.w, function(vehicle)
        Property:SetVehicleProperties(vehicle, vehProps)
        table.insert(Property.Current.Garage.SpawnedVehicles, vehicle)
        Property.Current.Garage.Vehicle[k] = vehicle
    end)
end

DrawCenterText = function(msg, time)
	ClearPrints()
	SetTextEntry_2("STRING2")
	AddTextComponentString(msg)
	DrawSubtitleTimed(time and math.ceil(time) or 0, true)
end

function Property:DrawVehicleDatas(vehicle, k)
    local vehProps = json.decode(Property.Current.Garage.Vehicles[k].vehicle_property)
    local vehName = GetLabelText(GetDisplayNameFromVehicleModel(vehProps.model))
    if not Property.ScalformGarage[k] then 
        Property.ScalformGarage[k] = CreateVehicleStatsScaleformLsCustoms(vehicle)
    end
    local vPos = GetEntityCoords(vehicle)
    local vHeight = GetEntityHeight(vehicle, vPos.x, vPos.y, vPos.z, true, false)
    if Property.ScalformGarage[k] and HasScaleformMovieLoaded(Property.ScalformGarage[k]) then
        DrawScaleformMovie_3dNonAdditive(Property.ScalformGarage[k], vPos.x, vPos.y, vPos.z + 2.4 + vHeight, GetGameplayCamRot(0), 0.0,1.0, 0.0, PosScalform[1], PosScalform[2], PosScalform[3], 0)
    end
    DrawCenterText("Rentrez dans le véhicule pour ~b~sortir~s~.", 50)
end

function Property:VehicleOut(k)
    local Player = PlayerPedId()
    local vehProps = json.decode(Property.Current.Garage.Vehicles[k].vehicle_property)
    if IsAnyVehicleNearPoint(Property.LastPos.x, Property.LastPos.y, Property.LastPos.z, 5.0) then 
        ESX.ShowNotification("~r~Un véhicule bloque la sortie.") 
    else
        DoScreenFadeOut(1000)
        Wait(1000)        
        local vehicle = GetVehiclePedIsIn(Player, false)
        local vehicleProps = ESX.Game.GetVehicleProperties(vehicle) 
        local plate = vehicleProps.plate 
        local state = 0
        TriggerServerEvent('esx_advancedgarage:setVehicleState', plate, state)
        Wait(150)
        TriggerServerEvent("ESX:vehicleOutGarage", Property.Current.Garage.Vehicles[k].id_vehicle, Property.Current.Id)
        Property:Exit(vehProps)
    end 
end

function Property:StartInstance()
    local Player = PlayerPedId()
    TriggerServerEvent("ESX:initInstance", Property.Current.Id)
    Property.IsInInstance = true
end

function Property:StopInstance()
    local Player = PlayerPedId()
    TriggerServerEvent("ESX:outInstance", Property.Current.Id)
    for k, v in pairs(GetActivePlayers()) do 
        if v ~= GetPlayerIndex() then      
            NetworkConcealPlayer(v, false, false) 
        end
    end
    Property.IsInInstance = false
end

function Property:PayBank(money)
    local hasEnough = false
    ESX.TriggerServerCallback("ESX:PayBank", function(hasMoney)
        if not hasMoney then
            ESX.ShowNotification("~r~Vous n'avez pas assez d'argent.")
        end
        hasEnough = hasMoney
    end, money)
    Wait(250)

    return hasEnough
end

function Property:OpenVisitMenu()
    local job = ESX.PlayerData.job and ESX.PlayerData.job.name
    Property.Menus.Visit = {
        Base = { Title = "", Header = {"commonmenu", "interaction_bgd"} },
        Data = { currentMenu = "Propriété" },
        Events = {
            onSelected = function(self, menuData, btnData, currentSlt, allButtons)
                local slide = btnData.slidenum
                local btn = btnData.name
                local Player = PlayerPedId()
                
                if btn == "Visiter la propriété" then
                    Property:Visit()
                    CloseMenu(true)
                elseif btn == "Louer cette propriété" then
                    local hasMoney = Property:PayBank(btnData.price)
                    if hasMoney then TriggerServerEvent("ESX:updateProperty", Property.Current.Name, "rented") end
                    Wait(500)
                    CloseMenu(true)
                elseif btn == "Acheter cette propriété" then
                    local hasMoney = Property:PayBank(btnData.price)
                    if hasMoney then TriggerServerEvent("ESX:updateProperty", Property.Current.Name, "bought") end
                    Wait(500)
                    CloseMenu(true)
                elseif btn == "~r~Supprimer cette propriété" then
                    AskEntry(function(msg)
                        if not msg or msg == "" then return ESX.ShowNotification("~r~Entrée invalide.") end
                        if msg ~= Property.Current.Name then return ESX.ShowNotification("~r~Nom invalide, rééssayez.") end

                        TriggerServerEvent("ESX:deleteProperty", Property.Current.Name)
                        CloseMenu(true)
                    end, "~b~" .. Property.Current.Name .. "~s~ - Insérez le nom de la ~b~propriété~s~pour continuer")
                end
            end,
        },
        Menu = {
            ["Propriété"] = {
                b = function()
                    local tblMenu = {
                        { name = "Visiter la propriété" }
                    }
                    local Player = PlayerPedId()

                    if job == Property.JobRequired then
                        tblMenu[#tblMenu+1] = { name = "Louer cette propriété", price = Property.Current.Price }
                        tblMenu[#tblMenu+1] = { name = "Acheter cette propriété", price = Property.Current.Price * 40 }
                        tblMenu[#tblMenu+1] = { name = "~r~Supprimer cette propriété" }
                    end

                    return tblMenu
                end,
            },
        }
    }

    Property.Menus.Visit.Base.Title = Property.Current.Name
    CreateMenu(Property.Menus.Visit)
end

GetPlayers = function()
	local players = {}

	for _,player in ipairs(GetActivePlayers()) do
		local ped = GetPlayerPed(player)

		if DoesEntityExist(ped) then
			table.insert(players, player)
		end
	end

	return players
end

function GetClosestPlayer(radius)
    local players = GetPlayers()
    local closestDistance = -1
    local closestPlayer = -1
    local ply = GetPlayerPed(-1)
    local plyCoords = GetEntityCoords(ply, 0)

    for index,value in ipairs(players) do
        local target = GetPlayerPed(value)
        if(target ~= ply) then
            local targetCoords = GetEntityCoords(GetPlayerPed(value), 0)
            local distance = GetDistanceBetweenCoords(targetCoords['x'], targetCoords['y'], targetCoords['z'], plyCoords['x'], plyCoords['y'], plyCoords['z'], true)
            if(closestDistance == -1 or closestDistance > distance) then
                closestPlayer = value
                closestDistance = distance
            end
        end
    end

	if closestDistance <= radius then
		return closestPlayer
	else
		return nil
	end
end

function Property:OpenOwnedMenu()
    local job = ESX.PlayerData.job and ESX.PlayerData.job.name
    Property.Menus.Owned = {
        Base = { Title = "", Header = {"commonmenu", "interaction_bgd"} },
        Data = { currentMenu = "Propriété" },
        Events = {
            onSlide = function(menuData, btnData, currentSlt, self)
                local currentMenu = menuData.currentMenu
                local slide = btnData.slidenum
                local btn = btnData.name

                if btn == "Modifier l'intérieur" then
                    Property.Interior.Name = Properties.Interiors[slide].name
                    Property.Interior.Price = Properties.Interiors[slide].price
                    btnData.sprite = Property.Interior.Name
                end
            end,
            onSelected = function(self, menuData, btnData, currentSlt, allButtons)
                local slide = btnData.slidenum
                local btn = btnData.name
                
                if btn == "Entrer ici" then
                    DoScreenFadeOut(1000)
                    Wait(1000)
                    Property:Enter()
                    CloseMenu(true)
                elseif btn == "Sonner ici" then
                    CloseMenu(true)
                    Property.Ringed = Property.Current
                    TriggerServerEvent("ESX:ringProperty", Property:GetAccess(Property.Current.Name), Property.Current.Owner, Property.Current.Name)
                elseif btn == "Attribuer cette propriété" then
                    local closestPly = GetClosestPlayer(3)
                    if closestPly and closestPly ~= -1 then
                        TriggerServerEvent("ESX:updateProperty", Property.Current.Name, Property.Current.Status, GetPlayerServerId(closestPly))
                        CloseMenu(true)
                    else
                        ESX.ShowNotification("~r~Il n'y a personne a proximité de vous.")
                    end    
                elseif btn == "Modifier l'intérieur" then
                    Property.Interior.Name = Properties.Interiors[slide].name
                    Property.Interior.Price = Properties.Interiors[slide].price

                    Property.Price = Property.Interior.Price * (Property:GetMultiplierFromSpace(Property.Current.Garage.Max))

                    TriggerServerEvent("ESX:updatePropertyInterior", Property.Current.Name, Property.Price, Property.Interior.Name)
                    CloseMenu(true)
                elseif btn == "Modifier le garage" then
                    Property.Garage.Max = Properties.Garages[slide].Space
                    Property.Garage.Multiplier = Properties.Garages[slide].Multiplier

                    Property.Price = Property:GetInteriorPrice(Property.Current.Interior) * (Properties.Garages[slide].Multiplier or 1)

                    TriggerServerEvent("ESX:updatePropertyGarage", Property.Current.Name, Property.Price, Property.Garage.Max)
                    CloseMenu(true)
                elseif btn == "Modifier le poids du coffre" then
                    Property.MaxChest.Max = Properties.MaxChest[slide].Max
                    Property.MaxChest.Multiplier = Properties.MaxChest[slide].Mutliplier

                    Property.Price = Property:GetInteriorPrice(Property.Current.Interior) * (Properties.MaxChest[slide].Multiplier or 1)

                    TriggerServerEvent("ESX:updatePropertyPoids", Property.Current.Name, Property.Price, Property.MaxChest.Max)
                    CloseMenu(true)
                elseif btn == "~r~Supprimer cette propriété" then
                    AskEntry(function(msg)
                        if not msg or msg == "" then return ESX.ShowNotification("~r~Entrée invalide.") end
                        if msg ~= Property.Current.Name then return ESX.ShowNotification("~r~Nom invalide, rééssayez.") end

                        TriggerServerEvent("ESX:deleteProperty", Property.Current.Name)
                        CloseMenu(true)
                    end, "~b~" .. Property.Current.Name .. "~s~ - Insérez le nom de la ~b~propriété~s~pour continuer")
                end
            end,
        },
        Menu = {
            ["Propriété"] = {
                b = function()
                    local tblMenu = {}
                    local Player = PlayerPedId()

                    tblMenu[#tblMenu+1] = Property:CanAccess() and { name = "Entrer ici" } or { name = "Sonner ici" }
                    if job == Property.JobRequired then
                        tblMenu[#tblMenu+1] = { name = "Attribuer cette propriété"}
                        tblMenu[#tblMenu+1] = { name = "~r~Supprimer cette propriété" }
                        tblMenu[#tblMenu+1] = { name = "Modifier l'intérieur", slidemax = Properties.Interior:GetSlideMaxFromConfig(), sprite = "Appartement1", Description = "Appuyez sur ~b~ENTRER ~s~pour valider." }
                        tblMenu[#tblMenu+1] = { name = "Modifier le garage", slidemax = Properties.Garage:GetSlideMaxFromConfig(), Description = "Appuyez sur ~b~ENTRER ~s~pour valider." }
                        tblMenu[#tblMenu+1] = { name = "Modifier le poids du coffre", slidemax = Properties.MaxChest:GetSlideMaxFromConfig(), Description = "Appuyez sur ~b~ENTRER ~s~pour valider." }
                    end

                    return tblMenu
                end,
            },
        }
    }
    
    Property.Menus.Owned.Base.Title = Property.Current.Name
    CreateMenu(Property.Menus.Owned)
end

function Property:OpenHouseMenu()
    local job = ESX.PlayerData.job and ESX.PlayerData.job.name
    Property.Menus.House = {
        Base = { Title = "", Header = {"commonmenu", "interaction_bgd"} },
        Data = { currentMenu = "Propriété" },
        Events = {
            onOpened = function()
                if Property.UseClippyOrga then 
                    if not Orga:GetOrgaFromPlayer() then return end
                    Orga:GetPerms()
                end
            end,
            onSelected = function(self, menuData, btnData, currentSlt, allButtons)
                local slide = btnData.slidenum
                local btn = btnData.name
                local result = GetOnscreenKeyboardResult()

                if self.Data.currentMenu == "locataires" then
                    if btn == "~g~Ajouter un locataire" then
                        local closestPly = GetClosestPlayer(3)
                        if closestPly and closestPly ~= -1 then
                            TriggerServerEvent("ESX:addAccess", Property.Current.Id, GetPlayerServerId(closestPly), Property.Current.Name)
                            CloseMenu(true)
                            Wait(500)
                            Property.Current.Access = Property:GetAccess(Property.Current.Name)
                        else
                            ESX.ShowNotification("~r~Il n'y a personne a proximité de vous.")
                        end        
                    else
                        TriggerServerEvent("ESX:deleteAccess", btnData.identifier, Property.Current.Name)
                        ESX.ShowNotification("~r~Vous avez supprimé " .. btn .. "de votre propriété.")
                        Wait(500)
                        Property.Current.Access = Property:GetAccess(Property.Current.Name)
                    end
                end
    
                if btn == "Nom de la propriété" then
                    if result == "" or not result then return ESX.ShowNotification("~r~Entrée invalide.") end

                    TriggerServerEvent("ESX:updatePropertyName", Property.Current.Name, result)
                    Property.Current.Name = result
                elseif btn == "Voir la caméra" then
                    CloseMenu(true)
                    Property:ShowCamera()
                elseif btn == "Attribuer la propriété" then
                    local closestPly = GetClosestPlayer(3)
                    if closestPly and closestPly ~= -1 then
                        TriggerServerEvent("ESX:updateProperty", Property.Current.Name, Property.Current.Status, GetPlayerServerId(closestPly))
                        CloseMenu(true)
                    else
                        ESX.ShowNotification("~r~Il n'y a personne a proximité de vous.")
                    end    
                elseif btn == "Attribuer la propriété à mon Métier" then
                    if job == nil then return end 
                    local can = true 
                    for k,v in pairs(Property.JobCantAttribute) do 
                        if job == v then 
                            ESX.ShowNotification("~r~Vous ne pouvez pas attribuer cette propriété a votre métier.")
                            can = false 
                            break
                        end
                    end

                    if not can then return end

                    TriggerServerEvent("ESX:attributePropertyToJob", Property.Current.Name, job)
                elseif btn == "Attribuer la propriété à mon Orga" then 
                    --ESX.ShowNotification("TEST")
                    if not Property.UseClippyOrga then return end
                    if not Orga.Perms.attribute_property then return ESX.ShowNotification("~r~Vous ne pouvez pas faire cela.") end

                    TriggerServerEvent("ESX:attributePropertyToOrga", Property.Current.Name, Orga.PlyData.id_orga)
                end
            end,
        },
        Menu = {
            ["Propriété"] = {
                b = {
                    { name = "Nom de la propriété", ask = function() return Property.Current.Name end },
                    { name = "Locataires", ask = ">", askX = true },
                    { name = "Attribuer la propriété", canSee = function() return Config.UseClippyOrga and (Property.Current.Orga_Id and Orga.Perms.attribute_property or true) or true end },
                    { name = "Attribuer la propriété à mon Métier", canSee = function() return Config.UseClippyOrga and (Property.Current.Orga_Id and Orga.Perms.attribute_property or true) or true end },
                    { name = "Attribuer la propriété à mon Orga", canSee = function() return Property.UseClippyOrga and Orga:GetOrgaFromPlayer() ~= nil end},
                }
            },
            ["locataires"] = {
                b = function()
                    local tblAccess = {
                        { name = "~g~Ajouter un locataire", Description = "Ajouter la personne en face de vous en locataire.", canSee = function() return Config.UseClippyOrga and (Property.Current.Orga_Id and Orga.Perms.give_access_property or true) or true end }
                    }
                    Property.Current.Access = Property:GetAccess(Property.Current.Name)
                    Wait(500) 

                    for k, v in pairs(Property.Current.Access) do
                        tblAccess[#tblAccess+1] = { name = v.player_name, identifier = v.player_identifier, Descrption = "Appuyez sur ~b~ENTRER ~s~pour retirer l'accès à " .. v.player_name .. "." }
                    end

                    return tblAccess
                end
            }
        }
    }

    Property.Menus.House.Base.Title = Property.Current.Name
    CreateMenu(Property.Menus.House)
end

function Property:OpenGestionGarageMenu()
    Property.Menus.GarageGestion = {
        Base = { Title = "", Header = {"commonmenu", "interaction_bgd"} },
        Data = { currentMenu = "Gestion véhicules" },
        Events = {
            onSelected = function(self, menuData, btnData, currentSlt, allButtons)
                local slide = btnData.slidenum
                local btn = btnData.name
                
                if btn ~= "Places restantes" then
                    if Property.UseClippyOrga then 
                        if Property.Current.Orga_Id then 
                            if Orga.Perms.take_car then 
                                Property:VehicleOut(btnData.i)
                                Wait(500)
                                CloseMenu(true)
                            else
                                ESX.ShowNotification("~r~Vous n'avez pas les permissions pour sortir un véhicule.")
                            end
                        else 
                            Property:VehicleOut(btnData.i)
                            Wait(500)
                            CloseMenu(true)
                        end
                    else
                        Property:VehicleOut(btnData.i)
                        Wait(500)
                        CloseMenu(true)
                    end
                end
            end,
        },
        Menu = {
            ["Gestion véhicules"] = {
                b = function()
                    local tblGestion = {
                        { name = "Places restantes", ask = "~b~" .. Property.Current.Garage.Max - #Property.Current.Garage.Vehicles .. "/" .. Property.Current.Garage.Max },
                    }

                    for k, v in pairs(Property.Current.Garage.Vehicles) do
                        local vehProps = json.decode(v.vehicle_property)
                        local vehName = GetLabelText(GetDisplayNameFromVehicleModel(vehProps.model))
                        tblGestion[#tblGestion+1] = { name = vehName, ask = "~b~" .. vehProps.plate, askX = true, i = k}
                    end

                    return tblGestion
                end,
            },
        }
    }

    Property.Menus.GarageGestion.Base.Title = Property.Current.Name
    CreateMenu(Property.Menus.GarageGestion)
end

function RequestControl(entity) --Request Control d'une entité
	local start = GetGameTimer()
	local entityId = tonumber(entity)
	if not DoesEntityExist(entityId) then return end
	if not NetworkHasControlOfEntity(entityId) then		
		NetworkRequestControlOfEntity(entityId)
		while not NetworkHasControlOfEntity(entityId) do
			Citizen.Wait(10)
			if GetGameTimer() - start > 5000 then return end
		end
	end
	return entityId
end

-- Boucle
Citizen.CreateThread(function()
    local Player = PlayerPedId()
    while true do
        local time = 3000
        if Property.IsInInstance and Property.Current.Id then
            Property:StartInstance()
        end
        Wait(time)
    end
end)

function Property:GetDetailsProperties(vehicle)
	if DoesEntityExist(vehicle) then
		local colorPrimary, colorSecondary = GetVehicleColours(vehicle)
		local pearlescentColor, wheelColor = GetVehicleExtraColours(vehicle)
		local extras = {}

		for extraId=0, 12 do
			if DoesExtraExist(vehicle, extraId) then
				local state = IsVehicleExtraTurnedOn(vehicle, extraId) == 1
				extras[tostring(extraId)] = state
			end
		end

		return {
			model             = GetEntityModel(vehicle),

			plate             = ESX.Math.Trim(GetVehicleNumberPlateText(vehicle)),
			plateIndex        = GetVehicleNumberPlateTextIndex(vehicle),

			bodyHealth        = ESX.Math.Round(GetVehicleBodyHealth(vehicle), 1),
			engineHealth      = ESX.Math.Round(GetVehicleEngineHealth(vehicle), 1),
			tankHealth        = ESX.Math.Round(GetVehiclePetrolTankHealth(vehicle), 1),

			fuelLevel         = ESX.Math.Round(GetVehicleFuelLevel(vehicle), 1),
			dirtLevel         = ESX.Math.Round(GetVehicleDirtLevel(vehicle), 1),
			color1            = colorPrimary,
			color2            = colorSecondary,

			pearlescentColor  = pearlescentColor,
			wheelColor        = wheelColor,

			wheels            = GetVehicleWheelType(vehicle),
			windowTint        = GetVehicleWindowTint(vehicle),
			xenonColor        = GetVehicleXenonLightsColour(vehicle),

			neonEnabled       = {
				IsVehicleNeonLightEnabled(vehicle, 0),
				IsVehicleNeonLightEnabled(vehicle, 1),
				IsVehicleNeonLightEnabled(vehicle, 2),
				IsVehicleNeonLightEnabled(vehicle, 3)
			},

			customWheel = GetVehicleModVariation(vehicle, 23),

			neonColor         = table.pack(GetVehicleNeonLightsColour(vehicle)),
			extras            = extras,
			tyreSmokeColor    = table.pack(GetVehicleTyreSmokeColor(vehicle)),

			modSpoilers       = GetVehicleMod(vehicle, 0),
			modFrontBumper    = GetVehicleMod(vehicle, 1),
			modRearBumper     = GetVehicleMod(vehicle, 2),
			modSideSkirt      = GetVehicleMod(vehicle, 3),
			modExhaust        = GetVehicleMod(vehicle, 4),
			modFrame          = GetVehicleMod(vehicle, 5),
			modGrille         = GetVehicleMod(vehicle, 6),
			modHood           = GetVehicleMod(vehicle, 7),
			modFender         = GetVehicleMod(vehicle, 8),
			modRightFender    = GetVehicleMod(vehicle, 9),
			modRoof           = GetVehicleMod(vehicle, 10),

			modEngine         = GetVehicleMod(vehicle, 11),
			modBrakes         = GetVehicleMod(vehicle, 12),
			modTransmission   = GetVehicleMod(vehicle, 13),
			modHorns          = GetVehicleMod(vehicle, 14),
			modSuspension     = GetVehicleMod(vehicle, 15),
			modArmor          = GetVehicleMod(vehicle, 16),

			modTurbo          = IsToggleModOn(vehicle, 18),
			modSmokeEnabled   = IsToggleModOn(vehicle, 20),
			modXenon          = IsToggleModOn(vehicle, 22),

			modFrontWheels    = GetVehicleMod(vehicle, 23),
			modBackWheels     = GetVehicleMod(vehicle, 24),

			modPlateHolder    = GetVehicleMod(vehicle, 25),
			modVanityPlate    = GetVehicleMod(vehicle, 26),
			modTrimA          = GetVehicleMod(vehicle, 27),
			modOrnaments      = GetVehicleMod(vehicle, 28),
			modDashboard      = GetVehicleMod(vehicle, 29),
			modDial           = GetVehicleMod(vehicle, 30),
			modDoorSpeaker    = GetVehicleMod(vehicle, 31),
			modSeats          = GetVehicleMod(vehicle, 32),
			modSteeringWheel  = GetVehicleMod(vehicle, 33),
			modShifterLeavers = GetVehicleMod(vehicle, 34),
			modAPlate         = GetVehicleMod(vehicle, 35),
			modSpeakers       = GetVehicleMod(vehicle, 36),
			modTrunk          = GetVehicleMod(vehicle, 37),
			modHydrolic       = GetVehicleMod(vehicle, 38),
			modEngineBlock    = GetVehicleMod(vehicle, 39),
			modAirFilter      = GetVehicleMod(vehicle, 40),
			modStruts         = GetVehicleMod(vehicle, 41),
			modArchCover      = GetVehicleMod(vehicle, 42),
			modAerials        = GetVehicleMod(vehicle, 43),
			modTrimB          = GetVehicleMod(vehicle, 44),
			modTank           = GetVehicleMod(vehicle, 45),
			modWindows        = GetVehicleMod(vehicle, 46),
			modLivery         = GetVehicleLivery(vehicle)
		}
	else
		return
	end
end

function Property:GetVehicleProperties(vehicle)
    if DoesEntityExist(vehicle) then
        local vehicleProps = Property:GetDetailsProperties(vehicle)
        vehicleProps["tyres"] = {}
        vehicleProps["windows"] = {}
        vehicleProps["doors"] = {}
        for id = 1, 10 do
            local tyreId = IsVehicleTyreBurst(vehicle, id, false)
        
            if tyreId then
                vehicleProps["tyres"][#vehicleProps["tyres"] + 1] = tyreId
        
                if tyreId == false then
                    tyreId = IsVehicleTyreBurst(vehicle, id, true)
                    vehicleProps["tyres"][ #vehicleProps["tyres"]] = tyreId
                end
            else
                vehicleProps["tyres"][#vehicleProps["tyres"] + 1] = false
            end
        end
        for id = 1, 7 do
            local windowId = IsVehicleWindowIntact(vehicle, id)

            if windowId ~= nil then
                vehicleProps["windows"][#vehicleProps["windows"] + 1] = windowId
            else
                vehicleProps["windows"][#vehicleProps["windows"] + 1] = true
            end
        end
        for id = 0, 6 do
            local doorId = IsVehicleDoorDamaged(vehicle, id)
            if doorId then
                vehicleProps["doors"][#vehicleProps["doors"] + 1] = doorId
            else
                vehicleProps["doors"][#vehicleProps["doors"] + 1] = false
            end
        end
		vehicleProps["vehicleHeadLight"]  = GetVehicleHeadlightsColour(vehicle)
        vehicleProps["vehicleEngine"]  = GetVehicleEngineHealth(vehicle)
        return vehicleProps
	else
		return nil
    end
end

function Property:SetVehicleDetailsProperties(vehicle, props)
	if DoesEntityExist(vehicle) then
		local colorPrimary, colorSecondary = GetVehicleColours(vehicle)
		local pearlescentColor, wheelColor = GetVehicleExtraColours(vehicle)
		SetVehicleModKit(vehicle, 0)

		if props.plate then SetVehicleNumberPlateText(vehicle, props.plate) end
		if props.plateIndex then SetVehicleNumberPlateTextIndex(vehicle, props.plateIndex) end
		if props.bodyHealth then SetVehicleBodyHealth(vehicle, props.bodyHealth + 0.0) end
		if props.engineHealth then SetVehicleEngineHealth(vehicle, props.engineHealth + 0.0) end
		if props.tankHealth then SetVehiclePetrolTankHealth(vehicle, props.tankHealth + 0.0) end
		if props.fuelLevel then SetVehicleFuelLevel(vehicle, props.fuelLevel + 0.0) end
		if props.dirtLevel then SetVehicleDirtLevel(vehicle, props.dirtLevel + 0.0) end
		if props.color1 then SetVehicleColours(vehicle, props.color1, colorSecondary) end
		if props.color2 then SetVehicleColours(vehicle, props.color1 or colorPrimary, props.color2) end
		if props.pearlescentColor then SetVehicleExtraColours(vehicle, props.pearlescentColor, wheelColor) end
		if props.wheelColor then SetVehicleExtraColours(vehicle, props.pearlescentColor or pearlescentColor, props.wheelColor) end
		if props.wheels then SetVehicleWheelType(vehicle, props.wheels) end
		if props.windowTint then SetVehicleWindowTint(vehicle, props.windowTint) end


		if props.neonEnabled then
			SetVehicleNeonLightEnabled(vehicle, 0, props.neonEnabled[1])
			SetVehicleNeonLightEnabled(vehicle, 1, props.neonEnabled[2])
			SetVehicleNeonLightEnabled(vehicle, 2, props.neonEnabled[3])
			SetVehicleNeonLightEnabled(vehicle, 3, props.neonEnabled[4])
		end

		if props.extras then
			for extraId,enabled in pairs(props.extras) do
				if enabled then
					SetVehicleExtra(vehicle, tonumber(extraId), 0)
				else
					SetVehicleExtra(vehicle, tonumber(extraId), 1)
				end
			end
		end

		if props.neonColor then SetVehicleNeonLightsColour(vehicle, props.neonColor[1], props.neonColor[2], props.neonColor[3]) end
		if props.xenonColor then SetVehicleXenonLightsColour(vehicle, props.xenonColor) end
		if props.modSmokeEnabled then ToggleVehicleMod(vehicle, 20, true) end
		if props.tyreSmokeColor then SetVehicleTyreSmokeColor(vehicle, props.tyreSmokeColor[1], props.tyreSmokeColor[2], props.tyreSmokeColor[3]) end
		if props.modSpoilers then SetVehicleMod(vehicle, 0, props.modSpoilers, false) end
		if props.modFrontBumper then SetVehicleMod(vehicle, 1, props.modFrontBumper, false) end
		if props.modRearBumper then SetVehicleMod(vehicle, 2, props.modRearBumper, false) end
		if props.modSideSkirt then SetVehicleMod(vehicle, 3, props.modSideSkirt, false) end
		if props.modExhaust then SetVehicleMod(vehicle, 4, props.modExhaust, false) end
		if props.modFrame then SetVehicleMod(vehicle, 5, props.modFrame, false) end
		if props.modGrille then SetVehicleMod(vehicle, 6, props.modGrille, false) end
		if props.modHood then SetVehicleMod(vehicle, 7, props.modHood, false) end
		if props.modFender then SetVehicleMod(vehicle, 8, props.modFender, false) end
		if props.modRightFender then SetVehicleMod(vehicle, 9, props.modRightFender, false) end
		if props.modRoof then SetVehicleMod(vehicle, 10, props.modRoof, false) end
		if props.modEngine then SetVehicleMod(vehicle, 11, props.modEngine, false) end
		if props.modBrakes then SetVehicleMod(vehicle, 12, props.modBrakes, false) end
		if props.modTransmission then SetVehicleMod(vehicle, 13, props.modTransmission, false) end
		if props.modHorns then SetVehicleMod(vehicle, 14, props.modHorns, false) end
		if props.modSuspension then SetVehicleMod(vehicle, 15, props.modSuspension, false) end
		if props.modArmor then SetVehicleMod(vehicle, 16, props.modArmor, false) end
		if props.modTurbo then ToggleVehicleMod(vehicle,  18, props.modTurbo) end
		if props.modXenon then ToggleVehicleMod(vehicle,  22, props.modXenon) end
		if props.modFrontWheels then SetVehicleMod(vehicle, 23, props.modFrontWheels, false) end
		if props.modBackWheels then SetVehicleMod(vehicle, 24, props.modBackWheels, false) end
		if props.modPlateHolder then SetVehicleMod(vehicle, 25, props.modPlateHolder, false) end
		if props.modVanityPlate then SetVehicleMod(vehicle, 26, props.modVanityPlate, false) end
		if props.modTrimA then SetVehicleMod(vehicle, 27, props.modTrimA, false) end
		if props.modOrnaments then SetVehicleMod(vehicle, 28, props.modOrnaments, false) end
		if props.modDashboard then SetVehicleMod(vehicle, 29, props.modDashboard, false) end
		if props.modDial then SetVehicleMod(vehicle, 30, props.modDial, false) end
		if props.modDoorSpeaker then SetVehicleMod(vehicle, 31, props.modDoorSpeaker, false) end
		if props.modSeats then SetVehicleMod(vehicle, 32, props.modSeats, false) end
		if props.modSteeringWheel then SetVehicleMod(vehicle, 33, props.modSteeringWheel, false) end
		if props.modShifterLeavers then SetVehicleMod(vehicle, 34, props.modShifterLeavers, false) end
		if props.modAPlate then SetVehicleMod(vehicle, 35, props.modAPlate, false) end
		if props.modSpeakers then SetVehicleMod(vehicle, 36, props.modSpeakers, false) end
		if props.modTrunk then SetVehicleMod(vehicle, 37, props.modTrunk, false) end
		if props.modHydrolic then SetVehicleMod(vehicle, 38, props.modHydrolic, false) end
		if props.modEngineBlock then SetVehicleMod(vehicle, 39, props.modEngineBlock, false) end
		if props.modAirFilter then SetVehicleMod(vehicle, 40, props.modAirFilter, false) end
		if props.modStruts then SetVehicleMod(vehicle, 41, props.modStruts, false) end
		if props.modArchCover then SetVehicleMod(vehicle, 42, props.modArchCover, false) end
		if props.modAerials then SetVehicleMod(vehicle, 43, props.modAerials, false) end
		if props.modTrimB then SetVehicleMod(vehicle, 44, props.modTrimB, false) end
		if props.modTank then SetVehicleMod(vehicle, 45, props.modTank, false) end
		if props.modWindows then SetVehicleMod(vehicle, 46, props.modWindows, false) end
		if props.customWheel then SetVehicleMod(vehicle, 23, GetVehicleMod(vehicle, 23), true) end

		if props.modLivery then
			SetVehicleMod(vehicle, 48, props.modLivery, false)
			SetVehicleLivery(vehicle, props.modLivery)
		end
	end
end

function Property:SetVehicleProperties(vehicle, vehicleProps)
    Property:SetVehicleDetailsProperties(vehicle, vehicleProps)
    if vehicleProps["windows"] then
        for windowId = 1, 9, 1 do
            if vehicleProps["windows"][windowId] == false then
                SmashVehicleWindow(vehicle, windowId)
            end
        end
    end
    if vehicleProps["tyres"] then
        for tyreId = 1, 7, 1 do
            if vehicleProps["tyres"][tyreId] ~= false then
                SetVehicleTyreBurst(vehicle, tyreId, true, 1000)
            end
        end
    end
    if vehicleProps["doors"] then
        for doorId = 0, 5, 1 do
            if vehicleProps["doors"][doorId] ~= false then
                SetVehicleDoorBroken(vehicle, doorId - 1, true)
            end
        end
    end
	if vehicleProps["vehicleHeadLight"] then 
        SetVehicleHeadlightsColour(vehicle, vehicleProps["vehicleHeadLight"]) 
    end
    if vehicleProps["vehicleEngine"] then 
        SetVehicleEngineHealth(vehicle, tonumber(vehicleProps["vehicleEngine"])) 
    end
end

function Property:TeleportCoords(vector, peds)
	if not vector or not peds then return end
	local x, y, z = vector.x, vector.y, vector.z + 0.98
	peds = peds or PlayerPedId()

	RequestCollisionAtCoord(x, y, z)
	NewLoadSceneStart(x, y, z, x, y, z, 50.0, 0)

	local TimerToGetGround = GetGameTimer()
	while not IsNewLoadSceneLoaded() do
		if GetGameTimer() - TimerToGetGround > 3500 then
			break
		end
		Citizen.Wait(0)
	end

	SetEntityCoordsNoOffset(peds, x, y, z)

	TimerToGetGround = GetGameTimer()
	while not HasCollisionLoadedAroundEntity(peds) do
		if GetGameTimer() - TimerToGetGround > 3500 then
			break
		end
		Citizen.Wait(0)
	end

	local retval, GroundPosZ = GetGroundZCoordWithOffsets(x, y, z)
	TimerToGetGround = GetGameTimer()
	while not retval do
		z = z + 5.0
		retval, GroundPosZ = GetGroundZCoordWithOffsets(x, y, z)
		Wait(0)

		if GetGameTimer() - TimerToGetGround > 3500 then
			break
		end
	end

	SetEntityCoordsNoOffset(peds, x, y, retval and GroundPosZ or z)
	NewLoadSceneStop()
	return true
end


Citizen.CreateThread(function()
    while true do
        local timeInit = 1000
        local Player = PlayerPedId()
        local pPed = Player
        local pPos = GetEntityCoords(Player)
        for k, v in pairs(Properties.List) do
            if not IsPedInAnyVehicle(Player, false) then 
                local propPos = json.decode(v.property_pos)
                local dist = Vdist2(vector3(pPos.x, pPos.y, pPos.z), vector3(propPos.x, propPos.y, propPos.z))
                if dist <= 15.0 then
                    timeInit = 5
                    Property.Current = v
                    Property.Current.Id = v.id_property
                    Property.Current.Enter = Property:GetEnterFromType(Property.Current.Interior)
                    Property.Current.Pos = json.decode(v.property_pos)
                    Property.Current.Chest = Property:GetChestFromType(Property.Current.Interior)          
                    Property.Current.ChestMax = v.property_chest            
                    Property.Current.Name = v.property_name    
                    Property.Current.Status = v.property_status 
                    Property.Current.Interior = v.property_type 
                    Property.Current.Price = v.property_price
                    Property.Current.Owner = v.property_owner
                    Property.Current.Jobs_Id = v.jobs
                    Property.Current.Orga_Id = v.orga
                    Property.Current.Garage = {}
                    Property.Current.GarageBlip = json.decode(v.garage_pos)
                    Property.Current.Garage.Max = v.garage_max

                    --if Property.Current.CanAccess then
                        if Property.UseClippyOrga then 
                            if Property.Current.Orga_Id then 
                                if Orga.Perms.access_property then 
                                    DrawMarker(25, Property.Current.Pos.x, Property.Current.Pos.y, Property.Current.Pos.z-0.98, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 1.0, 1.0, 1.0, 0, 128, 0, 200, 0, 0, 0, 0)

                                    if dist <= 5 then 

                                        ESX.ShowHelpNotification("Appuyez sur ~INPUT_CONTEXT~ pour ~b~accéder~s~ à la ~b~propriété~s~.")
                                        if IsControlJustPressed(0, 51) then
                                            if Property.Current.Owner ~= nil then
                                                Property:OpenOwnedMenu()
                                            else
                                                Property:OpenVisitMenu()
                                            end
                                        end
                                    end
                                end
                            else
                                DrawMarker(25, Property.Current.Pos.x, Property.Current.Pos.y, Property.Current.Pos.z-0.98, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 1.0, 1.0, 1.0, 0, 128, 0, 200, 0, 0, 0, 0)

                                if dist <= 5 then 

                                    ESX.ShowHelpNotification("Appuyez sur ~INPUT_CONTEXT~ pour ~b~accéder~s~ à la ~b~propriété~s~.")
                                    if IsControlJustPressed(0, 51) then
                                        if Property.Current.Owner ~= nil then
                                            Property:OpenOwnedMenu()
                                        else
                                            Property:OpenVisitMenu()
                                        end
                                    end
                                end
                            end
                        else
                            DrawMarker(25, Property.Current.Pos.x, Property.Current.Pos.y, Property.Current.Pos.z-0.98, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 1.0, 1.0, 1.0, 0, 128, 0, 200, 0, 0, 0, 0)

                            if dist <= 5 then 

                                ESX.ShowHelpNotification("Appuyez sur ~INPUT_CONTEXT~ pour ~b~accéder~s~ à la ~b~propriété~s~.")
                                if IsControlJustPressed(0, 51) then
                                    if Property.Current.Owner ~= nil then
                                        Property:OpenOwnedMenu()
                                    else
                                        Property:OpenVisitMenu()
                                    end
                                end
                            end
                        end
                    --end
                end
            end
        end
        Wait(timeInit)
    end
end)

Citizen.CreateThread(function()
    while true do
        local timeInit = 1000
        local Player = PlayerPedId()
        local pPed = Player
        local pPos = GetEntityCoords(Player)
        for k, v in pairs(Properties.List) do
            if v.garage_pos ~= "null" then
                local garagePos = json.decode(v.garage_pos)
                local dist = Vdist2(vector3(pPos.x, pPos.y, pPos.z), vector3(garagePos.x, garagePos.y, garagePos.z))
                if dist <= 35 then
                    Property.Current = v
                    Property.Current.Id = v.id_property
                    Property.Current.Name = v.property_name    
                    Property.Current.Status = v.property_status 
                    Property.Current.Owner = v.property_owner
                    Property.Current.Jobs_Id = v.jobs
                    Property.Current.Orga_Id = v.orga
                    Property.Current.Garage = {}
                    Property.Current.Garage.Pos = json.decode(v.garage_pos)
                    Property.Current.Garage.Max = v.garage_max
                    Property.Current.Garage.Enter = Property:GetEnterFromGarage(Property.Current.Garage.Max)
                    Property.Current.Garage.Gestion = Property:GetGestionFromGarage(Property.Current.Garage.Max)
                    Property.Current.Garage.Spaces = Property:GetSpacesFromGarage(Property.Current.Garage.Max)

                    if not Property.Current.CanAccess then Property.Current.CanAccess = Property:CanAccess() end
                    timeInit = 5

                    if Property.Current.CanAccess then
                        if Property.UseClippyOrga then 
                            if Property.Current.Orga_Id then 
                                if Orga.Perms.access_garage then 
                                    if Property.Current.Garage.Pos then 
                                        DrawMarker(25, Property.Current.Garage.Pos.x, Property.Current.Garage.Pos.y, Property.Current.Garage.Pos.z-0.98, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 1.1, 1.1, 1.0001, 0, 80, 120, 200, 0, 0, 0, 0)
                                    end
            
                                    if dist <= (IsPedInAnyVehicle(Player, false) and 25 or 5) then 
                                        ESX.ShowHelpNotification("Appuyez sur ~INPUT_CONTEXT~ pour ~b~entrer~s~ dans le ~b~garage~s~.")
                                        timeInit = 5
            
                                        if IsControlJustPressed(0, 51) then
                                            if IsPedInAnyVehicle(Player) then
                                                if Orga.Perms.park_car then
                                                    TriggerServerEvent("ESX:stockVehicleInProperty", Property.Current.Name, Property.Current.Garage.Max, Property:GetVehicleProperties(GetVehiclePedIsIn(Player, false)), Property.Current.Id)
                                                    Wait(5000)
                                                else
                                                    ESX.ShowNotification("~r~Vous n'avez pas les permissions pour ranger un véhicule.")
                                                end
                                            else
                                                DoScreenFadeOut(1000)
                                                Wait(1000)    
                                                Property:EnterGarage()
                                            end
                                        end
                                    end
                                end
                            else
                                if Property.Current.Garage.Pos then 
                                    DrawMarker(25, Property.Current.Garage.Pos.x, Property.Current.Garage.Pos.y, Property.Current.Garage.Pos.z-0.98, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 1.1, 1.1, 1.0001, 0, 80, 120, 200, 0, 0, 0, 0)
                                end
        
                                if dist <= (IsPedInAnyVehicle(Player, false) and 25 or 5) then 
                                    ESX.ShowHelpNotification("Appuyez sur ~INPUT_CONTEXT~ pour ~b~entrer~s~ dans le ~b~garage~s~.")
                                    timeInit = 5
        
                                    if IsControlJustPressed(0, 51) then
                                        if IsPedInAnyVehicle(Player) then
                                            TriggerServerEvent("ESX:stockVehicleInProperty", Property.Current.Name, Property.Current.Garage.Max, Property:GetVehicleProperties(GetVehiclePedIsIn(Player, false)), Property.Current.Id)
                                            Wait(5000)
                                        else
                                            DoScreenFadeOut(1000)
                                            Wait(1000)    
                                            Property:EnterGarage()
                                        end
                                    end
                                end   
                            end
                        else
                            if Property.Current.Garage.Pos then 
                                DrawMarker(25, Property.Current.Garage.Pos.x, Property.Current.Garage.Pos.y, Property.Current.Garage.Pos.z-0.98, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 1.1, 1.1, 1.0001, 0, 80, 120, 200, 0, 0, 0, 0)
                            end
    
                            if dist <= (IsPedInAnyVehicle(Player, false) and 25 or 5) then 
                                ESX.ShowHelpNotification("Appuyez sur ~INPUT_CONTEXT~ pour ~b~entrer~s~ dans le ~b~garage~s~.")
                                timeInit = 5
    
                                if IsControlJustPressed(0, 51) then
                                    if IsPedInAnyVehicle(Player) then
                                        TriggerServerEvent("ESX:stockVehicleInProperty", Property.Current.Name, Property.Current.Garage.Max, Property:GetVehicleProperties(GetVehiclePedIsIn(Player, false)), Property.Current.Id)
                                        Wait(5000)
                                    else
                                        DoScreenFadeOut(1000)
                                        Wait(1000)    
                                        Property:EnterGarage()
                                    end
                                end
                            end
                        end
                    end
                end
            end
        end
        Wait(timeInit)
    end
end)

-- Events
RegisterNetEvent("ESX:InitProperties")
AddEventHandler("ESX:InitProperties", function()
    Properties:Init()
end)





RegisterNetEvent("ESX:stockVehicleInProperty")
AddEventHandler("ESX:stockVehicleInProperty", function(model)
    DoScreenFadeOut(1000)
    Wait(1000)
    local Player = PlayerPedId()
    if IsPedSittingInAnyVehicle(Player) then
        local vehicle = GetVehiclePedIsIn(Player, false)
        local plate = GetVehicleNumberPlateText(vehicle) 
        local state = 1
        TriggerServerEvent('esx_advancedgarage:setVehicleState', plate, state)
        Property:DeleteVehicle(GetVehiclePedIsIn(Player, false))
        ESX.ShowNotification("Vous avez rangé votre ~b~" .. GetLabelText(GetDisplayNameFromVehicleModel(model)))
        Property:EnterGarage()
    else
        Property:EnterGarage()
    end
end)

RegisterNetEvent("ESX:startInstance")
AddEventHandler("ESX:startInstance", function(tblAccessId)
    for k, v in pairs(GetActivePlayers()) do 
        NetworkConcealPlayer(v, false, false) 
        local serverId = GetPlayerServerId(v)
        if v ~= GetPlayerIndex() then      
            if tblAccessId ~= nil and not tblAccessId[serverId] then 
                NetworkConcealPlayer(v, true, true) 
            end 
        end
    end
    tblAccessId = {}
end)

RegisterNetEvent("ESX:ringProperty")
AddEventHandler("ESX:ringProperty", function(pName, target)
    Citizen.CreateThread(function()
        local timer = 60*1000
        ESX.ShowNotification("Quelqu'un veux rentrer dans votre propriété.\n~b~" .. pName)
        ESX.ShowNotification("~g~Y ~s~pour accepter\n~r~X ~s~pour refuser")    
        while true do
            timer = timer - 1
            Wait(1)
    
            if timer <= 0 then
                TriggerServerEvent("ESX:refuseEnterProperty", pName, target)
                ESX.ShowNotification("~r~Vous avez refusé l'accès à la personne qui sonnait.")
                break
            end
    
            if IsControlJustPressed(1, 252) then
                TriggerServerEvent("ESX:refuseEnterProperty", pName, target)
                ESX.ShowNotification("~r~Vous avez refusé l'accès à la personne qui sonnait.")
                break
            end
    
            if IsControlJustPressed(1, 246) then 
                TriggerServerEvent("ESX:acceptEnterProperty", pName, target)
                ESX.ShowNotification("~g~Vous avez autorisé l'accès à la personne qui sonnait.")
                break
            end
        end    
    end)
end)

RegisterNetEvent("ESX:enterRingedProperty")
AddEventHandler("ESX:enterRingedProperty", function()
    if not Property.Ringed then return ESX.ShowNotification("~r~Erreur") end
    Property.Current = Property.Ringed
    DoScreenFadeOut(1000)
    Wait(1000)
    Property:Enter()
end)

RegisterNetEvent("ESX:refreshGarage")
AddEventHandler("ESX:refreshGarage", function()
    DoScreenFadeOut(1000)
    Wait(1000)    
    Property:Exit()
    Property:EnterGarage()
end)

RegisterKeyMapping("openPropertymenu", "Ouvrir le menu de gestion de votre propriété", "keyboard", "L")
RegisterCommand("openPropertymenu", function()
    if not Property.IsInProperty then return ESX.ShowNotification("~r~Vous devez être dans une properiétée.") end
    Property:OpenHouseMenu()
end)

Citizen.CreateThread(function()
    Wait(5000)
    Properties:Init()
end)