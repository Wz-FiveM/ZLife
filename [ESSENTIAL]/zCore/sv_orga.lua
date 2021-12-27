ESX = nil
local Org = {}
local RegisteredOrganisation = {}

TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

function GetOrganisation(name)
	for i=1, #RegisteredOrganisation, 1 do
		if RegisteredOrganisation[i].name == name then
			return RegisteredOrganisation[i]
		end
	end
end

MySQL.ready(function()
	local result = MySQL.Sync.fetchAll('SELECT * FROM org', {})

	for i=1, #result, 1 do
		Org[result[i].name]        = result[i]
		Org[result[i].name].gradeorg = {}
	end

	local result2 = MySQL.Sync.fetchAll('SELECT * FROM org_gradeorg', {})

	for i=1, #result2, 1 do
		Org[result2[i].org_name].gradeorg[tostring(result2[i].gradeorg)] = result2[i]
	end
end)

AddEventHandler('esx_organisation:registerOrganisation', function(name, label, account, datastore, inventory, data)
	local found = false

	local organisation = {
		name      = name,
		label     = label,
		account   = account,
		datastore = datastore,
		inventory = inventory,
		data      = data
	}

	for i=1, #RegisteredOrganisation, 1 do
		if RegisteredOrganisation[i].name == name then
			found = true
			RegisteredOrganisation[i] = organisation
			break
		end
	end

	if not found then
		table.insert(RegisteredOrganisation, organisation)
	end
end)

AddEventHandler('esx_organisation:getOrganisation', function(cb)
	cb(RegisteredOrganisation)
end)

AddEventHandler('esx_organisation:getOrganisation', function(name, cb)
	cb(Getorganisation(name))
end)

RegisterServerEvent('esx_organisation:withdrawMoney')
AddEventHandler('esx_organisation:withdrawMoney', function(organisation, amount)
	local xPlayer = ESX.GetPlayerFromId(source)
	local organisation = GetOrganisation(organisation)
	amount = ESX.Math.Round(tonumber(amount))

	if xPlayer.org.name == organisation.name then
		TriggerEvent('esx_addonaccount:getSharedAccount', organisation.account, function(account)
			if amount > 0 and account.money >= amount then
				account.removeMoney(amount)
				xPlayer.addMoney(amount)

				TriggerClientEvent('esx:showNotification', xPlayer.source, "Vous avez retiré ~g~"..amount.."$~s~ du coffre.")
				--xPlayer.showNotification(_U('have_withdrawn', ESX.Math.GroupDigits(amount)))
			else
				xPlayer.showNotification(_U('invalid_amount'))
			end
		end)
	else
		print(('esx_organisation: %s attempted to call withdrawMoney!'):format(xPlayer.identifier))
	end
end)

RegisterServerEvent('esx_organisation:depositMoney')
AddEventHandler('esx_organisation:depositMoney', function(organisation, amount)
	local xPlayer = ESX.GetPlayerFromId(source)
	local organisation = GetOrganisation(organisation)
	amount = ESX.Math.Round(tonumber(amount))

	if xPlayer.org.name == organisation.name then
		if amount > 0 and xPlayer.getMoney() >= amount then
			TriggerEvent('esx_addonaccount:getSharedAccount', organisation.account, function(account)
				xPlayer.removeMoney(amount)
				account.addMoney(amount)
			end)

			xPlayer.showNotification(_U('have_deposited', ESX.Math.GroupDigits(amount)))
		else
			xPlayer.showNotification(_U('invalid_amount'))
		end
	else
		print(('esx_organisation: %s attempted to call depositMoney!'):format(xPlayer.identifier))
	end
end)

RegisterServerEvent('esx_organisation:washMoney')
AddEventHandler('esx_organisation:washMoney', function(organisation, amount)
	local xPlayer = ESX.GetPlayerFromId(source)
	local account = xPlayer.getAccount('black_money')
	amount = ESX.Math.Round(tonumber(amount))

	if xPlayer.org.name == organisation then
		if amount and amount > 0 and account.money >= amount then
			xPlayer.removeAccountMoney('black_money', amount)

			MySQL.Async.execute('INSERT INTO organisation_moneywash (identifier, organisation, amount) VALUES (@identifier, @organisation, @amount)', {
				['@identifier'] = xPlayer.identifier,
				['@organisation']    = organisation,
				['@amount']     = amount
			}, function(rowsChanged)
				xPlayer.showNotification(_U('you_have', ESX.Math.GroupDigits(amount)))
			end)
		else
			xPlayer.showNotification(_U('invalid_amount'))
		end
	else
		print(('esx_organisation: %s attempted to call washMoney!'):format(xPlayer.identifier))
	end
end)

RegisterServerEvent('esx_organisation:putVehicleInGarage')
AddEventHandler('esx_organisation:putVehicleInGarage', function(organisationName, vehicle)
	local organisation = GetOrganisation(organisationName)

	TriggerEvent('esx_datastore:getSharedDataStore', organisation.datastore, function(store)
		local garage = store.get('garage') or {}

		table.insert(garage, vehicle)
		store.set('garage', garage)
	end)
end)

RegisterServerEvent('esx_organisation:removeVehicleFromGarage')
AddEventHandler('esx_organisation:removeVehicleFromGarage', function(organisationName, vehicle)
	local organisation = GetOrganisation(organisationName)

	TriggerEvent('esx_datastore:getSharedDataStore', organisation.datastore, function(store)
		local garage = store.get('garage') or {}

		for i=1, #garage, 1 do
			if garage[i].plate == vehicle.plate then
				table.remove(garage, i)
				break
			end
		end

		store.set('garage', garage)
	end)
end)

ESX.RegisterServerCallback('esx_organisation:getOrganisationMoney', function(source, cb, organisationName)
	local organisation = GetOrganisation(organisationName)

	if organisation then
		TriggerEvent('esx_addonaccount:getSharedAccount', organisation.account, function(account)
			cb(account.money)
		end)
	else
		cb(0)
	end
end)

ESX.RegisterServerCallback('esx_organisation:getEmployees', function(source, cb, organisation)
	if Config.EnableESXIdentity then

		MySQL.Async.fetchAll('SELECT firstname, lastname, identifier, org, org_gradeorg FROM users WHERE org = @org ORDER BY org_gradeorg DESC', {
			['@org'] = organisation
		}, function (results)
			local employees = {}

			for i=1, #results, 1 do
				table.insert(employees, {
					name       = results[i].firstname .. ' ' .. results[i].lastname,
					identifier = results[i].identifier,
					org = {
						name        = results[i].org,
						label       = Org[results[i].org].label,
						gradeorg       = results[i].org_gradeorg,
						gradeorg_name  = Org[results[i].org].gradeorgs[tostring(results[i].org_gradeorg)].name,
						gradeorg_label = Org[results[i].org].gradeorgs[tostring(results[i].org_gradeorg)].label
					}
				})
			end

			cb(employees)
		end)
	else
		MySQL.Async.fetchAll('SELECT name, identifier, org, org_gradeorg FROM users WHERE org = @org ORDER BY org_gradeorg DESC', {
			['@org'] = organisation
		}, function (result)
			local employees = {}

			for i=1, #result, 1 do
				table.insert(employees, {
					name       = result[i].name,
					identifier = result[i].identifier,
					org = {
						name        = result[i].org,
						label       = Org[result[i].org].label,
						gradeorg       = result[i].org_gradeorg,
						gradeorg_name  = Org[result[i].org].gradeorgs[tostring(result[i].org_gradeorg)].name,
						gradeorg_label = Org[result[i].org].gradeorgs[tostring(result[i].org_gradeorg)].label
					}
				})
			end

			cb(employees)
		end)
	end
end)

ESX.RegisterServerCallback('esx_organisation:getOrg', function(source, cb, organisation)
	local org    = json.decode(json.encode(Org[organisation]))
	local gradeorg = {}

	for k,v in pairs(org.gradeorg) do
		table.insert(gradeorg, v)
	end

	table.sort(gradeorg, function(a, b)
		return a.gradeorg < b.gradeorg
	end)

	org.gradeorg = gradeorg

	cb(org)
end)

ESX.RegisterServerCallback('esx_organisation:setOrg', function(source, cb, identifier, org, gradeorg, type)
	local xPlayer = ESX.GetPlayerFromId(source)
	local isBoss = xPlayer.org.gradeorg_name == 'boss'

	if isBoss then
		local xTarget = ESX.GetPlayerFromIdentifier(identifier)

		if xTarget then
			xTarget.setOrg(org, gradeorg)

			if type == 'hire' then
				xTarget.showNotification(_U('you_have_been_hired', org))
			elseif type == 'promote' then
				xTarget.showNotification(_U('you_have_been_promoted'))
			elseif type == 'fire' then
				xTarget.showNotification(_U('you_have_been_fired', xTarget.getOrg().label))
			end

			cb()
		else
			MySQL.Async.execute('UPDATE users SET org = @org, org_gradeorg = @org_gradeorg WHERE identifier = @identifier', {
				['@org']        = org,
				['@org_gradeorg']  = gradeorg,
				['@identifier'] = identifier
			}, function(rowsChanged)
				cb()
			end)
		end
	else
		print(('esx_organisation: %s attempted to setOrg'):format(xPlayer.identifier))
		cb()
	end
end)

ESX.RegisterServerCallback('esx_organisation:setOrgSalary', function(source, cb, org, gradeorg, salary)
	local xPlayer = ESX.GetPlayerFromId(source)

	if xPlayer.org.name == org and xPlayer.org.gradeorg_name == 'boss' then
		if salary <= Config.MaxSalary then
			MySQL.Async.execute('UPDATE org_gradeorg SET salary = @salary WHERE org_name = @org_name AND gradeorg = @gradeorg', {
				['@salary']   = salary,
				['@org_name'] = org,
				['@gradeorg']    = gradeorg
			}, function(rowsChanged)
				Org[org].gradeorg[tostring(gradeorg)].salary = salary
				local xPlayers = ESX.GetPlayers()

				for i=1, #xPlayers, 1 do
					local xTarget = ESX.GetPlayerFromId(xPlayers[i])

					if xTarget.org.name == org and xTarget.org.gradeorg == gradeorg then
						xTarget.setOrg(org, gradeorg)
					end
				end

				cb()
			end)
		else
			print(('esx_organisation: %s attempted to setOrgSalary over config limit!'):format(xPlayer.identifier))
			cb()
		end
	else
		print(('esx_organisation: %s attempted to setOrgSalary'):format(xPlayer.identifier))
		cb()
	end
end)

ESX.RegisterServerCallback('esx_organisation:getOnlinePlayers', function(source, cb)
	local xPlayers = ESX.GetPlayers()
	local players  = {}

	for i=1, #xPlayers, 1 do
		local xPlayer = ESX.GetPlayerFromId(xPlayers[i])
		table.insert(players, {
			source     = xPlayer.source,
			identifier = xPlayer.identifier,
			name       = xPlayer.name,
			org        = xPlayer.org
		})
	end

	cb(players)
end)

ESX.RegisterServerCallback('esx_organisation:getVehiclesInGarage', function(source, cb, organisationName)
	local organisation = GetOrganisation(organisationName)

	TriggerEvent('esx_datastore:getSharedDataStore', organisation.datastore, function(store)
		local garage = store.get('garage') or {}
		cb(garage)
	end)
end)

ESX.RegisterServerCallback('esx_organisation:isBoss', function(source, cb, org)
	cb(isPlayerBoss(source, org))
end)

function isPlayerBoss(playerId, org)
	local xPlayer = ESX.GetPlayerFromId(playerId)

	if xPlayer.org.name == org and xPlayer.org.gradeorg_name == 'boss' then
		return true
	else
		print(('esx_organisation: %s attempted open a organisation boss menu!'):format(xPlayer.identifier))
		return false
	end
end

function WashMoneyCRON(d, h, m)
	MySQL.Async.fetchAll('SELECT * FROM organisation_moneywash', {}, function(result)
		for i=1, #result, 1 do
			local organisation = GetOrganisation(result[i].organisation)
			local xPlayer = ESX.GetPlayerFromIdentifier(result[i].identifier)

			-- add organisation money
			TriggerEvent('esx_addonaccount:getSharedAccount', organisation.account, function(account)
				account.addMoney(result[i].amount)
			end)

			-- send notification if player is online
			if xPlayer then
				xPlayer.showNotification(_U('you_have_laundered', ESX.Math.GroupDigits(result[i].amount)))
			end

			MySQL.Async.execute('DELETE FROM organisation_moneywash WHERE id = @id', {
				['@id'] = result[i].id
			})
		end
	end)
end

TriggerEvent('cron:runAt', 3, 0, WashMoneyCRON)
