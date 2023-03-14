local OutsideVehicles = {}
local garagevehs = {}
local HouseGarLoc = {}
local NoVehinGarage = true

local QBCore = exports['qb-core']:GetCoreObject()


-- Citizen.CreateThread(function()
-- 	ResetGaragesServer() 
-- end)

-- function ResetGaragesServer()
--     exports.oxmysql:execute('SELECT * FROM player_vehicles WHERE state = ?', {"0"}, function(vehicles)
-- 		for k, v in ipairs(vehicles) do
-- 			if v.state == 0 then
--                 exports.oxmysql:execute("UPDATE player_vehicles SET state = @state WHERE plate = @plate", {['state'] = '2', ['plate'] = v.plate})
-- 			end
-- 		end
-- 	end)
-- end

RegisterServerEvent("nc-garages:select")
AddEventHandler("nc-garages:select",function(gName, isHouse)
    local src = source
    local user = QBCore.Functions.GetPlayer(src)
    local ply = user.PlayerData
    local citizenid = ply.citizenid
    local vehicle = vehicle
    local name = name

    if not citizenid then return end
    if Var.MySQL == "oxmysql" then
        exports.oxmysql:execute("SELECT * FROM player_vehicles WHERE citizenid = ?", {citizenid}, function(vehcheck)
            if vehcheck ~= nil then
                for i = 1, #vehcheck do
                    garagevehs[i] = {
                        state = vehcheck[i].state,
                        plate = vehcheck[i].plate,
                        name = vehcheck[i].vehicle:upper(),
                        garage = vehcheck[i].garage,
                    }
                    if gName == garagevehs[i].garage then
                        if garagevehs[i].state ~= 2 and garagevehs[i].state ~= 0 then
                            local vehname = QBCore.Shared.Vehicles[vehcheck[i].vehicle].name
                            local plate = vehcheck[i].plate
                            TriggerClientEvent('nh-context:sendMenu', src, {
                                {
                                    id = i,
                                    header = vehname,
                                    txt = "Plate: "..plate,
                                    params = {
                                        event = "nc-garages:client:attemptspawn",
                                        args = {
                                            veh = vehcheck[i],
                                            engine = vehcheck[i].engine,
                                            body = vehcheck[i].body,
                                            fuel = vehcheck[i].fuel,
                                            housegar = isHouse
                                        }
                                    }
                                },
                            })
                            NoVehinGarage = false
                        end
                    elseif (garagevehs[i].state == 0 or garagevehs[i].state == 2 or vehcheck[i].depotprice > 0) and gName == "impoundlot" or gName == "policeimp" or gName == "emsimp" then
                        local vehname = QBCore.Shared.Vehicles[vehcheck[i].vehicle].name
                        local plate = vehcheck[i].plate
                        local fine = vehcheck[i].depotprice
                        TriggerClientEvent('nh-context:sendMenu', src, {
                            {
                                id = i,
                                header = vehname,
                                txt = "Plate: "..plate.." | Fine: "..fine.."$" ,
                                params = {
                                    event = "nc-garages:takeoutveh:depot",
                                    args = {
                                        vehicle = vehcheck[i]
                                    }
                                }
                            },
                        })
                        NoVehinGarage = false
                    end
                end
            end
            if NoVehinGarage then
                TriggerClientEvent('QBCore:Notify', src, "You have no vehicles here!", "error")
            end
            NoVehinGarage = true
        end)
    elseif Var.MySQL == "ghmattisql" then
        exports.ghmattimysql:execute("SELECT * FROM player_vehicles WHERE citizenid = ?", {citizenid}, function(vehcheck)
            if vehcheck ~= nil then   
                for i = 1, #vehcheck do
                    garagevehs[i] = {
                        state = vehcheck[i].state,
                        plate = vehcheck[i].plate,
                        name = vehcheck[i].vehicle:upper(),
                        garage = vehcheck[i].garage,
                    }
                    if gName == garagevehs[i].garage then
                        if garagevehs[i].state ~= 2 and garagevehs[i].state ~= 0 then
                            local vehname = QBCore.Shared.Vehicles[vehcheck[i].vehicle].name
                            local plate = vehcheck[i].plate
                            TriggerClientEvent('nh-context:sendMenu', src, {
                                {
                                    id = i,
                                    header = vehname,
                                    txt = "Plate: "..plate,
                                    params = {
                                        event = "nc-garages:client:attemptspawn",
                                        args = {
                                            veh = vehcheck[i],
                                            engine = vehcheck[i].engine,
                                            body = vehcheck[i].body,
                                            fuel = vehcheck[i].fuel,
                                            housegar = isHouse
                                        }
                                    }
                                },
                            })
                            NoVehinGarage = false
                        end
                    elseif (garagevehs[i].state == 0 or vehcheck[i].depotprice > 0) and gName == "hayesdepot" then
                        local vehname = QBCore.Shared.Vehicles[vehcheck[i].vehicle].name
                        local plate = vehcheck[i].plate
                        local fine = vehcheck[i].depotprice
                        TriggerClientEvent('nh-context:sendMenu', src, {
                            {
                                id = i,
                                header = vehname,
                                txt = "Plate: "..plate.." | Fine: "..fine.."$" ,
                                params = {
                                    event = "nc-garages:takeoutveh:depot",
                                    args = {
                                        vehicle = vehcheck[i]
                                    }
                                }
                            },
                        })
                        NoVehinGarage = false
                    end
                end
            end
            if NoVehinGarage then
                TriggerClientEvent('QBCore:Notify', src, "You have no vehicles here!", "error")
            end
            NoVehinGarage = true
        end)
    end
end)

RegisterServerEvent('nc-garages:server:attemptspawn')
AddEventHandler('nc-garages:server:attemptspawn', function(data)
    local pSrc = source
	local char = QBCore.Functions.GetPlayer(pSrc)
    local enginePercent = data.engine / 10
	local bodyPercent = data.body / 10
	TriggerClientEvent('nh-context:sendMenu', pSrc, {
		{
			id = 1,
			header = "< Go Back",
			txt = "Return to your list of all your vehicles.",
			params = {
				event = "nc-garages:open"
			}
		},
		{
			id = 2,
			header = "Take Out Vehicle",
			txt = "Spawn Selected Vehicle",
			params = {
				event = "nc-garages:Spawnveh",
				args = {
					vehicle = data.veh,
                    isHouse = data.housegar
				}
			}
			
		},
		{
			id = 3,
			header = "Vehicle Status",
			txt = "Fuel: "..data.fuel.."% | Engine: "..enginePercent.."% | Body: "..bodyPercent.."%"
		},
	})
end)

RegisterServerEvent('nc-garage:server:PayDepotPrice')
AddEventHandler('nc-garage:server:PayDepotPrice', function(plate)
    local src = source
    local Player = QBCore.Functions.GetPlayer(src)
    local bankBalance = Player.PlayerData.money["bank"]
    if Var.MySQL == "oxmysql" then
        exports['oxmysql']:execute('SELECT * FROM player_vehicles WHERE plate = @plate', {['@plate'] = plate}, function(result)
            if result[1] ~= nil then
                if bankBalance >= result[1].depotprice then
                    Player.Functions.RemoveMoney("bank", result[1].depotprice, "paid-depot")
                    exports['oxmysql']:execute('UPDATE player_vehicles SET depotprice = @depotprice WHERE plate = @plate', {['@depotprice'] = 0, ['@plate'] = plate})
                end
            end
        end)
    elseif Var.MySQL == "ghmattisql" then
        exports['ghmattimysql']:execute('SELECT * FROM player_vehicles WHERE plate = @plate', {['@plate'] = plate}, function(result)
            if result[1] ~= nil then
                if bankBalance >= result[1].depotprice then
                    Player.Functions.RemoveMoney("bank", result[1].depotprice, "paid-depot")
                    exports['ghmattimysql']:execute('UPDATE player_vehicles SET depotprice = @depotprice WHERE plate = @plate', {['@depotprice'] = 0, ['@plate'] = plate})
                end
            end
        end)
    end
end)

RegisterServerEvent('nc-garage:server:updateVehicleState')
AddEventHandler('nc-garage:server:updateVehicleState', function(state, plate, garage)
    if Var.MySQL == "oxmysql" then
        exports.oxmysql:execute('UPDATE player_vehicles SET state = ?, garage = ?, depotprice = ? WHERE plate = ?', {state, garage, 0, plate})
    elseif Var.MySQL == "ghmattisql" then
        exports.ghmattimysql:execute('UPDATE player_vehicles SET state = ?, garage = ?, depotprice = ? WHERE plate = ?', {state, garage, 0, plate})
    end
end)

RegisterServerEvent('nc-garage:server:updateVehicleStatus')
AddEventHandler('nc-garage:server:updateVehicleStatus', function(fuel, engine, body, plate, garage)
    local src = source
    local pData = QBCore.Functions.GetPlayer(src)

    if engine > 1000 then
        engine = engine / 1000
    end

    if body > 1000 then
        body = body / 1000
    end

    if Var.MySQL == "oxmysql" then
        exports.oxmysql:execute(
            'UPDATE player_vehicles SET fuel = ?, engine = ?, body = ? WHERE plate = ? AND citizenid = ? AND garage = ?',
            {fuel, engine, body, plate, pData.PlayerData.citizenid, garage})
    elseif Var.MySQL == "ghmattisql" then
        exports.ghmattimysql:execute(
            'UPDATE player_vehicles SET fuel = ?, engine = ?, body = ? WHERE plate = ? AND citizenid = ? AND garage = ?',
            {fuel, engine, body, plate, pData.PlayerData.citizenid, garage})
    end
end)

RegisterServerEvent('nc-garages:server:UpdateOutsideVehicles')
AddEventHandler('nc-garages:server:UpdateOutsideVehicles', function(Vehicles)
    local src = source
    local Ply = QBCore.Functions.GetPlayer(src)
    local CitizenId = Ply.PlayerData.citizenid

    OutsideVehicles[CitizenId] = Vehicles
end)

RegisterServerEvent('nc-garages:server:addHouseGarage')
AddEventHandler('nc-garages:server:addHouseGarage', function(house, garageInfo)
    HouseGarLoc[house] = garageInfo
end)

RegisterServerEvent('nc-garages:server:setVehicleOwned')
AddEventHandler('nc-garages:server:setVehicleOwned', function(mods, status, vehicle)
    local src = source
    local xPlayer = QBCore.Functions.GetPlayer(src)
    exports.oxmysql:insert("INSERT INTO `player_vehicles` (`citizenid`, `plate`, `vehicle`, `mods`, `status`, `state`) VALUES ('" .. xPlayer.PlayerData.citizenid .. "', '" .. mods.plate .. "', '" .. vehicle .. "', '" .. json.encode(mods) .. "', '" .. json.encode(status) .. "', 'out')")
end)

QBCore.Functions.CreateCallback("nc-garage:server:checkVehicleOwner", function(source, cb, plate)
    local src = source
    local pData = QBCore.Functions.GetPlayer(src)

    if Var.MySQL == "oxmysql" then
        exports.oxmysql:fetch('SELECT * FROM player_vehicles WHERE plate = ? AND citizenid = ?',
            {plate, pData.PlayerData.citizenid}, function(result)
                if result[1] ~= nil then
                    cb(true)
                else
                    cb(false)
                end
            end)
    elseif Var.MySQL == "ghmattisql" then
        exports.ghmattimysql:execute('SELECT * FROM player_vehicles WHERE plate = ? AND citizenid = ?',
        {plate, pData.PlayerData.citizenid}, function(result)
            if result[1] ~= nil then
                cb(true)
            else
                cb(false)
            end
        end)
    end
end)

QBCore.Functions.CreateCallback("nc-garage:server:GetUserVehicles", function(source, cb, garage)
    local src = source
    local pData = QBCore.Functions.GetPlayer(src)

    if Var.MySQL == "oxmysql" then
        exports.oxmysql:fetch('SELECT * FROM player_vehicles WHERE citizenid = ? AND garage = ?',
            {pData.PlayerData.citizenid, garage}, function(result)
                if result[1] ~= nil then
                    cb(result)
                else
                    cb(nil)
                end
            end)
    elseif Var.MySQL == "ghmattisql" then
        exports.ghmattimysql:execute('SELECT * FROM player_vehicles WHERE citizenid = ? AND garage = ?',
            {pData.PlayerData.citizenid, garage}, function(result)
                if result[1] ~= nil then
                    cb(result)
                else
                    cb(nil)
                end
            end)
    end
end)

QBCore.Functions.CreateCallback("nc-garage:server:GetVehicleProperties", function(source, cb, plate)
    local src = source
    local properties = {}
    local result = nil
    if Var.MySQL == "oxmysql" then
        result = exports.oxmysql:fetchSync('SELECT mods FROM player_vehicles WHERE plate = ?', {plate})
    elseif Var.MySQL == "ghmattisql" then
        result = exports.ghmattimysql:executeSync('SELECT mods FROM player_vehicles WHERE plate = ?', {plate})
    end
    if result[1] ~= nil then
        properties = json.decode(result[1].mods)
    end
    cb(properties)
end)

QBCore.Functions.CreateCallback("nc-garage:server:GetOutsideVehicles", function(source, cb)
    local Ply = QBCore.Functions.GetPlayer(source)
    local CitizenId = Ply.PlayerData.citizenid

    if OutsideVehicles[CitizenId] ~= nil and next(OutsideVehicles[CitizenId]) ~= nil then
        cb(OutsideVehicles[CitizenId])
    else
        cb(nil)
    end
end)

QBCore.Functions.CreateCallback("nc-garages:isAtHouseGar", function(source, cb)
    local src = source
    for k, v in pairs(HouseGarLoc) do
        if HouseGarLoc[k].takeVehicle.x ~= nil and HouseGarLoc[k].takeVehicle.y ~= nil and HouseGarLoc[k].takeVehicle.z ~= nil then
            if #(GetEntityCoords(GetPlayerPed(src)) - vector3(HouseGarLoc[k].takeVehicle.x, HouseGarLoc[k].takeVehicle.y, HouseGarLoc[k].takeVehicle.z)) < 5 then
                cb(true)
            end
        end
    end
end)

QBCore.Functions.CreateCallback("nc-garages:server:checkVehicleOwner", function(source, cb, plate)
    local src = source
    local pData = QBCore.Functions.GetPlayer(src)
    exports.oxmysql:execute('SELECT * FROM player_vehicles WHERE plate = ? AND citizenid = ?',{plate, pData.PlayerData.citizenid}, function(result)
    if result[1] then
    cb(true, result[1].balance)
    else
    cb(false)
    end
    end)
    end)

-- Haritha#3955 --
-- Haritha#3955 --
-- Haritha#3955 --
-- Haritha#3955 --
-- Haritha#3955 --