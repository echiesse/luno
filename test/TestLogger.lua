require "luno.oop"
require "TestListener"

class ("TestLogger", TestListener)
function TestLogger.init(obj)
    obj.type = "CaseResult"
end


function TestLogger:exec(caseEvent)
    if caseEvent.status == true then
        msg = "---->Teste " .. caseEvent.case:getName() .. " executado com sucesso."
    else
        msg = "---->Teste " .. caseEvent.case:getName() .. " falhou."
    end
    print(msg)
end


