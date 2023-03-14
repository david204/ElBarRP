local QBCore = exports['qb-core']:GetCoreObject()

local playerPed, playerCoords, playerInZone, playerInMission

CreateThread(function()
    
    local huntingShopBlip = AddBlipForCoord(Config.Locations["startJob"].x, Config.Locations["startJob"].y, Config.Locations["startJob"].z)
    SetBlipSprite(huntingShopBlip, 119)
    SetBlipColour(huntingShopBlip, 1)
    SetBlipScale(huntingShopBlip, 0.7)
    BeginTextCommandSetBlipName("STRING")
    AddTextComponentSubstringPlayerName("Hunting Shop")
    EndTextCommandSetBlipName(huntingShopBlip)
    SetBlipAsShortRange(huntingShopBlip, true)

    local huntingZoneBlip = AddBlipForCoord(-1189.043, 4661.6391, 249.82835)
    SetBlipSprite(huntingZoneBlip, 141)
    SetBlipScale(huntingZoneBlip, 0.7)
    BeginTextCommandSetBlipName("STRING")
    AddTextComponentSubstringPlayerName("Hunting Zone")
    EndTextCommandSetBlipName(huntingZoneBlip)
    SetBlipAsShortRange(huntingZoneBlip, true)

    local blipId2 = AddBlipForRadius(-1189.043, 4661.6391, 249.82835, 450.00)
    SetBlipHighDetail(blipId2, true)
    SetBlipColour(blipId2, 45)
    SetBlipAlpha(blipId2, 125)
    SetBlipAsShortRange(blipId2, true)


    while true do
        local ped = PlayerPedId()
        local _, weaponHash = GetCurrentPedWeapon(ped, 1)

        if(weaponHash == GetHashKey("weapon_musket")) and not playerInMission then
            DisablePlayerFiring(ped, true)
            Wait(0)
        else
            Wait(250)
        end
    end

end)

RegisterNetEvent('nc-HuntingSell', function()
  TriggerServerEvent('qb-hunting:server:sellMeat')
end)

RegisterNetEvent("qb-hunting:client:interactionEvent", function()
    print("NCHub - #1")
    TriggerServerEvent("inventory:server:OpenInventory", "shop", "hunting_shop", Config.Shop)
end)

function RequestDict(dict)
    while not HasAnimDictLoaded(dict) do
        RequestAnimDict("amb@medic@standing@kneel@base")
        RequestAnimDict("anim@gangops@facility@servers@bodysearch@")
        Wait(100)
    end
end

RegisterNetEvent("qb-hunting:client:useKnife", function(knifeLevel, animalsStriped, item) 

    local ped = PlayerPedId()
    local closestPed, distance = QBCore.Functions.GetClosestPed(nil, {ped})
    local closestPedHash = GetEntityModel(closestPed)

    print(Config.Animals[closestPedHash])
    print(distance)
    print(playerInMission)
    print(GetEntityHealth(closestPed))

    if(Config.Animals[closestPedHash] == nil or distance > 1.5 or playerInMission == nil or GetEntityHealth(closestPed) ~= 0) then
        QBCore.Functions.Notify("You aren't close to any dead animal", "error")
        return
    end
    
    RequestDict("amb@medic@standing@kneel@base")
    RequestDict("anim@gangops@facility@servers@bodysearch@")
    RequestAnimDict("amb@medic@standing@kneel@base")
    RequestAnimDict("anim@gangops@facility@servers@bodysearch@")

    TaskPlayAnim(PlayerPedId(), "amb@medic@standing@kneel@base" ,"base" ,8.0, -8.0, -1, 1, 0, false, false, false )
	TaskPlayAnim(PlayerPedId(), "anim@gangops@facility@servers@bodysearch@" ,"player_search" ,8.0, -8.0, -1, 48, 0, false, false, false )

    QBCore.Functions.Progressbar("strip_animal", "Stripping Animal..", 8000, false, true, true, {}, {}, {}, function()
       -- On Finish
    
       ClearPedTasks(ped)
       DeleteEntity(closestPed)

       TriggerServerEvent("qb-hunting:server:collectMeat", closestPedHash, item)
    end, function()
       -- On Cancel
       ClearPedTasks(ped)
    end)

end)

RegisterNetEvent("polyzone:enter", function(name)
	if name ~= "forest" then
        return
    end

    PlaySoundFrontend(-1, "ScreenFlash", "MissionFailedSounds")
    QBCore.Functions.Notify("You entered the hunting zone, Good luck!", "success", 5000)
    playerInMission = true
    TriggerServerEvent("qb-hunting:server:setInZone")

end)

RegisterNetEvent("polyzone:leave", function(name)
	if name ~= "forest" then
        return
    end

    PlaySoundFrontend(-1, "ScreenFlash", "MissionFailedSounds")
    QBCore.Functions.Notify("You exited the hunting zone", "error", 5000)
    playerInMission = false
    TriggerServerEvent("qb-hunting:server:setNotInZone")

end)

------------Modified By Sajjad
CreateThread(function()
    for name, value in pairs(Settings) do
      Settings[name]['inPoly'] = false
      Settings[name]['polyzone'] = PolyZone:Create(value['points'], value['options'])
      
      if value['rooms'] then
        for roomName, room in pairs(value['rooms']) do
          Settings[name]['rooms'][roomName]['inPoly'] = false
          Settings[name]['rooms'][roomName]['polyzone'] = PolyZone:Create(room['points'], room['options'])
        end
      end
    end
  
    while true do
      Wait(500)
      local plyPed = PlayerPedId()
      local coords = GetPedBoneCoords(plyPed, HeadBone)
  
      for name, value in pairs(Settings) do
        local poly = value['polyzone']
        if poly then
          local inPoly = poly:isPointInside(coords)
  
          if inPoly then
            if not value['inPoly'] then
              value['inPoly'] = true
              TriggerEvent("polyzone:enter", name)
              -- print("[Enter] " .. name)
            end
  
            if value['rooms'] then
              for roomName, room in pairs(value['rooms']) do
                local roomPoly = room['polyzone']
                if roomPoly then
                  local inRoomPoly = roomPoly:isPointInside(coords)
                  if inRoomPoly and not room['inPoly'] then
                    room['inPoly'] = true
                    TriggerEvent("polyzone:enter", name .. ":" .. roomName)
                    -- print("[Enter " .. name .. "'s Room] " .. roomName)
                  elseif not inRoomPoly and room['inPoly'] then
                    room['inPoly'] = false
                    TriggerEvent("polyzone:leave", name .. ":" .. roomName)
                    -- print("[Leave " .. name .. "'s Room] " .. roomName)
                  end
                end
              end
            end
          elseif value['inPoly'] then
            value['inPoly'] = false
            TriggerEvent("polyzone:leave", name)
            -- print("[Leave] " .. name)
  
            if value['rooms'] then
              for roomName, room in pairs(value['rooms']) do
                if room['inPoly'] then
                  room['inPoly'] = false
                  TriggerEvent("polyzone:leave", name .. ":" .. roomName)
                  -- print("[Leave " .. name .. "'s Room] " .. roomName)
                end
              end
            end
          end
        end
      end
    end
  end)