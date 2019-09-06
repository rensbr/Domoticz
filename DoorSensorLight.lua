--*------------------------------------------------------------------------------------*--
--Creator: Rens
--Date: 26-04-2019
--Last update: 26-04-2019
--Changelog:
--Source: -
--Description: Used to Switch on light, when the door is open
--*------------------------------------------------------------------------------------*--

return {
	on = {
		devices = {
			91  -- Door sensor
		}
	},
	execute = function(domoticz, device)
		--Declarations
		local Light 	= domoticz.devices(118) --Light Berging
		local TimeofDay = domoticz.devices(73) --DayNight
		local DS 	= domoticz.devices(91) -- DS Opslag
		
		--Function
		if (DS.active) then
			if (TimeofDay.state == 'Evening' or TimeofDay.state == 'Day') then -- Door sensor open and Day or Evening
				Light.dimTo(100) -- Turn on 100%
			elseif (TimeofDay.state == 'Night') then -- Door sensor Open and Night
				Light.dimTo(40) -- Turn on 40%
	        	end
		else
		    	Light.switchOff().checkFirst() --Turn off
		end
	end
}
