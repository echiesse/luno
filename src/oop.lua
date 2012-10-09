-- *****************************************************************************
-- Luno
-- Copyright (c) 2011-2012 Eric Chiesse de Souza (www.echiesse.com.br)
-- Read "License.txt" for the license terms
-- *****************************************************************************

require"luno.base"


luno.oop = {}

local commonCreateClass


function Class(className, Base, env)
    env = env or _G
    env[className] = {}
    local ClassTable = env[className]
    commonCreateClass(ClassTable, Base)
    ClassTable._name = className
end


function commonCreateClass(ClassTable, Base)
    ClassTable.mt = Base or {}
    setmetatable(ClassTable, ClassTable.mt)

    -- Template para a criação do construtor:
    ClassTable.mt.__call = function(classObj, ...) -- ClassTable e classObj são a mesma tabela
        local new = {}
        setmetatable(new, classObj)
        if classObj.init ~= nil then
            classObj.init(new, ...)
        else
            classObj.init = function() end
        end
        return new
    end

    -- Atributos não encontrados no objeto devem ser encontrados na classe:
    ClassTable.__index = ClassTable
end
