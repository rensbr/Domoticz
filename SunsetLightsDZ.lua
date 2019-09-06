--*------------------------------------------------------------------------------------*--
--Creator: Rens
--Date: 26-04-2019
--Last update: 26-04-2019
--Changelog: Added vacation switch
--Source: -
--Description: Used to Switch on lights, when it is dark, and switch them off at time based
-- or when nobody is home
--*------------------------------------------------------------------------------------*--

return {
	on = {
		devices = {
		    47, -- TV woonkamer
		    54, -- Iemand thuis
		    55 -- Vakantie
		},
		timer = {
		    'at 15 minutes before sunset'
		}
	},
	execute = function(domoticz, device)
		--Declarations
		local LightWoon 	= domoticz.devices(139) --Lampen Woonkamer
		local IemandThuis 	= domoticz.devices(54) -- Iemand Thuis
		local Vakantie 		= domoticz.devices(55) -- Vakantie
		local Weekend 		= domoticz.devices(74) -- Weekend
		local TV 		= domoticz.devices(47) -- TV woonkamer
		local Time 		= require('Time') --Time function
		local CurrentTime 	= Time() --Current time
		
		--Function
		if (not Vakantie.active and IemandThuis.active) then
			if ((CurrentTime.matchesRule('between 15 minutes before sunset and 23:14')) and (not TV.active)) then 
		        	LightWoon.setKelvin(255)
		        	LightWoon.dimTo(100)
	        	end
	    	else -- When nobody home or vacation
            		LightWoon.switchOff().checkFirst()
		end
	end
}
