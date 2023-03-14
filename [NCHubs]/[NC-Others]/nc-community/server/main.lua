local QBCore = exports['qb-core']:GetCoreObject() 

QBCore.Commands.Add("comserv", _U('give_player_community'), {{name = "id", help = _U('target_id')}, {name = "actions", help = _U('action_count_suggested')}}, false, function(source, args, user)
	local Player = QBCore.Functions.GetPlayer(source)
    if Player.PlayerData.job.name == "police" then
        if args[1] and GetPlayerName(args[1]) ~= nil and tonumber(args[2]) then
            TriggerEvent('qb-communityservice:sendToCommunityService', tonumber(args[1]), tonumber(args[2]))
        else
            TriggerClientEvent('chat:addMessage', source, { args = { _U('system_msn'), _U('invalid_player_id_or_actions') } } )
        end
    end
end,"admin")

QBCore.Commands.Add("punish", _U('give_player_community'), {{name = "id", help = _U('target_id')}, {name = "actions", help = _U('action_count_suggested')}}, false, function(source, args, user)
	local Player = QBCore.Functions.GetPlayer(source)
	if args[1] and GetPlayerName(args[1]) ~= nil and tonumber(args[2]) then
		TriggerEvent('qb-communityservice:sendToCommunityService', tonumber(args[1]), tonumber(args[2]))
	else
		TriggerClientEvent('chat:addMessage', source, { args = { _U('system_msn'), _U('invalid_player_id_or_actions') } } )
	end
end,"admin")

QBCore.Commands.Add("endpunish", "End Community Service", { { name = "id", help = _U('target_id') } }, false, function(source, args, user)
    local Player = QBCore.Functions.GetPlayer(source)

    if args[1] then
        if args[1] ~= nil then
            TriggerEvent('qb-communityservice:endCommunityServiceCommand', tonumber(args[1]))
        else
            TriggerClientEvent('chat:addMessage', source, { args = { _U('system_msn'), _U('invalid_player_id') } })
        end
     else
    end
end, "admin")

QBCore.Commands.Add("endcomserv", "End Community Service", { { name = "id", help = _U('target_id') } }, false, function(source, args, user)
    local Player = QBCore.Functions.GetPlayer(source)
    if Player.PlayerData.job.name == "police" then
        if args[1] then
            if args[1] ~= nil then
                TriggerEvent('qb-communityservice:endCommunityServiceCommand', tonumber(args[1]))
            else
                TriggerClientEvent('chat:addMessage', source, { args = { _U('system_msn'), _U('invalid_player_id') } })
            end
        else
        end
    end
end, "admin")

RegisterServerEvent('qb-communityservice:endCommunityServiceCommand', function(source)
    if source ~= nil then
        releaseFromCommunityService(source)
    end
end)

-- unjail after time served
RegisterServerEvent('qb-communityservice:finishCommunityService', function()
    releaseFromCommunityService(source)
end)

RegisterServerEvent('qb-communityservice:completeService', function()
    local _source = source
    local Player = QBCore.Functions.GetPlayer(_source)
    actions_remaining = tonumber(Player.PlayerData.metadata["communityservice"])
    Player.Functions.SetMetaData("communityservice", actions_remaining - 1)
end)

RegisterServerEvent('qb-communityservice:extendService', function()
    local _source = source
    local Player = QBCore.Functions.GetPlayer(_source)
 
    actions_remaining = tonumber(Player.PlayerData.metadata["communityservice"])
 
    Player.Functions.SetMetaData("communityservice", actions_remaining + Config.ServiceExtensionOnEscape)
end)

RegisterServerEvent('qb-communityservice:sendToCommunityService', function(target, actions_count)
    local _source = source
    local Player = QBCore.Functions.GetPlayer(target)
 
    Player.Functions.SetMetaData("communityservice", actions_count)
 
    TriggerClientEvent('qb-communityservice:inCommunityService', target, actions_count)
    TriggerClientEvent('chat:addMessage', -1, {args = {_U('judge'), _U('comserv_msg', GetPlayerName(target), actions_count)}, color = {147, 196, 109}})
end)

RegisterServerEvent('qb-communityservice:checkIfSentenced', function()
    local _source = source
    local Player = QBCore.Functions.GetPlayer(_source)
    actions_remaining = tonumber(Player.PlayerData.metadata["communityservice"])
    if actions_remaining > 0 then
        TriggerClientEvent('qb-communityservice:inCommunityService', _source, actions_remaining)
 
    end
end)

function releaseFromCommunityService(target)
    local Player = QBCore.Functions.GetPlayer(target)
    Player.Functions.SetMetaData("communityservice", 0)
    TriggerClientEvent('qb-communityservice:finishCommunityService', target)
    TriggerClientEvent('chat:addMessage', -1, {args = {_U('judge'), _U('comserv_finished', GetPlayerName(target))}, color = {147, 196, 109}})
end
