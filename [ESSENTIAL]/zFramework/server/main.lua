AddEventHandler('es:playerLoaded', function(source, _player)
	local _source = source
	local tasks   = {}

	local userData = {
		accounts     = {},
		inventory    = {},
		job          = {},
		org          = {},
		loadout      = {},
		playerName   = GetPlayerName(_source),
		lastPosition = nil
	}

	TriggerEvent('es:getPlayerFromId', _source, function(player)
		-- Update user name in DB
		table.insert(tasks, function(cb)
			MySQL.Async.execute('UPDATE `users` SET `name` = @name WHERE `identifier` = @identifier', {
				['@identifier'] = player.getIdentifier(),
				['@name'] = userData.playerName
			}, function(rowsChanged)
				cb()
			end)
		end)

		-- Get accounts
		table.insert(tasks, function(cb)
			MySQL.Async.fetchAll('SELECT * FROM `user_accounts` WHERE `identifier` = @identifier', {
				['@identifier'] = player.getIdentifier()
			}, function(accounts)
				for i=1, #Config.Accounts, 1 do
					for j=1, #accounts, 1 do
						if accounts[j].name == Config.Accounts[i] then
							table.insert(userData.accounts, {
								name  = accounts[j].name,
								money = accounts[j].money,
								label = Config.AccountLabels[accounts[j].name]
							})
							break
						end
					end
				end

				cb()
			end)
		end)

		-- Get inventory
		table.insert(tasks, function(cb)

			MySQL.Async.fetchAll('SELECT * FROM `user_inventory` WHERE `identifier` = @identifier', {
				['@identifier'] = player.getIdentifier()
			}, function(inventory)
				local tasks2 = {}

				for i=1, #inventory do
					local item = ESX.Items[inventory[i].item]

					if item then
						table.insert(userData.inventory, {
							name = inventory[i].item,
							count = inventory[i].count,
							label = item.label,
							limit = item.limit,
							usable = ESX.UsableItemsCallbacks[inventory[i].item] ~= nil,
							rare = item.rare,
							canRemove = item.canRemove
						})
					else
						print(('es_extended: invalid item "%s" ignored!'):format(inventory[i].item))
					end
				end

				for k,v in pairs(ESX.Items) do
					local found = false

					for j=1, #userData.inventory do
						if userData.inventory[j].name == k then
							found = true
							break
						end
					end

					if not found then
						table.insert(userData.inventory, {
							name = k,
							count = 0,
							label = ESX.Items[k].label,
							limit = ESX.Items[k].limit,
							usable = ESX.UsableItemsCallbacks[k] ~= nil,
							rare = ESX.Items[k].rare,
							canRemove = ESX.Items[k].canRemove
						})

						local scope = function(item, identifier)
							table.insert(tasks2, function(cb2)
								MySQL.Async.execute('INSERT INTO user_inventory (identifier, item, count) VALUES (@identifier, @item, @count)', {
									['@identifier'] = identifier,
									['@item'] = item,
									['@count'] = 0
								}, function(rowsChanged)
									cb2()
								end)
							end)
						end

						scope(k, player.getIdentifier())
					end

				end

				Async.parallelLimit(tasks2, 5, function(results) end)

				table.sort(userData.inventory, function(a,b)
					return a.label < b.label
				end)

				cb()
			end)

		end)

		-- Get job and loadout
		table.insert(tasks, function(cb)

			local tasks2 = {}

			-- Get job name, grade and last position
			table.insert(tasks2, function(cb2)

				MySQL.Async.fetchAll('SELECT job, job_grade, org, org_gradeorg, loadout, position FROM `users` WHERE `identifier` = @identifier', {
					['@identifier'] = player.getIdentifier()
				}, function(result)
					local job, grade = result[1].job, tostring(result[1].job_grade)

					if ESX.DoesJobExist(job, grade) then
						local jobObject, gradeObject = ESX.Jobs[job], ESX.Jobs[job].grades[grade]

						userData.job = {}

						userData.job.id    = jobObject.id
						userData.job.name  = jobObject.name
						userData.job.label = jobObject.label

						userData.job.grade        = tonumber(grade)
						userData.job.grade_name   = gradeObject.name
						userData.job.grade_label  = gradeObject.label
						userData.job.grade_salary = gradeObject.salary

						userData.job.skin_male    = {}
						userData.job.skin_female  = {}

						if gradeObject.skin_male ~= nil then
							userData.job.skin_male = json.decode(gradeObject.skin_male)
						end
			
						if gradeObject.skin_female ~= nil then
							userData.job.skin_female = json.decode(gradeObject.skin_female)
						end
					else
						print(('es_extended: %s had an unknown job [job: %s, grade: %s], setting as unemployed!'):format(player.getIdentifier(), job, grade))

						local job, grade = 'unemployed', '0'
						local jobObject, gradeObject = ESX.Jobs[job], ESX.Jobs[job].grades[grade]

						userData.job = {}

						userData.job.id    = jobObject.id
						userData.job.name  = jobObject.name
						userData.job.label = jobObject.label
			
						userData.job.grade        = tonumber(grade)
						userData.job.grade_name   = gradeObject.name
						userData.job.grade_label  = gradeObject.label
						userData.job.grade_salary = gradeObject.salary
			
						userData.job.skin_male    = {}
						userData.job.skin_female  = {}
					end

					local org, gradeorg = result[1].org, tostring(result[1].org_gradeorg)

					if ESX.DoesOrgExist(org, gradeorg) then
						local orgObject, gradeorgObject = ESX.Org[org], ESX.Org[org].gradeorg[gradeorg]

						userData.org = {}

						userData.org.id    = orgObject.id
						userData.org.name  = orgObject.name
						userData.org.label = orgObject.label

						userData.org.gradeorg        = tonumber(gradeorg)
						userData.org.gradeorg_name   = gradeorgObject.name
						userData.org.gradeorg_label  = gradeorgObject.label
						userData.org.gradeorg_salary = gradeorgObject.salary

						userData.org.skin_male    = {}
						userData.org.skin_female  = {}

						if gradeorgObject.skin_male ~= nil then
							userData.org.skin_male = json.decode(gradeorgObject.skin_male)
						end
			
						if gradeorgObject.skin_female ~= nil then
							userData.org.skin_female = json.decode(gradeorgObject.skin_female)
						end
					else
						print(('es_extended: %s had an unknown org [org: %s, gradeorg: %s], setting as unemployed!'):format(player.getIdentifier(), org, gradeorg))

						local org, gradeorg = 'organisation', '0'
						local orgObject, gradeorgObject = ESX.Org[org], ESX.Org[org].gradeorg[gradeorg]

						userData.org = {}

						userData.org.id    = orgObject.id
						userData.org.name  = orgObject.name
						userData.org.label = orgObject.label
			
						userData.org.gradeorg        = tonumber(gradeorg)
						userData.org.gradeorg_name   = gradeorgObject.name
						userData.org.gradeorg_label  = gradeorgObject.label
						userData.org.gradeorg_salary = gradeorgObject.salary
			
						userData.org.skin_male    = {}
						userData.org.skin_female  = {}
					end

					if result[1].loadout ~= nil then
						userData.loadout = json.decode(result[1].loadout)

						-- Compatibility with old loadouts prior to components update
						for k,v in ipairs(userData.loadout) do
							if v.components == nil then
								v.components = {}
							end
						end
					end

					if result[1].position ~= nil then
						userData.lastPosition = json.decode(result[1].position)
					end

					cb2()
				end)

			end)

			Async.series(tasks2, cb)

		end)

		-- Run Tasks
		Async.parallel(tasks, function(results)
			local xPlayer = CreateExtendedPlayer(player, userData.accounts, userData.inventory, userData.job, userData.org, userData.loadout, userData.playerName, userData.lastPosition)

			xPlayer.getMissingAccounts(function(missingAccounts)
				if #missingAccounts > 0 then

					for i=1, #missingAccounts, 1 do
						table.insert(xPlayer.accounts, {
							name  = missingAccounts[i],
							money = 0,
							label = Config.AccountLabels[missingAccounts[i]]
						})
					end

					xPlayer.createAccounts(missingAccounts)
				end

				ESX.Players[_source] = xPlayer

				TriggerEvent('esx:playerLoaded', _source, xPlayer)

				TriggerClientEvent('esx:playerLoaded', _source, {
					identifier   = xPlayer.identifier,
					accounts     = xPlayer.getAccounts(),
					inventory    = xPlayer.getInventory(),
					job          = xPlayer.getJob(),
					org         = xPlayer.getOrg(),
					loadout      = xPlayer.getLoadout(),
					lastPosition = xPlayer.getLastPosition(),
					money        = xPlayer.getMoney()
				})

				xPlayer.displayMoney(xPlayer.getMoney())
			end)
		end)

	end)
end)

AddEventHandler('playerDropped', function(reason)
	local _source = source
	local xPlayer = ESX.GetPlayerFromId(_source)

	if xPlayer then
		TriggerEvent('esx:playerDropped', _source, reason)

		ESX.SavePlayer(xPlayer, function()
			ESX.Players[_source] = nil
			ESX.LastPlayerData[_source] = nil
		end)
	end
end)

RegisterServerEvent('esx:updateLoadout')
AddEventHandler('esx:updateLoadout', function(loadout)
	local xPlayer = ESX.GetPlayerFromId(source)
	xPlayer.loadout = loadout
end)

RegisterServerEvent('esx:updateLastPosition')
AddEventHandler('esx:updateLastPosition', function(position)
	local xPlayer = ESX.GetPlayerFromId(source)
	xPlayer.setLastPosition(position)
end)

RegisterServerEvent('esx:giveInventoryItem')
AddEventHandler('esx:giveInventoryItem', function(target, type, itemName, itemCount)
	local _source = source

	local sourceXPlayer = ESX.GetPlayerFromId(_source)
	local targetXPlayer = ESX.GetPlayerFromId(target)

	if type == 'item_standard' then

		local sourceItem = sourceXPlayer.getInventoryItem(itemName)
		local targetItem = targetXPlayer.getInventoryItem(itemName)

		if itemCount > 0 and sourceItem.count >= itemCount then

			if targetItem.limit ~= -1 and (targetItem.count + itemCount) > targetItem.limit then
				TriggerClientEvent('esx:showNotification', _source, _U('ex_inv_lim', targetXPlayer.name))
			else
				sourceXPlayer.removeInventoryItem(itemName, itemCount)
				targetXPlayer.addInventoryItem   (itemName, itemCount)
				
				TriggerClientEvent('esx:showNotification', _source, _U('gave_item', itemCount, ESX.Items[itemName].label, targetXPlayer.name))
				TriggerClientEvent('esx:showNotification', target,  _U('received_item', itemCount, ESX.Items[itemName].label, sourceXPlayer.name))
			end

		else
			TriggerClientEvent('esx:showNotification', _source, _U('imp_invalid_quantity'))
		end

	elseif type == 'item_money' then

		if itemCount > 0 and sourceXPlayer.getMoney() >= itemCount then
			sourceXPlayer.removeMoney(itemCount)
			targetXPlayer.addMoney   (itemCount)

			TriggerClientEvent('esx:showNotification', _source, _U('gave_money', ESX.Math.GroupDigits(itemCount), targetXPlayer.name))
			TriggerClientEvent('esx:showNotification', target,  _U('received_money', ESX.Math.GroupDigits(itemCount), sourceXPlayer.name))
		else
			TriggerClientEvent('esx:showNotification', _source, _U('imp_invalid_amount'))
		end

	elseif type == 'item_account' then

		if itemCount > 0 and sourceXPlayer.getAccount(itemName).money >= itemCount then
			sourceXPlayer.removeAccountMoney(itemName, itemCount)
			targetXPlayer.addAccountMoney   (itemName, itemCount)

			TriggerClientEvent('esx:showNotification', _source, _U('gave_account_money', ESX.Math.GroupDigits(itemCount), Config.AccountLabels[itemName], targetXPlayer.name))
			TriggerClientEvent('esx:showNotification', target,  _U('received_account_money', ESX.Math.GroupDigits(itemCount), Config.AccountLabels[itemName], sourceXPlayer.name))
		else
			TriggerClientEvent('esx:showNotification', _source, _U('imp_invalid_amount'))
		end
	end
end)

RegisterServerEvent('esx:createPickupCoords')
AddEventHandler('esx:createPickupCoords', function(type, itemName, itemCount, itemLabel, model, coords)
	local _source = source
	if type == "item_weapon" then return end
	if type == 'item_standard' then
		if itemCount > 0 then
			local xPlayer = ESX.GetPlayerFromId(source)
			local pickupLabel = ('~y~%s~s~ [~b~%s~s~]'):format(itemLabel, itemCount)
			local pickupLabel = ('~y~%s~s~ [~b~%s~s~]'):format(itemLabel, itemCount)
			ESX.CreatePickupCoords('item_standard', itemName, itemCount, pickupLabel, _source, model or 'prop_cs_package_01', coords)
		end
	elseif type == 'item_money' then
		if itemCount > 0 then
			local xPlayer = ESX.GetPlayerFromId(source)
			local pickupLabel = ('~y~%s~s~ [~g~%s~s~]'):format(_U('cash'), _U('locale_currency', ESX.Math.GroupDigits(itemCount)))
			ESX.CreatePickupCoords('item_money', 'money', itemCount, pickupLabel, _source, model or "bkr_prop_money_wrapped_01", coords)
		end
	elseif type == 'item_account' then
		if itemCount > 0 then
			local xPlayer = ESX.GetPlayerFromId(source)
			local pickupLabel = ('~y~%s~s~ [~g~%s~s~]'):format("Argent inconnu", _U('locale_currency', ESX.Math.GroupDigits(itemCount)))
			ESX.CreatePickupCoords('item_account', itemName, itemCount, pickupLabel, _source, model or "bkr_prop_money_wrapped_01", coords)
		end
	end
end)

RegisterServerEvent('esx:removeInventoryItem')
AddEventHandler('esx:removeInventoryItem', function(type, itemName, itemCount)
	local _source = source

	if type == "item_weapon" then return end
	if type == 'item_standard' then

		if itemCount == nil or itemCount < 1 then
			TriggerClientEvent('esx:showNotification', _source, _U('imp_invalid_quantity'))
		else
			local xPlayer = ESX.GetPlayerFromId(source)
			local xItem = xPlayer.getInventoryItem(itemName)

			if (itemCount > xItem.count or xItem.count < 1) then
				TriggerClientEvent('esx:showNotification', _source, _U('imp_invalid_quantity'))
			else
				xPlayer.removeInventoryItem(itemName, itemCount)

				local pickupLabel = ('~y~%s~s~ [~b~%s~s~]'):format(xItem.label, itemCount)
				local pickupLabel = ('~y~%s~s~ [~b~%s~s~]'):format(xItem.label, itemCount)

				local model = 'prop_cs_package_01'
				for _,v in pairs(Config.Item) do
					if xItem.name == v[1] then
						model = v[2]
					end
				end

				ESX.CreatePickup('item_standard', itemName, itemCount, pickupLabel, _source, model)
				TriggerClientEvent('esx:showNotification', _source, _U('threw_standard', itemCount, xItem.label))
			end
		end

	elseif type == 'item_money' then

		if itemCount == nil or itemCount < 1 then
			TriggerClientEvent('esx:showNotification', _source, _U('imp_invalid_amount'))
		else
			local xPlayer = ESX.GetPlayerFromId(source)
			local playerCash = xPlayer.getMoney()

			if (itemCount > playerCash or playerCash < 1) then
				TriggerClientEvent('esx:showNotification', _source, _U('imp_invalid_amount'))
			else
				xPlayer.removeMoney(itemCount)

				local pickupLabel = ('~y~%s~s~ [~g~%s~s~]'):format(_U('cash'), _U('locale_currency', ESX.Math.GroupDigits(itemCount)))
				if itemCount > 9999 then 
					ESX.CreatePickup('item_money', 'money', itemCount, pickupLabel, _source, "hei_prop_heist_deposit_box")
				elseif itemCount > 4999 then 
					ESX.CreatePickup('item_money', 'money', itemCount, pickupLabel, _source, "prop_poly_bag_money")
				elseif itemCount > 999 then 
					ESX.CreatePickup('item_money', 'money', itemCount, pickupLabel, _source, "bkr_prop_moneypack_01a")
				elseif itemCount > 0 then 
					ESX.CreatePickup('item_money', 'money', itemCount, pickupLabel, _source, "bkr_prop_money_wrapped_01")
				end

				TriggerClientEvent('esx:showNotification', _source, _U('threw_money', ESX.Math.GroupDigits(itemCount)))
			end
		end

	elseif type == 'item_account' then

		if itemCount == nil or itemCount < 1 then
			TriggerClientEvent('esx:showNotification', _source, _U('imp_invalid_amount'))
		else
			local xPlayer = ESX.GetPlayerFromId(source)
			local account = xPlayer.getAccount(itemName)

			if (itemCount > account.money or account.money < 1) then
				TriggerClientEvent('esx:showNotification', _source, _U('imp_invalid_amount'))
			else
				xPlayer.removeAccountMoney(itemName, itemCount)

				local pickupLabel = ('~y~%s~s~ [~g~%s~s~]'):format(account.label, _U('locale_currency', ESX.Math.GroupDigits(itemCount)))
				if itemCount > 9999 then 
					ESX.CreatePickup('item_account', itemName, itemCount, pickupLabel, _source, "hei_prop_heist_deposit_box")
				elseif itemCount > 4999 then 
					ESX.CreatePickup('item_account', itemName, itemCount, pickupLabel, _source, "prop_poly_bag_money")
				elseif itemCount > 999 then 
					ESX.CreatePickup('item_account', itemName, itemCount, pickupLabel, _source, "bkr_prop_moneypack_01a")
				elseif itemCount > 0 then 
					ESX.CreatePickup('item_account', itemName, itemCount, pickupLabel, _source, "bkr_prop_money_wrapped_01")
				end
				TriggerClientEvent('esx:showNotification', _source, _U('threw_account', ESX.Math.GroupDigits(itemCount), string.lower(account.label)))
			end
		end

	end
end)

RegisterServerEvent('esx:useItem')
AddEventHandler('esx:useItem', function(itemName)
	local xPlayer = ESX.GetPlayerFromId(source)
	local count   = xPlayer.getInventoryItem(itemName).count

	if count > 0 then
		ESX.UseItem(source, itemName)
	else
		TriggerClientEvent('esx:showNotification', xPlayer.source, _U('act_imp'))
	end
end)

RegisterServerEvent('esx:onPickup')
AddEventHandler('esx:onPickup', function(id)
	local _source = source
	local pickup  = ESX.Pickups[id]
	local xPlayer = ESX.GetPlayerFromId(_source)

	if pickup.type == 'item_standard' then

		local item      = xPlayer.getInventoryItem(pickup.name)
		local canTake   = ((item.limit == -1) and (pickup.count)) or ((item.limit - item.count > 0) and (item.limit - item.count)) or 0
		local total     = pickup.count < canTake and pickup.count or canTake
		local remaining = pickup.count - total
		local itemName = pickup.name

		TriggerClientEvent('esx:removePickup', -1, id)

		if total > 0 then
			TriggerClientEvent('esx:showNotification', _source, "Vous avez ramassé ~g~"..total.." "..ESX.Items[itemName].label.."~s~.", 2000)
			xPlayer.addInventoryItem(pickup.name, total)
		end

		if remaining > 0 then
			TriggerClientEvent('esx:showNotification', _source, _U('cannot_pickup_room', item.label))

			local pickupLabel = ('~y~%s~s~ [~b~%s~s~]'):format(item.label, remaining)
			local model = 'prop_cs_package_01'
			for _,v in pairs(Config.Item) do
				if xItem.name == v[1] then
					model = v[2]
				end
			end

			ESX.CreatePickup('item_standard', pickup.name, remaining, pickupLabel, _source, model)
		end

	elseif pickup.type == 'item_money' then
		TriggerClientEvent('esx:removePickup', -1, id)
		TriggerClientEvent('esx:showNotification', _source, "Vous avez ramassé ~g~"..pickup.count.."$~s~.")
		xPlayer.addMoney(pickup.count)
	elseif pickup.type == 'item_account' then
		TriggerClientEvent('esx:removePickup', -1, id)
		TriggerClientEvent('esx:showNotification', _source, "Vous avez ramassé ~r~"..pickup.count.."$~s~.")
		xPlayer.addAccountMoney(pickup.name, pickup.count)
	end
end)

ESX.RegisterServerCallback('esx:getPlayerData', function(source, cb)
	local xPlayer = ESX.GetPlayerFromId(source)

	cb({
		identifier   = xPlayer.identifier,
		accounts     = xPlayer.getAccounts(),
		inventory    = xPlayer.getInventory(),
		job          = xPlayer.getJob(),
		org         = xPlayer.getOrg(),
		loadout      = xPlayer.getLoadout(),
		lastPosition = xPlayer.getLastPosition(),
		money        = xPlayer.getMoney()
	})
end)

ESX.RegisterServerCallback('esx:getOtherPlayerData', function(source, cb, target)
	local xPlayer = ESX.GetPlayerFromId(target)

	cb({
		identifier   = xPlayer.identifier,
		accounts     = xPlayer.getAccounts(),
		inventory    = xPlayer.getInventory(),
		job          = xPlayer.getJob(),
		org          = xPlayer.getOrg(),
		loadout      = xPlayer.getLoadout(),
		lastPosition = xPlayer.getLastPosition(),
		money        = xPlayer.getMoney()
	})
end)

TriggerEvent("es:addGroup", "jobmaster", "orgmaster", "user", function(group) end)

ESX.StartDBSync()
ESX.StartPayCheck()


if Citizen and Citizen.CreateThread then
	CreateThread = Citizen.CreateThread
end

Async = {}

function Async.parallel(tasks, cb)

	if #tasks == 0 then
		cb({})
		return
	end

	local remaining = #tasks
	local results   = {}

	for i=1, #tasks, 1 do
		
		CreateThread(function()
			
			tasks[i](function(result)
				
				table.insert(results, result)
				
				remaining = remaining - 1;

				if remaining == 0 then
					cb(results)
				end

			end)

		end)

	end

end

function Async.parallelLimit(tasks, limit, cb)

	if #tasks == 0 then
		cb({})
		return
	end

	local remaining = #tasks
	local running   = 0
	local queue     = {}
	local results   = {}

	for i=1, #tasks, 1 do
		table.insert(queue, tasks[i])
	end

	local function processQueue()

		if #queue == 0 then
			return
		end

		while running < limit and #queue > 0 do
			
			local task = table.remove(queue, 1)
			
			running = running + 1

			task(function(result)
				
				table.insert(results, result)
				
				remaining = remaining - 1;
				running   = running - 1

				if remaining == 0 then
					cb(results)
				end

			end)

		end

		CreateThread(processQueue)

	end

	processQueue()

end

function Async.series(tasks, cb)
	Async.parallelLimit(tasks, 1, cb)
end
