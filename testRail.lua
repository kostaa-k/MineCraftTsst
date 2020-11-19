local turtleLocationX = 506
if #arg > 0 then 
    turtleLocationX = tonumber(arg[1])
end

local turtleLocationZ = 466
if #arg > 1 then 
    turtleLocationZ = tonumber(arg[2])
end


function canGoRight()
    turtle.turnRight()
    if(turtle.detect() == true) then
        return false
    end
    return true
end

function getDistanceFromPoint(fromX, fromZ, destX, destZ)
    local xDist = math.abs(destX-fromX)
    local yDist = math.abs(destZ-fromZ)

    return (xDist+yDist)

end

function goToTurtle(turtleX, turtleZ)
    local currentX, currentZ, currentY = gps.locate()
    local distFromTurtle = getDistanceFromPoint(currentX, currentZ, turtleX, turtleZ)

    local hasRedStone = false
    while(distFromTurtle > 1) do
        hasRedStone = moveForward(hasRedStone)
    end

    didDrop = dropBucketOfLava()
end

function dropBucketOfLava()
    for i=1, 16 do
        tempItem = turtle.getItemDetail(i)
        
        if (tempItem ~= nil) then
            print(tempItem["name"])
        end
    end

    return true
end


function moveForward(wasRedStone) 
    local success, tableData = turtle.inspectDown()
    isRedStone = false
    if(success == true) then
        if(string.find(tableData["name"], "Redstone")) then
            if(wasRedStone == false) then
                turtle.turnRight()
            end
            isRedStone = true
        else
            isRedStone = false
        end
    
    end
    local couldMove =  turtle.forward()
    if(couldMove == false) then
        if(canGoRight() == true) then
            turtle.forward()
        else
            turtle.turnLeft()
            turtle.turnLeft()
            turtle.forward()
        end
    end

    return isRedStone
end



goToTurtle(turtleLocationX, turtleLocationZ)