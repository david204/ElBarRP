local QBCore = exports['qb-core']:GetCoreObject()

RegisterServerEvent('nc-speedcamera:PayBill', function(amount)
	local xPlayer = QBCore.Functions.GetPlayer(source)
	xPlayer.Functions.RemoveMoney("bank", amount)
end)


RegisterServerEvent('nc-speedcamera:openGUI', function()
	TriggerClientEvent('nc-speedcamera:openGUI', source)
end)

RegisterServerEvent('nc-speedcamera:closeGUI', function()
	TriggerClientEvent('nc-speedcamera:closeGUI', source)
end)

QBCore.Functions.CreateCallback("nc-speedcameras:server:checkOwnership", function(source, cb, plate)
	local src = source
    local pData = QBCore.Functions.GetPlayer(src)
	MySQL.query('SELECT * FROM player_vehicles WHERE citizenid = ? AND plate = ?', {pData.PlayerData.citizenid, plate}, function(result)
		if result[1] then
			cb(true)
		else
			cb(false)
		end
	end)
end)