ESX = nil
TriggerEvent('esx:getSharedObject', function(obj) 
	ESX = obj 
end)
local eatitem = {
	{'cigarette', 'eatItem', 'Cigarette', 'hunger', 0},
	{'cigar', 'eatItem', 'Cigarette', 'hunger', 0},
	-- eatItem
	{'hamburger', 'eatItem', 'Hamburger', 'hunger', 400000}, -- Meilleur
		-- LTD
	{'donut', 'eatItem', 'Donut', 'hunger', 250000},
	{'chocolat', 'eatItem', 'Chocolat', 'hunger', 250000},
	{'frites', 'eatItem', 'Frites', 'hunger', 250000},
	{'hotdog', 'eatItem', 'Hot-dog', 'hunger', 250000},
		-- Farm
	{'viande', 'eatItem', 'Viande crue', 'hunger', 250000},
	{'whitefish', 'eatItem', "Ombre de l'arctique", 'hunger', 250000},
	{'fish', 'eatItem', 'Truite de lac', 'hunger', 250000},
	{'goldfish', 'eatItem', 'Saumon frais', 'hunger', 250000},
	{'carpecuir', 'eatItem', 'Truite arc-en-ciel', 'hunger', 250000},
	{'pompom', 'eatItem', 'Truite bull', 'hunger', 250000},
		-- Divers
	{'kebab', 'eatItem', 'Kebab', 'hunger', 250000},
	{'fricadelle', 'eatItem', 'Fricadelle', 'hunger', 250000},
	{'tapas', 'eatItem', 'Tapas', 'hunger', 250000},
	{'chinook', 'eatItem', 'Chinook', 'hunger', 250000},
	{'tender', 'eatItem', 'Tender', 'hunger', 250000},
	-- drinkItem
	{'jusfruit', 'drinkItem', 'Jus de Leechi', 'thirst', 400000}, -- Meilleur
		-- Soirée
	{'magnum', 'eatItem', 'Magnum', 'thirst', 250000},
	{'triplebiere', 'drinkItem', 'Triple bière', 'thirst', 250000},
	{'jupiler', 'drinkItem', 'Jupiler', 'thirst', 250000},
	{'tequila', 'drinkItem', 'Tequila', 'thirst', 250000},
	{'whisky', 'drinkItem', 'Whisky', 'thirst', 250000},
	{'vin', 'drinkItem', 'Vin', 'thirst', 250000},
	{'mojito', 'drinkItem', 'Tequila', 'thirst', 250000},
	{'rhum', 'drinkItem', 'Vin', 'thirst', 250000},
	{'vodka', 'drinkItem', 'Bière sans alcool', 'thirst', 250000},
	{'biere', 'drinkItem', 'Bière', 'thirst', 250000},
	{'cocktail', 'drinkItem', 'Cocktail', 'thirst', 250000},
	{'champagne', 'drinkItem', 'Champagne', 'thirst', 250000},
		-- LTD
	{'cafe', 'drinkItem', 'Café', 'thirst', 250000},
	{'water', 'drinkItem', 'Eau de source', 'thirst', 250000},
	{'soda', 'drinkItem', 'Soda', 'thirst', 250000},
	{'tea', 'drinkItem', 'Thé vert', 'thirst', 250000},
	{'jusraisin', 'drinkItem', 'Jus de Leechi', 'thirst', 250000},
}
for _,v in pairs(eatitem) do
    ESX.RegisterUsableItem(v[1], function(source)
       local _source = source
       local xPlayer = ESX.GetPlayerFromId(_source)

       TriggerClientEvent('clp_nour:gry', source, v[2], v[3], v[4], v[5])
       xPlayer.removeInventoryItem(v[1], 1)
    end)
end
TriggerEvent('es:addGroupCommand', 'heal', 'admin', function(source, args, user)
	if args[1] then
		local target = tonumber(args[1])
		if target ~= nil then
			
			if GetPlayerName(target) then
				TriggerClientEvent('esx_basicneeds:healPlayer', target)
			end
		end
	else
		TriggerClientEvent('esx_basicneeds:healPlayer', source)
	end
end, function(source, args, user)
end, {help = "Heal someone."})