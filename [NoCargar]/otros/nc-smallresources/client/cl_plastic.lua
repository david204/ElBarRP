local startX = 333.11  --starting
local startY = -572.64
local startZ = 43.32

--[[ CreateThread(function()
    while true do
	Wait(sleep)
		local plyCoords = GetEntityCoords(PlayerPedId(), false)
		local dist = Vdist(plyCoords.x, plyCoords.y, plyCoords.z, startX, startY, startZ)

		if dist <= 2.5 then
		DrawText3D(startX, startY, startZ, "Press ~b~[E]~w~ For Plastic Surgery")
		end

		if dist <= 1.5 then
			if IsControlJustReleased(0, 38) then -- "E"
				QBCore.Functions.TriggerCallback('QBCore:HasItem', function(result)
					if result then
						TriggerServerEvent("qb-plastics:surgeryfuck")
						TriggerEvent('qb-clothing:client:openMenu')
					else
						QBCore.Functions.Notify("You Don't Have Surgery Pass , Contact with Doctor", "error")
					end
			
				end, 'surgerypass')		
			end			
		end
	end
end)
 ]]
RegisterNetEvent('qb-plastic:surgery' , function()
	QBCore.Functions.TriggerCallback('QBCore:HasItem', function(result)
		if result then
			TriggerServerEvent("qb-plastics:surgeryfuck")
			TriggerEvent('qb-clothing:client:openMenu')
		else
			QBCore.Functions.Notify("You Don't Have Surgery Pass , Contact with Doctor", "error")
		end

	end, 'surgerypass')	
end)


function DrawText3D(x, y, z, text)
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