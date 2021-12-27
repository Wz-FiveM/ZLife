ESX = nil

TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)


RegisterServerEvent('gcPhone:transfer')
AddEventHandler('gcPhone:transfer', function(to, amountt)
    local _source = source
    local xPlayer = ESX.GetPlayerFromId(_source)
    local zPlayer = ESX.GetPlayerFromId(to)
    local balance = 0
    if zPlayer ~= nil then
        balance = xPlayer.getAccount('bank').money
        zbalance = zPlayer.getAccount('bank').money
        if tonumber(_source) == tonumber(to) then
            TriggerClientEvent('esx:showNotification', _source, '~r~Vous ne pouvez pas vous envoyer à vous même.')
        else
            if balance <= 0 or balance < tonumber(amountt) or tonumber(amountt) <= 0 then
                TriggerClientEvent('esx:showNotification', _source, "~r~Vous n'avez pas assez d'argent.")
            else
                xPlayer.removeAccountMoney('bank', tonumber(amountt))
                zPlayer.addAccountMoney('bank', tonumber(amountt))
                TriggerClientEvent('esx:showNotification', _source, 'Vous avez envoyé ~g~' .. amountt .. '$~s~ au destinataire.')
                TriggerClientEvent('esx:showNotification', to, 'Vous avez reçu ~g~' .. amountt .. '$~s~.')
                MySQL.Async.fetchAll("SELECT * FROM users WHERE identifier = @identifier", {
                    ['@identifier'] = zPlayer.identifier,
                }, function(result)
                    if result[1] then
                        local name = result[1].firstname .. " " .. result[1].lastname
                        MySQL.Async.fetchAll("INSERT INTO bank_transfer (type, identifier, price, name) VALUES (@type, @identifier, @price, @name)", {
                            ["@type"] = 1,
                            ["@identifier"] = xPlayer.identifier,
                            ["@price"] = amountt,
                            ["@name"] = name
                        }, function(results)
                        end)
                    end
                end)
			   MySQL.Async.fetchAll("SELECT * FROM users WHERE identifier = @identifier", {
                    ['@identifier'] = xPlayer.identifier,
                }, function(result)
                    if result[1] then
                        local name = result[1].firstname .. " " .. result[1].lastname
                        MySQL.Async.fetchAll("INSERT INTO bank_transfer (type, identifier, price, name) VALUES (@type, @identifier, @price, @name)", {
                            ["@type"] = 2,
                            ["@identifier"] = zPlayer.identifier,
                            ["@price"] = amountt,
                            ["@name"] = name
                        }, function(resultss)
                        end)
                    end
                end)
            end
        end
    end
end)

function getorfirstname (sourcePlayer, identifier, cb)
    local sourcePlayer = sourcePlayer
    local identifier = identifier
    local firstname = getFirstname(identifier)
	local lastname = getLastname(identifier)
end

function getFirstname(identifier)
    local result = MySQL.Sync.fetchAll("SELECT users.firstname FROM users WHERE users.identifier = @identifier", {
        ['@identifier'] = identifier
    })
    if result[1] ~= nil then
        return result[1].firstname
    end
    return nil
end

function getLastname(identifier)
    local result = MySQL.Sync.fetchAll("SELECT users.lastname FROM users WHERE users.identifier = @identifier", {
        ['@identifier'] = identifier
    })
    if result[1] ~= nil then
        return result[1].lastname
    end
    return nil
end


function BankGetBilling (accountId, cb)
  local xPlayer = ESX.GetPlayerFromId(source)
    MySQL.Async.fetchAll([===[
      SELECT * FROM bank_transfer WHERE identifier = @identifier ORDER BY time DESC LIMIT 10
      ]===], { ['@identifier'] = xPlayer.identifier }, cb)
  end 
  
  
  function getUserBank(phone_number, firstname, cb)
  MySQL.Async.fetchAll("SELECT firstname, phone_number FROM users WHERE users.firstname = @firstname AND users.phone_number = @phone_number", {
    ['@phone_number'] = phone_number,
	['@firstname'] = firstname
  }, function (data)
    cb(data[1])
  end)
end

RegisterServerEvent('gcPhone:bank_getBilling')
AddEventHandler('gcPhone:bank_getBilling', function(phone_number, firstname)
  local sourcePlayer = tonumber(source)
  if phone_number ~= nil and phone_number ~= "" and firstname ~= nil and firstname ~= "" then
    getUserBank(phone_number, firstname, function (user)
      local accountId = user and user.id
      BankGetBilling(accountId, function (bankkkkk)
        TriggerClientEvent('gcPhone:bank_getBilling', sourcePlayer, bankkkkk)
      end)
    end)
  else
    BankGetBilling(nil, function (bankkkkk)
      TriggerClientEvent('gcPhone:bank_getBilling', sourcePlayer, bankkkkk)
    end)
  end
end)