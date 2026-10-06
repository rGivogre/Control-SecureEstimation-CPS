function [x_err, a_err] = dsso(x0, a, C, A, lambda, nu, max_iter)
% Implement the Deadbeat Sparse Soft Observer algorithm

[q, n] = size(C);                     % Number of sensors and State vector dimension      

x_hat = (zeros(n, 1));                % Initialise estimations, we can start from all zeros
a_hat = (zeros(q, 1));

x_err = (zeros(max_iter, 1));         % Initialise performance metrics arrays
a_err = (zeros(max_iter, 1));

desired_eigs = rand(n, 1) * 10^-10;
L = (place(A', C', desired_eigs))'; % Compute L, observer gain


x = x0;                             % Initial conditions of the dynamic system

C_copy = C;

for iter = 1:max_iter

    % Compute measurements of the dynamic system
    y = C_copy*x + a;      
    % Compute our estimates of the measurements
    y_hat = C_copy*x_hat + a_hat;    

    if iter == 1e3
        attacked_sensors = find(abs(a_hat) > 1e-1);  % threshold to detect attacks
        fprintf('Sensors under attack (detected at iter %d):\n', iter);
        disp(attacked_sensors);

        C_copy(attacked_sensors, :) = 0;
        L = (place(A', C_copy', desired_eigs))';
    end


    % Update the estimates of the state and attack vectors
    x_hat = A*x_hat - L*((y_hat - y));
    a_hat = soft_threshold(a_hat - nu*(y_hat - y), nu*lambda);

    x = A*x;                        % Update the state vector
    

    % Compute error on the state vector x and save it in a metric array (on index iter)
    x_err(iter) = norm(x_hat - x, 2)/norm(x, 2);
    
    % Compute support attack error and save it in a metric array (on index iter)
    a_true_attacked = double( abs(a) > 1e-1 );      
    a_hat_attacked = double( abs(a_hat) > 1e-1 );
    a_err(iter) = sum(abs(a_true_attacked - a_hat_attacked)); 
end

end