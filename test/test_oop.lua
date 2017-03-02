require"Test"
require"luno.oop"


--##############################################################################
-- Funções auxiliares:


--##############################################################################
-- Testes
local cases =
{
    TestCase
    (
        "makeClass",
        function()
            local classTable = {}

            makeClass(classTable)

            -- Criar uma instância:
            local obj = classTable()

            local res =
            {
                assertTable(classTable),
                -- Verificar a existência de init:
                assertFunction(obj.init),
            }
            return allTrue(res)
        end
    ),
}

return cases
