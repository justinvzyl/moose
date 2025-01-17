# FunctionIC

!syntax description /ICs/FunctionIC

Sets an initial condition via a [Function](syntax/Functions/index.md) described by parameter [!param](/ICs/FunctionIC/function). It can be restricted to particular blocks and boundaries using the [!param](/ICs/FunctionIC/block) and [!param](/ICs/FunctionIC/boundary) parameters, respectively.

## Example input syntax

In this example, we set the initial value of variable `u` using a [MooseParsedFunction.md]. This particular example shows that information about the gradient of the parsed function is kept in initial condition, using further mesh refinement.

!listing test/tests/ics/function_ic/parsed_function.i block=ICs Functions

!syntax parameters /ICs/FunctionIC

!syntax inputs /ICs/FunctionIC

!syntax children /ICs/FunctionIC
