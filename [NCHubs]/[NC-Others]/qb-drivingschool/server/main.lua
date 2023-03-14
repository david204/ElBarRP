local QBCore = exports['qb-core']:GetCoreObject() 



RegisterNetEvent('qb-drivingschool:Payqb', function()
	local src = source
    local xPlayer = QBCore.Functions.GetPlayer(src)
	local bankamount = xPlayer.PlayerData.money["bank"]
	local ghuu = 500

	if bankamount >= ghuu then
		xPlayer.Functions.RemoveMoney('bank', 500)
	end
end)



RegisterServerEvent('qb-drivingschool:server:GetLicense', function()
    local src = source
    local Player = QBCore.Functions.GetPlayer(src)


    local info = {}
        info.firstname = Player.PlayerData.charinfo.firstname
        info.lastname = Player.PlayerData.charinfo.lastname
        info.birthdate = Player.PlayerData.charinfo.birthdate
        info.type = "A1-A2-A | AM-B | C1-C-CE"


    Player.Functions.AddItem('driver_license', 1, nil, info)

    TriggerClientEvent('inventory:client:ItemBox', src, QBCore.Shared.Items['driver_license'], 'add')
end)

