--*------------------------------------------------------------------------------------*--
--Creator: Rens
--Date: 26-04-2019
--Last update: 26-04-2019
--Changelog:
--Source: -
--Description: Used check whenevery anyone is home depending on ping
--*------------------------------------------------------------------------------------*--

return {
	on = {
		devices = {
			52, -- Person one
			53  -- Person two
		}
	},
	execute = function(domoticz, device)
		 --Declarations
		local IemandThuis = domoticz.devices(54) -- Iemand Thuis
		local One = domoticz.devices(52) -- Person one 
		local Two = domoticz.devices(53) -- Person two
		
        --Function
        if (One.active) or (Two.active) then -- When somebody is at home
            IemandThuis.switchOn().checkFirst()
        else
            IemandThuis.switchOff().checkFirst()
        end
        
	end
}
