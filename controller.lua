
rednet.open("left")
senderID, theMessage, distanceAway, theProtocol = rednet.receive()

print(theMessage)