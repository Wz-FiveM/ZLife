inMenu                      = true
ESX = nil
local bank = 0
local firstname = ''
local lastname = ''

function setBankBalance (value)
      bank = value
      SendNUIMessage({event = 'updateBankbalance', banking = bank})
end

RegisterNetEvent('esx:playerLoaded')
AddEventHandler('esx:playerLoaded', function(playerData)
      local accounts = playerData.accounts or {}
      for index, account in ipairs(accounts) do 
            if account.name == 'bank' then
                  setBankBalance(account.money)
                  break
            end
      end
end)

RegisterNetEvent('esx:setAccountMoney')
AddEventHandler('esx:setAccountMoney', function(account)
      if account.name == 'bank' then
            setBankBalance(account.money)
      end
end)

RegisterNetEvent("es:addedBank")
AddEventHandler("es:addedBank", function(m)
      setBankBalance(bank + m)
end)

RegisterNetEvent("es:removedBank")
AddEventHandler("es:removedBank", function(m)
      setBankBalance(bank - m)
end)

RegisterNetEvent('es:displayBank')
AddEventHandler('es:displayBank', function(bank)
      setBankBalance(bank)
end)

RegisterNUICallback('transfer', function(data)
	TriggerServerEvent('gcPhone:transfer', data.to, data.amountt)
end)

RegisterNetEvent("gcPhone:firstname")
AddEventHandler("gcPhone:firstname", function(_firstname)
  firstname = _firstname
  SendNUIMessage({event = 'updateMyFirstname', firstname = firstname})
end)

RegisterNetEvent("gcPhone:lastname")
AddEventHandler("gcPhone:lastname", function(_lastname)
  lastname = _lastname
  SendNUIMessage({event = 'updateMyListname', lastname = lastname})
end)


RegisterNetEvent("gcPhone:bank_getBilling")
AddEventHandler("gcPhone:bank_getBilling", function(bankkkkk)
  SendNUIMessage({event = 'bank_billingg', bankkkkk = bankkkkk})
end)

RegisterNUICallback('bank_getBilling', function(data, cb)
  TriggerServerEvent('gcPhone:bank_getBilling', data.type, data.price, data.name)
end)