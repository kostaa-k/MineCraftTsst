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

    return (xDist+yDist)

end


function goLeft()
    turtle.turnLeft()
    turtle.forward()
    turtle.turnRight()
end

function goRight()
    turtle.turnRight()
    turtle.forward()
    turtle.turnLeft()
end

function getPossibleMoves()
    local numTurns = 0
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

function makeMove(whereTo, theX, theZ)

    if(whereTo == "S") then
        turtle.forward()
        return theX, theZ-1
    elseif(whereTo == "R") then
        goRight()
        return theX+1, theZ
    elseif(whereTo == "L") then
        goLeft()
        return theX-1, theZ
    elseif(whereTo == "B") then
        turtle.back()
        return theX, theZ+1
        
    end

    return nil
end

function getLocationHash(xVal, zVal)
    local xStr = tostring(xVal)
    local zStr = tostring(zVal)

    local hashVal = xStr .. "," .. zStr

    return hashVal
    
end


function getCoordsOfMove(theCurrentX, theCurrentZ, theMove)

    if(theMove == "S") then
        return theCurrentX, theCurrentZ-1
    elseif(theMove == "R") then
        return theCurrentX+1, theCurrentZ
    elseif(theMove == "L") then
        return theCurrentX-1, theCurrentZ
    elseif(theMove == "B") then
        return theCurrentX, theCurrentZ+1
    end

end

function getToPoint(getToX, getToZ)

    local visitedStates = {}

    local currentX, currentZ, currentY = gps.locate()

    while(currentX ~= getToX or currentZ ~= getToZ) do
        table.insert(visitedStates, getLocationHash(currentX, currentZ))
        print(getLocationHash(currentX, currentZ))
        local possibleMoves = getPossibleMoves()
        for i,v in ipairs(possibleMoves) do print(i,v) end
        if (#possibleMoves == 0) then
            return -1
        end

        local minMove = "B"
        local minHeuristicVal = 1000
        for i=1, #possibleMoves do
            local thePosHash = getLocationHash(getCoordsOfMove(currentX, currentZ, possibleMoves[i]))

            local isInStates = hasBeenVisitedBefore(visitedStates, thePosHash)

            if(isInStates == false) then
                local heuristicVal = getHeuristicOfMove(currentX, currentZ, getToX, getToZ, possibleMoves[i])
                
                if(heuristicVal <= minHeuristicVal) then
                    minMove = possibleMoves[i]
                    minHeuristicVal = heuristicVal
                end
            end
        end

        makeMove(minMove, currentX, currentZ)
        currentX, currentZ, currentY = gps.locate()

    end
end

function hasBeenVisitedBefore(theVisistedStates, theLocationHash)
    for i=1, #theVisistedStates do
        if (theLocationHash == theVisistedStates[i]) then
            return true
        end
    end

    return false
end
function getHeuristicOfMove(theX, theZ, destinationX, destinationZ, theMove)

    if(theMove == "S") then
        return getDistanceFromPoint(theX, theZ-1, destinationX, destinationZ)
    elseif(theMove == "R") then
        return getDistanceFromPoint(theX+1, theZ, destinationX, destinationZ)
    elseif(theMove == "L") then
        return getDistanceFromPoint(theX-1, theZ, destinationX, destinationZ)
    elseif(theMove == "B") then
        return getDistanceFromPoint(theX, theZ+1, destinationX, destinationZ)
    end
end



-- local possibleMoves = getPossibleMoves()

-- for i,v in ipairs(possibleMoves) do print(i,v) end

-- local myStartLocation = getLocationHash(startX, startZ)

-- print(myStartLocation)

getToPoint(toX, toZ)