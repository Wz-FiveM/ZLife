Weaopnsdqsd={}
local B6zKxgVs={
    {spawnPos={x=758.04,y=-1659.92,z=29.48,a=356.96},deliveryPos=vector3(912.8, -1564.04, 30.76)},
    {spawnPos={x=1110.24,y=-782.16,z=58.28,a=359.25},deliveryPos=vector3(1373.76, -739.76, 67.24)},
    {spawnPos={x=-290.72,y=-2447.72,z=6.0,a=230.66},deliveryPos=vector3(-344.24, -2633.88, 6.0)},
    {spawnPos={x=-339.84,  y = 6248.56,  z = 31.48,a=314.67},deliveryPos=vector3(-166.4, 6272.24, 31.48)},
    {spawnPos={x=-1509.06,y=4695.59,z=36.75,a=77.73},deliveryPos=vector3(-1631.42,4738.65,52.16)},
    {spawnPos={x=2270.94,y=2034.41,z=128.84,a=51.49},deliveryPos=vector3(2173.24, 2177.48, 116.68)},
    {spawnPos={x=-687.2,y=2186.44,z=101.12,a=204.81},deliveryPos=vector3(-554.6, 2092.28, 148.08)},
    {spawnPos={x=2127.97,y=3273.94,z=45.0,a=83.98},deliveryPos=vector3(2049.96,3446.54,42.81)},
    {spawnPos={x=-1409.56,y=2693.56,z=4.72,a=280.58},deliveryPos=vector3(-1135.64, 2855.0, 15.0)}
}

local O3_X={"csb_mweather","s_m_y_blackops_01","s_m_y_ammucity_01"}
local DVs8kf2w={"mule4","mule4","mule4","mule4"}
local vms5={}
local listW = {}
local M7
local v3=0;
local ihKb=1;
local JGSK;

local function rA5U()
    for Rr,scRP0 in pairs(O3_X)do 
        RequestAndWaitModel(scRP0)
    end;
    v3=CreateGroup()
end

local function Uc06(AI0R2TQ6)
    for yA,XmVolesU in pairs(O3_X)do 
        SetModelAsNoLongerNeeded(XmVolesU)
    end
    for eZ0l3ch,W_63_9 in pairs(DVs8kf2w)do 
        SetModelAsNoLongerNeeded(W_63_9)
    end
    if not AI0R2TQ6 then 
        for h9dyA_4T,oh in pairs(vms5)do 
            DeleteEntity(oh)
        end
        DeleteEntity(M7)
    else
        for DZXGTh,Su9Koz in pairs(vms5)do 
            SetEntityAsNoLongerNeeded(Su9Koz)
        end;
        SetEntityAsNoLongerNeeded(M7)
    end;
    RemoveGroup(v3)
    if JGSK then 
        RemoveBlip(JGSK)
        JGSK=nil 
    end
    vms5={}M7=nil;v3=nil 
end

local function lcBL(Uk7e)
    local KwQCk_G = B6zKxgVs[Uk7e]
    local ptZa=DVs8kf2w[math.random(1,#DVs8kf2w)]
    local PEqsd = KwQCk_G.spawnPos;
    RequestAndWaitModel(ptZa)
    local iSj=CreateVehicle(ptZa,PEqsd.x, PEqsd.y, PEqsd.z, PEqsd.a,true,true)
    SetEntityInvincible(iSj,true)
    SetVehicleOnGroundProperly(iSj,5.0)
    SetVehicleModColor_1(iSj,0)
    SetVehicleModColor_2(iSj,0)
    SetEntityAsMissionEntity(iSj,true,true)
    SetVehicleIsConsideredByPlayer(iSj,false)
    SetVehicleStrong(iSj,true)
    SetVehicleExplodesOnHighExplosionDamage(iSj,false)
    SetVehicleCanBreak(iSj,true)
    SetVehicleTyresCanBurst(iSj,false)
    JGSK=AddBlipForEntity(iSj)
    SetBlipSprite(JGSK,532)
    SetBlipColour(JGSK,47)
    SetBlipScale(JGSK,0.5)
    SetBlipAsShortRange(JGSK,true)
    M7=iSj
    for iXxD6s=1,ihKb do
    local oiY=CreatePedInsideVehicle(iSj,4,O3_X[iXxD6s],iXxD6s-2,true,true)
    SetEntityInvincible(oiY,true)
    SetBlockingOfNonTemporaryEvents(oiY,true)
    TaskSetBlockingOfNonTemporaryEvents(oiY,true)
    SetPedRandomComponentVariation(oiY,true)
    SetPedRandomProps(oiY)
    SetDriverAbility(oiY,0.5)
    SetPedConfigFlag(oiY,116,true)
    SetPedConfigFlag(oiY,118,true)
    vms5[#vms5+1]=oiY
        if v3 ~=0 then 
            if iXxD6s==1 then 
                SetPedAsGroupLeader(oiY,v3)
            else
                SetPedAsGroupMember(oiY,v3)
                GiveWeaponToPed(oiY,GetHashKey("WEAPON_ASSAULTRIFLE"),10,false,1)
            end 
        end 
    end 
end

local function DHPxI(HLXS0Q_)
    rA5U()
    Wait(2500)
    lcBL(HLXS0Q_)
    local Kw=vms5[1]
    local nvaIsNv7 = B6zKxgVs[HLXS0Q_]
    local vDnoL55 = nvaIsNv7.deliveryPos
    TaskVehicleDriveToCoordLongrange(Kw,M7,vDnoL55,12.0,1076369579,8.0)
    while GetScriptTaskStatus(Kw,0x21d33957)~=7 do 
        Wait(1000)
    end;
    if GetDistanceBetweenCoords(vDnoL55,GetEntityCoords(M7))>16 then 
        Uc06(true)
        return 
    end
    TaskLeaveVehicle(Kw,M7,0)
    for FT=2,ihKb do 
        TaskLeaveVehicle(vms5[FT],M7,1)
    end;
    local xlAK=GetEntityModel(M7)
    local zr1y,Hs=GetModelDimensions(xlAK)local jk=-vec3(zr1y.x+Hs.x,Hs.y,0.0)
    local qzSFyIO=GetOffsetFromEntityInWorldCoords(M7,jk)
    for YVLXYq=2,ihKb do
        TaskWanderInArea(vms5[YVLXYq],qzSFyIO,8.0,1.0,15.0)
        GiveWeaponToPed(vms5[YVLXYq],GetHashKey("WEAPON_ASSAULTRIFLE"),10,false,1)
    end
    TaskGoToCoordAnyMeans(Kw,qzSFyIO,1.0,0,0)
    Wait(0)
    while GetScriptTaskStatus(Kw,0x93399e79)~=7 do 
        Wait(1000)
    end;
    if GetDistanceBetweenCoords(qzSFyIO,GetEntityCoords(Kw))>8 then 
        Uc06(true)
        return 
    end
    TaskTurnPedToFaceEntity(Kw,M7,-1)
    SetVehicleDoorOpen(M7,2,0,0)
    SetVehicleDoorOpen(M7,3,0,0)Wait(2000)
    local Z65="missbigscore2aig_7@driver"
    RequestAndWaitDict(Z65)

    RequestModel(listW.hash)
    while not HasModelLoaded(listW.hash) do 
        Wait(10) 
    end 
    for bJfct=1,HLXS0Q_ do
        TaskPlayAnim(Kw,Z65,"carry_from_van",8.0,-4.0,2000,1,0,0,0,0)
        Wait(2000)
    end
    RemoveAnimDict(Z65)
    local veh = CreateVehicle(listW.hash, qzSFyIO-GetEntityForwardVector(M7)*4, GetEntityHeading(M7), 1, 0)
    ShowAboveRadarMessage("Votre véhicule: ~b~"..listW.name.." ~s~viens de vous être livré, crochetez le!")
    SetVehicleDoorsLocked(veh, 2)
    SetVehicleDoorsLockedForAllPlayers(veh, true)
    SetVehicleHasBeenOwnedByPlayer(veh,false)
    SetVehicleDoorShut(M7,2,0)
    SetVehicleDoorShut(M7,3,0)
    for OhuFpq_N=1,ihKb do
        TaskWanderInArea(vms5[OhuFpq_N],qzSFyIO,8.0,1.0,15.0)
    end;
    TriggerEvent('persistent-vehicles/register-vehicle', veh)
    SetVehicleDoorShut(M7,3)
    SetVehicleDoorShut(M7,2)
    Wait(1000*30)
    for Dzg,_4O in pairs(vms5)do 
        TaskEnterVehicle(_4O,M7,-1,Dzg-2,2.0,1,0)
    end;
    local umyCNfj=GetGameTimer()
    while GetPedInVehicleSeat(M7,-1)==0 and GetPedInVehicleSeat(M7,0)and umyCNfj+6000 >GetGameTimer()do 
        Wait(1000)
    end
    TaskVehicleDriveToCoordLongrange(Kw,M7,vec3(0.0,0.0,0.0),12.0,1076369579,8.0)
    listW = {
        hash = nil,
        name = nil,
        price = 0,
    }
    SetTimeout(1000*20,function()
        Uc06(true)
    end)
end;

local listvehs = {
    {'youga3', 'Youga Classic 4x4', 17000},
    {'sultan2', 'Sultan custom', 20400},
    {'freecrawler', 'Freecrawler', 20300},
    {'oracle', 'Oracle', 27400},
    {'rebel2', 'Rebel', 15000},
    {'sandking', 'Sandking XL', 49550},
    {'kuruma', 'Kuruma', 30000},
    {'buffalo2', 'Buffalo Sport', 30000},
    {'peyote', 'Peyote', 10260},
    {'baller2', 'Baller 2', 25000},
    {'moonbeam', 'Moon Beam', 10030},
    {'rumpo', 'Rumpo', 17600},
    {'bobcatxl', 'Bobcat XL', 10500},
    {'gburrito2', 'Gang Burrito', 15000},
    {'cliffhanger', 'Cliffhanger', 5500},
    {'enduro', 'Enduro', 3500},
    {'sanchez2', 'Sanchez 2', 3300},
    {'daemon2', 'Daemon custom', 9500},
    {'zombieb', 'Zombie chopper', 9000},
}

local function dx()
    local C={}
    for fLI2zRe,_Fr2YU in pairs(listvehs)do 
        C[#C+1]={name=_Fr2YU[2],price = math.ceil(_Fr2YU[3] * 1.2), hash = _Fr2YU[1],}
    end;
    return C 
end

local function OnSelected(Xfn, U,Ebsw, UlikV, JtAjijkG)
    local s=Ebsw.name:lower()
	local MenuSelect = U.currentMenu
    local m = MenuSelect
    if m =="magasin"then 
        local o5sms=GetClockHours()
        if o5sms<21 and o5sms>6 then
            ShowAboveRadarMessage("~r~Vous ne pouvez pas faire une livraison de jour.")
            return 
        end
        local JQi1jg,wVzn=GetPlayerPed(-1)
		for zC,pfZ3SPy_ in pairs(B6zKxgVs)do
            if GetDistanceBetweenCoords(pfZ3SPy_.deliveryPos,GetEntityCoords(JQi1jg))<32 then 
                wVzn=zC;
                break 
            end 
        end;
        if not wVzn then
            ShowAboveRadarMessage("~r~Vous devez faire votre commande sur un point de livraison.")
            return 
        end
        listW = {
            hash = Ebsw.hash,
            name = Ebsw.name,
            price = Ebsw.price,
        }
        if listW.hash ~= nil then 
            TriggerServerEvent("clp:removemoney", listW.price)
            DHPxI(wVzn)
            Xfn:CloseMenu()
        end
	end 
end

local mcYOuT={
    Base={ Title="Reseller de véhicule"},
    Data={currentMenu="magasin"},
    Events={onSelected=OnSelected},
    Menu={
        ["magasin"]={
            b=dx
        }
    }
}

RegisterCommand("livraisonveh",function()
    local JQi1jg,wVzn=GetPlayerPed(-1)
    for zC,pfZ3SPy_ in pairs(B6zKxgVs)do
        if GetDistanceBetweenCoords(pfZ3SPy_.deliveryPos,GetEntityCoords(JQi1jg))<32 then 
            wVzn=zC;
            break 
        end 
    end;
    if not wVzn then
        return 
    end
    CreateMenu(mcYOuT)
end)