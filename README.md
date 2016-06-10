# L- Schemer
L-Schemer is a simple piece of software written in Chicken Scheme that is designed to facilitate the rendering of [L-Systems](https://en.wikipedia.org/wiki/L-system) with turtle graphics. The software was built on top of the [simple-graphics](http://wiki.call-cc.org/eggref/4/simple-graphics) egg.

## Building L-Schemer
In order to compile L-Schemer one needs to run `csc repl.scm` in the directory

## Using L-Schemer
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
# Data representation with JSON and "ruleset" files
## JSON files
In order to use L-Schemer one must import the L-system data in the form of a JSON file. For more information about the meanings of the individual parameters, [please read the Wikipedia subsection on the structure of L-systems.](https://en.wikipedia.org/wiki/L-system#L-system_structure)
``` JSON
{
        "variables":["F"],     
        "constants":["+", "-"],
        "axiom":"F",
        "rules":{"F":"F+F-F-F+F"}       
}
```
As you can see, variables and constants are represented by an array of strings, axioms by strings, and rules by hashmaps.

## Ruleset Files
Ruleset files of Scheme-style alists, with keys being the variables and constants of a specific L-system and the values being Scheme commands for rendering them (see [simple-graphics](http://wiki.call-cc.org/eggref/4/simple-graphics) for more detail.
``` Scheme
("F" . (forward 1))            
("+" . (left 90))              
("-" . (right 90))
```

## Images
![](https://raw.githubusercontent.com/floutt/L-Schemer/master/images/sierpinski.png)

*Sierpinski/s triangle rendered in L-Schemer*

![](https://raw.githubusercontent.com/floutt/L-Schemer/master/images/koch-curve.png)

*Koch curve partially rendered in L-Schemer*
