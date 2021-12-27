ESX = nil

Citizen.CreateThread(function()

	while ESX == nil do
		TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
		Citizen.Wait(0)
	end

	local GUI = {}
	GUI.Time = 0
	local MenuType = 'default'

	local openMenu = function(namespace, name, data)

		SendNUIMessage({
			action = 'openMenu',
			namespace = namespace,
			name = name,
			data = data,
		})

	end

	local closeMenu = function(namespace, name)

		SendNUIMessage({
			action = 'closeMenu',
			namespace = namespace,
			name = name,
			data = data,
		})
	end

	ESX.UI.Menu.RegisterType(MenuType, openMenu, closeMenu)

	RegisterNUICallback('menu_submit', function(data, cb)
		local menu = ESX.UI.Menu.GetOpened(MenuType, data._namespace, data._name)
		
		if menu.submit ~= nil then
			menu.submit(data, menu)
		end

		cb('OK')
	end)

	RegisterNUICallback('menu_cancel', function(data, cb)
		
		local menu = ESX.UI.Menu.GetOpened(MenuType, data._namespace, data._name)
		
		if menu.cancel ~= nil then
			menu.cancel(data, menu)
		end

		cb('OK')
	end)

	RegisterNUICallback('menu_change', function(data, cb)
		
		local menu = ESX.UI.Menu.GetOpened(MenuType, data._namespace, data._name)
		
		for i=1, #data.elements, 1 do
			
			menu.setElement(i, 'value', data.elements[i].value)

			if data.elements[i].selected then
				menu.setElement(i, 'selected', true)
			else
				menu.setElement(i, 'selected', false)
			end

		end

		if menu.change ~= nil then
			menu.change(data, menu)
		end

		cb('OK')
	end)

	Citizen.CreateThread(function()
		while true do

	  	Wait(0)

			if IsControlPressed(0, 18) and (GetGameTimer() - GUI.Time) > 150 then
				SendNUIMessage({
					action = 'controlPressed',
					control = 'ENTER'
				})
				GUI.Time = GetGameTimer()
			end

			if IsControlPressed(0, 177) and (GetGameTimer() - GUI.Time) > 150 then
				SendNUIMessage({
					action = 'controlPressed',
					control = 'BACKSPACE'
				})
				GUI.Time = GetGameTimer()
			end

			if IsControlPressed(0, 27) and (GetGameTimer() - GUI.Time) > 150 then
				SendNUIMessage({
					action = 'controlPressed',
					control = 'TOP'
				})
				GUI.Time = GetGameTimer()
			end

			if IsControlPressed(0, 173) and (GetGameTimer() - GUI.Time) > 150 then
				SendNUIMessage({
					action  = 'controlPressed',
					control = 'DOWN'
				})
				GUI.Time = GetGameTimer()
			end

			if IsControlPressed(0, 174) and (GetGameTimer() - GUI.Time) > 150 then

				SendNUIMessage({
					action  = 'controlPressed',
					control = 'LEFT'
				})

				GUI.Time = GetGameTimer()

			end

			if IsControlPressed(0, 175) and (GetGameTimer() - GUI.Time) > 150 then
				SendNUIMessage({
					action  = 'controlPressed',
					control = 'RIGHT'
				})
				GUI.Time = GetGameTimer()
			end

	    end
	end)

end)