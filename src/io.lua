-- *****************************************************************************
-- Luno
-- Copyright (c) 2011-2013 Eric Chiesse de Souza (www.echiesse.com.br)
-- Read "License.txt" for the license terms
-- *****************************************************************************

require"luno.base"
require"luno.util"


luno.io = {}


function luno.io.exposeAll()
    expose(luno.io)
end


function luno.io.useAlias()
    lio = luno.io
end


luno.io.exposeSome = luno.io.exposeAll
--[[
function luno.io.exposeSome()
    local mainFunctions =
    {
    }

    for i, v in ipairs(mainFunctions) do
        _G[v] = luno.io[v]
    end
end
]]

--##############################################################################

function luno.io.getTextFromFile(fileName)
    local file, msg = io.open(fileName, "rt")
    local ret
    if file == nil then
        ret = {nil, msg}
    else
        ret = {file:read("*a")}
    end
    return unpack(ret)
end


function luno.io.saveTextToFile(text, fileName)
    local file = io.open(fileName, "wt")
    file:write(text)
end


return luno.io
