--*------------------------------------------------------------------------------------*--
--Creator: Rens
--Date: 28-08-2019
--Last update: 28-08-2019
--Changelog: 
--Source: https://www.domoticz.com/forum/viewtopic.php?p=91615#p91615
--Description: Sets the Sonos Speaker Status and displays numbers
--*------------------------------------------------------------------------------------*--
return {
	on = {
		timer = {
		    'every minute'
		}
	},
    execute = function(domoticz, device)
        --Declarations
        local json 		= (loadfile "/home/pi/domoticz/scripts/lua/JSON.lua")()
        local sonos		= assert(io.popen('curl http://localhost:5005/Woonkamer/state'))
        local SonosControl 	= domoticz.devices(202) -- Sonos Woonkamer
        local SonosStatus 	= domoticz.devices(203) -- Sonos Woonkamer Status
        local Sonostext
        local SonosState
        local status 		= sonos:read('*all')
        sonos:close()
        local jsonStatus 	= json:decode(status)
        
        --Get states from json file
        playerstate 	= jsonStatus['playbackState']
        currentartist 	= jsonStatus['currentTrack']['artist']
        currenttitle 	= jsonStatus['currentTrack']['title']
        currentalbum 	= jsonStatus['currentTrack']['album']
        source 		= jsonStatus['currentTrack']['type']
        nextartist 	= jsonStatus['nextTrack']['artist']
        nexttitle 	= jsonStatus['nextTrack']['title']
        nextalbum 	= jsonStatus['nextTrack']['album']
        
        --Function
        if (playerstate == 'PLAYING') then
            SonosState = 10
            
            --Check which content is played
            if source == "radio" then
                Sonostext = "Now playing: Radiostation: " .. currentartist .. " - " .. currenttitle
            else
                Sonostext = "Now playing: " .. currentartist .. " - " .. currenttitle .. "\nNext: " .. nextartist .. " -" .. nexttitle
            end
        elseif (playerstate == 'PAUSED_PLAYBACK') then
            SonosState = 20
            Sonostext = "Paused"
        elseif (playerstate == 'STOPPED') then
            SonosState = 0
            Sonostext = "Stopped"
        else
            SonosState = 0
            Sonostext = "Unknown"
        end
        
        --Update the text when changed
        if (Sonostext ~= SonosStatus.text) then
            SonosStatus.updateText(Sonostext)
        end
        
        --Set state when changed
        if (SonosState ~= SonosControl.level) then
            SonosControl.switchSelector(SonosState)
        end
  end
}
