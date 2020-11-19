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
    local xCord, yCord, zCord = gps.locate()
    local posValue = xStr .. "," .. zStr
    rednet.broadcast(posValue)
    local id,message = rednet.receive()

    if(message == posValue) then 
        getRefuel()
    end
end

function getRefuel()
    turtle.suck()
    shell.run("refuel")
end

for x=1, 2 do
    for i=1, 3 do
        local numToGo = math.random(35, height)
        shell.run("MineRandomly", numToGo, tilesToDig, dropEvery)
    end



end