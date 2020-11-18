
local lineLength = 5
if #arg > 0 then 
    lineLength = tonumber(arg[1])
end

local dropEvery


function digInLine(numberOfTiles)
    for i=1,(numberOfTiles) do
      if(turtle.detect() == true) then
        
        slotToFill = selectCorrectSlot()
        couldDig = turtle.dig()
        if(couldDig == false) then
          print("COULDNT DIG this way!")
        end
      end
      couldMove = turtle.forward()
      if(couldMove == false) then
        while(couldMove == false) do
            didAttack = turtle.attack()
            print("Attacked")
            slotToFill = selectCorrectSlot()
            turtle.dig()
            couldMove = turtle.forward()
        end
      end
    end
end

function selectCorrectSlot()
    for i=1, 16 do
        turtle.select(i)
        isSame = turtle.compare(i)
        if(isSame == true) then
            return i
        end
    end

    return 0
end

function digRandomly()
    
    listOfMoves = {}
    
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
        while(turtle.detect() == false) do
            digInLine(1)
            table.insert(listOfMoves, "S")
        end
    else
        digInLine(1)
        table.insert(listOfMoves, "S")
    end

    for i,v in ipairs(listOfMoves) do print(i,v) end
end

digRandomly()