-- *****************************************************************************
-- Luno
-- Copyright (c) 2011-2013 Eric Chiesse de Souza (www.echiesse.com.br)
-- Read "License.txt" for the license terms
-- *****************************************************************************

require"luno.base"
require"luno.util"


luno.argReader = {}


function luno.argReader.exposeAll()
    expose(luno.argReader)
end


--##############################################################################

--[[
-- Exemplo de mapa de argumentos:
argMap =
{
    ["-o"] = ARG_TYPE.KEY_VALUE,
    ["-c"] = ARG_TYPE.FLAG,
}
--]]

luno.argReader.ARG_TYPE =
{
    POSITIONAL = 0,
    FLAG       = 1,
    KEY_VALUE  = 2,
}

local ARG_TYPE = luno.argReader.ARG_TYPE

function luno.argReader.getArgTable(args, argMap)
    local ret = {}
    local i, arg = next(args)
    local n = 1
    while i ~= nil do
        if argMap[arg] == nil then
            -- Argumento posicional:
            ret[n] = arg
            n = n + 1
        elseif argMap[arg] == ARG_TYPE.FLAG then
            -- Flag:
            ret[arg] = true
        elseif argMap[arg] == ARG_TYPE.KEY_VALUE then
            -- Chave e valor:
            local valor
            i, valor = next(args, i)
            ret[arg] = valor
        else
            error("O código não devia chegar aqui !!!")
        end

        i, arg = next(args, i)
    end

    for arg, argType in pairs(argMap) do
        if argType == ARG_TYPE.FLAG and ret[arg] == nil then
            ret[arg] = false
        end
    end

    return ret
end

return luno.argReader
