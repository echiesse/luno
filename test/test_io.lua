require"Test"
require"luno.io"


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
            luno.io.useAlias()
            local res =
            {
                assertTable(lio),
                assertEquals(luno.io, lio)
            }
            return allTrue(res)
        end
    ),


    TestCase
    (
        "getTextFromFile_fileExists",
        function()
            -- Criar arquivo temporário:
            local text = "Teste*&!!@#"
            local fileName = "tmp1.tmp"
            local tmpHandle = io.open(fileName, "w")
            tmpHandle:write(text)
            tmpHandle:close()

            -- Ler o arquivo:
            local readText = luno.io.getTextFromFile(fileName)

            -- Comparar os resultados:
            local res = assertEquals (text, readText)

            -- Limpeza:
            os.remove(fileName)

            return res
        end
    ),


    TestCase
    (
        "getTextFromFile_fileDontExists",
        function()
            -- Criar arquivo temporário:
            local fileName = "tmp2.tmp"
            os.remove(fileName)

            -- Ler o arquivo:
            local readText, text = luno.io.getTextFromFile(fileName)

            -- Comparar os resultados:
            local res = {assertNil(readText), assertString(text)}

            return allTrue(res)
        end
    ),


    TestCase
    (
        "saveTextToFile",
        function()
            -- Criar arquivo temporário:
            local text = "Teste*&!!@#"
            local fileName = "tmp3.tmp"
            luno.io.saveTextToFile(text, fileName)

            -- Ler o arquivo:
            local res = false
            local tmpHandle = io.open(fileName, "rb")
            if assertNonNil(tmpHandle) then
                local readText = tmpHandle:read("*a")

                -- Comparar os resultados:
                res = assertEquals (text, readText)
                tmpHandle:close()
            end

            -- Limpeza:
            os.remove(fileName)
            return res
        end
    ),
}


return cases
