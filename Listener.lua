rednet.open("left")
local id, message = rednet.receive()

while(message ~= "STOP NOW") do 

    print(message)
    id,message = rednet.receive()
end