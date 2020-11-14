


local height = 10
if #arg > 0 then height=arg[1] end

function turtleDigDown(numTiles)
  for i=0,numTiles do 
    if(turtle.detectDown() == true) then
      turtle.digDown()
    else
      turtle.down()