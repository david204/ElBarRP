local state = false

CreateThread(function()
    for k, v in pairs(Depots) do
        if v.showBlip then
            local Depot = AddBlipForCoord(Depots[k].Blip.x, Depots[k].Blip.y, Depots[k].Blip.z)
            SetBlipSprite (Depot, 68)
            SetBlipDisplay(Depot, 4)
            SetBlipScale  (Depot, 0.7)
            SetBlipAsShortRange(Depot, true)
            SetBlipColour(Depot, 5)
            BeginTextCommandSetBlipName("STRING")
            AddTextComponentSubstringPlayerName(Depots[k].label)
            EndTextCommandSetBlipName(Depot)
        end
    end
    
    if Var.BlipsonStartup then
        ToggleGarageBlips()
    end
end)

function ToggleGarageBlips() 
    state = not state
    for k, v in pairs(Garages) do
        if v.showBlip then
            if state then
                v.blip = AddBlipForCoord(Garages[k].Blip.x, Garages[k].Blip.y, Garages[k].Blip.z)
                SetBlipSprite (v.blip, 357)
                SetBlipDisplay(v.blip, 4)
                SetBlipScale  (v.blip, 0.65)
                SetBlipAsShortRange(v.blip, true)
                SetBlipColour(v.blip, 3)
                BeginTextCommandSetBlipName("STRING")
                AddTextComponentSubstringPlayerName(Garages[k].label)
                EndTextCommandSetBlipName(v.blip)
            else
                RemoveBlip(v.blip)
            end
        end
    end
end

function GetCurrentGarage()
    local ply = PlayerPedId()
    local plypos = GetEntityCoords(ply)
    for k, v in pairs(Garages) do
        local takeDist = #(plypos - vector3(Garages[k].polyzone.x, Garages[k].polyzone.y, Garages[k].polyzone.z))
        if takeDist <= 28 then
            return k
        end
    end
end

function GetGangGarage()
    local ply = PlayerPedId()
    local plypos = GetEntityCoords(ply)
    for k, v in pairs(GangGarages) do
        local takeDist = #(plypos - vector3(GangGarages[k].polyzone.x, GangGarages[k].polyzone.y, GangGarages[k].polyzone.z))
        if takeDist <= 25 then
            return k
        end
    end
end

local currentHouseGarage = nil

RegisterNetEvent('nc-garages:client:setHouseGarage')
AddEventHandler('nc-garages:client:setHouseGarage', function(house, hasKey)
    currentHouseGarage = tostring(house)
    hasGarageKey = hasKey
end)

RegisterNetEvent('nc-garages:client:houseGarageConfig')
AddEventHandler('nc-garages:client:houseGarageConfig', function(garageConfig)
    HouseGarages = garageConfig
end)

NearestHouseGarage = function()
    local ped = PlayerPedId()
    local pos = GetEntityCoords(ped)
    if HouseGarages ~= nil and currentHouseGarage ~= nil then
        if hasGarageKey and HouseGarages[currentHouseGarage] ~= nil then
            local takeDist = GetDistanceBetweenCoords(pos, HouseGarages[currentHouseGarage].takeVehicle.x, HouseGarages[currentHouseGarage].takeVehicle.y, HouseGarages[currentHouseGarage].takeVehicle.z)
            if takeDist <= 25 then
                return currentHouseGarage
            end
        end
    end
end

exports("isNearHouseGarage", NearestHouseGarage)

function GetJobGarage()
    local ply = PlayerPedId()
    local plypos = GetEntityCoords(ply)
    for k, v in pairs(JobGarages) do
        local takeDist = #(plypos - vector3(JobGarages[k].polyzone.x, JobGarages[k].polyzone.y, JobGarages[k].polyzone.z))
        if takeDist <= 28 then
            return k
        end
    end
end

function GetDepotsDist()
    local ply = PlayerPedId()
    local plypos = GetEntityCoords(ply)
    for k, v in pairs(Depots) do
        local takeDist = #(plypos - vector3(Depots[k].polyzone.x, Depots[k].polyzone.y, Depots[k].polyzone.z))
        if takeDist <= 10 then
            return k
        end
    end
end

function getVehicleInDirection(coordFrom, coordTo)
	local offset = 0
	local rayHandle
	local vehicle
	for i = 0, 100 do
		rayHandle = CastRayPointToPoint(coordFrom.x, coordFrom.y, coordFrom.z, coordTo.x, coordTo.y, coordTo.z + offset, 10, PlayerPedId(), 0)	
		a, b, c, d, vehicle = GetRaycastResult(rayHandle)
		offset = offset - 1
		if vehicle ~= 0 then break end
	end
	local distance = Vdist2(coordFrom, GetEntityCoords(vehicle))
	if distance > 25 then vehicle = nil end
    return vehicle ~= nil and vehicle or 0
end

function round(num, numDecimalPlaces)
    return tonumber(string.format("%." .. (numDecimalPlaces or 0) .. "f", num))
end

function doCarDamage(currentVehicle, veh)
	smash = false
	damageOutside = false
	damageOutside2 = false
	local engine = veh.engine + 0.0
	local body = veh.body + 0.0
	if engine < 200.0 then
		engine = 200.0
    end

    if engine > 1000.0 then
        engine = 1000.0
    end

	if body < 150.0 then
		body = 150.0
	end
	if body < 900.0 then
		smash = true
	end

	if body < 800.0 then
		damageOutside = true
	end

	if body < 500.0 then
		damageOutside2 = true
	end

    Citizen.Wait(100)
    SetVehicleEngineHealth(currentVehicle, engine)

	if smash then
		SmashVehicleWindow(currentVehicle, 0)
		SmashVehicleWindow(currentVehicle, 1)
		SmashVehicleWindow(currentVehicle, 2)
		SmashVehicleWindow(currentVehicle, 3)
		SmashVehicleWindow(currentVehicle, 4)
	end

	if damageOutside then
		SetVehicleDoorBroken(currentVehicle, 1, true)
		SetVehicleDoorBroken(currentVehicle, 6, true)
		SetVehicleDoorBroken(currentVehicle, 4, true)
	end

	if damageOutside2 then
		SetVehicleTyreBurst(currentVehicle, 1, false, 990.0)
		SetVehicleTyreBurst(currentVehicle, 2, false, 990.0)
		SetVehicleTyreBurst(currentVehicle, 3, false, 990.0)
		SetVehicleTyreBurst(currentVehicle, 4, false, 990.0)
	end

	if body < 1000 then
		SetVehicleBodyHealth(currentVehicle, 985.1)
	end
end