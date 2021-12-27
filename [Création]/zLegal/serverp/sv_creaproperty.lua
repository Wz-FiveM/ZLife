ESX = nil

TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

RegisterServerEvent('clp:creaproperty')
AddEventHandler('clp:creaproperty', function(name, label, entering, exit, inside, outside, ipl, isSingle, isRoom, isGateway, roommenu, garage, price)
    local x_source = source
    MySQL.Async.fetchAll("SELECT name FROM properties WHERE name = @name", {

   	   ['@name'] = name,

    }, 
    function(result)
        if result[1] ~= nil then 
			local id = math.random(500, 1000000000)
       	   TriggerClientEvent('esx:showNotification', id, '~r~Ce nom éxiste déja.')
       	else 
       	   Insert(id, name, label, entering, exit, inside, outside, ipl, isSingle, isRoom, isGateway, roommenu, garage, price)   
        end 
    end)
end)

function Insert(id, name, label, entering, exit, inside, outside, ipl, isSingle, isRoom, isGateway, roommenu, garage, price)
    MySQL.Async.execute('INSERT INTO properties (name, label ,entering ,`exit`,inside,outside,ipls,is_single,is_room,is_gateway,room_menu,garage,price) VALUES (@name,@label,@entering,@exit,@inside,@outside,@ipls,@isSingle,@isRoom,@isGateway,@roommenu,@garage,@price)',
		{
			['@name'] = name,
			['@label'] = label,
			['@entering'] = entering,
			['@exit'] = exit,
			['@inside'] = inside,
			['@outside'] = outside,
			['@ipls'] = ipl,
			['@isSingle'] = isSingle,
			['@isRoom'] = isRoom,
			['@isGateway'] = isGateway,
			['@roommenu'] = roommenu,
			['@garage'] = garage,
			['@price'] = price,

		}, 
		function (rowsChanged)
			TriggerClientEvent('esx:showNotification', id, "~g~Vous venez d'enregistrer une propriété sous le nom de ~b~"..name.."~g~ au prix de ~b~"..price.."$~g~.")
		end
	)
end
