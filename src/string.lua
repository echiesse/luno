-- *****************************************************************************
-- Luno
-- Copyright (c) 2011-2013 Eric Chiesse de Souza (www.echiesse.com.br)
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
        "charAt",
        "trim",
        "gtrim",
        "split",
        "splitLines",
        "splitWords",
        "join",
        "joinWords",
        "joinLines",
    }

    for i, v in ipairs(mainFunctions) do
        _G[v] = luno.string[v]
    end
end


--##############################################################################

--------------------------------------------------------------------------------
-- Removes whitespace chars from the beginning (left) of a string.
-- @param str The string to be trimmed
-- @return The trimmed string
--------------------------------------------------------------------------------
function luno.string.ltrim(str)
    -- [ECS]: Note to all trim functions: The parentheses around gsub below are
    -- required to avoid returning the second return value of gsub which may
    -- cause undesired side effects on the caller
    return (string.gsub(str, "^%s*", ""))
end


--------------------------------------------------------------------------------
-- Removes whitespace chars from the end (right) of a string.
-- @param str The string to be trimmed
-- @return The trimmed string
--------------------------------------------------------------------------------
function luno.string.rtrim(str)
    return (string.gsub(str, "%s*$", ""))
end


--------------------------------------------------------------------------------
-- Removes whitespace chars from the beginning (left) and the end (right) of a string.
-- @param str The string to be trimmed
-- @return The trimmed string
--------------------------------------------------------------------------------
function luno.string.trim(str)
    return luno.string.rtrim(luno.string.ltrim(str))
end


function luno.string.gltrim(str, pattern)
    return (string.gsub(str, "^" .. pattern, ""))
end


function luno.string.grtrim(str, pattern)
    return (string.gsub(str, pattern .. "$", ""))
end


function luno.string.gtrim(str, patternLeft, patternRight)
    patternRight = patternRight or patternLeft
    local ret = luno.string.gltrim(str, patternLeft)
    ret = luno.string.grtrim(ret, patternRight)
    return ret
end


--------------------------------------------------------------------------------
--  Verifica se uma string começa pelo conteúdo de uma outra string.
--  @param str     A string a ser verificada
--  @param strTest A string com a qual o ínicio de str será comparado
--------------------------------------------------------------------------------
function luno.string.beginsWith(str, strTest)
    return (string.find(str, "^" .. strTest) ~= nil)
end


--------------------------------------------------------------------------------
--  Verifica se uma string termina pelo conteúdo de uma outra string.
--  @param str     A string a ser verificada
--  @param strTest A string com a qual o fim de str será comparado
--------------------------------------------------------------------------------
function luno.string.endsWith(str, strTest)
    return (string.find(str, strTest .. "$") ~= nil)
end


--------------------------------------------------------------------------------
--  Quebra uma string de acordo com um determinado separados.
--  @param str A string a ser quebrada.
--  @param sep Separador usado para definir os pontos de quebra. <i>sep</i> também pode ser um padrão.
--  @return Uma lista contendo as partes da string original. As partes não incluem o separador utilizado.
--  @usage luno.string.split("a,b,c", ",") --> {"a","b","c"}
--  @usage luno.string.split(",,", ",") --> {"","",""}
--  @usage luno.string.split("a b  c    d", "%s+") --> {"a","b","c","d"}
--------------------------------------------------------------------------------
function luno.string.split(str, sep)
    local ret = {}
    local ini = 1
    local fim, aux = string.find(str, sep)
    while fim ~= nil do
        local trecho = string.sub(str, ini, fim-1)
        table.insert(ret, trecho)
        ini = aux + 1
        fim, aux = string.find(str, sep, ini)
    end
    table.insert(ret, string.sub(str, ini))
    return ret
end


function luno.string.splitWords(text)
    return luno.string.split(text, "%s+")
end


function luno.string.splitLines(text)
    return luno.string.split(text, "\r?\n")
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


function luno.string.join(list, sep)
    local sep = sep or ""
    local ret = list[1] or ""
    for i = 2, #list do
        ret = ret .. sep .. list[i]
    end
    return ret
end


function luno.string.joinWords(words)
    return luno.string.join(words, " ")
end


function luno.string.joinLines(lines)
    return luno.string.join(lines, "\n")
end


function luno.string.strLinesIterator(text)
    return luno.string.splitIterator(text, "\r?\n")
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


function luno.string.padLeft(str, padChar, maxChars)
    while #str < maxChars do
        str = padChar .. str
    end
    return str
end


function luno.string.padRight(str, padChar, maxChars)
    while #str < maxChars do
        str = str .. padChar
    end
    return str
end


return luno.string
