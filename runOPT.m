function allresults = runOPT(NSU)

% Declare parameters
params.m = 5;                   %weight
params.l = 1.2;                 %length
params.g = 9.81;                %gravity
params.T = 10;                  %Duration of motion
params.targetangle = pi/2;      %The final angle of the trajectory

params.nstates  = 2;    %Number of states in the dynamic system
params.ncontrols= 1;    %Number of controls

params.NperSU = 60;     %Number of collocation nodes
params.NSU = 1;         %Start with one swingup

params.solver = 'IPOPT'; %Solved using IPOPT

params = getParams(params);                     %Do some bookkeeping on number of constraints and optimization variables
params.omega = zeros(params.nstates,params.N);  %This is the noise vector, initially zeros

[X0, L, U] = getIniConBound(params);            %Get initial guess and bounds

[~, params] = conjacstructure(L, U, params);    %Find structure of constraint jacobian, necessary for IPOPT

%First result witout noise for desired trajectory
result1 = Optimize(X0, L, U, params);

% Now add more swingups and noise
params.NSU = NSU;
params = getParams(params);
params.omega = 0.001*randn(params.nstates,params.N);

[X0, L, U] = getIniConBound(params, result1); %Use previous result as initial guess
[~, params] = conjacstructure(L, U, params);
result2 = Optimize(X0, L, U, params);

% More noise
X0 = result2.X;
params.omega = 0.01*randn(params.nstates,params.N); %Added noise
[~, params] = conjacstructure(L, U, params);
result3 = Optimize(X0, L, U, params);

X0 = result3.X;
params.omega = 0.05*randn(params.nstates,params.N); %Added noise
[~, params] = conjacstructure(L, U, params);
result4 = Optimize(X0, L, U, params);

X0 = result4.X;
params.omega = 0.1*randn(params.nstates,params.N); %Added noise, low pass filtered
[~, params] = conjacstructure(L, U, params);
result5 = Optimize(X0, L, U, params);

X0 = result5.X;
params.omega = 0.5*randn(params.nstates,params.N); %Added noise, low pass filtered
[~, params] = conjacstructure(L, U, params);
result6 = Optimize(X0, L, U, params);

X0 = result6.X;
params.omega = 1*randn(params.nstates,params.N); %Added noise, low pass filtered
[~, params] = conjacstructure(L, U, params);
result = Optimize(X0, L, U, params);

allresults(1) = result1;
allresults(2) = result2;
allresults(3) = result3;
allresults(4) = result4;
allresults(5) = result5;
allresults(6) = result6;
allresults(7) = result;