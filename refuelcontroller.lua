

local turtleHomeLocationX = 506
if #arg > 0 then 
    turtleHomeLocationX = tonumber(arg[1])
end

local turtleHomeLocationZ = 466
if #arg > 1 then 
    turtleHomeLocationZ = tonumber(arg[2])
end

function actOnMessage(theMessage)

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

    shell.run("testRail", xValue, zValue, reconstructedMessage)
    shell.run("testRail", turtleHomeLocationX, turtleHomeLocationZ, 3, 4)
end



local count = 0
rednet.open("left")
rednet.broadcast("REFUELER RDY")
local id, message = rednet.receive()

while(message ~= "STOP NOW") do 

    if (string.find(message, "FROM COMMAND")) then
        rednet.broadcast("REFUELER BUSY")
        actOnMessage(message)
        rednet.broadcast("REFUELER RDY")
    end


    id,message = rednet.receive()
end