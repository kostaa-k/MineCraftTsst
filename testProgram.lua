
function turtleDigDown(numTiles)
  for i=0,numTiles do 
    if(turtle.detectDown() == true) then
      turtle.digDown()
    else
      turtle.down()
    end

function turtleComeUp(numTiles)
  for i=0,numTiles do 
    if(turtle.detectUp() == true) then
      turtle.digUp()
    else
      turtle.up()
    end


turtleDigDown()
turtleDigUp()