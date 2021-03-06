
local height = 5
if #arg > 0 then 
  height = tonumber(arg[1])
end

local squareSize = 3
if #arg > 1 then 
  squareSize = tonumber(arg[2])
end

local num_layers = 1
if #arg > 2 then 
  num_layers = tonumber(arg[3])
end

print("Digging down:")
print(height)

print("squareSize at Bottom")
print (squareSize)

function turtleDigDown(numTiles)
  count = 0
  for i=1,numTiles do 
    if(turtle.detectDown() == true) then
      couldDig = turtle.digDown()
      if(couldDig == false) then
        print("COULDNT DIG DOWN!")
      end
    end
    is_true = turtle.down()
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


function dropNonImportant(count)

  importantWords = {"diamond", "turtle"}
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
          turtle.drop()
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



function getToStartSquare(radius)

  digInLine(radius)

  turtle.turnRight()
  digInLine(radius)
  turtle.turnRight()
end

function digSquare(diameter)

  newRadius = diameter-1
  while(newRadius >= 2) do
    digInLine(newRadius)
    turtle.turnRight()
    digInLine(newRadius)
    turtle.turnRight()
    digInLine(newRadius)
    turtle.turnRight()
    digInLine(newRadius-1)
    turtle.turnRight()
    digInLine(1)

    newRadius = newRadius-2
  end
end

function digInLine(numberOfTiles)
  for i=1,(numberOfTiles) do
    dropNonImportant(1)
    if(turtle.detect() == true) then
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
          turtle.dig()
          couldMove = turtle.forward()
      end
    end
  end
end


function automaticRefuel()
  for i=1,16 do
    tempItem = turtle.getItemDetail(i)

    if tempItem ~= nil then
      if count == 0 then
        turtle.select(i)
        turtle.placeDown()
      end
      tempName = tempItem["name"]
      if string.find(tempName, "coal") then
        didRefuel = turtle.refuel(100)
        if(didRefuel == true) then
          print("Refueled")
        end
      end
    end

  end

end


numTilesDown = turtleDigDown(height)
theDiameter = squareSize


if(squareSize%2 == 0) then
  theDiameter = (squareSize/2)
else
  theDiameter = (squareSize-1)/2
end

for i=1,num_layers do
  --print("Making square")
  automaticRefuel()
  dropNonImportant(1)
  getToStartSquare(theDiameter)
  digSquare(squareSize)
  turtleComeUp(1)
end

print("Coming up:")
print(numTilesDown-num_layers)
turtleComeUp(numTilesDown-num_layers)
dropNonImportant(1)

