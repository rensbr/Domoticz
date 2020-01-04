--*------------------------------------------------------------------------------------*--
--Creator: Rens
--Date: 04-01-2020
--Last update: 
--Changelog: 
--Source: https://gathering.tweakers.net/forum/list_message/61060350#61060350
--Description: Log counter incredimental values to InfluxDB
--*------------------------------------------------------------------------------------*--

return {
    on = {
        devices = {
            25
        }
    },
    execute = function(domoticz, device)
        zon = domoticz.devices(25)
        os.execute("curl -i -XPOST 'http://IP:8086/write?db=domoticz' --data-binary 'Zonnepanelen-opbrengst,idx=25,name='Zonnepanelen' value="..zon.counterToday.."'")
        domoticz.log(""..zon.counterToday.."")
    end
}
