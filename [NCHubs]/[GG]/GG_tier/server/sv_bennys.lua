local QBCore = exports['qb-core']:GetCoreObject()

local chicken = vehicleBaseRepairCost

--[[RegisterNetEvent('GG_tier:attemptPurchase', function(type, upgradeLevel)
    local source = source
    local Player = QBCore.Functions.GetPlayer(source)
    local balance = nil
    if Player.PlayerData.job.name == "admin" then
        balance = exports['qb-bossmenu']:GetAccount(Player.PlayerData.job.name)
    else
        balance = Player.Functions.GetMoney(moneyType)
    end
    if type == "repair" then
        if balance >= chicken then
            if Player.PlayerData.job.name == "admin" then
                TriggerEvent('qb-bossmenu:server:removeAccountMoney', Player.PlayerData.job.name, chicken)
            else
                Player.Functions.RemoveMoney(moneyType, chicken, "bennys")
            end
            TriggerClientEvent('GG_tier:purchaseSuccessful', source)
        else
            TriggerClientEvent('GG_tier:purchaseFailed', source)
        end
    elseif type == "performance" then
        if balance >= vehicleCustomisationPrices[type].prices[upgradeLevel] then
            TriggerClientEvent('GG_tier:purchaseSuccessful', source)
            if Player.PlayerData.job.name == "admin" then
                TriggerEvent('qb-bossmenu:server:removeAccountMoney', Player.PlayerData.job.name,
                    vehicleCustomisationPrices[type].prices[upgradeLevel])
            else
                Player.Functions.RemoveMoney(moneyType, vehicleCustomisationPrices[type].prices[upgradeLevel], "bennys")
            end
        else
            TriggerClientEvent('GG_tier:purchaseFailed', source)
        end
    else
        if balance >= vehicleCustomisationPrices[type].price then
            TriggerClientEvent('GG_tier:purchaseSuccessful', source)
            if Player.PlayerData.job.name == "admin" then
                TriggerEvent('qb-bossmenu:server:removeAccountMoney', Player.PlayerData.job.name,
                    vehicleCustomisationPrices[type].price)
            else
                Player.Functions.RemoveMoney(moneyType, vehicleCustomisationPrices[type].price, "bennys")
            end
        else
            TriggerClientEvent('GG_tier:purchaseFailed', source)
        end
    end
end)]]

RegisterNetEvent('GG_tier:attemptPurchase', function(type, upgradeLevel)
    local source = source
    local Player = QBCore.Functions.GetPlayer(source)
    if type == "repair" then
        if Player.PlayerData.money.cash >= chicken then
            Player.Functions.RemoveMoney('cash', chicken)
            TriggerClientEvent('GG_tier:purchaseSuccessful', source)
        else
            TriggerClientEvent('GG_tier:purchaseFailed', source)
        end
    elseif type == "performance" then
        if Player.PlayerData.money.cash >= vehicleCustomisationPrices[type].prices[upgradeLevel] then
            TriggerClientEvent('GG_tier:purchaseSuccessful', source)
            Player.Functions.RemoveMoney('cash', vehicleCustomisationPrices[type].prices[upgradeLevel])
        else
            TriggerClientEvent('GG_tier:purchaseFailed', source)
        end
    else
        if Player.PlayerData.money.cash >= vehicleCustomisationPrices[type].price then
            TriggerClientEvent('GG_tier:purchaseSuccessful', source)
            Player.Functions.RemoveMoney('cash', vehicleCustomisationPrices[type].price)
        else
            TriggerClientEvent('GG_tier:purchaseFailed', source)
        end
    end
end)

RegisterNetEvent('GG_tier:updateRepairCost', function(cost)
    chicken = cost
end)

RegisterNetEvent("updateVehicle", function(myCar)
    local src = source
    if IsVehicleOwned(myCar.plate) then
        exports.oxmysql:execute('UPDATE player_vehicles SET mods = ? WHERE plate = ?', {json.encode(myCar), myCar.plate})
    end
end)

function IsVehicleOwned(plate)
    local retval = false
    local result = exports.oxmysql:scalarSync('SELECT plate FROM player_vehicles WHERE plate = ?', {plate})
    if result then
        retval = true
    end
    return retval
end