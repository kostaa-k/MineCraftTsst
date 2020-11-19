local numberOfTiles = 10
if #arg > 0 then 
    numberOfTiles = tonumber(arg[1])
end


function canGoRight()
    turtle.turnRight()
    if(turtle.detect() == true) then
        return false
    end
    return true
end


for i=1, numberOfTiles do
    local couldMove =  turtle.forward()
    if(couldMove == false) then
        if(canGoRight() == true) then
            turtle.forward()
        else
            turtle.turnLeft()
            turtle.turnLeft()
            turtle.forward()
        end
    end
end