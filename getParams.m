function params = getParams(params)

params.nvarpernode = params.nstates+params.ncontrols;   %number of variables per node
params.N = params.NSU*params.NperSU;                    %total number of nodes
params.h = params.T/(params.NperSU-1);                  %timestep

params.nvarperSU = params.nvarpernode*params.NperSU;    %number of variables per swing up
params.nvars = params.nvarpernode*params.N+2;           %Total number of optimization variables
params.nconSU1 = params.nstates*params.NperSU;          %Number of constraints in the first swingup
params.nconperSU = (params.ncontrols+params.nstates)*params.NperSU; %Number of constraints in all other swingups
params.ncon = params.nconSU1+(params.NSU-1)*params.nconperSU+2; % Total number of constraints
