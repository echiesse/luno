-- *****************************************************************************
-- Luno
-- Copyright (c) 2011-2013 Eric Chiesse de Souza (www.echiesse.com.br)
-- Read "License.txt" for the license terms
-- *****************************************************************************

require"luno.base"
require"luno.util"


luno.table = {}


function luno.table.exposeAll()
    expose(luno.table)
end


function luno.table.useAlias()
    ltable = luno.table
end


function luno.table.exposeSome()
    local mainFunctions =
    {
        "isEmpty",
    }

    for i, v in ipairs(mainFunctions) do
        _G[v] = luno.table[v]
    end
end


--##############################################################################

--------------------------------------------------------------------------------
--  Extends the first table with the elements of the second table returning a
-- new table with the resulting elements in the order that they appear in the
-- original tables
--------------------------------------------------------------------------------
function luno.table.extend(t1, t2)
    local ret = {}

    for _i, t in ipairs{t1,t2} do
        for i, v in ipairs(t) do
            table.insert(ret, v)
        end
    end
    return ret
end


--------------------------------------------------------------------------------
-- @deprecated Use luno.table.extend instead
--------------------------------------------------------------------------------
luno.table.append = luno.table.extend


--------------------------------------------------------------------------------
-- Returns a new table whose elements are the elements of the passed tables in
-- the order that they appear in the original tables
--------------------------------------------------------------------------------
function luno.table.extendAll(...)
    local tbs = {...}
    if #tbs == 1 and type(tbs[1][1]) == "table" then
        tbs = tbs[1]
    end

    local ret = {}
    for _, tb in ipairs(tbs) do
        for i, v in ipairs(tb) do
            table.insert(ret, v)
        end
    end
    return ret
end


--------------------------------------------------------------------------------
--  Append com acumulador (t1 serve como acumulador)
--------------------------------------------------------------------------------
function luno.table.extendA(t1, t2)
    for i, v in ipairs(t2) do
        table.insert(t1, v)
    end
end


--------------------------------------------------------------------------------
--  @deprecated Use luno.table.extendA instead
--------------------------------------------------------------------------------
luno.table.appendA = luno.table.extendA


function luno.table.equals(tb1, tb2)
    if tb1 == tb2 then
        return true
    end

    local ret = true
    for i, v in pairs(tb1) do
        if tb2[i] ~= v then
            ret = false
            break
        end
    end

    if ret == true then
        for i, v in pairs(tb2) do
            if tb1[i] ~= v then
                ret = false
                break
            end
        end
    end

    return ret
end


function luno.table.iequals(l1, l2)
    if l1 == l2 then
        return true
    end

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


function luno.table.print(tb)
    for i, v in pairs(tb) do
        print(i, v)
    end
end


function luno.table.isEmpty(tb)
    return (next(tb) == nil)
end


function luno.table.last(tb)
    return tb[#tb]
end


function luno.table.find(tb, value, test)
    local ret = {}

    test = test or (function(a,b) return a==b end)

    for i, v in pairs(tb) do
        if test(v, value) then
            table.insert(ret, {index = i, value = v})
        end
    end
    return ret
end


function luno.table.slice(tb, bSlice, eSlice)
    bSlice = bSlice or 1
    if bSlice == 0 then
        bSlice = 1
    elseif bSlice < 0 then
        bSlice = #tb + bSlice + 1
    end

    eSlice = eSlice or #tb
    if eSlice == 0 then
        eSlice = 1
    elseif eSlice < 0 then
        eSlice = #tb + eSlice + 1
    elseif eSlice > #tb then
        eSlice = #tb + 1 -- Apenas melhorando o desempenho
    end

    if eSlice < bSlice then
        -- Erro ?
        error("bSlice must be less than or equal eSlice", 2)
    end


    local ret = {}
    if bSlice <= #tb then
        for i = bSlice, eSlice do
            table.insert(ret, tb[i])
        end
    end

    return ret
end


return luno.table
