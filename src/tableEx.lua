
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


return tableEx
