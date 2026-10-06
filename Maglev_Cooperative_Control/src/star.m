%% Topology - Star

Adj = [
    0 1 1 1 1 1;
    1 0 0 0 0 0;
    1 0 0 0 0 0;
    1 0 0 0 0 0;
    1 0 0 0 0 0;
    1 0 0 0 0 0;
    ];

D_in = diag([5 1 1 1 1 1]);

G = diag([1 0 0 0 0 0]);

L = D_in - Adj;