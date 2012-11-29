-- *****************************************************************************
-- Luno
-- Copyright (c) 2011-2012 Eric Chiesse de Souza (www.echiesse.com.br)
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

function luno.table.append(t1, t2)
    local ret = {}

    for _i, t in ipairs{t1,t2} do
        for i, v in ipairs(t) do
            table.insert(ret, v)
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
            table.insert(ret, {[i] = v})
        end
    end
    return ret
end

return luno.table
