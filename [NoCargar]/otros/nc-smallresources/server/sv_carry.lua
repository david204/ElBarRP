-- local QBCore = exports['qb-core']:GetCoreObject()
-- RegisterServerEvent('CarryPeople:sync')
-- AddEventHandler('CarryPeople:sync', function(target, animationLib,animationLib2, animation, animation2, distans, distans2, height,targetSrc,length,spin,controlFlagSrc,controlFlagTarget,animFlagTarget)
-- 	TriggerClientEvent('CarryPeople:syncTarget', targetSrc, source, animationLib2, animation2, distans, distans2, height, length,spin,controlFlagTarget,animFlagTarget)
-- 	TriggerClientEvent('CarryPeople:syncMe', source, animationLib, animation,length,controlFlagSrc,animFlagTarget)
-- end)

-- RegisterServerEvent('CarryPeople:stop')
-- AddEventHandler('CarryPeople:stop', function(targetSrc)
-- 	TriggerClientEvent('CarryPeople:cl_stop', targetSrc)
-- end)

QBCore = exports['qb-core']:GetCoreObject()

RegisterServerEvent('CrashTackle')
AddEventHandler('CrashTackle', function(playerId)
	TriggerClientEvent("playerTackled", playerId)
end)

RegisterServerEvent('undragTarget')
AddEventHandler('undragTarget', function(playerId)
	TriggerClientEvent("undragPlayer", playerId, source)
end)

RegisterServerEvent('dragTarget')
AddEventHandler('dragTarget', function(playerId)
	TriggerClientEvent("dragPlayer", playerId, source)
end)

RegisterServerEvent("nc-carry:beingCarried")
AddEventHandler("nc-carry:beingCarried", function(beingCarried)
	local src = source
	local Player = QBCore.Functions.GetPlayer(src)
	TriggerClientEvent("nc-carry:beingCarried", src, beingCarried)
	Player.Functions.SetMetaData('incarry', beingCarried)
end)