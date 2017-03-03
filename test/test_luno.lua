require"TestFunctions"
require"Test"
require"TestLogger"

require"luno"


--##############################################################################

function printSummary(testResults, title)
    title = title or "Resultados:"
    local percentPassed = (testResults.passedCases/testResults.totalCases) * 100
    local percentFailed = 100 - percentPassed

    print(title)
    print("Total de testes   = " .. testResults.totalCases)
    print("Total de sucessos = " .. testResults.passedCases .. " (" .. string.format("%.2f", percentPassed) .. "%)")
    print("Total de falhas   = " .. testResults.failedCases .. " (" .. string.format("%.2f", percentFailed) .. "%)")

end

function createAndRunTest(testFileName, testModuleName)
    local cases = dofile(testFileName .. ".lua")
    local test = Test(cases)
    test:addListener(TestLogger())
    print()
    print(">Testando " .. testModuleName)
    local results = test:run()
    print()
    printSummary(results)
    return results
end


--##############################################################################
local results =
{
    createAndRunTest("test_argReader",  "luno.argReader"),
    createAndRunTest("test_functional", "luno.functional"),
    createAndRunTest("test_string",     "luno.string"),
    createAndRunTest("test_table",      "luno.table"),
    createAndRunTest("test_io",         "luno.io"),
    createAndRunTest("test_util",       "luno.util"),
    --createAndRunTest("test_oop",        "luno.oop"),
}

local globalResults = TestResults.sum(results)

print()
printSummary(globalResults, "Resultados globais:")
