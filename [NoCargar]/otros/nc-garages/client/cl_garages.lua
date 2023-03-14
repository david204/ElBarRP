local currentGarage = nil
local ParkingSpot = nil
local hasGarageKey = nil
local selectedGarage = nil
local OutsideVehicles = {}
local PlayerGang = {}

-- default new version of QBCore
local QBCore = exports['qb-core']:GetCoreObject()

RegisterNetEvent('QBCore:Client:OnPlayerLoaded')
AddEventHandler('QBCore:Client:OnPlayerLoaded', function()
    PlayerGang = QBCore.Functions.GetPlayerData().gang
end)

RegisterNetEvent('QBCore:Client:OnGangUpdate')
AddEventHandler('QBCore:Client:OnGangUpdate', function(gang)
    PlayerGang = gang
end)

RegisterNetEvent('nc-garages:client:houseGarageConfig')
AddEventHandler('nc-garages:client:houseGarageConfig', function(garageConfig)
    HouseGarages = garageConfig
end)

RegisterNetEvent('nc-garages:client:addHouseGarage')
AddEventHandler('nc-garages:client:addHouseGarage', function(house, garageInfo)
    TriggerServerEvent('nc-garages:server:addHouseGarage', house, garageInfo)
    HouseGarages[house] = garageInfo
end)

function GetVehicleEngineRasZebi()
    local coords = GetEntityCoords(PlayerPedId())
    if IsAnyVehicleNearPoint(coords.x, coords.y, coords.z, 5.0) then
        vehicle = GetClosestVehicle(coords.x, coords.y, coords.z, 5.0, 0, 71)
        return  GetVehicleEngineHealth(vehicle)
    else
        return false
    end
end

RegisterNetEvent('nc-garages:store')
AddEventHandler('nc-garages:store', function()
    local ped = PlayerPedId()
    local coordA = GetEntityCoords(ped, 1)
    local coordB = GetOffsetFromEntityInWorldCoords(ped, 0.0, 100.0, 0.0)
    local curVeh = getVehicleInDirection(coordA, coordB)
    local plate = GetVehicleNumberPlateText(curVeh)
    QBCore.Functions.TriggerCallback('nc-garage:server:checkVehicleOwner', function(owned)
        --Citizen.Wait(1000)
        if owned then
            local pGarage = GetCurrentGarage()
            if pGarage ~= nil then
                QBCore.Functions.TriggerCallback("nc-garage:server:GetUserVehicles", function(result)
                    local bodyDamage = math.ceil(GetVehicleBodyHealth(curVeh))
                    local engineDamage = math.ceil(GetVehicleEngineRasZebi())
                    local totalFuel = exports['nc-fuel']:GetFuel(curVeh)
                    local passenger = GetVehicleMaxNumberOfPassengers(curVeh)

                    TriggerServerEvent('nc-garage:server:updateVehicleStatus', totalFuel, engineDamage, bodyDamage, plate, pGarage)
                    TriggerServerEvent('nc-garage:server:updateVehicleState', 1, plate, pGarage)
                    if plate ~= nil then
                        OutsideVehicles[plate] = veh
                        TriggerServerEvent('nc-garages:server:UpdateOutsideVehicles', OutsideVehicles)
                    end
                    QBCore.Functions.DeleteVehicle(curVeh)
                    QBCore.Functions.Notify("Vehicle parked in : "..Garages[pGarage].label, "success")
                end, pGarage)
            else
                pGarage = GetGangGarage()
                if pGarage ~= nil then
                    if PlayerGang.name ~= nil then
                        if PlayerGang.name == GangGarages[pGarage].gang then
                            QBCore.Functions.TriggerCallback("nc-garage:server:GetUserVehicles", function(result)
                                local bodyDamage = math.ceil(GetVehicleBodyHealth(curVeh))
                                local engineDamage = math.ceil(GetVehicleEngineRasZebi())
                                local totalFuel = exports['nc-fuel']:GetFuel(curVeh)
                                local passenger = GetVehicleMaxNumberOfPassengers(curVeh)
                                TriggerServerEvent('nc-garage:server:updateVehicleStatus', totalFuel, engineDamage, bodyDamage, plate, pGarage)
                                TriggerServerEvent('nc-garage:server:updateVehicleState', 1, plate, pGarage)
                                if plate ~= nil then
                                    OutsideVehicles[plate] = veh
                                    TriggerServerEvent('nc-garages:server:UpdateOutsideVehicles', OutsideVehicles)
                                end
                                QBCore.Functions.DeleteVehicle(curVeh)
                                QBCore.Functions.Notify("Vehicle parked in : "..GangGarages[pGarage].label, "success")
                            end, pGarage)
                        else
                            QBCore.Functions.Notify("You can not store here.", "error")
                        end
                    else
                        QBCore.Functions.Notify("You can not store here.", "error")
                    end
                else
                    pGarage = NearestHouseGarage()
                    if pGarage ~= nil then
                        QBCore.Functions.TriggerCallback("nc-houses:server:hasKey", function(result)
                            if result then
                                QBCore.Functions.TriggerCallback("nc-garage:server:GetUserVehicles", function(result)
                                    local bodyDamage = math.ceil(GetVehicleBodyHealth(curVeh))
                                    local engineDamage = math.ceil(GetVehicleEngineRasZebi())
                                    local totalFuel = exports['nc-fuel']:GetFuel(curVeh)
                                    local passenger = GetVehicleMaxNumberOfPassengers(curVeh)
                                    TriggerServerEvent('nc-garage:server:updateVehicleStatus', totalFuel, engineDamage, bodyDamage, plate, pGarage)
                                    TriggerServerEvent('nc-garage:server:updateVehicleState', 1, plate, pGarage)
                                    if plate ~= nil then
                                        OutsideVehicles[plate] = veh
                                        TriggerServerEvent('nc-garages:server:UpdateOutsideVehicles', OutsideVehicles)
                                    end
                                    QBCore.Functions.DeleteVehicle(curVeh)
                                    QBCore.Functions.Notify("Vehicle parked in : "..pGarage, "success")
                                end, pGarage)
                            else
                                QBCore.Functions.Notify("You have no access to park here!", "error")
                            end
                        end, pGarage)
                    else
                        pGarage = GetJobGarage()
                        if pGarage ~= nil then
                            if JobGarages[pGarage].job == QBCore.Functions.GetPlayerData().job.name then
                                QBCore.Functions.TriggerCallback("nc-garage:server:GetUserVehicles", function(result)
                                    local bodyDamage = math.ceil(GetVehicleBodyHealth(curVeh))
                                    local engineDamage = math.ceil(GetVehicleEngineRasZebi())
                                    local totalFuel = exports['nc-fuel']:GetFuel(curVeh)
                                    local passenger = GetVehicleMaxNumberOfPassengers(curVeh)
                                    TriggerServerEvent('nc-garage:server:updateVehicleStatus', totalFuel, engineDamage, bodyDamage, plate, pGarage)
                                    TriggerServerEvent('nc-garage:server:updateVehicleState', 1, plate, pGarage)
                                    if plate ~= nil then
                                        OutsideVehicles[plate] = veh
                                        TriggerServerEvent('nc-garages:server:UpdateOutsideVehicles', OutsideVehicles)
                                    end
                                    QBCore.Functions.DeleteVehicle(curVeh)
                                    QBCore.Functions.Notify("Vehicle parked in : "..JobGarages[pGarage].label, "success")
                                end, pGarage)
                            else
                                QBCore.Functions.Notify("You have no access!", "error")
                            end
                        else
                            QBCore.Functions.Notify("Unable to find garage!", "error")
                        end
                    end
                end
            end
        else
            QBCore.Functions.Notify("You can store your owned cars only!", "error")
        end
    end, plate)
end)

RegisterNetEvent('nc-garages:open')
AddEventHandler('nc-garages:open', function()
    local pGarage = GetCurrentGarage() or GetDepotsDist()
    if pGarage ~= nil then
        TriggerServerEvent('nc-garages:select', pGarage, 0)
    else
        pGarage = GetGangGarage()
        if pGarage ~= nil then
            if PlayerGang.name ~= nil then
                if PlayerGang.name == GangGarages[pGarage].gang then
                    TriggerServerEvent('nc-garages:select', pGarage, 0)
                else
                    QBCore.Functions.Notify("How do you even think about it bitch?", "error")
                end
            else
                QBCore.Functions.Notify("How do you even think about it bitch?", "error")
            end
        else
            local pGarage = NearestHouseGarage()
            if pGarage ~= nil then
                QBCore.Functions.TriggerCallback("nc-houses:server:hasKey", function(result)
                    if result then
                        TriggerServerEvent('nc-garages:select', pGarage, 1)
                    else
                        QBCore.Functions.Notify("You have no access to the garage!", "error")
                    end
                end, pGarage)
            else
                pGarage = GetJobGarage()
                if pGarage ~= nil then
                    if JobGarages[pGarage].job == QBCore.Functions.GetPlayerData().job.name then
                        TriggerServerEvent('nc-garages:select', pGarage, 0)
                    else
                        QBCore.Functions.Notify("You have no access!", "error")
                    end
                else
                    QBCore.Functions.Notify("We couldn't find a garage.", "error")
                end
            end
        end
    end
end)

RegisterNetEvent('nc-garages:client:attemptspawn')
AddEventHandler('nc-garages:client:attemptspawn', function(data)
    TriggerServerEvent('nc-garages:server:attemptspawn', data)
end)

RegisterNetEvent('nc-garages:Spawnveh')
AddEventHandler('nc-garages:Spawnveh', function(type)
    local enginePercent = round(type.vehicle.engine / 10, 0)
    local bodyPercent = round(type.vehicle.body / 10, 0)
    local currentFuel = type.vehicle.fuel
    local ped = PlayerPedId()
    local coords = GetEntityCoords(ped)   
    if type.isHouse == 1 then
        local heading = GetEntityHeading(ped)
        local forward = GetEntityForwardVector(PlayerPedId())
        local x, y, z = table.unpack(coords + forward)
        ParkingSpot = vector4(x, y, z, heading+85)
    else
        local CurGar = GetCurrentGarage()
        if CurGar ~= nil then
            selectedGarage = Garages[CurGar]
        else
            CurGar = GetGangGarage()
            if CurGar ~= nil then
                selectedGarage = GangGarages[CurGar]
            else
                CurGar = GetJobGarage()
                if CurGar ~= nil then
                    selectedGarage = JobGarages[CurGar]
                end
            end
        end
        for i=1, #selectedGarage.spawns do
            local RunSpawnCheck = false
            local distance = #(vector3(selectedGarage.spawns[i].x, selectedGarage.spawns[i].y, selectedGarage.spawns[i].z) - GetEntityCoords(PlayerPedId()))
            if distance < 1.6 then
                RunSpawnCheck = true
            elseif distance < 1.8 and not RunSpawnCheck then
                RunSpawnCheck = true
            elseif distance < 2.0 and not RunSpawnCheck then
                RunSpawnCheck = true
            elseif distance < 2.4 and not RunSpawnCheck then
                RunSpawnCheck = true
            elseif distance < 3.0 and not RunSpawnCheck then
                RunSpawnCheck = true
            elseif distance < 3.5 and not RunSpawnCheck then
            end
            if RunSpawnCheck then
                local vehicle = GetClosestVehicle(selectedGarage.spawns[i].x, selectedGarage.spawns[i].y, selectedGarage.spawns[i].z, 2.0, 0, 127)
                if not DoesEntityExist(vehicle) then
                    ParkingSpot = vector4(selectedGarage.spawns[i].x, selectedGarage.spawns[i].y, selectedGarage.spawns[i].z, selectedGarage.spawns[i].h)
                    break
                end
            end
        end
        if not ParkingSpot then
            TriggerEvent("QBCore:Notify", "You need to be near a free parking spot!")
            return
        end
    end
    --Citizen.Wait(1000)
    QBCore.Functions.SpawnVehicle(type.vehicle.vehicle, function(veh)
        QBCore.Functions.TriggerCallback('nc-garage:server:GetVehicleProperties', function(properties)
            QBCore.Functions.SetVehicleProperties(veh, properties)
            SetVehicleNumberPlateText(veh, type.vehicle.plate)
            exports['nc-fuel']:SetFuel(veh, type.vehicle.fuel)
            doCarDamage(veh, type.vehicle)
            SetEntityAsMissionEntity(veh, true, true)
            TriggerServerEvent('nc-garage:server:updateVehicleState', 0, type.vehicle.plate, type.vehicle.garage)
            local plate = GetVehicleNumberPlateText(veh)
            TriggerEvent("vehiclekeys:client:SetOwner", GetVehicleNumberPlateText(veh), veh)
            --TriggerEvent("vehiclekeys:client:SetOwner", GetVehicleNumberPlateText(veh))
            SetVehicleEngineOn(veh, false, false)
            if type.vehicle.plate ~= nil then
                OutsideVehicles[type.vehicle.plate] = veh
                TriggerServerEvent('nc-garages:server:UpdateOutsideVehicles', OutsideVehicles)
            end
        end, type.vehicle.plate)
    end, ParkingSpot, true)
    ParkingSpot = nil
end)

function findVehFromPlateAndLocate(plate)

    local gameVehicles = QBCore.Functions.GetVehicles()
  
    for i = 1, #gameVehicles do
        local vehicle = gameVehicles[i]

        if DoesEntityExist(vehicle) then
            if GetVehicleNumberPlateText(vehicle) == plate then
                local vehCoords = GetEntityCoords(vehicle)
                SetNewWaypoint(vehCoords.x, vehCoords.y)
                return true
            end
        end
    end
end

RegisterNetEvent('nc-garages:takeoutveh:depot')
AddEventHandler('nc-garages:takeoutveh:depot', function(type)

    for k, v in pairs(type) do
        if findVehFromPlateAndLocate(v.plate) then
            QBCore.Functions.Notify("Vehicle is still outside, GPS has been set to your vehicle location.", "error")
        else 
            enginePercent = round(v.engine / 10, 0)
            bodyPercent = round(v.body / 10, 0)
            currentFuel = v.fuel
            local ped = PlayerPedId()
            local coords = GetEntityCoords(ped)
            local heading = GetEntityHeading(ped)
            local forward = GetEntityForwardVector(PlayerPedId())
            local x, y, z = table.unpack(coords + forward)
            local pDepot = GetDepotsDist()
            local spawnpoint = vector4(Depots[pDepot].takeVehicle.x, Depots[pDepot].takeVehicle.y, Depots[pDepot].takeVehicle.z, Depots[pDepot].face) 
            Citizen.Wait(1000)
            QBCore.Functions.SpawnVehicle(v.vehicle, function(veh)
                if v.plate ~= nil then
                    DeleteVehicle(OutsideVehicles[v.plate])
                    OutsideVehicles[v.plate] = veh
                    TriggerServerEvent('nc-garages:server:UpdateOutsideVehicles', OutsideVehicles)
                end
                QBCore.Functions.TriggerCallback('nc-garage:server:GetVehicleProperties', function(properties)
                    QBCore.Functions.SetVehicleProperties(veh, properties)
                    SetVehicleNumberPlateText(veh, v.plate)
                    exports['nc-fuel']:SetFuel(veh, v.fuel)
                    doCarDamage(veh, v)
                    SetEntityAsMissionEntity(veh, true, true)
                    TriggerServerEvent('nc-garage:server:updateVehicleState', 0, v.plate, v.garage)
                    QBCore.Functions.Notify("Vehicle: Engine " .. enginePercent .. "% Body: " .. bodyPercent.. "% Fuel: "..currentFuel.. "%")
                    local plate = GetVehicleNumberPlateText(veh)
                    TriggerEvent("vehiclekeys:client:SetOwner", GetVehicleNumberPlateText(veh), veh)
                    --TriggerEvent("vehiclekeys:client:SetOwner", GetVehicleNumberPlateText(veh))
                    SetVehicleEngineOn(veh, false, false)
                    TriggerServerEvent('nc-garage:server:PayDepotPrice', v.plate)
                end, v.plate)
            end, spawnpoint, true)
        end
    end
end)

RegisterNetEvent('garages:Blips')
AddEventHandler('garages:Blips', function()
    ToggleGarageBlips()
end)

CreateThread(function()
    Wait(2000)
    if Var.ShowMarkerinGarages then
        while true do
            Wait(10)
            for k, v in pairs(HouseGarages) do
                if #(GetEntityCoords(PlayerPedId()) - vector3(HouseGarages[k].takeVehicle.x, HouseGarages[k].takeVehicle.y, HouseGarages[k].takeVehicle.z)) <= 15 then
                    DrawMarker(2, HouseGarages[k].takeVehicle.x, HouseGarages[k].takeVehicle.y, HouseGarages[k].takeVehicle.z, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.3, 0.2, 0.15, 200, 0, 0, 222, false, false, false, true, false, false, false)
                end
            end
            for k, v in pairs(GangGarages) do
                if #(GetEntityCoords(PlayerPedId()) - vector3(GangGarages[k].polyzone.x, GangGarages[k].polyzone.y, GangGarages[k].polyzone.z)) <= 20 then
                    DrawMarker(2, GangGarages[k].polyzone.x, GangGarages[k].polyzone.y, GangGarages[k].polyzone.z, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.3, 0.2, 0.15, 200, 0, 0, 222, false, false, false, true, false, false, false)
                end
            end
        end
    end
end)