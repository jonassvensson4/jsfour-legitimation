local ESX 				= nil
local cardOpen 		= false
local PlayerData 	= {}

-- ESX
Citizen.CreateThread(function()
	while ESX == nil do
		TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
		Citizen.Wait(0)
	end
end)

RegisterNetEvent('esx:playerLoaded')
AddEventHandler('esx:playerLoaded', function(xPlayer)
	PlayerData = xPlayer
end)

RegisterNetEvent('esx:setJob')
AddEventHandler('esx:setJob', function(job)
	PlayerData.job = job
end)

function idCardMenu()
	ESX.UI.Menu.CloseAll()

	ESX.UI.Menu.Open(
		'default', GetCurrentResourceName(), 'id_card_menu',
		{
			title    = 'ID meny',
			elements = {
				{label = 'Kolla på ditt legg', value = 'check'},
				{label = 'Visa ditt legg', value = 'show'}
			}
		},
		function(data, menu)
			if data.current.value == 'check' then
				TriggerServerEvent('jsfour-legitimation:open', GetPlayerServerId(PlayerId()), GetPlayerServerId(PlayerId()))
			elseif data.current.value == 'show' then
				local player, distance = ESX.Game.GetClosestPlayer()
				print(GetPlayerServerId(player))
				if distance ~= -1 and distance <= 3.0 then
					--TriggerServerEvent('jsfour-legitimation:open', GetPlayerServerId(PlayerId()), player)
				end
			end
			menu.close()
		end,
		function(data, menu)
			menu.close()
		end
	)
end

-- # Open ID card
RegisterNetEvent('jsfour-legitimation:open')
AddEventHandler('jsfour-legitimation:open', function(playerData)
	cardOpen = true
	SendNUIMessage({
		action = "open",
		array = playerData
	})
end)

-- Close the ID card
-- Key events
Citizen.CreateThread(function()
	while true do
		Wait(0)
		-- if IsControlPressed(0, 38)  then
		-- 	idCardMenu()
		-- end
		if IsControlPressed(0, 322) or IsControlPressed(0, 177) and cardOpen then
			SendNUIMessage({
				action = "close"
			})
			cardOpen = false
		end
	end
end)
