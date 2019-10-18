--*------------------------------------------------------------------------------------*--
--Creator: Rens
--Date: 10-10-2019
--Last update:
--Changelog: 
--Source: -
--Description: Checks the Humidity changes every 2 minutes and turn off/on the ITHO fan based on that changes
--*------------------------------------------------------------------------------------*--

return {
	on = {
        timer = {
            'at 06:00-23:15 every 2 minutes'
        },
	},
	execute = function(domoticz, device)
		 --Declarations
		local bad               = domoticz.devices(102) --Humidity badkamer
		local fan               = domoticz.devices(195) -- ITHO Fan: off (0), level1 (10), level2 (20), level3 (30)
		local PrevHum           = domoticz.variables(4) -- Variable PrevHum
		local Time              = require('Time') --Time function
    local CurrentTime       = Time() --Current time
      
    --Function
    if ((bad.humidity-PrevHum.value) > 5) then 
        if (fan.level ~= 30) then
            fan.switchSelector(30) -- Set fan to level 3
        end
    elseif (PrevHum.value-bad.humidity > 5) then
        if (fan.level ~= 10) then
            fan.switchSelector(10) -- Set fan to level1
        end
    end
     
    if bad.humidity ~= PrevHum.value then
        PrevHum.set(bad.humidity)
    end
	end
}
