require "luno.oop"

class"Event"
function Event.init(obj)
    obj.type = "all"
end


class("CaseResultEvent", Event)
function CaseResultEvent.init(obj, case, status)
    obj.type = "CaseResult"
    obj.case = case
    obj.status = status
end

