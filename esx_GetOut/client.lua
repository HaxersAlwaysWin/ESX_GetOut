ESX					= nil
local PlayerData	= {}

======================
==    Mini Config   ==
======================
local waitTimeInSeconds = 5  --Set this to however many seconds you want to wait before the player gets kicked
======================

local waitTime = waitTimeInSeconds * 1000

Citizen.CreateThread(function()
	while ESX == nil do
		TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
		Citizen.Wait(0)
	end
end)

Citizen.CreateThread(function()
	while true do
		Citizen.Wait(1000)
        	local vehicle = GetVehiclePedIsIn(PlayerPedId(), false)
		local vehicleClass = GetVehicleClass(vehicle)
		PlayerData = ESX.GetPlayerData()
		
		if vehicleClass == 18 and GetPedInVehicleSeat(vehicle, -1) == PlayerPedId() then
			if PlayerData.job.name ~= 'police' and PlayerData.job.name ~= 'ambulance' and PlayerData.job.name ~= 'mecano' then
			ClearPedTasksImmediately(PlayerPedId())
			TaskLeaveVehicle(PlayerPedId(),vehicle,0)
			ESX.ShowNotification("No stealing Emergency Vehicles. You have "..waitTimeInSeconds.." seconds to get out")
			Citizen.Wait(waitTime)
				if IsPedInVehicle(PlayerPedId(), vehicle, false)
					TriggerServerEvent("KickPlayer:EmergencyVehicle")
				end
			end
		end
	end
end)
