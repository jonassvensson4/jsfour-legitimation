local ESX = nil
-- ESX
TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

-- Open ID card
RegisterServerEvent('jsfour-legitimation:open')
AddEventHandler('jsfour-legitimation:open', function(ID, targetID)
	local identifier = ESX.GetPlayerFromId(ID).identifier
	local _source = ESX.GetPlayerFromId(targetID).source

	MySQL.Async.fetchAll('SELECT firstname, lastname, dateofbirth, sex, height, lastdigits FROM users WHERE identifier = @identifier', {['@identifier'] = identifier},
	function (result)
		if (result[1] ~= nil) then
		  playerData = {firstname = result[1].firstname, lastname = result[1].lastname, dateofbirth = result[1].dateofbirth, sex = result[1].sex, height = result[1].height, lastdigits = result[1].lastdigits}
		  TriggerClientEvent('jsfour-legitimation:open', _source, playerData)
		end
	end)
end)
