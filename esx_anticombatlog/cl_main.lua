--[[
		ANTI COMBATLOGGING 
							]]--------------------------------------------
--ESX---------------------------------------------------------------------
ESX = nil																--
PlayerData = nil														--
---------																--	
TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)		--
--------																--
RegisterNetEvent('esx:playerLoaded')									--
AddEventHandler('esx:playerLoaded', function(xPlayer)					--
  PlayerData = xPlayer													--
  TriggerServerEvent('esx_anticombatlog:request', PlayerData.identifier)--
  chat("1", _U('info_text'))  											--
end)																	--
----------------------------------------------------------------------------------------------------------
																										--
chat = function(clr, msg) TriggerEvent('chatMessage', "", {255, 0, 0}, "^" .. clr .. tostring(msg)) end	--
																										--
----------------------------------------------------------------------------------------------------------

local firstSpawn = true
local penalty = 0									

AddEventHandler('baseevents:onPlayerDied', function(killerType, coords)
  TriggerServerEvent('esx_anticombatlog:update', true, PlayerData.identifier)
end)

AddEventHandler('baseevents:onPlayerKilled', function(killerId, data)
  TriggerServerEvent('esx_anticombatlog:update', true, PlayerData.identifier)
end)

RegisterNetEvent('esx_anticombatlog:allOk')
AddEventHandler('esx_anticombatlog:allOk', function()
	chat("4",_U('was_alive'))
end)

RegisterNetEvent('esx_anticombatlog:startPenalty')
AddEventHandler('esx_anticombatlog:startPenalty', function()
	
	chat("1", _U('was_dead'))
	
	Citizen.CreateThread(function() --due to player magic revival on skin load, penalty timer sounds like a good idea
	
		penalty = Config.PenaltyTimer * 60000
				
		while penalty > 0 do
			if GetEntityHealth(GetPlayerPed(-1)) > 0 then
				if Config.ReviveAndKill then
					TriggerEvent('esx_ambulancejob:revive')
					Citizen.Wait(1150)
				end 
				SetEntityHealth(GetPlayerPed(-1), 0)
			end
			Citizen.Wait(1000)
			penalty = penalty - 1015
		end
				
		TriggerServerEvent('esx_anticombatlog:update', false, PlayerData.identifier)
	end)
	
end)

AddEventHandler('playerSpawned', function()
	
	if firstSpawn or penalty > 0 then
		firstSpawn = false --nvm 
		return
	end
	
	TriggerServerEvent('esx_anticombatlog:update', false, PlayerData.identifier)
	
end)









