Thanks for purchasing SM-Scripts

Installation:
1. Go to your mumble [qb-voice] => client => module => radio.lua and add this to line 150 (In command called: +radiotalk): TriggerEvent("sm-voice:radioActive", true)
2. Go to your mumble [qb-voice] => client => module => radio.lua and add this to line 167 (In command called: -radiotalk): TriggerEvent("sm-voice:radioActive", false)
3. Go to your mumble [qb-voice] => client => commands.lua => Search for the command "cycleproximity" and add above the end: TriggerServerEvent("SM-10System:Client:GetMode", mode)
4. Add This to: [qb-voice] => server => module => radio.lua:
RegisterNetEvent("SM-10System:MoveToChannel")
AddEventHandler("SM-10System:MoveToChannel", function(source, radiochannel, Mover)
	setPlayerRadio(source, tonumber(radiochannel))
	TriggerClientEvent('QBCore:Notify', source, "You have moved to channel ".. radiochannel .. " By ".. Mover, "success")
end) 
5. Add TriggerEvent('SM-10System:OnPlayerDrop', src) to your core/events below: "AddEventHandler('playerDropped', function(reason)"
6. Add TriggerEvent('SM-10system:Server:OnUpdateChannel', source, radioChannel) on:[voip]\qb-voice\server\module\radio.lua on function: function addPlayerToRadio(source, radioChannel)
7. Add TriggerEvent("SM-10System:UpdateCallsign", src) to qb-police\server on command: Callsign add this below: Player.Functions.SetMetaData("callsign", table.concat(args, " "))
8. Add this to [qb-voice]\server\module\radio.lua: exports('getPlayerRadio', function(src)
	return voiceData[src] and voiceData[src].radio or 'x'
end)