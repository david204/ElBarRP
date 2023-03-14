local PlayerData
local PlayerJob

local createdBlips = {}

CreateThread(function()
	if Config.Framework == 'QBCORE' then
		QBCore = exports['qb-core']:GetCoreObject()
	end
	Wait(sleep)
	loadBlips()
end)

------ This is for QBCore
RegisterNetEvent('QBCore:Client:OnJobUpdate', function(JobInfo)
	PlayerJob = JobInfo
	for k,v in pairs(createdBlips) do
		RemoveBlip(v)
	end
	Wait(500)
	loadBlips()
end)
------



function loadBlips()
	print(getJob())
	for k,v in pairs(Config.Blips) do
		local canSee = false
		if #v.AllowedJobs == 0 then
			canSee = true
		end
		for key,val in pairs(v.AllowedJobs) do
			if val == getJob() then
				canSee = true
			end
		end
		if canSee then
			local blip = AddBlipForCoord(v.Coords.x, v.Coords.y, v.Coords.z)
			SetBlipSprite(blip, v.Blip.sprite)
			SetBlipDisplay(blip, 4)
			SetBlipScale(blip, v.Blip.size)
			SetBlipColour(blip, v.Blip.color)
			SetBlipAsShortRange(blip, true)
			BeginTextCommandSetBlipName("STRING")
			AddTextComponentString(v.Blip.name)
			EndTextCommandSetBlipName(blip)
			table.insert(createdBlips, blip)
		end
	end
end

function getJob()
	if Config.Framework == 'QBCORE' then
		local Player = QBCore.Functions.GetPlayerData()
		if Player ~= nil then
		PlayerJob = Player.job
		return PlayerJob.name
		end
	end
end
