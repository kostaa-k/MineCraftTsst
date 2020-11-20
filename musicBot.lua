
local count = 0
speaker = peripherals.wrap("left")
while(count < 200) do
    if(turtle.detect() == true) then
        speaker.playSound("harp", 3, 10)
    end
end