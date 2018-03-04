--
-- You should also block inventory when player is dead
-- Can be done with for example ' if IsEntityDead(GetPlayerPed(-)) then return end '
--
--add the following line to ALphone client
Citizen.CreateThread(function()
	while true do 
		if GUI.IsOpen and IsEntityDead(GetPlayerPed(-1)) then
			ClosePhone()
		end
		Citizen.Wait(300)
	end
end)

--edit open phone function
function OpenPhone() --line ~~42
	
  if GUI.IsOpen or IsEntityDead(GetPlayerPed(-1)) then --edit this line
	ClosePhone()
	return
  end
--rest of the code



