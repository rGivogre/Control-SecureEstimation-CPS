%% Topology - Fully Connected

Adj = [
    0 1 1 1 1 1;
    1 0 1 1 1 1;
    1 1 0 1 1 1;
    1 1 1 0 1 1;
    1 1 1 1 0 1;
    1 1 1 1 1 0;
    ];

D_in = diag([5 5 5 5 5 5]);

G = diag([1 0 0 0 0 0]);

L = D_in - Adj;