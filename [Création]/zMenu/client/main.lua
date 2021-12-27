ESX = nil

function notification(title, subject, msg)

	local mugshot, mugshotStr = ESX.Game.GetPedMugshot(GetPlayerPed(-1))
  
	ESX.ShowAdvancedNotification(title, subject, msg, mugshotStr, 1)
  
	UnregisterPedheadshot(mugshot)
  
end

_menuPool = nil
local personalmenu = {}

local invItem, wepItem, billItem, mainMenu, itemMenu, weaponItemMenu = {}, {}, {}, nil, nil, nil

local isDead, inAnim = false, false

local playerGroup, noclip, godmode, visible = nil, false, false, false

local societymoney, societymoney2 = nil, nil

local wepList = nil

Citizen.CreateThread(function()
	while ESX == nil do
		TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
		Citizen.Wait(10)
	end

	while ESX.GetPlayerData().job == nil do
		Citizen.Wait(10)
	end

	if Config.doublejob then
		while ESX.GetPlayerData().org == nil do
			Citizen.Wait(10)
		end
	end

	ESX.PlayerData = ESX.GetPlayerData()

	while playerGroup == nil do
		ESX.TriggerServerCallback('KorioZ-PersonalMenu:Admin_getUsergroup', function(group) playerGroup = group end)
		Citizen.Wait(10)
	end

	while actualSkin == nil do
		TriggerEvent('skinchanger:getSkin', function(skin) actualSkin = skin end)
		Citizen.Wait(10)
	end

	RefreshMoney()

	if Config.doublejob then
		RefreshMoney2()
	end

	wepList = ESX.GetWeaponList()

	_menuPool = NativeUI.CreatePool()

	mainMenu = NativeUI.CreateMenu("", _U('mainmenu_subtitle'))
	mainMenu:SetMenuWidthOffset(10)
	itemMenu = NativeUI.CreateMenu("", _U('inventory_actions_subtitle'))
	itemMenu:SetMenuWidthOffset(10)
	weaponItemMenu = NativeUI.CreateMenu("", _U('loadout_actions_subtitle'))
	weaponItemMenu:SetMenuWidthOffset(10)
	_menuPool:Add(mainMenu)
	_menuPool:Add(itemMenu)
	_menuPool:Add(weaponItemMenu)
end)


RegisterNetEvent('esx:playerLoaded')
AddEventHandler('esx:playerLoaded', function(xPlayer)
	ESX.PlayerData = xPlayer
end)

AddEventHandler('esx:onPlayerDeath', function()
	isDead = true
	_menuPool:CloseAllMenus()
	ESX.UI.Menu.CloseAll()
end)

AddEventHandler('playerSpawned', function()
	isDead = false
end)

RegisterNetEvent('esx:setJob')
AddEventHandler('esx:setJob', function(job)
	ESX.PlayerData.job = job
	RefreshMoney()
end)

RegisterNetEvent('esx:setOrg')
AddEventHandler('esx:setOrg', function(org)
	ESX.PlayerData.org = org
	RefreshMoney2()
end)

function RefreshMoney()
	if ESX.PlayerData.job ~= nil and ESX.PlayerData.job.grade_name == 'boss' then
		ESX.TriggerServerCallback('esx_society:getSocietyMoney', function(money)
			UpdateSocietyMoney(money)
		end, ESX.PlayerData.job.name)
	end
end

function RefreshMoney2()
	if ESX.PlayerData.org ~= nil and ESX.PlayerData.org.gradeorg_name == 'boss' then
		ESX.TriggerServerCallback('esx_society:getSocietyMoney', function(money)
			UpdateSociety2Money(money)
		end, ESX.PlayerData.org.name)
	end
end

RegisterNetEvent('esx_addonaccount:setMoney')
AddEventHandler('esx_addonaccount:setMoney', function(society, money)
	if ESX.PlayerData.job ~= nil and ESX.PlayerData.job.grade_name == 'boss' and 'society_' .. ESX.PlayerData.job.name == society then
		UpdateSocietyMoney(money)
	end
	if ESX.PlayerData.org ~= nil and ESX.PlayerData.org.gradeorg_name == 'boss' and 'society_' .. ESX.PlayerData.org.name == society then
		UpdateSociety2Money(money)
	end
end)

function UpdateSocietyMoney(money)
	societymoney = ESX.Math.GroupDigits(money)
end

function UpdateSociety2Money(money)
	societymoney2 = ESX.Math.GroupDigits(money)
end

-- Weapon Menu --

RegisterNetEvent("KorioZ-PersonalMenu:Weapon_addAmmoToPedC")
AddEventHandler("KorioZ-PersonalMenu:Weapon_addAmmoToPedC", function(value, quantity)
	local weaponHash = GetHashKey(value)

	if HasPedGotWeapon(plyPed, weaponHash, false) and value ~= 'WEAPON_UNARMED' then
		AddAmmoToPed(plyPed, value, quantity)
	end
end)

-- Admin Menu --

RegisterNetEvent('KorioZ-PersonalMenu:Admin_BringC')
AddEventHandler('KorioZ-PersonalMenu:Admin_BringC', function(plyPedCoords)
	SetEntityCoords(plyPed, plyPedCoords)
end)

function startAnim(lib, anim)
	ESX.Streaming.RequestAnimDict(lib, function()
		TaskPlayAnim(plyPed, lib, anim, 8.0, -8.0, -1, 0, 0, false, false, false)
	end)
end

function startAnimAction(lib, anim)
	ESX.Streaming.RequestAnimDict(lib, function()
		TaskPlayAnim(plyPed, lib, anim, 8.0, 1.0, -1, 49, 0, false, false, false)
	end)
end

function AddMenuWalletMenu(menu)
	local moneyOption = {}
	
	moneyOption = {
		_U('wallet_option_give'),
		_U('wallet_option_drop')
	}

	walletmenu = _menuPool:AddSubMenu(menu, _U('wallet_title'))
	walletmenu.Item:RightLabel("→")
	walletmenu.SubMenu:SetMenuWidthOffset(10)


	local walletJob = NativeUI.CreateItem(_U('wallet_job_button', ESX.PlayerData.job.label, ESX.PlayerData.job.grade_label), "")
	walletmenu.SubMenu:AddItem(walletJob)
	local walletOrg = NativeUI.CreateItem("Organisation : "..ESX.PlayerData.org.label, "")
	walletmenu.SubMenu:AddItem(walletOrg)


	local walletOrg = nil

	
	local walletMoney = NativeUI.CreateListItem(_U('wallet_money_button', ESX.Math.GroupDigits(ESX.PlayerData.money)), moneyOption, 1)
	walletmenu.SubMenu:AddItem(walletMoney)

	local walletdirtyMoney = nil
	local showID = nil
	local showDriver = nil
	local showFirearms = nil
	local checkID = nil
	local checkDriver = nil
	local checkFirearms = nil

	for i = 1, #ESX.PlayerData.accounts, 1 do
		if ESX.PlayerData.accounts[i].name == 'black_money' then
			walletdirtyMoney = NativeUI.CreateListItem(_U('wallet_blackmoney_button', ESX.Math.GroupDigits(ESX.PlayerData.accounts[i].money)), moneyOption, 1)
			walletmenu.SubMenu:AddItem(walletdirtyMoney)
		end
	end


	if Config.EnableJsfourIDCard then
		showID = NativeUI.CreateItem(_U('wallet_show_idcard_button'), "")
		walletmenu.SubMenu:AddItem(showID)

		checkID = NativeUI.CreateItem(_U('wallet_check_idcard_button'), "")
		walletmenu.SubMenu:AddItem(checkID)
	   
        showDriver = NativeUI.CreateItem(_U('wallet_show_driver_button'), "")
        walletmenu.SubMenu:AddItem(showDriver)
       
        checkDriver = NativeUI.CreateItem(_U('wallet_check_driver_button'), "")
        walletmenu.SubMenu:AddItem(checkDriver)
		   
        showFirearms = NativeUI.CreateItem(_U('wallet_show_firearms_button'), "")
        walletmenu.SubMenu:AddItem(showFirearms)
       
        checkFirearms = NativeUI.CreateItem(_U('wallet_check_firearms_button'), "")
        walletmenu.SubMenu:AddItem(checkFirearms)
	end

	walletmenu.SubMenu.OnItemSelect = function(sender, item, index)
		if Config.EnableJsfourIDCard then
			if item == showID then
				personalmenu.closestPlayer, personalmenu.closestDistance = ESX.Game.GetClosestPlayer()
											
				if personalmenu.closestDistance ~= -1 and personalmenu.closestDistance <= 3.0 then
					TriggerServerEvent('jsfour-idcard:open', GetPlayerServerId(PlayerId()), GetPlayerServerId(personalmenu.closestPlayer))
				else
					ESX.ShowColoredNotification("~r~Personne à côté de vous", 5)
				end
			elseif item == checkID then
				TriggerServerEvent('jsfour-idcard:open', GetPlayerServerId(PlayerId()), GetPlayerServerId(PlayerId()))
			elseif item == showDriver then
				personalmenu.closestPlayer, personalmenu.closestDistance = ESX.Game.GetClosestPlayer()
											
				if personalmenu.closestDistance ~= -1 and personalmenu.closestDistance <= 3.0 then
					TriggerServerEvent('jsfour-idcard:open', GetPlayerServerId(PlayerId()), GetPlayerServerId(personalmenu.closestPlayer), 'driver')
				else
					ESX.ShowColoredNotification("~r~Personne à côté de vous", 5)
				end
			elseif item == checkDriver then
				TriggerServerEvent('jsfour-idcard:open', GetPlayerServerId(PlayerId()), GetPlayerServerId(PlayerId()), 'driver')
			elseif item == showFirearms then
				personalmenu.closestPlayer, personalmenu.closestDistance = ESX.Game.GetClosestPlayer()
											
				if personalmenu.closestDistance ~= -1 and personalmenu.closestDistance <= 3.0 then
					TriggerServerEvent('jsfour-idcard:open', GetPlayerServerId(PlayerId()), GetPlayerServerId(personalmenu.closestPlayer), 'weapon')
				else
					ESX.ShowColoredNotification("~r~Personne à côté de vous", 5)
				end
			elseif item == checkFirearms then
				TriggerServerEvent('jsfour-idcard:open', GetPlayerServerId(PlayerId()), GetPlayerServerId(PlayerId()), 'weapon')
			end
		end
	end

	walletmenu.SubMenu.OnListSelect = function(sender, item, index)
		if item == walletMoney or item == walletdirtyMoney then
			if index == 1 then
				local quantity = KeyboardInput("Nom", _U('dialogbox_amount'), "", 8)

				if quantity ~= nil then
					local post = true
					quantity = tonumber(quantity)

					if type(quantity) == 'number' then
						quantity = ESX.Math.Round(quantity)

						if quantity <= 0 then
							post = false
						end
					end

					local foundPlayers = false
					personalmenu.closestPlayer, personalmenu.closestDistance = ESX.Game.GetClosestPlayer()

					if personalmenu.closestDistance ~= -1 and personalmenu.closestDistance <= 3 then
						foundPlayers = true
					end

					if foundPlayers == true then
						local closestPed = GetPlayerPed(personalmenu.closestPlayer)

						if not IsPedSittingInAnyVehicle(closestPed) then
							if post == true then
								if item == walletMoney then
									TriggerServerEvent('esx:giveInventoryItem', GetPlayerServerId(personalmenu.closestPlayer), 'item_money', 'money', quantity)
									TaskPlayAnim(GetPlayerPed(-1), "mp_common", "givetake2_a", 2.0, 2.0, 1000, 51, 0, false, false, false)
									_menuPool:CloseAllMenus()
								elseif item == walletdirtyMoney then
									TriggerServerEvent('esx:giveInventoryItem', GetPlayerServerId(personalmenu.closestPlayer), 'item_account', 'black_money', quantity)
									TaskPlayAnim(GetPlayerPed(-1), "mp_common", "givetake2_a", 2.0, 2.0, 1000, 51, 0, false, false, false)
									_menuPool:CloseAllMenus()
								end
							else
								ESX.ShowNotification(_U('amount_invalid'))
							end
						else
							ESX.ShowNotification(_U('in_vehicle_give'))
						end
					else
						ESX.ShowNotification(_U('players_nearby'))
					end
				end
			elseif index == 2 then
				local quantity = KeyboardInput("Nom", _U('dialogbox_amount'), "", 8)

				if quantity ~= nil then
					local post = true
					quantity = tonumber(quantity)

					if type(quantity) == 'number' then
						quantity = ESX.Math.Round(quantity)

						if quantity <= 0 then
							post = false
						end
					end

					if not IsPedSittingInAnyVehicle(plyPed) then
						if post == true then
							if item == walletMoney then
								TriggerServerEvent('esx:removeInventoryItem', 'item_money', 'money', quantity)
								_menuPool:CloseAllMenus()
							elseif item == walletdirtyMoney then
								TriggerServerEvent('esx:removeInventoryItem', 'item_account', 'black_money', quantity)
								_menuPool:CloseAllMenus()
							end
						else
							ESX.ShowNotification(_U('amount_invalid'))
						end
					else
						if item == walletMoney then
							ESX.ShowNotification(_U('in_vehicle_drop', 'de l\'argent'))
						elseif item == walletdirtyMoney then
							ESX.ShowNotification(_U('in_vehicle_drop', 'de l\'argent sale'))
						end
					end
				end
			end
		end
	end
end


function AddMenuBossMenu(menu)
	bossMenu = _menuPool:AddSubMenu(menu, _U('bossmanagement_title', ESX.PlayerData.job.label))
	bossMenu.Item:RightLabel("→")
	bossMenu.SubMenu:SetMenuWidthOffset(10)

	local coffreItem = nil

	if societymoney ~= nil then
		coffreItem = NativeUI.CreateItem(_U('bossmanagement_chest_button'), "")
		coffreItem:RightLabel("$" .. societymoney)
		bossMenu.SubMenu:AddItem(coffreItem)
	end

	local recruterItem = NativeUI.CreateItem(_U('bossmanagement_hire_button'), "")
	bossMenu.SubMenu:AddItem(recruterItem)
	local virerItem = NativeUI.CreateItem(_U('bossmanagement_fire_button'), "")
	bossMenu.SubMenu:AddItem(virerItem)
	local promouvoirItem = NativeUI.CreateItem(_U('bossmanagement_promote_button'), "")
	bossMenu.SubMenu:AddItem(promouvoirItem)
	local destituerItem = NativeUI.CreateItem(_U('bossmanagement_demote_button'), "")
	bossMenu.SubMenu:AddItem(destituerItem)

	bossMenu.SubMenu.OnItemSelect = function(sender, item, index)
		if item == recruterItem then
			if ESX.PlayerData.job.grade_name == 'boss' or ESX.PlayerData.job.grade_name == 'capitaine' then
				personalmenu.closestPlayer, personalmenu.closestDistance = ESX.Game.GetClosestPlayer()

				if personalmenu.closestPlayer == -1 or personalmenu.closestDistance > 3.0 then
					ESX.ShowNotification(_U('players_nearby'))
				else
					TriggerServerEvent('KorioZ-PersonalMenu:Boss_recruterplayer', GetPlayerServerId(personalmenu.closestPlayer), ESX.PlayerData.job.name, 0)
				end
			else
				ESX.ShowNotification(_U('missing_rights'))
			end
		elseif item == virerItem then
			if ESX.PlayerData.job.grade_name == 'boss' or ESX.PlayerData.job.grade_name == 'capitaine' then
				personalmenu.closestPlayer, personalmenu.closestDistance = ESX.Game.GetClosestPlayer()

				if personalmenu.closestPlayer == -1 or personalmenu.closestDistance > 3.0 then
					ESX.ShowNotification(_U('players_nearby'))
				else
					TriggerServerEvent('KorioZ-PersonalMenu:Boss_virerplayer', GetPlayerServerId(personalmenu.closestPlayer))
				end
			else
				ESX.ShowNotification(_U('missing_rights'))
			end
		elseif item == promouvoirItem then
			if ESX.PlayerData.job.grade_name == 'boss' or ESX.PlayerData.job.grade_name == 'capitaine' then
				personalmenu.closestPlayer, personalmenu.closestDistance = ESX.Game.GetClosestPlayer()

				if personalmenu.closestPlayer == -1 or personalmenu.closestDistance > 3.0 then
					ESX.ShowNotification(_U('players_nearby'))
				else
					TriggerServerEvent('KorioZ-PersonalMenu:Boss_promouvoirplayer', GetPlayerServerId(personalmenu.closestPlayer))
				end
			else
				ESX.ShowNotification(_U('missing_rights'))
			end
		elseif item == destituerItem then
			if ESX.PlayerData.job.grade_name == 'boss' or ESX.PlayerData.job.grade_name == 'capitaine' then
				personalmenu.closestPlayer, personalmenu.closestDistance = ESX.Game.GetClosestPlayer()

				if personalmenu.closestPlayer == -1 or personalmenu.closestDistance > 3.0 then
					ESX.ShowNotification(_U('players_nearby'))
				else
					TriggerServerEvent('KorioZ-PersonalMenu:Boss_destituerplayer', GetPlayerServerId(personalmenu.closestPlayer))
				end
			else
				ESX.ShowNotification(_U('missing_rights'))
			end
		end
	end
end

function AddMenuBossMenu2(menu)
	bossMenu2 = _menuPool:AddSubMenu(menu, _U('bossmanagement2_title', ESX.PlayerData.org.label))
	bossMenu2.Item:RightLabel("→")
	bossMenu2.SubMenu:SetMenuWidthOffset(10)

	local coffre2Item = nil

	if societymoney2 ~= nil then
		coffre2Item = NativeUI.CreateItem(_U('bossmanagement2_chest_button'), "")
		coffre2Item:RightLabel("$" .. societymoney2)
		bossMenu2.SubMenu:AddItem(coffre2Item)
	end

	local recruter2Item = NativeUI.CreateItem(_U('bossmanagement2_hire_button'), "")
	bossMenu2.SubMenu:AddItem(recruter2Item)
	local virer2Item = NativeUI.CreateItem(_U('bossmanagement2_fire_button'), "")
	bossMenu2.SubMenu:AddItem(virer2Item)
	local promouvoir2Item = NativeUI.CreateItem(_U('bossmanagement2_promote_button'), "")
	bossMenu2.SubMenu:AddItem(promouvoir2Item)
	local destituer2Item = NativeUI.CreateItem(_U('bossmanagement2_demote_button'), "")
	bossMenu2.SubMenu:AddItem(destituer2Item)

	bossMenu2.SubMenu.OnItemSelect = function(sender, item, index)
		if item == recruter2Item then
			--if ESX.PlayerData.org.grade_name == 'boss' then
				personalmenu.closestPlayer, personalmenu.closestDistance = ESX.Game.GetClosestPlayer()

				if personalmenu.closestPlayer == -1 or personalmenu.closestDistance > 3.0 then
					ESX.ShowNotification("~r~Aucun joueur.")
				else
					TriggerServerEvent('KorioZ-PersonalMenu:Boss_recruterplayer2', GetPlayerServerId(personalmenu.closestPlayer), ESX.PlayerData.org.name, 0)
				end
			--else
				--ESX.ShowNotification(_U('missing_rights'))
			--end
		elseif item == virer2Item then
			--if ESX.PlayerData.org.grade_name == 'boss' then
				personalmenu.closestPlayer, personalmenu.closestDistance = ESX.Game.GetClosestPlayer()

				if personalmenu.closestPlayer == -1 or personalmenu.closestDistance > 3.0 then
					ESX.ShowNotification("~r~Aucun joueur.")
				else
					TriggerServerEvent('KorioZ-PersonalMenu:Boss_virerplayer2', GetPlayerServerId(personalmenu.closestPlayer))
				end
			--else
				--ESX.ShowNotification(_U('missing_rights'))
			--end
		elseif item == promouvoir2Item then
			--if ESX.PlayerData.org.grade_name == 'boss' then
				personalmenu.closestPlayer, personalmenu.closestDistance = ESX.Game.GetClosestPlayer()

				if personalmenu.closestPlayer == -1 or personalmenu.closestDistance > 3.0 then
					ESX.ShowNotification("~r~Aucun joueur.")
				else
					TriggerServerEvent('KorioZ-PersonalMenu:Boss_promouvoirplayer2', GetPlayerServerId(personalmenu.closestPlayer))
				end
			--else
				--ESX.ShowNotification(_U('missing_rights'))
			--end
		elseif item == destituer2Item then
			--if ESX.PlayerData.org.grade_name == 'boss' then
				personalmenu.closestPlayer, personalmenu.closestDistance = ESX.Game.GetClosestPlayer()

				if personalmenu.closestPlayer == -1 or personalmenu.closestDistance > 3.0 then
					ESX.ShowNotification("~r~Aucun joueur.")
				else
					TriggerServerEvent('KorioZ-PersonalMenu:Boss_destituerplayer2', GetPlayerServerId(personalmenu.closestPlayer))
				end
			--else
				--ESX.ShowNotification(_U('missing_rights'))
			--end
		end
	end
end

function GeneratePersonalMenu()	
	if ESX.PlayerData.job ~= nil and ESX.PlayerData.job.grade_name == 'boss' or ESX.PlayerData.job.grade_name == 'capitaine' then
		AddMenuBossMenu(mainMenu)
	end

	if ESX.PlayerData.org ~= nil and ESX.PlayerData.org.gradeorg_name == 'boss' then
		AddMenuBossMenu2(mainMenu)
	end

	_menuPool:RefreshIndex()
end

RegisterControlKey("openmenuentreprise","Ouvrir le menu Entreprise","K",function()
	if mainMenu ~= nil and not mainMenu:Visible() and ESX.PlayerData.job ~= nil and ESX.PlayerData.job.grade_name == 'boss' or ESX.PlayerData.job.grade_name == 'capitaine' then
		ESX.PlayerData = ESX.GetPlayerData()
		GeneratePersonalMenu()
		mainMenu:Visible(true)
		Citizen.Wait(10)
	end
end)

Citizen.CreateThread(function()
	while true do
		if _menuPool ~= nil then
			_menuPool:ProcessMenus()
		end
		
		Citizen.Wait(0)
	end
end)

Citizen.CreateThread(function()
	while true do
		while _menuPool ~= nil and _menuPool:IsAnyMenuOpen() do
			Citizen.Wait(0)

			if not _menuPool:IsAnyMenuOpen() then
				mainMenu:Clear()
				itemMenu:Clear()
				weaponItemMenu:Clear()

				_menuPool:Clear()
				_menuPool:Remove()

				personalmenu = {}

				invItem = {}
				wepItem = {}
				billItem = {}

				collectgarbage()

				_menuPool = NativeUI.CreatePool()

				mainMenu = NativeUI.CreateMenu("", _U('mainmenu_subtitle'))
				mainMenu:SetMenuWidthOffset(10)
				itemMenu = NativeUI.CreateMenu("", _U('inventory_actions_subtitle'))
				itemMenu:SetMenuWidthOffset(10)
				weaponItemMenu = NativeUI.CreateMenu("", _U('loadout_actions_subtitle'))
				weaponItemMenu:SetMenuWidthOffset(10)
				_menuPool:Add(mainMenu)
				_menuPool:Add(itemMenu)
				_menuPool:Add(weaponItemMenu)
			end
		end

		Citizen.Wait(0)
	end
end)