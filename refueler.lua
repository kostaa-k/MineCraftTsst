local facing = "N"

local startX, startZ, startY = gps.locate()

local toX = startX
if #arg > 0 then 
    toX = tonumber(arg[1])
end

local toZ = startZ
if #arg > 1 then 
    toZ = tonumber(arg[2])
end

--facing northi -> going forward Z gets smaller
-- facing north -> going left x gets smaller


function getDistanceFromPoint(fromX, fromZ, destX, destZ)
    local xDist = math.abs(destX-fromX)
    local yDist = math.abs(destZ-fromZ)

    return xDist+yDist

end


function getPossibleMoves()
    numTurns = 0
    local listOfMoves = {}
    while(numTurns < 4) do
        if(turtle.detect() == false) then
            if(numTurns == 1) then
                table.insert(listOfMoves, "R")
            elseif (numTurns == 2) then
                table.insert(listOfMoves, "B")
            elseif (numTurns == 3) then
                table.insert(listOfMoves, "L")
            elseif (numTurns == 0) then
                table.insert(listOfMoves, "S")
            end
        
        end
        turtle.turnRight()
        numTurns = numTurns+1
    end

    return listOfMoves

end

function move(whereTo)

    if(whereTo == "S") then
        turtle.forward()
    elseif(whereTo == "R") then
        goRight()
    elseif(whereTo == "L") then
        goLeft()
    elseif(whereTo == "B") then
        turtle.back()
    end
end

function goRight()
    turtle.turnRight()
    turtle.forward()
    turtle.turnLeft()
end

function getLocationHash(xVal, yVal)
    local xStr = tostring(xVal)
    local zStr = tostring(yVal)

    local hashVal = xStr .. "," .. zStr

    return hashVal
    
end

function goLeft()
    turtle.turnRight()
    turtle.forward()
    turtle.turnLeft()
end

local possibleMoves = getPossibleMoves()

for i,v in ipairs(possibleMoves) do print(i,v) end

local myStartLocation = getLocationHash(startX, startZ)

print(myStartLocation)