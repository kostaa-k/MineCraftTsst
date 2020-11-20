
local count = 0
speaker = peripheral.wrap("left")
while(count < 200) do
    if(turtle.detect() == true) then
        for i=0,12 do 
            success = speaker.playSound("harp", 3, i*2)
            os.sleep(0.01)
        end
    end

    os.sleep(0.1)
end