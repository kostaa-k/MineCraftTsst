
local height = 5
if #arg > 0 then 
  height = tonumber(arg[1])
end

local tilesToDig = 3
if #arg > 1 then 
    tilesToDig = tonumber(arg[2])
end





function turtleDigDown(numTiles)
    local count = 0
    for i=1,numTiles do 
      if(turtle.detectDown() == true) then
        local couldDig = turtle.digDown()
        if(couldDig == false) then
          print("COULDNT DIG DOWN!")
        end
      end
      local is_true = turtle.down()
      if(is_true == true) then
        count = count+1
      end
    end
  
    return count
end




function turtleComeUp(numTiles)
    for i=1,numTiles do 
      if(turtle.detectUp() == true) then
        turtle.digUp()
        turtle.up()
      else
        turtle.up()
      end
    end
end




function digInLine(numberOfTiles)
    for i=1,(numberOfTiles) do
      if(turtle.detect() == true) then
        
        if(turtle.compare() == false) then
            local slotToFill = selectCorrectSlot()
        end
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
        local isSame = turtle.compare()
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
                if(numTurns == 1) then
                    table.insert(listOfMoves, "R")
                else if (numTurns == 3) then
                    table.insert(listOfMoves, "L")
                end
                
                end

                numTurns = 4
            end
        end

        if(canGo == false) then
            digInLine(1)
            numOfMoves = numOfMoves+1
            table.insert(listOfMoves, "S")
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
        if(value == "R") then
            table.insert(reverseMoves, "L")
        elseif(value == "L") then
            table.insert(reverseMoves, "R")
        else
            table.insert(reverseMoves, value)
        end
    end

    return reverseMoves

end

function traverseBackWards(movesToMake)
    turtle.turnRight()
    turtle.turnRight()

    for i =1, #movesToMake do
        local value = movesToMake[i]
        if(value == "L") then
            turtle.turnLeft()
        elseif(value == "R") then
            turtle.turnRight()
        else
            digInLine(1)
        end
    end

    turtle.turnRight()
    turtle.turnRight()

end

numTilesDown = turtleDigDown(height)

theMoves = digRandomly(tilesToDig)
theReverseMoves = createReverseList(theMoves)

traverseBackWards(theReverseMoves)

turtleComeUp(numTilesDown)