--[[
	
	ANTI-COMBATLOGGING
	
]]--

ESX = nil

TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

DeadPlayers = {}

ESX.RegisterServerCallback('esx_anticombatlog:getStatus', function(source, cb, id)

	if DeadPlayers[id] ~= nil then
		cb(true)
	else
		cb(false)
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


