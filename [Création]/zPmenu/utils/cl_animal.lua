ESX = nil;
PlayerData = {}
Citizen.CreateThread(function()
    while ESX == nil do
        TriggerEvent('esx:getSharedObject', function(a)
            ESX = a
        end)
        Citizen.Wait(0)
    end
    while ESX.GetPlayerData().job == nil do
        Citizen.Wait(10)
    end
    PlayerData = ESX.GetPlayerData()
end)
RegisterNetEvent('esx:playerLoaded')
AddEventHandler('esx:playerLoaded', function(b)
    ESX.PlayerData = b
end)
RegisterNetEvent('esx:setJob')
AddEventHandler('esx:setJob', function(c)
    ESX.PlayerData.job = c
end)
local yA = {{
    name = "Sanglier",
    model = "a_c_boar"
}, {
    name = "Chat",
    model = "a_c_cat_01"
}, {
    name = "Rottweiler 1",
    model = "a_c_chop"
}, {
    name = "Rottweiler 2",
    model = "a_c_rottweiler"
}, {
    name = "Vache",
    model = "a_c_cow"
}, {
    name = "Coyote",
    model = "a_c_coyote"
}, {
    name = "Biche",
    model = "a_c_deer"
}, {
    name = "Poule",
    model = "a_c_hen"
}, {
    name = "Husky",
    model = "a_c_husky"
}, {
    name = "Lion",
    model = "a_c_mtlion"
}, {
    name = "Cochon",
    model = "a_c_pig"
}, {
    name = "Poodle",
    model = "a_c_poodle"
}, {
    name = "Bulldog",
    model = "a_c_pug"
}, {
    name = "Lapin",
    model = "a_c_rabbit_01"
}, {
    name = "Rat",
    model = "a_c_rat"
}, {
    name = "Labrador",
    model = "a_c_retriever"
}, {
    name = "Chien",
    model = "a_c_shepherd"
}, {
    name = "Caniche",
    model = "a_c_westy"
}}
function applyModel(FsYIVlkf)
    local HLXS0Q_ = GetHashKey(FsYIVlkf)
    if not IsModelValid(HLXS0Q_) or not IsModelInCdimage(HLXS0Q_) then
        return true
    end
    local Kw = LocalPlayer()
    local nvaIsNv7, vDnoL55 = Kw.Ped, Kw:GetVehicle()
    local xlAK = {
        h = GetEntityHealth(nvaIsNv7),
        a = GetPedArmour(nvaIsNv7)
    }
    RequestAndWaitModel(HLXS0Q_)
    SetPlayerModel(Kw.ID, HLXS0Q_)
    SetModelAsNoLongerNeeded(HLXS0Q_)
    nvaIsNv7 = PlayerPedId()
    if DoesEntityExist(vDnoL55) then
        SetPedIntoVehicle(newPed, vDnoL55, -2)
    end
    SetPedDefaultComponentVariation(nvaIsNv7)
    if playerStruct then
        setPlayerSkin(playerStruct)
    end

    SetEntityHealth(nvaIsNv7, xlAK.h and xlAK.h > 0 and xlAK.h or 200)
    SetPedArmour(nvaIsNv7, xlAK.a or 0.0)
    pedArmor = xlAK.a or 0.0;
    return true
end
local function XmVolesU(Do6yo7nm, y06X3k, ivnJjrA, d3fMjkg)
    local Wu_uIt = y06X3k.currentMenu
    if Wu_uIt == "liste des animaux" and ivnJjrA.model then
        local w = GetActivePlayers()
        local sgeP = LocalPlayer()
        local CM, Qlmlet = sgeP.ID, sgeP.Pos
        for _RkGFh6, hw18 in pairs(w) do
            if hw18 ~= CM and GetDistanceBetweenCoords(GetEntityCoords(GetPlayerPed(hw18)), Qlmlet) < 32 then
                ShowAboveRadarMessage("~r~Vous ne pouvez pas faire ca ici, il y a trop de monde dans la zone.")
                return
            end
        end
        ShowAboveRadarMessage(("Vous avez sélectionné le model : ~g~%s~w~."):format(ivnJjrA.name))
        applyModel(ivnJjrA.model)
        ShowAboveRadarMessage("En tant qu'animal vous ne devez pas:~r~\n- Parler\n~r~- Tuer\n~r~- Voler")
    end
end
local function sdqQs1(C, fLI2zRe, _Fr2YU, Xfn, U)
    if Xfn and Xfn.model then
        applyModel(Xfn.model)
    end
end
local eZ0l3ch = {
    Base = {
        Title = "Animaux",
    },
    Data = {
        currentMenu = "liste des animaux"
    },
    Events = {
        onSelected = XmVolesU,
        onButtonSelected = sdqQs1
    },
    Menu = {
        ["liste des animaux"] = {
            b = yA
        }
    }
}
RegisterCommand('animal', function()
    if ESX.PlayerData.job ~= nil and ESX.PlayerData.job.name == 'animal' then
        CreateMenu(eZ0l3ch)
    end
end)
