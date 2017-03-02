require"Test"
require"luno.argReader"


--##############################################################################
-- Funções auxiliares:
local argMap =
{
    a = luno.argReader.ARG_TYPE.FLAG,
}


--##############################################################################
-- Testes
local cases =
{
    TestCase
    (
        "Flag absent goes to false",
        function()
            local args = luno.argReader.getArgTable({}, argMap)
            return assertFalse(args.a)
        end
    ),

    TestCase
    (
        "Flag is true",
        function()
            local args = luno.argReader.getArgTable({"a"}, argMap)
            return assertTrue(args.a)
        end
    ),

    TestCase
    (
        "Inexistent flag is nil flag",
        function()
            local args = luno.argReader.getArgTable({"void"}, argMap)
            return assertNil(args.void)
        end
    ),

    TestCase
    (
        "Inexistent flag or key is positional",
        function()
            local paramName = "void"
            local args = luno.argReader.getArgTable({paramName}, argMap)
            return assertEquals(args[1], paramName)
        end
    ),
}

return cases
