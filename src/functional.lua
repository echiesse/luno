-- *****************************************************************************
-- Luno
-- Copyright (c) 2011-2012 Eric Chiesse de Souza (www.echiesse.com.br)
-- Read "License.txt" for the license terms
-- *****************************************************************************

require"luno.base"
require"luno.util"


luno.functional = {}


function luno.functional.exposeAll()
    expose(luno.functional)
end


function luno.functional.useAlias()
    F = luno.functional
end


--[[
function luno.functional.exposeSome()
end
]]


-- O módulo functional por padrão usa aliases
luno.functional.useAlias()

--##############################################################################

-- Funções auxiliares:
local function tbAppend(t1, t2)
    local ret = {}

    for _i, t in ipairs{t1,t2} do
        for i, v in ipairs(t) do
            table.insert(ret, v)
        end
    end
    return ret
end


--##############################################################################

--------------------------------------------------------------------------------
-- Funções sobre listas:

function F.head(list)
    return list[1]
end


function F.tail(list)
    local ret = {}
    for i = 2, #list do
        ret[i-1] = list[i]
    end
    return ret
end


function F.take(n, list)
    local ret = {}
    for i = 1, n do
        ret[i] = list[i]
    end
    return ret
end


function F.drop(n, list)
    local ret = {}
    for i = n+1, #list do
        table.insert(ret, list[i])
    end
    return ret
end


--------------------------------------------------------------------------------
function F.any(f, list)
    local ret = false
    for i, v in ipairs(list) do
        if f(v) == true then
            ret = true
            break
        end
    end
    return ret
end


function F.all(f, list)
    local ret = true
    for i, v in ipairs(list) do
        if f(v) == false then
            ret = false
            break
        end
    end
    return ret
end


function F.map(f, list)
    local ret = {}
    for i, v in ipairs(list) do
        ret[i] = f(v)
    end
    return ret
end


function F.gmap(f, list)
    local ret = {}
    for i, v in pairs(list) do
        ret[i] = f(v)
    end
    return ret
end


function F.mapi(f, list)
    local ret = {}
    for i, v in ipairs(list) do
        ret[i] = f(v, i)
    end
    return ret
end


function F.gmapi(f, list)
    local ret = {}
    for i, v in pairs(list) do
        ret[i] = f(v, i)
    end
    return ret
end


function F.filter(f, list)
    local ret = {}
    local j = 1
    for i, v in ipairs(list) do
        if f(v) == true then
            ret[j] = v
            j = j + 1
        end
    end
    return ret
end


function F.gfilter(f, list)
    local ret = {}
    for i, v in pairs(list) do
        if f(v) == true then
            ret[i] = v
        end
    end
    return ret
end


function F.reduce(f, list, iniVal)
    list = copy(list) -- Evitar efeitos colaterais no chamador
    if iniVal == nil then
        if #list < 2 then
            error("A lista deve ter no minimo 2 elementos", 2)
        else
            iniVal = list[1]
            table.remove(list, 1)
        end
    elseif #list < 1 then
        error("A lista deve ter no minimo 1 elemento", 2)
    end

    local ret = iniVal
    for i, v in ipairs(list) do
        ret = f(ret, v)
    end
    return ret
end


function F.flip(f, a, b)
    return f(b,a)
end


--------------------------------------------------------------------------------
function F.partial(f, ...)
    local uArg = copy({...}) -- Evita efeitos colaterais
    return function(...) return f(unpack(tbAppend(uArg, {...}))) end
end


function F.rpartial(f, ...)
    local uArg = copy({...}) -- Evita efeitos colaterais
    return function(...) return f(unpack(tbAppend({...}, uArg))) end
end

--- Funções de aplicação parcial que permitem efeitos colaterais
function F.cpartial(f, ...)
    local uArg = {...}
    return function(...) return f(unpack(tbAppend(uArg, {...}))) end
end


function F.crpartial(f, ...)
    local uArg = {...}
    return function(...) return f(unpack(tbAppend({...}, uArg))) end
end


function F.compose(f1, f2)
    return function(...)
        return f1(f2(...))
    end
end


function F.gcompose(...)
    local funcs = {...}
    if type(funcs[1]) == "table" then
        funcs = funcs[1]
    end

    return function(...)
        local ret = {...}
        for i = #funcs, 1, -1 do
            local f = funcs[i]
            ret = {f(unpack(ret))}
        end
        return unpack(ret)
    end
end


-- Versão iterativa de F.pipe
function F.pipe(...)
    local funcs = {...}
    if type(funcs[1]) == "table" then
        funcs = funcs[1]
    end

    return function(...)
        local ret = {...}
        for i, f in ipairs(funcs) do
            ret = {f(unpack(ret))}
        end
        return unpack(ret)
    end
end


-- Versão recursiva de F.pipe
function F.pipeR(...)
    local funcs = {...}
    if type(funcs[1]) == "table" then
        funcs = funcs[1]
    end
    if #funcs == 1 then
        return funcs[1]
    elseif #funcs > 1 then
        local f = funcs[#funcs]
        table.remove(funcs)
        return function(...) return f(F.pipeR(funcs)(...)) end
    else
        return nil
    end
end


--##############################################################################

-- Operadores
Op = {}
function Op.mul(a, b) return a * b end
function Op.add(a, b) return a + b end
function Op.sub(a, b) return a - b end
function Op.div(a, b) return a / b end
function Op.mod(a, b) return a % b end
function Op.cat(a, b) return a .. b end
function Op.neg(a)    return (-a) end
function Op.len(a)    return #a end

function Op.eq(a,b) return a == b end
function Op.ne(a,b) return a ~= b end
function Op.gt(a,b) return a >  b end
function Op.ge(a,b) return a >= b end
function Op.lt(a,b) return a <  b end
function Op.le(a,b) return a <= b end

function Op.andf(a, b) return (a and b) end
function Op.orf(a, b)  return (a or b) end
function Op.notf(a)    return (not a) end

-- Predicados
function isEven(a) return (a%2 == 0) end
function isOdd(a)  return (a%2 ~= 0) end

--##############################################################################

return luno.functional
