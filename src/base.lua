-- *****************************************************************************
-- Luno
-- Copyright (c) 2011-2013 Eric Chiesse de Souza (www.echiesse.com.br)
-- Read "License.txt" for the license terms
-- *****************************************************************************

luno = {}

function luno.exposeAll()
    for k, v in pairs(luno) do
        if type(v) == "table" then
            local libExposeAll = v["exposeAll"]
            if type(libExposeAll) == "function" then
                libExposeAll()
            end
        end
    end
end

function luno.exposeSome()
    for k, v in pairs(luno) do
        if type(v) == "table" then
            local libExposeAll = v["exposeSome"]
            if type(libExposeSome) == "function" then
                libExposeSome()
            end
        end
    end
end

function luno.useAliases()
    for k, v in pairs(luno) do
        if type(v) == "table" then
            local useAlias = v["useAlias"]
            if type(useAlias) == "function" then
                useAlias()
            end
        end
    end
end
