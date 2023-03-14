local fixing, turn = false, false
local zcoords, mcolor = 0.0, 0
local position = 0

RegisterNetEvent('khrp:fixCarS', function()
	TriggerEvent('khrp:fixCar')		
end)

RegisterNetEvent('khrp:fixCar', function()
	local playerPed = GetPlayerPed(-1)
	local vehicle = GetVehiclePedIsIn(playerPed, false)
	fixing = true
	TriggerEvent('khrp:markAnimation')	
	FreezeEntityPosition(vehicle, true)
	TriggerServerEvent('khrp:costRepair')
	TriggerServerEvent('InteractSound_SV:PlayWithinDistance', 5.0, 'car_repair', 0.7)
	Wait(Config.RepairTime)
	fixing = false
	SetVehicleDeformationFixed(vehicle)
	FreezeEntityPosition(vehicle, false)
	SetVehicleEngineHealth(vehicle, 9999)
	SetVehiclePetrolTankHealth(vehicle, 9999)
	SetVehicleFixed(vehicle)
	zcoords, mcolor, turn = 0.0, 0, false
end)