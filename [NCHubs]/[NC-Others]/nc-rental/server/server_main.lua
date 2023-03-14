local QBCore = exports[Config.QBCoreName]:GetCoreObject()

QBCore.Functions.CreateCallback('nc-rental:server:VerifyMoney', function(source, cb, Price)
    local hasMoney = false
    local Player = QBCore.Functions.GetPlayer(source)

    if Player.Functions.GetMoney('bank') >= Price then
        cb(true)
    else
        cb(false)
        return
    end
end)

RegisterNetEvent('nc-rental:server:RentVehicle', function(RentPrice, VehicleLableName, VehiclePlate, TimeAmount, PlayerData)
    local Player = QBCore.Functions.GetPlayer(source)
    local info = {}
    info.name = PlayerData.charinfo.firstname .. " " .. PlayerData.charinfo.lastname
    info.plate = VehiclePlate
    info.time = TimeAmount
    info.price = RentPrice
    info.vehiclename = VehicleLableName

    Player.Functions.AddItem('rentalpapers', 1, nil, info)
    TriggerClientEvent('inventory:client:ItemBox', source, QBCore.Shared.Items["rentalpapers"], "add", 1)
    Player.Functions.RemoveMoney('bank', RentPrice)
end)

RegisterNetEvent('nc-rental:server:RemoveContract', function()
    local Player = QBCore.Functions.GetPlayer(source)

    Player.Functions.RemoveItem('rentalpapers', 1)
    TriggerClientEvent('inventory:client:ItemBox', source, QBCore.Shared.Items["rentalpapers"], "remove", 1)
end)

RegisterNetEvent('nc-rental:server:BillPlayer', function(FeesPrice)
    local Player = QBCore.Functions.GetPlayer(source)
    if Config.PhoneName == "qb-phone" then
        MySQL.Async.insert('INSERT INTO phone_invoices (citizenid, amount, society, sender, sendercitizenid) VALUES (?, ?, ?, ?, ?)',{
            Player.PlayerData.citizenid,
            FeesPrice,
            'Renting', 
            'Jóse das couves', 
            'CVS04712'
        })
        TriggerClientEvent(Config.QBPhoneName..':RefreshPhone', Player.PlayerData.source)
    elseif Config.PhoneName == "gksphone" then
        MySQL.Async.execute('INSERT INTO gksphone_invoices (citizenid, amount, society, sender, sendercitizenid, label) VALUES (@citizenid, @amount, @society, @sender, @sendercitizenid, @label)', {
            ['@citizenid'] = Player.PlayerData.citizenid,
            ['@amount'] = FeesPrice,
            ['@society'] = 'Renting',
            ['@sender'] = 'Jóse das couves',
            ['@sendercitizenid'] = 'CVS04712',
            ['@label'] = 'Renting',
        })
        TriggerClientEvent('gksphone:notifi', src, {title = 'Billing', message = Lang.InvoiceSuccess})
        TriggerClientEvent('gksphone:notifi', Player.PlayerData.source, {title = 'Billing', message = Lang.InvoiceRecieved})
    end
end)