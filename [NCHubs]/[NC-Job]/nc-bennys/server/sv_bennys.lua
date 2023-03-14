-----------------------
----   Variables   ----
-----------------------
local QBCore = exports['qb-core']:GetCoreObject()
local RepairCosts = {}

-----------------------
----   Functions   ----
-----------------------

local function IsVehicleOwned(plate)
    local retval = false
    local result = MySQL.Sync.fetchScalar('SELECT plate FROM player_vehicles WHERE plate = ?', {plate})
    if result then retval = true end
    return retval
end

-----------------------
----   Threads     ----
-----------------------

-----------------------
---- Server Events ----
-----------------------

AddEventHandler("playerDropped", function()
	local source = source
    RepairCosts[source] = nil
end)

RegisterNetEvent('nc-bennys:server:attemptPurchase', function(type, upgradeLevel)
    local source = source
    local Player = QBCore.Functions.GetPlayer(source)
    local moneyType = Config.MoneyType
    local balance = Player.Functions.GetMoney(moneyType)

    if type == "repair" then
        local repairCost = RepairCosts[source] or 600
        moneyType = Config.RepairMoneyType
        balance = Player.Functions.GetMoney(moneyType)
        if balance >= repairCost then
            Player.Functions.RemoveMoney(moneyType, repairCost, "bennys")
            TriggerClientEvent('nc-bennys:client:purchaseSuccessful', source)
        else
            TriggerClientEvent('nc-bennys:client:purchaseFailed', source)
        end
    elseif type == "performance" or type == "turbo" then
        if balance >= vehicleCustomisationPrices[type].prices[upgradeLevel] then
            TriggerClientEvent('nc-bennys:client:purchaseSuccessful', source)
            Player.Functions.RemoveMoney(moneyType, vehicleCustomisationPrices[type].prices[upgradeLevel], "bennys")
        else
            TriggerClientEvent('nc-bennys:client:purchaseFailed', source)
        end
    else
        if balance >= vehicleCustomisationPrices[type].price then
            TriggerClientEvent('nc-bennys:client:purchaseSuccessful', source)
            Player.Functions.RemoveMoney(moneyType, vehicleCustomisationPrices[type].price, "bennys")
        else
            TriggerClientEvent('nc-bennys:client:purchaseFailed', source)
        end
    end
end)

RegisterNetEvent('nc-bennys:server:updateRepairCost', function(cost)
    local source = source
    RepairCosts[source] = cost
end)

RegisterNetEvent("nc-bennys:server:updateVehicle", function(myCar)
    if IsVehicleOwned(myCar.plate) then
        MySQL.Async.execute('UPDATE player_vehicles SET mods = ? WHERE plate = ?', {json.encode(myCar), myCar.plate})
    end
end)

-- Use somthing like this to dynamically enable/disable a location. Can be used to change anything at a location.
-- TriggerEvent('nc-bennys:server:UpdateLocation', 'Hayes', 'settings', 'enabled', test)

RegisterNetEvent('nc-bennys:server:UpdateLocation', function(location, type, key, value)
    Config.Locations[location][type][key] = value
    TriggerClientEvent('nc-bennys:client:UpdateLocation', -1, location, type, key, value)
end)

QBCore.Functions.CreateCallback('nc-bennys:server:GetLocations', function(source, cb)
	cb(Config.Locations)
end)