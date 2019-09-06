--*------------------------------------------------------------------------------------*--
--Creator: Rens
--Date: 20-05-2019
--Last update: 22-08-2019
--Changelog: Added cancelQueuedCommands()
--Source: -
--Description: Used to Switch on Lamp, when there is movement on the toilet
--*------------------------------------------------------------------------------------*--

return {
	on = {
		devices = {
			191,  -- HBS
			73 -- DayNight
		}
	},
	execute = function(domoticz, device)
		--Declarations
		local Light 	= domoticz.devices(119) --Lampen WC
		local TimeofDay = domoticz.devices(73) --DayNight
		local HBS 	= domoticz.devices(191) -- HBS WC
		
		--Function
		if ((HBS.active) and (TimeofDay.state == 'Evening' or TimeofDay.state == 'Day')) then -- sensor on and Evening or Day
		    Light.cancelQueuedCommands()
		    Light.dimTo(100)-- Turn on 100% for 4 minutes
		    Light.switchOff().afterMin(4)
		elseif ((HBS.active) and (TimeofDay.state == 'Night')) then -- sensor on and Night
		    Light.cancelQueuedCommands()
		    Light.dimTo(15)
		    Light.switchOff().afterMin(2)
		end
	end
}
