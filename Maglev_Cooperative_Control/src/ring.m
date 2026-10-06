%% Topology - Ring

Adj = [
    0 1 0 0 0 1;
    1 0 1 0 0 0;
    0 1 0 1 0 0;
    0 0 1 0 1 0;
    0 0 0 1 0 1;
    1 0 0 0 1 0;
    ];

D_in = diag([2 2 2 2 2 2]);

G = diag([1 0 0 0 0 0]);

L = D_in - Adj;