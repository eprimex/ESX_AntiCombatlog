--[[
	
	ANTI-COMBATLOGGING
	
]]--

DeadPlayers = {}

function dbg(msg)
	Citizen.Trace(tostring(msg) .. '\n')
end

RegisterServerEvent('esx_anticombatlog:request')
AddEventHandler('esx_anticombatlog:request', function(id)
	if DeadPlayers[id] ~= nil then
		dbg('Player ' .. id .. ' combatlogged')
		TriggerClientEvent('esx_anticombatlog:startPenalty', source)
	else
		dbg('Player ' .. id .. ' had not combatlogged')
		TriggerClientEvent('esx_anticombatlog:allOk', source)
	end
end)

RegisterServerEvent('esx_anticombatlog:update')
AddEventHandler('esx_anticombatlog:update', function(isDead, id)
	if isDead then
		dbg('Player ' .. id .. ' is dead')
		DeadPlayers[id] = true
	else
		dbg('Player ' .. id .. ' is alive')
		DeadPlayers[id] = nil
	end
end)


