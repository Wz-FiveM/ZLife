LsCustoms = LsCustoms or {}
LsCustoms.Data = { 
    veh = nil,
    props = nil,
	propsVeh = nil,
}

ESX = nil
Citizen.CreateThread(function()
	while ESX == nil do
		TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
		Citizen.Wait(0)
	end

	while ESX.GetPlayerData().job == nil do
		Citizen.Wait(100)
	end

	ESX.PlayerData = ESX.GetPlayerData()
end)

RegisterNetEvent('esx:playerLoaded')
AddEventHandler('esx:playerLoaded', function(xPlayer)
	ESX.PlayerData = xPlayer
end)

RegisterNetEvent('esx:setJob')
AddEventHandler('esx:setJob', function(job)
	ESX.PlayerData.job = job
end)

LsCustoms.UpdateVehicle = {
    {model = "primo", update = "primo2"},
    {model = "baller", update = "baller2"},
    {model = "cavalcade", update = "cavalcade2"},
    {model = "dubsta", update = "dubsta2"},
    {model = "patriot", update = "patriot2"},
    {model = "felon", update = "felon2"},
    {model = "oracle", update = "oracle2"},
    {model = "sentinel", update = "sentinel2"},
    {model = "sentinel2", update = "sentinel3"},
    {model = "windsor", update = "windsor2"}, 
    {model = "zion", update = "zion2"}, 
    {model = "buccaneer", update = "buccaneer2"}, 
    {model = "chino", update = "chino2"},
    {model = "dominator", update = "dominator3"},
    {model = "faction", update = "faction2"},
    {model = "faction2", update = "faction3"},
    {model = "moonbeam", update = "moonbeam2"},
    {model = "ratloader", update = "ratloader2"},
    {model = "sabregt", update = "sabregt"},
    {model = "slamvan", update = "slamvan2"},
    {model = "slamvan2", update = "slamvan3"},
    {model = "virgo", update = "virgo2"},
    {model = "virgo2", update = "virgo3"},
    {model = "btype", update = "btype2"},
    {model = "btype2", update = "btype3"},
    {model = "tornado", update = "tornado5"},
    {model = "turismor", update = "turismo2"},
    {model = "blista", update = "blista2"},
    {model = "buffalo", update = "buffalo2"},
    {model = "comet", update = "comet2"},
    {model = "comet2", update = "comet3"},
    {model = "comet3", update = "comet4"},
    {model = "comet4", update = "comet5"},
    {model = "elegy", update = "elegy2"},
    {model = "schafter2", update = "schafter3"},
    {model = "schafter3", update = "schafter4"},
    {model = "specter", update = "specter2"},
    {model = "sultan", update = "sultanrs"},
    {model = "tampa", update = "tampa2"},
    {model = "banshee", update = "banshee2"},
    {model = "entityxf", update = "entity2"},
    {model = "italigtb", update = "italigtb2"},
    {model = "nero", update = "nero2"},
    {model = "bati", update = "bati2"},
    {model = "daemon", update = "daemon2"},
    {model = "diablous", update = "diablous2"},
    {model = "faggio", update = "faggio2"},
    {model = "faggio2", update = "faggio3"},
    {model = "fcr", update = "fcr2"},
    {model = "hakuchou", update = "hakuchou2"},
    {model = "sanchez", update = "sanchez2"},
    {model = "zombiea", update = "zombieb"},
    {model = "blazer", update = "blazer3"},
    {model = "blazer3", update = "blazer4"},
    {model = "rebel", update = "rebel2"},
    {model = "sandking", update = "sandking2"},
    {model = "trophytruck", update = "trophytruck2"},
    {model = "gburrito", update = "gburrito2"},
    {model = "minivan", update = "minivan2"},
    {model = "rumpo", update = "rumpo3"},
    {model = "speedo", update = "speedo4"},
    {model = "surfer", update = "surfer2"},
    {model = "youga", update = "youga2"},
    {model = "mule3", update = "mule4"},
    {model = "phantom", update = "phantom3"},
    {model = "pounder", update = "pounder2"},
}

LsCustoms.ModsInBennys = {30, 31, 32, 33, 34, 35, 36, 37, 38, 39, 44, 45, 48, 49, 50}
LsCustoms.ModsInFirstPerson = {27, 28, 29, 30, 33, 32, 34}
LsCustoms.ModsCapotOpen = {39, 40, 45}
LsCustoms.ModsCoffreOpen = {37}
LsCustoms.Price = 0

LsCustoms.ModsList = {
	{ id = 0, name = "Aileron", prix = 400 },
	{ id = 1, name = "Pare-choc avant", prix = 300 },
	{ id = 2, name = "Pare-choc arrière", prix = 300 },
	{ id = 3, name = "Carroserie", prix = 250 },
	{ id = 4, name = "Echappement", prix = 400 },
	{ id = 5, name = "Cadre", prix = 400 },
	{ id = 6, name = "Calandre", prix = 300 },
	{ id = 7, name = "Capot", prix = 400 },
	{ id = 8, name = "Autocollant gauche", prix = 250 },
	{ id = 9, name = "Autocollant droit", prix = 250 },
	{ id = 10, name = "Toit", prix = 250 },
	{ id = 25, name = "Support de plaque", prix = 250 },
	{ id = 26, name = "Plaque avant", prix = 250 },
	{ id = 27, name = "Style intérieur", prix = 250 },
	{ id = 28, name = "Figurine", prix = 250 },
	{ id = 29, name = "Tableau de bord motif", prix = 250 },
	{ id = 30, name = "Cadran", prix = 250 },
	{ id = 31, name = "Haut parleur portes", prix = 250 },
	{ id = 32, name = "Motif sieges", prix = 250 },
	{ id = 33, name = "Volant", prix = 250 },
	{ id = 34, name = "Levier", prix = 250 },
	{ id = 35, name = "Logo custom", prix = 250 },
	{ id = 36, name = "Vitre", prix = 250 },
	{ id = 37, name = "Haut parleur coffre", prix = 250 },
	{ id = 38, name = "Hydrolique", prix = 250 },
	{ id = 39, name = "Moteur", prix = 250 },
	{ id = 40, name = "Filtres à air", prix = 250 },
	{ id = 41, name = "Entretoises", prix = 250 },
	{ id = 42, name = "Couverture", prix = 250 },
	{ id = 43, name = "Antenne", prix = 250 },
	--{ id = 44, name = "motif exterieur", prix = 250 },
	{ id = 45, name = "Reservoir", prix = 250 },
	{ id = 46, name = "Fenêtre", prix = 250 },
	{ id = 48, name = "Style", prix = 250 },
}

-- Particles
function RequestAndStartparticles(pos, effectData, size)
    RequestNamedPtfxAsset(effectData[1])
    while not HasNamedPtfxAssetLoaded(effectData[1]) do
        Wait(0)
    end

    UseParticleFxAssetNextCall(effectData[1])
    StartParticleFxNonLoopedAtCoord(effectData[2], pos + vec3(0, 0, 0), 0.0, 0.0, 0.0, size or 1.0, false, false, false, false)

    RemovePtfxAsset()
end

RegisterNetEvent('zHayes:StartParticles')
AddEventHandler('zHayes:StartParticles', function(pos, effectData, size)
    if effectData[1] then 
        RequestAndStartparticles(pos, effectData, size)
    end
end)

function TaskSynchronizedTasks(ped, animData, clearTasks)
	for _,v in pairs(animData) do
		if not HasAnimDictLoaded(v.anim[1]) then
			RequestAnimDict(v.anim[1])
			while not HasAnimDictLoaded(v.anim[1]) do Citizen.Wait(0) end
		end
	end

	local _, sequence = OpenSequenceTask(0)
	for _,v in pairs(animData) do
		TaskPlayAnim(0, v.anim[1], v.anim[2], 2.0, -2.0, math.floor(v.time or -1), v.flag or 48, 0, 0, 0, 0)
	end

	CloseSequenceTask(sequence)
	if clearTasks then ClearPedTasks(ped) end
	TaskPerformSequence(ped, sequence)
	ClearSequenceTask(sequence)

	for _,v in pairs(animData) do
		RemoveAnimDict(v.anim[1])
	end

	return sequence
end

local function TransFormVehicle(veh, btn)
	local player = PlayerPedId()
	local pPed = player
	local pPos = GetEntityCoords(player)
	local model = (type(btn.update) == 'number' and btn.update or GetHashKey(btn.update))
	local heading = GetEntityHeading(veh)
	local vPos = GetEntityCoords(veh)

	local time = 60000
	local timespray = 30000
	Wait(500)
	SetEntityHeading(pPed, GetEntityHeading(veh)+180.0)
	UseTheJackFunction(veh, 5)
	Wait(100)
	AnimationSpray()
	Wait(500)
	TaskPlayAnimToPlayer("WORLD_HUMAN_VEHICLE_MECHANIC", time, 1)
    SetEntityHeading(pPed, GetEntityHeading(veh)+90.0)
	Wait(time)
	ClearPedTasksImmediately(pPed)
	ESX.ShowNotification("~g~Vous avez installé toutes les modifications.")
	UseTheJackFunction(veh, 5)

	DeleteVehicle(veh)
	TriggerServerEvent('zHayes:StartParticles', vPos, {"proj_indep_firework", "scr_indep_firework_grd_burst"}, 3.0)
	Wait(25)
	local vehicle = CreateVehicle(model, pPos.x, pPos.y, pPos.z, heading, true, false, 3)
	local id = NetworkGetNetworkIdFromEntity(vehicle)
	SetNetworkIdCanMigrate(id, true)
	SetEntityAsMissionEntity(vehicle, true, false)
	SetVehicleHasBeenOwnedByPlayer(vehicle, true)
	SetVehicleNeedsToBeHotwired(vehicle, false)
	SetVehicleOnGroundProperly(vehicle)
	SetModelAsNoLongerNeeded(model)
	SetVehicleRadioLoud(vehicle, true)
	SetDisableVehiclePetrolTankFires(vehicle, true)
	SetVehicleCanLeakOil(vehicle, true)
	SetVehicleCanLeakPetrol(vehicle, true)
	TaskWarpPedIntoVehicle(pPed, vehicle, -1)
	CloseMenu(true)
end	

local function RenderBackProperties(bool)
	if bool then 
		LsCustoms.Data.props = LsCustoms:GetVehicleProperties(LsCustoms.Data.veh)
	elseif not bool then 
		LsCustoms:SetVehicleProperties(LsCustoms.Data.veh, LsCustoms.Data.props)
	end
end

local slideFunction = {
	["couleur intérieur"] = function(veh, b)
		SetVehicleInteriorColour(veh, b.slidenum and b.slidenum - 1 or 0)
	end,
	["nacrage"] = function(veh, b)
		local _, w = GetVehicleExtraColours(veh)
		SetVehicleExtraColours(veh, b.slidenum and b.slidenum - 1 or 0, w)
	end,
	["couleur principale"] = function(veh, b, id)
		if b.RGBA then
			local r, g, bb = GetVehicleCustomPrimaryColour(veh)
			ClearVehicleCustomPrimaryColour(veh)
			SetVehicleCustomPrimaryColour(veh, b.RGBA[1] or r, b.RGBA[2] or g, b.RGBA[3] or bb)
		else
			local _, s = GetVehicleColours(veh)
			local color = (b.slidenum or 1) - 1
			ClearVehicleCustomPrimaryColour(veh)
			SetVehicleColours(veh, color, s)
		end
	end,
	["couleur secondaire"] = function(veh, b, id)
		if b.RGBA then
			local r, g, bb = GetVehicleCustomSecondaryColour(veh)
			ClearVehicleCustomSecondaryColour(veh)
			SetVehicleCustomSecondaryColour(veh, b.RGBA[1] or r, b.RGBA[2] or g, b.RGBA[3] or bb)
		else
			local p = GetVehicleColours(veh)
			local color = (b.slidenum or 1) - 1

			ClearVehicleCustomSecondaryColour(veh)
			SetVehicleColours(veh, p, color)
		end
	end,
	["klaxon"] = function(veh, b) SetVehicleMod(veh, 14, b.slidenum - 2, false) end,
	["type de roues"] = function(veh, b, id, menuData, self)
		local allMenu = self.Menu[menuData.currentMenu]
		if not allMenu or not allMenu.b or not allMenu.b[2] then return end
		SetVehicleWheelType(veh, b.slidenum - 1)
		allMenu.b[2].slidenum = 1
		allMenu.b[2].slidemax = GetNumVehicleMods(veh, 23) - 1
	end,
	["jantes principales"] = function(veh, b) SetVehicleMod(veh, 23, b.slidenum - 2, GetVehicleModVariation(veh, 23)) end,
	["jantes arrières"] = function(veh, b) SetVehicleMod(veh, 24, b.slidenum - 2, GetVehicleModVariation(veh, 24)) end,
	["couleurs des jantes"] = function(veh, b)
		local a = GetVehicleExtraColours(veh)
		SetVehicleExtraColours(veh, a, b.slidenum and b.slidenum - 1 or 0)
	end,
	["roues customs"] = function(veh, b)
		local enabled = b.slidenum == 2 or false
		SetVehicleMod(veh, 23, GetVehicleMod(veh, 23), enabled)
	end,
	["roues arrières customs"] = function(veh, b)
		local enabled = b.slidenum == 2 or false
		SetVehicleMod(veh, 24, GetVehicleMod(veh, 24), enabled)
	end,
	["teinte des vitres"] = function(veh, b) SetVehicleWindowTint(veh, b.slidenum and b.slidenum - 1 or 0) end,
	["couleur tableau de bord"] = function(veh, b) SetVehicleDashboardColour(veh, b.slidenum and b.slidenum - 1 or 0) end,
	["types de plaques"] = function(veh, b) SetVehicleNumberPlateTextIndex(veh, b.slidenum and b.slidenum - 1 or 0) end,
	["neons"] = function(veh, b)
		local r, g, bb = GetVehicleNeonLightsColour(veh)
		if b.RGBA then SetVehicleNeonLightsColour(veh, b.RGBA[1] or r, b.RGBA[2] or g, b.RGBA[3] or bb) end
	end,
	["customs"] = function(veh, b) SetVehicleMod(veh, b.id, b.slidenum and b.slidenum - 2 or - 1) end,
	["performances"] = function(veh, b) SetVehicleMod(veh, b.id, b.slidenum and b.slidenum - 2 or - 1) end,
	["bennys"] = function(veh, b) SetVehicleMod(veh, b.id, b.slidenum and b.slidenum - 2 or - 1) end,
	["roues"] = function(veh, b)
		local r, g, bb = GetVehicleTyreSmokeColor(veh)
		if b.RGBA then SetVehicleTyreSmokeColor(veh, b.RGBA[1] or r, b.RGBA[2] or g, b.RGBA[3] or bb) end
	end,
	["livery"] = function(veh, b) SetVehicleLivery(veh, b.slidenum) end,
	["couleur des phares"] = function(veh, b) SetVehicleXenonLightsColour(veh, b.slidenum and b.slidenum - 1) end,
	["extra"] = function(veh, b) SetVehicleExtra(veh, b.id, b.slidenum ~= nil and b.slidenum == 1) end,
	-- ["transformation du véhicule"] = function(veh, b) 
	-- 	local model = (type(b.update) == 'number' and b.update or GetHashKey(b.update))
	-- 	ESX.Streaming.RequestModel(model) 
	-- end,
}

local function onSlide(menuData, currentButton, currentSlt, self)
	local currentMenu, buttonName = menuData.currentMenu, string.lower(currentButton.name)
	local lastMenu = menuData.back[#menuData.back]

	local slidenum = currentButton.slidenum and currentButton.slidenum - 1 or 0
	if currentMenu == "couleur principale" or currentMenu == "couleur secondaire" then -- extra args
		buttonName = currentMenu
		if currentSlt == 1 then currentButton.pType = slidenum end
	elseif currentMenu == "couleurs customs" then
		buttonName = lastMenu.menu
		currentButton.RGBA = { [currentSlt] = slidenum }
	elseif currentMenu == "customs" or (currentMenu == "roues" and currentSlt == 5) or currentMenu == "bennys" or currentMenu == "performances" then
		buttonName = currentMenu
	end

	local slideFunc = slideFunction[buttonName] or slideFunction[currentMenu]
	if slideFunc then
		slideFunc(LsCustoms.Data.veh, currentButton, currentSlt, menuData, self)
	end
end

local function GetModObjects(veh, mod)
	local tbl = {"default"}
	for i = 0, tonumber(GetNumVehicleMods(veh,mod)) - 1 do
		local toBeInserted = "0"
		local labelName = GetModTextLabel(veh,mod,i)
		if labelName ~= nil then
			local name = tostring(GetLabelText(labelName))
			if name ~= "NULL" then
				toBeInserted = name
			end
		end
		tbl[#tbl + 1] = toBeInserted
	end

	return tbl
end
-- Table
function TableGetValue(tbl, value, k) -- Si une table a une value précise
	if not tbl or not value or type(tbl) ~= "table" then return end
	for _,v in pairs(tbl) do
		if k and v[k] == value or v == value then return true, _ end
	end
end


local function GetAllCustomFromVeh(bennys)
	local veh, tbl = LsCustoms.Data.veh, {}
	if not veh or not DoesEntityExist(veh) then return tbl end

	for _,v in pairs(LsCustoms.ModsList) do
		local INSIDE = TableGetValue(LsCustoms.ModsInBennys, v.id)
		if bennys and INSIDE or not bennys and not INSIDE then
			local num = GetNumVehicleMods(veh, v.id)
			if num and num > 0 then
				tbl[#tbl + 1] = { name = v.name, slidemax = GetModObjects(veh, v.id), customSlidenum = GetVehicleMod(veh, v.id) + 2, id = v.id, prix = v.prix or 200 }
			end
		end
	end

	return tbl
end

local function GetExtraFromVehicle()
	local veh, tbl = LsCustoms.Data.veh, {}
	if not veh or not DoesEntityExist(veh) then return tbl end

	for i = 0, 20 do
		if DoesExtraExist(veh, i) then
			tbl[#tbl + 1] = { name = "Extra #" .. i, id = i, slidemax = {"Inactif", "Actif"}, customSlidenum = function() return IsVehicleExtraTurnedOn(veh, i) and 2 or 1 end, prix = 50 }
		end
	end

	return tbl
end

local function onButtonSelected(PMenu, currentSlt, old, currentButton)

	SetVehicleDoorShut(LsCustoms.Data.veh, 5, true)
	SetVehicleDoorShut(LsCustoms.Data.veh, 4, true)
	if GetFollowVehicleCamViewMode() == 4 then SetFollowVehicleCamViewMode(0) end

	if currentButton.id then
		local shouldOpenTrunk = TableGetValue(LsCustoms.ModsCoffreOpen, currentButton.id)
		local shouldOpenCapot = TableGetValue(LsCustoms.ModsCapotOpen, currentButton.id)
		local shouldToggleFirst = TableGetValue(LsCustoms.ModsInFirstPerson, currentButton.id)

		if shouldOpenTrunk or shouldOpenCapot then
			SetVehicleDoorOpen(LsCustoms.Data.veh, shouldOpenTrunk and 5 or 4, false, true)
		end

		if shouldToggleFirst then
			SetFollowVehicleCamViewMode(4)
		end
	end
end

local function BuyCustoms(price)
	LsCustoms.Price = LsCustoms.Price + price
    if not price then return ESX.ShowNotification("~r~Aucun prix n'est renseigné.") end
end

LsCustoms.OnInstall = false
RegisterNetEvent('zHayes:InstallLsCustoms')
AddEventHandler('zHayes:InstallLsCustoms', function()
	LsCustoms.OnInstall = true
    LsCustoms.Data.props = LsCustoms:GetVehicleProperties(LsCustoms.Data.veh)
	local player = PlayerPedId()
	local pPed = player
	ClearPedTasksImmediately(pPed)
	ESX.ShowNotification("~g~Vous avez installé toutes les modifications.")
	CloseMenu()
	LsCustoms.OnInstall = false
	LsCustoms.Data = {}
end)

RegisterNetEvent('zHayes:CancelLsCustoms')
AddEventHandler('zHayes:CancelLsCustoms', function()
	ESX.ShowNotification("~r~La commande a été refusé car l'entreprise n'a plus assez de fonds nécessaires.")
	LsCustoms:SetVehicleProperties(LsCustoms.Data.veh, LsCustoms.Data.propsVeh)
end)

local function GetInventoryVehicles()
    local tblButtons= {}

    local model = GetEntityModel(GetVehiclePedIsIn(PlayerPedId(), false))
    local vehModel = GetDisplayNameFromVehicleModel(model)
    local vehLabel = GetLabelText(GetDisplayNameFromVehicleModel(model))

    tblButtons[#tblButtons + 1] = { name = vehLabel}

	return tblButtons
end

local scalLsCustoms = nil

local function onSelected(PMenu, menuData, currentButton, currentSlt, allButtons)
	local currentMenu, customPr = menuData.currentMenu
	local buttonName = string.lower(currentButton.name)

	if LsCustoms.Data.loadingVehicle then return end

	if currentMenu == "customisation" then
		if currentButton.name == "~g~Confirmer" and LsCustoms.Data.veh and DoesEntityExist(LsCustoms.Data.veh) then
            TriggerServerEvent("zHayes:BuyLsCustoms", LsCustoms.Price)
			Wait(500)
			PMenu:CloseMenu()
            LsCustoms.Price = 0
		end
	else
		local checkbox = currentButton.checkbox ~= nil and currentButton.checkbox()

		if currentMenu == "couleurs customs" then currentMenu = menuData.back[#menuData.back].menu end
		if currentButton.name == "couleurs customs" then return end

		if currentButton.toggle then
			local enable = not checkbox
			ToggleVehicleMod(LsCustoms.Data.veh, currentButton.toggle, enable)
			if enable then 
				RenderBackProperties(true)
				BuyCustoms(currentButton.prix)
			end
		elseif currentButton.customs then 
			if not IsThisModelABike(GetEntityModel(LsCustoms.Data.veh)) then 
				local enable = not GetVehicleModVariation(LsCustoms.Data.veh, currentButton.customs)
				RenderBackProperties(enable)
				SetVehicleMod(LsCustoms.Data.veh, currentButton.customs, GetVehicleMod(LsCustoms.Data.veh, currentButton.customs), enable)
				if enable then 
					RenderBackProperties(true)
					BuyCustoms(currentButton.prix)
				end
			else
				currentButton.customs = 24
				local enable = not GetVehicleModVariation(LsCustoms.Data.veh, currentButton.customs)
				RenderBackProperties(enable)
				SetVehicleMod(LsCustoms.Data.veh, currentButton.customs, GetVehicleMod(LsCustoms.Data.veh, currentButton.customs), enable)
				if enable then 
					RenderBackProperties(true)
					BuyCustoms(currentButton.prix)
				end
			end
		elseif currentMenu == "performances" and currentButton.id then
            customPr = currentButton.prix * currentButton.slidenum
			RenderBackProperties(true)
            BuyCustoms(customPr)
		elseif currentMenu == "transformation du véhicule" then 
			if currentButton.name == "Rien" then return end
			TransFormVehicle(LsCustoms.Data.veh, currentButton)
		elseif (currentMenu == "customs" or currentMenu == "bennys" or currentMenu == "classiques") and currentButton.id then
			local id = currentButton.slidenum - 2
            customPr = id == -1 and 0 or currentButton.prix
			RenderBackProperties(true)
            BuyCustoms(customPr)
		elseif currentMenu == "classiques" then
			if buttonName == "teinte des vitres" then
			elseif buttonName == "types de plaques" then
			elseif buttonName == "livery" then
			--elseif buttonName == "couleur des phares" then
			end
			RenderBackProperties(true)
            BuyCustoms(currentButton.prix)
		elseif currentMenu == "neons" then
			if currentButton.checkbox ~= nil then
				local enable = not checkbox
				SetVehicleNeonLightEnabled(LsCustoms.Data.veh, currentSlt - 1, enable)
				RenderBackProperties(true)
                BuyCustoms(currentButton.prix)
				if not enable then customPr = 0 end
			else
                customPr = 250
				RenderBackProperties(true)
                BuyCustoms(customPr)
			end
		elseif currentMenu == "couleur principale" or currentMenu == "couleur secondaire" then
			customPr = currentButton.prix
			RenderBackProperties(true)
            BuyCustoms(customPr)
			local boolSecondary = currentMenu == "couleur secondaire"
		elseif currentMenu == "peintures" then
			if buttonName == "couleur intérieur" then
				RenderBackProperties(true)
                BuyCustoms(currentButton.prix)
			elseif buttonName == "couleur tableau de bord" then
				RenderBackProperties(true)
                BuyCustoms(currentButton.prix)
			elseif buttonName == "nacrage" then
				RenderBackProperties(true)
                BuyCustoms(currentButton.prix)
            end
		elseif currentMenu == "roues" then
			if buttonName ~= "type de roues" then
				RenderBackProperties(true)
                BuyCustoms(currentButton.prix)
			end
		elseif currentMenu == "extra" then
			if currentButton.slidenum == 2 then
			else
			end
		elseif currentButton.name == "Phares xenons" then 
			if not IsToggleModOn(LsCustoms.Data.veh, 22) then 
				RenderBackProperties(true)
				BuyCustoms(currentButton.prix)
			end
		end
	end
end

function LsCustoms:GetDetailsProperties(vehicle)
	if DoesEntityExist(vehicle) then
		local colorPrimary, colorSecondary = GetVehicleColours(vehicle)
		local pearlescentColor, wheelColor = GetVehicleExtraColours(vehicle)
		local extras = {}

		for extraId=0, 12 do
			if DoesExtraExist(vehicle, extraId) then
				local state = IsVehicleExtraTurnedOn(vehicle, extraId) == 1
				extras[tostring(extraId)] = state
			end
		end

		return {
			model             = GetEntityModel(vehicle),

			plate             = ESX.Math.Trim(GetVehicleNumberPlateText(vehicle)),
			plateIndex        = GetVehicleNumberPlateTextIndex(vehicle),

			bodyHealth        = ESX.Math.Round(GetVehicleBodyHealth(vehicle), 1),
			engineHealth      = ESX.Math.Round(GetVehicleEngineHealth(vehicle), 1),
			tankHealth        = ESX.Math.Round(GetVehiclePetrolTankHealth(vehicle), 1),

			fuelLevel         = ESX.Math.Round(GetVehicleFuelLevel(vehicle), 1),
			dirtLevel         = ESX.Math.Round(GetVehicleDirtLevel(vehicle), 1),
			color1            = colorPrimary,
			color2            = colorSecondary,

			pearlescentColor  = pearlescentColor,
			wheelColor        = wheelColor,

			wheels            = GetVehicleWheelType(vehicle),
			windowTint        = GetVehicleWindowTint(vehicle),
			xenonColor        = GetVehicleXenonLightsColour(vehicle),

			neonEnabled       = {
				IsVehicleNeonLightEnabled(vehicle, 0),
				IsVehicleNeonLightEnabled(vehicle, 1),
				IsVehicleNeonLightEnabled(vehicle, 2),
				IsVehicleNeonLightEnabled(vehicle, 3)
			},

			customWheel = GetVehicleModVariation(vehicle, 23),

			neonColor         = table.pack(GetVehicleNeonLightsColour(vehicle)),
			extras            = extras,
			tyreSmokeColor    = table.pack(GetVehicleTyreSmokeColor(vehicle)),

			modSpoilers       = GetVehicleMod(vehicle, 0),
			modFrontBumper    = GetVehicleMod(vehicle, 1),
			modRearBumper     = GetVehicleMod(vehicle, 2),
			modSideSkirt      = GetVehicleMod(vehicle, 3),
			modExhaust        = GetVehicleMod(vehicle, 4),
			modFrame          = GetVehicleMod(vehicle, 5),
			modGrille         = GetVehicleMod(vehicle, 6),
			modHood           = GetVehicleMod(vehicle, 7),
			modFender         = GetVehicleMod(vehicle, 8),
			modRightFender    = GetVehicleMod(vehicle, 9),
			modRoof           = GetVehicleMod(vehicle, 10),

			modEngine         = GetVehicleMod(vehicle, 11),
			modBrakes         = GetVehicleMod(vehicle, 12),
			modTransmission   = GetVehicleMod(vehicle, 13),
			modHorns          = GetVehicleMod(vehicle, 14),
			modSuspension     = GetVehicleMod(vehicle, 15),
			modArmor          = GetVehicleMod(vehicle, 16),

			modTurbo          = IsToggleModOn(vehicle, 18),
			modSmokeEnabled   = IsToggleModOn(vehicle, 20),
			modXenon          = IsToggleModOn(vehicle, 22),

			modFrontWheels    = GetVehicleMod(vehicle, 23),
			modBackWheels     = GetVehicleMod(vehicle, 24),

			modPlateHolder    = GetVehicleMod(vehicle, 25),
			modVanityPlate    = GetVehicleMod(vehicle, 26),
			modTrimA          = GetVehicleMod(vehicle, 27),
			modOrnaments      = GetVehicleMod(vehicle, 28),
			modDashboard      = GetVehicleMod(vehicle, 29),
			modDial           = GetVehicleMod(vehicle, 30),
			modDoorSpeaker    = GetVehicleMod(vehicle, 31),
			modSeats          = GetVehicleMod(vehicle, 32),
			modSteeringWheel  = GetVehicleMod(vehicle, 33),
			modShifterLeavers = GetVehicleMod(vehicle, 34),
			modAPlate         = GetVehicleMod(vehicle, 35),
			modSpeakers       = GetVehicleMod(vehicle, 36),
			modTrunk          = GetVehicleMod(vehicle, 37),
			modHydrolic       = GetVehicleMod(vehicle, 38),
			modEngineBlock    = GetVehicleMod(vehicle, 39),
			modAirFilter      = GetVehicleMod(vehicle, 40),
			modStruts         = GetVehicleMod(vehicle, 41),
			modArchCover      = GetVehicleMod(vehicle, 42),
			modAerials        = GetVehicleMod(vehicle, 43),
			modTrimB          = GetVehicleMod(vehicle, 44),
			modTank           = GetVehicleMod(vehicle, 45),
			modWindows        = GetVehicleMod(vehicle, 46),
			modLivery         = GetVehicleLivery(vehicle)
		}
	else
		return
	end
end

function LsCustoms:GetVehicleProperties(vehicle)
    if DoesEntityExist(vehicle) then
        local vehicleProps = LsCustoms:GetDetailsProperties(vehicle)
        vehicleProps["tyres"] = {}
        vehicleProps["windows"] = {}
        vehicleProps["doors"] = {}
        for id = 1, 10 do
            local tyreId = IsVehicleTyreBurst(vehicle, id, false)
        
            if tyreId then
                vehicleProps["tyres"][#vehicleProps["tyres"] + 1] = tyreId
        
                if tyreId == false then
                    tyreId = IsVehicleTyreBurst(vehicle, id, true)
                    vehicleProps["tyres"][ #vehicleProps["tyres"]] = tyreId
                end
            else
                vehicleProps["tyres"][#vehicleProps["tyres"] + 1] = false
            end
        end
        for id = 1, 7 do
            local windowId = IsVehicleWindowIntact(vehicle, id)

            if windowId ~= nil then
                vehicleProps["windows"][#vehicleProps["windows"] + 1] = windowId
            else
                vehicleProps["windows"][#vehicleProps["windows"] + 1] = true
            end
        end
        for id = 0, 6 do
            local doorId = IsVehicleDoorDamaged(vehicle, id)
            if doorId then
                vehicleProps["doors"][#vehicleProps["doors"] + 1] = doorId
            else
                vehicleProps["doors"][#vehicleProps["doors"] + 1] = false
            end
        end
		vehicleProps["vehicleHeadLight"]  = GetVehicleHeadlightsColour(vehicle)
        vehicleProps["vehicleEngine"]  = GetVehicleEngineHealth(vehicle)
        return vehicleProps
	else
		return nil
    end
end

function LsCustoms:SetVehicleDetailsProperties(vehicle, props)
	if DoesEntityExist(vehicle) then
		local colorPrimary, colorSecondary = GetVehicleColours(vehicle)
		local pearlescentColor, wheelColor = GetVehicleExtraColours(vehicle)
		SetVehicleModKit(vehicle, 0)

		if props.plate then SetVehicleNumberPlateText(vehicle, props.plate) end
		if props.plateIndex then SetVehicleNumberPlateTextIndex(vehicle, props.plateIndex) end
		if props.bodyHealth then SetVehicleBodyHealth(vehicle, props.bodyHealth + 0.0) end
		if props.engineHealth then SetVehicleEngineHealth(vehicle, props.engineHealth + 0.0) end
		if props.tankHealth then SetVehiclePetrolTankHealth(vehicle, props.tankHealth + 0.0) end
		if props.fuelLevel then SetVehicleFuelLevel(vehicle, props.fuelLevel + 0.0) end
		if props.dirtLevel then SetVehicleDirtLevel(vehicle, props.dirtLevel + 0.0) end
		if props.color1 then SetVehicleColours(vehicle, props.color1, colorSecondary) end
		if props.color2 then SetVehicleColours(vehicle, props.color1 or colorPrimary, props.color2) end
		if props.pearlescentColor then SetVehicleExtraColours(vehicle, props.pearlescentColor, wheelColor) end
		if props.wheelColor then SetVehicleExtraColours(vehicle, props.pearlescentColor or pearlescentColor, props.wheelColor) end
		if props.wheels then SetVehicleWheelType(vehicle, props.wheels) end
		if props.windowTint then SetVehicleWindowTint(vehicle, props.windowTint) end


		if props.neonEnabled then
			SetVehicleNeonLightEnabled(vehicle, 0, props.neonEnabled[1])
			SetVehicleNeonLightEnabled(vehicle, 1, props.neonEnabled[2])
			SetVehicleNeonLightEnabled(vehicle, 2, props.neonEnabled[3])
			SetVehicleNeonLightEnabled(vehicle, 3, props.neonEnabled[4])
		end

		if props.extras then
			for extraId,enabled in pairs(props.extras) do
				if enabled then
					SetVehicleExtra(vehicle, tonumber(extraId), 0)
				else
					SetVehicleExtra(vehicle, tonumber(extraId), 1)
				end
			end
		end

		if props.neonColor then SetVehicleNeonLightsColour(vehicle, props.neonColor[1], props.neonColor[2], props.neonColor[3]) end
		if props.xenonColor then SetVehicleXenonLightsColour(vehicle, props.xenonColor) end
		if props.modSmokeEnabled then ToggleVehicleMod(vehicle, 20, true) end
		if props.tyreSmokeColor then SetVehicleTyreSmokeColor(vehicle, props.tyreSmokeColor[1], props.tyreSmokeColor[2], props.tyreSmokeColor[3]) end
		if props.modSpoilers then SetVehicleMod(vehicle, 0, props.modSpoilers, false) end
		if props.modFrontBumper then SetVehicleMod(vehicle, 1, props.modFrontBumper, false) end
		if props.modRearBumper then SetVehicleMod(vehicle, 2, props.modRearBumper, false) end
		if props.modSideSkirt then SetVehicleMod(vehicle, 3, props.modSideSkirt, false) end
		if props.modExhaust then SetVehicleMod(vehicle, 4, props.modExhaust, false) end
		if props.modFrame then SetVehicleMod(vehicle, 5, props.modFrame, false) end
		if props.modGrille then SetVehicleMod(vehicle, 6, props.modGrille, false) end
		if props.modHood then SetVehicleMod(vehicle, 7, props.modHood, false) end
		if props.modFender then SetVehicleMod(vehicle, 8, props.modFender, false) end
		if props.modRightFender then SetVehicleMod(vehicle, 9, props.modRightFender, false) end
		if props.modRoof then SetVehicleMod(vehicle, 10, props.modRoof, false) end
		if props.modEngine then SetVehicleMod(vehicle, 11, props.modEngine, false) end
		if props.modBrakes then SetVehicleMod(vehicle, 12, props.modBrakes, false) end
		if props.modTransmission then SetVehicleMod(vehicle, 13, props.modTransmission, false) end
		if props.modHorns then SetVehicleMod(vehicle, 14, props.modHorns, false) end
		if props.modSuspension then SetVehicleMod(vehicle, 15, props.modSuspension, false) end
		if props.modArmor then SetVehicleMod(vehicle, 16, props.modArmor, false) end
		if props.modTurbo then ToggleVehicleMod(vehicle,  18, props.modTurbo) end
		if props.modXenon then ToggleVehicleMod(vehicle,  22, props.modXenon) end
		if props.modFrontWheels then SetVehicleMod(vehicle, 23, props.modFrontWheels, false) end
		if props.modBackWheels then SetVehicleMod(vehicle, 24, props.modBackWheels, false) end
		if props.modPlateHolder then SetVehicleMod(vehicle, 25, props.modPlateHolder, false) end
		if props.modVanityPlate then SetVehicleMod(vehicle, 26, props.modVanityPlate, false) end
		if props.modTrimA then SetVehicleMod(vehicle, 27, props.modTrimA, false) end
		if props.modOrnaments then SetVehicleMod(vehicle, 28, props.modOrnaments, false) end
		if props.modDashboard then SetVehicleMod(vehicle, 29, props.modDashboard, false) end
		if props.modDial then SetVehicleMod(vehicle, 30, props.modDial, false) end
		if props.modDoorSpeaker then SetVehicleMod(vehicle, 31, props.modDoorSpeaker, false) end
		if props.modSeats then SetVehicleMod(vehicle, 32, props.modSeats, false) end
		if props.modSteeringWheel then SetVehicleMod(vehicle, 33, props.modSteeringWheel, false) end
		if props.modShifterLeavers then SetVehicleMod(vehicle, 34, props.modShifterLeavers, false) end
		if props.modAPlate then SetVehicleMod(vehicle, 35, props.modAPlate, false) end
		if props.modSpeakers then SetVehicleMod(vehicle, 36, props.modSpeakers, false) end
		if props.modTrunk then SetVehicleMod(vehicle, 37, props.modTrunk, false) end
		if props.modHydrolic then SetVehicleMod(vehicle, 38, props.modHydrolic, false) end
		if props.modEngineBlock then SetVehicleMod(vehicle, 39, props.modEngineBlock, false) end
		if props.modAirFilter then SetVehicleMod(vehicle, 40, props.modAirFilter, false) end
		if props.modStruts then SetVehicleMod(vehicle, 41, props.modStruts, false) end
		if props.modArchCover then SetVehicleMod(vehicle, 42, props.modArchCover, false) end
		if props.modAerials then SetVehicleMod(vehicle, 43, props.modAerials, false) end
		if props.modTrimB then SetVehicleMod(vehicle, 44, props.modTrimB, false) end
		if props.modTank then SetVehicleMod(vehicle, 45, props.modTank, false) end
		if props.modWindows then SetVehicleMod(vehicle, 46, props.modWindows, false) end
		if props.customWheel then SetVehicleMod(vehicle, 23, GetVehicleMod(vehicle, 23), true) end

		if props.modLivery then
			SetVehicleMod(vehicle, 48, props.modLivery, false)
			SetVehicleLivery(vehicle, props.modLivery)
		end
	end
end

function LsCustoms:SetVehicleProperties(vehicle, vehicleProps)
    LsCustoms:SetVehicleDetailsProperties(vehicle, vehicleProps)
    if vehicleProps["windows"] then
        for windowId = 1, 9, 1 do
            if vehicleProps["windows"][windowId] == false then
                SmashVehicleWindow(vehicle, windowId)
            end
        end
    end
    if vehicleProps["tyres"] then
        for tyreId = 1, 7, 1 do
            if vehicleProps["tyres"][tyreId] ~= false then
                SetVehicleTyreBurst(vehicle, tyreId, true, 1000)
            end
        end
    end
    if vehicleProps["doors"] then
        for doorId = 0, 5, 1 do
            if vehicleProps["doors"][doorId] ~= false then
                SetVehicleDoorBroken(vehicle, doorId - 1, true)
            end
        end
    end
	if vehicleProps["vehicleHeadLight"] then 
        SetVehicleHeadlightsColour(vehicle, vehicleProps["vehicleHeadLight"]) 
    end
    if vehicleProps["vehicleEngine"] then 
        SetVehicleEngineHealth(vehicle, tonumber(vehicleProps["vehicleEngine"])) 
    end
end

-- Scalforms
function SetScaleformParams(scaleform, data) -- Set des éléments dans un scalform
	data = data or {}
	for k,v in pairs(data) do
		PushScaleformMovieFunction(scaleform, v.name)
		if v.param then
			for _,par in pairs(v.param) do
				if math.type(par) == "integer" then
					PushScaleformMovieFunctionParameterInt(par)
				elseif type(par) == "boolean" then
					PushScaleformMovieFunctionParameterBool(par)
				elseif math.type(par) == "float" then
					PushScaleformMovieFunctionParameterFloat(par)
				elseif type(par) == "string" then
					PushScaleformMovieFunctionParameterString(par)
				end
			end
		end
		if v.func then v.func() end
		PopScaleformMovieFunctionVoid()
	end
end
function CreateScaleform(name, data) -- Créer un scalform
	if not name or string.len(name) <= 0 then return end
	local scaleform = RequestScaleformMovie(name)

	while not HasScaleformMovieLoaded(scaleform) do
		Citizen.Wait(0)
	end

	SetScaleformParams(scaleform, data)
	return scaleform
end

function GetVehicleHealth(entityVeh) -- Get la vie d'un moteur (0-100%)
	return math.floor( math.max(0, math.min(100, GetVehicleEngineHealth(entityVeh) / 10 ) ) )
end

function CreateVehicleStatsScaleformLsCustoms(cars)
    local VehicleModel = GetEntityModel(cars)
    local VehicleSpeed = GetVehicleEstimatedMaxSpeed(cars) * 1.25
    local VehicleAcceleration = GetVehicleAcceleration(cars) * 200
    local VehicleBraking = GetVehicleMaxBraking(cars) * 100
    local VehicleTraction = GetVehicleMaxTraction(cars) * 25
    local VehicleHealth = GetVehicleHealth(cars)
    return CreateScaleform("mp_car_stats_01", {{
        name = "SET_VEHICLE_INFOR_AND_STATS",
        param = {GetLabelText(GetDisplayNameFromVehicleModel(VehicleModel)), "État du véhicule: "..VehicleHealth.."%", "MPCarHUD","Annis", "Vitesse max", "Accélération", "Frein", "Suspension", VehicleSpeed, VehicleAcceleration, VehicleBraking, VehicleTraction}
    }})
end

-- Draw Text 
function DrawTextScreen(Text,Text3,Taille,Text2,Font,Justi,havetext) -- Créer un text 2D a l'écran
    SetTextFont(Font)
    SetTextScale(Taille,Taille)
    SetTextColour(255,255,255,255)
    SetTextJustification(Justi or 1)
    SetTextEntry("STRING")
    if havetext then 
        SetTextWrap(Text,Text+.1)
    end;
    AddTextComponentString(Text2)
    DrawText(Text,Text3)
end

local Multiple = .9
local PosScalform = {(10 * 0.8) * Multiple, (6 * 0.8) * Multiple, 1 * Multiple}
local function onRender(self, allButtons, currentButton)
    local currentMenu = self.Data.currentMenu

    local pPed = PlayerPedId()

	if scalLsCustoms and HasScaleformMovieLoaded(scalLsCustoms) then
        local vPos = GetEntityCoords(LsCustoms.Data.veh)
        local vHeight = GetEntityHeight(LsCustoms.Data.veh, vPos.x, vPos.y, vPos.z, true, false)
        DrawScaleformMovie_3dNonAdditive(scalLsCustoms, vPos.x, vPos.y, vPos.z + 2.4 + vHeight, GetGameplayCamRot(0), 0.0,1.0, 0.0, PosScalform[1], PosScalform[2], PosScalform[3], 0)
    end

	if LsCustoms.Price > 0 then 
		DrawTextScreen(0.5, 0.90, 1.1, "Total facture: ~b~"..(LsCustoms.Price*1.6).."$~s~. Total entreprise: ~g~"..LsCustoms.Price.."$~s~.", 4, 0)
	end

	if currentMenu == "customisation" or not currentButton then return end
	local useMult = currentMenu == "performances" and currentButton.slidemax
    local price = currentButton.prix

	if price then 
		DrawTextScreen(0.85, 0.82, 1.2, "~b~"..price.."$", 4, 0)
	end
end

LsCustoms.InMenu = false
LsCustoms.LSCustomMenu = {
	Base = { Header = {"shopui_title_supermod", "shopui_title_supermod"}, Title = "" },
	Data = { currentMenu = "customisation" },
	Events = {
		onOpened = function()
            local player = PlayerPedId()
			--[[ RequestStreamedTextureDict("shopui_title_carmod2", false)
			SetStreamedTextureDictAsNoLongerNeeded("shopui_title_carmod2") ]]
			LsCustoms.Data.loadingVehicle = true
	
			LsCustoms.Data.loadingVehicle = nil
	
			LsCustoms.Data.veh = GetVehiclePedIsIn(player, false)
	
			SetVehicleModKit(LsCustoms.Data.veh, 0)
			SetEntityInvincible(LsCustoms.Data.veh, true)

            LsCustoms.Price = 0
	
			scalLsCustoms = CreateVehicleStatsScaleformLsCustoms(LsCustoms.Data.veh)

			LsCustoms.Data.propsVeh = LsCustoms:GetVehicleProperties(LsCustoms.Data.veh)
            LsCustoms.Data.props = LsCustoms:GetVehicleProperties(LsCustoms.Data.veh)
			LsCustoms.InMenu = true
		end,
		onRender = onRender,
		onSlide = onSlide,
		onSelected = onSelected,
		onButtonSelected = onButtonSelected,
		onBack = function()
			RenderBackProperties(false)
		end,
		onExited = function()
			SetEntityInvincible(LsCustoms.Data.veh, false)
			if HasScaleformMovieLoaded(scalLsCustoms) then
				SetScaleformMovieAsNoLongerNeeded(scalLsCustoms)
				scalLsCustoms = nil
			end
			if not LsCustoms.OnInstall then 
				LsCustoms:SetVehicleProperties(LsCustoms.Data.veh, LsCustoms.Data.propsVeh)
				LsCustoms.Data = {}
			end

			LsCustoms.InMenu = false
		end
	},
	Menu = {
		["customisation"] = {
			b = {
				{ name = "Peintures", ask = "", askX = true },
				{ name = "Roues" },
				{ name = "Classiques" },
				{ name = "Customs" },
				{ name = "Bennys" },
				{ name = "Performances" },
				--{ name = "Extra" },
				{ name = "~g~Confirmer" },
			},
		},
		["transformation du véhicule"] = {
			b = function()
				local carsUdt = {}
				
				for k,v in pairs(LsCustoms.UpdateVehicle) do 
					if string.match(GetDisplayNameFromVehicleModel(LsCustoms.Data.props.model):lower(), GetDisplayNameFromVehicleModel(v.model):lower()) then 
						carsUdt[#carsUdt + 1 ] = {name = GetLabelText(GetDisplayNameFromVehicleModel(v.update)), prix = 500, update = v.update}
					end
				end 

				return carsUdt
			end,
		},
		["classiques"] = {
			b = {
				{ name = "Klaxon", prix = 80, id = 14, slidemax = function() return GetNumVehicleMods(LsCustoms.Data.veh, 14) - 1 end, customSlidenum = function() return GetVehicleMod(LsCustoms.Data.veh, 14) + 2 end },
				{ name = "Teinte des vitres", prix = 200, slidemax = {"normal", "black", "smoke black", "simple smoke", "stock", "limo"}, customSlidenum = function() return math.max(1, math.min(10, GetVehicleWindowTint(LsCustoms.Data.veh) + 1)) end },
				{ name = "Phares xenons", prix = 200, toggle = 22, checkbox = function() return IsToggleModOn(LsCustoms.Data.veh, 22) ~= false end },
				{ name = "Types de plaques", prix = 150, slidemax = {"default", "sa black", "sa blue", "sa white", "simple white", "ny white"}, customSlidenum = function() return GetVehicleNumberPlateTextIndex(LsCustoms.Data.veh) + 1 end },
				{ name = "Livery", prix = 700, slidemax = 20, customSlidenum = function() return SetVehicleLivery(LsCustoms.Data.veh) end },
				--{ name = "Couleur des phares", prix = 250, slidemax = 12 },
			}
		},
		["roues"] = {
			slidertime = 75,
			b = {
				{ name = "Type de roues", slidemax = {"Sport", "Muscle", "Lowrider", "SUV", "Offroad", "Tuner", "Moto", "High end", "Bespokes Originals", "Bespokes Smokes"}, customSlidenum = function() return GetVehicleWheelType(LsCustoms.Data.veh) + 1 end },
				{ name = "Jantes principales", prix = 500, id = 23, slidemax = function() return GetNumVehicleMods(LsCustoms.Data.veh, 23) - 1 end },
				{ name = "Jantes arrières", prix = 500, id = 24, slidemax = function() return GetNumVehicleMods(LsCustoms.Data.veh, 24) - 1 end, canSee = function() return IsThisModelABike(GetEntityModel(LsCustoms.Data.veh)) end },
				--{ name = "Pneus customs", prix = 850, customs = 23, ask = "", askX = true},
				{ name = "Couleurs des jantes", prix = 90, slidemax = 160 },
			}
		},
		["performances"] = {
			b = {
				{ name = "Suspension", prix = 400, slidemax = {"Stock", "Discount", "Street", "Sport", "Race"}, customSlidenum = function() return GetVehicleMod(LsCustoms.Data.veh, 15) + 2 end, id = 15 },
				{ name = "Transmission", prix = 500, slidemax = {"Stock","Street", "Sport", "Race"}, customSlidenum = function() return GetVehicleMod(LsCustoms.Data.veh, 13) + 2 end, id = 13 },
				{ name = "Moteur", prix = 2400, slidemax = {"Stock", "Discount", "Street", "Sport", "Race"}, customSlidenum = function() return GetVehicleMod(LsCustoms.Data.veh, 11) + 2 end, id = 11 },
				{ name = "Frein", prix = 1000, slidemax = {"Stock", "Street", "Sport", "Race"}, customSlidenum = function() return GetVehicleMod(LsCustoms.Data.veh, 12) + 2 end, id = 12 },
				{ name = "Turbo", prix = 14000, toggle = 18, checkbox = function() return IsToggleModOn(LsCustoms.Data.veh, 18) ~= false end, canSee = function() return IsThisModelACar(GetEntityModel(LsCustoms.Data.veh)) end },
			}
		},
		["peintures"] = {
			slidertime = 75,
			b = {
				{ name = "Couleur Principale" },
				{ name = "Couleur Secondaire" },
				--{ name = "Couleur Intérieur", slidemax = 158, prix = 125 },
				--{ name = "Couleur Tableau de bord", slidemax = 158, prix = 125 },
				{ name = "Nacrage", slidemax = 158, prix = 300 },
			}
		},
		["couleur principale"] = { 
            slidertime = 75, 
            b = {
				{ name = "Couleur", slidemax = 159, prix = 75 },
			},
            prix = 150 
        },
		["couleur secondaire"] = { 
            slidertime = 75, 
			b = {
				{ name = "Couleur", slidemax = 159, prix = 75 },
			},
            prix = 150 
        },
		["extra"] = {
			b = GetExtraFromVehicle
		},
		["customs"] = {
			b = function() return GetAllCustomFromVeh() end
		},
		["bennys"] = {
			b = function() return GetAllCustomFromVeh(true) end
		}
	}
}

-- BLIPS INFOS
local BLIP_INFO_DATA = {}

--[[
    Default state for blip info
]]

function ensureBlipInfo(blip)
    if blip == nil then blip = 0 end
    SetBlipAsMissionCreatorBlip(blip, true)
    if not BLIP_INFO_DATA[blip] then BLIP_INFO_DATA[blip] = {} end
    if not BLIP_INFO_DATA[blip].title then BLIP_INFO_DATA[blip].title = "" end
    if not BLIP_INFO_DATA[blip].rockstarVerified then BLIP_INFO_DATA[blip].rockstarVerified = false end
    if not BLIP_INFO_DATA[blip].info then BLIP_INFO_DATA[blip].info = {} end
    if not BLIP_INFO_DATA[blip].money then BLIP_INFO_DATA[blip].money = "" end
    if not BLIP_INFO_DATA[blip].rp then BLIP_INFO_DATA[blip].rp = "" end
    if not BLIP_INFO_DATA[blip].dict then BLIP_INFO_DATA[blip].dict = "" end
    if not BLIP_INFO_DATA[blip].tex then BLIP_INFO_DATA[blip].tex = "" end
    return BLIP_INFO_DATA[blip]
end

--[[
    Export functions, use these via an export pls
]]

function ResetBlipInfo(blip)
    BLIP_INFO_DATA[blip] = nil
end

function SetBlipInfoTitle(blip, title, rockstarVerified)
    local data = ensureBlipInfo(blip)
    data.title = title or ""
    data.rockstarVerified = rockstarVerified or false
end

function SetBlipInfoImage(blip, dict, tex)
    local data = ensureBlipInfo(blip)
    data.dict = dict or ""
    data.tex = tex or ""
end

function SetBlipInfoEconomy(blip, rp, money)
    local data = ensureBlipInfo(blip)
    data.money = tostring(money) or ""
    data.rp = tostring(rp) or ""
end

function SetBlipInfo(blip, info)
    local data = ensureBlipInfo(blip)
    data.info = info
end

function AddBlipInfoText(blip, leftText, rightText)
    local data = ensureBlipInfo(blip)
    if rightText then
        table.insert(data.info, {1, leftText or "", rightText or ""})
    else
        table.insert(data.info, {5, leftText or "", ""})
    end
end

function AddBlipInfoName(blip, leftText, rightText)
    local data = ensureBlipInfo(blip)
    table.insert(data.info, {3, leftText or "", rightText or ""})
end

function AddBlipInfoHeader(blip, leftText, rightText)
    local data = ensureBlipInfo(blip)
    table.insert(data.info, {4, leftText or "", rightText or ""})
end

function AddBlipInfoIcon(blip, leftText, rightText, iconId, iconColor, checked)
    local data = ensureBlipInfo(blip)
    table.insert(data.info, {2, leftText or "", rightText or "", iconId or 0, iconColor or 0, checked or false})
end

--[[
    All that fancy decompiled stuff I've kinda figured out
]]

local Display = 1
function UpdateDisplay()
    if PushScaleformMovieFunctionN("DISPLAY_DATA_SLOT") then
        PushScaleformMovieFunctionParameterInt(Display)
        PopScaleformMovieFunctionVoid()
    end
end

function SetColumnState(column, state)
    if PushScaleformMovieFunctionN("SHOW_COLUMN") then
        PushScaleformMovieFunctionParameterInt(column)
        PushScaleformMovieFunctionParameterBool(state)
        PopScaleformMovieFunctionVoid()
    end
end

function ShowDisplay(show)
    SetColumnState(Display, show)
end

function func_36(fParam0)
    BeginTextCommandScaleformString(fParam0)
    EndTextCommandScaleformString()
end

function SetIcon(index, title, text, icon, iconColor, completed)
    if PushScaleformMovieFunctionN("SET_DATA_SLOT") then
        PushScaleformMovieFunctionParameterInt(Display)
        PushScaleformMovieFunctionParameterInt(index)
        PushScaleformMovieFunctionParameterInt(65)
        PushScaleformMovieFunctionParameterInt(3)
        PushScaleformMovieFunctionParameterInt(2)
        PushScaleformMovieFunctionParameterInt(0)
        PushScaleformMovieFunctionParameterInt(1)
        func_36(title)
        func_36(text)
        PushScaleformMovieFunctionParameterInt(icon)
        PushScaleformMovieFunctionParameterInt(iconColor)
        PushScaleformMovieFunctionParameterBool(completed)
        PopScaleformMovieFunctionVoid()
    end
end

function SetText(index, title, text, textType)
    if PushScaleformMovieFunctionN("SET_DATA_SLOT") then
        PushScaleformMovieFunctionParameterInt(Display)
        PushScaleformMovieFunctionParameterInt(index)
        PushScaleformMovieFunctionParameterInt(65)
        PushScaleformMovieFunctionParameterInt(3)
        PushScaleformMovieFunctionParameterInt(textType or 0)
        PushScaleformMovieFunctionParameterInt(0)
        PushScaleformMovieFunctionParameterInt(0)
        func_36(title)
        func_36(text)
        PopScaleformMovieFunctionVoid()
    end
end

local _labels = 0
local _entries = 0
function ClearDisplay()
    if PushScaleformMovieFunctionN("SET_DATA_SLOT_EMPTY") then
        PushScaleformMovieFunctionParameterInt(Display)
    end
    PopScaleformMovieFunctionVoid()
    _labels = 0
    _entries = 0
end

function _label(text)
    local lbl = "LBL" .. _labels
    AddTextEntry(lbl, text)
    _labels = _labels + 1
    return lbl
end

function SetTitle(title, rockstarVerified, rp, money, dict, tex)
    if PushScaleformMovieFunctionN("SET_COLUMN_TITLE") then
        PushScaleformMovieFunctionParameterInt(Display)
        func_36("")
        func_36(_label(title))
        PushScaleformMovieFunctionParameterInt(rockstarVerified)
        PushScaleformMovieFunctionParameterString(dict)
        PushScaleformMovieFunctionParameterString(tex)
        PushScaleformMovieFunctionParameterInt(0)
        PushScaleformMovieFunctionParameterInt(0)
        if rp == "" then
            PushScaleformMovieFunctionParameterBool(0)
        else
            func_36(_label(rp))
        end
        if money == "" then
            PushScaleformMovieFunctionParameterBool(0)
        else
            func_36(_label(money))
        end
    end
    PopScaleformMovieFunctionVoid()
end

function AddText(title, desc, style)
    SetText(_entries, _label(title), _label(desc), style or 1)
    _entries = _entries + 1
end

function AddIcon(title, desc, icon, color, checked)
    SetIcon(_entries, _label(title), _label(desc), icon, color, checked)
    _entries = _entries + 1
end

-- Blips
function CreateBlips(vector3Pos, intSprite, intColor, stringText, boolRoad, floatScale, intDisplay, intAlpha, Title, Image, InfoName, Texts, InfoText, Header) -- Créer un blips
	local blip = AddBlipForCoord(vector3Pos.x, vector3Pos.y, vector3Pos.z)
	SetBlipSprite(blip, intSprite)
	SetBlipAsShortRange(blip, true)
	if intColor then 
		SetBlipColour(blip, intColor) 
	end
	if floatScale then 
		SetBlipScale(blip, floatScale) 
	end
	if boolRoad then 
		SetBlipRoute(blip, boolRoad) 
	end
	if intDisplay then 
		SetBlipDisplay(blip, intDisplay) 
	end
	if intAlpha then 
		SetBlipAlpha(blip, intAlpha) 
	end
	if stringText and (not intDisplay or intDisplay ~= 8) then
		BeginTextCommandSetBlipName("STRING")
		AddTextComponentString(stringText)
		EndTextCommandSetBlipName(blip)
	end
    if Title then
        SetBlipInfoTitle(blip, Title, false)
    end
    if Image then
        RequestStreamedTextureDict(Image[1], 1)
        while not HasStreamedTextureDictLoaded(Image[1]) do
            Wait(0)
        end
    
        SetBlipInfoImage(blip, Image[1], Image[2])
    end
    if InfoName then
        AddBlipInfoName(blip, InfoName[1], InfoName[2])
    end
    if Texts then
        for k, v in pairs (Texts) do
            AddBlipInfoText(blip, v[1], v[2])
        end
    end
    if InfoText then
        AddBlipInfoText(blip, InfoText)
    end
    if Header then
        AddBlipInfoHeader(blip, "") 
    end
	return blip
end



Citizen.CreateThread(function()
	for k,v in pairs(LsCustoms.Pos) do 
		if v.blips then 
			local blip = CreateBlips(v.pos, v.blips.display, v.blips.colour, v.blips.name, false, v.blips.size) 
		end
	end

    while true do 
        local wait = 1000
        local pPed = PlayerPedId()
        local pPos = GetEntityCoords(pPed)

        if IsPedInAnyVehicle(pPed, false) and (GetPedInVehicleSeat(GetVehiclePedIsIn(pPed, false), -1) == pPed) then 
			local dist = Vdist(pPos, -319.5214, -123.45800, 39.0169)
			local dist2 = Vdist(pPos, 474.252, -1882.9552, 26.08733)

			if ESX.PlayerData.job.name and ESX.PlayerData.job.name == "lscustoms"then 
				if dist <= 30.0 then 
					wait = 5
					ESX.ShowHelpNotification("Appuyez sur ~INPUT_CONTEXT~ pour accéder au ~b~Hayes Auto~s~.")
					if IsControlJustPressed(0, 51) then 
						CreateMenu(LsCustoms.LSCustomMenu)
						LsCustoms.LSCustomMenu.Base.Header = {"shopui_title_supermod", "shopui_title_supermod"}
					end
				elseif dist >= 30.0 then 
					if LsCustoms.InMenu then 
						CloseMenu(true)
					end
				end
			end

			if ESX.PlayerData.job.name and ESX.PlayerData.job.name == "atomic" then
				if dist2 <= 10.0 then 
					wait = 5
					ESX.ShowHelpNotification("Appuyez sur ~INPUT_CONTEXT~ pour accéder au ~b~Hayes Auto~s~.")
					if IsControlJustPressed(0, 51) then 
						CreateMenu(LsCustoms.LSCustomMenu)
						LsCustoms.LSCustomMenu.Base.Header = {"shopui_title_supermod", "shopui_title_supermod"}
					end
				elseif dist2 >= 10.0 then 
					if LsCustoms.InMenu then 
						CloseMenu(true)
					end
				end
			end 
        end
        Wait(wait)
    end
end)