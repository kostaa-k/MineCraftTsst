local height = 5
if #arg > 0 then 
  height = tonumber(arg[1])
end

local tilesToDig = 3
if #arg > 1 then 
    tilesToDig = tonumber(arg[2])
end

local dropEvery = 20
if #arg > 2 then 
    dropEvery = tonumber(arg[3])
end

for i=1, 10 do
    local numToGo = math.random(35, height)
    shell.run("MineRandomly", numToGo, tilesToDig, dropEvery)
end