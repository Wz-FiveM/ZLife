local Keys = {
  ["ESC"] = 322, ["F1"] = 288, ["F2"] = 289, ["F3"] = 170, ["F5"] = 166, ["F6"] = 167, ["F7"] = 168, ["F8"] = 169, ["F9"] = 56, ["F10"] = 57,
  ["~"] = 243, ["1"] = 157, ["2"] = 158, ["3"] = 160, ["4"] = 164, ["5"] = 165, ["6"] = 159, ["7"] = 161, ["8"] = 162, ["9"] = 163, ["-"] = 84, ["="] = 83, ["BACKSPACE"] = 177,
  ["TAB"] = 37, ["Q"] = 44, ["W"] = 32, ["E"] = 38, ["R"] = 45, ["T"] = 245, ["Y"] = 246, ["U"] = 303, ["P"] = 199, ["["] = 39, ["]"] = 40, ["ENTER"] = 18,
  ["CAPS"] = 137, ["A"] = 34, ["S"] = 8, ["D"] = 9, ["F"] = 23, ["G"] = 47, ["H"] = 74, ["K"] = 311, ["L"] = 182,
  ["LEFTSHIFT"] = 21, ["Z"] = 20, ["X"] = 73, ["C"] = 26, ["V"] = 0, ["B"] = 29, ["N"] = 249, ["M"] = 244, [","] = 82, ["."] = 81,
  ["LEFTCTRL"] = 36, ["LEFTALT"] = 19, ["SPACE"] = 22, ["RIGHTCTRL"] = 70,
  ["HOME"] = 213, ["PAGEUP"] = 10, ["PAGEDOWN"] = 11, ["DELETE"] = 178,
  ["LEFT"] = 174, ["RIGHT"] = 175, ["TOP"] = 27, ["DOWN"] = 173,
  ["NENTER"] = 201, ["N4"] = 108, ["N5"] = 60, ["N6"] = 107, ["N+"] = 96, ["N-"] = 97, ["N7"] = 117, ["N8"] = 61, ["N9"] = 118
}

ESX                           = nil
local GUI                     = {}
GUI.Time                      = 0
local isInMarker      = false

RegisterNetEvent('clp_sim:OpenSim')
AddEventHandler('clp_sim:OpenSim', function()
	OpenPhoneMenu()
end)

function OpenSimMenu()

	ESX.UI.Menu.CloseAll()

	local elements = {}
	local elements2 = {}
  
	  ESX.TriggerServerCallback('clp_sim:GetList', function(sim)
  
		  for _,v in pairs(sim) do
  
			  table.insert(elements, {label = tostring(v.number), value = v})
			  
		  end
  
		  ESX.UI.Menu.Open(
		  'default', GetCurrentResourceName(), 'phone_change',
		  {
			  css  		= 'inventaire',
			  title    = 'Cartes sim',
			  align    = 'center',
			  elements = elements,
		  },
	  function(data, menu)
  
		local elements2 = {
			{label = 'Utiliser', value = 'sim_use'},
			{label = 'Donnez', value = 'sim_give'},
		  	{label = 'Detruire', value = 'sim_delete'}
		  }
  
		  ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'sim_change', {
			css = 'inventaire',
			title    = data.current.value.number,
			align    = 'center',
			elements = elements2,
		  }, 
		  function(data2, menu2)
  
			if data2.current.value == 'sim_use' then
				ESX.UI.Menu.CloseAll()
				TriggerServerEvent('clp_sim:sim_use', data.current.value.number)
				Wait(1000)
				TriggerServerEvent('clp_sim:sim_use', data.current.value.number)
				ESX.ShowNotification("Votre carte sim est maintenant active sur le numéro : ~g~" .. data.current.value.number)
				TriggerServerEvent('gcPhone:allUpdate')
			end
			if data2.current.value == 'sim_give' then
				ESX.UI.Menu.CloseAll()
				local closestPlayer, closestDistance = ESX.Game.GetClosestPlayer()
				if closestPlayer == -1 or closestDistance > 1.5 then
					ESX.ShowNotification('~r~Aucune personne.')
				else
					local dict, anim = "mp_common", "givetake2_a"
					ESX.Streaming.RequestAnimDict(dict)
					TaskPlayAnim(GetPlayerPed(-1), dict, anim, 2.0, 2.0, 1000, 51, 0, false, false, false)
					TriggerServerEvent('clp_sim:sim_give', data.current.value.number, GetPlayerServerId(closestPlayer))
				end
				TriggerServerEvent('gcPhone:allUpdate')
			end
			if data2.current.value == 'sim_delete' then
				ESX.UI.Menu.CloseAll()
				TriggerServerEvent('clp_sim:sim_delete', data.current.value.number)
				ESX.ShowNotification("~r~Vous venez de détruire cette carte sim avec le numéro : ~g~" .. data.current.value.number)
				TriggerServerEvent('gcPhone:allUpdate')
			end

			menu2.close()
		end, function(data2, menu2)
			menu2.close()
		end)
  
		end,
		function(data, menu)
			menu.close()
		end)	
	end)
end

function OpenPhoneMenu()

	ESX.UI.Menu.CloseAll()

	local elements = {
	  {label = 'Carte SIM', value = 'sim_phone'}
	}
  
	ESX.UI.Menu.Open(
	  'default', GetCurrentResourceName(), 'phone_actions',
	  {
		title    = 'Téléphone',
		elements = elements
	  },
	  function(data, menu)
  
		if data.current.value == 'sim_phone' then
			OpenSimMenu()
		end
	end,
	  	function(data, menu)
		menu.close()
	end)
end

Citizen.CreateThread(function() --ok

	while ESX == nil do
	  TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
	  Citizen.Wait(1)
	end
end)


RegisterCommand('simcard', function()
	OpenSimMenu()
	Citizen.Wait(1)
end)