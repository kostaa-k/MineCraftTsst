
function turtleDigDown(numTiles)
  for i=0,numTiles do 
    if(turtle.detectDown() == true) then
      turtle.digDown()
    else
      turtle.down()