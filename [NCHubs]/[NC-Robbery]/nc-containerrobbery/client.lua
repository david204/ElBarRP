local QBCore = exports['qb-core']:GetCoreObject()

local viewEntity;

RegisterNetEvent("qb-target:entity:change", function(a)
  viewEntity = a
end)

function GetZoneData()
    local coords = GetEntityCoords(PlayerPedId());
    local var1, var2 = GetStreetNameAtCoord(coords.x, coords.y, coords.z, Citizen.ResultAsInteger(), Citizen.ResultAsInteger());
    local hash1, hash2 = GetStreetNameFromHashKey(var1), GetStreetNameFromHashKey(var2);
    local zoneLabel = GetLabelText(GetNameOfZone(coords.x, coords.y, coords.z));

    if (hash2 == '') then
        return hash1, zoneLabel;
    else
        return hash1, ('%s, %s'):format(hash2, zoneLabel);
    end
end

function HasItem(item)
    local retval = nil
    QBCore.Functions.TriggerCallback("QBCore:HasItem", function(data)
        retval = data
    end, item)

    while retval == nil do
        Wait(1)
    end

    return retval
end

RegisterNetEvent("nc-containerrobbery:robAction", function(data)
    if HasItem('weapon_crowbar') then
        local entity = viewEntity
        local netID = NetworkGetNetworkIdFromEntity(entity)
        local time = Config.timeATM * 1000
        robAction("ATM",time,"dispatch:atmRob","anim@amb@business@weed@weed_sorting_seated@","sorter_right_sort_v3_sorter02","atm",netID)
    else
        QBCore.Functions.Notify("You need a crowbar to rob an ATM...", "error")
    end

end)

RegisterNetEvent("nc-containerrobbery:truck",function()
    local playerPed = PlayerPedId()
    local playerPos = GetEntityCoords(playerPed)    
    local isCloseObject = GetClosestObjectOfType(playerPos.x, playerPos.y, playerPos.z, 5.0, 1152297372, 0, 0, 0)
    local time = Config.timeTruck * 1000
    if isCloseObject ~= 0 then
        local netID = NetworkGetNetworkIdFromEntity(isCloseObject)
        robAction("Truck",time,"dispatch:truckRob","missheistfbi3b_ig7","lift_fibagent_loop","truck",netID)
    end
end)


function robAction(name,time,dispatch,anim,anim2,bool,netID)
    local plyPed = PlayerPedId()
    TriggerEvent('qb-inventory:client:close:inventory')
    QBCore.Functions.TriggerCallback("srp:canRob",function(canRob,reason)
        if canRob then
            TriggerEvent(dispatch)
            if (exports['nc-hackminigame']:Begin(2, 7000)) then            
                    RonRequestAnimDict(anim, function()
                    ClearPedTasks(plyPed)
                    TaskPlayAnim(plyPed, anim, anim2, 8.0, -8, -1, 49, 0, 0, 0, 0)
                    FreezeEntityPosition(plyPed,true)
                end)
                QBCore.Functions.Progressbar("use_bank", "Robbing "..name, time, false, true, {}, {}, {}, {}, function() -- Done
                    if bool == "atm" then 
                        TriggerServerEvent("nc-containerrobbery:recivemoney")
                    else 
                        getItems()
                    end
                    ClearPedTasks(plyPed)
                    FreezeEntityPosition(PlayerPedId(),false)
                    TriggerServerEvent("srp:setCooldown",netID)
                    TriggerEvent("weapons:client:AddWeaponQuality", 25)
                    TriggerServerEvent("nc-containerrobbery:logs", bool, true, GetZoneData());
                    -- TriggerServerEvent("nc-containerrobbery:server:cooldown", cooldown)
                end, function() show = true -- Cancel
                    QBCore.Functions.Notify("Canceled..", "error")
                    ClearPedTasks(plyPed)
                    FreezeEntityPosition(PlayerPedId(),false)
                end)
            else
                QBCore.Functions.Notify("Rob failed!", "error")
                TriggerServerEvent("nc-containerrobbery:logs", bool, false, GetZoneData());
                return
            end
        else
            QBCore.Functions.Notify(reason, "error")
        end
    end, netID, name)
end

function RonRequestAnimDict(animdict,func)
    if not DoesAnimDictExist(animdict) then return end
    RequestAnimDict(animdict)
    while not HasAnimDictLoaded(animdict) do
        Wait(50)
    end
    func()
end

function getItems()
    local idan = randomWeapons()
    for k,v in next,idan do 
        TriggerServerEvent("nc-containerrobbery:reciveitems",k,v)
    end
end

function randomWeapons()
    local list = {}
    for i = 0, 4 do 
        local rand = math.random(#Config.Ron - i)

        while list[Config.Ron[rand]] do 
            rand = math.random(#Config.Ron - i)
        end

        list[Config.Ron[rand]] = Config.TruckRob[Config.Ron[rand]]
    end
    return list
end


exports("isNearTruck",function()
    local playerPed = PlayerPedId()
    local playerPos = GetEntityCoords(playerPed)
    local isCloseObject = GetClosestObjectOfType(playerPos.x, playerPos.y, playerPos.z, 5.0, 1152297372, 0, 0, 0)

    if isCloseObject ~= 0 then 
        local objectOffset = GetOffsetFromEntityInWorldCoords(isCloseObject, 0.0,-6.0,1.5)
        local objectDist = #(playerPos - objectOffset)
        if objectDist < 2.0 then 
            return true
        end
    end
    return false
end)

DrawText3Ds = function(x, y, z, text)
	SetTextScale(0.35, 0.35)
    SetTextFont(4)
    SetTextProportional(1)
    SetTextColour(255, 255, 255, 215)
    SetTextEntry("STRING")
    SetTextCentre(true)
    AddTextComponentString(text)
    SetDrawOrigin(x,y,z, 0)
    DrawText(0.0, 0.0)
    local factor = (string.len(text)) / 370
    DrawRect(0.0, 0.0+0.0125, 0.017+ factor, 0.03, 0, 0, 0, 75)
    ClearDrawOrigin()
end
