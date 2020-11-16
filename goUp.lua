local height = 5
if #arg > 0 then 
  height = tonumber(arg[1]) 
end

for i=1,height do
    turtle.digUp()
    turtle.up()
end