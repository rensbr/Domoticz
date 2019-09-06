--*------------------------------------------------------------------------------------*--
--Creator: Rens
--Date: 26-04-2019
--Last update: 26-04-2019
--Changelog: 
--Source: -
--Description: Used to send the notifications from Mi Vacuum Cleaner and put some settings
--*------------------------------------------------------------------------------------*--

return {
	on = {
	    devices = {
	        14 -- Xiaomi Vacuum status
        }
	},
	execute = function(domoticz, device)
	    --Declarations
	    local StofzuigerState = domoticz.devices(14) -- Xiaomi Vacuum status: Charging / Paused / Cleaning / Waiting / Back to home / Sleeping / In Error
	    local StofzuigerCont = domoticz.devices(15) -- Xiaomi Vacuum control: Clean(10) / Home(20) / Spot(30) / Pauze(40) / Stop(50) / Find(60)
	    local StofzuigerFan = domoticz.devices(16) -- Xiaomi Vacuum Fan: Quiet(10) / Balanced(20) / Turbo(30) / Max (40)
	    
		--Function
		print('Mi Vacuum status has changed')
		if (StofzuigerState.rawData[1] == 'Back to home') then
		    domoticz.notify('Mi Vacuum Cleaner','The Vacuumcleaner is going back to dock',domoticz.PRIORITY_LOW)
		    StofzuigerFan.switchSelector(20) -- Set Fan Level to Balanced when done
		end
		
		if (StofzuigerState.rawData[1] == 'Charging') then
		    domoticz.notify('Mi Vacuum Cleaner','The Vacuumcleaner is docked and charging',domoticz.PRIORITY_LOW)
		end
		
		if (StofzuigerState.rawData[1] == 'Cleaning') then
		    domoticz.notify('Mi Vacuum Cleaner','The Vacuumcleaner is cleaning',domoticz.PRIORITY_LOW)
		end
		
		if (StofzuigerState.rawData[1] == 'In Error') then
		    domoticz.notify('Mi Vacuum Cleaner','The Vacuumcleaner is in error',domoticz.PRIORITY_HIGH)
            --StofzuigerCont.switchSelector(10).checkFirst() --Set Vacuum back on when in error
		end
		
		if (StofzuigerState.rawData[1] == 'Paused') then
		    domoticz.notify('Mi Vacuum Cleaner','The Vacuumcleaner is paused',domoticz.PRIORITY_HIGH)
		end
	end
}
