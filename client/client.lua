-- For loop by the origianl ESX Developers

ESX = nil

Citizen.CreateThread(function()
	while ESX == nil do
		TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
		Citizen.Wait(0)
	end
	
	PlayerData = ESX.GetPlayerData()
end)

CreateThread(function()
	while true do
		Wait(5)

		if ESX.PlayerData.job and ESX.PlayerData.job.name == 'police' then
			local playerPed = PlayerPedId()
			local playerCoords = GetEntityCoords(playerPed)
			local isInMarker, letSleep = false, false, true

			for k,v in pairs(config.locations) do
				for i=1, #v.blipCoords, 1 do
					local distance = #(playerCoords - v.blipCoords[i])

					if distance < 3 then
                        if ESX.PlayerData.job.grade ~= 5 then
                            ESX.ShowFloatingHelpNotification("Go Off Duty", v.blipCoords[i])
                            letSleep = false

                        else
                            ESX.ShowFloatingHelpNotification("Go On Duty", v.blipCoords[i])
                            letSleep = false
                        end

                        if distance < config.MarkerSize.x then
                            isInMarker = true
                        end

					end
				end
            end

            if isInMarker and ESX.PlayerData.job and ESX.PlayerData.job.name == 'police' then
                if ESX.PlayerData.job.grade ~= 5 then
                    ESX.ShowHelpNotification('press ~INPUT_CONTEXT~ to go ~r~off duty~r~.')
                else
                    ESX.ShowHelpNotification('press ~INPUT_CONTEXT~ to go ~g~on duty~g~.')
                end
            end

            if isInMarker and IsControlJustReleased(0, 38) and ESX.PlayerData.job and ESX.PlayerData.job.name == 'police' then
                if ESX.PlayerData.job.grade ~= 5 then
                    TriggerServerEvent('policeOffDuty', ESX.PlayerData.identifier, ESX.PlayerData.job.grade)
                else
                    TriggerServerEvent('policeOnDuty', ESX.PlayerData.identifier)
                end
            end
        end
    end
end)
