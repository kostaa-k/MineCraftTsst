
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

NumTimesWentUp = 0

local totalFuelPredicted = (height*2)+(tilesToDig*2)
local beginFuelLevel = tonumber(turtle.getFuelLevel())

if(totalFuelPredicted >= beginFuelLevel-1000) then
  print("Not enough Fuel!")
  do return end
end

local startingX, startingZ, startingY = gps.locate()


function turtleDigDown(numTiles)
    local count = 0
    for i=1,numTiles do 
      if(turtle.detectDown() == true) then
        turtle.digDown()
        local couldMove = turtle.down()
        local numTimesTried = 0 
        if(couldMove == false) then
          while(couldMove == false and numTimesTried<20) do
              local didAttack = turtle.attackDown()
              turtle.digDown()
              couldMove = turtle.down()
              numTimesTried = numTimesTried+1
          end
          if(couldMove == false and numTimesTried >= 20) then
            count = count-1
          end
        end
      else
        turtle.down()
      end
      count = count+1
    end
  
    return count
end




function turtleComeUp(numTiles)
    for i=1,numTiles do 
      if(turtle.detectUp() == true) then
        turtle.digUp()
        local couldMove = turtle.up()
        if(couldMove == false) then
          while(couldMove == false) do
              local didAttack = turtle.attackUp()
              turtle.digUp()
              couldMove = turtle.up()
          end
        end
      else
        turtle.up()
      end
    end
end




function digInLine(numberOfTiles)
    for i=1,(numberOfTiles) do
      if(turtle.detect() == true) then

        local inFront, theMetadata = turtle.inspect()
        if(inFront == true) then
          if(string.find(theMetadata["name"], "turtle")) then
            local goingUp = math.random(0, 3)
            turtleComeUp(goingUp)
            NumTimesWentUp = NumTimesWentUp+goingUp
          end
        end
        
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

    turtle.select(1)
    return 0
end

function dropNonImportant(count)

    importantWords = {"ore", "diamond", "emerald", "ruby", "coal", "redstone", "basalt", "redstone", "draconium", "turtle", "obsidian", "sapphire", "bucket"}
    for i=1,16 do
        tempItem = turtle.getItemDetail(i)
        
        if tempItem ~= nil then
          if count == 0 then
            turtle.select(i)
            turtle.placeDown()
          end
          tempName = string.lower(tempItem["name"])
          if (isInList(importantWords, tempName) == true) then
            count = count+1
          else
            turtle.select(i)
            turtle.dropDown()
          end
        end
  
    end
  end
  
  function isInList(theList, theWord)
    for i in pairs(theList) do
      if string.find(theWord, theList[i]) then
        return true
      end
    end
  
    return false
  end

function digRandomly(maxTiles, toDropEvery)
    
    local listOfMoves = {}
    
    local numOfMoves = 0

    while(numOfMoves < maxTiles) do 
        if(math.fmod(numOfMoves, toDropEvery) == 0) then
            dropNonImportant(1)
        end
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

function realDigRandom()

  local listOfMoves = {}
    
    local numOfMoves = 0

    while(numOfMoves < maxTiles) do 
        if(math.fmod(numOfMoves, toDropEvery) == 0) then
            dropNonImportant(1)
        end
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
            turnRandomly()
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

function turnRandomly()
  theNumTurns = math.random(0, 3)

  for i=1, theNumTurns do
      turtle.turnRight()
  end

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

function dropInChestUp()
  for i=1,16 do
    turtle.select(i)
    turtle.dropUp()
  end
end

numTilesDown = turtleDigDown(height)

theMoves = digRandomly(tilesToDig, dropEvery)
theReverseMoves = createReverseList(theMoves)

traverseBackWards(theReverseMoves)

local finishedX, finishedZ, finishedY = gps.locate()
if(finishedX ~= startingX or finishedZ ~= startingZ) then
  shell.run("Get_To", finishedX, finishedZ)
end


local howManyGoingUp = numTilesDown-NumTimesWentUp
if(howManyGoingUp > 0) then
  local currentX, currentZ, currentY = gps.locate()
  while(currentX == nil) do
    turtleComeUp(1)
    currentX, currentZ, currentY = gps.locate()
  end

  while(currentY < startingY) do
      turtleComeUp(1)
      currentX, currentZ, currentY = gps.locate()
  end
elseif(howManyGoingUp < 0 ) then
  turtleDigDown(NumTimesWentUp-numTilesDown)
end

dropNonImportant(1)
dropInChestUp()

if(turtle.detect() == false) then
  turtle.turnRight()
  turtle.turnRight()
end