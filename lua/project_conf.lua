local M = {}

-- State
local config = {}
local commands = {}

function M.load()
    local env = {}

  if not io.open("project.lua") then
        -- print("No config found")
        config = {}
        return
    end

    print("Loading project.lua")
    local chunk,err = loadfile("project.lua", 't', env)

    if err then
        print("[Config error] project.lua: " .. err)
        config = {}
        return
    end

    pcall(chunk)

    config = env
end

function M.exec_command(name) 
    local command = M.get("commands")[name] or commands[name]

    if not command then
      print(string.format("Command '%s' is not defined", name))
      return
    end

    local full_command = {"clear\n"}
    for v in command:gmatch("%S+") do
        full_command[#full_command+1] = vim.fn.expand(v)
    end

    local command = table.concat(full_command, ' ')

    vim.cmd(":wa")
    require'toggleterm'.exec(command, 1)
end

function M.overview()
  print("config:")
  for k, v in pairs(vim.tbl_extend("keep", config, commands)) do
    print(string.format("  %-8s%s", k..': ', v))
  end
end

local ft_commands = {
    c = {
        build = "build.sh",
        run = "run.sh",
    },
    lua = {
        build="luac %",
        run="lua %",
        test="lua %",
    },
    rust = {
        build="cargo build",
        run="cargo run",
        test="cargo test",
    },
    haskell = {
        build="ghc %",
        run="runhaskell %"
    },
    nim = {
        build="nimble build",
        run="nimble run",
        test="nimble c -r %"
    },
    python = {
        build="python -m %",
        run="python %",
        test="python %"
    }
}

-- Loads basic config based on filetype
function M.load_for_ft()
    local ft = vim.api.nvim_buf_get_option(0, "filetype")

    local ft_command = ft_commands[ft:lower()]
    if not ft_command then
        return false
    end

    -- Load and commands
    for k,v in pairs(ft_command) do
        commands[k] = v
    end

    return true
end

function M.get(option)
    return config[option] or {}
end

return M
