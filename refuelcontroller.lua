
local count = 0
rednet.open("left")

local id,message = rednet.receive()
local xValueStr = ""
local zValueStr = ""

local secondSide = false
for c in string.gmatch(message, ".") do 
    if(c == ",") then
        secondSide = true

    else
        if(secondSide == false) then
            xValueStr = xValueStr..c
        else
            zValueStr = zValueStr..c
        end
    end
end 

print(xValueStr)
print(zValueStr)

local xValue = tonumber(xValueStr)
local zValue = tonumber(zValueStr)

shell.run("testRail", xValue, zValue)
shel.run("testRail", 1, 2, 3)