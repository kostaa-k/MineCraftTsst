shell.run("delete", "MineUntilDead.lua")
shell.run("delete", "MineRandomly.lua")
shell.run("delete", "controller.lua")

shell.run("wget", "https://raw.githubusercontent.com/kostaa-k/MineCraftTsst/master/MineRandomly.lua")
shell.run("wget", "https://raw.githubusercontent.com/kostaa-k/MineCraftTsst/master/MineUntilDead.lua")
shell.run("wget", "https://raw.githubusercontent.com/kostaa-k/MineCraftTsst/master/controller.lua")
shell.run("wget", "https://raw.githubusercontent.com/kostaa-k/MineCraftTsst/master/SoftwareUpdate.lua", "NewSoftwareUpdate.lua")
shell.run("delete", "SoftwareUpdate.lua")
shell.run("rename", "NewSoftwareUpdate.lua", "SoftwareUpdate.lua")