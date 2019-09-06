--*------------------------------------------------------------------------------------*--
--Creator: Rens
--Date: 29-05-2019
--Last update: 29-05-2019
--Changelog: 
--Source: -
--Description: Used to turn off/on the ITHO fan based on humidity
--*------------------------------------------------------------------------------------*--

return {
	on = {
		devices = {
			102	-- Badkamer humidity
		}
	},
	execute = function(domoticz, device)
		--Declarations
		local bad           = domoticz.devices(102) --Humidity badkamer
		local fan           = domoticz.devices(195) -- ITHO Fan: off (0), level1 (10), level2 (20), level3 (30)
		local Time          = require('Time') --Time function
        	local CurrentTime   = Time() --Current time
		
		--Function
		if (CurrentTime.matchesRule('at 06:00-22:30') and bad.humidity > 75) then 
		    fan.switchSelector(30) -- Set fan to level 3
		elseif (bad.humidity <= 75) then
		    fan.switchSelector(10) -- Set fan to level1
		end
	end
}
