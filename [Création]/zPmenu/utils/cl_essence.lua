local dT7iYDf4=5;
local L=.3*dT7iYDf4;
local WRH9=0.0005*L;
local cJoBcud=0.0002*L
local notifidfuel 
local e=0.0001*L;
local B6zKxgVs
local O3_X={
	vector3(49.4187, 2778.793, 58.043),
	vector3(263.894, 2606.463, 44.983),
	vector3(1039.958, 2671.134, 39.550),
	vector3(1207.260, 2660.175, 37.899),
	vector3(2539.685, 2594.192, 37.944),
	vector3(2679.858, 3263.946, 55.240),
	vector3(2005.055, 3773.887, 32.403),
	vector3(1687.156, 4929.392, 42.078),
	vector3(1701.314, 6416.028, 32.763),
	vector3(179.857, 6602.839, 31.868),
	vector3(-94.4619, 6419.594, 31.489),
	vector3(-2554.996, 2334.40, 33.078),
	vector3(-1800.375, 803.661, 138.651),
	vector3(-1437.622, -276.747, 46.207),
	vector3(-2096.243, -320.286, 13.168),
	vector3(-724.619, -935.1631, 19.213),
	vector3(-526.019, -1211.003, 18.184),
	vector3(-70.2148, -1761.792, 29.534),
	vector3(265.648, -1261.309, 29.292),
	vector3(819.653, -1028.846, 26.403),
	vector3(1208.951, -1402.567,35.224),
	vector3(1181.381, -330.847, 69.316),
	vector3(620.843, 269.100, 103.089),
	vector3(2581.321, 362.039, 108.468),
	vector3(176.631, -1562.025, 29.263),
	vector3(-319.292, -1471.715, 30.549),
	vector3(1784.324, 3330.55, 41.253)
}

RegisterNetEvent("cl_fuel:refuelVeh")
AddEventHandler("cl_fuel:refuelVeh",function(v3,ihKb)
	local JGSK=GetClosestVehicle2(GetEntityCoords(GetPlayerPed(-1)),5.0,ihKb)
	if not JGSK or not DoesEntityExist(JGSK)then 
		ShowAboveRadarMessage("~r~Le véhicule n'a pas été trouvé.")
		return 
	end
	SetVehicleEngineOn(JGSK,false,true,true)
	SetVehicleUndriveable(JGSK,true)
	local rA5U=math.floor(GetVehicleHandlingFloat(JGSK,"CHandlingData","fPetrolTankVolume"))
	local Uc06=math.floor(GetVehicleFuelLevel(JGSK))
	while(Uc06+v3)>GetVehicleFuelLevel(JGSK)and not IsVehicleEngineOn(JGSK)and rA5U>math.floor(Uc06+v3-1)do 
		SetVehicleFuelLevel(JGSK,GetVehicleFuelLevel(JGSK)+1)
		Citizen.Wait(1000)
	end;
	SetVehicleUndriveable(JGSK,false)
	SetVehicleEngineOn(JGSK,true,true)
	ShowAboveRadarMessage("~o~Globe Oil\n~s~Le plein du véhicule est terminé.")
end)

local function DVs8kf2w(lcBL,DHPxI,dx,RRuSHnxf)
	local mcYOuT=lcBL.Data.veh
	if not mcYOuT or not DoesEntityExist(mcYOuT)or IsVehicleEngineOn(mcYOuT)or not IsVehicleDriveable(mcYOuT)then 
		ShowAboveRadarMessage("~r~Le véhicule n'a pas été trouvé.")
		lcBL:CloseMenu()
		return 
	end
	local Rr,scRP0=math.floor(GetVehicleFuelLevel(mcYOuT)),math.floor(GetVehicleHandlingFloat(mcYOuT,"CHandlingData","fPetrolTankVolume"))
		if RRuSHnxf==1 then 
			if notifidfuel then 
				RemoveNotification(notifidfuel)
			end
			notifidfuel = ShowAboveRadarMessage("~o~Globe Oil\n~s~Réservoir du véhicule: ~b~"..Rr.."L~s~.")
		elseif RRuSHnxf==2 or RRuSHnxf==3 then
			local AI0R2TQ6=RRuSHnxf==2 and math.floor(scRP0-Rr)or math.max(.0,math.min(scRP0,math.floor(tonumber(dx.slidename))))
			AI0R2TQ6=Rr+AI0R2TQ6 >scRP0 and scRP0- (Rr+AI0R2TQ6)or AI0R2TQ6;
	if AI0R2TQ6 <1 then
		ShowAboveRadarMessage("~r~Le réservoir est trop remplit. "..scRP0 .."/"..scRP0 .."L")return end
		TriggerServerEvent('fuel:pay', AI0R2TQ6)
		ShowAboveRadarMessage("~o~Globe Oil\n~s~Vous venez de payez ~b~"..AI0R2TQ6.."$~s~ pour ~b~"..AI0R2TQ6.."L~s~.")
		createProgressBar("Remplissage du réservoir",254, 115, 0,120, AI0R2TQ6*1000)
		TriggerEvent('cl_fuel:refuelVeh', AI0R2TQ6, GetEntityModel(mcYOuT))
		lcBL:CloseMenu()
	end 
end

local function vms5(yA)
	if yA.Data then 
		if not yA.Data.veh or not DoesEntityExist(yA.Data.veh)or GetIsVehicleEngineRunning(yA.Data.veh)then 
			return 
		end
		local XmVolesU=GetEntityCoords(yA.Data.veh)
			DrawMarker(0,XmVolesU+vector3(.0,.0,1.5),vector3(.0,.0,.0),vector3(0.0,0.0,0.0),1.0,1.0,0.7,255,185,0,150,true,true,true,false,false,false,false)
		end 
	end
	local M7={Base = { Header = {"shopui_title_gasstation", "shopui_title_gasstation"},HeaderColor = {255,255,255}},Data={currentMenu="station essence"},
	Events={onSelected=DVs8kf2w,onRender=vms5,onOpened=function(eZ0l3ch,W_63_9)
	local h9dyA_4T=GetClosestVehicle2(GetEntityCoords(GetPlayerPed(-1)),5.0)
		if h9dyA_4T and DoesEntityExist(h9dyA_4T)then
			W_63_9.Data.veh=h9dyA_4T;
			SetVehicleEngineOn(h9dyA_4T,false,true,true)
		end 
	end},
	Menu={
		["station essence"] = {
			b = {
				{name="Consulter le réservoir du véhicule", ask = ">", askX  = true, Description = "Consulter le taux d'essence dans le véhicule."},
				{name="Faire le plein du véhicule", ask = ">", askX  = true, Description = "Faire le plein maximale du véhicule."},
				{name="Faire le plein du véhicule en litres",slidemax={5,10,15,20,25,30}, Description = "Faire le plein du véhicule en litres."}
			}
		}
	}
}

function FuelInitialize()
	for oh,DZXGTh in pairs(O3_X)do
		createBlip(DZXGTh,361,1,"Station d'essence",false,0.6)
	end
end

FuelInitialize()

Citizen.CreateThread(function()
	while true do 
		local attente = 2000
		local Su9Koz=GetPlayerPed(-1)
		local Uk7e,KwQCk_G,ptZa=GetPlayerPed(-1),GetEntityCoords(Su9Koz),GetVehiclePedIsIn(Su9Koz, false)
		if IsPedInAnyVehicle(Su9Koz, false) then
			local PEqsd,iSj=GetVehicleFuelLevel(ptZa),GetEntityModel(ptZa)
			if PEqsd>0 and IsVehicleEngineOn(ptZa)and(IsThisModelACar(iSj)or IsThisModelABike(iSj)or IsThisModelAHeli(iSj))then 
				local attente = 2150
				local iXxD6s=math.floor(GetEntitySpeed(ptZa)*3.6)
				PEqsd=PEqsd-(iXxD6s*WRH9)-(GetVehicleAcceleration(ptZa)*cJoBcud)-(GetVehicleMaxTraction(ptZa)*e)
				PEqsd=PEqsd>0 and PEqsd or 0
				SetVehicleFuelLevel(ptZa,PEqsd)
			end 
		end
		for oiY,FsYIVlkf in pairs(O3_X)do
			if GetDistanceBetweenCoords(FsYIVlkf,KwQCk_G,true)<7 then 
				attente = 5
				B6zKxgVs=oiY 
			elseif B6zKxgVs==oiY then 
				B6zKxgVs=nil;
				ClearHelp(-1)
			end 
		end
		if B6zKxgVs then
			attente = 5
			DrawTopNotification("Appuyez sur ~INPUT_CONTEXT~ pour accéder à ~o~la station essence~w~.")
			if IsControlJustPressed(0,51)then 
				TriggerEvent("randPickupAnim")
				CreateMenu(M7)
			end 
		end
		Wait(attente)
	end
end)

local vm5 = false
function Utils_UserFuelPetrolTank(bJfct,DsXd)
    local OhuFpq_N,Dzg=bJfct.Ped,bJfct.Pos;
    if vm5 or IsPedInAnyVehicle(OhuFpq_N, -1) then return end
    local _4O=DsXd
    if _4O and DoesEntityExist(_4O) and (GetEntityBoneIndexByName(_4O,"petroltank")==-1 and GetDistanceBetweenCoords(Dzg,GetEntityCoords(_4O),true)<2.5 or GetDistanceBetweenCoords(Dzg,GetWorldPositionOfEntityBone(_4O,GetEntityBoneIndexByName(_4O,"petroltank")),true)<2)then
        FreezeEntityPosition(OhuFpq_N,true)
        SetBlockingOfNonTemporaryEvents(OhuFpq_N,true)
        forceAnim({"weapon@w_sp_jerrycan","fire"},47)
        GiveWeaponToPed(OhuFpq_N,GetHashKey("WEAPON_PETROLCAN"),100,false,true)
        SetCurrentPedWeapon(OhuFpq_N,GetHashKey("WEAPON_PETROLCAN"),true)
        createProgressBar("Remplissage du réservoir",0, 80, 125,200, GetVehicleHandlingFloat(_4O,"CHandlingData","fPetrolTankVolume")*150)
        SetVehicleEngineOn(_4O,false,true)
        SetVehicleUndriveable(_4O,true)
        vms5=true
        SetTimeout(10000,function()
            vms5=false
            SetVehicleFuelLevel(_4O,GetVehicleHandlingFloat(_4O,"CHandlingData","fPetrolTankVolume"))
            SetVehicleUndriveable(_4O,false)
            SetBlockingOfNonTemporaryEvents(OhuFpq_N,false)
            ShowAboveRadarMessage("~b~Vous avez fait le plein du véhicule.")
            RemoveWeaponFromPed(OhuFpq_N,GetHashKey("WEAPON_PETROLCAN"))
            SetCurrentPedWeapon(OhuFpq_N,GetHashKey("WEAPON_UNARMED"),true)
            FreezeEntityPosition(OhuFpq_N,false)
			ClearPedTasks(OhuFpq_N)
			TriggerServerEvent("clp:removeitem", "essence", 1)
        end)
    end 
end;

RegisterNetEvent("clp:usessence")
AddEventHandler("clp:usessence", function()
    local vms5=GetPlayerPed(-1)
    local L = LocalPlayer()
    local pVeh = GetClosestVehicle2(GetEntityCoords(vms5),3.0)
    if pVeh then 
        Utils_UserFuelPetrolTank(L, pVeh)
    else
        print(pVeh)
    end
end)

