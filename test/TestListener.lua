require "luno.oop"

class "TestListener"

function TestListener.init(obj, listenerType)
    obj.type = listenerType or "all"
end


function TestListener:exec(event)
    error("listener:exec is not implemented", 2)
end


