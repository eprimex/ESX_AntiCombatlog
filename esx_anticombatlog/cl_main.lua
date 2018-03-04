--[[
		ANTI COMBATLOGGING 
							]]----------------------------------------
--ESX-----------------------------------------------------------------
ESX = nil															--
PlayerData = nil													--
---------															--	
TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)	--
--------															--
RegisterNetEvent('esx:playerLoaded')								--
AddEventHandler('esx:playerLoaded', function(xPlayer)				--
  PlayerData = xPlayer												--
  TriggerEvent('esx_anticombatlog:onPlayerJoin')					--
end)																--
----------------------------------------------------------------------------------------------------------
																										--
chat = function(clr, msg) TriggerEvent('chatMessage', "", {255, 0, 0}, "^" .. clr .. tostring(msg)) end	--
																										--
----------------------------------------------------------------------------------------------------------

local spawnCount = 0											

AddEventHandler('baseevents:onPlayerDied', function(killerType, coords)
  
  TriggerServerEvent('esx_anticombatlog:update', true, PlayerData.identifier)
  
end)

AddEventHandler('baseevents:onPlayerKilled', function(killerId, data)
  
  TriggerServerEvent('esx_anticombatlog:update', true, PlayerData.identifier)
  
end)


AddEventHandler('esx_anticombatlog:onPlayerJoin', function()

	chat("1", _U('info_text'))
	
	ESX.TriggerServerCallback('esx_anticombatlog:getStatus', function(wasDead)
		
		if wasDead then
			chat("1", _U('was_dead'))
			
			Citizen.CreateThread(function() --due to player magic revival on skin load, penalty timer sounds like a good idea
				
				local penalty = Config.PenaltyTimer * 60000
				
				while penalty > 0 do
					if GetEntityHealth(GetPlayerPed(-1)) > 0 then
						SetEntityHealth(GetPlayerPed(-1), 0)
					end
					Citizen.Wait(1000)
					penalty = penalty - 1005
				end
							
				TriggerServerEvent('esx_anticombatlog:update', true, PlayerData.identifier)
			end)
		else
			chat("4",_U('was_alive'))
		end
		
	end, PlayerData.identifier)
	
end)

AddEventHandler('playerSpawned', function()
	
	if firstSpawn then
		firstSpawn = false
		return
	end
	
	TriggerServerEvent('esx_anticombatlog:update', false, PlayerData.identifier)
	
end)









