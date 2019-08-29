ESX					= nil
local PlayerData	= {}

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
			if not isJobWhitelisted(PlayerData.job.name) then
				ClearPedTasksImmediately(PlayerPedId())
				TaskLeaveVehicle(PlayerPedId(),vehicle,0)
				ESX.ShowNotification("No stealing Emergency Vehicles. You have ".. Config.waitTimeInSeconds .." seconds to get out")
				Citizen.Wait(Config.waitTime)
				if IsPedInVehicle(PlayerPedId(), vehicle, false) then
					TriggerServerEvent("KickPlayer:EmergencyVehicle")
				end
			end
		end
	end
end)


function isJobWhitelisted(jobName)
	for _, whitelistedJob in pairs(Config.whitelistedJobs) do
		if jobName == whitelistedJob then
			return true
		end
	end

	return false
end
