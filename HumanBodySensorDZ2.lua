--*------------------------------------------------------------------------------------*--
--Creator: Rens
--Date: 01-09-2019
--Last update:
--Changelog: 
--Source: -
--Description: Used to Switch on Lamp, when there is movement
--*------------------------------------------------------------------------------------*--

--Declarations
local HBSNum       = 191 -- HBS WC

return {
	on = {
		devices = {
			HBSNum  -- HBS
		}
	},
	execute = function(domoticz, device)
		--Declarations
		local Light     = domoticz.devices(247) --Lampen WC
		local TimeofDay = domoticz.devices(73) --DayNight
		local HBS       = domoticz.devices(HBSNum) -- HBS WC
		
		--Function
		if ((HBS.active) and (TimeofDay.state == 'Evening' or TimeofDay.state == 'Day')) then -- sensor on and Evening or Day
		    Light.cancelQueuedCommands()
		    Light.dimTo(100)-- Turn on 100%
		elseif ((HBS.active) and (TimeofDay.state == 'Night')) then -- sensor on and Night
		    Light.cancelQueuedCommands()
		    Light.dimTo(15)
	    else
	        Light.switchOff().afterMin(2)
		end
	end
}
