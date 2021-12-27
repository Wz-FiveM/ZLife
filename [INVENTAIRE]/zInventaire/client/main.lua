local a = {
    ["ESC"] = 322,
    ["F1"] = 288,
    ["F2"] = 289,
    ["F3"] = 170,
    ["F5"] = 166,
    ["F6"] = 167,
    ["F7"] = 168,
    ["F8"] = 169,
    ["F9"] = 56,
    ["F10"] = 57,
    ["~"] = 243,
    ["1"] = 157,
    ["2"] = 158,
    ["3"] = 160,
    ["4"] = 164,
    ["5"] = 165,
    ["6"] = 159,
    ["7"] = 161,
    ["8"] = 162,
    ["9"] = 163,
    ["-"] = 84,
    ["="] = 83,
    ["BACKSPACE"] = 177,
    ["TAB"] = 37,
    ["Q"] = 44,
    ["W"] = 32,
    ["E"] = 38,
    ["R"] = 45,
    ["T"] = 245,
    ["Y"] = 246,
    ["U"] = 303,
    ["P"] = 199,
    ["["] = 39,
    ["]"] = 40,
    ["ENTER"] = 18,
    ["CAPS"] = 137,
    ["A"] = 34,
    ["S"] = 8,
    ["D"] = 9,
    ["F"] = 23,
    ["G"] = 47,
    ["H"] = 74,
    ["K"] = 311,
    ["L"] = 182,
    ["LEFTSHIFT"] = 21,
    ["Z"] = 20,
    ["X"] = 73,
    ["C"] = 26,
    ["V"] = 0,
    ["B"] = 29,
    ["N"] = 249,
    ["M"] = 244,
    [","] = 82,
    ["."] = 81,
    ["LEFTCTRL"] = 36,
    ["LEFTALT"] = 19,
    ["SPACE"] = 22,
    ["RIGHTCTRL"] = 70,
    ["HOME"] = 213,
    ["PAGEUP"] = 10,
    ["PAGEDOWN"] = 11,
    ["DELETE"] = 178,
    ["LEFT"] = 174,
    ["RIGHT"] = 175,
    ["TOP"] = 27,
    ["DOWN"] = 173,
    ["NENTER"] = 201,
    ["N4"] = 108,
    ["N5"] = 60,
    ["N6"] = 107,
    ["N+"] = 96,
    ["N-"] = 97,
    ["N7"] = 117,
    ["N8"] = 61,
    ["N9"] = 118
}
function SetFieldValueFromNameEncode(b, c)
    SetResourceKvp(b, json.encode(c))
end
function GetFieldValueFromName(b)
    local c = GetResourceKvpString(b)
    return c and json.decode(c) or {}
end
local d = nil;
local e = false;
local f = false;
ESX = nil;
local g = GetFieldValueFromName('Clippy_Slots').name and GetFieldValueFromName('Clippy_Slots').name or {}
local h = false;
local i = false;
Citizen.CreateThread(function()
    while ESX == nil do
        TriggerEvent("esx:getSharedObject", function(j)
            ESX = j
        end)
        Citizen.Wait(0)
    end
end)
Citizen.CreateThread(function()
    while true do
        Citizen.Wait(0)
        BlockWeaponWheelThisFrame()
        DisableControlAction(0, 37, true)
        DisableControlAction(0, 199, true) 
    end
end)

function openInventory()
    TriggerEvent('esx_status:setDisplay', 1.0)
    loadPlayerInventory()
    e = true;
    f = true;
    SendNUIMessage({
        action = "display",
        type = "normal"
    })
    SetNuiFocus(true, true)
    SetCanMooveInInv(true)
    TriggerEvent("ESX:RebuildLoadout")
end
RegisterKeyMapping("openinv", "Ouvrir l'inventaire", "keyboard", "TAB")
RegisterCommand("openinv", function()
    if not f then
        Citizen.Wait(150)
        openInventory()
    else
        closeInventory()
    end
end, false)
function openTrunkInventory()
    TriggerEvent('esx_status:setDisplay', 0.0)
    loadPlayerInventory()
    f = true;
    e = true;
    SendNUIMessage({
        action = "display",
        type = "trunk"
    })
    SetNuiFocus(true, true)
    SetCanMooveInInv(true)
end
RegisterNetEvent('clp_closeinventory')
AddEventHandler('clp_closeinventory', function()
    if i then
        i = false;
        ClearPedTasks(GetPlayerPed(-1))
    end
    TriggerEvent('esx_status:setDisplay', 0.0)
    closeInventory()
end)
function closeInventory()
    TriggerEvent('esx_status:setDisplay', 0.0)
    if i then
        i = false;
        ClearPedTasks(GetPlayerPed(-1))
    end
    e = false;
    f = false;
    SendNUIMessage({
        action = "hide"
    })
    SetNuiFocus(false, false)
    SetCanMooveInInv(false)
end
RegisterNUICallback("NUIFocusOff", function()
    closeInventory()
    Citizen.Wait(50)
end)
RegisterNUICallback("GetNearPlayers", function(k, l)
    local m = PlayerPedId()
    local n, o = ESX.Game.GetPlayersInArea(GetEntityCoords(m), 3.0)
    local p = false;
    local q = {}
    for r = 1, #n, 1 do
        if n[r] ~= PlayerId() then
            p = true;
            table.insert(q, {
                label = GetPlayerName(n[r]),
                player = GetPlayerServerId(n[r])
            })
        end
    end
    if not p then
        ESX.ShowNotification(_U("players_nearby"))
    else
        SendNUIMessage({
            action = "nearPlayers",
            foundAny = p,
            players = q,
            item = k.item
        })
    end
    l("ok")
end)
RegisterNUICallback("PutIntoTrunk", function(k, l)
    local m = GetPlayerPed(-1)
    if type(k.number) == "number" and math.floor(k.number) == k.number then
        local s = tonumber(k.number)
        if k.item.type == "item_weapon" then
            s = GetAmmoInPedWeapon(PlayerPedId(), GetHashKey(k.item.name))
        end
        TriggerServerEvent("esx_trunk:putItem", d.plate, k.item.type, k.item.name, s, d.max, d.myVeh, k.item.label)
    end
    Wait(50)
    loadPlayerInventory()
    l("ok")
end)
RegisterNUICallback("TakeFromTrunk", function(k, l)
    local m = GetPlayerPed(-1)
    if type(k.number) == "number" and math.floor(k.number) == k.number then
        TriggerServerEvent("esx_trunk:getItem", d.plate, k.item.type, k.item.name, tonumber(k.number), d.max, d.myVeh)
    end
    Wait(50)
    loadPlayerInventory()
    l("ok")
end)

function TaskPlayAnimToPlayer(a,b,c,d,e)if type(a)~="table"then a={a}end;d,c=d or GetPlayerPed(-1),c and tonumber(c)or false;if not a or not a[1]or string.len(a[1])<1 then return end;if IsEntityPlayingAnim(d,a[1],a[2],3)or IsPedActiveInScenario(d)then ClearPedTasks(d)return end;Citizen.CreateThread(function()TaskForceAnimPlayer(a,c,{ped=d,time=b,pos=e})end)end;local f={"WORLD_HUMAN_MUSICIAN","WORLD_HUMAN_CLIPBOARD"}local g={["WORLD_HUMAN_BUM_WASH"]={"amb@world_human_bum_wash@male@high@idle_a","idle_a"},["WORLD_HUMAN_SIT_UPS"]={"amb@world_human_sit_ups@male@idle_a","idle_a"},["WORLD_HUMAN_PUSH_UPS"]={"amb@world_human_push_ups@male@base","base"},["WORLD_HUMAN_BUM_FREEWAY"]={"amb@world_human_bum_freeway@male@base","base"},["WORLD_HUMAN_CLIPBOARD"]={"amb@world_human_clipboard@male@base","base"},["WORLD_HUMAN_VEHICLE_MECHANIC"]={"amb@world_human_vehicle_mechanic@male@base","base"}}function TaskForceAnimPlayer(a,c,h)c,h=c and tonumber(c)or false,h or{}local d,b,i,j,k,l=h.ped or GetPlayerPed(-1),h.time,h.clearTasks,h.pos,h.ang;if IsPedInAnyVehicle(d)and(not c or c<40)then return end;if not i then ClearPedTasks(d)end;if not a[2]and g[a[1]]and GetEntityModel(d)==-1667301416 then a=g[a[1]]end;if a[2]and not HasAnimDictLoaded(a[1])then if not DoesAnimDictExist(a[1])then return end;RequestAnimDict(a[1])while not HasAnimDictLoaded(a[1])do Citizen.Wait(10)end end;if not a[2]then ClearAreaOfObjects(GetEntityCoords(d),1.0)TaskStartScenarioInPlace(d,a[1],-1,not TableHasValue(f,a[1]))else if not j then TaskPlayAnim(d,a[1],a[2],8.0,-8.0,-1,c or 44,1,0,0,0,0)else TaskPlayAnimAdvanced(d,a[1],a[2],j.x,j.y,j.z,k.x,k.y,k.z,8.0,-8.0,-1,1,1,0,0,0)end end;if b and type(b)=="number"then Citizen.Wait(b)ClearPedTasks(d)end;if not h.dict then RemoveAnimDict(a[1])end end;function TableHasValue(m,n,o)if not m or not n or type(m)~="table"then return end;for p,q in pairs(m)do if o and q[o]==n or q==n then return true,p end end end

ListTypeClothes = {
    {type = "tshirt", id = "tshirt_1", id2 = "tshirt_2", anim = {'clothingtie', 'try_tie_neutral_d'}, drax = 15, draxfemale = 15},
    {type = "torso", id = "torso_1", id2 = "torso_2", anim = {'clothingtie', 'try_tie_neutral_d'}, drax = 15, draxfemale = 15},
    {type = "arms", id = "arms", id2 = "arms_2", anim = {'clothingtie', 'try_tie_neutral_d'}, drax = 15, draxfemale = 15},
    {type = "pants", id = "pants_1", id2 = "pants_2", anim = {'clothingtrousers', 'try_trousers_neutral_c'}, drax = 18, draxfemale = 14},
    {type = "shoes", id = "shoes_1", id2 = "shoes_2", anim = {'clothingshoes', 'try_shoes_neutral_d'}, drax = 34, draxfemale = 34},
    {type = "mask", id = "mask_1", id2 = "mask_2", anim = {'misscommon@van_put_on_masks', 'put_on_mask_ps'}, drax = 0, draxfemale = 0},
    {type = "bproof", id = "bproof_1", id2 = "bproof_2", anim = {'clothingtie', 'try_tie_neutral_b'}, drax = 0, draxfemale = 0},
    {type = "chain", id = "chain_1", id2 = "chain_2", anim = {'clothingtie', 'try_tie_neutral_d'}, drax = 0, draxfemale = 0},
    {type = "helmet", id = "helmet_1", id2 = "helmet_2", anim = {'misscommon@van_put_on_masks', 'put_on_mask_ps'}, drax = -1, draxfemale = -1},
    {type = "glasses", id = "glasses_1", id2 = "glasses_2", anim = {'clothingspecs', 'try_glasses_positive_a'}, drax = 0, draxfemale = 0},
    {type = "watches", id = "watches_1", id2 = "watches_2", anim = {'clothingtie', 'try_tie_neutral_d'}, drax = -1, draxfemale = -1},
    {type = "bracelets", id = "bracelets_1", id2 = "bracelets_2", anim = {'clothingtie', 'try_tie_neutral_d'}, drax = -1, draxfemale = -1},
    {type = "bags", id = "bags_1", id2 = "bags_2", anim = {'clothingshirt', 'try_shirt_negative_a'}, drax = 0, draxfemale = 0},
}

function SavePlayerSkin()
    TriggerEvent('skinchanger:getSkin', function(skin)
        TriggerServerEvent('esx_skin:save', skin)
    end)
end 

RegisterNUICallback("UseItem", function(k, l)
    if k.item.isClothe then 
        if k.item.name ~= "tenue" then 
            for _,v in pairs(ListTypeClothes) do
                if v.type == k.item.name then
                    TaskForceAnimPlayer(v.anim, 49, {time = 2000 })
                    TriggerEvent("skinchanger:change", v.id, tonumber(k.item.clotheId))
                    TriggerEvent('skinchanger:change', v.id2, tonumber(k.item.color))
                end
            end
        else
            TriggerEvent('skinchanger:getSkin', function(skin)
                TriggerEvent('skinchanger:loadClothes', skin, k.item.clotheId)
                SavePlayerSkin()
                ESX.ShowNotification("Vous avez enfilé la tenue ~b~" .. k.item.label .."~s~.")
            end)
        end
        Citizen.Wait(10)
        loadClothesInventory()
        l("ok")
    else
        TriggerServerEvent("esx:useItem", k.item.name)
        Citizen.Wait(10)
        loadPlayerInventory()
        l("ok")
    end
end)

function IsPedPeds() -- Si le joueur est un Homme
    local pPed = PlayerPedId()
    if IsPedModel(pPed, GetHashKey("mp_m_freemode_01")) then 
        return true 
    elseif IsPedModel(pPed, GetHashKey("mp_f_freemode_01")) then 
        return false 
    else
        return "ped"
    end
end

RegisterNUICallback("DropItem", function(k, l)
    local m = GetPlayerPed(-1)
    if IsPedSittingInAnyVehicle(m) then
        return
    end
    if k.item.isClothe then 
        if k.item.name ~= "tenue" then 
            for _,v in pairs(ListTypeClothes) do
                if v.type == k.item.name then
                    TriggerServerEvent("cClothes:deleteClothes", k.item.data, k.item.label)
                    if IsPedPeds() ~= "ped" then 
                        if not IsPedPeds() then 
                            TriggerEvent("skinchanger:change", v.id, v.draxfemale)
                            TriggerEvent('skinchanger:change', v.id2, 0)
                        else
                            TriggerEvent("skinchanger:change", v.id, v.drax)
                            TriggerEvent('skinchanger:change', v.id2, 0)
                        end
                    else
                        ESX.ShowNotification("~r~Vous ne pouvez pas en tant que peds.")
                    end
                end
            end
        else
            TriggerServerEvent("cClothes:deleteClothes", k.item.data, k.item.label)
        end
        Citizen.Wait(10)
        loadClothesInventory()
        l("ok")
    else
        if type(k.number) == "number" and math.floor(k.number) == k.number then
            TriggerServerEvent("esx:removeInventoryItem", k.item.type, k.item.name, k.number)
        end
        Wait(10)
        loadPlayerInventory()
        l("ok")
    end
end)

RegisterNUICallback("GiveItem", function(k, l)
    local m = PlayerPedId()
    local n, o = ESX.Game.GetPlayersInArea(GetEntityCoords(m), 3.0)
    local t = false;
    for r = 1, #n, 1 do
        if n[r] ~= PlayerId() then
            if GetPlayerServerId(n[r]) == k.player then
                t = true
            end
        end
    end
    if k.item.type == "item_weapon" then
        return ESX.ShowNotification("~r~Vous ne pouvez pas donner ce type d'arme.")
    end
    if t then
        if k.item.isClothe then 
            if k.item.name ~= "tenue" then 
                for _,v in pairs(ListTypeClothes) do
                    if v.type == k.item.name then
                        local closestPlayer, closestDistance = ESX.Game.GetClosestPlayer()
                        if closestPlayer and closestPlayer ~= -1 and closestDistance <= 2.5 then 
                            TaskForceAnimPlayer({"mp_common", "givetake2_a"}, 49, {time = 2000 })
                            TriggerServerEvent("cClothes:giveClothes", k.item.name, k.item.clotheId, k.item.color, k.item.label, GetPlayerServerId(closestPlayer), k.item.data)
                            if IsPedPeds() ~= "ped" then 
                                if not IsPedPeds() then 
                                    TriggerEvent("skinchanger:change", v.id, v.draxfemale)
                                    TriggerEvent('skinchanger:change', v.id2, 0)
                                else
                                    TriggerEvent("skinchanger:change", v.id, v.drax)
                                    TriggerEvent('skinchanger:change', v.id2, 0)
                                end
                            else
                                ESX.ShowNotification("~r~Vous ne pouvez pas en tant que peds.")
                            end
                        else
                            ESX.ShowNotification("~r~Aucun joueur à proximité.")
                        end
                    end
                end
            else
                local closestPlayer, closestDistance = ESX.Game.GetClosestPlayer()
                if closestPlayer and closestPlayer ~= -1 and closestDistance <= 2.5 then 
                    TaskForceAnimPlayer({"mp_common", "givetake2_a"}, 49, {time = 2000 })
                    TriggerServerEvent("cClothes:giveClothes", k.item.name, k.item.clotheId, k.item.color, k.item.label, GetPlayerServerId(closestPlayer), k.item.data)
                else
                    ESX.ShowNotification("~r~Aucun joueur à proximité.")
                end
            end
            Citizen.Wait(10)
            loadClothesInventory()
            l("ok")
        else
            local s = tonumber(k.number)
            if k.item.type == "item_weapon" then
                s = GetAmmoInPedWeapon(PlayerPedId(), GetHashKey(k.item.name))
            end
            TriggerServerEvent("esx:giveInventoryItem", k.player, k.item.type, k.item.name, s)
            Wait(10)
            loadPlayerInventory()
        end
    else
        ESX.ShowNotification(_U("player_nearby"))
    end
    l("ok")
end)
function shouldCloseInventory(u)
    for v, w in ipairs(Config.CloseUiItems) do
        if w == u then
            return true
        end
    end
    return false
end
function shouldSkipAccount(x)
    for v, w in ipairs(Config.ExcludeAccountsList) do
        if w == x then
            return true
        end
    end
    return false
end
local y = false;
function getInventoryWeight(inventory)
    local z = 0;
    local A = 0;
    if inventory ~= nil then
        for r = 1, #inventory, 1 do
            if inventory[r] ~= nil then
                A = Config.DefaultWeight;
                if arrayWeight[inventory[r].name] ~= nil then
                    A = arrayWeight[inventory[r].name]
                end
                z = z + A * (inventory[r].count or 1)
            end
        end
    end
    return z
end
local B = 30000;
local C = false;
local D = {}
local E = {}
local F;
function loadPlayerInventory()
    ESX.TriggerServerCallback("c_inventaire:getPlayerInventory", function(k)
        items = {}
        fastItems = {}
        inventory = k.inventory;
        accounts = k.accounts;
        money = k.money;
        weapons = k.weapons;
        E = inventory;
        if not Config.UseLastVersionESX then 
            if Config.IncludeCash and money ~= nil and money > 0 then
                for G, w in pairs(accounts) do
                    moneyData = {
                        label = _U("cash"),
                        name = "cash",
                        type = "item_money",
                        count = money,
                        usable = false,
                        rare = false,
                        limit = -1,
                        canRemove = true
                    }
                    table.insert(items, moneyData)
                end
            end
            if Config.IncludeAccounts and accounts ~= nil then
                for G, w in pairs(accounts) do
                    if not shouldSkipAccount(accounts[G].name) then
                        local H = accounts[G].name ~= "bank"
                        if accounts[G].money > 0 then
                            accountData = {
                                label = accounts[G].label,
                                count = accounts[G].money,
                                type = "item_account",
                                name = accounts[G].name,
                                usable = false,
                                rare = false,
                                limit = -1,
                                canRemove = H
                            }
                            table.insert(items, accountData)
                        end
                    end
                end
            end
        elseif Config.UseLastVersionESX then 
            if Config.IncludeCash then
                for G, w in pairs(accounts) do
                    if w.name ~= "bank" and w.money >= 1 then
                        moneyData = {
                            label = w.name == Config.Cash and Config.CashLabel or w.name == Config.Blackmoney and Config.BlackmoneyLabel,
                            name = w.name,
                            type = "item_money",
                            count = w.money,
                            usable = false,
                            rare = false,
                            limit = -1,
                            canRemove = true
                        }
                        table.insert(items, moneyData)
                    end
                end
            end
        end
        for n, y in pairs(g) do
            for G, w in pairs(inventory) do
                if inventory[G].count <= 0 then
                    inventory[G] = nil
                else
                    inventory[G].type = "item_standard"
                    if y == inventory[G].name then
                        table.insert(fastItems, {
                            label = inventory[G].label,
                            count = inventory[G].count,
                            limit = -1,
                            type = inventory[G].type,
                            name = inventory[G].name,
                            usable = true,
                            rare = false,
                            canRemove = true,
                            slot = n
                        })
                        break
                    end
                end
            end
        end
        if inventory ~= nil then
            for G, w in pairs(inventory) do
                if inventory[G].count <= 0 then
                    inventory[G] = nil
                else
                    if json.encode(fastItems) ~= "[]" then
                        for n, y in pairs(fastItems) do
                            if y.name == inventory[G].name then
                                D[G] = true;
                                break
                            else
                                D[G] = false
                            end
                        end
                    else
                        D = {}
                    end
                    if not D[G] then
                        inventory[G].type = "item_standard"
                        table.insert(items, inventory[G])
                    end
                end
            end
        end
        local arrayWeight = Config.localWeight;
        local z = 0;
        local A = 0;
        local I = 0;
        if items ~= nil then
            for r = 1, #items, 1 do
                if items[r] ~= nil then
                    A = Config.DefaultWeight;
                    A = A / items[1].count * 0.0;
                    if arrayWeight[items[r].name] ~= nil then
                        A = arrayWeight[items[r].name]
                        items[r].limit = A / 1000
                    end
                    z = z + A * (items[r].count or 1)
                end
            end
        end
        local J = _U("player_info", z / 1000, B / 1000)
        local K = z / 1000;
        if z > 50000 then
            ESX.ShowNotification('~r~Vous êtes trop lourd.')
            J = _U("player_info_full", z / 1000, Config.Limit / 1000)
            pasmarcher1 = true
        elseif z > B then
            print('trop lourd')
            ESX.ShowNotification('~r~Vous êtes trop lourd.')
            y = true;
            pasmarcher1 = false;
            J = _U("player_info_full", z / 1000, Config.Limit / 1000)
        elseif z <= B then
            y = false;
            if pasmarcher1 then
                FreezeEntityPosition(GetPlayerPed(-1), false)
            end
            pasmarcher1 = false;
            J = _U("player_info", z / 1000, Config.Limit / 1000)
        end
        SendNUIMessage({
            action = "setItems",
            itemList = items,
            fastItems = fastItems,
            text = J
        })
    end, GetPlayerServerId(PlayerId()))
end

function loadClothesInventory()
    ESX.TriggerServerCallback("cClothes:getPlayerClothes", function(clothes)
        if json.encode(clothes) ~= "[]" and clothes ~= nil then 
            items = {}
    
            for k, v in pairs(clothes) do
                clothesData = {
                    clotheId = v.id,
                    label = v.label,
                    data = k,
                    color = v.color,
                    isClothe = true,
                    name = v.type,
                    count = 1,
                    usable = true, 
                    rare = false,
                    limit = -1,
                    canRemove = true
                }
                table.insert(items, clothesData)
            end

            SendNUIMessage(
                {
                    action = "setClothesInventoryItems",
                    itemList = items
                }
            )    
        else
            --ESX.ShowNotification("~r~Vous n'avez aucun vêtements.")
            loadClothesInventory()
        end
    end, GetPlayerServerId(PlayerId()))
end

RegisterNUICallback("ShowClothes",function()
    loadClothesInventory()
end)

RegisterNUICallback("ShowItems",function()
    loadPlayerInventory()
end)


function setHurt()
    FreezeEntityPosition(GetPlayerPed(-1), true)
end
function setNotHurt()
    FreezeEntityPosition(GetPlayerPed(-1), false)
end
Citizen.CreateThread(function()
    while true do
        local L = 400;
        if y then
            L = 1;
            DisableControlAction(0, 22, true)
            DisableControlAction(0, 21, true)
        end
        if pasmarcher1 then
            L = 1;
            DisableControlAction(0, 22, true)
            DisableControlAction(0, 21, true)
            FreezeEntityPosition(GetPlayerPed(-1), true)
        end
        Wait(L)
    end
end)
RegisterNetEvent("c_inventaire:openTrunkInventory")
AddEventHandler("c_inventaire:openTrunkInventory", function(k, M, inventory, weapons)
    setTrunkInventoryData(k, M, inventory, weapons)
    openTrunkInventory()
end)
RegisterNetEvent("c_inventaire:refreshTrunkInventory")
AddEventHandler("c_inventaire:refreshTrunkInventory", function(k, M, inventory, weapons)
    setTrunkInventoryData(k, M, inventory, weapons)
end)
function setTrunkInventoryData(k, M, inventory, weapons)
    d = k;
    SendNUIMessage({
        action = "setInfoText",
        text = k.text
    })
    items = {}
    if M > 0 then
        accountData = {
            label = _U("black_money"),
            count = M,
            type = "item_account",
            name = "black_money",
            usable = false,
            rare = false,
            limit = -1,
            canRemove = false
        }
        table.insert(items, accountData)
    end
    if inventory ~= nil then
        for G, w in pairs(inventory) do
            if inventory[G].count <= 0 then
                inventory[G] = nil
            else
                inventory[G].type = "item_standard"
                inventory[G].usable = false;
                inventory[G].rare = false;
                inventory[G].limit = -1;
                inventory[G].canRemove = false;
                table.insert(items, inventory[G])
            end
        end
    end
    if Config.IncludeWeapons and weapons ~= nil then
        for G, w in pairs(weapons) do
            local N = GetHashKey(weapons[G].name)
            local m = PlayerPedId()
            if weapons[G].name ~= "WEAPON_UNARMED" then
                table.insert(items, {
                    label = weapons[G].label,
                    count = weapons[G].ammo,
                    limit = -1,
                    type = "item_weapon",
                    name = weapons[G].name,
                    usable = false,
                    rare = false,
                    canRemove = false
                })
            end
        end
    end
    SendNUIMessage({
        action = "setSecondInventoryItems",
        itemList = items
    })
end
function openTrunkInventory()
    loadPlayerInventory()
    e = true;
    local m = GetPlayerPed(-1)
    SendNUIMessage({
        action = "display",
        type = "trunk"
    })
    SetNuiFocus(true, true)
    SetCanMooveInInv(true)
end
Citizen.CreateThread(function()
    Citizen.Wait(2000)
    while true do
        Citizen.Wait(0)
        HudWeaponWheelIgnoreSelection()
        HideHudComponentThisFrame(19)
        HideHudComponentThisFrame(20)
        DisableControlAction(0, 37, true)
        DisableControlAction(0, 12, true)
        DisableControlAction(0, 13, true)
        DisableControlAction(0, 14, true)
        DisableControlAction(0, 15, true)
        DisableControlAction(0, 16, true)
        DisableControlAction(0, 17, true)
    end
end)
RegisterNUICallback("PutIntoFast", function(k, l)
    if k.item.slot ~= nil then
        g[k.item.slot] = nil
    end
    g[k.slot] = k.item.name;
    TriggerServerEvent("c_inventaire:changeFastItem", k.slot, k.item.name)
    SetFieldValueFromNameEncode('Clippy_Slots', {
        name = g
    })
    loadPlayerInventory()
    l("ok")
end)
RegisterNUICallback("TakeFromFast", function(k, l)
    g[k.item.slot] = nil;
    SetFieldValueFromNameEncode('Clippy_Slots', {
        name = g
    })
    TriggerServerEvent("c_inventaire:changeFastItem", 0, k.item.name)
    loadPlayerInventory()
    l("ok")
end)
RegisterKeyMapping("equipone", "Équiper armes (Slot 1)", "keyboard", "1")
RegisterKeyMapping("equiptwo", "Équiper armes (Slot 2)", "keyboard", "2")
RegisterKeyMapping("equipthree", "Équiper armes (Slot 3)", "keyboard", "3")
RegisterKeyMapping("equipfor", "Équiper armes (Slot 4)", "keyboard", "4")
RegisterKeyMapping("equipfive", "Équiper armes (Slot 5)", "keyboard", "5")
RegisterCommand("equipone", function()
    UseKey(1)
end)
RegisterCommand("equiptwo", function()
    UseKey(2)
end)
RegisterCommand("equipthree", function()
    UseKey(3)
end)
RegisterCommand("equipfor", function()
    UseKey(4)
end)
RegisterCommand("equipfive", function()
    UseKey(5)
end)
function UseKey(n)
    if g[n] ~= nil then
        for O, y in pairs(E) do
            if y.name == g[n] then
                if y.type == "item_weapon" then
                elseif y.type == "item_standard" then
                    if string.find(y.name, "weapon_") then
                        UseWeapon(n, y.label)
                        break
                    elseif string.find(y.name, "gadget_") then
                        UseWeapon(n, y.label)
                        break
                    else
                        TriggerServerEvent("esx:useItem", y.name)
                        break
                    end
                end
            end
        end
    end
end
local P;
local Q;
function UseWeapon(n, R)
    local S = PlayerPedId()
    if IsPedInAnyVehicle(S, false) then
        return ESX.ShowNotification("~r~Vous ne pouvez pas équiper votre arme en véhicule.")
    end
    if P == g[n] then
        RemoveWeapon(P)
        P = nil;
        Q = nil;
        return
    elseif P ~= nil then
        RemoveWeapon(P)
        P = nil;
        Q = nil
    end
    P = g[n]
    GiveWeapon(P, R)
    ClearPedTasks(S)
end
function RemoveWeapon(T)
    local m = GetPlayerPed(-1)
    local U = GetHashKey(T)
    RemoveWeaponFromPed(m, U)
end
local V = {GetHashKey("weapon_pistol"), GetHashKey("weapon_combatpistol"), GetHashKey("weapon_pistol50"),
           GetHashKey("weapon_snspistol"), GetHashKey("weapon_heavypistol"), GetHashKey("weapon_vintagepistol"),
           GetHashKey("weapon_flaregun"), GetHashKey("weapon_revolver"), GetHashKey("weapon_doubleaction"),
           GetHashKey("weapon_microsmg"), GetHashKey("weapon_minismg"), GetHashKey("weapon_machinepistol")}
function GiveWeapon(T, R)
    local m = GetPlayerPed(-1)
    local U = GetHashKey(T)
    if R ~= nil then
        ESX.ShowNotification("Vous avez équipé votre ~g~" .. R .. "~s~.")
    end
    if TableGetValue(V, U) then
        GiveWeaponToPed(m, U, 0, false, true)
    else
        GiveWeaponToPed(m, U, 0, false, true)
    end
end
RegisterNetEvent('c_inventaire:client:addItem')
AddEventHandler('c_inventaire:client:addItem', function(W, X)
    local k = {
        name = W,
        label = X
    }
    SendNUIMessage({
        type = "addInventoryItem",
        addItemData = k
    })
end)
function TableGetValue(Y, Z, n)
    if not Y or not Z or type(Y) ~= "table" then
        return
    end
    for O, y in pairs(Y) do
        if n and y[n] == Z or y == Z then
            return true, O
        end
    end
end
local a = false;
local d = false;
local e = {1, 2, 3, 4, 5, 6, 18, 24, 25, 37, 68, 69, 70, 91, 92, 142, 182, 199, 200, 245, 257}
function SetCanMooveInInv(f)
    if SetNuiFocusKeepInput then
        SetNuiFocusKeepInput(f)
    end
    a = f;
    if not d and f then
        d = true;
        Citizen.CreateThread(function()
            while a do
                Wait(0)
                for g, h in pairs(e) do
                    DisableControlAction(0, h, true)
                end
            end
            d = false
        end)
    end
end



ESX = nil



local Weapons = {}
local AmmoTypes = {}

local PlayerData = nil
local AmmoInClip = {}

local CurrentWeapon = nil

local IsShooting = false
local AmmoBefore = 0

for name,item in pairs(Configarme.Weapons) do
  Weapons[GetHashKey(name)] = item
end

for name,item in pairs(Configarme.AmmoTypes) do
  AmmoTypes[GetHashKey(name)] = item
end

Citizen.CreateThread(function()
  while ESX == nil do
    TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
    Citizen.Wait(0)
  end
end)

function GetAmmoItemFromHash(hash)
  for name,item in pairs(Configarme.Weapons) do
    if hash == GetHashKey(item.name) then
      if item.ammo then
        return item.ammo
      else
        return nil
      end
    end
  end
  return nil
end

function GetInventoryItem(name)
  local inventory = PlayerData.inventory
  for i=1, #inventory, 1 do
    if inventory[i].name == name then
      return inventory[i]
    end
  end
  return nil
end

function RebuildLoadout()
  
  while not PlayerData do
    Citizen.Wait(0)
  end
  
  local playerPed = GetPlayerPed(-1)

  for weaponHash,v in pairs(Weapons) do
    local item = GetInventoryItem(v.item)
    if item and item.count > 0 then
      local ammo = 0
      local ammoType = GetPedAmmoTypeFromWeapon(playerPed, weaponHash)

      if ammoType and AmmoTypes[ammoType] then
        local ammoItem = GetInventoryItem(AmmoTypes[ammoType].item)
        if ammoItem then
          ammo = ammoItem.count
        end
      end

      local SatGet = GetSelectedPedWeapon(playerPed)

      if (item.name == "weapon_ball" or "weapon_molotov" or "weapon_ceramicpistol" or "weapon_fireextinguisher" or "weapon_petrolcan") then
        if SatGet == "600439132" or SatGet == "615608432" or SatGet == "615608432" or SatGet == "883325847" or SatGet == "101631238" then
          SetPedAmmo(playerPed, SatGet, 2000)
        end
      end
      
      if HasPedGotWeapon(playerPed, weaponHash, false) then
        if GetAmmoInPedWeapon(playerPed, weaponHash) ~= ammo then
          SetPedAmmo(playerPed, weaponHash, ammo)
        end
      else
        GiveWeaponToPed(playerPed, weaponHash, ammo, false, false)
      end
    elseif HasPedGotWeapon(playerPed, weaponHash, false) then
      RemoveWeaponFromPed(playerPed, weaponHash)
    end
  end

end

function RemoveUsedAmmo()  
  local playerPed = GetPlayerPed(-1)
  local AmmoAfter = GetAmmoInPedWeapon(playerPed, CurrentWeapon)
  local ammoType = AmmoTypes[GetPedAmmoTypeFromWeapon(playerPed, CurrentWeapon)]
  
  if ammoType and ammoType.item then
    local ammoDiff = AmmoBefore - AmmoAfter
    if ammoDiff > 0 then
      TriggerServerEvent('esx:discardInventoryItem', ammoType.item, ammoDiff)
    end
  end

  return AmmoAfter
end

RegisterNetEvent('esx:playerLoaded')
AddEventHandler('esx:playerLoaded', function(xPlayer)
  PlayerData = xPlayer
  RebuildLoadout()
end)

RegisterNetEvent('esx:modelChanged')
AddEventHandler('esx:modelChanged', function()
  RebuildLoadout()
end)

AddEventHandler('playerSpawned', function()
  RebuildLoadout()
end)

AddEventHandler('skinchanger:modelLoaded', function()
  RebuildLoadout()
end)

RegisterNetEvent('esx:addInventoryItem')
AddEventHandler('esx:addInventoryItem', function(name, count)
  Citizen.Wait(1) 
  PlayerData = ESX.GetPlayerData()
  RebuildLoadout()
  if CurrentWeapon then
    AmmoBefore = GetAmmoInPedWeapon(GetPlayerPed(-1), CurrentWeapon)
  end
end)

RegisterNetEvent('esx:removeInventoryItem')
AddEventHandler('esx:removeInventoryItem', function(name, count)
  Citizen.Wait(1)
  PlayerData = ESX.GetPlayerData()
  RebuildLoadout()
  if CurrentWeapon then
    AmmoBefore = GetAmmoInPedWeapon(GetPlayerPed(-1), CurrentWeapon)
  end
end)

Citizen.CreateThread(function()
  while true do
    local attente = 500
    
    local playerPed = GetPlayerPed(-1)
    if IsPedArmed(playerPed, 4) then 
      attente = 1
      if CurrentWeapon ~= GetSelectedPedWeapon(playerPed) then
        IsShooting = false
        RemoveUsedAmmo()
        CurrentWeapon = GetSelectedPedWeapon(playerPed)
        AmmoBefore = GetAmmoInPedWeapon(playerPed, CurrentWeapon)
      end

      if IsPedShooting(playerPed) and not IsShooting then
        IsShooting = true
      elseif IsShooting and IsControlJustReleased(0, 24) then
        IsShooting = false
        AmmoBefore = RemoveUsedAmmo()
      elseif not IsShooting and IsControlJustPressed(0, 45) then
        AmmoBefore = GetAmmoInPedWeapon(playerPed, CurrentWeapon)
      end
    end
    local CurrentWeapon = GetSelectedPedWeapon(playerPed)
    local gEA = GetAmmoInPedWeapon(playerPed, CurrentWeapon)
    if IsPedArmed(playerPed, 3) and (gEA ~= 35 or GetMaxAmmo(playerPed, CurrentWeapon, gEA)) then 
      SetPedAmmo(playerPed, CurrentWeapon, 35)
    end
    Wait(attente)
  end
end)