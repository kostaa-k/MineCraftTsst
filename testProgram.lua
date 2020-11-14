
local height = 5
if #arg > 0 then height = tonumber(arg[1]) end

print("Digging down:")
print(height)

function turtleDigDown(numTiles)
  count = 0
  for i=0,numTiles do 
    if(turtle.detectDown() == true) then
      turtle.digDown()
    end
    is_true = turtle.down()
    if(is_true == true) then
      count = count+1
    end
  end

return count
end

function turtleComeUp(numTiles)
  for i=0,numTiles do 
    if(turtle.detectUp() == true) then
      turtle.digUp()
      turtle.up()
    else
      turtle.up()
    end
  end
end


function dropNonImportant()
  for i=1,16 do
      tempItem = turtle.getItemDetail(i)
      
      if tempItem ~= nil then
          tempName = tempItem["name"]
          if string.find(tempName, "ore") or string.find(tempName, "diamond") then
            print (tempName)
            print ("Was found")
          else
            turtle.select(i)
            turtle.drop()
          end
      end

  end
end

numTilesDown = turtleDigDown(height)
turtleComeUp(numTilesDown-1)
dropNonImportant()