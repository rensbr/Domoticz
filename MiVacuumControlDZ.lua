--*------------------------------------------------------------------------------------*--
--Creator: Rens
--Date: 26-04-2019
--Last update: 19-07-2019
--Changelog: Added vacation mode
--Source: -
--Description: Used to switch on the Xiaomi Vacuum every day when nobody is home, and twice a week in holiday
--*------------------------------------------------------------------------------------*--

return {
	on = {
		timer = {
		    'at 14:00',
		    'at 09:00'
		}
	},
	execute = function(domoticz, device)
		--Declarations
		local StofzuigerState	= domoticz.devices(14) -- Xiaomi Vacuum status: Charging / Paused / Cleaning / Waiting / Back to home / Sleeping / In Error
		local StofzuigerCont 	= domoticz.devices(15) -- Xiaomi Vacuum control: Clean(10) / Home(20) / Spot(30) / Pauze(40) / Stop(50) / Find(60)
		local StofzuigerFan 	= domoticz.devices(16) -- Xiaomi Vacuum Fan: Quiet(10) / Balanced(20) / Turbo(30) / Max (40)
		local IemandThuis 	= domoticz.devices(54) -- Iemand Thuis
		local Vakantie 		= domoticz.devices(55) -- Vakantie
		local Time 		= require('Time') --Time function
		local CurrentTime 	= Time() --Current time
	    
		--Function
		if (not IemandThuis.active) and (not Vakantie.active) and (CurrentTime.matchesRule('at 14:00')) then -- When nobody home and no vacation
			StofzuigerFan.switchSelector(30) -- Set Fan Level to 30 =  'Turbo'
			StofzuigerCont.switchSelector(10) -- Set Control to 10 = 'Clean'
			domoticz.notify('Mi Vacuum Cleaner','The Vacuumcleaner has been turned on by Domoticz',domoticz.PRIORITY_NORMAL)
	    	elseif (Vakantie.active and CurrentTime.matchesRule('at 09:00 on sun,wed')) then
	        	StofzuigerFan.switchSelector(40) -- Set Fan Level to 30 =  'Max'
		    	StofzuigerCont.switchSelector(10) -- Set Control to 10 = 'Clean'
		    	domoticz.notify('Mi Vacuum Cleaner','The Vacuumcleaner has been turned on by Domoticz in vacation mode',domoticz.PRIORITY_NORMAL)
		end
	end
}
