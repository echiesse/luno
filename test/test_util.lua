require"Test"
require"luno.util"


--##############################################################################
-- Funções auxiliares:
local function printToBuffer(...)
    __buff = ""
    local arg = {...}
    if #arg == 1 then
        __buff = tostring(arg[1])
    elseif #arg > 1 then
        __buff = tostring(arg[1])
        for i = 2, #arg do
            __buff = __buff .. "\t" .. tostring(arg[i])
        end
    end
    __buff = __buff .. "\n"
end


--##############################################################################
-- Testes
local cases =
{
    TestCase
    (
        "choose_true",
        function()
            local ret =
            {
                assertEquals(choose(true, "valTrue", "valFalse"), "valTrue"),
                assertDifferent(choose(true, "valTrue", "valFalse"), "valFalse"),
            }
            return allTrue(ret)
        end
    ),


    TestCase
    (
        "choose_false",
        function()
            local ret =
            {
                assertEquals(choose(false, "valTrue", "valFalse"), "valFalse"),
                assertDifferent(choose(false, "valTrue", "valFalse"), "valTrue"),
            }
            return allTrue(ret)
        end
    ),


    --TestCase
    --(
    --    "printDeep",
    --    function()
    --        local _print = print
    --        print = printToBuffer -- <<<<< Falta definir um contexto de impressão. Algo para bufferizar as saida entre chamadas.
    --
    --        local t1 = {a=1, b="ss"}
    --        --local t2 = {a=1, b="ss", c = {"a", "b"}}
    --        printDeep(t1)
    --        print = _print
    --        local str = "a: 1\r\nb: ss"
    --
    --        local ret = assertEquals (__buff, str)
    --        __buff = nil
    --
    --        return ret
    --    end
    --),



--function copy(val)
--function expose(tab)
--function exposeOnly(tab, keys)
--function pack(...)


}

return cases
