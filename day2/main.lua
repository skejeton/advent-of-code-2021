local io = require'io'

local function read_file(path)
    local file = io.open(path, "rb")
    if not file then return nil end
    local content = file:read "*a"
    file:close()
    return content
end

local file = read_file("test_input.txt")
local toks = {}

for tok in file:gmatch("[^%s]+") do 
    table.insert(toks, tok)
end

local i = 1
local cmds = {}

while i <= #toks do
    table.insert(cmds, {toks[i], tonumber(toks[i+1])} )
    i = i + 2
end


repeat 
    local depth = 0
    local hor = 0
    local aim = 0

    for _, cmd in ipairs(cmds) do
        if cmd[1] == "forward" then
            hor = hor + cmd[2]
            depth = depth + aim * cmd[2]
        end
        if cmd[1] == "down" then
            depth = depth + cmd[2]
        end
        if cmd[1] == "up" then
            depth = depth - cmd[2]
        end
    end
    print("Part 1 ans: ", hor * depth)
until 0

repeat 
    local depth = 0
    local hor = 0
    local aim = 0

    for _, cmd in ipairs(cmds) do
        if cmd[1] == "forward" then
            hor = hor + cmd[2]
            depth = depth + aim * cmd[2]
        end
        if cmd[1] == "down" then
            aim = aim + cmd[2]
        end
        if cmd[1] == "up" then
            aim = aim - cmd[2]
        end
    end
    print("Part 2 ans: ", hor * depth)
until 0
