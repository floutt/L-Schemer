# L- Schemer
L-Schemer is a simple piece of software written in Chicken Scheme that is designed to facilitate the rendering of [L-Systems](https://en.wikipedia.org/wiki/L-system) with turtle graphics. The software was built on top of the [simple-graphics](http://wiki.call-cc.org/eggref/4/simple-graphics) egg.

# Building L-Schemer
In order to compile L-Schemer one needs to run `csc repl.scm` in the directory

# Using L-Schemer
There are two ways to use L-Schemer, one can use the filename of a source file as the parameter for "repl"

```
./repl filename
```

One can also simply pass parameters to the REPL (see "content/help.txt" for more info)

```
lscm> IMPORT JSON examples/json/koch.json koch
lscm> IMPORT RULESET examples/rulesets/koch.ruleset koch
lscm> RENDER koch 0.01 6
```
