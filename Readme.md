# Simulated-Annealing.jl

-------------

Julia implementation of the simulated annealing algorithm for solving the 3cnf-sat problem.

-------------

## Usage:

The simulated annealing can be invocated by using `main(name)` present on the main.jl file, where `name` is the path to a file in the DIMACS cnf format.
_tester.jl_ contains a function which runs over a directory and executes the simulated annealing on all input files there, and saves the output
to a file.

In the main function there are some relevant parameters:

| Name     | Default  | Description                                                         |
| ---      | ---      | ---                                                                 |
| maxIter  | 5 * 10^5 | Maximum number of iteration for the program execution               |
| t\_0     | 220.0    | Starting temperature                                                |
| t\_n     | 0.0      | Final temperature                                                   |
| temp     | linear   | Pointer to the cooling scheme function                              |
| plotInt  | 10^3     | Interval in which data is gathered for ploting and showing progress |
| canDraw  | false    | Turns on temperature and objective function ploting                 |
| progress | false    | Turns on progress printing during solving                           |

At the end of the execution the program returns `(time, iterations, solved)`, where time is the
total execution time, iteration is how much iterations it took to solve the problem (up to maxIter) and
solved is a boolean value which tells if the problem was solved or not.

-------------

## License:

See LICENSE
