--[[ local density = 0.4 ]]
CreateThread(function()
	while true do
		SetParkedVehicleDensityMultiplierThisFrame(0.8)
		SetVehicleDensityMultiplierThisFrame(0.6)
		SetRandomVehicleDensityMultiplierThisFrame(0.2)
		SetPedDensityMultiplierThisFrame(1.0)
		SetScenarioPedDensityMultiplierThisFrame(0.8, 0.8) -- Walking NPC Density
		Wait(0)
	end
end)
