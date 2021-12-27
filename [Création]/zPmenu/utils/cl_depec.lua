local listValid = {-1716189206,2227010557,2460120199,4191993645,3756226112,3441901897,-1834847097,-581044007,-538741184}
local TimeDelete = 60
local hashAnimals = {
    {hash = GetHashKey('a_c_deer'), name = "une Biche", item = "viande", count = 2},
    {hash = GetHashKey('a_c_cormorant'), name = "un Cormorant", item = "viande", count = 2},
    {hash = GetHashKey('a_c_coyote'), name = "un Coyote", item = "viande", count = 2},
    {hash = GetHashKey('a_c_crow'), name = "un Corbeau", item = "viande", count = 2},
    {hash = GetHashKey('a_c_mtlion'), name = "une Pantère", item = "viande", count = 2},
    {hash = GetHashKey('a_c_pig'), name = "un Cochon", item = "viande", count = 2},
    {hash = GetHashKey('a_c_pigeon'), name = "un Pigeon", item = "viande", count = 2},
    {hash = GetHashKey('a_c_rabbit_01'), name = "un Lapin", item = "viande", count = 2},
    {hash = GetHashKey('a_c_seagull'), name = "une Pie", item = "viande", count = 2},
    {hash = GetHashKey('a_c_hen'), name = "une Poule", item = "viande", count = 2},
    {hash = GetHashKey('a_c_boar'), name = "un Sanglier", item = "viande", count = 2},
    {hash = GetHashKey('a_c_chickenhawk'), name = "un Épervier de poulet", item = "viande", count = 2},
}

local notifDepouilleID
local depouillenaimaeltime

local function delPeds(ped, time)
    Citizen.CreateThread(function()
        Wait(time*1000)
        if ped ~= nil then
            SetEntityAsNoLongerNeeded(ped)
            DeleteEntity(ped)
        end
    end)
end

local function FindAnimals(ped)
    local hash = GetEntityModel(ped)
    for _,v in pairs(hashAnimals) do
        if v.hash == hash then
            return v
        end
    end
end

RegisterControlKey("depouille","Dépecer un animal","",function()
    local time = 30000
    local playerPed = PlayerPedId()
    local dstPeds = GetClosestPed2(GetEntityCoords(playerPed), 3.0)
    local SlctWeapon = GetSelectedPedWeapon(playerPed)
    local animals = FindAnimals(dstPeds)

    if dstPeds and DoesEntityExist(dstPeds) and IsEntityDead(dstPeds) and GetPedType(dstPeds) == 28 and tableHasValue(listValid, SlctWeapon) and animals ~= nil then
        if IsEntityAMissionEntity(dstPeds) then return end
        if depouillenaimaeltime and depouillenaimaeltime > GetGameTimer() then
            if notifDepouilleID then
                RemoveNotification(notifDepouilleID)
            end
            notifDepouilleID = ShowAboveRadarMessage(string.format("~r~Veuillez patienter encore %s seconde(s) avant de dépecer un autre animal.", math.floor((depouillenaimaeltime - GetGameTimer()) / 1000))) return
        end
        local depuioilletime = 5000 + time
        depouillenaimaeltime = GetGameTimer() + depuioilletime
    end

    if not IsPedInAnyVehicle(playerPed, false) and IsPedWeaponReadyToShoot(playerPed) then
        if dstPeds and DoesEntityExist(dstPeds) and IsEntityDead(dstPeds) and GetPedType(dstPeds) == 28 then
            if not tableHasValue(listValid, SlctWeapon) then
                ShowAboveRadarMessage("~r~Vous devez utiliser un objet tranchant.")
            else
                ExecuteCommand('me dépece l\'animal')
                RemoveNotification(notifDepouilleID)
                --createProgressBar("Vous dépecez "..animals.name.."",181, 45, 45, 150, 12000)
                local dict, anim = "missexile3","ex03_dingy_search_case_a_michael"
                RequestAndWaitDict(dict)
                TaskPlayAnim(GetPlayerPed(-1), dict, anim, 8.0, 8.0, -1, 1, 1, 0, 0, 0)
                local PedsNet = PedToNet(dstPeds)
                Citizen.Wait(12000)
                if PedsNet then
                    TriggerServerEvent("clp:giveitemchill", animals.item, 1) -- Give de l'item
                else
                    ShowAboveRadarMessage("~r~Impossible de dépecer cet animal.")
                end
                SetEntityAsMissionEntity(dstPeds,true,true)
                ClearPedTasks(playerPed)
                delPeds(dstPeds, TimeDelete)
            end
        end
    end

end)

