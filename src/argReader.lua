require"ecs/stringEx"

--[[
-- Exemplo de mapa de argumentos:
argMap =
{
    ["-o"] = ARG_TYPE.KEY_VALUE,
    ["-c"] = ARG_TYPE.FLAG,
}
--]]

ARG_TYPE =
{
    POSITIONAL = 0,
    FLAG       = 1,
    KEY_VALUE  = 2,
}


function getArgTable(args, argMap)
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

    return ret
end

