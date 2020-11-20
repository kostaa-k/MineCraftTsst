
function getCoordsFromMessage(theMessage)

    local xValueStr = ""
    local zValueStr = ""

    local secondSide = false
    for c in string.gmatch(theMessage, ".") do 
        if(c == ",") then
            secondSide = true

        else
            if(tonumber(c) ~= nil) then
                if(secondSide == false) then
                    xValueStr = xValueStr..c
                else
                    zValueStr = zValueStr..c
                end
            end
        end
    end 

    print(xValueStr)
    print(zValueStr)

    local xValue = tonumber(xValueStr)
    local zValue = tonumber(zValueStr)

    local reconstructedMessage = xValueStr..","..zValueStr

    return reconstructedMessage
end


local refuelerBusy = true
local count = 0
rednet.open("left")
local id, message = rednet.receive()

local currentQueue = {}
local toRefuelMessage = ""
while(message ~= "STOP NOW") do 

    if (string.find(message, "MINER")) then
        local theNewMessage = getCoordsFromMessage(message)
        if(refuelerBusy == false) then
            rednet.broadcast("FROM COMMAND REFUEL "..theNewMessage)
        else
            --push
            table.insert(currentQueue, theNewMessage)
        end
        
    elseif(string.find(message, "REFUELER RDY")) then
        refuelerBusy = false
        -- check if queue is not empty, 
        if(#currentQueue > 0 ) then
            toRefuelMessage = table.remove(currentQueue, 1)
            rednet.broadcast("FROM COMMAND REFUEL "..toRefuelMessage)
        end
    elseif(string.find(message, "REFUELER BUSY")) then
        refuelerBusy = true
    end


    id,message = rednet.receive()
end