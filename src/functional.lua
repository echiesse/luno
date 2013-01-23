-- *****************************************************************************
-- Luno
-- Copyright (c) 2011-2013 Eric Chiesse de Souza (www.echiesse.com.br)
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

--------------------------------------------------------------------------------
--  Obtem o primeiro elemento de uma lista.
--  @param list Lista da qual se obtem o primeiro elemento.
--  @return Primeiro elemento da lista.
function luno.functional.head(list)
    return list[1]
end


--------------------------------------------------------------------------------
--  Obtem uma nova lista sem o primeiro elemento.
--  @param list Lista a ser processada.
--  @return Lista sem o primeiro elemento.
function luno.functional.tail(list)
    local ret = {}
    for i = 2, #list do
        ret[i-1] = list[i]
    end
    return ret
end


--------------------------------------------------------------------------------
--  Obtem o último elemento de uma lista.
--  @param list Lista da qual se obtem o último elemento.
--  @return Último elemento da lista.
function luno.functional.last(list)
    return list[#list]
end


--------------------------------------------------------------------------------
--  Obtem uma nova lista sem o último elemento.
--  @param list Lista a ser processada.
--  @return Lista sem o último elemento.
function luno.functional.init(list)
    local ret = {}
    for i = 1, #list-1 do
        ret[i] = list[i]
    end
    return ret
end


--------------------------------------------------------------------------------
--  Obtem uma nova lista contendo os n primeiros elementos da lista original.
--  @param n    Número de elementos a serem obtidos.
--  @param list Lista a ser processada.
--  @return Lista com os n primeiros elementos da lista original.
function luno.functional.take(n, list)
    local ret = {}
    for i = 1, n do
        ret[i] = list[i]
    end
    return ret
end


--------------------------------------------------------------------------------
--  Obtem uma nova lista sem os n primeiros elementos da lista original.
--  @param n    Número de elementos a serem extraídos.
--  @param list Lista a ser processada.
--  @return Lista sem os n primeiros elementos da lista original.
function luno.functional.drop(n, list)
    local ret = {}
    for i = n+1, #list do
        table.insert(ret, list[i])
    end
    return ret
end


--------------------------------------------------------------------------------
--  Verifica se algum elemento da lista satisfaz o predicado
--  @param f Predicado a ser preenchido. Deve ser uma função que returna um booleano.
--  @param list Lista a ser testada
--  @return Retorna true se algum elemento satifizer o predicado e false caso contrário
function luno.functional.any(f, list)
    local ret = false
    for i, v in ipairs(list) do
        if f(v) == true then
            ret = true
            break
        end
    end
    return ret
end


--------------------------------------------------------------------------------
--  Verifica se todos os elementos da lista satisfazem o predicado
--  @param f Predicado a ser preenchido. Deve ser uma função que returna um booleano.
--  @param list Lista a ser testada
--  @return Retorna true se todos os elementos satifizerem o predicado e false caso contrário.
function luno.functional.all(f, list)
    local ret = true
    for i, v in ipairs(list) do
        if f(v) == false then
            ret = false
            break
        end
    end
    return ret
end


--------------------------------------------------------------------------------
--  Produz uma lista onde os elementos são resultantes da aplicação de uma função
-- a cada elemento de uma lista inicial.
--  @param f    Função a ser aplicada aos elementos de list.
--  @param list Lista com os elementos originais. list deve ser uma tabela lua
-- com índices numéricos.
--  @return Retorna uma lista em que cada elemento é resultante da aplicação da
-- função f à lista list.
function luno.functional.map(f, list)
    local ret = {}
    for i, v in ipairs(list) do
        ret[i] = f(v)
    end
    return ret
end


--------------------------------------------------------------------------------
--  Produz uma tabela onde os elementos são resultantes da aplicação de uma função
-- a cada elemento de uma tabela inicial. Diferente de map, gmap também aplica f
-- aos itens indexados por índices não numéricos.
--  @param f    Função a ser aplicada aos elementos de tab.
--  @param tab  Tabela com os elementos originais.
--  @return Retorna uma tabela em que cada elemento é resultante da aplicação da
-- função f à tabela original tab.
function luno.functional.gmap(f, tab)
    local ret = {}
    for i, v in pairs(tab) do
        ret[i] = f(v)
    end
    return ret
end


--------------------------------------------------------------------------------
--  Produz uma lista onde os elementos são resultantes da aplicação de uma função
-- a cada elemento de uma lista inicial e seu índice.
--  @param f    Função a ser aplicada aos elementos de list e ao seu índice.
-- f deve receber dois argumentos: elem e i onde elem é o elemento a ser
-- processado e i o seu índice.
--  @param list Lista com os elementos originais. list deve ser uma tabela lua
-- com índices numéricos.
--  @return Retorna uma lista em que cada elemento é resultante da aplicação da
-- função f à lista list.
function luno.functional.mapi(f, list)
    local ret = {}
    for i, v in ipairs(list) do
        ret[i] = f(v, i)
    end
    return ret
end


function luno.functional.gmapi(f, tab)
    local ret = {}
    for i, v in pairs(tab) do
        ret[i] = f(v, i)
    end
    return ret
end


function luno.functional.filter(f, list)
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


function luno.functional.gfilter(f, list)
    local ret = {}
    for i, v in pairs(list) do
        if f(v) == true then
            ret[i] = v
        end
    end
    return ret
end


function luno.functional.reduce(f, list, iniVal)
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


function luno.functional.flip(f, a, b)
    return f(b,a)
end


--------------------------------------------------------------------------------
function luno.functional.partial(f, ...)
    local uArg = copy({...}) -- Evita efeitos colaterais
    return function(...) return f(unpack(tbAppend(uArg, {...}))) end
end


function luno.functional.rpartial(f, ...)
    local uArg = copy({...}) -- Evita efeitos colaterais
    return function(...) return f(unpack(tbAppend({...}, uArg))) end
end

--- Funções de aplicação parcial que permitem efeitos colaterais

--------------------------------------------------------------------------------
function luno.functional.cpartial(f, ...)
    local uArg = {...}
    return function(...) return f(unpack(tbAppend(uArg, {...}))) end
end


function luno.functional.crpartial(f, ...)
    local uArg = {...}
    return function(...) return f(unpack(tbAppend({...}, uArg))) end
end


function luno.functional.compose(f1, f2)
    return function(...)
        return f1(f2(...))
    end
end


function luno.functional.gcompose(...)
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


-- Versão iterativa de luno.functional.pipe
function luno.functional.pipe(...)
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


-- Versão recursiva de luno.functional.pipe
function luno.functional.pipeR(...)
    local funcs = {...}
    if type(funcs[1]) == "table" then
        funcs = funcs[1]
    end
    if #funcs == 1 then
        return funcs[1]
    elseif #funcs > 1 then
        local f = funcs[#funcs]
        table.remove(funcs)
        return function(...) return f(luno.functional.pipeR(funcs)(...)) end
    else
        return nil
    end
end


--##############################################################################

-- Operadores
op = {}
function op.mul(a, b) return a * b end
function op.add(a, b) return a + b end
function op.sub(a, b) return a - b end
function op.div(a, b) return a / b end
function op.mod(a, b) return a % b end
function op.cat(a, b) return a .. b end
function op.neg(a)    return (-a) end
function op.len(a)    return #a end

function op.eq(a,b) return a == b end
function op.ne(a,b) return a ~= b end
function op.gt(a,b) return a >  b end
function op.ge(a,b) return a >= b end
function op.lt(a,b) return a <  b end
function op.le(a,b) return a <= b end

function op.andf(a, b) return (a and b) end
function op.orf(a, b)  return (a or b) end
function op.notf(a)    return (not a) end

-- Predicados
function isEven(a) return (a%2 == 0) end
function isOdd(a)  return (a%2 ~= 0) end

--##############################################################################

return luno.functional
