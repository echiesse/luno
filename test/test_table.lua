require"Test"
require"luno.table"


--##############################################################################
-- Funções auxiliares:


--##############################################################################
-- Testes
local cases =
{
    TestCase
    (
        "useAlias",
        function()
            -- Criar arquivo temporário:
            luno.table.useAlias()
            local res =
            {
                assertTable(ltable),
                assertEquals(luno.table, ltable)
            }
            return allTrue(res)
        end
    ),


    TestCase
    (
        "append",
        function()
            local t1 = {1,2,3}
            local t2 = {10,20,30}

            local res1 = luno.table.append(t1, t2)
            local res2 = luno.table.append(t2, t1)


            local ret =
            {
                assertListEquals(res1, {1,2,3,10,20,30}),
                assertListEquals(res2, {10,20,30,1,2,3}),
            }

            return allEquals(ret, true)
        end
    ),


    TestCase
    (
        "appendA",
        function()
            local t1 = {1,2,3}
            local t2 = {10,20,30}

            luno.table.appendA(t1, t2)


            local ret =
            {
                assertListEquals(t1, {1,2,3,10,20,30}),
            }

            return allEquals(ret, true)
        end
    ),


--function luno.table.equals(tb1, tb2)
--function luno.table.iequals(l1, l2)
--function luno.table.print(tb)
--function luno.table.isEmpty(tb)
--function luno.table.last(tb)
--function luno.table.find(tb, value, test)
--[[
    TestCase
    (
        "find",
        function()
            local t1 = {10,20,30,40,50,60}
            local res1 = luno.table.find(t1, 30)
            printDeep(res1)

            local t2 = {a=10,b=20,c=10}
            local res2 = luno.table.find(t2, 10)
            printDeep(res2)

            local t3 = {a=10,b=20,c=10,d=30}
            local res3 = luno.table.find(t3, 15, function(value, vRef) return value > vRef end)
            printDeep(res3)

            local ret =
            {
                assertTableCorresponds(res1, {{index = 3, value = 30}}),
                assertTableCorresponds(res2, {{index = "a", value = 10},{index = "c", value = 10}}),
                assertTableCorresponds(res3, {{index = "b", value = 20},{index = "d", value = 30}}),
            }

            return allEquals(ret, true)
        end
    ),
]]

    TestCase
    (
        "slice",
        function()
            local t1 = {1,2,3,4,5,6}

            local res1 = luno.table.slice(t1, 1, 2)
            local res2 = luno.table.slice(t1, 1, 6)
            local res3 = luno.table.slice(t1, 1, 1)
            local res4 = luno.table.slice(t1, 6, 6)
            local res5 = luno.table.slice(t1, 1, -1)
            local res6 = luno.table.slice(t1, -2, -1)
            local res7 = luno.table.slice(t1, -5, 6)


            local ret =
            {
                assertListEquals(res1, {1,2}),
                assertListEquals(res2, {1,2,3,4,5,6}),
                assertListEquals(res3, {1}),
                assertListEquals(res4, {6}),
                assertListEquals(res5, {1,2,3,4,5,6}),
                assertListEquals(res6, {5,6}),
                assertListEquals(res7, {2,3,4,5,6}),
            }

            return allEquals(ret, true)
        end
    ),


}

return cases
