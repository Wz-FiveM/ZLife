ESX = nil;
local a = {}
local b = {}
local c = nil;
local d = false;
b.Time = 0;
local e = {}
local f = Config.localWeight;
local g = false;
local h = nil;
local i = nil;
local j = 0;
Citizen.CreateThread(function()
    while ESX == nil do
        TriggerEvent('esx:getSharedObject', function(k)
            ESX = k
        end)
        Citizen.Wait(0)
    end
    while ESX.GetPlayerData().job == nil do
        Citizen.Wait(10)
    end
    a = ESX.GetPlayerData()
end)
RegisterNetEvent("esx:playerLoaded")
AddEventHandler("esx:playerLoaded", function(xPlayer)
    a = xPlayer;
    j = GetGameTimer()
end)
AddEventHandler("onResourceStart", function()
    a = xPlayer;
    j = GetGameTimer()
end)
RegisterNetEvent("esx:setJob")
AddEventHandler("esx:setJob", function(l)
    a.job = l
end)
RegisterNetEvent("cProperty_chest_inventory:setOwnedVehicule")
AddEventHandler("cProperty_chest_inventory:setOwnedVehicule", function(m)
    e = m
end)
function getItemyWeight(n)
    local o = 0;
    local p = 0;
    if n ~= nil then
        p = Config.DefaultWeight;
        if f[n] ~= nil then
            p = f[n]
        end
    end
    return p
end

RegisterNetEvent("esx:playerLoaded")
AddEventHandler("esx:playerLoaded", function(xPlayer)
    a = xPlayer;
    j = GetGameTimer()
end)
function OpenPropertyChest(M, N, myVeh)
    ESX.TriggerServerCallback("cProperty_chest:getInventoryV", function(O)
        text = _U("Chest_info", O.weight, N)
        data = {
            plate = M,
            max = N,
            myVeh = myVeh,
            text = text
        }
        TriggerEvent("cPropertyInv:openChestInventory", data, O.blackMoney, O.items, O.weapons, O.money)
    end, M)
end
function all_trim(P)
    if P then
        return P:match "^%s*(.*)":match "(.-)%s*$"
    else
        return "noTagProvided"
    end
end
function dump(Q)
    if type(Q) == "table" then
        local P = "{ "
        for R, S in pairs(Q) do
            if type(R) ~= "number" then
                R = '"' .. R .. '"'
            end
            P = P .. "[" .. R .. "] = " .. dump(S) .. ","
        end
        return P .. "} "
    else
        return tostring(Q)
    end
end


RegisterNetEvent("cPropertyInv:openChestInventory")
AddEventHandler("cPropertyInv:openChestInventory", function(k, M, inventory, weapons, money)
    setChestInventoryData(k, M, inventory, weapons, money)
    if Property.ChestHUD then 
        openChestInventory()
    end
end)

RegisterNetEvent("cPropertyInv:refreshChestInventory")
AddEventHandler("cPropertyInv:refreshChestInventory", function(k, M, inventory, weapons, money)
    setChestInventoryData(k, M, inventory, weapons, money)
end)
function setChestInventoryData(k, M, inventory, weapons, money)
    local InvMenu
    local AccountsMenu
    local MoneyMenu
    local WeaponsMenu

    d = k;
    if not Property.ChestHUD then 
        CloseMenu(true)
        Wait(100)
        local menuTemplate = {
            Base = { Title = "Coffre", Header = {"commonmenu", "interaction_bgd"} },
            Data = { currentMenu = "Coffre" },
            Events = {
                onSelected = function(self, menuData, btnData, currentSlt, allButtons)
                    local slide = btnData.slidenum
                    local btn = btnData.name
                    
                    if menuData.currentMenu == "vos objets" then 
                        if not btnData.item then return ESX.ShowNotification("~r~Veuillez cliquer sur un item valide.") end
                        AskEntry(function(msg)
                            local count = tonumber(msg)
                            if count then 
                                if btnData.type == "item_weapon" then
                                    count = GetAmmoInPedWeapon(PlayerPedId(), GetHashKey(btnData.item))
                                end
                                TriggerServerEvent("cProperty_chest:putItem", d.plate, btnData.type, btnData.item, count, d.max, d.myVeh, btnData.name)
                                Wait(50)
                                LoadInvProperty()
                            else
                                ESX.ShowNotification("~r~Veuillez entrez une quantité valide.")
                            end
                        end, "Entrez le nombre d'item a déposer.")
                    elseif menuData.currentMenu == "les objets" then 
                        if not btnData.item then return ESX.ShowNotification("~r~Veuillez cliquer sur un item valide.") end
                        AskEntry(function(msg)
                            local count = tonumber(msg)
                            if count then 
                                TriggerServerEvent("cProperty_chest:getItem", d.plate, btnData.type, btnData.item, count, d.max, d.myVeh)
                                Wait(50)
                                LoadInvProperty()
                            else
                                ESX.ShowNotification("~r~Veuillez entrez une quantité valide.")
                            end
                        end, "Entrez le nombre d'item a déposer.")
                    end
                end,
            },
            Menu = {
                ["Coffre"] = {
                    b = {
                        {name = "Vos objets", ask = ">", askX = true},
                        {name = "Les objets", ask = ">", askX = true},
                    }
                },
                ["vos objets"] = {
                    b = function()
                        local table = {}
                        ESX.TriggerServerCallback("cPropertyInv:getPlayerInventory", function(k)
                            items = {}
                            InvMenu = k.inventory
                            AccountsMenu = k.accounts
                            MoneyMenu = k.money
                            WeaponsMenu = k.weapons
                        end, GetPlayerServerId(PlayerId()))
                        Wait(150)
                        if Config.IncludeCash and MoneyMenu ~= nil and MoneyMenu > 0 then
                            for G, w in pairs(AccountsMenu) do
                                table[#table+1] = {name = "Cash", item = "cash", price = MoneyMenu, type = "item_money"}
                            end
                        end
                        if Config.IncludeAccounts and AccountsMenu ~= nil then
                            for G, w in pairs(AccountsMenu) do
                                local H = w.name ~= "bank"
                                if w.money > 0 and H then
                                    table[#table+1] = {name = w.label, item = "black_money", price = w.money, type = "item_account"}
                                end
                            end
                        end
                        if InvMenu ~= nil then
                            for G, w in pairs(InvMenu) do
                                if w.count > 0 then
                                    table[#table+1] = {name = w.label.." ~b~x"..w.count, item = w.name, ask = ">", askX = true, type = "item_standard"}
                                end
                            end
                        end

                        if Config.IncludeWeapons and WeaponsMenu ~= nil then
                            for G, w in pairs(WeaponsMenu) do
                                local N = GetHashKey(w.name)
                                local m = PlayerPedId()
                                if w.name ~= "WEAPON_UNARMED" then
                                    table[#table+1] = {name = w.label.." ~b~x"..w.ammo, item = w.name, ask = ">", askX = true, type = "item_weapon"}
                                end
                            end
                        end

                        return table
                    end,
                },
                ["les objets"] = {
                    b = function()
                        local table = {}
                        table[#table+1] = {name = "~b~"..k.text}
                        if money > 0 then
                            table[#table+1] = {name = "Cash", item = "cash", price = money, type = "item_money"}
                        end
                        if M > 0 then
                            table[#table+1] = {name = "Argent sale", item = "black_money", price = M, type = "item_account"}
                        end
                        if inventory ~= nil then
                            for G, w in pairs(inventory) do
                                if w.count > 0 then
                                    table[#table+1] = {name = w.label.." ~b~x"..w.count, item = w.name, ask = ">", askX = true, type = "item_standard"}
                                end
                            end
                        end

                        return table
                    end,
                },
            }
        }
        CreateMenu(menuTemplate)
    elseif Property.ChestHUD then 
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
        if money then 
            if money > 0 then
                accountData = {
                    label = "Cash",
                    count = money,
                    type = "item_money",
                    name = "cash",
                    usable = false,
                    rare = false,
                    limit = -1,
                    canRemove = false
                }
                table.insert(items, accountData)
            end
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
end
function LoadInvProperty()
    ESX.TriggerServerCallback("cPropertyInv:getPlayerInventory", function(k)
        items = {}
        fastItems = {}
        inventory = k.inventory;
        accounts = k.accounts;
        money = k.money;
        weapons = k.weapons;
        E = inventory;

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
                --if not shouldSkipAccount(accounts[G].name) then
                    local H = accounts[G].name ~= "bank"
                    if accounts[G].money > 0 and H then
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
                --end
            end
        end
        if inventory ~= nil then
            for G, w in pairs(inventory) do
                if inventory[G].count <= 0 then
                    inventory[G] = nil
                else
                    inventory[G].type = "item_standard"
                    table.insert(items, inventory[G])
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
                        items[r].limit = A
                    end
                    z = z + A * (items[r].count or 1)
                end
            end
        end
        SendNUIMessage({
            action = "setItems",
            itemList = items,
            fastItems = fastItems,
            text = J
        })
    end, GetPlayerServerId(PlayerId()))
end
function openChestInventory()
    LoadInvProperty()
    e = true;
    local m = GetPlayerPed(-1)
    SendNUIMessage({
        action = "display",
        type = "Chest"
    })
    SetNuiFocus(true, true)
end

function ClosePropertyInv()
    e = false;
    f = false;
    SendNUIMessage({
        action = "hide"
    })
    SetNuiFocus(false, false)
end
RegisterNUICallback("NUIFocusOff", function()
    ClosePropertyInv()
    Citizen.Wait(50)
end)

RegisterNUICallback("PutIntoChest", function(k, l)
    local m = GetPlayerPed(-1)
    if type(k.number) == "number" and math.floor(k.number) == k.number then
        local s = tonumber(k.number)
        if k.item.type == "item_weapon" then
            s = GetAmmoInPedWeapon(PlayerPedId(), GetHashKey(k.item.name))
        end
        TriggerServerEvent("cProperty_chest:putItem", d.plate, k.item.type, k.item.name, s, d.max, d.myVeh, k.item.label)
    end
    Wait(50)
    LoadInvProperty()
    l("ok")
end)
RegisterNUICallback("TakeFromChest", function(k, l)
    local m = GetPlayerPed(-1)
    if type(k.number) == "number" and math.floor(k.number) == k.number then
        TriggerServerEvent("cProperty_chest:getItem", d.plate, k.item.type, k.item.name, tonumber(k.number), d.max, d.myVeh)
    end
    Wait(50)
    LoadInvProperty()
    l("ok")
end)