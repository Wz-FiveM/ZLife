ESX = nil
local PlayerData = {}
local open = false

local Garage = RageUI.CreateMenu("Garage", " ",0,80)
Garage:DisplayGlare(true)
Garage.Closed = function()
end
Garage:DisplayPageCounter(true)

local wListe = {
    listevoiture = {},
    listefourriere = {}
}


Citizen.CreateThread(function()
    for k,v in pairs(wGarage.zone) do
       local blip = AddBlipForCoord(v.sortie.x, v.sortie.y, v.sortie.z)
       SetBlipSprite(blip, 473)
       SetBlipColour(blip, 0)
       SetBlipScale(blip, 0.6)
       SetBlipAsShortRange(blip, true)

       BeginTextCommandSetBlipName('STRING')
       AddTextComponentString("Garage")
       EndTextCommandSetBlipName(blip)
   end
end)




--marker vehicule en fourriere
Citizen.CreateThread(function()
   while true do
       Citizen.Wait(0)
       local coords, letSleep = GetEntityCoords(PlayerPedId()), true

       for k,v in pairs(wGarage.zone) do
           if (wGarage.Type ~= -1 and GetDistanceBetweenCoords(coords, v.ranger.x, v.ranger.y, v.ranger.z, true) < wGarage.DrawDistance) then
               DrawMarker(wGarage.Type, v.ranger.x, v.ranger.y, v.ranger.z, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, wGarage.Size.x, wGarage.Size.y, wGarage.Size.z, wGarage.Color2.r, wGarage.Color2.g, wGarage.Color2.b, 100, false, true, 2, false, false, false, false)
               letSleep = false
           end
       end


       for k,v in pairs(wGarage.zone) do
           if (wGarage.Type ~= -1 and GetDistanceBetweenCoords(coords, v.sortie.x, v.sortie.y, v.sortie.z, true) < wGarage.DrawDistance) then
               DrawMarker(wGarage.Type, v.sortie.x, v.sortie.y, v.sortie.z, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, wGarage.Size.x, wGarage.Size.y, wGarage.Size.z, wGarage.Color.r, wGarage.Color.g, wGarage.Color.b, 100, false, true, 2, false, false, false, false)
               letSleep = false
           end
       end

       if letSleep then
           Citizen.Wait(500)
       end
   end
end)


function openGarage()
    if open then
        open = false
        RageUI.Visible(Garage, false)
    else
        open = true
        RageUI.Visible(Garage, true)
        Citizen.CreateThread(function()
            while open do
                RageUI.IsVisible(Garage, function()
                    
                    for i = 1, #wListe.listevoiture, 1 do
                        local hashvoiture = wListe.listevoiture[i].vehicle.model
                        local modelevoiturespawn = wListe.listevoiture[i].vehicle
                        local nomvoituremodele = GetDisplayNameFromVehicleModel(hashvoiture)
                        local nomvoituretexte  = GetLabelText(nomvoituremodele)
                        local plaque = wListe.listevoiture[i].plate

                        RageUI.Button(plaque.." | "..nomvoituretexte, nil, {RightLabel = ">"}, true, {
                            onSelected = function()
                            sortirvoiture(modelevoiturespawn, plaque)
                        end
                        });        
                    end
                end, function()
                end)
                Wait(1)
            end
        end)
    end
end




local publicgarage = false
local interval = 5000


Citizen.CreateThread(function()
    while ESX == nil do
		TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
		Citizen.Wait(100)
	end

    while true do
        for k,v in pairs(wGarage.zone) do
            interval = 5000
            local plyCoords = GetEntityCoords(GetPlayerPed(-1), false)
            local dist = Vdist(plyCoords.x, plyCoords.y, plyCoords.z, v.ranger.x, v.ranger.y, v.ranger.z)
            local dist2 = Vdist(plyCoords.x, plyCoords.y, plyCoords.z, v.sortie.x, v.sortie.y, v.sortie.z)     
            if dist and dist2 <= 21.0 then
                interval = 5000
            end

            if dist and dist2 <= 9.0 then
                interval = 100
            end
            if dist <= 1.5 then
                interval = 1
                ESX.ShowHelpNotification("Appuyez sur [~b~E~w~] pour ranger un ~b~véhicule")
                if IsControlJustPressed(1,51) then
                    StockVehicle()
                end   
            end
            if dist2 <= 1.5 then
                interval = 1
                ESX.ShowHelpNotification("Appuyez sur [~b~E~w~] pour sortir un ~b~véhicule")
                if IsControlJustPressed(1,51) then
                    ESX.TriggerServerCallback('wGarage:listevoiture', function(ownedCars)
                        wListe.listevoiture = ownedCars
                    end)
                    openGarage()
                end
            end
        end
        Wait(interval)
    end
end)