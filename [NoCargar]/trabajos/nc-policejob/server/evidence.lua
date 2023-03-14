local QBCore = exports['qb-core']:GetCoreObject()

QBCore.Commands.Add('evidence', 'Open evidence storage [case-number]', {}, false, function(source, args)
    local src = source
    local Player = QBCore.Functions.GetPlayer(src)

    if Player and (Player.PlayerData.job.name == 'police') then
        TriggerClientEvent('police:evidence', src, args[1])
    else
        TriggerClientEvent('chat:addMessage', src, {
            template = '<div class="chat-message server">SYSTEM: {0}</div>',
            args = { 'This command is for emergency services!' }
        })
    end
end)