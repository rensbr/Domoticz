--*------------------------------------------------------------------------------------*--
--Creator: Rens
--Date: 18-07-2019
--Last update: 14-08-2019
--Changelog:
--Source: https://www.domoticz.com/wiki/DzVents:_next_generation_LUA_scripting#Shared_helper_functions
--Description: The Library for common functions
--*------------------------------------------------------------------------------------*--

return {
    helpers = {
        FindTrashDate = function(Type,Zipcode,Number)
            --*------------------------------------------------------------------------------------*--
            --Creator: Rens
            --Date: 13-08-2019
            --Last update: 14-08-2019
            --Changelog:
            --Source: https://www.domoticz.com/forum/viewtopic.php?f=61&t=18628
            --Description: Used to pickup the afval dates and search for the nearest pickupdate
            --*------------------------------------------------------------------------------------*--
            
            --Declarations
            local Time          = require('Time') --Time function
            local CurrentTime   = Time() --Current time
            local Day           = CurrentTime.day
            local Month         = CurrentTime.month
            local Year          = CurrentTime.year
            local Count         = 60
            local String
            
            --Function
            url = ('curl  "https://dataservice.deafvalapp.nl/dataservice/DataServiceServlet?service=OPHAALSCHEMA&land=NL&postcode=' .. Zipcode ..'&straatId=0&huisnr=' .. Number .. '"') 
            local f = io.popen(url) --Get the data
            
            while (true) do 
                local line = f:read("*line") --search per line
                if (not line) then --EOF
                    break 
                end
                
                if (string.find(line,Type)) then --Search for line which contain the type (Paper, GFT, etc)
                    String = line
                    
                    --Search for nearest afval date
                    for i=Count,1,-1 do
                        if string.len(Day) == 1 then --Convert day from 6 to 06
                            Day = "0" .. Day 
                        end
                
                        if string.len(Month) == 1 then --Convert Month from 7 to 07
                            Month = "0" .. Month 
                        end
                
                        local Trash_NextDate = Day .. "%-" .. Month .. "%-" .. Year
                        if string.find(String, Trash_NextDate) then --Find Next TrashDate
                            Date = Day .. "-" .. Month .. "-" .. Year
                            break
                        else
                            if (tonumber(Day) == 31 ) then 
                                Day = 1
                                Month = tonumber(Month) + 1
                            else
                                Day = tonumber(Day) + 1
                            end
                        end
                    end
                end
            end
        return Date
        end,
    }
}
