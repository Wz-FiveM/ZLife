ESX              = nil
local PlayerData = {}
local CopsConnected       	   = 0
local PlayersHarvestingCoke    = {}

TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

------------------------------------------- BMX -------------------------------------------

--[[ ESX.RegisterUsableItem('bmx', function(source)
	TriggerClientEvent('bmx:usebmx', source)
end) ]]

local velo = {
    {'bmx', 'bmx'},
    {'fixter', 'fixter'},
    {'scorcher', 'scorcher'},
    {'tribike', 'tribike'},
    {'tribike2', 'tribike2'},
    {'tribike3', 'tribike3'},
}

for _,v in pairs(velo) do
    ESX.RegisterUsableItem(v[1], function(source)
       local _source = source
       local xPlayer = ESX.GetPlayerFromId(_source)

       TriggerClientEvent('bmx:usebmx', source, v[2])
       xPlayer.removeInventoryItem(v[2], 1)
    end)
end

ESX.RegisterUsableItem('lockpick', function(source)
	TriggerClientEvent("clp:uyselockpickl", source)
end)

RegisterNetEvent('removelockpick')
AddEventHandler('removelockpick', function()
    local _source = source
    local xPlayer = ESX.GetPlayerFromId(source)
	xPlayer.removeInventoryItem('lockpick', 1)
end)

RegisterNetEvent('removeflashlightn')
AddEventHandler('removeflashlightn', function()
    local _source = source
    local xPlayer = ESX.GetPlayerFromId(source)
	xPlayer.removeInventoryItem('flashlight', 1)
end)

RegisterServerEvent('alertelockpick:policealerte1')
AddEventHandler('alertelockpick:policealerte1', function(x, y, z) 
	local total   = math.random(0, 99);
	local _source = source
	local xPlayer = ESX.GetPlayerFromId(_source)
	if xPlayer.job.name == 'police' or xPlayer.job.name == 'sheriff' then
		if total >= 0 and total <= 50 then
			TriggerClientEvent('alertelockpick:policealerte', -1, x, y, z)
		end
	end
end)

AddEventHandler('esx:onRemoveInventoryItem', function(source, item, count)
	if item.name == 'bulletproof' or item.name == 'bulletproofpolice' or item.name == 'bulletproofsheriff' and item.count < 1 then
		TriggerClientEvent('clp:removebullet', source)
	end
end)


RegisterNetEvent('removebmx')
AddEventHandler('removebmx', function()
    local _source = source
    local xPlayer = ESX.GetPlayerFromId(source)
	xPlayer.removeInventoryItem('bmx', 1)
end)

RegisterNetEvent('addbmx')
AddEventHandler('addbmx', function(item)
    local _source = source
    local xPlayer = ESX.GetPlayerFromId(source)
    TriggerClientEvent('esx:DrawMissionText', source, "Vous avez ramassé votre ~g~"..item.."~s~. (~b~+1~s~)", 1500)
	xPlayer.addInventoryItem(item, 1)
end)

RegisterServerEvent('esx_narshop:remove')
AddEventHandler('esx_narshop:remove', function()
	local xPlayer = ESX.GetPlayerFromId(source)
	xPlayer.removeInventoryItem('clip', 1)
end)

RegisterServerEvent('esx_narshop:remove1')
AddEventHandler('esx_narshop:remove1', function()
	local xPlayer = ESX.GetPlayerFromId(source)
	xPlayer.removeInventoryItem('clipextended', 1)
end)

RegisterServerEvent('esx_narshop:remove2')
AddEventHandler('esx_narshop:remove2', function()
	local xPlayer = ESX.GetPlayerFromId(source)
	xPlayer.removeInventoryItem('clipdrum', 1)
end)

RegisterServerEvent('esx_narshop:remove3')
AddEventHandler('esx_narshop:remove3', function()
	local xPlayer = ESX.GetPlayerFromId(source)
	xPlayer.removeInventoryItem('viseur', 1)
end)

ESX.RegisterUsableItem('silencieux', function(source)
    local xPlayer = ESX.GetPlayerFromId(source)	
    TriggerClientEvent('esx_narshop:silencieux', source)
end)

ESX.RegisterUsableItem('flashlight', function(source)
    local xPlayer = ESX.GetPlayerFromId(source)	
    TriggerClientEvent('esx_narshop:flashlight', source)
end)

ESX.RegisterUsableItem('grip', function(source)
    local xPlayer = ESX.GetPlayerFromId(source)	
    TriggerClientEvent('esx_narshop:grip', source)
end)

ESX.RegisterUsableItem('viseur', function(source)
    local xPlayer = ESX.GetPlayerFromId(source)	
    TriggerClientEvent('esx_narshop:viseur', source)
end)

ESX.RegisterUsableItem('clipextended', function(source)
    local xPlayer = ESX.GetPlayerFromId(source)	
    TriggerClientEvent('esx_narshop:clipextended', source)
end)

ESX.RegisterUsableItem('clipdrum', function(source)
    local xPlayer = ESX.GetPlayerFromId(source)	
    TriggerClientEvent('esx_narshop:clipdrum', source)
end)

ESX.RegisterUsableItem('yusuf', function(source)
    local xPlayer = ESX.GetPlayerFromId(source)
    TriggerClientEvent('esx_narshop:yusuf', source)
end)

ESX.RegisterUsableItem('yusuf', function(source)
    local xPlayer = ESX.GetPlayerFromId(source)
    TriggerClientEvent('esx_narshop:yusuf', source)
end)

ESX.RegisterUsableItem('brolly', function(source)
	TriggerClientEvent('esx_useitem:brolly', source)
end)

ESX.RegisterUsableItem('kitpic', function(source)
	local xPlayer  = ESX.GetPlayerFromId(source)
	TriggerClientEvent('esx_useitem:kitpic', source)
	--xPlayer.removeInventoryItem('kitpic', 1)
end)

ESX.RegisterUsableItem('ball', function(source)
	TriggerClientEvent('esx_useitem:ball', source)
end)

ESX.RegisterUsableItem('permis', function(source)
	TriggerClientEvent('esx_useitem:permis', source)
end)

ESX.RegisterUsableItem('permisarmes', function(source)
	TriggerClientEvent('esx_useitem:permisarmes', source)
end)

ESX.RegisterUsableItem('carteidentite', function(source)
	TriggerClientEvent('esx_useitem:carteidentite', source)
end)

ESX.RegisterUsableItem('mask_swim', function(source)
	TriggerClientEvent('esx_useitem:swim', source)
	local xPlayer  = ESX.GetPlayerFromId(source)
	--xPlayer.removeInventoryItem('mask_swim', 1)
end)

ESX.RegisterUsableItem('bong', function(source)
	TriggerClientEvent('esx_useitem:bong', source)
end)

ESX.RegisterUsableItem('nightvision', function(source)
	TriggerClientEvent('esx_useitem:Nightvision', source)
end)

RegisterServerEvent('esx_useitem:bong')
AddEventHandler('esx_useitem:bong', function()

	local xPlayer  = ESX.GetPlayerFromId(source)

	xPlayer.removeInventoryItem('bong', 1)
	TriggerClientEvent('esx_status:add', source, 'drunk', 450000)

end)

ESX.RegisterUsableItem('sandwich', function(source)
	TriggerClientEvent('esx_useitem:sandwich', source)

	local xPlayer = ESX.GetPlayerFromId(source)

	xPlayer.removeInventoryItem('bread', 1)	
	TriggerClientEvent('esx_status:add', source, 'hunger', 500000)

end)

ESX.RegisterUsableItem('tatgun', function(source)
	TriggerClientEvent('esx_useitem:tatgun', source)
end)

ESX.RegisterUsableItem('bulletproof', function(source)
	TriggerClientEvent('esx_useitem:bulletproof', source, itemData, itemNum)
end)

RegisterServerEvent('removebullet')
AddEventHandler('removebullet', function()
	local xPlayer = ESX.GetPlayerFromId(source)
	xPlayer.removeInventoryItem('bulletproof', 1)
end)

ESX.RegisterUsableItem('bulletproofpolice', function(source)

	local xPlayer = ESX.GetPlayerFromId(source)

	TriggerClientEvent('esx_useitem:removebulletpolice', source)
end)

RegisterServerEvent('removebulletpolice')
AddEventHandler('removebulletpolice', function()
	local xPlayer = ESX.GetPlayerFromId(source)
	xPlayer.removeInventoryItem('bulletproofpolice', 1)
end)

RegisterServerEvent('removebulletsheriff')
AddEventHandler('removebulletsheriff', function()
	local xPlayer = ESX.GetPlayerFromId(source)
	xPlayer.removeInventoryItem('bulletproofsheriff', 1)
end)

ESX.RegisterUsableItem('bulletproofsheriff', function(source)
	TriggerClientEvent('esx_useitem:removebulletsheriff', source)
end)


------------------------------------
	----- Utiliser Kali Linux -------
------------------------------------

ESX.RegisterUsableItem('kalilinux', function(source)

	TriggerClientEvent('esx_useitem:kalilinux', source)

end)

------------------------------------
	----- Utiliser ROSE -------
------------------------------------

ESX.RegisterUsableItem('rose', function(source)
	
		TriggerClientEvent('esx_useitem:rose', source)
	
end)

------------------------------------
	----- Utiliser NOTEPAD -------
------------------------------------

ESX.RegisterUsableItem('notepad', function(source)
	
		TriggerClientEvent('esx_useitem:notepad', source)
	
end)

--HAZMAT NOIRE
ESX.RegisterUsableItem('sactactique', function(source)
    local _source = source
    local xPlayer = ESX.GetPlayerFromId(_source)
    
    TriggerClientEvent('c_inv:settenuesactac', _source)
end)


--HAZMAT NOIRE
ESX.RegisterUsableItem('hazmat1', function(source)
    local _source = source
    local xPlayer = ESX.GetPlayerFromId(_source)
    
    TriggerClientEvent('esx_objects:settenuehaz1', _source)
end)

--HAZMAT BLEUE
ESX.RegisterUsableItem('hazmat2', function(source)
    local _source = source
    local xPlayer = ESX.GetPlayerFromId(_source)
    
    TriggerClientEvent('esx_objects:settenuehaz2', _source)
end)

--HAZMAT BREAKINGBAD
ESX.RegisterUsableItem('hazmat3', function(source)
    local _source = source
    local xPlayer = ESX.GetPlayerFromId(_source)
    
    TriggerClientEvent('esx_objects:settenuehaz3', _source)
end)

--HAZMAT BLANCHE
ESX.RegisterUsableItem('hazmat4', function(source)
    local _source = source
    local xPlayer = ESX.GetPlayerFromId(_source)
    
    TriggerClientEvent('esx_objects:settenuehaz4', _source)
end)

--CASA PAPEL
ESX.RegisterUsableItem('casapapel', function(source)
    local _source = source
    local xPlayer = ESX.GetPlayerFromId(_source)
    
    TriggerClientEvent('esx_objects:settenuecasa', _source)
end)

--TENUE KARTING
ESX.RegisterUsableItem('karting1', function(source)
    local _source = source
    local xPlayer = ESX.GetPlayerFromId(_source)
    
    TriggerClientEvent('esx_objects:settenuekarting1', _source)
end)

--TENUE KARTING2
ESX.RegisterUsableItem('karting2', function(source)
    local _source = source
    local xPlayer = ESX.GetPlayerFromId(_source)
    
    TriggerClientEvent('esx_objects:settenuekarting2', _source)
end)

--TENUE SKYDIVING
ESX.RegisterUsableItem('skydiving', function(source)
    local _source = source
    local xPlayer = ESX.GetPlayerFromId(_source)
    
    TriggerClientEvent('esx_objects:settenueskydivingcl', _source)
end)

--TENUE PRISON
ESX.RegisterUsableItem('prisonnier', function(source)
    local _source = source
    local xPlayer = ESX.GetPlayerFromId(_source)
    
    TriggerClientEvent('esx_objects:settenuejailer', _source)
end)

--TENUE Little Pricks
ESX.RegisterUsableItem('LittlePricks', function(source)
    local _source = source
    local xPlayer = ESX.GetPlayerFromId(_source)
    
    TriggerClientEvent('esx_objects:settenuelittlepricks', _source)
end)

--TENUE Mécano
ESX.RegisterUsableItem('LsCustoms', function(source)
    local _source = source
    local xPlayer = ESX.GetPlayerFromId(_source)
    
    TriggerClientEvent('esx_objects:settenuelscustoms', _source)
end)



RegisterServerEvent('esx_outlawalert:carJackInProgress')
AddEventHandler('esx_outlawalert:carJackInProgress', function(targetCoords, streetName, vehicleLabel, playerGender)
    local _source = source
    local xPlayer = ESX.GetPlayerFromId(_source)

    if playerGender == 0 then
		playerGender = "Homme"
	else
		playerGender = "Femme"
	end
    
    --if xPlayer.job.name == 'police' or xPlayer.job.name == 'sheriff' then
	TriggerClientEvent('esx:showAdvancedNotification', -1, "Centrale", "~b~Appel d'urgence: 911", "~b~Identité: ~s~"..playerGender.."\n~b~Localisation: ~s~"..streetName.."\n~b~Infos: ~s~Vol de véhicule", 'CHAR_CALL911', 7)
    TriggerClientEvent('esx:showNotification', -1, "Accepter: ~g~E~s~ Refuser : ~r~X")
    --end
	TriggerClientEvent('esx_outlawalert:carJackInProgress', -1, targetCoords)
end)

ESX.RegisterServerCallback('esx_outlawalert:isVehicleOwner', function(source, cb, plate)
	local identifier = GetPlayerIdentifier(source, 0)

	MySQL.Async.fetchAll('SELECT owner FROM owned_vehicles WHERE owner = @owner AND plate = @plate', {
		['@owner'] = identifier,
		['@plate'] = plate
	}, function(result)
		if result[1] then
			cb(result[1].owner == identifier)
		else
			cb(false)
		end
	end)
end)








local vehicles = {}

function getVehData(plate, callback)
    MySQL.Async.fetchAll("SELECT * FROM `owned_vehicles`", {},
    function(result)
        local foundIdentifier = nil
        for i=1, #result, 1 do
            local vehicleData = json.decode(result[i].vehicle)
            if vehicleData.plate == plate then
                foundIdentifier = result[i].owner
                break
            end
        end
        if foundIdentifier ~= nil then
            MySQL.Async.fetchAll("SELECT * FROM `users` WHERE `identifier` = @identifier", {['@identifier'] = foundIdentifier},
            function(result)
                local ownerName = result[1].firstname .. " " .. result[1].lastname

                local info = {
                    plate = plate,
                    owner = ownerName
                }
                callback(info)
            end
          )
        else -- if identifier is nil then...
          local info = {
            plate = plate
          }
          callback(info)
        end
    end)
  end

RegisterNetEvent("esx_nocarjack:setVehicleDoorsForEveryone")
AddEventHandler("esx_nocarjack:setVehicleDoorsForEveryone", function(veh, doors, plate)
    local _source = source
    local xPlayer = ESX.GetPlayerFromId(_source)
    local veh_model = veh[1]
    local veh_doors = veh[2]
    local veh_plate = veh[3]

    if not vehicles[veh_plate] then
        getVehData(veh_plate, function(veh_data)
            if veh_data.plate ~= plate then
                local players = GetPlayers()
                for _,player in pairs(players) do
                    TriggerClientEvent("esx_nocarjack:setVehicleDoors", player, table.unpack(veh, doors))
                end
            end
        end)
        vehicles[veh_plate] = true
    end
end)

local Cops = {
	"steam:100000000000",
}

RegisterServerEvent("PoliceVehicleWeaponDeleter:askDropWeapon")
AddEventHandler("PoliceVehicleWeaponDeleter:askDropWeapon", function(wea)
	local isCop = false

	for _,k in pairs(Cops) do
		if(k == getPlayerID(source)) then
			isCop = true
			break;
		end
	end

	if(not isCop) then
		print(1)
		TriggerClientEvent("PoliceVehicleWeaponDeleter:drop", source, wea)
	end

end)


function getPlayerID(source)
    local identifiers = GetPlayerIdentifiers(source)
    local player = getIdentifiant(identifiers)
    return player
end

function getIdentifiant(id)
    for _, v in ipairs(id) do
        return v
    end
end