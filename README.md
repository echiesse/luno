# Luno
Luno is a bundle of general purpose libraries for Lua.
The Luno project provides APIs to perform common tasks that facilitate the use of the Lua language.


##Extensions to Lua standard library
Luno conta com os módulos luno.string, luno.table e luno.io. Esses módulos provêem funções extras para manipular strings (trim, split, join, charAt, ...), io (getTextFromFile, ...), tabelas (imprimir tabelas, concatenar, ...).
O módulo luno.util provê funções de uso geral como cópia (deep copy)  e impressão (deep print) de variáveis.

O exemplo a seguir mostra como a biblioteca pode poupar código e deixar o trabalho mais organizado. Suponhamos que estamos interessados na primeira e na última linha de um arquivo. O código escrito diretamente em Lua pode ser como segue:
```lua
arqIn = io.open("list.txt", "rt")
text = arqIn:read("*a")
arqIn:close()
text = string.gsub(text, "^%s*", "")
text = string.gsub(text, "%s*$", "")
first = string.match(text, "^(.-)\r?\n")
last  = string.match(text, "([^\n]-)$")
newText = first .. "\n" .. last
arqOut = io.open("newList.txt", "wt")
arqOut:write(newText)
arqOut:close()
```

Já o código escrito com o suporte de Luno fica:
```lua
require"luno.string"
require"luno.table"
require"luno.io"

luno.useAliases() -- permite usar lstring em vez de luno.string (idem para io e table)

text = lio.getTextFromFile("list.txt")
text = lstring.trim(text)
list = lstring.splitLines(text)
newList = {list[1] or "empty", ltable.last(list) or "empty"}
newText = lstring.joinLines(newList)
lio.saveTextToFile(newText, "newList.txt")
```

A segunda versão do código é muito mais legível, podendo mesmo ser lido sem comentários de documentação. Além disso, evita problemas com arquivos não fechados e elimina o tempo, muitas vezes necessário, para ajustar corretamente o _pattern matching_ de strings. Por último, as linhas de código efetivo (eliminando os requires e configuração da lib) cai de 11 para 6 que é uma ganho que quase 2:1.

##Functional Programming - luno.functional
O módulo luno.functional implementa as principais funções do paradigma funcional, como por exemplo: map, filter e reduce. Também há suporte para composição de funções e aplicação parcial de parâmetros. É possivel por exemplo fazer:

```lua
require "luno.functional"
function soma(a,b) return a+b end
soma2 = F.partial(soma, 2)
list = {1,2,3,4}
res = F.map(soma2, list) -- res == {3,4,5,6}
```

##Object Orientation - luno.oop
O módulo `luno.oop` implementa um pequeno framework (bem pequeno) para programação orientada a objetos que permite fazer coisas simples como:
```lua
require "luno.oop"
class"A" -- declarar uma classe
function A:init(a,b) -- definir um construtor
    self.a = a
    self.b = b
end

a = A(1,2) -- instanciar um objeto.
```
Herança também é prevista mudando um pouco a sintaxe.

##Note
Please consider this project in experimental phase and relatively unstable. It is possible that some interfaces change in new versions though this does not happen frequently.
