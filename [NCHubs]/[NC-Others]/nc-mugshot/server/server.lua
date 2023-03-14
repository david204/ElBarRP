local QBCore = exports['qb-core']:GetCoreObject()

local MugShots = {}

RegisterNetEvent('nc-mugshot:server:triggerSuspect', function(suspect)
    TriggerClientEvent('nc-mugshot:client:trigger', suspect, suspect)
end)

RegisterNetEvent('nc-mugshot:server:MDTupload', function(citizenid, MugShotURLs)
    MugShots[citizenid] = MugShotURLs
    if Config.CQCMDT then
        TriggerEvent('cqc-mdt:server:updateMugShotForCitizen',citizenid, MugShotURLs)
    end
end)

--Allows external resources to pull most recent mugshot urls for a given citizen id
QBCore.Functions.CreateCallback(function(source, cb, citizenid) 
    cb(MugShots[citizenid])
end)