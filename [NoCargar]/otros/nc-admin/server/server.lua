-- Variables
local QBCore = exports['qb-core']:GetCoreObject()
local frozen = false
local permissions = {
    ['kill'] = 'god',
    ['ban'] = 'god',
    ['noclip'] = 'admin',
    ['kickall'] = 'god',
    ['kick'] = 'admin'
}

-- Get Dealers
QBCore.Functions.CreateCallback('test:getdealers', function(source, cb)
    cb(exports['nc-drugs']:GetDealers())
end)

-- Get Players
QBCore.Functions.CreateCallback('test:getplayers', function(source, cb) -- WORKS
    local players = {}
    for k, v in pairs(QBCore.Functions.GetPlayers()) do
        local targetped = GetPlayerPed(v)
        local ped = QBCore.Functions.GetPlayer(v)
        players[#players+1] = {
            name = ped.PlayerData.charinfo.firstname .. ' ' .. ped.PlayerData.charinfo.lastname .. ' | (' .. GetPlayerName(v) .. ')',
            id = v,
            coords = GetEntityCoords(targetped),
            cid = ped.PlayerData.charinfo.firstname .. ' ' .. ped.PlayerData.charinfo.lastname,
            citizenid = ped.PlayerData.citizenid,
            sources = GetPlayerPed(ped.PlayerData.source),
            sourceplayer= ped.PlayerData.source

        }
    end
        -- Sort players list by source ID (1,2,3,4,5, etc) --
        table.sort(players, function(a, b)
            return a.id < b.id
        end)
        ------
    cb(players)
end)

QBCore.Functions.CreateCallback('qb-admin:server:getrank', function(source, cb)
    local src = source
    if QBCore.Functions.HasPermission(src, 'user') or IsPlayerAceAllowed(src, 'command') then
        cb(true)
    else
        cb(false)
    end
end)

-- Functions

local function tablelength(table)
    local count = 0
    for _ in pairs(table) do
        count = count + 1
    end
    return count
end

QBCore.Commands.Add('police', 'Police message.', {}, false, function(source, args)
	-- If From Console
	if source == 0 then
		TriggerClientEvent('chat:addMessage', -1, {
        	template = '<div class="chat-message" style="background-color: rgba(52, 67, 235, 0.75);">{0} <b>Police</b> <img src=' .. Config.Images.Police .. ' style="width:22px; padding-right: 5px; position:relative ; top: 3px;height:20px ;"></img></div>',
        	args = { args }
    	})
		
		TriggerEvent('barbaronn:SendWebhookDiscordMsg', Config.Logs, "CONSOLE", "```[Police] " .. args .. "```" )
		return
	end

	-- Emojis Stuff
	args = table.concat(args, ' ')
	args = args:gsub("%:heart:", "❤️")
    args = args:gsub("%:smile:", "🙂")
    args = args:gsub("%:thinking:", "🤔")
    args = args:gsub("%:check:", "✅")
    args = args:gsub("%:hot:", "🥵")
    args = args:gsub("%:sad:", "😦")

    -- Permmisions Stuff
	local xPlayer = QBCore.Functions.GetPlayer(source)
	if xPlayer.PlayerData.job ~= nil and xPlayer.PlayerData.job.name == 'police' then
		TriggerClientEvent('chat:addMessage', -1, {
        	template = '<div class="chat-message" style="background-color: rgba(52, 67, 235, 0.75);"><b>Police</b> {0}<img src=' .. Config.Images.Police .. ' style="width:22px; padding-right: 5px; position:relative ; top: 5px;height:20px ;"></img></div>',
        	args = { args }
    	})
	else
		TriggerClientEvent('chat:addMessage', source, {
        	template = '<div class="chat-message" style="background-color: rgba(66, 66, 66, 0.75); color: white;"><img src=' .. Config.Images.System .. ' style="width:22px; padding-right: 5px; position:relative ; top: 5px;height:20px ;"></img><b>ADMIN</b> You are not a police officer</div>',
        	args = {}
    	})
	end
	
	-- Logs Stuff
	TriggerEvent('barbaronn:SendWebhookDiscordMsg', Config.Logs, GetPlayerName(source) .. " | " .. GetPlayerIdentifiers(source)[1], "```[Police] " .. args .. "```" )
end)

QBCore.Commands.Add('ems', 'EMS Message.', {}, false, function(source, args)
	-- If From Console
	if source == 0 then
		TriggerClientEvent('chat:addMessage', -1, {
        	template = '<div class="chat-message" style="background-color: rgba(163, 62, 48, 0.75);">{0} <b>EMS</b> <img src=' .. Config.Images.Ems .. ' style="width:22px; padding-right: 5px; position:relative ; top: 3px;height:20px ;"></img></div>',
        	args = { args }
    	})
		
		TriggerEvent('barbaronn:SendWebhookDiscordMsg', Config.Logs, "CONSOLE", "```[Police] " .. args .. "```" )
		return
	end

	-- Emojis Stuff
	args = table.concat(args, ' ')
	args = args:gsub("%:heart:", "❤️")
    args = args:gsub("%:smile:", "🙂")
    args = args:gsub("%:thinking:", "🤔")
    args = args:gsub("%:check:", "✅")
    args = args:gsub("%:hot:", "🥵")
    args = args:gsub("%:sad:", "😦")

    -- Permmisions Stuff
	local xPlayer = QBCore.Functions.GetPlayer(source)
	if xPlayer.PlayerData.job ~= nil and xPlayer.PlayerData.job.name == 'ambulance' then
		TriggerClientEvent('chat:addMessage', -1, {
        	template = '<div class="chat-message" style="background-color: rgba(255, 0, 21, 0.75);"><b>EMS</b> {0}<img src=' .. Config.Images.Ems .. ' style="width:22px; padding-right: 5px; position:relative ; top: 5px;height:20px ;"></img></div>',
        	args = { args }
    	})
	else
		TriggerClientEvent('chat:addMessage', source, {
        	template = '<div class="chat-message" style="background-color: rgba(66, 66, 66, 0.75); color: white;"><img src=' .. Config.Images.System .. ' style="width:22px; padding-right: 5px; position:relative ; top: 5px;height:20px ;"></img><b>ADMIN</b> You are not an EMS employer</div>',
        	args = {}
    	})
	end
	
	-- Logs Stuff
	TriggerEvent('barbaronn:SendWebhookDiscordMsg', Config.Logs, GetPlayerName(source) .. " | " .. GetPlayerIdentifiers(source)[1], "```[Police] " .. args .. "```" )
end)


RegisterCommand('staff', function(source, args, rawCommand)
	-- If From Console
	if source == 0 then
		TriggerClientEvent('chat:addMessage', -1, {
        	template = '<div class="chat-message" style="background-color: rgba(255, 0, 0, 0.75);"><img src=' .. Config.Images.System .. ' style="width:22px; padding-right: 5px; position:relative ; top: 3px;height:20px ;"></img><b>ADMIN:</b> {0}</div>',
        	args = { args }
    	})
		return
	end

	-- Emojis Stuff
	args = table.concat(args, ' ')
	args = args:gsub("%:heart:", "❤️")
    args = args:gsub("%:smile:", "🙂")
    args = args:gsub("%:thinking:", "🤔")
    args = args:gsub("%:check:", "✅")
    args = args:gsub("%:hot:", "🥵")
    args = args:gsub("%:sad:", "😦")

    -- Permmisions Stuff
	local xPlayerGroup = QBCore.Functions.GetPermission(source)
	if xPlayerGroup ~= nil and xPlayerGroup ~= "user" then
		TriggerClientEvent('chat:addMessage', -1, {
        	template = '<div class="chat-message" style="background-color: rgba(163, 62, 48, 0.75);"><img src=' .. Config.Images.System .. ' style="width:22px; padding-right: 5px; position:relative ; top: 3px;height:20px ;"></img><b>ADMIN:</b> {0}</div>',
        	args = { args }
    	})
	else
		TriggerClientEvent('chat:addMessage', source, {
        	template = '<div class="chat-message" style="background-color: rgba(66, 66, 66, 0.75); color: white;"><img src=' .. Config.Images.System .. ' style="width:22px; padding-right: 5px; position:relative ; top: 5px;height:20px ;"></img><b>ADMIN</b> You are not a staff member</div>',
        	args = {}
    	})
	end
	
	-- Logs Stuff
	TriggerEvent('barbaronn:SendWebhookDiscordMsg', Config.Logs, GetPlayerName(source) .. " | " .. GetPlayerIdentifiers(source)[1], "```[Police] " .. args .. "```" )
end, false)

-- Events

QBCore.Commands.Add("ac", "Send message to all staff", {{name="message", help="Message that you want to send"}}, true, function(source, args)
    local msg = table.concat(args, " ")
    TriggerClientEvent('nc-admin:client:SendStaffChat', -1, GetPlayerName(source), msg)
end, "admin")

RegisterServerEvent('nc-admin:server:StaffChatMessage')
AddEventHandler('nc-admin:server:StaffChatMessage', function(name, msg)
    local src = source
    local Players = QBCore.Functions.GetPlayers()
    if QBCore.Functions.HasPermission(src, "admin") then

            TriggerClientEvent('chat:addMessage', src, {
                template = '<div class="chat-message" style="background-color: rgba(201, 41, 45, 0.75);">STAFF CHAT | {0} <b>{1}</b></div>',
                args = {name, " "..msg}
            })
            --TriggerClientEvent('chatMessage', src, "STAFFCHAT - "..name, "error", msg)
    end
end)


RegisterNetEvent('qb-admin:server:GetPlayersForBlips', function()
    local src = source
    local players = {}
    for k, v in pairs(QBCore.Functions.GetPlayers()) do
        local targetped = GetPlayerPed(v)
        local ped = QBCore.Functions.GetPlayer(v)
        players[#players+1] = {
            name = ped.PlayerData.charinfo.firstname .. ' ' .. ped.PlayerData.charinfo.lastname .. ' | ' .. GetPlayerName(v),
            id = v,
            coords = GetEntityCoords(targetped),
            cid = ped.PlayerData.charinfo.firstname .. ' ' .. ped.PlayerData.charinfo.lastname,
            citizenid = ped.PlayerData.citizenid,
            sources = GetPlayerPed(ped.PlayerData.source),
            sourceplayer= ped.PlayerData.source
        }
    end
    TriggerClientEvent('qb-admin:client:Show', src, players)
end)

RegisterNetEvent('qb-admin:server:kill', function(player)
    TriggerClientEvent('hospital:client:KillPlayer', player.id)
end)

RegisterNetEvent('qb-admin:server:revive', function(player)
    TriggerClientEvent('hospital:client:Revive', player.id)
end)

RegisterNetEvent('qb-admin:server:kick', function(player, reason)
    local src = source
    if QBCore.Functions.HasPermission(src, permissions['kick']) or IsPlayerAceAllowed(src, 'command')  then
        TriggerEvent('qb-log:server:CreateLog', 'bans', 'Player Kicked', 'red', string.format('%s was kicked by %s for %s', GetPlayerName(player.id), GetPlayerName(src), reason), true)
        DropPlayer(player.id, 'You have been kicked from the server:\n' .. reason .. '\n\n🔸 Check our Discord for more information: ' .. QBCore.Config.Server.discord)
    end
end)

RegisterNetEvent('qb-admin:server:ban', function(player, time, reason)
    local src = source
    if QBCore.Functions.HasPermission(src, permissions['ban']) or IsPlayerAceAllowed(src, 'command') then
        local time = tonumber(time)
        local banTime = tonumber(os.time() + time)
        if banTime > 2147483647 then
            banTime = 2147483647
        end
        local timeTable = os.date('*t', banTime)
        exports.oxmysql:insert('INSERT INTO bans (name, license, discord, ip, reason, expire, bannedby) VALUES (?, ?, ?, ?, ?, ?, ?)', {
            GetPlayerName(player.id),
            QBCore.Functions.GetIdentifier(player.id, 'license'),
            QBCore.Functions.GetIdentifier(player.id, 'discord'),
            QBCore.Functions.GetIdentifier(player.id, 'ip'),
            reason,
            banTime,
            GetPlayerName(src)
        })
        TriggerClientEvent('chat:addMessage', -1, {
            template = "<div class=chat-message server'><strong>ANNOUNCEMENT | {0} has been banned:</strong> {1}</div>",
            args = {GetPlayerName(player.id), reason}
        })
        TriggerEvent('qb-log:server:CreateLog', 'bans', 'Player Banned', 'red', string.format('%s was banned by %s for %s', GetPlayerName(player.id), GetPlayerName(src), reason), true)
        if banTime >= 2147483647 then
            DropPlayer(player.id, 'You have been banned:\n' .. reason .. '\n\nYour ban is permanent.\n🔸 Check our Discord for more information: ' .. QBCore.Config.Server.discord)
        else
            DropPlayer(player.id, 'You have been banned:\n' .. reason .. '\n\nBan expires: ' .. timeTable['day'] .. '/' .. timeTable['month'] .. '/' .. timeTable['year'] .. ' ' .. timeTable['hour'] .. ':' .. timeTable['min'] .. '\n🔸 Check our Discord for more information: ' .. QBCore.Config.Server.discord)
        end
    end
end)

RegisterNetEvent('qb-admin:server:spectate')
AddEventHandler('qb-admin:server:spectate', function(player)
    local src = source
    local targetped = GetPlayerPed(player.id)
    local coords = GetEntityCoords(targetped)
    TriggerClientEvent('qb-admin:client:spectate', src, player.id, coords)
end)

RegisterNetEvent('qb-admin:server:freeze')
AddEventHandler('qb-admin:server:freeze', function(player)
    local target = GetPlayerPed(player.id)
    if not frozen then
        frozen = true
        FreezeEntityPosition(target, true)
    else
        frozen = false
        FreezeEntityPosition(target, false)
    end
end)

RegisterNetEvent('qb-admin:server:goto', function(player)
    local src = source
    local admin = GetPlayerPed(src)
    local coords = GetEntityCoords(GetPlayerPed(player.id))
    SetEntityCoords(admin, coords)
end)

RegisterNetEvent('qb-admin:server:intovehicle', function(player)
    local src = source
    local admin = GetPlayerPed(src)
    -- local coords = GetEntityCoords(GetPlayerPed(player.id))
    local targetPed = GetPlayerPed(player.id)
    local vehicle = GetVehiclePedIsIn(targetPed,false)
    local seat = -1
    if vehicle ~= 0 then
        for i=0,8,1 do
            if GetPedInVehicleSeat(vehicle,i) == 0 then
                seat = i
                break
            end
        end
        if seat ~= -1 then
            SetPedIntoVehicle(admin,vehicle,seat)
            TriggerClientEvent('QBCore:Notify', src, 'Entered vehicle', 'success', 5000)
        else
            TriggerClientEvent('QBCore:Notify', src, 'The vehicle has no free seats!', 'danger', 5000)
        end
    end
end)

RegisterNetEvent('qb-admin:server:bring', function(player)
    local src = source
    local admin = GetPlayerPed(src)
    local coords = GetEntityCoords(admin)
    local target = GetPlayerPed(player.id)
    SetEntityCoords(target, coords)
end)

RegisterNetEvent('qb-admin:server:inventory', function(player)
    local src = source
    TriggerClientEvent('qb-admin:client:inventory', src, player.id)
end)

RegisterNetEvent('qb-admin:server:cloth', function(player)
    TriggerClientEvent('yonatan:clothing', player.id)
end)

RegisterNetEvent('qb-admin:server:setPermissions', function(targetId, group)
    local src = source
    if QBCore.Functions.HasPermission(src, 'god') or IsPlayerAceAllowed(src, 'command') then
        QBCore.Functions.AddPermission(targetId, group[1].rank)
        TriggerClientEvent('QBCore:Notify', targetId, 'Your Permission Level Is Now '..group[1].label)
    end
end)

RegisterNetEvent('qb-admin:server:SendReport', function(name, targetSrc, msg)
    local src = source
    if QBCore.Functions.HasPermission(src, 'admin') or IsPlayerAceAllowed(src, 'command') then
        if QBCore.Functions.IsOptin(src) then
            TriggerClientEvent('chat:addMessage', src, {
                color = {255, 0, 0},
                multiline = true,
                args = {'Admin Report - '..name..' ('..targetSrc..')', msg}
            })
        end
    end
end)

RegisterNetEvent('qb-admin:server:Staffchat:addMessage', function(name, msg)
    local src = source
    if QBCore.Functions.HasPermission(src, 'admin') or IsPlayerAceAllowed(src, 'command') then
        if QBCore.Functions.IsOptin(src) then
            TriggerClientEvent('chat:addMessage', src, 'STAFFCHAT - '..name, 'error', msg)
        end
    end
end)

RegisterNetEvent('qb-admin:server:SaveCar', function(mods, vehicle, hash, plate)
    local src = source
    local Player = QBCore.Functions.GetPlayer(src)
    local result = exports.oxmysql:executeSync('SELECT plate FROM player_vehicles WHERE plate = ?', { plate })
    if result[1] == nil then
        exports.oxmysql:insert('INSERT INTO player_vehicles (license, citizenid, vehicle, hash, mods, plate, state) VALUES (?, ?, ?, ?, ?, ?, ?)', {
            Player.PlayerData.license,
            Player.PlayerData.citizenid,
            vehicle.model,
            vehicle.hash,
            json.encode(mods),
            plate,
            0
        })
        TriggerClientEvent('QBCore:Notify', src, 'The vehicle is now yours!', 'success', 5000)
    else
        TriggerClientEvent('QBCore:Notify', src, 'This vehicle is already yours..', 'error', 3000)
    end
end)

-- Commands

QBCore.Commands.Add('blips', 'Show blips for players (Admin Only)', {}, false, function(source)
    local src = source
    TriggerClientEvent('qb-admin:client:toggleBlips', src)
end, 'admin')

QBCore.Commands.Add('names', 'Show player name overhead (Admin Only)', {}, false, function(source)
    local src = source
    TriggerClientEvent('qb-admin:client:toggleNames', src)
end, 'admin')

QBCore.Commands.Add('coords', 'Enable coord display for development stuff (Admin Only)', {}, false, function(source)
    local src = source
    TriggerClientEvent('qb-admin:client:ToggleCoords', src)
end, 'admin')

QBCore.Commands.Add('noclip', 'Toggle noclip (Admin Only)', {}, false, function(source)
    local src = source
    TriggerClientEvent('qb-admin:client:ToggleNoClip', src)
end, 'admin')

QBCore.Commands.Add('admincar', 'Save Vehicle To Your Garage (Admin Only)', {}, false, function(source, args)
    local ply = QBCore.Functions.GetPlayer(source)
    TriggerClientEvent('qb-admin:client:SaveCar', source)
end, 'admin')

QBCore.Commands.Add('say', 'Make An Announcement (Admin Only)', {}, false, function(source, args)
    local msg = table.concat(args, ' ')
    if msg == '' then return end
    TriggerClientEvent('chat:addMessage', -1, {
        color = { 255, 0, 0},
        multiline = true,
        args = {"Announcement", msg}
    })
end, 'admin')

QBCore.Commands.Add('admin', 'Open Admin Menu (Admin Only)', {}, false, function(source, args)
    TriggerClientEvent('qb-admin:client:openMenu', source)
end, 'admin')

-- QBCore.Commands.Add('report', 'Admin Report', {{name='message', help='Message'}}, true, function(source, args)
--     local src = source
--     local msg = table.concat(args, ' ')
--     local Player = QBCore.Functions.GetPlayer(source)
--     TriggerClientEvent('qb-admin:client:SendReport', -1, GetPlayerName(src), src, msg)
--     TriggerEvent('qb-log:server:CreateLog', 'report', 'Report', 'green', '**'..GetPlayerName(source)..'** (CitizenID: '..Player.PlayerData.citizenid..' | ID: '..source..') **Report:** ' ..msg, false)
-- end)

QBCore.Commands.Add('staffchat', 'Send A Message To All Staff (Admin Only)', {{name='message', help='Message'}}, true, function(source, args)
    local msg = table.concat(args, ' ')
    TriggerClientEvent('qb-admin:client:SendStaffChat', -1, GetPlayerName(source), msg)
end, 'admin')

QBCore.Commands.Add('givenuifocus', 'Give A Player NUI Focus (Admin Only)', {{name='id', help='Player id'}, {name='focus', help='Set focus on/off'}, {name='mouse', help='Set mouse on/off'}}, true, function(source, args)
    local playerid = tonumber(args[1])
    local focus = args[2]
    local mouse = args[3]
    TriggerClientEvent('qb-admin:client:GiveNuiFocus', playerid, focus, mouse)
end, 'admin')

QBCore.Commands.Add('warn', 'Warn A Player (Admin Only)', {{name='ID', help='Player'}, {name='Reason', help='Mention a reason'}}, true, function(source, args)
    local targetPlayer = QBCore.Functions.GetPlayer(tonumber(args[1]))
    local senderPlayer = QBCore.Functions.GetPlayer(source)
    table.remove(args, 1)
    local msg = table.concat(args, ' ')
    local myName = senderPlayer.PlayerData.name
    local warnId = 'WARN-'..math.random(1111, 9999)
    if targetPlayer ~= nil then
        --TriggerClientEvent('chat:addMessage', targetPlayer.PlayerData.source, 'SYSTEM', 'error', 'You have been warned by: '..GetPlayerName(source)..', Reason: '..msg)
		TriggerClientEvent('chat:addMessage', targetPlayer.PlayerData.source, { args = { "SYSTEM", "^8WARNING ^7 You have been warned by"..GetPlayerName(source)..", Reason: "..msg }, color = 255, 0, 0 })
        --TriggerClientEvent('chat:addMessage', source, 'SYSTEM', 'error', 'You have warned '..GetPlayerName(targetPlayer.PlayerData.source)..' for: '..msg)
		TriggerClientEvent('chat:addMessage', source, { args = { "SYSTEM", "^8WARNING ^7 You have warned "..GetPlayerName(targetPlayer.PlayerData.source)..", for: "..msg }, color = 255, 0, 0 })
        exports.oxmysql:insert('INSERT INTO player_warns (senderIdentifier, targetIdentifier, reason, warnId) VALUES (?, ?, ?, ?)', {
            senderPlayer.PlayerData.license,
            targetPlayer.PlayerData.license,
            msg,
            warnId
        })
    else
        TriggerClientEvent('QBCore:Notify', source, 'This player is not online', 'error')
    end
end, 'admin')

QBCore.Commands.Add('checkwarns', 'Check Player Warnings (Admin Only)', {{name='id', help='Player'}, {name='Warning', help='Number of warning, (1, 2 or 3 etc..)'}}, false, function(source, args)
    if args[2] == nil then
        local targetPlayer = QBCore.Functions.GetPlayer(tonumber(args[1]))
        local result = exports.oxmysql:executeSync('SELECT * FROM player_warns WHERE targetIdentifier = ?', { targetPlayer.PlayerData.license })
        TriggerClientEvent('chat:addMessage', source, 'SYSTEM', 'warning', targetPlayer.PlayerData.name..' has '..tablelength(result)..' warnings!')
    else
        local targetPlayer = QBCore.Functions.GetPlayer(tonumber(args[1]))
        local warnings = exports.oxmysql:executeSync('SELECT * FROM player_warns WHERE targetIdentifier = ?', { targetPlayer.PlayerData.license })
        local selectedWarning = tonumber(args[2])
        if warnings[selectedWarning] ~= nil then
            local sender = QBCore.Functions.GetPlayer(warnings[selectedWarning].senderIdentifier)
            TriggerClientEvent('chat:addMessage', source, 'SYSTEM', 'warning', targetPlayer.PlayerData.name..' has been warned by '..sender.PlayerData.name..', Reason: '..warnings[selectedWarning].reason)
        end
    end
end, 'admin')

QBCore.Commands.Add('delwarn', 'Delete Players Warnings (Admin Only)', {{name='id', help='Player'}, {name='Warning', help='Number of warning, (1, 2 or 3 etc..)'}}, true, function(source, args)
    local targetPlayer = QBCore.Functions.GetPlayer(tonumber(args[1]))
    local warnings = exports.oxmysql:executeSync('SELECT * FROM player_warns WHERE targetIdentifier = ?', { targetPlayer.PlayerData.license })
    local selectedWarning = tonumber(args[2])
    if warnings[selectedWarning] ~= nil then
        local sender = QBCore.Functions.GetPlayer(warnings[selectedWarning].senderIdentifier)
        TriggerClientEvent('chat:addMessage', source, 'SYSTEM', 'warning', 'You have deleted warning ('..selectedWarning..') , Reason: '..warnings[selectedWarning].reason)
        exports.oxmysql:execute('DELETE FROM player_warns WHERE warnId = ?', { warnings[selectedWarning].warnId })
    end
end, 'admin')

QBCore.Commands.Add('reportr', 'Reply To A Report (Admin Only)', {{name='id', help='Player'}, {name = 'message', help = 'Message to respond with'}}, false, function(source, args, rawCommand)
    local src = source
    local playerId = tonumber(args[1])
    table.remove(args, 1)
    local msg = table.concat(args, ' ')
    local OtherPlayer = QBCore.Functions.GetPlayer(playerId)
    if msg == '' then return end
    if not OtherPlayer then return TriggerClientEvent('QBCore:Notify', src, 'Player is not online', 'error') end
    if not QBCore.Functions.HasPermission(src, 'admin') or IsPlayerAceAllowed(src, 'command') ~= 1 then return end
    TriggerClientEvent('chat:addMessage', playerId, {
        color = {255, 0, 0},
        multiline = true,
        args = {'Admin Response', msg}
    })
    TriggerClientEvent('chat:addMessage', src, {
        color = {255, 0, 0},
        multiline = true,
        args = {'Report Response ('..playerId..')', msg}
    })
    TriggerClientEvent('QBCore:Notify', src, 'Reply Sent')
    TriggerEvent('qb-log:server:CreateLog', 'report', 'Report Reply', 'red', '**'..GetPlayerName(src)..'** replied on: **'..OtherPlayer.PlayerData.name.. ' **(ID: '..OtherPlayer.PlayerData.source..') **Message:** ' ..msg, false)
end, 'admin')

QBCore.Commands.Add('setmodel', 'Change Ped Model (Admin Only)', {{name='model', help='Name of the model'}, {name='id', help='Id of the Player (empty for yourself)'}}, false, function(source, args)
    local model = args[1]
    local target = tonumber(args[2])
    if model ~= nil or model ~= '' then
        if target == nil then
            TriggerClientEvent('qb-admin:client:SetModel', source, tostring(model))
        else
            local Trgt = QBCore.Functions.GetPlayer(target)
            if Trgt ~= nil then
                TriggerClientEvent('qb-admin:client:SetModel', target, tostring(model))
            else
                TriggerClientEvent('QBCore:Notify', source, 'This person is not online..', 'error')
            end
        end
    else
        TriggerClientEvent('QBCore:Notify', source, 'You did not set a model..', 'error')
    end
end, 'admin')

QBCore.Commands.Add('setspeed', 'Set Player Foot Speed (Admin Only)', {}, false, function(source, args)
    local speed = args[1]
    if speed ~= nil then
        TriggerClientEvent('qb-admin:client:SetSpeed', source, tostring(speed))
    else
        TriggerClientEvent('QBCore:Notify', source, 'You did not set a speed.. (`fast` for super-run, `normal` for normal)', 'error')
    end
end, 'admin')

QBCore.Commands.Add('reporttoggle', 'Toggle Incoming Reports (Admin Only)', {}, false, function(source, args)
    local src = source
    QBCore.Functions.ToggleOptin(src)
    if QBCore.Functions.IsOptin(src) then
        TriggerClientEvent('QBCore:Notify', src, 'You are receiving reports', 'success')
    else
        TriggerClientEvent('QBCore:Notify', src, 'You are not receiving reports', 'error')
    end
end, 'admin')

QBCore.Commands.Add('kickall', 'Kick all players', {}, false, function(source, args)
    local src = source
    if src > 0 then
        local reason = table.concat(args, ' ')
        if QBCore.Functions.HasPermission(src, 'god') or IsPlayerAceAllowed(src, 'command') then
            if not reason then
                for k, v in pairs(QBCore.Functions.GetPlayers()) do
                    local Player = QBCore.Functions.GetPlayer(v)
                    if Player then
                        DropPlayer(Player.PlayerData.source, reason)
                    end
                end
            else
                TriggerClientEvent('QBCore:Notify', src, 'No reason specified', 'error')
            end
        end
    else
        for k, v in pairs(QBCore.Functions.GetPlayers()) do
            local Player = QBCore.Functions.GetPlayer(v)
            if Player then
                DropPlayer(Player.PlayerData.source, 'Server restart, check our Discord for more information: ' .. QBCore.Config.Server.discord)
            end
        end
    end
end, 'god')

QBCore.Commands.Add('setammo', 'Set Your Ammo Amount (Admin Only)', {{name='amount', help='Amount of bullets, for example: 20'}, {name='weapon', help='Name of the weapen, for example: WEAPON_VINTAGEPISTOL'}}, false, function(source, args)
    local src = source
    local weapon = args[2]
    local amount = tonumber(args[1])

    if weapon ~= nil then
        TriggerClientEvent('qb-weapons:client:SetWeaponAmmoManual', src, weapon, amount)
    else
        TriggerClientEvent('qb-weapons:client:SetWeaponAmmoManual', src, 'current', amount)
    end
end, 'admin')


QBCore.Commands.Add("cleararea", "remove peds, vehicles and everything in the area", {}, false, function(source, args)
    TriggerClientEvent('QBCore:ClearArea', -1)
end, "admin")

QBCore.Commands.Add("key", "Toggle engine On/Off of the vehicle", {}, false, function(source, args)
    TriggerClientEvent('vehiclekeys:client:SetOwner', source)
    TriggerClientEvent('vehiclekeys:client:ToggleEngine', source)
end,"god")