ESX = nil
Items = {}
local DataStoresIndex = {}
local DataStores = {}
local SharedDataStores = {}

TriggerEvent(
  "esx:getSharedObject",
  function(obj)
    ESX = obj
  end
)

ESX.RegisterServerCallback("cPropertyInv:getPlayerInventory",
	function(source, cb, target)
		local targetXPlayer = ESX.GetPlayerFromId(target)

		if targetXPlayer ~= nil then
			cb({inventory = targetXPlayer.inventory, money = targetXPlayer.getMoney(), accounts = targetXPlayer.accounts, weapons = targetXPlayer.loadout})
		else
			cb(nil)
		end
	end
)

AddEventHandler("onResourceStart", function()
  Wait(1000)
  local result = MySQL.Sync.fetchAll("SELECT * FROM data_inventory")
  local data = nil
  if #result ~= 0 then
    for i = 1, #result, 1 do
      local plate = result[i].plate
      local owned = result[i].owned
      local data = (result[i].data == nil and {} or json.decode(result[i].data))
      local dataStore = CreateDataStore(plate, owned, data)
      SharedDataStores[plate] = dataStore
    end
  end
end)

function loadInvent(plate)
  local result =
    MySQL.Sync.fetchAll(
    "SELECT * FROM data_inventory WHERE plate = @plate",
    {
      ["@plate"] = plate
    }
  )
  local data = nil
  if #result ~= 0 then
    for i = 1, #result, 1 do
      local plate = result[i].plate
      local owned = result[i].owned
      local data = (result[i].data == nil and {} or json.decode(result[i].data))
      local dataStore = CreateDataStore(plate, owned, data)
      SharedDataStores[plate] = dataStore
    end
  end
end

function MakeDataStore(plate)
  local data = {}
  local owned = true
  local dataStore = CreateDataStore(plate, owned, data)
  SharedDataStores[plate] = dataStore
  MySQL.Async.execute(
    "INSERT INTO data_inventory(plate,data,owned) VALUES (@plate,'{}',@owned)",
    {
      ["@plate"] = plate,
      ["@owned"] = true
    }
  )
  loadInvent(plate)
end

function GetSharedDataStore(plate)
  if SharedDataStores[plate] == nil then
    MakeDataStore(plate)
  end
  return SharedDataStores[plate]
end

AddEventHandler(
  "cProperty_chest:getSharedDataStore",
  function(plate, cb)
    cb(GetSharedDataStore(plate))
  end
)
