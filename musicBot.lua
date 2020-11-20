
local count = 0
speaker = peripheral.wrap("left")
while(count < 200) do
    if(turtle.detect() == true) then
        success = speaker.playSound("harp", 3, 10)
        print(success)
    end
end