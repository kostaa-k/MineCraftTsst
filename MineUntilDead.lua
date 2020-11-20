local height = 5
if #arg > 0 then 
  height = tonumber(arg[1])
end

local tilesToDig = 3
if #arg > 1 then 
    tilesToDig = tonumber(arg[2])
end

local dropEvery = 20
if #arg > 2 then 
    dropEvery = tonumber(arg[3])
end

function broadcastForFuel()
    rednet.open("left")
    os.sleep(2)
    local xCord, zCord, yCord = gps.locate()
    local posValue = tostring(xCord) .. "," .. tostring(zCord)
    rednet.broadcast("MINER Need Fuel at:"..posValue)

    --this is the bots message
    local finishedValue = "Refueling:"..posValue

    local id,message = rednet.receive()

    while(message ~= finishedValue) do
        id,message = rednet.receive()
    end
        
    getRefuel()
    turtle.turnRight()
    turtle.turnRight()
end

function getRefuel()
    shell.run("refuel")
    local isTurtleThere = turnUntilRefueler()
    if(isTurtleThere == true) then
        dropBuckets()
    end
end

function turnUntilRefueler()
    local numTurns = 0
    while(numTurns < 4) do
        local aSuccess, theMetadata = turtle.inspect()
        if(aSuccess == false) then
            turtle.turnRight()
        else
            if(string.find(theMetadata["name"], "turtle_advanced")) then
                return true
            else
                turtle.turnRight()
            end
        end

        numTurns = numTurns+1
    end
end

function dropBuckets()

    for i=1,16 do
        tempItem = turtle.getItemDetail(i)
        
        if tempItem ~= nil then
          tempName = string.lower(tempItem["name"])
          if string.find(tempName, "bucket") then
            turtle.select(i)
            turtle.drop()
          end
        end
  
    end

    os.sleep(2)
end

for x=1, 20 do
    for i=1, 10 do
        local numToGo = math.random(35, height)
        shell.run("MineRandomly", numToGo, tilesToDig, dropEvery)
    end

    broadcastForFuel()
end