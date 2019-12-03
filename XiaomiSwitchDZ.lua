--*------------------------------------------------------------------------------------*--
--Creator: Rens
--Date: 26-04-2019
--Last update: 03-12-2019
--Changelog: Added local SwitchNum
--Source: https://gathering.tweakers.net/forum/list_message/58490276#58490276
--Description: Used to switch on lights with an Xiaomi Switch
--*------------------------------------------------------------------------------------*--

--Declarations
local SwitchNum = 98

return {
    on = {
        devices = {
            SwitchNum -- Woonkamer Schakelaar  
        }                               
    },
    execute = function(domoticz, device)
        --Declarations
		local Switch        = domoticz.devices(SwitchNum) --Woonkamer Schakelaar
		local LightWoon     = domoticz.devices(251) --Lampen Woonkamer
		local LightKeuken   = domoticz.devices(253) -- Lampen Keuken
        
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
