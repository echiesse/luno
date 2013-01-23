require"luno.table"
require"Test"

luno.table.useAlias()

--##############################################################################
-- Funções auxiliares:


--##############################################################################
-- Testes
local cases =
{
    TestCase
    (
        "append",
        function()
            local t1 = {1,2,3}
            local t2 = {10,20,30}

            local res1 = ltable.append(t1, t2)
            local res2 = ltable.append(t2, t1)


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

            ltable.appendA(t1, t2)


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

            local res1 = ltable.slice(t1, 1, 2)
            local res2 = ltable.slice(t1, 1, 6)
            local res3 = ltable.slice(t1, 1, 1)
            local res4 = ltable.slice(t1, 6, 6)
            local res5 = ltable.slice(t1, 1, -1)
            local res6 = ltable.slice(t1, -2, -1)
            local res7 = ltable.slice(t1, -5, 6)


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
