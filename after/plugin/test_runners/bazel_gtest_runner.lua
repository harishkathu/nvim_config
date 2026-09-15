-- Goal:
-- * Run bazel gtest on the open buffer (given its a test file)
-- * Tests if built successfully should
--  * Show individial test results (as icon) in line (virt text)
--  * Faild test should provide some way to view test logs (either hover window or new buff)
-- * Filed builds should show unique icon to represent that build failed
--  * Additionally provide way to see error log
-- 
-- Good to haves
-- * Only run tests present in given file

-- Step 1
-- * Get current buffer (check if test file)
-- * Search for nearest bazel file
-- * run bazel query type cc_test
-- * run bazel test for all with filter for file name and json file here
-- * show icon for all passed and failed cases

-- PRIVATE FUNCTIONS

local function _set_cursor_to_last_line(win_num, buf_num)
    vim.api.nvim_win_set_cursor(win_num, { vim.api.nvim_buf_line_count(buf_num), 0 }) -- Move cursor to last line, column 0
end

local function _append_line_to_buf(buf_num, data)
    vim.api.nvim_buf_set_lines(buf_num, -1, -1, false, data)
end

local function _del_old_lines_in_promt_buffer()
    local line_count = vim.api.nvim_buf_line_count(PLUGIN_BUF_NUM)
    if line_count > MAX_PLUGIN_BUF_LINES then
        vim.api.nvim_buf_set_lines(PLUGIN_BUF_NUM, 1, line_count - MAX_PLUGIN_BUF_LINES, false, {" NVIM: older lines deleted ..."})
    end
end

local function _get_win_num_where_buf_is_active(buf_num)
    local win_list = vim.api.nvim_tabpage_list_wins(vim.api.nvim_get_current_tabpage())
    for _, win_num in ipairs(win_list) do
        if vim.api.nvim_win_get_buf(win_num) == buf_num then
            return win_num
        end
    end
    return -1
end

local function _read_as_json(path)
    local file, err = io.open(path, "r")
    if not file then
        vim.notify("Error opening file: " .. tostring(err), vim.log.levels.ERROR)
        return err
    end
    local content = vim.json.decode(file:read("*a"))
    file:close()
    return content
end

local function _get_all_testsuits(test_json)
    local testsuites = {}
    for _, tests in ipairs(test_json["testsuites"]) do
        for _, test in ipairs(tests["testsuite"]) do table.insert(testsuites, test) end
    end
    return testsuites
end

-- PRIVATE FUNCTIONS END

local function return_if_not_gtest_file(path)
    return path:match("[^/]*$"):match("^.*[test.|.test].*.cpp$")
end

local function serach_nearest_bazel_file(cur_path)

    while cur_path ~= "" or cur_path ~= nil do
        for file in io.popen("ls "..cur_path):lines() do
            if file:match("BUILD.bazel") ~= nil then
                return cur_path
            end
        end
        cur_path = cur_path:match("^(.*)/[^/]*$")
    end
end

local function get_all_bazel_test_targets(bazel_file_path)
    local targets = {}
    local handle = io.popen("bazel query 'kind(\"cc_test\", //" .. bazel_file_path .. "/...)' 2>&1")

    if not handle then
        vim.notify("Failed to run bazel query", vim.log.levels.ERROR)
        return targets
    end

    for line in handle:lines() do
        if line:match("^//.*$") ~= nil then
            table.insert(targets, line)
        end
    end

    handle:close()
    return targets
end

local function _filter_for_buf_and_add_line_num(testsuites, cur_bufnum)
    local cur_testsuites = {}
    local buf_lines = vim.api.nvim_buf_get_lines(cur_bufnum, 0, -1, false)

    for _, v in ipairs(testsuites) do
        local name = v.name
        -- if cur_testsuites[name] ~= nil then goto next_testsuite end
        if name:match(".*%d+") then
            name = name:gsub("%/%d+", "")
        end

        -- If testsuite in current buffer, then make new entry in out tables as
        -- test_name: testsuite(with a linenumber kv pair)
        for i, line in ipairs(buf_lines) do
            if line:match("^//.*$") then goto next_line end -- Skip cpp comments

            -- Matches for gtest test case syntax ('or' lause consideres formating)
            if line:match("^.*TEST" .. name .. "%s*%)%s*$") or line:match("^.*" .. name .. "%s*[,|%)]%s*$") then
                local key = v.name
                v["line"] = i-1 -- i is 1-based indexng
                cur_testsuites[key] = v
                cur_testsuites[key].name = name -- We remove the parameterised test name from inseted value
                goto continue
            end
            :: next_line::
        end
        ::continue::
    end

    return cur_testsuites
end

local function show_icon_for_test(cur_bufnum)
    -- Check if json was generated
    if vim.fn.filereadable(GTEST_JSON_OUTPUT_PATH) == 0 then
        vim.notify("Bazel test failed to generate json, Maybe build failed...", vim.log.levels.ERROR)
        return
    end

    local test_out = _read_as_json(GTEST_JSON_OUTPUT_PATH)
    local testsuites = _get_all_testsuits(test_out)

    -- Get all relevant test suits and line number to table
    testsuites = _filter_for_buf_and_add_line_num(testsuites, cur_bufnum)

    -- Set an extmark with virtual text
    local ns = vim.api.nvim_create_namespace("BazelTestRunner_VirtText")
    vim.api.nvim_buf_clear_namespace(cur_bufnum, ns, 0, -1)

    -- We need the keys (whihc are testsuite names) sorted so that parameterised test cases appear in order.
    -- This lets the virt text to also be in order, thus easier to find the failing parameterised test 
    --
    -- We also sort in reverse because we print virtual text at col 0 (prepend)
    -- In parameterised tests we print status of every parameter test case in single line.
    -- Reverse sort ensures the order of virtual text is preserved (1st mark = 1st param, 2nd mark = 2nd param, ...)
    local sorted_test_names = {}
    for k, _ in pairs(testsuites) do table.insert(sorted_test_names, k) end
    table.sort(sorted_test_names, function(x, y) return x > y end) -- reverse sort

    for _, name in ipairs(sorted_test_names) do
        local text = {{ "|🚗💨"}} -- { {text, highlight_group} }

        if testsuites[name]["failures"] ~= nil then text = { { "|💥🚗"}} end
        -- print(name .. " " .. text[1])

        vim.api.nvim_buf_set_extmark(cur_bufnum, ns, testsuites[name]["line"], 0, {
          virt_text = text,
        })
        local name = io.read()
    end

end

-- Function to run a command and stream output into a new scratch buffer
local function run_job(cmd, win_num, cur_bufnum)
    -- Start the job
    local job_id = vim.api.nvim_buf_set_lines(PLUGIN_BUF_NUM, 0, -1, false, {"BUILD CMD: " .. table.concat(cmd, " ")})
    local job_id = vim.fn.jobstart(cmd, {
        stderr_buffered = false, -- stream output line-by-line
        stdout_buffered = false, -- stream output line-by-line
        on_stdout = function(_, data, _)
            if data then
                _append_line_to_buf(PLUGIN_BUF_NUM, data)
            end
            _set_cursor_to_last_line(win_num, PLUGIN_BUF_NUM)
            _del_old_lines_in_promt_buffer() -- clear old output
        end,
        on_stderr = function(_, data, _)
            if data then
                _append_line_to_buf(PLUGIN_BUF_NUM, data)
            end
            _set_cursor_to_last_line(win_num, PLUGIN_BUF_NUM)
            _del_old_lines_in_promt_buffer() -- clear old output
        end,
        on_exit = function(_, code, _)
            if code == -1 then
                print("STATUS -1")
                vim.notify("Build job timed out (>" .. (JOB_TIMEOUT / 60 / 1000) .. " min/s", vim.log.levels.ERROR)
            elseif code > 0 then
                print("STATUS 0")
                vim.notify("Build job failed with exit code " .. code, vim.log.levels.ERROR)
            end

            _append_line_to_buf(PLUGIN_BUF_NUM, { "NVIM: [Process exited with code " .. code .. "]" })
            vim.api.nvim_buf_set_option(PLUGIN_BUF_NUM, "modifiable", false)
            vim.api.nvim_buf_set_option(PLUGIN_BUF_NUM, "modified", false)
            _set_cursor_to_last_line(win_num, PLUGIN_BUF_NUM)

            show_icon_for_test(cur_bufnum)
        end,
    })

    if job_id <= 0 then
        vim.notify("Failed to start job", vim.log.levels.ERROR)
        return -1
    end
end

local function run_job_and_update_icons(bazel_targets, cur_bufnum)
    local cmd = {"bazel", "run"}
    for _, e in ipairs(bazel_targets) do
        table.insert(cmd, e)
    end
    table.insert(cmd, "--test_output=all")
    table.insert(cmd,
        "--test_arg=--gtest_output=json:" .. GTEST_JSON_OUTPUT_PATH)

    -- Check if buffer is already acitve
    --  * Active means its displayed in any of the windows in current tab
    -- If buffer is already open in a window we use it, else we use the current window.
    --  * Current window will be the vsplit window if buffer was not active
    local win_num = _get_win_num_where_buf_is_active(PLUGIN_BUF_NUM)
    if win_num == -1 then
        vim.cmd(string.format("%dvsplit", math.floor(vim.o.columns * VPLIT_PERCENTAGE)))
        win_num = vim.api.nvim_get_current_win()
    end

    vim.api.nvim_win_set_buf(win_num, PLUGIN_BUF_NUM)
    vim.api.nvim_buf_set_option(PLUGIN_BUF_NUM, "modifiable", true)
    vim.api.nvim_buf_set_lines(PLUGIN_BUF_NUM, 0, -1, false, {}) -- clear buffer


    return run_job(cmd, win_num, cur_bufnum)
end

local function main()
    local cur_bufnum = vim.api.nvim_get_current_buf()
    local cwd = vim.loop.cwd()
    local abs_cur_buf_path = vim.api.nvim_buf_get_name(cur_bufnum)
    local rel_cur_buf_path = abs_cur_buf_path:gsub(cwd:gsub("%-", "%%-"), ""):match("[^/].*$")
    local rel_cur_buf_parent_path = rel_cur_buf_path:match("^(.*)/[^/]*$")

    -- Remove old previous test json file if exits
    if vim.fn.filereadable(GTEST_JSON_OUTPUT_PATH) == 1 then
        local ok = vim.fn.delete(GTEST_JSON_OUTPUT_PATH)
        if ok ~= 0 then vim.notify("Error deleting file: " .. GTEST_JSON_OUTPUT_PATH, vim.log.levels.ERROR) end
    end

    -- Get path to the nearest bazel file
    local bazel_path = serach_nearest_bazel_file(rel_cur_buf_parent_path)
    bazel_path = bazel_path:gsub(cwd, "")

    -- Get cc_test targets
    local bazel_targets = get_all_bazel_test_targets(bazel_path)
    if #bazel_targets == 0 then
        vim.notify(
        "No bazel target to run. Please check if any parent folder contain a bazel file with cc_test target",
            vim.log.levels.INFO)
        return
    end

    -- Run bazel test, with appropriate arguments and update the current buffer with icons with test results
    run_job_and_update_icons(bazel_targets, cur_bufnum)

end


-- Plugins own buffer name
PLUGIN_BUF_NAME = "test_runner/temp_bazel_build"
MAX_PLUGIN_BUF_LINES = 10000                        -- 10K lines in buffer at max (older ones deleted)
VPLIT_PERCENTAGE = 0.3                              -- All vsplits for plugins buf is 30 percent of column width (to right)

JOB_TIMEOUT = 2 * 60 * 1000 -- in ms
GTEST_JSON_OUTPUT_PATH = vim.fn.stdpath("config") .. "/after/plugin/test_runners/temp_gtest_detail.json"


-- Check if buffer already exists, if yes delete it
for _, buf_num in ipairs(vim.api.nvim_list_bufs()) do
    if vim.api.nvim_buf_get_name(buf_num):match(PLUGIN_BUF_NAME) then
        vim.api.nvim_buf_delete(buf_num, {force = true})
    end
end

-- Create a new scratch buffer
PLUGIN_BUF_NUM = vim.api.nvim_create_buf(false, true)
if PLUGIN_BUF_NUM == 0 then
    vim.notify("Failed to create buffer for live output.", vim.log.levels.ERROR)
    return 1
end

vim.api.nvim_buf_set_name(PLUGIN_BUF_NUM, PLUGIN_BUF_NAME) -- Set custom name
vim.api.nvim_buf_set_option(PLUGIN_BUF_NUM, "buftype", "prompt") -- Prompt buffer


-------------
--- Attach BufWritePost autocmd to given buffer handle.
--- @param buf_num? int Attach autocmd to this buffer
---
local function _attach_auto_command(buf_num)
    -- Check if buf is a gtest file
    local abs_cur_buf_path = vim.api.nvim_buf_get_name(buf_num)
    local file_name = return_if_not_gtest_file(abs_cur_buf_path)
    if  file_name == nil then
        vim.notify("Skipping execution, not a cpp test file", vim.log.levels.INFO)
        return 1
    end

    vim.api.nvim_create_autocmd("BufWritePost", {
        buffer = buf_num, -- local-buffer autocmd
        group = vim.api.nvim_create_augroup("BazelGtestRunner", { clear = true }),
        -- Buffer or patter are exclusive. I want to manually attach and detach this autocmd for testing purposese,
        -- Should user pattern once plugin is stable
        -- pattern = {"*_test.cpp", "test_*.cpp", "*.test.cpp", "test.*.cpp"},
        callback = main,
        desc = "Finds the nearest bazel cc_test from current buffer and updates diagnostics." ..
            "Assumes nearest bazel file has test cases for current buffer"
    })
end

vim.api.nvim_create_user_command("BazelGtestRunnerAttach", function()
    _attach_auto_command(vim.api.nvim_get_current_buf())
end, {})

vim.api.nvim_create_user_command("BazelGtestRunnerDetach", function()
    vim.api.nvim_clear_autocmds({
        buffer = vim.api.nvim_get_current_buf(),
        group = vim.api.nvim_create_augroup("BazelGtestRunner", { clear = false }),
    })
end, {})

