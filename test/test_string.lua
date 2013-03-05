require"Test"
require"luno.string"


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
            luno.string.useAlias()
            local res =
            {
                assertTable(lstring),
                assertEquals(luno.string, lstring)
            }
            return allTrue(res)
        end
    ),


    TestCase
    (
        "chatAt",
        function()
            local res1 = lstring.charAt("agua", 1)
            local res2 = lstring.charAt("agua", 3)


            local ret =
            {
                assertEquals(res1, "a"),
                assertEquals(res2, "u"),
            }

            return allEquals(ret, true)
        end
    ),


    TestCase
    (
        "trim",
        function()
            local res1 = lstring.trim("   agua")
            local res2 = lstring.trim("agua    ")
            local res3 = lstring.trim(" agua    ")
            local res4 = lstring.trim(" ag  ua    ")


            local ret =
            {
                assertEquals(res1, "agua"),
                assertEquals(res2, "agua"),
                assertEquals(res3, "agua"),
                assertEquals(res4, "ag  ua"),
            }

            return allEquals(ret, true)
        end
    ),


    TestCase
    (
        "ltrim",
        function()
            local res1 = lstring.ltrim("   agua")
            local res2 = lstring.ltrim("agua    ")
            local res3 = lstring.ltrim(" agua    ")
            local res4 = lstring.ltrim(" ag  ua    ")


            local ret =
            {
                assertEquals(res1, "agua"),
                assertEquals(res2, "agua    "),
                assertEquals(res3, "agua    "),
                assertEquals(res4, "ag  ua    "),
            }

            return allEquals(ret, true)
        end
    ),


    TestCase
    (
        "rtrim",
        function()
            local res1 = lstring.rtrim("   agua")
            local res2 = lstring.rtrim("agua    ")
            local res3 = lstring.rtrim(" agua    ")
            local res4 = lstring.rtrim(" ag  ua    ")


            local ret =
            {
                assertEquals(res1, "   agua"),
                assertEquals(res2, "agua"),
                assertEquals(res3, " agua"),
                assertEquals(res4, " ag  ua"),
            }

            return allEquals(ret, true)
        end
    ),

--luno.string.gltrim(str, pattern)
--luno.string.grtrim(str, pattern)
--luno.string.gtrim(str, patternLeft, patternRight)


    TestCase
    (
        "beginsWith",
        function()
            local res1 = lstring.beginsWith("abcde", "")
            local res2 = lstring.beginsWith("abcde", "a")
            local res3 = lstring.beginsWith("abcde", "abc")
            local res4 = lstring.beginsWith("abcde", "abcde")
            local res5 = lstring.beginsWith("abcde", "abd")
            local res6 = lstring.beginsWith("abcde", "e")
            local res7 = lstring.beginsWith("a", "abcde")

            local ret =
            {
                assertTrue(res1),
                assertTrue(res2),
                assertTrue(res3),
                assertTrue(res4),
                assertFalse(res5),
                assertFalse(res6),
                assertFalse(res7),
            }

            return allTrue(ret)
        end
    ),


    TestCase
    (
        "endsWith",
        function()
            local res1 = lstring.endsWith("abcde", "")
            local res2 = lstring.endsWith("abcde", "e")
            local res3 = lstring.endsWith("abcde", "de")
            local res4 = lstring.endsWith("abcde", "abcde")
            local res5 = lstring.endsWith("abcde", "bde")
            local res6 = lstring.endsWith("abcde", "a")
            local res7 = lstring.endsWith("", "e")
            local res8 = lstring.endsWith("e", "abcde")

            local ret =
            {
                assertTrue(res1),
                assertTrue(res2),
                assertTrue(res3),
                assertTrue(res4),
                assertFalse(res5),
                assertFalse(res6),
                assertFalse(res7),
                assertFalse(res8),
            }

            return allTrue(ret)
        end
    ),


    TestCase
    (
        "split",
        function()
            local res1 = lstring.split("a,a", ",")
            local res2 = lstring.split("a,a,", ",")
            local res3 = lstring.split("a,a,,", ",")
            local res4 = lstring.split("aa", ",")
            local res5 = lstring.split("aa", "aa")

            local ret =
            {
                assertListEquals(res1, {"a","a"}),
                assertListEquals(res2, {"a","a",""}),
                assertListEquals(res3, {"a","a","",""}),
                assertListEquals(res4, {"aa"}),
                assertListEquals(res5, {"", ""}),
            }

            return allTrue(ret)
        end
    ),


    TestCase
    (
        "splitWords",
        function()
            local res1 = lstring.splitWords("a b c d e")
            local res2 = lstring.splitWords("  a b     c  d   e  ")
            local res3 = lstring.splitWords([[a b
               c  d  e]])
            local res4 = lstring.splitWords("a\t b \n c d \r e")
            local ret =
            {
                assertListEquals(res1, {"a","b","c","d","e"}),
                assertListEquals(res2, {"","a","b","c","d","e",""}),
                assertListEquals(res3, {"a","b","c","d","e"}),
                assertListEquals(res4, {"a","b","c","d","e"}),
            }

            return allTrue(ret)
        end
    ),


    TestCase
    (
        "splitLines",
        function()
            local res1 = lstring.splitLines([[a b c d e]])
            local res2 = lstring.splitLines([[a b
             c  d
e
  f  ]])

            local ret =
            {
                assertListEquals(res1, {"a b c d e"}),
                assertListEquals(res2, {"a b","             c  d","e", "  f  "}),
            }

            return allTrue(ret)
        end
    ),


--luno.string.splitIterator(text, sep)
--luno.string.join(list, sep)
--luno.string.joinWords(words)
--luno.string.joinLines(lines)
--luno.string.strLinesIterator(text)
--luno.string.removeFirstN(n, str)
--luno.string.removeFirst(str)
--luno.string.removeLastN(n, str)
--luno.string.removeLast(str)
--luno.string.lastChar(str, pos)
--luno.string.firstChar(str, pos)


}

return cases
