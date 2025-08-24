-- fennel_loader.lua
-- Eluna-compatible Fennel loader (no external modules)

-- Resolve this script's directory
local source = debug.getinfo(1, "S").source
local loader_dir = source:match("^@(.*/)")
if not loader_dir then loader_dir = "./" end

-- Normalize paths
local fennel_path = loader_dir .. "fennel.lua"
local fnl_dir = loader_dir .. "fnl"
local path_sep = package.config:sub(1,1)

-- Load Fennel compiler
local fennel_chunk, err = loadfile(fennel_path)
if not fennel_chunk then
    error("[FENNEL] Could not load fennel.lua: " .. tostring(err))
end
local fennel = fennel_chunk()
if fennel.install then fennel = fennel.install() end

-- Shared environment for all Fennel scripts
local shared_env = setmetatable({}, { __index = _G })

-- Expose Eluna API
local function expose_eluna(env)
    env["creature-say"] = function(creature, msg)
        creature:SendUnitSay(msg, 0)
    end
    env["player-say"] = function(player, msg)
        player:SendBroadcastMessage(msg)
    end
    env["player-give-item"] = function(player, itemId, count)
        player:AddItem(itemId, count or 1)
    end
    env["register-gossip-event"] = function(entry, event, fn)
        RegisterCreatureGossipEvent(entry, event, fn)
    end
    env["register-creature-event"] = function(entry, event, fn)
        RegisterCreatureEvent(entry, event, fn)
    end
    env["register-player-event"] = function(event, fn)
        RegisterPlayerEvent(event, fn)
    end
end

expose_eluna(shared_env)

-- Load a single .fnl file
local function load_fnl_file(path)
    local f = io.open(path, "r")
    if not f then
        print("[FENNEL] Could not open file: " .. path)
        return
    end
    local code = f:read("*a")
    f:close()

    local lua_code, err = fennel.compileString(code, { filename = path })
    if not lua_code then
        print("[FENNEL] Compile error in " .. path .. ": " .. tostring(err))
        return
    end

    local func, err = load(lua_code, path, "t", shared_env)
    if not func then
        print("[FENNEL] Load error in " .. path .. ": " .. tostring(err))
        return
    end

    local ok, result = pcall(func)
    if not ok then
        print("[FENNEL] Runtime error in " .. path .. ": " .. tostring(result))
    else
        print("[FENNEL] Loaded: " .. path)
    end
end

-- Load all .fnl files using io.popen
local function load_all_fnl(dir)
    local cmd = path_sep == "\\" and ('dir "%s" /b'):format(dir) or ('ls "%s"'):format(dir)
    local p = io.popen(cmd)
    if not p then
        print("[FENNEL] Failed to list files in: " .. dir)
        return
    end

    for file in p:lines() do
        if file:match("%.fnl$") then
            load_fnl_file(dir .. path_sep .. file)
        end
    end

    p:close()
end

-- Load on server start
load_all_fnl(fnl_dir)

-- Optional: reload via chat command
RegisterPlayerEvent(42, function(event, player, msg)
    if msg == ".reload fennel" then
        load_all_fnl(fnl_dir)
        player:SendBroadcastMessage("Fennel scripts reloaded.")
    end
end)
