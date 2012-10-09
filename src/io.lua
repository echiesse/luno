-- *****************************************************************************
-- Luno
-- Copyright (c) 2011-2012 Eric Chiesse de Souza (www.echiesse.com.br)
-- Read "License.txt" for the license terms
-- *****************************************************************************

require"luno.base"


luno.io = {}

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
