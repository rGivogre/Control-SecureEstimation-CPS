close all
clear all
clc

%% Choose the Topology
topology = 3;       % [0: chain, 1: ring, 2: star, 3: mesh, 4: fully connected]

switch topology
    case 0
        run("chain.m");
    case 1
        run("ring.m");
    case 2
        run("star.m");
    case 3
        run("mesh.m")
    case 4
        run("fullyConnected.m");
    otherwise
        error('Invalid topology choice. Choose between: [0: chain, 1: ring, 2: star, 3: mesh, 4: fully connected].');
end

%% System dynamics

A = [0, 1; 880.87, 0];
B = [0; -9.9453];
C = [708.27 0];
D = 0;

%% Control of the leader dynamics

% Choice of the desired leader reference (step/ramp/sin)
scelta = 'step';        

switch lower(scelta)
    case 'step'
        eigs = [0, -1]; 
        K0 = place(A, B, eigs);
    case 'ramp'
        eigs = [0, 0];
        K0 = acker(A, B, eigs);
    case 'sin'
        eigs = [+j, -j];
        K0 = place(A, B, eigs);
    otherwise
        error('Invalid reference. Choose between: step, ramp, sin.');
end

% Leader matrices
A0 = A;
B0 = B;
C0 = [C; eye(2)];
D0 = zeros(3, 1);

%% OBSV - Leader
L1=place(A',C',[-2 -1])';

A0_obv = A-L1*C;
B0_obv = [L1 B];
C0_obv = eye(2);
D0_obv = zeros(2);

%% Design - K
% design by me, must be positive and diag
Q = eye(2);
R = 100;

P = are((A-B*K0),B*inv(R)*B',Q); 

K = inv(R)*B'*P; 

%% Design - c

lambda = eig(L+G);
real_parts = real(lambda);               
min_real = min(real_parts(real_parts > 0)); 

c_minimum = 1/(2 * min_real);       % Minimum value needed for c
c = c_minimum;

%% Design - F

Q = 10*eye(2);
R = 1;

P2 = are((A-B*K0)',C'*inv(R)*C,Q); 

F = P2*C'*inv(R);

%% local OBSV - Agents 
F1 = place((A-B*K0)',C',[-1 -2])';

Aa_obv = (A-B*K0)-c*F1*C;
Ba_obv = [B c*F1];
Ca_obv = eye(2);
Da_obv = zeros(2);