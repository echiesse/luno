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

--------------------------------------------------------------------------------
--  Recupera o conteúdo de um arquivo de texto
--  @param fileName O nome do arquivo a ser recuperado.
--------------------------------------------------------------------------------
function luno.io.getTextFromFile(fileName)
    local file, msg = io.open(fileName, "r")
    local ret
    if file == nil then
        ret = {nil, msg}
    else
        ret = {file:read("*a")}
        file:close()
    end
    return unpack(ret)
end


--------------------------------------------------------------------------------
--  Salva um texto em arquivo.
--  @param text     String com o texto a ser salvo.
--  @param fileName O nome do arquivo a ser usado para salvar o texto.
--------------------------------------------------------------------------------
function luno.io.saveTextToFile(text, fileName)
    local file = io.open(fileName, "w")
    file:write(text)
    file:close()
end


--------------------------------------------------------------------------------
--  Salva um texto em arquivo.
--  @param text     String com o texto a ser salvo.
--  @param fileName O nome do arquivo a ser usado para salvar o texto.
--------------------------------------------------------------------------------
function luno.io.appendTextToFile(text, fileName)
    local file = io.open(fileName, "a")
    file:write(text)
    file:close()
end


return luno.io
