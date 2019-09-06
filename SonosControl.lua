--*------------------------------------------------------------------------------------*--
--Creator: Rens
--Date: 28-08-2019
--Last update: 28-08-2019
--Changelog: 
--Source: 
--Description: Pauses Sonos when TV is on or if everyone leaves
--*------------------------------------------------------------------------------------*--

return {
	on = {
		devices = {
			47, -- TV woonkamer
			54 -- Iemand thuis
		}
	},
	execute = function(domoticz, device)
		 --Declarations
		local TV 		= domoticz.devices(47) -- TV woonkamer
		local SonosControl 	= domoticz.devices(202) -- Sonos Woonkamer
		local IemandThuis 	= domoticz.devices(54) -- Iemand Thuis
		local Time 		= require('Time') --Time function
		local CurrentTime 	= Time() --Current time
		
		--Function
		if (TV.active) or (not IemandThuis.active) then 
			SonosControl.switchSelector(20) --Set to Pauze
	    	end
	end
}
