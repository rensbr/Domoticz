--*------------------------------------------------------------------------------------*--
--Creator: Rens
--Date: 18-07-2019
--Last update: 18-07-2019
--Changelog:
--Source: -
--Description: Set's 'Vakantie' to true, when nobody's home for more than 24 hours
--*------------------------------------------------------------------------------------*--

return {
	on = {
		devices = {
			54 -- IemandThuis
		}
	},
	execute = function(domoticz, device)
		 --Declarations
		local IemandThuis = domoticz.devices(54) -- Iemand Thuis
		local Vakantie = domoticz.devices(55) -- Vakantie
		
        	--Function
        	if (not IemandThuis.active) then -- When nobody is home
            		Vakantie.switchOn().afterHour(24) -- Switch vakantie on after 24 hours
        	elseif (IemandThuis.active) then -- if somebody is home in 24 hours, cancel the command and turn off vakantie
            		Vakantie.cancelQueuedCommands()
            		Vakantie.switchOff().checkFirst()
        	end
	end
}
