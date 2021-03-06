function [X, L, U] = getIniConBound(params, result)

% Bounds on x and u for each node
Lpernode = [-3*pi;-1000;-10000];
Upernode = [2*pi;1000;10000]; 

LperSU = [];
UperSU = [];
for i = 1:params.NperSU %repeat fo reach collocation node in the swingup
    LperSU = [LperSU;Lpernode];
    UperSU = [UperSU;Upernode];
end

L = [];
U = [];
for i = 1:params.NSU %repeat for each swingup
    L = [L;LperSU];
    U = [U;UperSU];
end

if nargin == 1
    L = [L;0;0]; %K and Kd
    U = [U;0;0];
else
    L = [L;0;0];
    U = [U;10;10];
end

if nargin == 1 %Mid or random initial guess
    X = 1/2*(L+U);
%     X = L+(U-L).*rand(size(L));
    X(end-1) = 0;
    X(end) = 0;
else %Repeat previous solution and use as initial guess
    X = [];
    for i = 1:params.NSU
        X = [X;result.X(1:result.params.nvarperSU)];
    end
    X = [X;result.X(end-1:end)];  
end

    