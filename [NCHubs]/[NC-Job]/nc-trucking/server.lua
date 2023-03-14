local QBCore = exports['qb-core']:GetCoreObject()

for k, v in pairs(Config.Jobs) do
    v['taken'] = false
end

RegisterServerEvent('start:truckingjob')
AddEventHandler('start:truckingjob', function()
    exports['qb-menu']:openMenu({
        {
            id = 1,
            header = "truckingjob",
            txt = "start work",
            params = {
                event = "esx_ets:startJob",
            }
        },
    })
end)
  ----------------------------------------------------
RegisterServerEvent('esx_ets:startJob')
AddEventHandler('esx_ets:startJob', function(id)
    local xPlayer, hasJob = QBCore.Functions.GetPlayer(source), true
    hasJob = true
    if Config.Job['jobRequired'] then
        if xPlayer.PlayerData.job.label == Config.Job['jobName'] then
            hasJob = true
        else
            hasJob = false
        end
    end
   if hasJob then
        if not Config.Jobs[id]['taken'] then
            Config.Jobs[id]['taken'] = true
            TriggerClientEvent('esx_ets:start', source, Config.Jobs[id], id)
        else
            TriggerClientEvent('QBCore:Notify', source, Strings['somebody_doing'], "error", 5000)
         
        end
    else
        TriggerClientEvent('QBCore:Notify', source, Strings['not_job'], "error", 5000)
       
    end
end)


     QBCore.Functions.CreateCallback("esx_ets:jobMenu",function(source, cb)
    local elements, xPlayer = {}, QBCore.Functions.GetPlayer(source)
    for k, v in pairs(Config.Jobs) do
        if not v['taken'] then
            table.insert(elements, {label = v.title, value = k})
        end
    end
    cb(elements)
   
end)

RegisterServerEvent('esx_ets:jobFinished')
AddEventHandler('esx_ets:jobFinished', function(id, damages)
    local xPlayer = QBCore.Functions.GetPlayer(source)
    if Config.Jobs[id]['taken'] then
        local price, health = Config.Jobs[id].payment, (damages['body_health'] + damages['engine_health']) / 2
        for k, v in pairs(damages['windows']) do health = health - 30 end
        for k, v in pairs(damages['tires']) do health = health - 35 end
        for k, v in pairs(damages['doors']) do health = health - 40 end
        if health <= 900 and health > 800 then
            price = price - 50
        elseif health <= 800 and health > 700 then
            price = price - 75
        elseif health <= 700 and health > 600 then
            price = price - 100
        elseif health <= 600 and health > 300 then
            price = price - 150
        elseif health <= 300 then
            price = price - 350
        end

        if price >= 0 then
            if price > 400 then
              xPlayer.Functions.AddMoney("cash",400)
              TriggerClientEvent('QBCore:Notify', source, 'cash added', 'success')
              --TriggerClientEvent('QBCore:Notify', source, (Strings['reward']):format(price), "success", 5000)
              --TriggerClientEvent('QBCore:Notify', 'cash added', "success", 5000)
            else
                xPlayer.Functions.AddMoney("cash",tonumber(price))
                TriggerClientEvent('QBCore:Notify', source, 'cash added', 'success')
            end
        else
            xPlayer.Functions.RemoveMoney("cash",tonumber(price))
            TriggerClientEvent('QBCore:Notify', source, 'cash for paid damages', 'error')
            --TriggerClientEvent('QBCore:Notify', source, (Strings['paid_damages']):format(price), "success", 5000)
        end
        Wait(Config.ReAdd * 1000)
        Config.Jobs[id]['taken'] = false
    end
end)



