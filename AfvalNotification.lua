--*------------------------------------------------------------------------------------*--
--Creator: Rens
--Date: 13-08-2019
--Last update: 13-08-2019
--Changelog: 
--Source: https://www.domoticz.com/forum/viewtopic.php?f=61&t=18628
--Description: Used to send notifcation when the trash is picked up. This script is converted from a LUA script, needs the function 'FindTrashDate' from global_data
--*------------------------------------------------------------------------------------*--

return {
	on = {
		timer = {
		    'at 07:00',
		    'at 21:00'
		}
	},
	execute = function(domoticz, device)
		--Declarations
		local kalender              = domoticz.devices(197)
		local Time                  = require('Time') --Time function
		local CurrentTime           = Time() --Current time
		local Trash_Date            = os.date("%d-%m-%Y",os.time()) -- date today
		local Trash_DateTomorrow    = os.date("%d-%m-%Y",os.time()+24*60*60) -- date tomorrow
		
		--Settings
		local postcode      = "1234AA"
		local hn            = "1"
		local NotGFT        = true
		local NotPapier     = true
		local NotPlastic    = true
		local NotRest       = true
		local NotKerst      = true
        
		--Get the next Trashdates
		local Trash_GFT     = domoticz.helpers.FindTrashDate("GFT",postcode,hn)
		local Trash_Papier  = domoticz.helpers.FindTrashDate("PAPIER",postcode,hn)
		local Trash_Plastic = domoticz.helpers.FindTrashDate("PMD",postcode,hn)
		local Trash_Rest    = domoticz.helpers.FindTrashDate("REST",postcode,hn)
		local Trash_Kerst   = domoticz.helpers.FindTrashDate("KERSTBOOM",postcode,hn)

		--Get the next Trashdates
		local Trash_GFT = domoticz.helpers.FindTrashDate("GFT",postcode,hn)
		local Trash_Papier = domoticz.helpers.FindTrashDate("PAPIER",postcode,hn)
		local Trash_Plastic = domoticz.helpers.FindTrashDate("PMD",postcode,hn)
		local Trash_Rest = domoticz.helpers.FindTrashDate("REST",postcode,hn)
		local Trash_Kerst = domoticz.helpers.FindTrashDate("KERSTBOOM",postcode,hn)

		--Send dates to Dummy sensor
		local kalendertext = "Eerst volgende ophaalmomenten zijn:\nGFT: " .. Trash_GFT .. '\nPapier: ' .. Trash_Papier .. '\nPlastic: ' .. Trash_Plastic .. '\nRest: ' .. Trash_Rest

		if (kalendertext ~= kalender.text) then
		    kalender.updateText(kalendertext)
		end

		    --Send notification at 07.00u same day
		if (CurrentTime.matchesRule('at 07:00')) then
		    if (Trash_Date == Trash_GFT and NotGFT) then
			domoticz.notify('Afval','Groente, Fruit en Tuinafval wordt vandaag opgehaald',domoticz.PRIORITY_LOW)
			print("Groente, Fruit en Tuinafval wordt vandaag opgehaald.") 
		    end

		    if (Trash_Date == Trash_Papier and NotPapier) then
			domoticz.notify('Afval','Papier wordt vandaag opgehaald',domoticz.PRIORITY_LOW)
			print("Papier wordt vandaag opgehaald.")
		    end

		    if (Trash_Date == Trash_Plastic and NotPlastic) then
			domoticz.notify('Afval','Plastic wordt vandaag opgehaald.',domoticz.PRIORITY_LOW)
			print("Plastic wordt vandaag opgehaald.")
		    end

		    if (Trash_Date == Trash_Rest and NotRest) then
			domoticz.notify('Afval','Restafval wordt vandaag opgehaald.',domoticz.PRIORITY_LOW)
			print("Restafval wordt vandaag opgehaald.")
		    end

		    if (Trash_Date == Trash_Kerst and NotKerst) then
			domoticz.notify('Afval','Kerstboom wordt vandaag opgehaald.',domoticz.PRIORITY_LOW)
			print("Kerstboom wordt vandaag opgehaald.")
		    end
		end    

		--Send notification at 21.00u day before
		if (CurrentTime.matchesRule('at 21:00')) then
		    if (Trash_DateTomorrow == Trash_GFT and NotGFT) then
			domoticz.notify('Afval','Groente, Fruit en Tuinafval wordt morgen opgehaald',domoticz.PRIORITY_LOW)
			print("Groente, Fruit en Tuinafval wordt morgen opgehaald.")
		    end

		    if  (Trash_DateTomorrow == Trash_Papier and NotPapier) then
			domoticz.notify('Afval','Papier wordt morgen opgehaald',domoticz.PRIORITY_LOW)
			print("Papier wordt morgen opgehaald.")
		    end

		    if  (Trash_DateTomorrow == Trash_Plastic and NotPlastic) then
			domoticz.notify('Afval','Plastic wordt morgen opgehaald.',domoticz.PRIORITY_LOW)
			print("Plastic wordt morgen opgehaald.")
		    end

		    if  (Trash_DateTomorrow == Trash_Rest and NotRest)  then
			domoticz.notify('Afval','Restafval wordt morgen opgehaald.',domoticz.PRIORITY_LOW)
			print("Restafval wordt morgen opgehaald.")
		    end

		    if  (Trash_DateTomorrow == Trash_Kerst and NotKerst) then
			domoticz.notify('Afval','Kerstboom wordt morgen opgehaald.',domoticz.PRIORITY_LOW)
			print("Kerstboom wordt morgen opgehaald.")
		    end
        	end
    	end
}
