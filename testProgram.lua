
local height = 5
if #arg > 0 then height = tonumber(arg[1]) end
function turtleDigDown(numTiles)
  for i=0,numTiles do 
    if(turtle.detectDown() == true) then
      turtle.digDown()
      turtle.down()
    else
      turtle.down()
    end
  end
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
  for i=0,16 do
      tempName = turtle.getItemDetail(i)["name"]

      if string.find(tempName, "ore") then
        print (tempName)
        print ("Was found")
      else
        turtle.select(i)
        turtle.drop(i)
      end
  end
end

turtleDigDown(height)
turtleComeUp(height)
dropNonImportant()