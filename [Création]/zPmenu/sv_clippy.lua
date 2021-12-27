ESX              = nil
local PlayerData = {}
PlayersResell   = {}

TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

local webhook = "WEB"

function SendWebhookMessage(webhook,message)
    if webhook ~= nil and webhook ~= "" then
        PerformHttpRequest(webhook, function(err, text, headers) end, 'POST', json.encode({content = message}), { ['Content-Type'] = 'application/json' })
    end
end

local item = {
    {'bread', 'Hamburger', 'faim', 100, 'prop_cs_burger_01', 'mp_player_inteat@burger', 'mp_player_int_eat_burger_fp'},
    {'donut', 'Donut', 'faim', 20, 'prop_amb_donut', 'mp_player_inteat@burger', 'mp_player_int_eat_burger_fp'},
    {'chocolat', 'Barre de chocolat', 'faim', 20, 'prop_choc_ego', 'mp_player_inteat@burger', 'mp_player_int_eat_burger_fp'},
    {'chips', 'Paquet de chips', 'faim', 20, 'prop_cs_crisps_01', 'mp_player_inteat@burger', 'mp_player_int_eat_burger_fp'},


    {'water', 'Eau', 'soif', 100, 'prop_ld_flow_bottle', 'mp_player_intdrink', 'loop_bottle'},
    {'whisky', 'Whisky', 'soif', 30, 'prop_cs_whiskey_bottle', 'mp_player_intdrink', 'loop_bottle'},
    {'milk', 'Brique de lait', 'soif', 30, 'prop_cs_milk_01', 'mp_player_intdrink', 'loop_bottle'},
    {'coffe', 'Café', 'soif', 30, 'p_amb_coffeecup_01', 'mp_player_intdrink', 'loop_bottle'},
    {'coca', 'Coca', 'soif', 100, 'prop_ld_flow_bottle', 'mp_player_intdrink', 'loop_bottle'},
    {'redbull', 'Redbull', 'soif', 100, 'prop_ld_flow_bottle', 'mp_player_intdrink', 'loop_bottle'},
    {'vodka', 'Vodka', 'soif', 100, 'prop_ld_flow_bottle', 'mp_player_intdrink', 'loop_bottle'},
}

for _,v in pairs(item) do
    ESX.RegisterUsableItem(v[1], function(source)
        local _source = source
        local xPlayer = ESX.GetPlayerFromId(_source)

        TriggerClientEvent('kxzeriia:hungerthrist', source, v[3], v[4], v[5], v[6], v[7])
        xPlayer.removeInventoryItem(v[1], 1)
        TriggerClientEvent('esx:showNotification', source, 'Vous avez utilisé ~g~1 '..v[2])
    end)
end

local eatitem = {
    {'cigarette', 'eatItem', 'Cigarette', 'hunger', 0},
    {'cigar', 'eatItem', 'Cigarette', 'hunger', 0},
    -- eatItem
    {'hamburger', 'eatItem', 'Hamburger', 'hunger', 40}, -- Meilleur
    -- LTD
    {'donut', 'eatItem', 'Donut', 'hunger', 250},
    {'chocolat', 'eatItem', 'Chocolat', 'hunger', 25},
    {'frites', 'eatItem', 'Frites', 'hunger', 25},
    {'hotdog', 'eatItem', 'Hot-dog', 'hunger', 25},
    -- Farm
    {'viande', 'eatItem', 'Viande crue', 'hunger', 25},
    {'whitefish', 'eatItem', "Ombre de l'arctique", 'hunger', 25},
    {'fish', 'eatItem', 'Truite de lac', 'hunger', 25},
    {'goldfish', 'eatItem', 'Saumon frais', 'hunger', 25},
    {'carpecuir', 'eatItem', 'Truite arc-en-ciel', 'hunger', 25},
    {'pompom', 'eatItem', 'Truite bull', 'hunger', 25},
    -- Divers
    {'kebab', 'eatItem', 'Kebab', 'hunger', 25},
    {'fricadelle', 'eatItem', 'Fricadelle', 'hunger', 25},
    {'tapas', 'eatItem', 'Tapas', 'hunger', 25},
    {'chinook', 'eatItem', 'Chinook', 'hunger', 25},
    {'tender', 'eatItem', 'Tender', 'hunger', 25},
    -- drinkItem
    {'jusfruit', 'drinkItem', 'Jus de Leechi', 'thirst', 40}, -- Meilleur
    -- Soirée
    {'magnum', 'eatItem', 'Magnum', 'thirst', 25},
    {'triplebiere', 'drinkItem', 'Triple bière', 'thirst', 25},
    {'jupiler', 'drinkItem', 'Jupiler', 'thirst', 25},
    {'tequila', 'drinkItem', 'Tequila', 'thirst', 25},
    {'whisky', 'drinkItem', 'Whisky', 'thirst', 25},
    {'vin', 'drinkItem', 'Vin', 'thirst', 25},
    {'mojito', 'drinkItem', 'Tequila', 'thirst', 25},
    {'rhum', 'drinkItem', 'Vin', 'thirst', 25},
    {'vodka', 'drinkItem', 'Bière sans alcool', 'thirst', 25},
    {'biere', 'drinkItem', 'Bière', 'thirst', 25},
    {'cocktail', 'drinkItem', 'Cocktail', 'thirst', 25},
    {'champagne', 'drinkItem', 'Champagne', 'thirst', 25},
    -- LTD
    {'cafe', 'drinkItem', 'Café', 'thirst', 25},
    {'water', 'drinkItem', 'Eau de source', 'thirst', 25},
    {'soda', 'drinkItem', 'Soda', 'thirst', 25},
    {'tea', 'drinkItem', 'Thé vert', 'thirst', 25},
    {'jusraisin', 'drinkItem', 'Jus de Leechi', 'thirst', 25},
    {'coca', 'drinkItem', 'Coca', 'thirst', 25},
}
for _,v in pairs(eatitem) do
    ESX.RegisterUsableItem(v[1], function(source)
        local _source = source
        local xPlayer = ESX.GetPlayerFromId(_source)

        TriggerClientEvent('clp_nour:gry', source, v[2], v[3], v[4], v[5])
        xPlayer.removeInventoryItem(v[1], 1)
    end)
end

ESX.RegisterServerCallback('esx_vending:checkMoneyandInvent', function(source, cb, item)
    local plySource = source
    local thisItem = item
    local thisCost = nil
    local thisName = nil
    local xPlayer = ESX.GetPlayerFromId(plySource)
    local cashMoney = xPlayer.getMoney()
    local targetItem = xPlayer.getInventoryItem(thisItem)

    thisCost = 5

    if thisCost > cashMoney then
        cb("cash")
    else
        xPlayer.removeMoney(thisCost)
        xPlayer.addInventoryItem(thisItem, 1)
        cb(true)
    end
end)

-- prop_amb_beer_bottle:     Bière

RegisterServerEvent("kxzeriia:savefood")
AddEventHandler("kxzeriia:savefood", function(eau,f)
    local xPlayers = ESX.GetPlayers()

    for i=1, #xPlayers, 1 do
        local xPlayer = ESX.GetPlayerFromId(xPlayers[i])
        MySQL.Async.execute('UPDATE users SET food= @food, thirst = @eau where identifier =@identifier', {['@eau']   =eau, ['@food'] = f, ['@identifier'] = xPlayer.identifier})
    end
end)

RegisterServerEvent('humeur:update')
AddEventHandler('humeur:update', function(humeur)
	local _source = source
	local xPlayer = ESX.GetPlayerFromId(_source)
	
    MySQL.Async.execute(
		'UPDATE users SET humeur = @humeur WHERE identifier = @identifier',
		{
			['@humeur']     = json.encode(humeur),
			['@identifier'] = xPlayer.identifier
		}
    )
end)

Heap = {}

ESX.RegisterServerCallback("james_barbershop:fetchBusyState", function(source, callback)
    local player = ESX.GetPlayerFromId(source)

    if not player then return callback(false) end

    callback(Heap.Busy)
end)

RegisterNetEvent("esx:playerDropped")
AddEventHandler("esx:playerDropped", function(source)
    if Heap.Busy == source then
        TriggerClientEvent("james_barbershop:eventHandler", -1, "CHAIR_BUSY", false)

        Heap.Busy = false
    end
end)
RegisterServerEvent('esx_reload:clip')
AddEventHandler('esx_reload:clip', function(item)
	local _source = source
	local xPlayer = ESX.GetPlayerFromId(_source)

	if xPlayer.getInventoryItem(item or "disc_ammo_pistol").count >= 1 then
	  TriggerClientEvent('esx_reload:clipreload', source)
	  xPlayer.removeInventoryItem(item, 1)
	else
		TriggerClientEvent('esx:DrawMissionText', source, "~r~Vous n'avez pas de chargeur de ce type.", 2000) -- FIN
	end
end)
RegisterNetEvent("james_barbershop:globalEvent")
AddEventHandler("james_barbershop:globalEvent", function(eventData)
    if eventData.Event == "CHAIR_BUSY" then
        Heap.Busy = eventData and source or false
    end

    TriggerClientEvent("james_barbershop:eventHandler", -1, eventData.Event, eventData.Data)
end)

RegisterNetEvent("james_barbershop:payment")
AddEventHandler("james_barbershop:payment", function()
    local player = ESX.GetPlayerFromId(source)

    if not player then return end

    local payment = 50

    if payment > 0 then
        if player.getMoney() > payment then
            player.removeMoney(payment)
        else
            player.removeAccountMoney("bank", payment)
        end

        TriggerClientEvent("esx:showNotification", source, "~b~Vous venez de payer ~g~50$~b~ au coiffeur.")
    end
end)

RegisterServerEvent('demarche:update')
AddEventHandler('demarche:update', function(demarche)
	local _source = source
	local xPlayer = ESX.GetPlayerFromId(_source)
	
	MySQL.Async.execute(
		'UPDATE users SET demarche = @demarche WHERE identifier = @identifier',
		{
			['@demarche']     = json.encode(demarche),
			['@identifier'] = xPlayer.identifier
		}
    )
end)


RegisterServerEvent('anims:update')
AddEventHandler('anims:update', function(anim, func, pad)
	local _source = source
	local xPlayer = ESX.GetPlayerFromId(_source)
	
	MySQL.Async.execute(
		'UPDATE users SET '..pad..' = @pad WHERE identifier = @identifier',
		{
			['@pad']     = json.encode(anim, func),
			['@identifier'] = xPlayer.identifier
		}
    )
end)
RegisterServerEvent("anims:upstarhe")
AddEventHandler("anims:upstarhe", function(pad)
    local _source = source
    local xPlayer  = ESX.GetPlayerFromId(_source)
    local player = xPlayer.getIdentifier()
    local result = MySQL.Sync.fetchAll("SELECT * FROM users WHERE identifier=@username", {['@username'] = player})
    if (result) then
        if xPlayer ~= nil then
            TriggerClientEvent("anims:start", _source, result[1].pad or nil)
        end
    end
end)

ESX.RegisterUsableItem("camera", function(source)
    local _source = source
    local xPlayer = ESX.GetPlayerFromId(_source)
    TriggerClientEvent('Cam:ToggleCam', source)
end)

ESX.RegisterUsableItem("micro", function(source)
    local _source = source
    local xPlayer = ESX.GetPlayerFromId(_source)
    TriggerClientEvent('Mic:ToggleMic', source)
end)

RegisterServerEvent("demarche:upstarhe")
AddEventHandler("demarche:upstarhe", function(xPlayer)
    local _source = source
    local xPlayer  = ESX.GetPlayerFromId(_source)
    local player = xPlayer.getIdentifier()
    local result = MySQL.Sync.fetchAll("SELECT * FROM users WHERE identifier=@username", {['@username'] = player})
    if (result) then
        if xPlayer ~= nil then
            TriggerClientEvent("demarche:upstarhe", _source, result[1].demarche or nil)
            TriggerClientEvent("humeur:upstarhe", _source, result[1].humeur or nil)
        end
    end
end)

---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
------------------------------------------------------------------------------------------ MENU F5 ------------------------------------------------------------------------------------------
---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------



RegisterNetEvent("power:createcart")
AddEventHandler("power:createcart", function (codebk)
    local xPlayer = ESX.GetPlayerFromId(source)
    MySQL.Async.execute(
        'UPDATE users SET `code` = @code WHERE identifier = @identifier',
        {
            
            ['@code']       = codebk,
            ['@identifier'] = xPlayer.identifier
            
        }
    )
   
    xPlayer.addInventoryItem("cartebancaire", 1)
end)

local function getLicense(source)
    for k,v in pairs(GetPlayerIdentifiers(source))do
        if string.sub(v, 1, string.len("license:")) == "license:" then
        return v
        end

    end
    return ""
end

RegisterServerEvent('c_character:saveidentite')
AddEventHandler('c_character:saveidentite', function(ResultSexe, ResultPrenom, ResultNom, ResultDateDeNaissance, ResultTaille)
    _source = source
    -- mySteamID = GetPlayerIdentifiers(_source)
    -- mySteam = mySteamID[1]
    local license = getLicense(source)
    print("".. ResultSexe, ResultPrenom, ResultNom, ResultDateDeNaissance, ResultTaille, license .. "")


    MySQL.Async.execute('UPDATE users SET `firstname` = @firstname, `lastname` = @lastname, `dateofbirth` = @dateofbirth, `sex` = @sex, `height` = @height WHERE identifier = @identifier', {
      ['@identifier']		= license,
      ['@firstname']		= ResultPrenom,
      ['@lastname']		= ResultNom,
      ['@dateofbirth']	= ResultDateDeNaissance,
      ['@sex']			= ResultSexe,
      ['@height']			= ResultTaille
    }, function(rowsChanged)
      if callback then
        callback(true)
      end
    end)
end)



RegisterServerEvent("clp_char:createsign")
AddEventHandler("clp_char:createsign", function(xPlayer)
    local _source = source
    local xPlayer  = ESX.GetPlayerFromId(_source)
    local player = getLicense(source)
    local result = MySQL.Sync.fetchAll("SELECT * FROM users WHERE identifier=@username", {['@username'] = player})
    if result[1] then
        if xPlayer ~= nil then
            TriggerClientEvent("clp_char:createsign", _source, (result[1].firstname .. " " .. result[1].lastname), xPlayer.job.label, ("Cash: " .. result[1].money .. "$"))
        end
    end
end)  


RegisterNetEvent('c_character:givetiemstart')
AddEventHandler('c_character:givetiemstart', function()
    local _source = source
    local xPlayer = ESX.GetPlayerFromId(_source)
    xPlayer.addInventoryItem("chocolat", 2)
    xPlayer.addInventoryItem("water", 2)
end)



RegisterServerEvent('fuel:pay')
AddEventHandler('fuel:pay', function(price)
	local xPlayer = ESX.GetPlayerFromId(source)
	local amount = ESX.Math.Round(price)
	if price > 0 then
		xPlayer.removeMoney(amount)
	end
end)

RegisterServerEvent("achat:velo")
AddEventHandler("achat:velo", function()
    local _source = source
    local xPlayer = ESX.GetPlayerFromId(source)
    local money = xPlayer.getMoney(source)
    if money >= 50 then
        xPlayer.removeMoney(50)
        xPlayer.addInventoryItem("bmx", 1)
    end
    if money <= 50 then
        TriggerClientEvent("esx:DrawMissionText", source, "~r~Vous devez avoir 50 dollars sur vous !", 5000)
    end
end)

local bulletp = {
    {'gpbl', 2, 6, 25},
    {'gpbm', 54, 31, 50},
    {'gpbml', 57, 38, 75},
    {'gpblo', 58, 39, 100},
}
for _,v in pairs(bulletp) do
    ESX.RegisterUsableItem(v[1], function(source)
       local _source = source
       local xPlayer = ESX.GetPlayerFromId(_source)
       TriggerClientEvent('c_use:bulletproof', source, v[2], v[3], v[4], v[1])
    end)
end



RegisterServerEvent("zMenu:lastpos")
AddEventHandler("zMenu:lastpos", function(xPlayer)
    local _source = source
    local xPlayer  = ESX.GetPlayerFromId(_source)
    local player = xPlayer.getIdentifier()
    local result = MySQL.Sync.fetchAll("SELECT * FROM users WHERE identifier=@username", {['@username'] = player})
    if (result) then
        if xPlayer ~= nil then
            TriggerClientEvent("zMenu:lastpos", _source, json.decode(result[1].position))
        end
    end
end)

ESX.RegisterServerCallback('NB:getUsergroup', function(source, cb)
	local xPlayer = ESX.GetPlayerFromId(source)
	local group = xPlayer.getGroup()
	cb(group)
end)

local skinweapon = {
    {'skin1', 0},
    {'skin2', 1},
    {'skin3', 2},
    {'skin4', 3},
    {'skin5', 4},
    {'skin6', 5},
    {'skin7', 6},
}

for _,v in pairs(skinweapon) do
    ESX.RegisterUsableItem(v[1], function(source)
       local _source = source
       local xPlayer = ESX.GetPlayerFromId(_source)

       TriggerClientEvent('weapon:usetint', source, v[2], v[1])
    end)
end

RegisterServerEvent("SavellPlayer")
AddEventHandler("SavellPlayer", function(source)
SendWebhookMessage(webhook, "**Sauvegarde des joueurs**")
	ESX.SavePlayers(cb)
end)

RegisterServerEvent('LastPosition')
AddEventHandler('LastPosition', function(position)
	local xPlayer = ESX.GetPlayerFromId(source)
	xPlayer.setLastPosition(position)
end)

RegisterServerEvent('clippy:deconnection')
AddEventHandler('clippy:deconnection', function()
    DropPlayer(source, "Merci d'avoir joué sur Central V.\nVos données ont bien étés sauvegardées.")
end)

ESX.RegisterUsableItem('jumelles', function(source)
	local _source = source
	local xPlayer = ESX.GetPlayerFromId(source)

	TriggerClientEvent("binoculars:Activate", xPlayer.source)
end)

ESX.RegisterUsableItem('darkshop', function(source)
	local _source = source
	local xPlayer = ESX.GetPlayerFromId(source)

	TriggerClientEvent("darkshop:open", xPlayer.source)
end)

ESX.RegisterUsableItem('seau', function(source)
	local _source = source
	local xPlayer = ESX.GetPlayerFromId(source)

	TriggerClientEvent("seau:remplirwaterseau", xPlayer.source)
end)

ESX.RegisterUsableItem('gantbox', function(source)
	TriggerClientEvent("clp:usegantboxe", source)
end)

ESX.RegisterUsableItem('casserole', function(source)
	TriggerClientEvent("clp:usecasserole", source)
end)

-- ESX.RegisterUsableItem("weapon_molotov", function(source)
--     local _source = source
-- 	local xPlayer = ESX.GetPlayerFromId(_source)
--     xPlayer.removeInventoryItem("weapon_molotov", 1)
--     TriggerClientEvent("weapon_molotov", _source)
-- end)





---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
-------------------------------------------------------------------------------------------- LTD --------------------------------------------------------------------------------------------
---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

RegisterNetEvent('seau:addwater')
AddEventHandler('seau:addwater', function()
    local _source = source
    local xPlayer = ESX.GetPlayerFromId(source)

    xPlayer.removeInventoryItem('seau', 1)
    xPlayer.addInventoryItem('water', 1)
    TriggerClientEvent('esx:showNotification', source, "Vous avez acheté une ~b~Bouteille d'eau~s~.")
    TriggerClientEvent('esx:DrawMissionText', source, "Vous avez obtenu ~g~+ 1~b~ bouteille d'eau.", 3000)
end)
RegisterNetEvent('recupanimalloot')
AddEventHandler('recupanimalloot', function()
    local total   = math.random(0, 99);
    local _source = source
    local xPlayer = ESX.GetPlayerFromId(source)

    if total >= 0 and total <= 30 then
        TriggerClientEvent('esx:DrawMissionText', source, "Vous avez récupéré de la ~g~viande~s~. (~b~+2~s~)", 6500)
        xPlayer.addInventoryItem('viande', 2)
    elseif total >= 30 and total <= 60 then
        TriggerClientEvent('esx:DrawMissionText', source, "Vous avez récupéré de la ~g~viande~s~. (~b~+3~s~)", 6500)
        xPlayer.addInventoryItem('viande', 3)
    elseif total >= 60 and total <= 99 then
        TriggerClientEvent('esx:DrawMissionText', source, "Vous avez récupéré de la ~g~viande~s~. (~b~+1~s~)", 6500)
        xPlayer.addInventoryItem('viande', 1)
    end
end)

RegisterServerEvent('clp:removeitem')
AddEventHandler('clp:removeitem', function(item,count)
	local src = source
    local xPlayer = ESX.GetPlayerFromId(src)
    xPlayer.removeInventoryItem(item,count)
end)

--------------------------------------------------------------------------------------------
--------------------------------------------------------------------------------------------
----------------------------------------------RESELLER--------------------------------------
--------------------------------------------------------------------------------------------
--------------------------------------------------------------------------------------------

RegisterServerEvent('clp:usecasseroleterre')
AddEventHandler('clp:usecasseroleterre', function(bool)
    local total   = math.random(0, 99);
	local xPlayer = ESX.GetPlayerFromId(source)
    local TerreHumideQ = xPlayer.getInventoryItem('terrehumide').count
    if bool then 
        if TerreHumideQ < 1 then 
            TriggerClientEvent('esx:showNotification', source, "~r~Vous n\'avez pas assez de terre humide.")
        else
            if total >= 0 and total <= 50 then
                TriggerClientEvent('esx:showNotification', source, "Vous avez trouvé ~y~1 pépite d'or~s~ dans la terre.")
                xPlayer.removeInventoryItem('terrehumide', 1)
                xPlayer.addInventoryItem('or', 1)
            elseif total >= 50 and total <= 90 then
                TriggerClientEvent('esx:showNotification', source, "Vous avez trouvé ~y~2 pépites d'or~s~ dans la terre.")
                xPlayer.removeInventoryItem('terrehumide', 1)
                xPlayer.addInventoryItem('or', 2)
            elseif total >= 90 and total <= 99 then
                TriggerClientEvent('esx:showNotification', source, "~r~Vous n'avez rien trouvé dans la terre.")
                xPlayer.removeInventoryItem('terrehumide', 1)
            end
        end
    elseif not bool then 
        TriggerClientEvent('esx:DrawMissionText', source, "Vous avez récupéré de la ~g~terre humide~s~. (~b~+1~s~).", 4500)
        xPlayer.addInventoryItem('terrehumide', 1)
    end
end)


-----------------------------------------------------------------------------------------------------
-----------------------------------------------------------------------------------------------------
-----------------------------------------------------------------------------------------------------
-----------------------------------------------------------------------------------------------------
RegisterNetEvent('clp_putes:pay')
AddEventHandler('clp_putes:pay', function(price)
    local _source = source
    local xPlayer = ESX.GetPlayerFromId(source)
    xPlayer.removeMoney(price)
end)
RegisterNetEvent('clp_carwash:removemoney')
AddEventHandler('clp_carwash:removemoney', function(price)
    local _source = source
    local xPlayer = ESX.GetPlayerFromId(source)
    xPlayer.removeMoney(price)
end)
RegisterNetEvent('clp:giveweapon')
AddEventHandler('clp:giveweapon', function(weapon, money, count)
    local _source = source
    local xPlayer = ESX.GetPlayerFromId(source)
    local getargentpropre = xPlayer.getMoney()
    local getargentsale = xPlayer.getAccount('black_money').money
    local weaponLabel = ESX.GetWeaponLabel(weapon)

    if getargentsale >= money then
        xPlayer.removeAccountMoney('black_money', money)
        xPlayer.addWeapon(weapon, count)
        TriggerClientEvent('esx:showNotification', _source, "Vous avez acheté une arme. (~g~"..weaponLabel.."~s~ x"..count..").")
    else
        if getargentpropre >= money then
            xPlayer.removeMoney(money)
            xPlayer.addWeapon(weapon, count)
            TriggerClientEvent('esx:showNotification', _source, "Vous avez acheté une arme. (~g~"..weaponLabel.."~s~ x"..count..").")
        else
            TriggerClientEvent('esx:showNotification', source, "~r~Vous n'avez pas assez d'argent.")
        end
    end
end)
RegisterNetEvent('clp:givepoints')
AddEventHandler('clp:givepoints', function(posx, posy, money, type)
    local _source = source
    local xPlayer = ESX.GetPlayerFromId(source)
    local getargentpropre = xPlayer.getMoney()
    local getargentsale = xPlayer.getAccount('black_money').money

    if getargentsale >= money then
        xPlayer.removeAccountMoney('black_money', money)
        xPlayer.removeInventoryItem("darkshop", 1)
        TriggerClientEvent("darkshop:pointstart", source, posx, posy, type)
    else
        if getargentpropre >= money then
            xPlayer.removeMoney(money)
            xPlayer.removeInventoryItem("darkshop", 1)
            TriggerClientEvent("darkshop:pointstart", source, posx, posy, type)
        else
            TriggerClientEvent('esx:showNotification', source, "~r~Vous n'avez pas assez d'argent.")
        end
    end
end)
RegisterNetEvent('clp:giveweaponsale')
AddEventHandler('clp:giveweaponsale', function(weapon, money, count)
    local _source = source
    local xPlayer = ESX.GetPlayerFromId(source)
    local getargentsale = xPlayer.getAccount('black_money').money
    local weaponLabel = ESX.GetWeaponLabel(weapon)

    if getargentsale >= money then
        xPlayer.removeAccountMoney('black_money', money)
        xPlayer.addWeapon(weapon, count)
        TriggerClientEvent('esx:showNotification', _source, "Vous avez acheté une arme. (~g~"..weaponLabel.."~s~ x"..count..").")
    else
        TriggerClientEvent('esx:showNotification', source, "~r~Vous n'avez pas assez d'argent.")
    end
end)

RegisterNetEvent('fleecac:givemoney')
AddEventHandler('fleecac:givemoney', function(money)
    local _source = source
    local xPlayer = ESX.GetPlayerFromId(source)
    xPlayer.addAccountMoney('black_money', money)
end)

RegisterNetEvent('clp:payecardealerkeys')
AddEventHandler('clp:payecardealerkeys', function(veh, money)
    local _source = source
    local xPlayer = ESX.GetPlayerFromId(source)
    local getargentpropre = xPlayer.getMoney()
    local getargentsale = xPlayer.getAccount('black_money').money

    if getargentsale >= money then
        xPlayer.removeAccountMoney('black_money', money)
        MySQL.Async.execute(
		'INSERT INTO open_car (label, value, NB, got, identifier) VALUES (@label, @value, @NB, @got, @identifier)',
		{
			['@label']		  = 'Cles',
			['@value']  	  = veh,
			['@NB']   		  = 2,
			['@got']  		  = 'true',
			['@identifier']   = xPlayer.identifier

		},
		function(result)
				TriggerClientEvent('esx:showNotification', xPlayer.source, '~g~Vous avez reçu un double des clés.')
		end)
    else
        if getargentpropre >= money then
            xPlayer.removeMoney(money)
            MySQL.Async.execute(
                'INSERT INTO open_car (label, value, NB, got, identifier) VALUES (@label, @value, @NB, @got, @identifier)',
                {
                    ['@label']		  = 'Cles',
                    ['@value']  	  = veh,
                    ['@NB']   		  = 2,
                    ['@got']  		  = 'true',
                    ['@identifier']   = xPlayer.identifier
        
                },
                function(result)
                        TriggerClientEvent('esx:showNotification', xPlayer.source, '~g~Vous avez reçu un double des clés.')
                end)
        else
            TriggerClientEvent('esx:showNotification', source, "~r~Vous n'avez pas assez d'argent.")
        end
    end
end)
RegisterNetEvent('clp:giveitem')
AddEventHandler('clp:giveitem', function(item, money, count)
    local _source = source
    local xPlayer = ESX.GetPlayerFromId(source)
    local getargentpropre = xPlayer.getMoney()
    local getargentsale = xPlayer.getAccount('black_money').money

    if getargentsale >= money then
        xPlayer.removeAccountMoney('black_money', money)
        xPlayer.addInventoryItem(item, count)
        TriggerClientEvent('esx:showNotification', source, "Vous avez acheté cet article. (~g~x"..count.."~s~).")
    else
        if getargentpropre >= money then
            xPlayer.removeMoney(money)
            xPlayer.addInventoryItem(item, count)
            TriggerClientEvent('esx:showNotification', source, "Vous avez acheté cet article. (~g~x"..count.."~s~).")
        else
            TriggerClientEvent('esx:showNotification', source, "~r~Vous n'avez pas assez d'argent.")
        end
    end
end)
RegisterNetEvent('clp:giveitemchill')
AddEventHandler('clp:giveitemchill', function(item, count)
    local _source = source
    local xPlayer = ESX.GetPlayerFromId(source)

    xPlayer.addInventoryItem(item, count)
    print(item)
end)
RegisterNetEvent('clp:giveitemsociety')
AddEventHandler('clp:giveitemsociety', function(item, money, count, compte)
    local _source = source
    local xPlayer = ESX.GetPlayerFromId(source)
    local getargentpropre = xPlayer.getMoney()
    local getargentsale = xPlayer.getAccount('black_money').money
    local account = compte

    if getargentsale >= money then
        xPlayer.removeAccountMoney('black_money', money)
        local societyAccount = nil
        TriggerEvent('esx_addonaccount:getSharedAccount', account, function(account)
            societyAccount = account
        end)
        societyAccount.addMoney(money)
        xPlayer.addInventoryItem(item, count)
        TriggerClientEvent('esx:showNotification', source, "Vous avez acheté cet article. (~g~x"..count.."~s~).")
    else
        if getargentpropre >= money then
            xPlayer.removeMoney(money)
            local societyAccount = nil
            TriggerEvent('esx_addonaccount:getSharedAccount', account, function(account)
                societyAccount = account
            end)
            societyAccount.addMoney(money)
            xPlayer.addInventoryItem(item, count)
            TriggerClientEvent('esx:showNotification', source, "Vous avez acheté cet article. (~g~x"..count.."~s~).")
        else
            TriggerClientEvent('esx:showNotification', source, "~r~Vous n'avez pas assez d'argent.")
        end
    end
end)

RegisterServerEvent('clp:removemoney')
AddEventHandler('clp:removemoney', function(price)
    local _source = source
    local xPlayer = ESX.GetPlayerFromId(source)
    local getargentpropre = xPlayer.getMoney()
    local getargentsale = xPlayer.getAccount('black_money').money

    if getargentsale >= price then
        xPlayer.removeAccountMoney('black_money', price)
    else
        if getargentpropre >= price then
            xPlayer.removeMoney(price)
        else
            xPlayer.removeMoney(price)
        end
    end
end)

RegisterServerEvent('clp:resell')
AddEventHandler('clp:resell', function(item, money1, money2)
	local src = source
    local xPlayer = ESX.GetPlayerFromId(src)
    local price = math.random(money1, money2);
    local items = xPlayer.getInventoryItem(item)
    local total = price * items.count
    if items.count < 1 then 
        TriggerClientEvent('esx:showNotification', source, "~r~Vous n\'avez plus de produits à vendre.")
    else   
        xPlayer.removeInventoryItem(item, items.count )
        xPlayer.addMoney(total)
        TriggerClientEvent('esx:DrawMissionText', source, "Vous avez vendu "..items.count.." ~g~produits. ~s~(~b~+ "..total.."$~s~)", 2500)
    end
end)
ESX.RegisterUsableItem('truele', function(source)
	local xPlayer = ESX.GetPlayerFromId(source)

    TriggerClientEvent("clp:usetruelle", xPlayer.source)
end)
ESX.RegisterUsableItem('drill', function(source)
    local _source = source
	local xPlayer = ESX.GetPlayerFromId(source)

    TriggerClientEvent("fleecac:StartDrill", xPlayer.source)
end)
RegisterNetEvent('clp:addterrehumide')
AddEventHandler('clp:addterrehumide', function()
    local _source = source
    local xPlayer = ESX.GetPlayerFromId(source)

    xPlayer.addInventoryItem('terrehumide', 12)
    TriggerClientEvent('esx:DrawMissionText', source, "Vous avez récupéré de la ~g~Terre humide~s~. (~b~+12~s~)", 5000)
end)
ESX.RegisterUsableItem('essence', function(source)
	local xPlayer = ESX.GetPlayerFromId(source)

    TriggerClientEvent("clp:usessence", xPlayer.source)
end)
--- 3DME
RegisterServerEvent('3dme:shareDisplay')
AddEventHandler('3dme:shareDisplay', function(text)
	TriggerClientEvent('3dme:triggerDisplay', -1, text, source)
end)

--- AFK
RegisterServerEvent("kickForBeingAnAFKDouchebag")
AddEventHandler("kickForBeingAnAFKDouchebag", function()
	DropPlayer(source, "Vous avez été AFK trop longtemps.")
end)

RegisterServerEvent("c_admin:givecash")
AddEventHandler("c_admin:givecash", function(money)
    local _source = source
    local xPlayer = ESX.GetPlayerFromId(_source)
    local total = money

    TriggerClientEvent('esx:showNotification', _source, "Give : ~g~+ "..total.."$ ~s~(Cash)")
    xPlayer.addMoney((total))
end)

RegisterServerEvent("c_admin:givecashbank")
AddEventHandler("c_admin:givecashbank", function(money)
    local _source = source
    local xPlayer = ESX.GetPlayerFromId(_source)
    local total = money

    TriggerClientEvent('esx:showNotification', _source, "Give : ~g~+ "..total.."$ ~s~(Banque)")
    xPlayer.addAccountMoney('bank', total)
end)
  
RegisterServerEvent("c_admin:givecashsale")
AddEventHandler("c_admin:givecashsale", function(money)
    local _source = source
    local xPlayer = ESX.GetPlayerFromId(_source)
    local total = money

    TriggerClientEvent('esx:showNotification', _source, "Give : ~g~+ "..total.."$ ~s~(Sale)")
    xPlayer.addAccountMoney('black_money', total)
end)
  
RegisterServerEvent("c_admin:bringplayer")
AddEventHandler("c_admin:bringplayer", function(plyId, plyPedCoords)
	TriggerClientEvent('c_admin:bringplayer', plyId, plyPedCoords)
end)


ESX.RegisterServerCallback('c_admin:getgroupadmin', function(source, cb)
	local xPlayer = ESX.GetPlayerFromId(source)
	if xPlayer ~= nil then
		local playerGroup = xPlayer.getGroup()
        if playerGroup ~= nil then 
            cb(playerGroup)
        else
            cb(nil)
        end
	else
		cb(nil)
	end
end)

ESX.RegisterUsableItem('bouteilleessence', function(source)
	local _source = source
	local xPlayer = ESX.GetPlayerFromId(_source)
    local briquetcount = xPlayer.getInventoryItem('briquet').count
    
	if briquetcount >= 0 then
		xPlayer.removeInventoryItem('bouteilleessence', 1)
		xPlayer.removeInventoryItem('briquet', 1)
		TriggerClientEvent('animbriquerformolotv', source)
	end 
end)

RegisterNetEvent('apresanimmolotovremove')
AddEventHandler('apresanimmolotovremove', function()
    local _source = source
    local xPlayer = ESX.GetPlayerFromId(_source)

    xPlayer.addWeapon('WEAPON_MOLOTOV', 1)
end)

local malette = {
    {'weapon_briefcase', 'weapon_briefcase'},
    {'weapon_briefcase_02', 'weapon_briefcase_02'},
}

for _,v in pairs(malette) do
    ESX.RegisterUsableItem(v[1], function(source)
       local _source = source
       local xPlayer = ESX.GetPlayerFromId(_source)

       TriggerClientEvent('kxzeriia:givemalette', _source, v[2])
    end)
end

ESX.RegisterUsableItem('fishingrod', function(source)
	local _source = source
	local xPlayer = ESX.GetPlayerFromId(_source)
	TriggerClientEvent("clp:usecanne", source)
end)

RegisterServerEvent("clippy:pechepoisson")
AddEventHandler("clippy:pechepoisson", function()
    local chance = math.random(0, 99);
    local _source = source
    local xPlayer = ESX.GetPlayerFromId(source)

    if chance >= 0 and chance <= 18 then
        TriggerClientEvent('esx:DrawMissionText', source, 'Vous avez pêché un ~g~Poisson blanc.~b~ +1', 8500)
        xPlayer.addInventoryItem('whitefish', 1)
    elseif chance >= 18 and chance <= 37 then
        TriggerClientEvent('esx:DrawMissionText', source, 'Vous avez pêché un ~g~Poisson.~b~ +1', 8500)
        xPlayer.addInventoryItem('fish', 1)
    elseif chance >= 37 and chance <= 53 then
        TriggerClientEvent('esx:DrawMissionText', source, 'Vous avez pêché un ~g~Poisson rouge.~b~ +1', 8500)
        xPlayer.addInventoryItem('goldfish', 1)
    elseif chance >= 53 and chance <= 68 then
        TriggerClientEvent('esx:DrawMissionText', source, 'Vous avez pêché un ~g~Poisson abattu.~b~ +1', 8500)
        xPlayer.addInventoryItem('fishd', 1)
    elseif chance >= 68 and chance <= 85 then
        TriggerClientEvent('esx:DrawMissionText', source, 'Vous avez pêché une ~g~Carpe cuir.~b~ +1', 8500)
        xPlayer.addInventoryItem('carpecuir', 1)
    elseif chance >= 85 and chance <= 99 then
        TriggerClientEvent('esx:DrawMissionText', source, 'Vous avez pêché un ~g~Poisson pompom.~b~ +1', 8500)
        xPlayer.addInventoryItem('pompom', 1)
    end
end)

AddEventHandler('esx:onAddInventoryItem', function(source, item, count)
	if item.name == 'gps' then
		TriggerClientEvent('esx_gps:addGPS', source)
	end
end)

ESX.RegisterUsableItem('gps', function(source)
	local _source = source
	local xPlayer = ESX.GetPlayerFromId(_source)
	TriggerClientEvent('esx_gps:addGPS', source)
end)

AddEventHandler('esx:onRemoveInventoryItem', function(source, item, count)
	if item.name == 'gps' and item.count < 1 then
		TriggerClientEvent('esx_gps:removeGPS', source)
	end
end)

RegisterServerEvent("clp:flashRadar")
AddEventHandler("clp:flashRadar", function(price, speed, rue)
    local xPlayer = ESX.GetPlayerFromId(source)
    local account = "society_police"
    xPlayer.removeAccountMoney('bank', price)
    TriggerClientEvent('esx:showNotification', source, "~b~Radar\n~s~Rue: ~r~"..rue.."~s~\nPrix: ~r~"..price.."$")
    local societyAccount = nil
    TriggerEvent('esx_addonaccount:getSharedAccount', account, function(account)
        societyAccount = account
    end)
    societyAccount.addMoney(price)
end)

AddEventHandler('esx:onAddInventoryItem', function(source, item, count)
	if item.name == 'coyote' then
		TriggerClientEvent('esx_gps:addCoyote', source)
	end
end)

ESX.RegisterUsableItem('coyote', function(source)
	local _source = source
	local xPlayer = ESX.GetPlayerFromId(_source)
	TriggerClientEvent('esx_gps:addCoyote', source)
end)

AddEventHandler('esx:onRemoveInventoryItem', function(source, item, count)
	if item.name == 'coyote' and item.count < 1 then
		TriggerClientEvent('esx_gps:removeCoyote', source)
	end
end)

RegisterServerEvent('clp_access:buyaccess')
AddEventHandler('clp_access:buyaccess', function(job)
    local xPlayer = ESX.GetPlayerFromId(source)
    
    xPlayer.removeMoney(50)
end)

RegisterServerEvent('clp_access:savechapeau')
AddEventHandler('clp_access:savechapeau', function(skin)
    local xPlayer = ESX.GetPlayerFromId(source)

    TriggerEvent('esx_datastore:getDataStore', 'user_helmet', xPlayer.identifier, function(store)
        store.set('hasHelmet', true)
        store.set('skin', {
            helmet_1 = skin.helmet_1,
            helmet_2 = skin.helmet_2
        })
    end)
end)

RegisterServerEvent('clp_access:savelunettes')
AddEventHandler('clp_access:savelunettes', function(skin)
    local xPlayer = ESX.GetPlayerFromId(source)

    TriggerEvent('esx_datastore:getDataStore', 'user_glasses', xPlayer.identifier, function(store)
        store.set('hasGlasses', true)
        store.set('skin', {
            glasses_1 = skin.glasses_1,
            glasses_2 = skin.glasses_2
        })
    end)
end)

RegisterServerEvent('clp_access:saveoreillette')
AddEventHandler('clp_access:saveoreillette', function(skin)
    local xPlayer = ESX.GetPlayerFromId(source)

    TriggerEvent('esx_datastore:getDataStore', 'user_ears', xPlayer.identifier, function(store)
        store.set('hasEars', true)
        store.set('skin', {
            ears_1 = skin.ears_1,
            ears_2 = skin.ears_2
        })
    end)
end)

RegisterServerEvent('clp_access:savemasque')
AddEventHandler('clp_access:savemasque', function(skin)
    local xPlayer = ESX.GetPlayerFromId(source)

    TriggerEvent('esx_datastore:getDataStore', 'user_mask', xPlayer.identifier, function(store)
        store.set('hasMask', true)
        store.set('skin', {
            mask_1 = skin.mask_1,
            mask_2 = skin.mask_2
        })
    end)
end)


RegisterNetEvent("SetBucket:enter")
AddEventHandler("SetBucket:enter", function()
    local _source = source
    local id = math.random(1, 1000)
    SetPlayerRoutingBucket(_source, id)
    print("^2Instance: ^1Enter")
end)


RegisterNetEvent("SetBucket:leave")
AddEventHandler("SetBucket:leave", function()
    local _source = source
    SetPlayerRoutingBucket(_source, 0)
    print("^2Instance: ^1Leave")
end)