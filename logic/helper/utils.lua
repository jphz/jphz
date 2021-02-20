local skynet = require "skynet"
local utils = {}

function utils.getCurrent()
    return skynet.time()
end

function utils.table_print(root, depth_max, exclude_key, exclude_type)
    if type(root) ~= "table" then
        return skynet.error("table_print value:", root)
    end

    depth_max = depth_max or 7
    local enter, more_space, vertical_line, depth = "\n", "    ", "|", 0
    local function _dump(tab, space, name)
        local temp = {}
        local key, new_key, table_str, value_type, key_str, space_param
        for k, v in pairs(tab) do
            key = tostring(k)
            if type(k) == "string" then
                key = '\"' .. tostring(k) .. '\"'
            end

            key_str = space .. "[" .. key .. "]" .. " = "
            if type(v) == "table" then
                new_key = name .. "." .. tostring(k)
                depth = depth + 1
                if depth >= depth_max or exclude_key == k then
                    table.insert(temp, key_str .. "{ ... }")
                else
                    space_param = space .. (next(v) and vertical_line) .. more_space
                    table_str = _dump(v, space_param, new_key)
                    if table_str then
                        table.insert(temp, key_str .. "{")
                        table.insert(temp, table_str)
                        table.insert(temp, space .. "},")
                    else
                        table.insert(temp, key_str .. "{ },")
                    end
                end
                depth = depth - 1
            else
                value_type = type(v)
                if exclude_type ~= value_type then
                    if value_type == "string" then
                        v = '\"' .. v .. '\"'
                    else
                        v = tostring(v)
                    end
                    table.insert(temp, key_str .. v .. ",")
                end
            end
        end

        return #temp > 0 and table.concat(temp, enter)
    end

    local result = _dump(root, more_space, "") or ""
    skynet.error("\n{\n" .. result .. "\n}")
end

return utils