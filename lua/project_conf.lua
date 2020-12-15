local M = {}

-- State
local config = {}

function M.load()
    local env = {}

  if not io.open("conf.lua") then
        -- print("No config found")
        config = {}
        return
    end

    local chunk,err = loadfile("conf.lua", 't', env)

    if err then
        print("[Config error] conf.lua: " .. err)
        config = {}
        return
    end

    pcall(chunk)

    config = env
end

function M.get(option)
    return config[option] or {}
end

return M
