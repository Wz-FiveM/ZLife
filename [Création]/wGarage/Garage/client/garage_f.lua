ESX = nil
local PlayerData = {}
local open = false

local Garage = RageUI.CreateMenu("Fourrière", " ",0,80)
Garage:DisplayGlare(true)
Garage.Closed = function()
end
Garage:DisplayPageCounter(true)

local wListe = {
    listefourriere = {}
}





--marker vehicule en fourriere
Citizen.CreateThread(function()
    while true do
        Citizen.Wait(0)
        local coords, letSleep = GetEntityCoords(PlayerPedId()), true

        for k,v in pairs(wGarage.fourriere) do
            if (wGarage.Type ~= -1 and GetDistanceBetweenCoords(coords, v.sortie.x, v.sortie.y, v.sortie.z, true) < wGarage.DrawDistance) then
                DrawMarker(wGarage.Type, v.sortie.x, v.sortie.y, v.sortie.z, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, wGarage.Size.x, wGarage.Size.y, wGarage.Size.z, wGarage.Color3.r, wGarage.Color3.g, wGarage.Color3.b, 100, false, true, 2, false, false, false, false)
                letSleep = false
            end
        end

        if letSleep then
            Citizen.Wait(500)
        end
    end
end)


function openFourriere()
    if open then
        open = false
        RageUI.Visible(Garage, false)
    else
        open = true
        RageUI.Visible(Garage, true)
        Citizen.CreateThread(function()
            while open do
                RageUI.IsVisible(Garage, function()
                    
                    for i = 1, #wListe.listefourriere, 1 do
                        local hashvoiture = wListe.listefourriere[i].vehicle.model
                        local modelevoiturespawn = wListe.listefourriere[i].vehicle
                        local nomvoituremodele = GetDisplayNameFromVehicleModel(hashvoiture)
                        local nomvoituretexte  = GetLabelText(nomvoituremodele)
                        local plaque = wListe.listefourriere[i].plate

                        RageUI.Button(plaque.." | "..nomvoituretexte, nil, {RightLabel = ">"}, true, {
                        }, subMenu);        
                    end
                end, function()
                end)
                Wait(1)
            end
        end)
    end
end




local interval = 5000

Citizen.CreateThread(function()
    while ESX == nil do
		TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
		Citizen.Wait(100)
	end

    while true do
        for k,v in pairs(wGarage.fourriere) do
            interval = 5000
            local plyCoords = GetEntityCoords(GetPlayerPed(-1), false)
            local dist = Vdist(plyCoords.x, plyCoords.y, plyCoords.z, v.sortie.x, v.sortie.y, v.sortie.z)   
            if dist <= 21.0 then
                interval = 5000
            end

            if dist <= 9.0 then
                interval = 100
            end
            if dist <= 1.5 then
                interval = 0
                ESX.ShowHelpNotification("Appuyez sur [~b~E~w~] pour ranger un ~b~véhicule")
                if IsControlJustPressed(1,51) then
                    ESX.TriggerServerCallback('wGarage:listevoiturefourriere', function(ownedCars)
                        wListe.listefourriere = ownedCars
                    end)
                    openFourriere()
                end   
            end
        end
        Wait(interval)
    end
end)