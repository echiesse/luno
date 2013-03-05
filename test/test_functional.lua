require"Test"
require"luno.functional"

luno.functional.exposeAll()

--##############################################################################
-- Funções auxiliares:

local function double(x)
    return 2 * x
end

local function ff(x)
    return x
end

--##############################################################################
-- Testes
local cases =
{
    TestCase
    (
        "head",
        function()
            local v =
            {
                assertEquals(10, head{10, 20, 30, 40, 50, 60}),
                assertEquals(10, head{10}),
                assertNil(head{}),
            }

            return allTrue(v)
        end
    ),


    TestCase
    (
        "tail",
        function()
            local v =
            {
                assertListEquals({20, 30, 40, 50, 60}, tail{10, 20, 30, 40, 50, 60}),
                assertListEmpty(tail{1}),
                assertListEmpty(tail{}),
            }

            return allTrue(v)
        end
    ),


    TestCase
    (
        "last",
        function()
            local v =
            {
                assertEquals(60, last{10, 20, 30, 40, 50, 60}),
                assertEquals(10, last{10}),
                assertNil(last{}),
            }

            return allTrue(v)
        end
    ),


    TestCase
    (
        "init",
        function()
            local v =
            {
                assertListEquals({10, 20, 30, 40, 50}, init{10, 20, 30, 40, 50, 60}),
                assertListEmpty(init{1}),
                assertListEmpty(init{}),
            }

            return allTrue(v)
        end
    ),


    TestCase
    (
        "take",
        function()
            local a = {10, 20, 30, 40, 50, 60}
            local b = take(3, a)
            local c = take(6, a)

            local v =
            {
                assertTrue(listEquals(b, {10, 20, 30})),
                assertTrue(listEquals(c, {10, 20, 30, 40, 50, 60})),

                assertTrue(listEquals(take(1, {1}), {1})),
                assertTrue(listEquals(take(0, {1}), {})),
            }

            return allTrue(v)
        end
    ),


    TestCase
    (
        "drop",
        function ()
            local a = {10, 20, 30, 40, 50, 60}
            local b = drop(2, a)
            local c = drop(6, a)

            local v =
            {
                assertTrue(listEquals(b, {30, 40, 50, 60})),
                assertTrue(listEquals(c, {})),
                assertTrue(listEquals(drop(1, {1}), {})),
            }
            return allTrue(v)
        end
    ),


    TestCase
    (
        "any",
        function ()
            local function eq3(a) return a == 3 end
            local v =
            {
                assertTrue(any(eq3, {1,2,3})),
                assertTrue(any(eq3, {3})),
                assertFalse(any(eq3, {4,5,6})),
            }
            return allTrue(v)
        end
    ),


    TestCase
    (
        "all",
        function ()
            local function eq3(a) return a == 3 end
            local v =
            {
                assertTrue(all(eq3, {3,3,3,3})),
                assertTrue(all(eq3, {3})),
                assertFalse(all(eq3, {3,3,3,3,4})),
                assertFalse(all(eq3, {1,2,3})),
                assertFalse(all(eq3, {4,5,6})),
            }
            return allTrue(v)
        end
    ),


    TestCase
    (
        "map",
        function()
            local res1 = map(double, {1,2,3})
            local res2 = map(double, {1})
            local res3 = map(double, {})


            local ret =
            {
                assertTrue(listEquals(res1, {2,4,6})),
                assertTrue(listEquals(res2, {2})),
                assertTrue(listEquals(res3, {})),
            }

            return allTrue(ret)
        end
    ),


    TestCase
    (
        "map_typeMismatch",
        function()
            local res1 = assertStackErrorDepth(1, map, nil, {1,2,3})
            print(_S.level)
            --local res2 = map(double, nil)
            --local res3 = map("", {1,2,3})

            return allTrue{res1}
        end
    ),


    TestCase
    (
        "gmap",
        function()
            local function f(a)
                return "!" .. a .. "!"
            end
            local t1 = {a = "a", b = "b", c = "c"}
            local res1 = gmap(f, t1)

            local t2 = {a = "a", b = "b", c = "c", "d"}
            local res2 = gmap(f, t2)

            local ret =
            {
                assertTrue(tableEquals(res1, {a = "!a!", b = "!b!", c = "!c!"})),
                assertTrue(tableEquals(res2, {a = "!a!", b = "!b!", c = "!c!", "!d!"})),
            }

            return allTrue(ret)
        end
    ),


--function F.mapi(f, list)
--function F.gmapi(f, list)
--function F.filter(f, list)
--function F.gfilter(f, list)
    TestCase
    (
        "reduce",
        function()
            local function soma(a,b)return a+b end
            local ret1 =
            {
                assertError(reduce, soma, {}),
                assertError(reduce, soma, {1}),
                assertError(reduce, soma, {}, 1),
            }

            local ret2 =
            {
                assertEquals(reduce(soma, {1,1})    , 2),
                assertEquals(reduce(soma, {1}, 1)   , 2),
                assertEquals(reduce(soma, {1, 1}, 1), 3),
            }

            return allEquals({allEquals(ret1, true), allEquals(ret2, true)}, true)
        end
    ),


    TestCase
    (
        "flip",
        function()
            local function f(a,b) return a, b end

            local ret =
            {
                assertListEquals({flip(f, 1,   2)}, {2, 1}),
                assertListEquals({flip(f, nil, 2)}, {2, nil}),
                assertListEquals({flip(f, "a", 1)}, {1, "a"}),
                assertListEquals({flip(f, "a", 1, "b")}, {1, "a"}),
            }

            return allTrue(ret)
        end
    ),


--function F.partial(f, ...)
--function F.rpartial(f, ...)
--function F.cpartial(f, ...)
--function F.crpartial(f, ...)
--function F.compose(f1, f2)
    TestCase
    (
        "gcompose",
        function()
            local function f1(x, y) return y, x end
            local function f2(x, y) return 2 + x, 3 + y end
            local function f3(x, y) return x^2, x+y end
            f3 = gcompose(f3,f1,f2)

            local v =
            {
                assertTrue(listEquals({f3(1,2)}, {25, 8})),
                assertTrue(listEquals({f3(0,0)}, {9, 5})),
            }

            return allTrue(v)
        end
    ),


--function F.pipe(...)
--function F.pipeR(...)
--
--function op.mul(a, b) return a * b end
--function op.add(a, b) return a + b end
--function op.sub(a, b) return a - b end
--function op.div(a, b) return a / b end
--function op.mod(a, b) return a % b end
--function op.cat(a, b) return a .. b end
--function op.neg(a)    return (-a) end
--function op.len(a)    return #a end
--
--function op.eq(a,b) return a == b end
--function op.ne(a,b) return a ~= b end
--function op.gt(a,b) return a >  b end
--function op.ge(a,b) return a >= b end
--function op.lt(a,b) return a <  b end
--function op.le(a,b) return a <= b end
--
--function op.andf(a, b) return (a and b) end
--function op.orf(a, b)  return (a or b) end
--function op.notf(a)    return (not a) end
--
--function isEven(a) return (a%2 == 0) end
--function isOdd(a)  return (a%2 ~= 0) end


}


return cases
