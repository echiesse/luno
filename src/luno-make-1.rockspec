
package = "Luno"
version = "make-1"
source =
{
    url = "http://...",
}

description =
{
    summary = "General purpose libraries for Lua.",
    detailed = [[Luno is a native lua implementation of a series of helpers for common tasks not covered in the standard library. Luno also provides support for functional and object oriented programming paradigms.
The library comprises the following packages:
    - luno.util        - General purpose functions
    - luno.argReader   - Deals with command line arguments
    - luno.io          - Helper io functions
    - luno.string      - Helper string functions
    - luno.table       - Helper table function
    - luno.functional  - Helps to write functional code in Lua.
    - luno.oop         - Helps to write oo code in Lua.

Note: Luno means Lua (moon) in esperanto.]],
    homepage = "http://code.google.com/p/luno/",
    license = "MIT",
}

dependencies =
{
    "lua >= 5.1"
}

build =
{
    type = "builtin",
    modules =
    {
        luno = "init.lua",
        ["luno.argReader"]  = "argReader.lua",
        ["luno.base"]       = "base.lua",
        ["luno.functional"] = "functional.lua",
        ["luno.io"]         = "io.lua",
        ["luno.oop"]        = "oop.lua",
        ["luno.string"]     = "string.lua",
        ["luno.table"]      = "table.lua",
        ["luno.util"]       = "util.lua",
    }
}
