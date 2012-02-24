-- *****************************************************************************
-- Luno
-- Copyright (c) 2011-2012 Eric Chiesse de Souza (www.echiesse.com.br)
-- Read "License.txt" for the license terms
-- *****************************************************************************

tableEx = {}

function tableEx.append(t1, t2)
    local ret = {}

    for _i, t in ipairs{t1,t2} do
        for i, v in ipairs(t) do
            table.insert(ret, v)
        end
    end
    return ret
end


function tableEx.print(tb)
    for i, v in pairs(tb) do
        print(i, v)
    end
end


function tableEx.isEmpty(tb)
    return (next(tb) == nil)
end


function tableEx.last(tb)
    return tb[#tb]
end


function tableEx.find(tb, value, test)
    local ret = {}

    test = test or (function(a,b) return a==b end)

    for i, v in pairs(tb) do
        if test(v, value) then
            table.insert(ret, {[i] = v})
        end
    end
    return ret
end

return tableEx
