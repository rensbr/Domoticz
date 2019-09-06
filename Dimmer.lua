--*------------------------------------------------------------------------------------*--
--Creator: Rens
--Date: 22-05-2019
--Last update: 22-05-2019
--Changelog:
--Source: -
--Description: Add 20% brightness when the lights are on, set to 20% when at 100% and do nothing when off
--*------------------------------------------------------------------------------------*--

return {
	on = {
		groups = {
		    4 --Number groep/scene
		}
	},
	execute = function(domoticz, device)
		--Declarations
		local Light1 = domoticz.devices(150) -- Number/name Light 
		--local Light2 = domoticz.devices(121) -- Number/name Light
		--local Light3 = domoticz.devices(121) -- Number/name Light
		
		--Function
		if (Light1.Active) then
		    if (Light1.level > 0 and Light1.level < 99) then
		        Light1.dimTo(Light1.level + 20)
		    elseif (Light1.level == 100) then
	            Light1.dimTo(20)
	        end
        end
	end
}
