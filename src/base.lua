-- *****************************************************************************
-- Luno
-- Copyright (c) 2011-2012 Eric Chiesse de Souza (www.echiesse.com.br)
-- Read "License.txt" for the license terms
-- *****************************************************************************


function lunoStartup()
    if type(luno) ~= "table" then
        luno = {}
    end
    return luno
end


function lunoReset()
    luno = nil
    startupLuno()
end


function lunoGetLoadedLibs()
    local ret = {}
    for i, v in pairs(luno) do
        table.insert(ret, i)
    end
    return ret
end


lunoStartup()
