
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
    shell.run("testRail", 1, 2, 3, 4)
end



local count = 0
rednet.open("left")
local id, message = rednet.receive()

while(message ~= "STOP NOW") do 

    if (string.find(message, "FROM COMMAND")) then
        actOnMessage(message)
        rednet.broadcast("REFUELER RDY")
    end


    id,message = rednet.receive()
end