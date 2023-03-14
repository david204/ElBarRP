QBCore = exports['qb-core']:GetCoreObject()
RegisterNetEvent('mechanic:client:RepairVehicle', function()
	local vehicle = QBCore.Functions.GetClosestVehicle()
	if vehicle ~= nil and vehicle ~= 0 then
		local pos = GetEntityCoords(GetPlayerPed(-1))
		local vehpos = GetEntityCoords(vehicle)
		if (GetDistanceBetweenCoords(pos.x, pos.y, pos.z, vehpos.x, vehpos.y, vehpos.z, true) < 5.0) and not IsPedInAnyVehicle(GetPlayerPed(-1)) then
			local drawpos = GetOffsetFromEntityInWorldCoords(vehicle, 0, 2.5, 0)
			if (IsBackEngine(GetEntityModel(vehicle))) then
				drawpos = GetOffsetFromEntityInWorldCoords(vehicle, 0, -2.5, 0)
			end
			if (GetDistanceBetweenCoords(pos.x, pos.y, pos.z, drawpos) < 2.0) and not IsPedInAnyVehicle(GetPlayerPed(-1)) then
				RepairVehicle(vehicle)
			else
				ShowEnginePos = true
			end
		end
	end
end)

function RepairVehicle(vehicle)
	if (IsBackEngine(GetEntityModel(vehicle))) then
        SetVehicleDoorOpen(vehicle, 5, false, false)
    else
        SetVehicleDoorOpen(vehicle, 4, false, false)
    end
	QBCore.Functions.Progressbar("repair_vehicle", "Repairing..", 10000, false, true, {
		disableMovement = true,
		disableCarMovement = true,
		disableMouse = false,
		disableCombat = true,
	}, {
		animDict = "mini@repair",
		anim = "fixing_a_player",
		flags = 16,
	}, {}, {}, function()
		StopAnimTask(GetPlayerPed(-1), "mini@repair", "fixing_a_player", 1.0)
		QBCore.Functions.Notify("Vehicle engine partially repaired")
		SetVehicleEngineHealth(vehicle, 500.0)
		SetVehicleTyreFixed(vehicle, 0)
		SetVehicleTyreFixed(vehicle, 1)
		SetVehicleTyreFixed(vehicle, 2)
		SetVehicleTyreFixed(vehicle, 3)
		SetVehicleTyreFixed(vehicle, 4)
		if (IsBackEngine(GetEntityModel(vehicle))) then
			SetVehicleDoorShut(vehicle, 5, false)
		else
			SetVehicleDoorShut(vehicle, 4, false)
		end
		TriggerServerEvent('mechanic:server:RemoveItem', "repairkit")
	end, function()
		StopAnimTask(GetPlayerPed(-1), "mini@repair", "fixing_a_player", 1.0)
		if (IsBackEngine(GetEntityModel(vehicle))) then
			SetVehicleDoorShut(vehicle, 5, false)
		else
			SetVehicleDoorShut(vehicle, 4, false)
		end
	end)
end

RegisterNetEvent('mechanic:client:AdvancedRepairVehicle', function()
	local vehicle = QBCore.Functions.GetClosestVehicle()
	if vehicle ~= nil and vehicle ~= 0 then
		local pos = GetEntityCoords(GetPlayerPed(-1))
		local vehpos = GetEntityCoords(vehicle)
		if (GetDistanceBetweenCoords(pos.x, pos.y, pos.z, vehpos.x, vehpos.y, vehpos.z, true) < 5.0) and not IsPedInAnyVehicle(GetPlayerPed(-1)) then
			local drawpos = GetOffsetFromEntityInWorldCoords(vehicle, 0, 2.5, 0)
			if (IsBackEngine(GetEntityModel(vehicle))) then
				drawpos = GetOffsetFromEntityInWorldCoords(vehicle, 0, -2.5, 0)
			end
			if (GetDistanceBetweenCoords(pos.x, pos.y, pos.z, drawpos) < 2.0) and not IsPedInAnyVehicle(GetPlayerPed(-1)) then
				AdvancedRepairVehicle(vehicle)
			else
				ShowEnginePos = true
			end
		end
	end
end)

function AdvancedRepairVehicle(vehicle)
	if (IsBackEngine(GetEntityModel(vehicle))) then
        SetVehicleDoorOpen(vehicle, 5, false, false)
    else
        SetVehicleDoorOpen(vehicle, 4, false, false)
    end
	QBCore.Functions.Progressbar("repair_vehicle", "Repairing..", 14000, false, true, {
		disableMovement = true,
		disableCarMovement = true,
		disableMouse = false,
		disableCombat = true,
	}, {
		animDict = "mini@repair",
		anim = "fixing_a_player",
		flags = 16,
	}, {}, {}, function()
		StopAnimTask(GetPlayerPed(-1), "mini@repair", "fixing_a_player", 1.0)
		QBCore.Functions.Notify("Vehicle repaired")
		SetVehicleEngineHealth(vehicle, 1000.0)
		SetVehicleTyreFixed(vehicle, 0)
		SetVehicleTyreFixed(vehicle, 1)
		SetVehicleTyreFixed(vehicle, 2)
		SetVehicleTyreFixed(vehicle, 3)
		SetVehicleTyreFixed(vehicle, 4)
		SetVehicleFixed(vehicle)
		if (IsBackEngine(GetEntityModel(vehicle))) then
			SetVehicleDoorShut(vehicle, 5, false)
		else
			SetVehicleDoorShut(vehicle, 4, false)
		end
		TriggerServerEvent('mechanic:server:RemoveItem', "advancedrepairkit")
	end, function()
		StopAnimTask(GetPlayerPed(-1), "mini@repair", "fixing_a_player", 1.0)
		if (IsBackEngine(GetEntityModel(vehicle))) then
			SetVehicleDoorShut(vehicle, 5, false)
		else
			SetVehicleDoorShut(vehicle, 4, false)
		end
	end)
end

RegisterNetEvent('mechanic:client:CleanVehicle', function()
	local vehicle = QBCore.Functions.GetClosestVehicle()
	if vehicle ~= nil and vehicle ~= 0 then
		local pos = GetEntityCoords(GetPlayerPed(-1))
		local vehpos = GetEntityCoords(vehicle)
		if (GetDistanceBetweenCoords(pos.x, pos.y, pos.z, vehpos.x, vehpos.y, vehpos.z, true) < 3.0) and not IsPedInAnyVehicle(GetPlayerPed(-1)) then
			CleanVehicle(vehicle)	
		end
	end
end)

function CleanVehicle(vehicle)
	TaskStartScenarioInPlace(GetPlayerPed(-1), "WORLD_HUMAN_MAID_CLEAN", 0, true)
	QBCore.Functions.Progressbar("repair_vehicle", "Cleaning Vehicle...", 2000, false, true, {
		disableMovement = true,
		disableCarMovement = true,
		disableMouse = false,
		disableCombat = true,
	}, {}, {}, {}, function() -- Done
		QBCore.Functions.Notify("Vehicle Cleaned")
		SetVehicleDirtLevel(vehicle)
        SetVehicleUndriveable(vehicle, false)
		WashDecalsFromVehicle(vehicle, 1.0)
		ClearAllPedProps(GetPlayerPed(-1))
		ClearPedTasks(GetPlayerPed(-1))
	end, function()
		ClearAllPedProps(GetPlayerPed(-1))
		ClearPedTasks(GetPlayerPed(-1))
	end)
end

function IsBackEngine(vehModel)
    for _, model in pairs(BackEngineVehicles) do
        if GetHashKey(model) == vehModel then
            return true
        end
    end
    return false
end

local function notification(msg)
	QBCore.Functions.Notify(msg)
end

local function isPedDrivingAVehicle()
	local ped = GetPlayerPed(-1)
	vehicle = GetVehiclePedIsIn(ped, false)
	if IsPedInAnyVehicle(ped, false) then
		if GetPedInVehicleSeat(vehicle, -1) == ped then
			local class = GetVehicleClass(vehicle)
			if class ~= 15 and class ~= 16 and class ~=21 and class ~=13 then
				return true
			end
		end
	end
	return false
end