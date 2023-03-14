QBCore = exports['qb-core']:GetCoreObject()

local wait = 60000*10

Citizen.CreateThread(function()
    while true do
        Wait(wait)
        TriggerServerEvent('crfw-paychecks:Register')
    end
end)

RegisterNetEvent('crfw-paychecks:targetcollect')
AddEventHandler('crfw-paychecks:targetcollect', function()
    TriggerServerEvent('crfw-paychecks:Collect')
end)

CreateThread(function()
    exports['qb-target']:AddBoxZone('paychecks', vector3(-1309.61, -822.77, 17.58), 1.5, 1.6, { 
        name = 'paychecks',
        heading = 49.43,
        debugPoly = false,
    }, {
        options = {
            {
                type = "client",
                event = "crfw-paychecks:targetcollect",
                icon = "fas fa-money-check-alt",
                label = "Collect Paycheck",
            },
        },           
        distance = 4.0
    })
end)