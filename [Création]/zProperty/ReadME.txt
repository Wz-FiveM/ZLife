Si tu souhaite ajouter les positions du garges 95 places, elle sont dans le ListPosGarages.txt (dernier)
Ajoute bien le sql.
Commande pour créer un propriété en étant agant immo: "creator" (Configurable)
Commande pour voir la liste des clients en étant agant immo: "clients" (Configurable)
Bien ajouter en bas du config le poids de vos items, et els images dans html/img/items

Anti save position: 
es_estended/server/functions.lua -- > Add:

ServerSavePlayers = {}
RegisterServerEvent("cProperty:CanSave")
AddEventHandler("cProperty:CanSave", function(bool, identifier)
	ServerSavePlayers[identifier] = bool
end)

ESX.SavePlayer = function() -- https://i.imgur.com/zPQzbGM.png / -- https://i.imgur.com/Vmib12v.png

And 

es_estended/server/main.lua -- > Add: -- https://i.imgur.com/RGQkZTe.png
