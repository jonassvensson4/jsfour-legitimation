# jsfour-legitimation
Ett alternativ till gcidentity där du kan titta på ditt legg samt visa upp det för den närmsta personen.

### LICENSE
Du får mer än gärna ändra vad du vill i scriptet men du får INTE sälja vidare scriptet eller ladda upp det på nytt, hänvisa folket hit istället.

### INFO
För att scriptet ska fungera så behöver du använda dig av ESX.

Scriptet är gjort efter mina behov vilket betyder att du kommer få ändra det lite.
Det du kan behöva ändra är följande:

- Ta bort lastdigits från SQL-queryn i server.lua
- Ändra formatet på personnumret i init.js

Vet du inte hur du gör detta så är det här inget script för dig.

### Screenshot
![screenshot](https://i.gyazo.com/98063ed06b7a804e6978c5e4bb4886e6.png)

### Exempel på hur en meny kan se ut
```
ESX.UI.Menu.Open(
	'default', GetCurrentResourceName(), 'id_card_menu',
	{
		title    = 'ID meny',
		elements = {
			{label = 'Kolla på ditt legg', value = 'check'},
			{label = 'Visa ditt legg', value = 'show'}
		}
	},
	function(data2, menu2)
		if data2.current.value == 'check' then
			TriggerServerEvent('jsfour-legitimation:open', GetPlayerServerId(PlayerId()), GetPlayerServerId(PlayerId()))
		elseif data2.current.value == 'show' then
			local player, distance = ESX.Game.GetClosestPlayer()

			if distance ~= -1 and distance <= 3.0 then
				TriggerServerEvent('jsfour-legitimation:open', GetPlayerServerId(PlayerId()), GetPlayerServerId(player))
			else
				ESX.ShowNotification('Ingen i närheten')
			end
		end
	end,
	function(data2, menu2)
		menu2.close()
	end
)
```
