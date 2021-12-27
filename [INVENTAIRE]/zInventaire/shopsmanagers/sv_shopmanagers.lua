RegisterServerEvent("ESX:saveClothes")
AddEventHandler("ESX:saveClothes", function(type, skin, name, multiplier)
    local xPlayer = ESX.GetPlayerFromId(source)
    
    if name and type and skin then 
        MySQL.Async.execute("INSERT INTO clothes(identifier, skin, type, name) VALUES(@identifier, @skin, @type, @name)", {
            ["@identifier"] = xPlayer.getIdentifier(),
            ["@skin"] = json.encode(skin),
            ["type"] = type,
            ["@name"] = name
        })
    end
    --TriggerClientEvent('ESX:showNotification', xPlayer.source, "Vous venez de sauvegarder votre tenue (~b~"..name.."~s~).", "danger")
end)

ESX.RegisterServerCallback("cClothes:getPlayerClothes", function(source, cb)
    local xPlayer = ESX.GetPlayerFromId(source)

    MySQL.Async.fetchAll("SELECT * FROM clothes WHERE identifier = @identifier", {
        ["@identifier"] = xPlayer.getIdentifier()
    }, function(result)
        cb(result)
    end)
end)

ESX.RegisterServerCallback('ESX_skin:getPlayerSkin', function(source, cb)
	local xPlayer = ESX.GetPlayerFromId(source)

	MySQL.Async.fetchAll('SELECT * FROM users WHERE identifier = @identifier', {
		['@identifier'] = xPlayer.identifier
	}, function(users)
		local user = users[1]
		local skin = nil

		local jobSkin = {
			skin_male   = xPlayer.job.skin_male,
			skin_female = xPlayer.job.skin_female
		}

		if user.skin ~= nil then
			skin = json.decode(user.skin)
		end

		cb(skin, jobSkin)
	end)
end)

RegisterServerEvent('ESX:ResellItem')
AddEventHandler('ESX:ResellItem', function(item, money1, money2)
	local src = source
    local xPlayer = ESX.GetPlayerFromId(src)
    local price = math.random(money1, money2)
    local items = xPlayer.getInventoryItem(item)
    local total = price * items.count
    if items.count < 1 then 
        TriggerClientEvent('ESX:showNotification', source, "~r~Vous n'avez plus de produits à vendre.")
    else   
        TriggerClientEvent('ESX:showNotification', source, "Vous avez vendu ~b~x"..items.count.."~s~ produits pour ~g~"..total.."$~s~.")
        xPlayer.removeInventoryItem(item, items.count)
        xPlayer.addMoney(total)
    end
end)

RegisterServerEvent("ESX:deleteClothe")
AddEventHandler("ESX:deleteClothe", function(id)
    MySQL.Async.execute("DELETE FROM clothes WHERE id = @id", {
        ["@id"] = id
    })
end)

RegisterServerEvent("tattoos:GetPlayerTattoos_s")
AddEventHandler("tattoos:GetPlayerTattoos_s", function()
    local _source = source
    local xPlayer = ESX.GetPlayerFromId(source)
    MySQL.Async.fetchAll("SELECT * FROM user_tattoos WHERE identifier = @identifier", {['@identifier'] = xPlayer.getIdentifier()}, function(result)
        if(result[1] ~= nil) then
            local tattoosList = json.decode(result[1].tattoos)
            TriggerClientEvent("tattoos:getPlayerTattoos", _source, tattoosList)
        else
            local tattooValue = json.encode({})
            MySQL.Async.execute("INSERT INTO user_tattoos (identifier, tattoos) VALUES (@identifier, @tattoo)", {['@identifier'] = xPlayer.getIdentifier(), ['@tattoo'] = tattooValue})
            TriggerClientEvent("tattoos:getPlayerTattoos", _source, {})
        end
    end)
end)

RegisterServerEvent("tattoos:delete")
AddEventHandler("tattoos:delete", function()
      local _source = source
      local xPlayer = ESX.GetPlayerFromId(_source)

    MySQL.Async.execute('DELETE FROM user_tattoos WHERE identifier = @identifier', {
      ['@identifier'] = xPlayer.getIdentifier()
    }, function(rowsChanged)
      tattoosList = {}
      TriggerClientEvent('ESX:showNotification', xPlayer.source, "~r~Vous venez de supprimer tous vos tatouages.", "danger")
    end)
end)

RegisterServerEvent("tattoos:save")
AddEventHandler("tattoos:save", function(tattoosList, value)
      local _source = source
      local xPlayer = ESX.GetPlayerFromId(_source)

      table.insert(tattoosList,value)
      MySQL.Async.execute("UPDATE user_tattoos SET tattoos = @tattoos WHERE identifier = @identifier", {['@tattoos'] = json.encode(tattoosList), ['@identifier'] = xPlayer.getIdentifier()})
      TriggerClientEvent("tattoo:buySuccess", _source, value)
      TriggerClientEvent("ESX:showNotification", _source, "~g~Vous venez de vous faire un tatouage.", "success")
end)



ESX.RegisterServerCallback("ESX:PayMoney", function(source, cb, money)
	local xPlayer = ESX.GetPlayerFromId(source)

	if xPlayer.getMoney() >= money then
		cb(true)
		xPlayer.removeMoney(money)
	else
		cb(false)
	end
end)