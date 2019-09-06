--*------------------------------------------------------------------------------------*--
--Creator: Rens
--Date: 20-05-2019
--Last update: 20-05-2019
--Changelog:
--Source: https://mijnsmarthome.tweakblogs.net/blog/16533/aanwezigheidssensoren-in-huis-hoe-voorkom-je-knipperende-lampen
--Description: Used to turn off the WC light, depending on the Human Body Sensor
--*------------------------------------------------------------------------------------*--

function timedifference(timestamp)
  y, m, d, H, M, S = timestamp:match("(%d+)-(%d+)-(%d+) (%d+):(%d+):(%d+)")
  difference = os.difftime(os.time(), os.time{year=y, month=m, day=d, hour=H, min=M, sec=S})
  return difference
end

commandArray = {}

s = otherdevices_lastupdate['Zigbee2MQTT - HBS WC'] --HBS WC

if(otherdevices['Zigbee2MQTT - HBS WC']=='Off' and otherdevices['Lamp WC']~='Off' and timedifference(s) > 60) then
        commandArray['Lamp WC']='Off' -- WC light
end
