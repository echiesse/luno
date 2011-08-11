
ioEx = {}

function ioEx.getTextFromFile(fileName)
    local file = io.open(fileName, "rt")
    return file:read("*a")
end


function ioEx.saveTextToFile(text, fileName)
    local file = io.open(fileName, "wt")
    file:write(text)
end


return ioEx