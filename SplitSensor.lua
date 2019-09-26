return {
    on = {
        devices = {
            1  -- IDX WTGR800
        }
    },
    execute = function(domoticz, device)
        --Declarations
        local Sensor          = domoticz.devices(1) -- IDX WTGR800
        local Temp          = domoticz.devices(2) -- IDX Dummy temp sensor
        local Hum         = domoticz.devices(3) -- IDX Dummy Hum sensor
        local Pres         = domoticz.devices(4) -- IDX Dummy Pres sensor
        
        --Function
        Temp.temperature = Sensor.temperature 
        Hum.humidity = Sensor.humidity
        Pres.pressure = Sensor.pressure
    end
}
