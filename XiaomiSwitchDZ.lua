--*------------------------------------------------------------------------------------*--
--Creator: Rens
--Date: 26-04-2019
--Last update: 20-08-2019
--Changelog:
--Source: https://gathering.tweakers.net/forum/list_message/58490276#58490276
--Description: Used to switch on lights with an Xiaomi Switch
--*------------------------------------------------------------------------------------*--

return {
    on = {
        devices = {
            98 -- Switch 
        }                               
    },
    execute = function(domoticz, device)
        --Declarations
	local Switch 		= domoticz.devices(98) --Switch
	local LightWoon 	= domoticz.devices(139) --Light Woonkamer
	local LightKeuken	= domoticz.devices(172) --Light Keuken
        
        --Function
        if (Switch.state == 'Switch 1') then
            LightWoon.toggleSwitch() -- Toggle on Switch 1
        elseif (Switch.state == 'Switch 1 Double Click') then
            LightWoon.dimTo(100) -- 100% on Switch 1 Double
        elseif (Switch.state == 'Switch 2') then
            LightKeuken.toggleSwitch() -- Toggle on Switch 2
        elseif (Switch.state == 'Switch 2 Double Click') then
            LightKeuken.dimTo(100) -- 100% on Switch 2 Double
        elseif (Switch.state == 'Both_Click') then
            LightWoon.toggleSwitch()
            LightKeuken.toggleSwitch()
        end
    end
}
