
local lineLength = 5
if #arg > 0 then 
    lineLength = tonumber(arg[1])
end


function digInLine(numberOfTiles)
    for i=1,(numberOfTiles) do
      if(turtle.detect() == true) then
        
        slotToFill = selectCorrectSlot()
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

function selectCorrectSlot()
    for i=1, 16 do
        turtle.select(i)
        isSame = turtle.compare(i)
        if(isSame == true) then
            return i
        end
    end

    return 0
end

digInLine(lineLength)