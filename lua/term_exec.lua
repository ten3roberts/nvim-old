local config = require "project_conf"

local M = {}

local

function M.execute(command)
  local expanded = {}
  for v in command:gmatch("%S+") do
    expanded[#expanded+1]  = vim.fn.expand(v)
  end

  local command = table.concat(command)

  print("Executing command: ", command)
end

local commands = {
    build=nil,
    run=nil,
}

function M.commands()
    return commands
end

-- Runs a given command
-- Expands all arguments, I.e; '%' will be replaced by current file
function M.exec_command(name)
    local command = config.get("commands")[name] or commands[name]


    vim.cmd(":wa")

    if not command then
        print(string.format("Undefined term command '%s'", name))
        return
    end

    local full_command = {}
    for v in command:gmatch("%S+") do
        full_command[#full_command+1] = vim.fn.expand(v)
    end

    local command = table.concat(full_coommand, ' ')
end

function M.set(name, command)
    commands[name] = command
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

function M.set_ft()
    local ft = vim.api.nvim_buf_get_option(0, "filetype")

    local ft_command = ft_commands[ft:lower()]
    if not ft_command then
        return false
    end

    commands = {}
    for k,v in pairs(ft_command) do
        commands[k] = v
    end

    return true
end

return M
