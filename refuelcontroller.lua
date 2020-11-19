
local count = 0
rednet.open("left")

local id,message = rednet.receive()
local xValueStr = ""
local zValueStr = ""

local secondSide = false
for c in string.gmatch(message, ".") do 
    if(secondSide == false) then
        xValueStr = xValueStr..c
    else
        zValueStr = zValueStr..c
    end
    if(c == ",") then
        secondSide = true
    end
end 

print(xValueStr)
print(zValueStr)