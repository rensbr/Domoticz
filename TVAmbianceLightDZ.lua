--*------------------------------------------------------------------------------------*--
--Creator: Rens
--Date: 26-04-2019
--Last update: 26-04-2019
--Changelog: Changed dimTo to direct link
--Source: https://www.domoticz.com/forum/viewtopic.php?p=192172&sid=ca64da6b45b11f5916f257a9bfb2b243#p192172
--Description: Used to dim and change the lights when the TV is on
--*------------------------------------------------------------------------------------*--

return {
	on = {
		devices = {
		    47 -- TV woonkamer
		},
		timer = {
		    'at 15 minutes before sunset'
		}
	},
	execute = function(domoticz, device)
	    --Declarations
		local LightWoon 	= domoticz.devices(139) --Lampen Woonkamer
		local LightTV 		= domoticz.devices(121) --Lampen TV woonkamer
		local TV 		= domoticz.devices(47) -- TV woonkamer
		local Time 		= require('Time') --Time function
    		local CurrentTime 	= Time() --Current time
		
		--Function
		if ((TV.active) and (CurrentTime.matchesRule('at 15 minutes before sunset-sunrise'))) then -- When sunset-sunrise and TV is on
		    	--Set color and dim is not possible with standard function, so that has to be arranged with the direct link
		    	domoticz.openURL({ --Light Woonkamer
                	url = domoticz.settings['Domoticz url'] .. '/json.htm?type=command&param=setcolbrightnessvalue&idx=139&color={"m":3,"t":0,"r":255,"g":204,"b":43,"cw":0,"ww":0}&brightness=90',
                	method = "GET",
            		})
            
            		domoticz.openURL({ -- Light TV
                	url = domoticz.settings['Domoticz url'] .. '/json.htm?type=command&param=setcolbrightnessvalue&idx=121&color={"m":3,"t":0,"r":255,"g":204,"b":43,"cw":0,"ww":0}&brightness=90',
                	method = "GET",
            		})
		elseif (not TV.active) then -- When tV off 
		    	if (LightWoon.active) then -- lamp is still on
		        	LightWoon.setKelvin(255)
		        	LightWoon.dimTo(100)
		    	end
		    	LightTV.switchOff().checkFirst()
		end    
	end
}
