require "luno.oop"
require "luno.table"
require "TestFunctions"
require "TestEvent"

luno.useAliases()


--##############################################################################
class "TestResults"
function TestResults.init(obj, totalCases, passedCases, failedCases)
    obj.totalCases  = totalCases  or 0
    obj.passedCases = passedCases or 0
    obj.failedCases = failedCases or 0
end


function TestResults.__add(self, t2)
    local info = TestResults()
    for i, v in pairs(self) do
        info[i] = v + t2[i]
    end

    return info
end


function TestResults.sum(res)
    local ret = TestResults()
    for i, v in pairs(res) do
        ret = ret + v
    end

    return ret
end


--##############################################################################
class "TestCase"

function TestCase.init(obj, name, caseFunction)
    obj.name = name
    obj.f = caseFunction
end


function TestCase:setFunction(f)
    self.f = f
end


function TestCase:getName()
    return self.name
end


function TestCase:run()
    return self.f()
end


--##############################################################################
class "Test"

function Test.init(obj, arg)
    obj.listeners = {}

    if arg == nil then
        obj.cases = {}
    elseif arg._name == "Test" then
        obj.cases = arg.cases
    elseif type(arg) == "table" then
        if type(arg[1]) == "table" then
            if arg[1]._name == "Test" then
                -- Estamos importando testes:
                obj.cases = {}
                for i, test in ipairs(arg) do
                    obj.cases = ltable.append(obj.cases, test.cases)
                end
            elseif arg[1]._name == "TestCase" then
                -- Estamos importando casos de teste:
                obj.cases = arg
            end
        end
    else
        -- Erro?
        -- Por enquanto não fazemos nada
    end
end


function Test.addListener(self, listener)
    table.insert(self.listeners, listener)
end


function Test.notify(self, event)
    for i, listener in ipairs(self.listeners) do
        if listener.type == "all" or listener.type == event.type then
            listener:exec(event)
        end
    end
end


function Test.reset(self)
    self.cases = {}
end


function Test.addCase(self, case)
    table.insert(self.cases, case)
end


function Test.setCases(self, cases)
    self.cases = cases
end


function Test:mergeCases(tests)
    for i, test in ipairs(tests) do
        self.cases = ltable.append(self.cases, test.cases)
    end
end


function Test.run(self)
    local msg
    local failedCases = 0
    local passedCases = 0
    local totalCases = #self.cases

    for i, case in ipairs(self.cases) do
        local status = case:run()
        if status == true then
            passedCases = passedCases + 1
        else
            failedCases = failedCases + 1
        end
        self:notify(CaseResultEvent(case, status))
    end

    local results = TestResults(totalCases, passedCases, failedCases)

    return results
end


