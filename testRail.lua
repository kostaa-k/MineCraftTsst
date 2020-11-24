local turtleLocationX = 506
if #arg > 0 then 
    turtleLocationX = tonumber(arg[1])
end

local turtleLocationZ = 466
if #arg > 1 then 
    turtleLocationZ = tonumber(arg[2])
end

local messageToSend = "NOT WORKING"
if #arg > 2 then 
    messageToSend = arg[3]
end

local goHome = false
if #arg > 3 then 
    goHome = true
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

function goToTurtle(turtleX, turtleZ, toGoHome, sendingMessage)
    local currentX, currentZ, currentY = gps.locate()
    local distFromTurtle = getDistanceFromPoint(currentX, currentZ, turtleX, turtleZ)


    local hasRedStone = false
    while(distFromTurtle > 1) do
        hasRedStone = moveForward(hasRedStone)
        currentX, currentZ, currentY = gps.locate()
        distFromTurtle = getDistanceFromPoint(currentX, currentZ, turtleX, turtleZ)
    end

    if(toGoHome == false) then
        local isTurtleThere = turnTowardsTurtle()
        if(isTurtleThere == true) then
            local didDrop = dropBucketOfLava()
        else
            turtle.turnLeft()
        end
        rednet.open("left")
        rednet.broadcast("Refueling:"..sendingMessage)

        os.sleep(5)

    else
        local theSuccess = turnTowardsChest()
        print("Dropping all buckets")
        os.sleep(2)
        dropallBuckets()
        print(theSuccess)
        turtle.suck()
        turtle.suck()
        turtle.suck()
        shell.run("refuel")
        shell.run("refuel")
        shell.run("refuel")
        dropallBuckets()
        os.sleep(5)
        turtle.suck()
        turtle.suck()
        turtle.suck()
        print("Got full buckets")
    end

end

function turnTowardsChest()
    local numTurns = 0
    while(numTurns < 4) do
        local aSuccess, theMetadata = turtle.inspect()
        if(aSuccess == false) then
            turtle.turnRight()
        else
            if(string.find(theMetadata["name"], "chest")) then
                return true
            else
                turtle.turnRight()
            end
        end

        numTurns = numTurns+1
    end

    return false

end


function turnTowardsTurtle()
    local numTurns = 0
    while(numTurns < 4) do
        local aSuccess, theMetadata = turtle.inspect()
        if(aSuccess == false) then
            turtle.turnRight()
        else
            if(string.find(theMetadata["name"], "turtle")) then
                return true
            else
                turtle.turnRight()
            end
        end

        numTurns = numTurns+1
    end

    return false

end


function dropBucketOfLava()
    for i=1, 16 do
        tempItem = turtle.getItemDetail(i)
        
        if (tempItem ~= nil) then
            if string.find(tempItem["name"], "lava_bucket") then
                turtle.select(i)
                turtle.drop()
              end
        end
    end

    return true
end


function dropallBuckets()
    for i=1, 16 do
        tempItem = turtle.getItemDetail(i)
        
        if (tempItem ~= nil) then
            if string.find(tempItem["name"], "bucket") then
                turtle.select(i)
                turtle.drop()
              end
        end
    end

    return true
end

function moveForward(wasRedStone) 
    local success, tableData = turtle.inspectDown()
    local isRedStone = false
    if(success == true) then
        if(string.find(tableData["name"], "drac")) then
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


function getLocationHash(xVal, zVal)
    local xStr = tostring(xVal)
    local zStr = tostring(zVal)

    local hashVal = xStr .. "," .. zStr

    return hashVal
    
end

local goHomeX = turtleLocationX
local goHomeZ = turtleLocationZ

if(goHome == false) then
    goToTurtle(turtleLocationX, turtleLocationZ, false, messageToSend)
else
    goToTurtle(goHomeX, goHomeZ, true, "none")
    turnTowardsChest()
end