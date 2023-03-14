local QBCore = exports['qb-core']:GetCoreObject()

local ChillZonesArea = {
    vector3(-579.71, -1061.42, 22.35),
    vector3(800.97, -752.44, 26.78),
    vector3(120.27, -1038.09, 29.23),
    vector3(-1192.31, -889.83, 14.25),
    vector3(1589.2, 6454.53, 26.15),
    vector3(400.07, -3.79, 92.29),
    vector3(182.82, -244.94, 54.07)
}

ChillZone = false
Citizen.CreateThread(function()
    while true do
        for k,v in ipairs(ChillZonesArea) do
            local distance = #(GetEntityCoords(PlayerPedId()) - v)
            if distance < 15 then
                if ChillZone == true then
                    QBCore.Functions.Notify("Feeling more relaxed..", 'success', 2500)
                    break
                else
                    TriggerServerEvent('hud:server:RelieveStress', 2)
                end
            else
                ChillZone = false
            end
        end
        Citizen.Wait(10000)
    end
end)

local MoreChillZonesArea = {
    vector3(985.06, 52.36, 70.24)
}

MoreChillZone = false
Citizen.CreateThread(function()
    while true do
        for k,v in ipairs(MoreChillZonesArea) do
            local distance = #(GetEntityCoords(PlayerPedId()) - v)
            if distance < 15 then
                if MoreChillZone == true then
                    QBCore.Functions.Notify("Feeling not good..", 'success', 2500)
                    break
                else
                    TriggerServerEvent('hud:server:GainStress', math.random(1, 4))
                end
            else
                MoreChillZone = false
            end
        end
        Citizen.Wait(50000)
    end
end)