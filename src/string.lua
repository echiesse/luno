-- *****************************************************************************
-- Luno
-- Copyright (c) 2011-2012 Eric Chiesse de Souza (www.echiesse.com.br)
-- Read "License.txt" for the license terms
-- *****************************************************************************

require"luno.base"
require"luno.util"


luno.string = {}

function luno.string.exposeAll()
    expose(luno.string)
end


function luno.string.useAlias()
    lstring = luno.string
end


function luno.string.exposeSome()
    local mainFunctions =
    {
        "trim",
        "gtrim",
        "split",
        "splitLines",
        "join",
        "joinWords",
    }

    for i, v in ipairs(mainFunctions) do
        _G[v] = luno.string[v]
    end
end


--##############################################################################

function luno.string.split(str, sep)
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


function luno.string.join(list, sep)
    local sep = sep or ""
    local ret = list[1] or ""
    for i = 2, #list do
        ret = ret .. sep .. list[i]
    end
    return ret
end


function luno.string.ltrim(str)
    return string.gsub(str, "^%s*", "")
end


function luno.string.rtrim(str)
    return string.gsub(str, "%s*$", "")
end


function luno.string.trim(str)
    return luno.string.rtrim(luno.string.ltrim(str))
end


function luno.string.gltrim(str, pattern)
    return string.gsub(str, "^" .. pattern, "")
end


function luno.string.grtrim(str, pattern)
    return string.gsub(str, pattern .. "$", "")
end


function luno.string.gtrim(str, patternLeft, patternRight)
    patternRight = patternRight or patternLeft
    local ret = luno.string.gltrim(str, patternLeft)
    ret = luno.string.grtrim(ret, patternRight)
    return ret
end


function luno.string.beginsWith(strTest, str)
    return (string.find(str, "^" .. strTest) ~= nil)
end


function luno.string.endsWith(strTest, str)
    return (string.find(str, strTest .. "$") ~= nil)
end


function luno.string.splitWords(text)
    return luno.string.split(text, "%s")
end


function luno.string.joinWords(words)
    return luno.string.join(words, " ")
end


function luno.string.splitLines(text)
    return luno.string.split(text, "\r?\n")
end


function luno.string.joinLines(lines)
    return luno.string.join(lines, "\n")
end


function luno.string.strLinesIterator(text)
    return luno.string.splitIterator(text, "\r?\n")
end

function luno.string.splitIterator(text, sep)
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


function luno.string.removeFirstN(n, str)
    return string.sub(str, 1 + n)
end


function luno.string.removeFirst(str)
    return luno.string.removeFirstN(1, str)
end


function luno.string.removeLastN(n, str)
    return string.sub(str, 1, #str - n)
end


function luno.string.removeLast(str)
    return luno.string.removeLastN(1, str)
end


function luno.string.charAt(str, pos)
    return string.sub(str, pos, pos)
end


function luno.string.lastChar(str, pos)
    return string.sub(str, -1)
end


function luno.string.firstChar(str, pos)
    return luno.string.charAt(str, 1)
end



return luno.string
