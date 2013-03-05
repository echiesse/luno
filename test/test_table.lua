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
