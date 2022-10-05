--*------------------------------------------------------------------------------------*--
--Creator: Rens
--Date: 26-04-2019
--Last update: 13-09-2022
--Changelog: 
--Source: -
--Description: Used check whenevery anyone is home with delay
--*------------------------------------------------------------------------------------*--

--Declarations
local Person1Num    = 1 -- Person 
local Person2Num    = 2 -- Person 
local Person3Num    = 3 -- Person
local OverrideNum   = 4 -- Person     
local Person4Num    = 5 -- Person
local Person5Num    = 6 -- Person

return {
	on = {
		devices = {
			Person1Num,	-- Person
			Person2Num,     -- Person
			Person3Num,     -- Person
			Person4Num,     -- Person
			Person5Num,     -- Person
			OverrideNum     -- Override  
		}
	},
	execute = function(domoticz, device)
		--Declarations
		local IemandThuis	= domoticz.devices(54) -- Iemand Thuis
		local Person1       	= domoticz.devices(Person1Num) -- Person 
		local Person2         	= domoticz.devices(Person2Num) -- Person 
		local Person3       	= domoticz.devices(Person3Num) -- Person
		local Person4         	= domoticz.devices(Person4Num) -- Person
		local Person5           = domoticz.devices(Person5Num) -- Person
		local Override      	= domoticz.devices(OverrideNum) -- Override 

		--Function
		if (Person1.active) or (Person2.active) or (Person3.active) or (Person4.active) or (Person5.active) or (Override.active) then -- When somebody is home
		    IemandThuis.cancelQueuedCommands()
		    IemandThuis.switchOn().checkFirst()
		else
		    IemandThuis.switchOff().afterMin(10)
		end

		if ((Person1.active) or (Person2.active) or (Person3.active) or (Person4.active) or (Person5.active)) and (Override.active) then -- Turn off override when real precense is there
		    Override.switchOff().checkFirst()
		end
	end
}
