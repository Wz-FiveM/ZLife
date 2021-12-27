
local mLibs         = exports["c_divers"]
local progBar       = (Config.UseProgBars and exports["progbars"] or false)
local Vector        = mLibs:Vector()
local Scenes        = mLibs:SynchronisedScene()
local sceneObjects  = {}
local SlingNextFrame = false
local MarketAccess   = false
local StopInfluence  = false

local _print = print
local print = function(...)
  if Config.Debug then
    _print(...)
  end
end

vDist = function(v1,v2)  
  if not v1 or not v2 or not v1.x or not v2.x or not v1.z or not v2.z then return 0; end
  return math.sqrt( ((v1.x - v2.x)*(v1.x-v2.x)) + ((v1.y - v2.y)*(v1.y-v2.y)) + ((v1.z-v2.z)*(v1.z-v2.z)) ) 
end

ShowNotification = function(msg)
  AddTextEntry('TerritoriesNotify', msg)
  SetNotificationTextEntry('TerritoriesNotify')
  DrawNotification(false, true)
end

TriggerEvent('instance:registerType', 'laboratoir')
TriggerEvent('instance:registerType', 'property')

Start = function()
    GetFramework()
    PlayerData = GetPlayerData()
    Wait(5000)
    TriggerServerEvent('Territories:PlayerLogin')
    while not ModStart do Wait(0); end
    Update()
end

local notifTerriId

RegisterControlKey("zoneinfo","Obtenir les informations d'une zone","",function()
  local closest = GetClosestZone()
  local area = Territories[closest]
  local dead = DeathCheck(lastZone)
  if area then 
    if notifTerriId then 
      RemoveNotification(notifTerriId)
    end
    notifTerriId = ShowAboveRadarMessage("~s~Zone : ~g~"..closest.."\n~s~Control : ~g~"..area.control:sub(1,1):upper()..area.control:sub(2).."\n~s~Influence : ~g~"..math.floor(area.influence).."%")
  else 
    if notifTerriId then 
      RemoveNotification(notifTerriId)
    end
    notifTerriId = ShowAboveRadarMessage("~r~Aucune zone n'est défini ici.")
  end
end)

RegisterCommand("zoneinfo", function()
  local closest = GetClosestZone()
  local area = Territories[closest]
  local dead = DeathCheck(lastZone)
  if area then 
    if notifTerriId then 
      RemoveNotification(notifTerriId)
    end
    notifTerriId = ShowAboveRadarMessage("~s~Zone : ~g~"..closest.."\n~s~Control : ~g~"..area.control:sub(1,1):upper()..area.control:sub(2).."\n~s~Influence : ~g~"..math.floor(area.influence).."%")
  else 
    if notifTerriId then 
      RemoveNotification(notifTerriId)
    end
    notifTerriId = ShowAboveRadarMessage("~r~Aucune zone n'est défini ici.")
  end
end)

TableCopy = function(tab)
  local r = {}
  for k,v in pairs(tab) do
    if type(v) == "table" then
      r[k] = TableCopy(v)
    else
      r[k] = v
    end
  end
  return r
end

local inzone=false
local inzone1=false

Update = function()
  --[[ if Config.ShowDebugText then    
    testText =  Utils.drawTextTemplate()
    testText.x = 0.95
    testText.y = 0.90
  end ]]

  while true do
    attente = 500
    local closest = GetClosestZone()
    local area = Territories[closest]
    local dead = DeathCheck(lastZone)
    
    if not dead then
      CheckLocation(closest)

    else
      if lastZone then
        if PlayerData.job and PlayerData.job.name and GangLookup[PlayerData.job.name] then
          TriggerServerEvent('Territories:LeaveZone',lastZone,PlayerData.job.name)
          lastZone = false
        elseif PlayerData.org and PlayerData.org.name and GangLookup[PlayerData.org.name] then
          TriggerServerEvent('Territories:LeaveZone',lastZone,PlayerData.org.name)
          lastZone = false
        end  
      end 
    end

    if inzone or inzone1 then 
      attente = 1
    end

    Wait(attente)
  end
end

local GetKeyUp = function(key) return IsControlJustReleased(0,key); end

local prisezonetrue = false
local TimeAtack = 60*1000*8.0

RegisterNetEvent('alertegang')
AddEventHandler('alertegang', function(closest)
		ShowAboveRadarMessage("~b~Guetteur~n~~w~Des personnes sont entrain ~r~d'attaquer~s~ notre ~r~Zone~s~ ! (~b~"..closest.."~s~)")
end)
RegisterNetEvent('alertegangat')
AddEventHandler('alertegangat', function(closest)
    ShowAboveRadarMessage("~b~Informateur~n~~w~Nous sommes entrain ~r~d'attaquer~s~ une zone~s~ ! (~b~"..closest.."~s~)")
end)

CheckLocation = function(closest)
  local area   = Territories[closest]
  local plyPed = GetPlayerPed(-1)
  local plyPos = GetEntityCoords(plyPed)
  local plyHp  = GetEntityHealth(plyPed)
  if closest then
    if plyHp > 100 then 
      if not lastZone or lastZone ~= closest then
        if lastZone then
          TriggerServerEvent('Territories:LeaveZone',lastZone,PlayerData.job.name)
        end
        if not StopInfluence then
          lastZone = closest
          if PlayerData.job and PlayerData.job.name and GangLookup[PlayerData.job.name] and GetSelectedPedWeapon(plyPed)==GetHashKey("WEAPON_MOLOTOV") and not prisezonetrue then
              prisezonetrue = true
              TriggerServerEvent('Territories:EnterZone',closest,PlayerData.job.name)
          elseif PlayerData.org and PlayerData.org.name and GangLookup[PlayerData.org.name] and GetSelectedPedWeapon(plyPed)==GetHashKey("WEAPON_MOLOTOV") and not prisezonetrue then
              prisezonetrue = true
              ESX.DrawMissionText("Vous êtes entrain de capturer la zone. (~g~"..closest.."~s~ / ~g~"..area.control.."~s~)", 20000)
              PrepareMusicEvent("RH2A_MISSION_START")
              TriggerMusicEvent("RH2A_MISSION_START")
              ESX.AddTimerBar("Capture en cours:",{endTime=GetGameTimer()+TimeAtack})
              PlaySoundFrontend(-1, "Enter_Area", "DLC_Lowrider_Relay_Race_Sounds", 0)
              TriggerServerEvent('Territories:EnterZone',closest,PlayerData.org.name)
              TriggerServerEvent('alertegabng', area.control, closest)
              TriggerServerEvent('alertegabngat', PlayerData.org.name, closest)
          end
        end
      else
        if lastZone and StopInfluence then     
          if PlayerData.job and PlayerData.job.name and GangLookup[PlayerData.job.name] and prisezonetrue then
            prisezonetrue = false
            notifshootingafterenter = false
            TriggerServerEvent('Territories:LeaveZone',lastZone,PlayerData.job.name)
          elseif PlayerData.org and PlayerData.org.name and GangLookup[PlayerData.org.name] and prisezonetrue then
            prisezonetrue = false
            notifshootingafterenter = false
            ESX.DrawMissionText("~r~Vous avez fui la zone.", 5000)
            ESX.RemoveTimerBar()
            PrepareMusicEvent("MP_MC_ASSAULT_ADV_STOP")
            TriggerMusicEvent("MP_MC_ASSAULT_ADV_STOP")
            PlaySoundFrontend(-1, "Out_Of_Area", "DLC_Lowrider_Relay_Race_Sounds", 0)
            TriggerServerEvent('Territories:LeaveZone',lastZone,PlayerData.org.name)
          end   
        end
      end
    end

    if area.control == PlayerData.job.name or (PlayerData.org and PlayerData.org.name == area.control) then
      if area.actions and area.actions.entry then 
        if vDist(plyPos,area.actions.entry.location) < Config.InteractDist then
          inzone=true
          ESX.ShowHelpNotification(area.actions.entry.helpText)
          if GetKeyUp(Config.InteractControl) then
            InsideInterior = area
            mLibs:TeleportPlayer(InsideInterior.actions.exit.location)
            TriggerEvent('instance:create', 'laboratoir')
          end
        elseif vDist(plyPos,area.actions.entry.location) > Config.InteractDist then 
          inzone=false
        end
      end

      if ((Config.SlingByHotkey and GetKeyUp(Config.SlingDrugsControl)) or SlingNextFrame) and not CurSlinging then
        SlingNextFrame = false
        SlingDrugs(area,closest)
      end
    end

    if not InsideInterior then
      if vDist(plyPos,area.actions.exit.location) < Config.InteractDist then
        inzone1=true
        ESX.ShowHelpNotification(area.actions.exit.helpText)
        if GetKeyUp(Config.InteractControl) then
          InsideInterior = area
          mLibs:TeleportPlayer(InsideInterior.actions.entry.location)
          TriggerEvent('instance:close')
          SetEntityVisible(GetPlayerPed(-1), true, false)
        end
      elseif vDist(plyPos,area.actions.exit.location) > Config.InteractDist then 
        inzone1=false
      end
    end
  else
    if lastZone then
      if PlayerData.job and PlayerData.job.name and GangLookup[PlayerData.job.name] and prisezonetrue then
        prisezonetrue = false
        notifshootingafterenter = false
        TriggerServerEvent('Territories:LeaveZone',lastZone,PlayerData.job.name)
      elseif PlayerData.org and PlayerData.org.name and GangLookup[PlayerData.org.name] and prisezonetrue then
        prisezonetrue = false
        notifshootingafterenter = false
        ESX.DrawMissionText("~r~Vous avez fui la zone.", 5000)
        ESX.RemoveTimerBar()
        PrepareMusicEvent("MP_MC_ASSAULT_ADV_STOP")
        TriggerMusicEvent("MP_MC_ASSAULT_ADV_STOP")
        PlaySoundFrontend(-1, "Out_Of_Area", "DLC_Lowrider_Relay_Race_Sounds", 0)
        TriggerServerEvent('Territories:LeaveZone',lastZone,PlayerData.org.name)
      end   
      lastZone = false
    end
    if not InsideInterior then
      print=false
      local closestExit,exitDist
      for k,v in pairs(Territories) do
        local exit = v.actions.exit.location
        local dist = vDist(plyPos,exit)
        if not exitDist or dist < exitDist then
          closestExit = k
          exitDist = dist
        end
      end

      if exitDist and exitDist < Config.InteractDist then
        inzone=true
        ESX.ShowHelpNotification(Territories[closestExit].actions.exit.helpText)
        if GetKeyUp(Config.InteractControl) then
          TriggerEvent('instance:create', 'laboratoir')
          mLibs:TeleportPlayer(Territories[closestExit].actions.entry.location)
          InsideInterior = nil          
        end
      elseif exitDist > Config.InteractDist then 
        inzone=false
      end
    end
  end

  if InsideInterior then    
    inzone1=true
    local exitDist = vDist(plyPos,InsideInterior.actions.exit.location)  
    if exitDist and exitDist < Config.InteractDist then
      ESX.ShowHelpNotification(InsideInterior.actions.exit.helpText)
      if GetKeyUp(Config.InteractControl) then
        TriggerEvent('instance:close')
        SetEntityVisible(GetPlayerPed(-1), true, false)
        mLibs:TeleportPlayer(InsideInterior.actions.entry.location)
        InsideInterior = nil          
      end
    else
      local closestAct,actDist = GetClosestAction(InsideInterior)
      if actDist < Config.InteractDist then
        inzone=true
        ESX.ShowHelpNotification(InsideInterior.actions[closestAct].helpText)
        if GetKeyUp(Config.InteractControl) then
          SceneHandler(InsideInterior.actions[closestAct])
        end
      end
    end
  end
end

local shooting = false
local notifshootingafterenter = false

local startTime
SceneHandler = function(action)
  local hasItem,itemLabel = not action.requireItem,''
  if action.requireItem then
    local plyData = ESX.GetPlayerData()
    for k,v in pairs(plyData.inventory) do
      if v.name == action.requireItem then
        hasItem = (v.count >= action.requireRate)
        itemLabel = v.label
      end
    end
  elseif action.requireCash then
    hasItem = false
    itemLabel = "Dirty Money"
    local plyData = ESX.GetPlayerData()
    for k,v in pairs(plyData.accounts) do
      if v.name == Config.DirtyAccount then
        hasItem = (v.money and v.money >= action.requireCash)
      end
    end
  end

  if hasItem then
    local plyPed = GetPlayerPed(-1)

    local sceneType = action.act
    local doScene = action.scene
    local actPos = action.location - action.offset
    local actRot = action.rotation

    local animDict = SceneDicts[sceneType][doScene]
    local actItems = SceneItems[sceneType][doScene]
    local actAnims = SceneAnims[sceneType][doScene]
    local plyAnim = PlayerAnims[sceneType][doScene]

    while not HasAnimDictLoaded(animDict) do RequestAnimDict(animDict); Wait(0); end

    local count = 1
    local objectCount = 0
    for k,v in pairs(actItems) do
      local hash = GetHashKey(v)
      while not HasModelLoaded(hash) do RequestModel(hash); Wait(0); end
      sceneObjects[k] = CreateObject(hash,actPos,true)
      SetModelAsNoLongerNeeded(hash)
      objectCount = objectCount + 1
      while not DoesEntityExist(sceneObjects[k]) do Wait(0); end
      SetEntityCollision(sceneObjects[k],false,false)
    end

    local scenes = {}
    local sceneConfig = Scenes.SceneConfig(actPos,actRot,2,false,false,1.0,0,1.0)

    for i=1,math.max(1,math.ceil(objectCount/3)),1 do
      scenes[i] = Scenes.Create(sceneConfig)
    end

    local pedConfig = Scenes.PedConfig(plyPed,scenes[1],animDict,plyAnim)
    Scenes.AddPed(pedConfig)

    for k,animation in pairs(actAnims) do      
      local targetScene = scenes[math.ceil(count/3)]
      local entConfig = Scenes.EntityConfig(sceneObjects[k],targetScene,animDict,animation)
      Scenes.AddEntity(entConfig)
      count = count + 1
    end

    local extras = {}
    if action.extraProps then
      for k,v in pairs(action.extraProps) do
        mLibs:LoadModel(v.model)
        local obj = CreateObject(GetHashKey(v.model), actPos + v.pos, true,true,true)
        while not DoesEntityExist(obj) do Wait(0); end
        SetEntityRotation(obj,v.rot)
        FreezeEntityPosition(obj,true)
        extras[#extras+1] = obj
      end
    end

    startTime = GetGameTimer()

    for i=1,#scenes,1 do
      Scenes.Start(scenes[i])
    end

    --if progBar then
      --progBar:StartProg(action.time,action.progText)
      createProgressBar(action.progText,160,160,160,200, action.time)
    --else
      --ShowNotification(action.progText)
    --end

    Wait(action.time)

    for i=1,#scenes,1 do
      Scenes.Stop(scenes[i])
    end

    for k,v in pairs(extras) do
      DeleteObject(v)
    end

    RemoveAnimDict(animDict)

    TriggerServerEvent('Territories:RewardPlayer',action)
    for k,v in pairs(sceneObjects) do NetworkFadeOutEntity(v,false,false); end
  else
    local str = _U["not_enough"]
    local label = (itemLabel:len() > 0 and itemLabel or 'UNKNOWN')
    local amount = (action.requireRate or (action.requireCash and "$"..action.requireCash or 'UNKNOWN'))
    ShowNotification(string.format(str,label,amount))
  end
end

GetClosestAction = function(interior)
  local plyPos = GetEntityCoords(GetPlayerPed(-1))
  local closest,closestDist
  for k,v in pairs(interior.actions) do
    if k ~= "entry" and k ~= "exit" then
      local dist = vDist(plyPos,v.location)
      if not closestDist or dist < closestDist then
        closestDist = dist
        closest = k
      end
    end
  end
  return (closest or false),(closestDist or 9999)
end

DeathCheck = function(zone)
  local plyPed = GetPlayerPed(-1)
  local plyHp = GetEntityHealth(plyPed)
  local dead = IsPedFatallyInjured(plyPed)
  if isDead then
    if not dead then
      isDead = false
    end
  else
    if dead and zone then
      isDead = true
      local killer = NetworkGetEntityKillerOfPlayer(PlayerId())
      local killerId = GetPlayerByEntityID(killer)
      if killer ~= plyPed and killerId ~= nil and NetworkIsPlayerActive(killerId) then 
        local serverId = GetPlayerServerId(killerId)
        if serverId and serverId ~= -1 then
          TriggerServerEvent('Territories:GotMurdered',serverId,zone)
        end
      end
    end
  end
  return isDead
end

Switch = function(cond,...)
  local args = {...}
  local even = (#args%2 == 0)
  for i=1,#args-(even and 0 or 1),2 do
    if cond == args[i] then
      return args[i+1]((even and nil or args[#args]))
    end
  end
end

UpdateBlips = function()
  for k,v in pairs(Territories) do    
    if Config.DrugProcessBlip then
      if not v.blip and PlayerData and (PlayerData.job and PlayerData.job.name and PlayerData.job.name == v.control or PlayerData.org and PlayerData.org.name and PlayerData.org.name == v.control) then
        v.blip = mLibs:AddBlip(v.blipData.pos.x,v.blipData.pos.y,v.blipData.pos.z,v.blipData.sprite,v.blipData.color,v.blipData.text,v.blipData.scale,v.blipData.display,v.blipData.shortRange,true)
      elseif v.blip then
        local inControl = false
        inControl = (PlayerData and PlayerData.job and PlayerData.job.name and PlayerData.job.name == v.control)
        inControl = (inControl == false and PlayerData.org and PlayerData.org.name and PlayerData.org.name == v.control or true)
        if not inControl then
          mLibs:RemoveBlip(v.blip)
          v.blip = false
        end
      end
    end
    if v.blips then
      for handle,blip in pairs(v.blips) do
        if Config.DisplayZoneForAll or PlayerInGang() then
          if blip.color ~= BlipColors[v.control] or blip.alpha ~= math.floor(v.influence) then 
            mLibs:SetBlip(handle,"alpha",math.floor(v.influence)) 
            mLibs:SetBlip(handle,"color",BlipColors[v.control])

            local b = TableCopy(mLibs:GetBlip(handle))
            Territories[k].blips[handle] = b    
          end
        else
          if blip.alpha ~= 0 then
            mLibs:SetBlip(handle,"alpha",0)          
            local b = TableCopy(mLibs:GetBlip(handle))
            Territories[k].blips[handle] = b
          end
        end
      end
    end
  end
end

GetClosestZone = function()
  local closest
  local thisZone = GetStreetNameFromHashKey(GetStreetNameAtCoord(GetEntityCoords(GetPlayerPed(-1)).x,GetEntityCoords(GetPlayerPed(-1)).y,GetEntityCoords(GetPlayerPed(-1)).z))
  for k,v in pairs(Territories) do
    if v.zone == thisZone then
      closest = k
    end
  end
  return (closest or false)
end

Sync = function(tab)
  for k,v in pairs(tab) do
    Territories[k].influence = v.influence
    Territories[k].control = v.control
  end
end

GetPlayerByEntityID = function(id)
  for i=0,Config.MaxPlayerCount do
    if(NetworkIsPlayerActive(i) and GetPlayerPed(i) == id) then return i end
  end
  return nil
end

PlayerInGang = function()
  if not PlayerData or (not PlayerData.job and not PlayerData.org) or (not PlayerData.job.name and not PlayerData.org.name) then return false; end
  if GangLookup[PlayerData.job.name] then 
    return true 
  else 
    if PlayerData.org and PlayerData.org.name and GangLookup[PlayerData.org.name] then
      return true
    else
      return false
    end
  end
end

if Config.StartEvent == "Thread" then
  Citizen.CreateThread(Start)
else
  AddEventHandler(Config.StartEvent,Start)
end

local isCuffed = false
GotCuffed = function()
  isCuffed = not isCuffed
  local zone = (isCuffed and GetClosestZone())
  if zone then
    TriggerServerEvent('Territories:CuffSuccess',zone)
  end
end

PlayerReported = function(pos)
  local job = ESX.GetPlayerData().job
  if job and job.name and PoliceLookup[job.name] then
    local started = GetGameTimer()
    ShowNotification(_U["drug_deal_reported"])
    while (GetGameTimer() - started) < 8000 do
      if IsControlJustReleased(0, 101) or IsDisabledControlJustReleased(0, 101) then
        SetNewWaypoint(pos.x,pos.y)
        return
      end
      Wait(0)
    end 
  else
    local org = ESX.GetPlayerData().org
    if org and org.name and PoliceLookup[org.name] then
      local started = GetGameTimer()
      ShowNotification(_U["drug_deal_reported"])
      while (GetGameTimer() - started) < 8000 do
        if IsControlJustReleased(0, 101) or IsDisabledControlJustReleased(0, 101) then
          SetNewWaypoint(pos.x,pos.y)
          return
        end
        Wait(0)
      end 
    end
  end
end

EnterHouse = function(...)
  if not Config.InfluenceInHouse then
    StopInfluence = true
  end
end

LeaveHouse = function(...)
  if not Config.InfluenceInHouse then
    lastZone = false
    StopInfluence = false
  end
end

StartRet = function(start,territories)
  ModStart = start
  Territories = territories
end

RegisterCommand('slingdrugs', function(...) if not CurSlinging then SlingNextFrame = true; end; end)

GetFramework = function()
  while not ESX do Wait(0) end
  while not ESX.IsPlayerLoaded() do Citizen.Wait(0); end
end

GetPlayerData = function()
  return ESX.GetPlayerData()
end

SetJob = function(job)
  PlayerData.job = job

  if lastZone then
    TriggerServerEvent('Territories:LeaveZone',lastZone,PlayerData.job.name)
    lastZone = false
  end
end

Setorg = function(org)
  PlayerData.org = org
  if lastZone then
    TriggerServerEvent('Territories:LeaveZone',lastZone,PlayerData.org.name)
    lastZone = false
  end
end

Smack = function()
  ShowNotification("Tricheur tricheur, mangeur de citrouille!")
  --[[ local plyPed = GetPlayerPed(-1)
  while GetEntityHealth(plyPed) > 80 do
    SetEntityHealth(plyPed,GetEntityHealth(plyPed) - 10)
    Wait(500)
  end ]]
end

RegisterNetEvent('instance:onCreate')
AddEventHandler('instance:onCreate', function(instance)

  if instance.type == 'laboratoir' then
    TriggerEvent('instance:enter', instance)
  end

end)


Utils.event(1,Sync,'Territories:Sync')
Utils.event(1,StartRet,'Territories:StartRet')
Utils.event(1,SetJob,Config.SetJobEvent)
Utils.event(1,Setorg,Config.SetOrgEvent)
Utils.event(1,GotCuffed,'Territories:GotCuffed')
Utils.event(1,PlayerReported,'Territories:PlayerReported')
Utils.event(1,GotMarketAccess,'Territories:GotMarketAccess')
Utils.event(1,LostMarketAccess,'Territories:LostMarketAccess')
Utils.event(1,Smack,'Territories:Smacked')
Utils.event(1,EnterHouse,'playerhousing:Entered')
Utils.event(1,LeaveHouse,'playerhousing:Leave')

