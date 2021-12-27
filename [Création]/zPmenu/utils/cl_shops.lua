local vms5 = {{
    name = "Classique (10$)",
	price = 10,
	item = "skin1"
}, {
    name = "Vert (200$)",
	price = 200,
	item = "skin2"
}, {
    name = "Jaune (1500$)",
    price = 1500,
	item = "skin3"
}, {
    name = "Rose (1250$)",
    price = 1250,
	item = "skin4"
}, {
    name = "Or (2500$)",
    price = 2500,
	item = "skin5"
}, {
    name = "Bleu (500$)",
    price = 500,
	item = "skin6"
}, {
    name = "Orange (400$)",
    price = 400,
	item = "skin7"
}}
local function OnSelected(self, mMenu,Select, _, button, slt)
	local MenuSelect = mMenu.currentMenu
	local btn = button.name
	local m = MenuSelect
	if m == "Reseller" then 
		if not Select.item then 
			return 
		end
		TriggerEvent("randPickupAnim")
		TriggerServerEvent('clp:resell', Select.item, Select.money1, Select.money2)
	elseif m == "Activités publiques"then 
		if not Select.message then 
			return 
		end
		TriggerEvent("randPickupAnim")
		ShowAboveRadarMessage("~b~Description :\n~w~".. Select.message)
	elseif Select.name == "Ranger le véhicule" then 
		local vehicle = GetClosestVehicle(GetEntityCoords(GetPlayerPed(-1)), 5.0, 0, 71)
		local plate = GetVehicleNumberPlateText(vehicle)
		if GetEntityModel(vehicle) == 2132890591 or GetEntityModel(vehicle) == 1917016601 then
			TriggerEvent('persistent-vehicles/forget-vehicle', vehicle)
			Wait(50)
			SetEntityAsMissionEntity(vehicle)
			DeleteEntity(vehicle)
			TriggerServerEvent('esx_vehiclelock:deletekeyjobs', 'no', plate)
		end
	elseif m == "armes de poing" or m == "handguns" or m == "submachine guns" or m == "shotguns" or m == "assault rifles" or m == "armes diverses" or m == "armes blanches" then 
		if not Select.weapon then 
			return 
		end;
		if Select.xps then 
			local d = exports.zClothes:ESXP_GetXP()
			if d >= Select.xp then 
				TriggerServerEvent('clp:giveitem', Select.weapon, Select.money, Select.count)
			else
				ShowAboveRadarMessage("~r~Vous devez être "..Select.xpno.."~r~ pour acheter cette arme.")
			end
		else
			TriggerServerEvent('clp:giveitem', Select.weapon, Select.money, Select.count)
		end
	elseif m == "armes de mêlée" then 
		if not Select.weapon then 
			return 
		end
		TriggerEvent("randPickupAnim")
		TriggerServerEvent('clp:giveitem', Select.weapon, Select.money, Select.count)
	elseif m == "munitions" or m == "accessoires" or m == "boissons" or m == "divers" or m == "nourritures" or m == "multimédia" or m == "Jazzy" or m == "vêtements" or m == "Objets disponibles" or m == "kevlar" then 
		if not Select.item then 
			return 
		end
		TriggerEvent("randPickupAnim")
		TriggerServerEvent('clp:giveitem', Select.item, Select.money, Select.count)
	elseif m == "Serrurier" then 
		if not Select.veh then 
			return 
		end;
		if not IsPedInAnyVehicle(GetPlayerPed(-1), false) then return ShowAboveRadarMessage("~r~Vous devez être dans un véhicule.") end
		local plate = GetVehicleNumberPlateText(GetVehiclePedIsIn(GetPlayerPed(-1), false))
		if plate ~= nil then 
			TriggerServerEvent('clp:payecardealerkeys', plate, Select.money)
		else 
			print(plate)
		end
	elseif m == "Hopital" or m == "Ls Customs" then 
		if not Select.item then 
			return 
		end
		TriggerEvent("randPickupAnim")
		TriggerServerEvent('clp:giveitemsociety', Select.item, Select.money, Select.count, Select.compte)
	elseif m == "Truc disponibles" then 
		if not Select.posx then 
			return 
		end
		TriggerEvent("randPickupAnim")
		TriggerServerEvent('clp:givepoints', Select.posx, Select.posy, Select.money, Select.type)
	elseif Select.name == "Camouflage" then 
		TriggerServerEvent('clp:giveitem', vms5[Select.slidenum].item, vms5[Select.slidenum].price, 1)
	elseif Select.name == "Appeler les internes" then 
		CloseMenu(true)
		TriggerEvent("esx_basicneeds:resetStatus")
		TriggerServerEvent('clp_death:removeweapon')
		TriggerEvent('esx_ambulancejob:revive')
	elseif m == "armes diverse" then 
		TriggerEvent("randPickupAnim")
		TriggerServerEvent('clp:giveitem', Select.weapon, Select.money, Select.count)
	elseif m == "Casse" then 
		if IsAnyVehicleNearPoint(Select.pos.x,Select.pos.y,Select.pos.z, 5.0) then return end
		local masS = math.random(123456,865417)
		local veh=createPersoVeh(Select.model, {}, masS,1, Select.pos)
		--SetEntityHeading(veh, Select.pos.a)
		local plate = GetVehicleNumberPlateText(veh)
		TriggerServerEvent('esx_vehiclelock:givekey', 'no', plate) 
	elseif m == "Achat" then
		TriggerServerEvent("achat:velo") 
	end 
end

function v3(W_63_9, h9dyA_4T)
    local oh
    for DZXGTh, Su9Koz in pairs(W_63_9 or {}) do
        if not oh or GetDistanceBetweenCoords(Su9Koz.x, Su9Koz.y, Su9Koz.z, h9dyA_4T) <
            GetDistanceBetweenCoords(oh.x, oh.y, oh.z, h9dyA_4T) then
            oh = Su9Koz
        end
    end
    return oh
end

local Cam 
local function rA5U(JQi1jg, wVzn, pE, RSjapQ)
	if wVzn.name == "Camouflage" then
		local playerPed = GetPlayerPed(-1)
		if IsPedArmed(playerPed, 5) then 
			SetPedWeaponTintIndex(playerPed, GetSelectedPedWeapon(playerPed), wVzn.slidenum - 1)
		else
			ShowAboveRadarMessage("~r~Veuillez équiper une arme.")
		end
    end
end
local function ExitWeapons(JQi1jg, wVzn, pE, RSjapQ)
	local playerPed = GetPlayerPed(-1)
	SetPedWeaponTintIndex(playerPed, GetSelectedPedWeapon(playerPed), 0)
	DestroyCam(Cam)
	RenderScriptCams(false, true, 1000, false, false)
end
local function createcam()
	local XmVolesU=GetEntityCoords(GetPlayerPed(-1))
    DrawMarker(0,XmVolesU+vector3(.0,.0,1.0),vector3(.0,.0,.0),vector3(0.0,0.0,0.0),.3,.3,0.15,255,0,0,100,false,true,true,false,false,false,false)
end

local Ltdshop = {
	Base = { Header = {"shopui_title_gasstation", "shopui_title_gasstation"},HeaderColor = {255,255,255}},
	Data = { currentMenu = "Catégories"},
	Events = { onSelected = OnSelected },
	Menu = {
		["Catégories"] = {
			b = {
				{name = "Boissons",ask = ">", askX = true},
				{name = "Nourritures",ask = ">", askX = true},
				{name = "Divers",ask = ">", askX = true},
				{name = "Multimédia",ask = ">", askX = true}
			}
		},
		["divers"] = {
			b = {
				{name = "Cigarette",item = "cigarette", money = 10, count = 1, ask = "~g~10$", askX = true},
				{name = "Cigar",item = "cigar", money = 13, count = 1, ask = "~g~13$", askX = true}
			}
		},
		["boissons"] = {
			b = {
				{name = "Eau",item = "water", money = 1, count = 1, ask = "~g~1$", askX = true},
				{name = "Soda",item = "soda", money = 2, count = 1, ask = "~g~2$", askX = true},
				{name = "Café",item = "cafe", money = 3, count = 1, ask = "~g~3$", askX = true},
				{name = "Thé vert",item = "tea", money = 3, count = 1, ask = "~g~3$", askX = true},
				{name = "Jus de raisin",item = "jusraisin", money = 4, count = 1, ask = "~g~4$", askX = true}
			}
		},
		["nourritures"] = {
			b = {
                {name = "Chocolat",item = "chocolat", money = 2, count = 1, ask = "~g~2$", askX = true},
                {name = "Frites",item = "frites", money = 2, count = 1, ask = "~g~2$", askX = true},
				{name = "Donut",item = "donut", money = 2, count = 1, ask = "~g~2$", askX = true},
				{name = "Hot-dog",item = "hotdog", money = 3, count = 1, ask = "~g~3$", askX = true},
				{name = "Hamburger",item = "hamburger", money = 4, count = 1, ask = "~g~4$", askX = true}
			}
		},
		["multimédia"] = {
			b = {
				{name = "Téléphone",item = "phone", money = 350, count = 1, ask = "~g~350$", askX = true},
				{name = "Carte sim",item = "sim", money = 50, count = 1, ask = "~g~50$", askX = true},
				{name = "Carte bancaire",item = "cartebleu", money = 50, count = 1, ask = "~g~50$", askX = true},
				{name = "GPS",item = "gps", money = 150, count = 1,ask = "~g~150$", askX = true}
			}
		}
	}
}
local Ltdshop1 = {
	Base = { Header = {"shopui_title_gasstation", "shopui_title_gasstation"},HeaderColor = {255,255,255}},
	Data = { currentMenu = "Catégories"},
	Events = { onSelected = OnSelected },
	Menu = {
		["Catégories"] = {
			b = {
				{name = "Boissons",ask = ">", askX = true},
				{name = "Nourritures",ask = ">", askX = true},
				{name = "Multimédia",ask = ">", askX = true}
			}
		},
		["boissons"] = {
			b = {
				{name = "Eau",item = "water", money = 3, count = 1, ask = "~g~3$", askX = true},
			}
		},
		["nourritures"] = {
			b = {
				{name = "Donut",item = "donut", money = 5, count = 1, ask = "~g~5$", askX = true},
			}
		},
		["multimédia"] = {
			b = {
				{name = "Téléphone",item = "phone", money = 450, count = 1, ask = "~g~450$", askX = true},
				{name = "Carte bancaire",item = "cartebleu", money = 100, count = 1, ask = "~g~100$", askX = true},
				{name = "GPS",item = "gps", money = 175, count = 1,ask = "~g~175$", askX = true}
			}
		}
	}
}
local ammuls = {
	Base = { Header = {"shopui_title_gunclub", "shopui_title_gunclub"}, HeaderColor = {255,255,255}},
	Data = { currentMenu = "Catégories"},
	Events = { 
		onSelected = OnSelected,
		onSlide = rA5U,
		onRender = createcam,
		onExited = ExitWeapons
	},
	Menu = {
		["Catégories"] = {
			b = {
				--{name = "Armes de mêlée",ask = ">", askX = true},
				--{name = "Armes diverse",ask = ">", askX = true},
				{name = "Accessoires",ask = ">", askX = true},
				{name = "Munitions",ask = ">", askX = true},
				{name = "Vêtements",ask = ">", askX = true},
				{name = "Camouflage",slidemax = vms5, askX = true},
			}
		},
		["armes de mêlée"] = {
			b = {
				{name = "Lampe torche",weapon = "weapon_flashlight", money = 50, count = 1, ask = "~g~50$", askX = true},
				{name = "Clé à molette",weapon = "weapon_wrench", money = 100, count = 1, ask = "~g~100$", askX = true},
				{name = "Cran d'arrêt",weapon = "weapon_switchblade", money = 250, count = 1, ask = "~g~250$", askX = true},
				{name = "Marteau",weapon = "weapon_hammer", money = 275, count = 1, ask = "~g~275$", askX = true},
				{name = "Queue de billard",weapon = "weapon_poolcue", money = 300, count = 1, ask = "~g~300$", askX = true},
				{name = "Poing américain",weapon = "weapon_knuckle", money = 425, count = 1, ask = "~g~425$", askX = true},
				{name = "Batte de baseball",weapon = "weapon_bat", money = 450, count = 1, ask = "~g~450$", askX = true},
				{name = "Pied de biche",weapon = "weapon_crowbar", money = 475, count = 1, ask = "~g~475$", askX = true}
			}
		},
		["armes diverse"] = {
			b = {
				{name = "Brique",weapon = "weapon_ball", money = 1, count = 1, ask = "~g~1$", askX = true},
				{name = "Pistolet de détresse",weapon = "weapon_flaregun", money = 1650, count = 1, ask = "~g~1650$", askX = true}
			}
		},
		["accessoires"] = {
			b = {
				{name = "Poignée",item = "grip", money = 250, count = 1, ask = "~g~250$", askX = true},
				{name = "Silencieux",item = "silencieux", money = 300, count = 1, ask = "~g~300$", askX = true},
				{name = "Lampe",item = "flashlight", money = 75, count = 1,ask = "~g~75$", askX = true},
			}
		},
		["vêtements"] = {
			b = {
				{name = "Chimique noire",item = "hazmat1", money = 500, count = 1, ask = "~g~500$", askX = true},
				{name = "Chimique blanche",item = "hazmat4", money = 500, count = 1,ask = "~g~500$", askX = true},
				{name = "Chimique bleu",item = "hazmat2", money = 500, count = 1,ask = "~g~500$", askX = true},
				{name = "Chimique jaune",item = "hazmat3", money = 500, count = 1,ask = "~g~500$", askX = true},
			}
		},
		["munitions"] = {
			b = {
				{name = "9mm (x7)",item = "disc_ammo_pistol", money = 10, count = 7, ask = "~g~10$", askX = true},
				{name = "19mm (x7)",item = "disc_ammo_smg", money = 10, count = 7, ask = "~g~10$", askX = true},
				{name = "Calibre 12 (x7)",item = "disc_ammo_shotgun", money = 10, count = 7, ask = "~g~10$", askX = true},
				{name = "5.56mm (x7)",item = "disc_ammo_rifle", money = 10, count = 7, ask = "~g~10$", askX = true},
			}
		}
	}
}
local menuidentite = {
	Base = { Header = {"commonmenu", "interaction_bgd"}, Title = "Jazzy"},
	Data = { currentMenu = "Jazzy"},
	Events = { onSelected = OnSelected },
	Menu = {
		["Jazzy"] = {
			b = {
				{name = "Obtenir sa carte d'identité",item = "carteidentite", money = 2, count = 1, ask = "~g~2$", askX = true},
				{name = "Obtenir sa carte de conduite",item = "permis", money = 50, count = 1, ask = "~g~50$", askX = true},
			}
		}
	}
}
local givecarkeyille = {
	Base = { Header = {"commonmenu", "interaction_bgd"}, Color = {color_black}, HeaderColor = {0, 80, 0}, Title = "Serrurier"},
	Data = { currentMenu = "Serrurier"},
	Events = { onSelected = OnSelected },
	Menu = {
		["Serrurier"] = {
			b = {
				{name = "Obtenir les clés de ce véhicule",veh = GetVehiclePedIsIn(GetPlayerPed(-1), false), money = 1250, ask = "~g~1250$", askX = true}
			}
		}
	}
}
local resellerfish = {
	Base = { Header = {"commonmenu", "interaction_bgd"}, Color = {color_black},  HeaderColor = {120, 230, 50},Title = "Reseller"},
	Data = { currentMenu = "Reseller"},
	Events = { onSelected = OnSelected },
	Menu = {
		["Reseller"] = {
			b = {
				{name = "Poisson abattu",item = "fishd", money1 = 20, money2 = 30,ask = ">", askX = true},
				{name = "Poisson",item = "fish", money1 = 30, money2 = 40,ask = ">", askX = true},
				{name = "Poisson rouge",item = "goldfish", money1 = 40, money2 = 50,ask = ">", askX = true},
				{name = "Poisson blanc",item = "whitefish", money1 = 50, money2 = 60,ask = ">", askX = true},
				{name = "Poisson pompom",item = "pompom", money1 = 60, money2 = 70,ask = ">", askX = true},
				{name = "Carpe cuir",item = "carpecuir", money1 = 70, money2 = 80,ask = ">", askX = true},
			}
		}
	}
}
local resellerviande = {
	Base = { Header = {"commonmenu", "interaction_bgd"}, Color = {color_black},  HeaderColor = {120, 230, 50},Title = "Reseller"},
	Data = { currentMenu = "Reseller"},
	Events = { onSelected = OnSelected },
	Menu = {
		["Reseller"] = {
			b = {
				{name = "Viande",item = "viande", money1 = 100, money2 = 250, ask = ">", askX = true}
			}
		}
	}
}
local reselleror = {
	Base = { Header = {"commonmenu", "interaction_bgd"}, Color = {color_black},  HeaderColor = {120, 250, 165},Title = "Reseller"},
	Data = { currentMenu = "Reseller"},
	Events = { onSelected = OnSelected },
	Menu = {
		["Reseller"] = {
			b = {
				{name = "Pépites d'or",item = "or", money1 = 8, money2 = 20, ask = ">", askX = true}
			}
		}
	}
}
local reselljjobs = {
	Base = { Header = {"commonmenu", "interaction_bgd"}, Color = {color_black},  HeaderColor = {120, 250, 165},Title = "Reseller Jobs"},
	Data = { currentMenu = "Reseller"},
	Events = { onSelected = OnSelected },
	Menu = {
		["Reseller"] = {
			b = {
				{name = "Sac poubelles",item = "sacpoubelle", money1 = 25, money2 = 35, ask = ">", askX = true},
				{name = "Feuilles",item = "feuilles", money1 = 25, money2 = 35, ask = ">", askX = true}
			}
		}
	}
}
local pawnshop = {
	Base = { Header = {"commonmenu", "interaction_bgd"},  Color = {color_black}, HeaderColor = {235, 254, 0}, Title = "PawnShop"},
	Data = { currentMenu = "Objets disponibles"},
	Events = { onSelected = OnSelected },
	Menu = {
		["Objets disponibles"] = {
			b = {
				{name = "Bidon d'essence",item = "essence", money = 55, count = 1,Description = "Permet de remplir l'essence d'un véhicule.",ask = "~g~55$", askX = true},
				{name = "Bouteille d'eau vide",item = "seau", money = 1, count = 1,Description = "Permet de remplir des bouteilles d'eau au bord de l'eau.",ask = "~g~1$", askX = true},
				{name = "Bouteille de plongée",item = "mask_swim", money = 150, count = 1,Description = "Permet d'avoir plus d'oxygène dans l'eau.",ask = "~g~150$", askX = true},
				{name = "Campement",item = "kitpic", money = 250, count = 1,Description = "Acheter un campement pour dormir (Tente + Tapis + Feu).",ask = "~g~250$", askX = true},
				{name = "Canne à pêche",item = "fishingrod", money = 50, count = 1,Description = "Permet de faire de la pêche.",ask = "~g~50$", askX = true},
				{name = "Casserole",item = "casserole", money = 50, count = 1,Description = "Acheter une casserole.",ask = "~g~50$", askX = true},
				{name = "Ciseaux",item = "ciseau", money = 50, count = 1,Description = "Permet couper les cheveux à quelqu'un.",ask = "~g~50$", askX = true},
				{name = "Gants de boxe",item = "gantbox", money = 50, count = 1,Description = "Gang de boxe.",ask = "~g~50$", askX = true},
				{name = "Jumelles",item = "jumelles", money = 250, count = 1,Description = "Permet d'observer beaucoup de chose.",ask = "~g~250$", askX = true},
				{name = "Malette",item = "weapon_briefcase", money = 100, count = 1,Description = "Acheter une malette en plastique.",ask = "~g~100$", askX = true},
				{name = "Malette en cuir",item = "weapon_briefcase_02", money = 100, count = 1,Description = "Acheter une malette en cuir.",ask = "~g~100$", askX = true},
				{name = "Radio",item = "radio", money = 150, count = 1,Description = "Permet de parler en radio (Oreillette).",ask = "~g~150$", askX = true},
				{name = "Sac tactique",item = "sactactique", money = 75, count = 1,Description = "Acheter un sac tactique.",ask = "~g~75$", askX = true},
				--{name = "Truelle",item = "truele", money = 75, count = 1,Description = "Permet de récolter de la terre humide.",ask = "~g~75$", askX = true},
			}
		}
	}
}
local Menumetiers = {
	Base = {Header = {"commonmenu", "interaction_bgd"}, Title = "Activités publiques", HeaderColor = {20, 160, 0}},
	Data = {currentMenu="Activités publiques"}, 
	Events = { onSelected = OnSelected },
	Menu = {
		["Activités publiques"] = {
			b = {
				{name="McGill",message="Rendez-vous vers le LTD de LS au McGill pour commencer à travailler en tant qu'ouvrier et livrer des planches de bois."},
				{name="Pêche",message="Rendez-vous au PawnShop pour acheter une cânne à pêche et ensuite allez au sud de Alamo Sea dans la zone de pêche pour commencer à travailler en tant que pêcheur et revendre ses poissons au reseller."},
				{name="Éboueur",message="Faites /eboueur, allez ensuite chercher votre camion à la casse et faites ensuite vos trajets notés sur la carte."},
				{name="Jardinier",message="Faites /jardinier, allez ensuite chercher votre camion à la casse et faites ensuite vos trajets notés sur la carte."},
				{name="Pépites d'or",message="Rendez-vous au PawnShop pour acheter une casserole et allez ensuite utiliser celle-ci dans l'eau (n'importe quelle eau) pour récupérer votre terre et ensuite traiter la (avec la casserole) sur le sol."},
			}
		}
	}
}
local armesillegalshop = {
	Base = { Header = {"commonmenu", "interaction_bgd"}, Color = {color_black}, HeaderColor = {50, 120, 160}, Title = "Armurie Illegal"},
	Data = { currentMenu = "Catégories"},
	Events = { onSelected = OnSelected },
	Menu = {
		["Catégories"] = {
			b = {
				{name = "Handguns",ask = ">", askX = true},
				{name = "Submachine Guns",ask = ">", askX = true},
				{name = "Shotguns",ask = ">", askX = true},
				{name = "Assault Rifles",ask = ">", askX = true},
				{name = "Armes diverses",ask = ">", askX = true},
				{name = "Armes blanches",ask = ">", askX = true},
				{name = "Kevlar",ask = ">", askX = true},
				{name = "Munitions",ask = ">", askX = true}
			}
		},
		["handguns"] = {
			b = {
				{name = "Pétoire",weapon = "weapon_snspistol", money = 6500, count = 1, ask = "~r~6500$ ~s~(8000$)", askX = true, xps = true, xp = 2100, xpno = "une ~b~Racaille",},
				{name = "Beretta 92",weapon = "weapon_pistol", money = 15000, count = 1, ask = "~r~15000$ ~s~(17000$)", askX = true, xps = true, xp = 2100, xpno = "une ~b~Racaille",},
				{name = "Glock 17",weapon = "weapon_combatpistol", money = 25000, count = 1, ask = "~r~25000$ ~s~(30000$)", askX = true, xps = true, xp = 2100, xpno = "une ~b~Racaille",},
				{name = "Colt-911",weapon = "weapon_heavypistol", money = 25000, count = 1, ask = "~r~25000$ ~s~(30000$)", askX = true, xps = true, xp = 2100, xpno = "une ~b~Racaille",},
				{name = "Desert Eagle",weapon = "weapon_pistol50", money = 30000, count = 1, ask = "~r~30000$ ~s~(35000$)", askX = true, xps = true, xp = 2100, xpno = "une ~b~Racaille",}
			}
		},
		["submachine guns"] = {
			b = {
				{name = "Tec-9",weapon = "weapon_machinepistol", money = 40000, count = 1, ask = "~r~40000$ ~s~(45000$)", askX = true, xps = true, xp = 2100, xpno = "une ~b~Racaille",},
				{name = "Scorpion VZ61",weapon = "weapon_minismg", money = 45000, count = 1, ask = "~r~45000$ ~s~(50000$)", askX = true, xps = true, xp = 2100, xpno = "une ~b~Racaille",}
			}
		},
		["shotguns"] = {
			b = {
				{name = "ST87 Saw",weapon = "weapon_sawnoffshotgun", money = 45000, count = 1, ask = "~r~45000$ ~s~(50000$)", askX = true, xps = true, xp = 24000, xpno = "un ~b~Escroc",},
				{name = "Remingnton",weapon = "weapon_pumpshotgun", money = 125000, count = 1, ask = "~r~125000$ ~s~(150000$)", askX = true, xps = true, xp = 24000, xpno = "un ~b~Escroc",},
				{name = "Fusil à pompe lourd",weapon = "weapon_heavyshotgun", money = 165000, count = 1, ask = "~r~165000$ ~s~(170000$)", askX = true, xps = true, xp = 24000, xpno = "un ~b~Escroc",}
			}
		},
		["assault rifles"] = {
			b = {
				{name = "AK-U",weapon = "weapon_compactrifle", money = 75000, count = 1, ask = "~r~75000$ ~s~(80000$)", askX = true, xps = true, xp = 24000, xpno = "un ~b~Escroc",},
				{name = "AK-47",weapon = "weapon_assaultrifle", money = 170000, count = 1, ask = "~r~170000$ ~s~(180000$)", askX = true, xps = true, xp = 84700, xpno = "un ~b~Soldat",},
				{name = "Balayeuse gusenberg",weapon = "weapon_gusenberg", money = 170000, count = 1, ask = "~r~170000$ ~s~(180000$)", askX = true, xps = true, xp = 84700, xpno = "un ~b~Soldat",},
				{name = "UMP 45",weapon = "weapon_combatpdw", money = 125000, count = 1, ask = "~r~125000$ ~s~(130000$)", askX = true, xps = true, xp = 84700, xpno = "un ~b~Soldat",}
			}
		},
		["armes diverses"] = {
			b = {
				{name = "Parachute",weapon = "gadget_parachute", money = 2500, count = 1, ask = "~r~2500$ ~s~(3000$)", askX = true, xps = true, xp = 2100, xpno = "une ~b~Racaille",},
				{name = "Jerry can",weapon = "weapon_petrolcan", money = 500, count = 5000, ask = "~r~500$ ~s~(500$)", askX = true, xps = true, xp = 2100, xpno = "une ~b~Racaille",},
				{name = "Cocktail molotov",weapon = "weapon_molotov", money = 2500, count = 1, ask = "~r~2500$ ~s~(3000$)", askX = true, xps = true, xp = 24000, xpno = "un ~b~Escroc",}
			}
		},
		["kevlar"] = {
			b = {
				{name = "Kevlar ultra léger",item = "gpbl", money = 2500, count = 1, ask = "~g~2500$", askX = true, xps = true, xp = 2100, xpno = "une ~b~Racaille"},
				{name = "Kevlar léger",item = "gpbm", money = 5000, count = 1, ask = "~g~5000$", askX = true, xps = true, xp = 2100, xpno = "une ~b~Racaille"},
				{name = "Kevlar lourd",item = "gpbml", money = 7500, count = 1, ask = "~g~7500$", askX = true, xps = true, xp = 24000, xpno = "un ~b~Escroc"},
				{name = "Kevlar ultra lourd",item = "gpblo", money = 10000, count = 1, ask = "~g~10000$", askX = true, xps = true, xp = 24000, xpno = "un ~b~Escroc"},
			}
		},
		["armes blanches"] = {
			b = {
			{name = "Bouteille cassée",weapon = "WEAPON_BOTTLE", money = 10, count = 1, ask = "~g~10$", askX = true},
			{name = "Lampe torche",weapon = "WEAPON_FLASHLIGHT", money = 25, count = 1, ask = "~g~25$", askX = true},
			{name = "Clé à molette",weapon = "WEAPON_WRENCH", money = 50, count = 1, ask = "~g~50$", askX = true},
			{name = "Machette",weapon = "WEAPON_MACHETE", money = 95, count = 1, ask = "~g~95$", askX = true},
			{name = "Couteau",weapon = "WEAPON_KNIFE", money = 120, count = 1, ask = "~g~120$", askX = true},
			{name = "Cran d'arrêt",weapon = "WEAPON_SWITCHBLADE", money = 125, count = 1, ask = "~g~125$", askX = true},
			{name = "Marteau",weapon = "WEAPON_HAMMER", money = 130, count = 1, ask = "~g~130$", askX = true},
			{name = "Queue de billard",weapon = "WEAPON_POOLCUE", money = 150, count = 1, ask = "~g~150$", askX = true},
			{name = "Katana",weapon = "WEAPON_HATCHET", money = 160, count = 1, ask = "~g~160$", askX = true},
			{name = "Club de golf",weapon = "WEAPON_GOLFCLUB", money = 155, count = 1, ask = "~g~155$", askX = true},
			{name = "Poignard",weapon = "WEAPON_DAGGER", money = 155, count = 1, ask = "~g~155$", askX = true},
			{name = "Poing américain",weapon = "WEAPON_KNUCKLE", money = 205, count = 1, ask = "~g~205$", askX = true},
			{name = "Batte de baseball",weapon = "WEAPON_BAT", money = 250, count = 1, ask = "~g~250$", askX = true},
			{name = "Pied de biche",weapon = "WEAPON_CROWBAR", money = 275, count = 1, ask = "~g~275$", askX = true}
			}
		},
		["munitions"] = {
			b = {
				{name = "9mm",item = "disc_ammo_pistol", money = 1, count = 1, ask = "~g~1$", askX = true},
				{name = "19mm",item = "disc_ammo_smg", money = 1, count = 1, ask = "~g~1$", askX = true},
				{name = "Calibre 12",item = "disc_ammo_shotgun", money = 1, count = 1, ask = "~g~1$", askX = true},
				{name = "5.56mm",item = "disc_ammo_rifle", money = 1, count = 1, ask = "~g~1$", askX = true},
			}
		}
	}
}
local venteems = {
	Base = { Header = {"commonmenu", "interaction_bgd"}, Title = "Hopital"},
	Data = { currentMenu = "Hopital"},
	Events = { onSelected = OnSelected },
	Menu = {
		["Hopital"] = {
			b = {
				{name = "Bandage",item = "bandage", money = 115, count = 1, compte = "society_ambulance", Description = "Permet de vous soigner de blessures.", ask = "~g~115$", askX = true},
				{name = "Paracétamol",item = "paracetamol", money = 50, count = 1, compte = "society_ambulance", Description = "Permet de vous remettre en forme peu à peu.", ask = "~g~50$", askX = true},
			}
		}
	}
}
local reaems = {
	Base = { Header = {"commonmenu", "interaction_bgd"}, Title = "Hopital"},
	Data = { currentMenu = "Internes"},
	Events = { onSelected = OnSelected },
	Menu = {
		["Internes"] = {
			b = {
				{name = "Appeler les internes", Description = "Permet de vous soigner de blessures.", ask = ">", askX = true},
			}
		}
	}
}
local ventelscustoms = {
	Base = { Header = {"commonmenu", "interaction_bgd"}, Title = "Ls Customs"},
	Data = { currentMenu = "Ls Customs"},
	Events = { onSelected = OnSelected },
	Menu = {
		["Ls Customs"] = {
			b = {
				{name = "Moteur",item = "moteur", money = 500, count = 1, compte = "society_lscustoms", Description = "Permet de réparer votre moteur.", ask = "~g~500$", askX = true},
				{name = "Kit carrosserie",item = "kitcarro", money = 500, count = 1, compte = "society_lscustoms", Description = "Permet de réparer votre carrosserie.", ask = "~g~500$", askX = true},
				{name = "Pneus",item = "pneu", money = 250, count = 1, compte = "society_lscustoms", Description = "Permet de réparer vos pneus.", ask = "~g~250$", askX = true},
			}
		}
	}
}
local magasinillegal = {
	Base = {  Header = {"commonmenu", "interaction_bgd"}, Color = {color_black}, HeaderColor = {150, 25, 100}, Title = "Aril"},
	Data = { currentMenu = "Objets disponibles"},
	Events = { onSelected = OnSelected },
	Menu = {
		["Objets disponibles"] = {
			b = {
				{name = "Clés de menottes",item = "cuff_keys", money = 65, count = 1,Description = "Permet de démenotter une personne.",ask = "~g~65$", askX = true},
				{name = "Perceuse",item = "drill", money = 350, count = 1,Description = "Permet de percer des coffres.",ask = "~g~350$", askX = true},
				{name = "Coyote",item = "coyote", money = 150, count = 1,Description = "Permet de vous avertir des radar.",ask = "~g~150$", askX = true},
				{name = "Menottes",item = "cuffs", money = 155, count = 1,Description = "Permet de menotter des personnes.",ask = "~g~155$", askX = true},
				{name = "Nokia",item = "darkshop", money = 750, count = 1,Description = "Permet d'obtenir des informations sur des points'.",ask = "~g~750$", askX = true},
				{name = "Outil de crochetage",item = "lockpick", money = 20, count = 1,Description = "Permet de servir à quelques activitées illégal.",ask = "~g~20$", askX = true},
				{name = "Outil de serrure",item = "advancedlockpick", money = 65, count = 1,Description = "Permet de crocheter des maison.",ask = "~g~65$", askX = true},
				{name = "Pelle",item = "pelle", money = 110, count = 1,Description = "Permet de creuser de la terre.",ask = "~g~110$", askX = true},
				{name = "Sac pour la tête",item = "sactete", money = 110, count = 1,Description = "Acheter un sac tactique.",ask = "~g~110$", askX = true}
			}
		}
	}
}
local darkshop = {
	Base = { Header = {"commonmenu", "interaction_bgd"}, Color = {color_black}, HeaderColor = {255, 187, 0}, Title = "DarkShop"},
	Data = { currentMenu = "Truc disponibles"},
	Events = { onSelected = OnSelected },
	Menu = {
		["Truc disponibles"] = {
			b = {
				{name = "Récolte de graines de weed",posx = -2222.158, posy = -365.9263, money = 14850, type = "~b~Dealer~s~\nDirige toi vers las bas, j'ai un ~b~dealer~s~ qui t'attendras, ~r~attention aux autres~s~ !",Description = "Récolte de graines de weed.",ask = "~g~14850$", askX = true},
				{name = "Récolte d'acide",posx = -1108.68, posy = 2723.8, money = 18650, type = "~b~Dealer~s~\nDirige toi vers las bas, j'ai un ~b~dealer~s~ qui t'attendras, ~r~attention aux autres~s~ !",Description = "Récolte d'acide.",ask = "~g~18650$", askX = true},
				{name = "Récolte de graines de coca",posx = 2854.88, posy = 4708.88, money = 29875, type = "~b~Dealer~s~\nDirige toi vers las bas, j'ai un ~b~dealer~s~ qui t'attendras, ~r~attention aux autres~s~ !",Description = "Récolte de graines de coca.",ask = "~g~29875$", askX = true},
				{name = "Récolte de sodium",posx = -230.76, posy = 3651.92, money = 34580, type = "~b~Dealer~s~\nDirige toi vers las bas, j'ai un ~b~dealer~s~ qui t'attendras, ~r~attention aux autres~s~ !",Description = "Récolte de sodium.",ask = "~g~34580$", askX = true},
				{name = "Récolte de crystal de meth",posx = -1467.52, posy = 5416.12, money = 41582, type = "~b~Dealer~s~\nDirige toi vers las bas, j'ai un ~b~dealer~s~ qui t'attendras, ~r~attention aux autres~s~ !",Description = "Récolte de crystal de meth.",ask = "~g~41582$", askX = true},
			}
		}
	}
}

local vehcasse = {
	Base = {Header = {"commonmenu", "interaction_bgd"}, Title = "Casse"},
	Data = { currentMenu = "Casse"},
	Events = { onSelected = OnSelected },
	Menu = {
		["Casse"] = {
			b = {
				{name = "Eboueur",model="trash",pos = {x = -622.84,  y = -1648.36,  z = 25.84, a = 63.49},Description = "Ce véhicule vous servira pour vos run d'eboueur.",ask = ">", askX = true},
				{name = "Jardinier",model="utillitruck3",pos = {x = -622.84,  y = -1648.36,  z = 25.84, a = 63.49},Description = "Ce véhicule vous servira pour vos run de jardinier.",ask = ">", askX = true},
			}
		}
	}
}
local vehcassedel = {
	Base = {Header = {"commonmenu", "interaction_bgd"}, Title = "Casse"},
	Data = { currentMenu = "Parking casse"},
	Events = { onSelected = OnSelected },
	Menu = {
		["Parking casse"] = {
			b = {
				{name = "Ranger le véhicule",ask = ">", askX = true},
			}
		}
	}
}

local achatbmx = {
	Base = {Header = {"commonmenu", "interaction_bgd"}, Title = "Vélo"},
	Data = { currentMenu = "Achat"},
	Events = { onSelected = OnSelected },
	Menu = {
		["Achat"] = {
			b = {
				{name = "Acheter un BMX",ask = ">", askX = true},
			}
		}
	}
}

local achatboissons = {
	Base = {  Header = {"commonmenu", "interaction_bgd"}, Color = {color_black}, HeaderColor = {150, 25, 100}, Title = "Aril"},
	Data = { currentMenu = "Objets disponibles"},
	Events = { onSelected = OnSelected },
	Menu = {
		["Objets disponibles"] = {
			b = {
				{name = "Bière",item = "biere", money = 5, count = 1,Description = "Acheter une Bière.",ask = "~g~5/U$", askX = true},
				{name = "Coca",item = "coca", money = 3, count = 1,Description = "Acheter un Coca.",ask = "~g~3/U$", askX = true},
				{name = "Vodka",item = "vodka", money = 6, count = 1,Description = "Acheter une Vodka.",ask = "~g~6/U$", askX = true},
				{name = "Red-Bull",item = "energy", money = 2, count = 1,Description = "Acheter une RedBull.",ask = "~g~2/U$", askX = true},
				{name = "Fanta",item = "fanta", money = 3, count = 1,Description = "Acheter un Fanta.",ask = "~g~3/U$", askX = true},
				{name = "Ice-Tea",item = "icetea", money = 3, count = 1,Description = "Acheter un Ice-Tea.",ask = "~g~3/U$", askX = true},
				{name = "Hamburger",item = "hamburger", money = 7, count = 1,Description = "Acheter un Hamburger.",ask = "~g~7/U$", askX = true},
			}
		}
	}
}








local posallshops = {
	{true,vector3(-555.48,-618.68,34.68),"~b~discuter",Menumetiers,"Activitées publiques",590,60,0.8},
	{true,vector3(-122.76,6389.65,32.17),"~b~discuter",Menumetiers,"Activitées publiques",590,60,0.8},
	{true,vector3(1690.04, 3581.6, 35.64),"~b~discuter",Menumetiers,"Activitées publiques",590,60,0.8},

	{true,vector3(-1459.32,-413.56,35.76), "~y~discuter",pawnshop, "PawnShop", 566, 46, 0.8},
	{true,vector3(1407.72,3619.28,34.88), "~y~discuter",pawnshop, "PawnShop", 566, 46, 0.8},

	{true,vector3(2747.8,3472.76,55.68), "~g~discuter",resellerfish, "Reseller de poisson", 479, 28, 0.8},
	{true,vector3(-458.16, -2266.12, 8.52), "~g~discuter",resellerviande, "Reseller de chasse", 442, 28, 0.8},

	{false,vector3(-1098.7382, -840.888, 19.0015), "~b~discuter",menuidentite},
	{false,vector3(1853.8,3688.08,34.240), "~b~discuter",menuidentite},

	{true,vector3(-661.64,-934.92,21.84), "~g~discuter",ammuls, "Ammunation LS", 313, 1, 0.8},
	{true,vector3(1692.8, 3760.64,34.72), "~g~discuter",ammuls, "Ammunation BC", 313, 1, 0.8},

	{true,vector3(-707.31,-913.63,19.21), "~g~discuter",Ltdshop, "LTD Sud", 59, 15, 0.8, true, "ltds"},
	{true,vector3(1959.84,3740.44,32.36), "~g~discuter",Ltdshop, "LTD Nord", 59, 15, 0.8, true, "ltdn"},
	{true,vector3(-716.835, -909.485, 19.215-0.50), "~b~discuter",Ltdshop1, "Magasin Sud", 1, 0, 0.4},
	{true,vector3(1964.854, 3747.5400, 32.343-0.50), "~b~discuter",Ltdshop1, "Magasin Nord", 1, 0, 0.4},

	{false,vector3(908.92, -3210.84, -98.24), "~r~discuter",armesillegalshop, "Ammunation Illegal", 59, 15, 0.8},

	{false,vector3(312.1956, -592.85, 43.284), "~b~discuter",venteems, "Magasin EMS", 59, 15, 0.8},
	{false,vector3(307.002, -595.0473, 43.284), "~v~discuter",reaems, "Magasin Internes", 59, 15, 0.8},
	{false,vector3(-352.125, -128.050, 39.021), "~g~discuter",ventelscustoms, "Magasin LsCustoms", 59, 15, 0.8},
	{false,vector3(477.6915, -1885.677, 26.0947), "~g~discuter",ventelscustoms, "Magasin Atomic", 59, 15, 0.8},

	{false,vector3(1399.364, -603.8837, 74.485), "~r~discuter",magasinillegal, "Magasin Illegal", 59, 15, 0.8},
	{false,vector3(1726.76, 4682.36, 43.64), "~r~discuter",magasinillegal, "Magasin Illegal", 59, 15, 0.8},

	{false,vector3(184.96, 2793.72, 45.64), "~r~discuter",givecarkeyille, "Keys véhicules", 59, 15, 0.8},

	{true,vector3(1074.24, -2010.16, 32.08), "~y~discuter",reselleror, "Resseler d'Or", 478, 5, 0.8},

	{true,vector3(-621.32, -1640.48, 25.96), "~b~discuter",vehcasse, "Casse", 67, 9, 0.6},
	{false,vector3(-618.24, -1645.44, 25.84), "~r~ranger le véhicule",vehcassedel, "Casse", 478, 5, 0.8},

	{true,vector3(579.16, 2678.0, 41.84), "~b~discuter",reselljjobs, "Resseler (Poubelles/Feuilles)", 467, 45, 0.8},
	{true,vector3(82.08, -219.88, 54.64), "~b~discuter",reselljjobs, "Resseler (Poubelles/Feuilles)", 467, 45, 0.8},
	{true, vector3(-702.848, -917.421, 19.2140), "~b~Discuter", achatbmx, "Vendeur de vélo", 1, 0, 0.4},
	{true, vector3(69.305, 127.608, 79.213), "~b~Discuter", achatboissons, "Vendeur de boissons", 1, 0, 0.4},

}

Citizen.CreateThread(function()
    while true do
		local attente = 500
		
        for _,v in pairs(posallshops) do

			if not IsPedInAnyVehicle(GetPlayerPed(-1), false) then 
				local pCoords = GetEntityCoords(PlayerPedId(), false)
				local playerClose = GetDistanceBetween3DCoords(pCoords.x, pCoords.y, pCoords.z, v[2].x, v[2].y, v[2].z, true) < 10
				if playerClose then
					attente = 5
					DrawText3D(v[2].x,v[2].y,v[2].z+1.1, "Appuyez sur ~b~E ~w~pour ~b~"..v[3], 9)
					--DrawText3D(-1429.505, -450.68579, 35.9097, "Rentrez votre véhicule dans le garage derrière pour bien appliquer tous vos customs")
					if IsControlJustPressed(1,51) and Vdist2(GetEntityCoords(PlayerPedId(), false), v[2]) < 2.1  then 
						if v[9] then
							if isJob(v[10]) then
								CreateMenuPeds(v[4])
								--setheader("Magasin / Reseller")
							else
								ShowAboveRadarMessage("~r~Vous n'avez pas le métier requis.")
							end
						else
							CreateMenuPeds(v[4])
							--setheader("Reseller")
							--setheader("Magasin / Reseller")
						end
					end
				end
			elseif IsPedInAnyVehicle(GetPlayerPed(-1), false) then 
				attente = 2500
			end
		end
		Wait(attente)
    end
end)

Citizen.CreateThread(function()
	for _,v in pairs(posallshops)do
		if v[1] then 
			createBlip(v[2] ,v[6],v[7],v[5],false,v[8])
		end
    end 
end)

RegisterNetEvent("darkshop:open")
AddEventHandler("darkshop:open", function()
	CreateMenu(darkshop)
	setheader("Illégal")
end)

RegisterNetEvent("darkshop:pointstart")
AddEventHandler("darkshop:pointstart", function(posx, posy, type)
	TriggerEvent('esx_xp:Add', 1500)
	SetNewWaypoint(posx, posy)
	ShowAboveRadarMessage(type)
end)

RegisterNetEvent("weapon:usetint")
AddEventHandler("weapon:usetint", function(type, name)
	local playerPed = GetPlayerPed(-1)
	if IsPedArmed(playerPed, 5) then 
		SetPedWeaponTintIndex(playerPed, GetSelectedPedWeapon(playerPed), type)
		TriggerServerEvent('clp:removeitem', name, 0)
	else
		ShowAboveRadarMessage("~r~Veuillez équiper une arme.")
	end
end)