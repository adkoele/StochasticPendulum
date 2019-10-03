# StochasticPendulum
MATLAB code to solve stochastic inverted pendulum problem

In main.m, the number of swing ups can be set. 

The function runOPT performs the optimizations. In this function most other parameters are set, such as the pendulum dimension and weight and the number of collocation points.
This function solves the series of problems as explained in the supplementary file.

The function Optimize contains the settings used in the optimization in IPOPT.

objfun, objgrad, confun, and conjac contain the objective function, objective gradient, constraint function and constraint Jacobian

getIniConBound defines the initial guess and the lower and upper bound.

plotresult plots the result of an optimization.
