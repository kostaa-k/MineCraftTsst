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
    turtle.turnLeft()
    turtle.turnLeft()
    rednet.open("left")
    os.sleep(2)
    local xCord, yCord, zCord = gps.locate()
    local posValue = xStr .. "," .. zStr
    rednet.broadcast(posValue)
    local id,message = rednet.receive()

    if(message == posValue) then 
        getRefuel()
    end
end

function getRefuel()
    shell.run("refuel")
    dropBuckets()
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

for x=1, 2 do
    for i=1, 3 do
        local numToGo = math.random(35, height)
        shell.run("MineRandomly", numToGo, tilesToDig, dropEvery)
    end

    broadcastForFuel()
end