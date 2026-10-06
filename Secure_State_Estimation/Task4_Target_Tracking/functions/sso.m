function [x_err, a_err] = sso(x0, a, y, G, A, lambda, nu, max_iter)
% Implement the Sparse Soft Observer algorithm

[rows, columns] = size(G);

q = rows;                           % Number of sensors (15)
n = columns - rows;                 % State vector dimension (36)

C = G(1:q, 1:n);
I_norm = G(1:q, n+1:n+q);
                  
x_hat = zeros(n, 1);                % Initialise our estimations to zero
a_hat = zeros(q, 1);        

x_err = zeros(max_iter, 1);         % Initialise performance metrics arrays
a_err = zeros(max_iter, 1);

x = x0;                             % Initial conditions of the dynamic system

for iter = 1:max_iter

    % Compute our estimates of the measurements
    y_hat = G*[x_hat; a_hat];
    
    % Update the estimates of the state and attack vectors
    x_hat = soft_threshold(A*x_hat - nu*A*(C')*(y_hat - y(:,iter)), nu*lambda);                        
    a_hat = soft_threshold(a_hat - nu*I_norm*(y_hat - y(:,iter)), nu*lambda);  

    % Update the true state
    x = A*x;

    % Compute support state error and save it in a metric array (on index iter)
    x_true_support = double( abs(x) >= 1 );
    x_hat_support = double( abs(x_hat) >= 1 );
    x_err(iter) = sum(abs(x_true_support - x_hat_support)); 

    % Compute support attack error and save it in a metric array (on index iter)
    a_true_attacked = double( abs(a) >= 1 );      
    a_hat_attacked = double( abs(a_hat) >= 1 );
    a_err(iter) = sum(abs(a_true_attacked - a_hat_attacked)); 
end

end