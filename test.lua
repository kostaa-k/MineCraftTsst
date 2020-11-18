
local lineLength = 5
if #arg > 0 then 
    lineLength = tonumber(arg[1])
end

local dropEvery


function digInLine(numberOfTiles)
    for i=1,(numberOfTiles) do
      if(turtle.detect() == true) then
        
        local slotToFill = selectCorrectSlot()
        local couldDig = turtle.dig()
        if(couldDig == false) then
          print("COULDNT DIG this way!")
        end
      end
      local couldMove = turtle.forward()
      if(couldMove == false) then
        while(couldMove == false) do
            local didAttack = turtle.attack()
            print("Attacked")
            local slotToFill = selectCorrectSlot()
            turtle.dig()
            couldMove = turtle.forward()
        end
      end
    end
end

function selectCorrectSlot()
    for i=1, 16 do
        turtle.select(i)
        local isSame = turtle.compare(i)
        if(isSame == true) then
            return i
        end
    end

    return 0
end

function digRandomly(maxTiles)
    
    local listOfMoves = {}
    
    local numOfMoves = 0

    while(numOfMoves < maxTiles) do 
        numTurns = 0
        canGo = false
        while(numTurns < 4) do
            if(turtle.detect() == false) then
                turtle.turnRight()
                numTurns = numTurns+1
            else
                canGo = true
                for i=0, (numTurns-1) do
                    table.insert(listOfMoves, "R")
                end
                numTurns = 4
            end
        end

        if(canGo == false) then
            while(turtle.detect() == false and numOfMoves < maxTiles) do
                digInLine(1)
                numOfMoves = numOfMoves+1
                table.insert(listOfMoves, "S")
            end
        else
            digInLine(1)
            table.insert(listOfMoves, "S")
            numOfMoves = numOfMoves+1
        end

    end
    return listOfMoves
end


function createReverseList(forwardMoves)

    local reverseMoves = {}

    for i = #forwardMoves, 1, -1 do
        local value = forwardMoves[i]
        table.insert(reverseMoves, value)
    end

    return reverseMoves

end

theMoves = digRandomly(lineLength)
theReverseMoves = createReverseList(theMoves)

for i,v in ipairs(theMoves) do print(i,v) end
print("Reverse moves:")
for i,v in ipairs(theReverseMoves) do print(i,v) end