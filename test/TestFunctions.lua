require"luno.table"

function tableEquals(tb1, tb2)
    local ret = true
    for i, v in pairs(tb1) do
        if tb2[i] ~= v then
            ret = false
            break
        end
    end

    return ret
end

--[[
function tableCorresponds(tb1, tb2)
    local ret = true
    for i, v in pairs(tb1) do
        if tb2[i] ~= v then
            if type(v) ~= "table" then
                ret = false
                break
            else
                ret = tableCorresponds(v, tb2[i])
                if ret == false then break end
            end
        end
    end
    return ret
end


function anyElementLike(elem, list)
    local ret = false
    for i, v in ipairs(list) do
        for j, u in pairs(elem)
            if v[j] == u then
                ret = true
                break
            end
        end
    end
    return ret
end
]]


function listEquals(l1, l2)
    local ret = true

    if #l2 ~= #l1 then
        ret = false
    else
        for i, v in ipairs(l1) do
            if l2[i] ~= v then
                ret = false
                break
            end
        end
    end

    return ret
end


function printList(list)
    for i, v in ipairs(list) do
        io.write(v .. " ")
    end
    print()
end


function getStackDepth()
    local iniDepth = 2 -- Desconta getinfo e getStackDepth
    local depth = iniDepth
    local i = iniDepth
    local info = debug.getinfo(i)
    while info ~= nil do
        i = i + 1
        info = debug.getinfo(i)
        depth = i
    end
    return depth - iniDepth
end


_S =
{
    level = 0
}

local function countHook(evtType)
    local info = debug.getinfo(2)
    --io.write(tostring(info.name or "??"))

    if evtType == "call" then
        --io.write("(\n")
        _S.level = _S.level + 1
    elseif evtType == "return" then
        --io.write(")\n")
        _S.level = _S.level - 1
    end
end

local function startDepthCount()
    _S.level = 0
    --_S.log = ""
    debug.sethook(countHook, "cr")
end

local function endDepthCount()
    debug.sethook(nil)
end

function checkStackErrorDepth(level, f, ...)
    startDepthCount()
    local ret, msg = pcall(f, ...)
    endDepthCount()
    return level == _S.level
end


--------------------------------------------------------------------------------
function allEquals(list, val)
    local ret = true
    for i, v in ipairs(list) do
        if v ~= val then
            ret = false
            break
        end
    end
    return ret
end

function anyEquals(list, val)
    local ret = false
    for i, v in ipairs(list) do
        if v == val then
            ret = true
            break
        end
    end
    return ret
end

function allTrue(list)
    return allEquals(list, true)
end

function anyTrue(list)
    return anyEquals(list, true)
end


--------------------------------------------------------------------------------
function condMessage(res)
    if not res then
        local info = debug.getinfo(3)
        print("Assertion failed at line " .. info.currentline .. " of " .. info.short_src)
    end
end


local function templateAssert(evalf)
    return function(...)
        local ret = evalf(...)
        condMessage(ret)
        return ret
    end
end


assertBoolean    = templateAssert(function(val) return (type(val) == "boolean") end)
assertNil        = templateAssert(function(val) return (type(val) == "nil") end)
assertNonNil     = templateAssert(function(val) return (type(val) ~= "nil") end)
assertNumber     = templateAssert(function(val) return (type(val) == "number") end)
assertString     = templateAssert(function(val) return (type(val) == "string") end)
assertFunction   = templateAssert(function(val) return (type(val) == "function") end)
assertTable      = templateAssert(function(val) return (type(val) == "table") end)
assertTrue       = templateAssert(function(val) return val == true end)
assertFalse      = templateAssert(function(val) return val == false end)
assertEquals     = templateAssert(function(a,b) return a==b end)
assertDifferent  = templateAssert(function(a,b) return a~=b end)
--[[
assertEquals     = templateAssert(function(a,b)
    print("!" .. tostring(a) .. "!", "!" .. tostring(b) .. "!")
    return a==b
end)
]]
assertError      = templateAssert(function (f, ...) return not pcall(f, ...) end)
assertListEquals = templateAssert(listEquals)
--assertTableCorresponds = templateAssert(tableCorresponds)
assertListEmpty  = templateAssert(luno.table.isEmpty)

assertStackErrorDepth = templateAssert(checkStackErrorDepth)
