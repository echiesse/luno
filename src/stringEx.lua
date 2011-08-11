
stringEx = {}

function stringEx.split(str, sep)
    local ini = 1
    local fim, aux = string.find(str, sep)
    local ret = {}
    while fim ~= nil do
        local trecho = string.sub(str, ini, fim-1)
        table.insert(ret, trecho)
        ini = aux + 1
        fim, aux = string.find(str, sep, ini)
    end
    table.insert(ret, string.sub(str, ini))
    return ret
end


function stringEx.join(list, sep)
    local ret = list[1] or ""
    for i = 2, #list do
        ret = ret .. sep .. list[i]
    end
    return ret
end


function stringEx.trim(str)
    local ret = string.gsub(str, "^%s*", "")
    ret = string.gsub(ret, "%s*$", "")
    return ret
end


function stringEx.beginsWith(strTest, str)
    return (string.find(str, "^" .. strTest) ~= nil)
end


function stringEx.endsWith(strTest, str)
    return (string.find(str, strTest .. "$") ~= nil)
end


function stringEx.splitLines(text)
    return stringEx.split(text, "\r?\n")
end


function stringEx.joinLines(lines)
    return stringEx.join(lines, "\n")
end


function stringEx.strLinesIterator(text)
    return stringEx.splitIterator(text, "\r?\n")
end

function stringEx.splitIterator(text, sep)
    local ini, fim = 1, 1
    local aux
    local _f = function(s, var)
        local ret = nil
        if ini ~= nil then
            fim, aux = string.find(s, sep, ini)

            if fim ~= nil then
                ret = string.sub(s, ini, fim-1)
                ini = aux + 1
            else
                ret = string.sub(s, ini)
                ini = nil
            end
        end
        return ret
    end

    return _f, text, ""
end

return stringEx
