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
		Citizen.Wait(0)
        local vehicle = GetVehiclePedIsIn(GetPlayerPed(-1), false)
		local ped = GetPlayerPed(-1)
		local vehicleClass = GetVehicleClass(vehicle)
		PlayerData = ESX.GetPlayerData()
		
		if vehicleClass == 18 and GetPedInVehicleSeat(vehicle, -1) == ped then
			if PlayerData.job.name ~= 'police' and PlayerData.job.name ~= 'ambulance' and PlayerData.job.name ~= 'mecano' then
			ClearPedTasksImmediately(ped)
			TaskLeaveVehicle(ped,vehicle,0)
			Citizen.Wait(250)
			TriggerServerEvent("KickPlayer:EmergencyVehicle")
			end
		end
	end
end)