ESX = nil
local arrayWeight = Config.localWeight
local VehicleList = {}
local VehicleInventory = {}

TriggerEvent("esx:getSharedObject",function(obj) ESX = obj end)

function getItemWeight(item)
  local weight = 0
  local itemWeight = 0
  if item ~= nil then
    itemWeight = Config.DefaultWeight
    if arrayWeight[item] ~= nil then
      itemWeight = arrayWeight[item]
    end
  end
  return itemWeight
end

function getInventoryWeight(inventory)
  local weight = 0
  local itemWeight = 0
  if inventory ~= nil then
    for i = 1, #inventory, 1 do
      if inventory[i] ~= nil then
        itemWeight = Config.DefaultWeight
        if arrayWeight[inventory[i].name] ~= nil then
          itemWeight = arrayWeight[inventory[i].name]
        end
        weight = weight + (itemWeight * (inventory[i].count or 1))
      end
    end
  end
  return weight
end

function getTotalInventoryWeight(plate)
  local total
  TriggerEvent(
    "cProperty_chest:getSharedDataStore",
    plate,
    function(store)
      local W_weapons = getInventoryWeight(store.get("weapons") or {})
      local W_coffre = getInventoryWeight(store.get("coffre") or {})
      local W_blackMoney = 0
      local blackAccount = (store.get("black_money")) or 0
      if blackAccount ~= 0 then
        W_blackMoney = blackAccount[1].amount / 10
      end
      total = W_weapons + W_coffre
    end
  )
  return total
end

ESX.RegisterServerCallback("cProperty_chest:getInventoryV",function(source, cb, plate)
      TriggerEvent("cProperty_chest:getSharedDataStore", plate, function(store)
      local blackMoney = 0
      local money = 0
      local items = {}
      local weapons = {}
      weapons = (store.get("weapons") or {})
      local blackAccount = (store.get("black_money")) or 0
      if blackAccount ~= 0 then
        blackMoney = blackAccount[1].amount
      end
      local moneyAccount = (store.get("money")) or 0
      if moneyAccount ~= 0 then
        money = moneyAccount[1].amount
      end
      local coffre = (store.get("coffre") or {})
      for i = 1, #coffre, 1 do
        table.insert(items, {name = coffre[i].name, count = coffre[i].count, label = ESX.GetItemLabel(coffre[i].name)})
      end
      local weight = getTotalInventoryWeight(plate)
      cb({
          blackMoney = blackMoney,
          money = money,
          items = items,
          weapons = weapons,
          weight = weight
        })
    end)
end)

RegisterServerEvent("cProperty_chest:getItem")
AddEventHandler(
  "cProperty_chest:getItem",
  function(plate, type, item, count, max, owned)
    local _source = source
    local xPlayer = ESX.GetPlayerFromId(_source)

    if type == "item_standard" then
      local targetItem = xPlayer.getInventoryItem(item)
      --if targetItem.limit == -1 or ((targetItem.count + count) <= targetItem.limit) then
        TriggerEvent("cProperty_chest:getSharedDataStore",plate,function(store)
            local coffre = (store.get("coffre") or {})
            for i = 1, #coffre, 1 do
              if coffre[i].name == item then
                if (coffre[i].count >= count and count > 0) then
                  xPlayer.addInventoryItem(item, count)
                  if (coffre[i].count - count) == 0 then
                    table.remove(coffre, i)
                  else
                    coffre[i].count = coffre[i].count - count
                  end
                  break
                else
                  TriggerClientEvent("esx:showNotification", xPlayer.source, "~r~Quantité invalide.")
                end
              end
            end

            store.set("coffre", coffre)

            local blackMoney = 0
            local items = {}
            local weapons = {}
            weapons = (store.get("weapons") or {})

            local blackAccount = (store.get("black_money")) or 0
            if blackAccount ~= 0 then
              blackMoney = blackAccount[1].amount
            end

            local money = 0
            local moneyAccount = (store.get("money")) or 0
            if moneyAccount ~= 0 then
              money = moneyAccount[1].amount
            end

            local coffre = (store.get("coffre") or {})
            for i = 1, #coffre, 1 do
              table.insert(items, {name = coffre[i].name, count = coffre[i].count, label = ESX.GetItemLabel(coffre[i].name)})
            end

            local weight = getTotalInventoryWeight(plate)

            text = _U("Chest_info", (weight), (max))
            data = {plate = plate, max = max, myVeh = owned, text = text}
            TriggerClientEvent("cPropertyInv:refreshChestInventory", _source, data, blackMoney, items, weapons, money)
          end
        )
      --else
        --TriggerClientEvent('esx:showNotification', xPlayer.source, "~r~Vous n'avez pas assez de place sur vous." )
      --end
    end

    if type == "item_account" then
      TriggerEvent(
        "cProperty_chest:getSharedDataStore",
        plate,
        function(store)
          local blackMoney = store.get("black_money")
          if (blackMoney[1].amount >= count and count > 0) then
            blackMoney[1].amount = blackMoney[1].amount - count
            store.set("black_money", blackMoney)
            xPlayer.addAccountMoney(item, count)

            local blackMoney = 0
            local items = {}
            local weapons = {}
            weapons = (store.get("weapons") or {})

            local blackAccount = (store.get("black_money")) or 0
            if blackAccount ~= 0 then
              blackMoney = blackAccount[1].amount
            end

            local money = 0
            local moneyAccount = (store.get("money")) or 0
            if moneyAccount ~= 0 then
              money = moneyAccount[1].amount
            end

            local coffre = (store.get("coffre") or {})
            for i = 1, #coffre, 1 do
              table.insert(items, {name = coffre[i].name, count = coffre[i].count, label = ESX.GetItemLabel(coffre[i].name)})
            end

            local weight = getTotalInventoryWeight(plate)

            text = _U("Chest_info", (weight), (max))
            data = {plate = plate, max = max, myVeh = owned, text = text}
            TriggerClientEvent("cPropertyInv:refreshChestInventory", _source, data, blackMoney, items, weapons, money)
          else
            TriggerClientEvent('esx:showNotification', xPlayer.source, _U("invalid_amount") )
          end
        end
      )
    end

    if type == "item_money" then
      TriggerEvent(
        "cProperty_chest:getSharedDataStore",
        plate,
        function(store)
          local blackMoney = store.get("money")
          if (blackMoney[1].amount >= count and count > 0) then
            blackMoney[1].amount = blackMoney[1].amount - count
            store.set("money", blackMoney)
            xPlayer.addMoney(count)

            local blackMoney = 0
            local items = {}
            local weapons = {}
            weapons = (store.get("weapons") or {})

            local blackAccount = (store.get("black_money")) or 0
            if blackAccount ~= 0 then
              blackMoney = blackAccount[1].amount
            end

            local money = 0
            local moneyAccount = (store.get("money")) or 0
            if moneyAccount ~= 0 then
              money = moneyAccount[1].amount
            end

            local coffre = (store.get("coffre") or {})
            for i = 1, #coffre, 1 do
              table.insert(items, {name = coffre[i].name, count = coffre[i].count, label = ESX.GetItemLabel(coffre[i].name), weapHash = coffre[i].compo, tint = coffre[i].tint})
            end

            local weight = getTotalInventoryWeight(plate)

            text = ""..weight.." / " ..max.. "Kg"
            data = {plate = plate, max = max, myVeh = owned, text = text}
            TriggerClientEvent("cPropertyInv:refreshChestInventory", _source, data, blackMoney, items, weapons, money)
          else
            TriggerClientEvent('esx:showNotification', xPlayer.source, _U("invalid_amount"), "danger" )
          end
        end
      )
    end

    if type == "item_weapon" then
      TriggerEvent(
        "cProperty_chest:getSharedDataStore",
        plate,
        function(store)
          local storeWeapons = store.get("weapons")

          if storeWeapons == nil then
            storeWeapons = {}
          end

          local weaponName = nil
          local ammo = nil

          for i = 1, #storeWeapons, 1 do
            if storeWeapons[i].name == item then
              weaponName = storeWeapons[i].name
              ammo = storeWeapons[i].ammo

              table.remove(storeWeapons, i)

              break
            end
          end

          store.set("weapons", storeWeapons)

          xPlayer.addWeapon(weaponName, ammo)

          local blackMoney = 0
          local items = {}
          local weapons = {}
          weapons = (store.get("weapons") or {})

          local blackAccount = (store.get("black_money")) or 0
          if blackAccount ~= 0 then
            blackMoney = blackAccount[1].amount
          end

          local money = 0
          local moneyAccount = (store.get("money")) or 0
          if moneyAccount ~= 0 then
            money = moneyAccount[1].amount
          end

          local coffre = (store.get("coffre") or {})
          for i = 1, #coffre, 1 do
            table.insert(items, {name = coffre[i].name, count = coffre[i].count, label = ESX.GetItemLabel(coffre[i].name)})
          end

          local weight = getTotalInventoryWeight(plate)

          text = _U("Chest_info", (weight), (max))
          data = {plate = plate, max = max, myVeh = owned, text = text}
          TriggerClientEvent("cPropertyInv:refreshChestInventory", _source, data, blackMoney, items, weapons, money)
        end
      )
    end
  end
)

RegisterServerEvent("cProperty_chest:putItem")
AddEventHandler(
  "cProperty_chest:putItem",
  function(plate, type, item, count, max, owned, label)
    local _source = source
    local xPlayer = ESX.GetPlayerFromId(_source)
    local xPlayerOwner = ESX.GetPlayerFromIdentifier(owner)

    if type == "item_standard" then
      local playerItemCount = xPlayer.getInventoryItem(item).count
      local playerItemName = xPlayer.getInventoryItem(item)

      if (playerItemCount >= count and count > 0) then
        TriggerEvent(
          "cProperty_chest:getSharedDataStore",
          plate,
          function(store)
            local found = false
            local coffre = (store.get("coffre") or {})

            for i = 1, #coffre, 1 do
              if coffre[i].name == item then
                coffre[i].count = coffre[i].count + count
                found = true
              end
            end
            if not found then
              table.insert(
                coffre,
                {
                  name = item,
                  count = count
                }
              )
            end
            if tonumber((getTotalInventoryWeight(plate) + (getItemWeight(item) * count))) > tonumber(max) then
              TriggerClientEvent('esx:showNotification', xPlayer.source, _U("insufficient_space"))
            else
              -- Checks passed, storing the item.
              xPlayer.removeInventoryItem(item, count)
			        store.set("coffre", coffre)

              MySQL.Async.execute(
                "UPDATE data_inventory SET owned = @owned WHERE plate = @plate",
                {
                  ["@plate"] = plate,
                  ["@owned"] = true
                }
              )
            end
          end
        )
      else
        TriggerClientEvent("esx:showNotification", xPlayer.source, "~r~Quantité invalide.")
      end
    end

    if type == "item_account" then
      local playerAccountMoney = xPlayer.getAccount(item).money

      if (playerAccountMoney >= count and count > 0) then
        TriggerEvent(
          "cProperty_chest:getSharedDataStore",
          plate,
          function(store)
            local blackMoney = (store.get("black_money") or nil)
            if blackMoney ~= nil then
              blackMoney[1].amount = blackMoney[1].amount + count
            else
              blackMoney = {}
              table.insert(blackMoney, {amount = count})
            end

              xPlayer.removeAccountMoney(item, count)
              store.set("black_money", blackMoney)

              MySQL.Async.execute(
                "UPDATE data_inventory SET owned = @owned WHERE plate = @plate",
                {
                  ["@plate"] = plate,
                  ["@owned"] = true
                }
              )
          end
        )
      else
        TriggerClientEvent('esx:showNotification', xPlayer.source, _U("invalid_amount") )
      end
    end

    if type == "item_weapon" then
      TriggerEvent(
        "cProperty_chest:getSharedDataStore",
        plate,
        function(store)
          local storeWeapons = store.get("weapons")

          if storeWeapons == nil then
            storeWeapons = {}
          end

          table.insert(
            storeWeapons,
            {
              name = item,
              label = label,
              ammo = count
            }
          )
          if (getTotalInventoryWeight(plate) + (getItemWeight(item))) > max then
            TriggerClientEvent('esx:showNotification', xPlayer.source, _U("insufficient_space") )
          else
            store.set("weapons", storeWeapons)
            xPlayer.removeWeapon(item)

            MySQL.Async.execute(
              "UPDATE data_inventory SET owned = @owned WHERE plate = @plate",
              {
                ["@plate"] = plate,
                ["@owned"] = true
              }
            )
          end
        end
      )
    end

    if type == "item_money" then
      local playerAccountMoney = xPlayer.getMoney()

      if (playerAccountMoney >= count and count > 0) then
        TriggerEvent(
          "cProperty_chest:getSharedDataStore",
          plate,
          function(store)
            local blackMoney = (store.get("money") or nil)
            if blackMoney ~= nil then
              blackMoney[1].amount = blackMoney[1].amount + count
            else
              blackMoney = {}
              table.insert(blackMoney, {amount = count})
            end


              -- Checks passed. Storing the item.
              xPlayer.removeMoney(count)
              store.set("money", blackMoney)

              MySQL.Async.execute(
                "UPDATE data_inventory SET owned = @owned WHERE plate = @plate",
                {
                  ["@plate"] = plate,
                  ["@owned"] = true
                }
              )

          end
        )
      else
        TriggerClientEvent('esx:showNotification', xPlayer.source, _U("invalid_amount"))
      end
    end

    TriggerEvent(
      "cProperty_chest:getSharedDataStore",
      plate,
      function(store)
        local blackMoney = 0
        local items = {}
        local weapons = {}
        weapons = (store.get("weapons") or {})

        local blackAccount = (store.get("black_money")) or 0
        if blackAccount ~= 0 then
          blackMoney = blackAccount[1].amount
        end

        local money = 0
        local moneyAccount = (store.get("money")) or 0
        if moneyAccount ~= 0 then
          money = moneyAccount[1].amount
        end

        local coffre = (store.get("coffre") or {})
        for i = 1, #coffre, 1 do
          table.insert(items, {name = coffre[i].name, count = coffre[i].count, label = ESX.GetItemLabel(coffre[i].name)})
        end

        local weight = getTotalInventoryWeight(plate)

        text = _U("Chest_info", (weight), (max))
        data = {plate = plate, max = max, myVeh = owned, text = text}
        TriggerClientEvent("cPropertyInv:refreshChestInventory", _source, data, blackMoney, items, weapons, money)
      end
    )
  end
)

ESX.RegisterServerCallback(
  "cProperty_chest:getPlayerInventory",
  function(source, cb)
    local xPlayer = ESX.GetPlayerFromId(source)
    local blackMoney = xPlayer.getAccount("black_money").money
    local items = xPlayer.inventory

    cb(
      {
        blackMoney = blackMoney,
        items = items
      }
    )
  end
)

function all_trim(s)
  if s then
    return s:match "^%s*(.*)":match "(.-)%s*$"
  else
    return "noTagProvided"
  end
end
