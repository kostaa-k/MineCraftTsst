

local whatX, whatZ, whatY = gps.locate()
if #arg > 0 then 
    whatX = tonumber(arg[1])
end

if #arg > 1 then 
    whatZ = tonumber(arg[2])
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


function turtleFacingWay()

  local thisX, thisZ, thisY = gps.locate()
  digInLine(1)
  local newX, newZ, newY = gps.locate()

  turtle.turnRight()
  turtle.turnRight()
  digInLine(1)
  turtle.turnRight()
  turtle.turnRight()
  if(newX > thisX) then
    return "E"
  elseif(newX < thisX) then
    return "W"
  elseif(newZ > thisZ) then
    return "S"
  elseif(newZ < thisZ) then 
    return "N"
  end

  return nil
end

function turtleFaceNorth(currentDirection)
  if(currentDirection == "S") then
    turtle.turnRight()
    turtle.turnRight()
  elseif(currentDirection == "W") then
    turtle.turnRight()
  elseif (currentDirection == "E") then
    turtle.turnLeft()
  end

end

function turtleFaceDirection(currentDirectionFacing, endDirection)

  turtleFaceNorth(currentDirectionFacing)

  if(endDirection == "S") then
    turtle.turnRight()
    turtle.turnRight()
  elseif(endDirection == "W") then
    turtle.turnLeft()
  elseif (endDirection == "E") then
    turtle.turnRight()
  end

end

function getToCoords(getToX, getToZ)

  local currentDirection = turtleFacingWay()

  print(currentDirection)

  os.sleep(10)

  local thisX, thisZ, thisY = gps.locate()
  local currentXChange = getToX-thisX
  local currentZChange = getToZ-thisZ

  if(thisX > getToX) then
    turtleFaceDirection(currentDirection, "W")
  elseif(thisX < getToX) then
    turtleFaceDirection(currentDirection, "E")
  end

  while(thisX ~= getToX) do
      digInLine(1)
      local thisX, thisZ, thisY = gps.locate()
      print(thisX, getToX)
  end

  if(thisZ > getToZ) then
    turtleFaceDirection(currentDirection, "N")
  elseif(thisZ < getToZ) then
    turtleFaceDirection(currentDirection, "S")
  end

  while(thisZ ~= getToZ) do
    digInLine(1)
    local thisX, thisZ, thisY = gps.locate()
  end

end

getToCoords(whatX, whatZ)