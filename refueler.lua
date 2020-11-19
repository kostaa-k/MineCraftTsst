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


function getPossibleMoves()
    numTurns = 0
    local listOfMoves = {}
    while(numTurns < 4) do
        if(turtle.detect() == false) then
            turtle.turnRight()
            numTurns = numTurns+1
        else
            canGo = true
            if(numTurns == 1) then
                table.insert(listOfMoves, "R")
            elseif (numTurns == 2) then
                table.insert(listOfMoves, "B")
            elseif (numTurns == 3) then
                table.insert(listOfMoves, "L")
            elseif (numTurns == 0) then
                table.insert(listOfMoves, "S")
            end
            numTurns = 4
        end
    end

    return listOfMoves

end

function goRight()
    turtle.turnRight()
    turtle.forward()
    turtle.turnLeft()
end

function goLeft()
    turtle.turnRight()
    turtle.forward()
    turtle.turnLeft()
end

local possibleMoves = getPossibleMoves()

for i,v in ipairs(possibleMoves) do print(i,v) end