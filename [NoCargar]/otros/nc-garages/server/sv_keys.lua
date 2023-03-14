local VehicleList = {}

local QBCore = exports['qb-core']:GetCoreObject()

QBCore.Functions.CreateCallback('vehiclekeys:CheckHasKey', function(source, cb, plate, vehicle)
    local Player = QBCore.Functions.GetPlayer(source)
    cb(CheckOwner(plate, Player.PlayerData.citizenid, vehicle))
end)

RegisterServerEvent('vehiclekeys:server:SetVehicleOwner')
AddEventHandler('vehiclekeys:server:SetVehicleOwner', function(plate, vehicle)
    local src = source
    local Player = QBCore.Functions.GetPlayer(src)
    if VehicleList ~= nil then
        if DoesPlateExist(plate, vehicle) then
            for k, val in pairs(VehicleList) do
                if val.plate == plate then
                    table.insert(VehicleList[k].owners, Player.PlayerData.citizenid)
                end
            end
        else
            local vehicleId = #VehicleList+1
            VehicleList[vehicleId] = {
                plate = plate, 
                vehicle = vehicle,
                owners = {},
            }
            VehicleList[vehicleId].owners[1] = Player.PlayerData.citizenid
        end
    else
        local vehicleId = #VehicleList+1
        VehicleList[vehicleId] = {
            plate = plate, 
            vehicle = vehicle,
            owners = {},
        }
        VehicleList[vehicleId].owners[1] = Player.PlayerData.citizenid
    end
end)

RegisterServerEvent('vehiclekeys:server:GiveVehicleKeys')
AddEventHandler('vehiclekeys:server:GiveVehicleKeys', function(plate, target)
    local src = source
    local Player = QBCore.Functions.GetPlayer(src)
    if CheckOwner(plate, Player.PlayerData.citizenid) then
        if QBCore.Functions.GetPlayer(target) ~= nil then
            TriggerClientEvent('vehiclekeys:client:SetOwner', target, plate)
            TriggerClientEvent('QBCore:Notify', src, "You just gave keys to your vehicles!")
            TriggerClientEvent('QBCore:Notify', target, "You just received keys to a vehicle!")
        else
            TriggerClientEvent('chatMessage', src, "SYSTEM", "error", "Player is not online!")
        end
    else
        TriggerClientEvent('chatMessage', src, "SYSTEM", "error", "You have no keys to this vehicle!")
    end
end)

QBCore.Commands.Add("givekeys", "Give keys to a vehicle", {}, true, function(source, args)
	local src = source
    TriggerClientEvent('vehiclekeys:client:GiveKeys', src)
end)

function DoesPlateExist(plate, vehicle)
    if VehicleList ~= nil then
        for k, val in pairs(VehicleList) do
            if val.vehicle == vehicle then
                return true
            end
        end
    end
    return false
end

function CheckOwner(plate, identifier, vehicle)
    local retval = false
    if VehicleList ~= nil then
        for k, val in pairs(VehicleList) do
            if (val.vehicle ~= nil and val.vehicle == vehicle) or val.plate == plate then
                for key, owner in pairs(VehicleList[k].owners) do
                    if owner == identifier then
                        retval = true
                    end
                end
            end
        end
    end
    return retval
end

QBCore.Functions.CreateUseableItem("lockpick", function(source, item)
    local Player = QBCore.Functions.GetPlayer(source)
    TriggerClientEvent("lockpicks:UseLockpick", source, false)
end)

QBCore.Functions.CreateUseableItem("advancedlockpick", function(source, item)
    local Player = QBCore.Functions.GetPlayer(source)
    TriggerClientEvent("lockpicks:UseLockpick", source, true)
end)

--fake plate [bb]
local networkVehicles = {}

QBCore.Functions.CreateUseableItem('advancedscrewdriver', function(source)
    local src = source
    TriggerClientEvent('nc-garages:client:fakeplate:steal', src)
end)

QBCore.Functions.CreateUseableItem('licenseplate', function(source, info)
    local src = source
    TriggerClientEvent('nc-garages:client:fakeplate:usePlate', src, info)
end)

RegisterServerEvent('nc-garages:server:isPlayerVehicle')
AddEventHandler('nc-garages:server:isPlayerVehicle', function(typ, plate, vehicle)
    if typ == 'STEAL' then
        exports.oxmysql:fetch("SELECT `vehicle` FROM `player_vehicles` WHERE `plate` = '" .. plate .. "' LIMIT 1", function(result)
            if result[1] ~= nil then
                exports.oxmysql:fetch("UPDATE `player_vehicles` SET `fakeplate` = '%' WHERE `plate` = '" .. plate .. "' AND `vehicle` = '" .. result[1].model .. "' LIMIT 1")
                networkVehicles[vehicle] = {plate, '%'}
            end
        end)
    elseif typ == 'SET' then
        -- if networkVehicles[vehicle] ~= nil then
            -- if networkVehicles[vehicle][1] == plate then
                exports.oxmysql:fetch("UPDATE `player_vehicles` SET `fakeplate` = '' WHERE `plate` = '" .. plate .. "' LIMIT 1")
                networkVehicles[vehicle] = nil
            -- else
            --     networkVehicles[vehicle][2] = plate
            -- end
        -- end
    end
end)

RegisterServerEvent('nc-garages:server:fakeplate:breakScrewdriver')
AddEventHandler('nc-garages:server:fakeplate:breakScrewdriver', function()
    local src = source
    local xPlayer = QBCore.Functions.GetPlayer(src)
    xPlayer.Functions.RemoveItem('advancedscrewdriver', 1)
    TriggerClientEvent('QBCore:Notify', src, "Your Advanced Screwdriver went broken", "error")
end)

RegisterServerEvent('nc-garages:server:fakeplate:removeLicensePlate')
AddEventHandler('nc-garages:server:fakeplate:removeLicensePlate', function(slot)
    local src = source
    local xPlayer = QBCore.Functions.GetPlayer(src)
    xPlayer.Functions.RemoveItem('licenseplate', 1, slot)
    TriggerClientEvent('QBCore:Notify', src, "Successfully installed license plate", "success")
end)

RegisterServerEvent('nc-garages:server:fakeplate:createLicensePlate')
AddEventHandler('nc-garages:server:fakeplate:createLicensePlate', function(plate)
    local src = source
    local xPlayer = QBCore.Functions.GetPlayer(src)
    xPlayer.Functions.AddItem('licenseplate', 1, nil, {plate = plate})
    TriggerClientEvent('QBCore:Notify', src, "You stole a license plate.", "success")
end)