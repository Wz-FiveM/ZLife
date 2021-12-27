RegisterControlKey("infoHUD","Ouvrir le menu des infos","F10",function()
	openinfostreet(true)
end,
function()
	openinfostreet(false)
end)

function openinfostreet(bool)
    XmVolesU = bool
    while XmVolesU do 
		Wait(0)
		players = {}
        
        for _,player in ipairs(GetActivePlayers()) do
            table.insert(players, player)
        end
			DrawNiceText(0.9,0.975,0.4,"",4,2,0.1)
			local pPos=GetEntityCoords(GetPlayerPed(-1));
			local JtAjijkG,s=GetStreetNameAtCoord(pPos.x,pPos.y,pPos.z,0,0)
			local YAtG_LV3=GetStreetNameFromHashKey(JtAjijkG)
			local e = LocalPlayer()
			local YAtG_LV2= GetLabelText(e.ZoneName)
			DrawNiceText(0.00099,0.50,0.42," "..YAtG_LV3,6)
			DrawNiceText(0.00099,0.53,0.42," "..YAtG_LV2,6)
			if IsPedInAnyVehicle(GetPlayerPed(-1), false) then 
				local JD,u=.9375,.4
				DrawRect(.032,u+.098,.150,.2,0,0,0,100)
				DrawNiceText(.005,.41,0.42,"État du moteur : ",6)
                DrawNiceText(.072,.41,0.42,"~b~"..GetVehicleHealth(GetVehiclePedIsIn(GetPlayerPed(-1), false)).."%",6,true)
                DrawNiceText(.005,.43,0.42,"État carrosserie : ",6)
				DrawNiceText(.072,.43,0.42,"~b~"..GetVehicleCaro(GetVehiclePedIsIn(GetPlayerPed(-1), false)).."%",6,true)
				DrawNiceText(.005,.45,0.42,"Réservoir : ",6)
				DrawNiceText(.072,.45,0.42,"~b~"..math.floor(GetVehicleFuelLevel(GetVehiclePedIsIn(GetPlayerPed(-1), false))).." L",6,true)
				DrawNiceText(.005,.47,0.42,"Modèle : ",6)
				DrawNiceText(.072,.47,0.42,"~b~"..GetLabelText(GetDisplayNameFromVehicleModel(GetEntityModel(GetVehiclePedIsIn(GetPlayerPed(-1), false)))),6,true)
			end
    end
end