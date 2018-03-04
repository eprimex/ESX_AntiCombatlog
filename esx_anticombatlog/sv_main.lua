--[[
	
	ANTI-COMBATLOGGING
	
]]--

DeadPlayers = {}

RegisterServerEvent('esx_anticombatlog:request')
AddEventHandler('esx_anticombatlog:request', function(id)
	if DeadPlayers[id] ~= nil then
		TriggerClientEvent('esx_anticombatlog:startPenalty', source)
	else
		TriggerClientEvent('esx_anticombatlog:allOk', source)
	end
end)

RegisterServerEvent('esx_anticombatlog:update')
AddEventHandler('esx_anticombatlog:update', function(isDead, id)
	if isDead then
		DeadPlayers[id] = true
	else
		DeadPlayers[id] = nil
	end
end)


