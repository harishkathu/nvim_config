require "harish"

-- Custom functions we will use
function GET_OS()
    -- ask LuaJIT first
    if jit then
        return jit.os
    end

    -- Unix, Linux variants
    local fh = package.config:sub(1,1) == "\\" and "Windows" or "unix"
    return fh
end
