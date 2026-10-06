clear all; clc


addpath("functions");
run("config.m");

% Start the run

nu_sso = initVar(C);

% Execute SSO algorithm that returns the metrics of the run 
[x_err_sso, a_err_sso] = sso(x0, a, C, A, lambda, nu_sso, max_iterations);

% Execute D-SSO algorithm and returns the metrics of the run
[x_err_dsso, a_err_dsso] = dsso(x0, a, C, A, lambda, nu_dsso, max_iterations);


% Plot: State Estimation error 
figure(1);
loglog(1:max_iterations, x_err_dsso, 'Color', [1, 0.5, 0], 'LineWidth', 1); hold on;
loglog(1:max_iterations, x_err_sso, 'b', 'LineWidth', 1);
xlabel('Iterations');
ylabel('Relative state error');
legend('D-SSO', 'SSO');
title('State estimation error - D-SSO vs SSO');
grid on;

% Plot: Support Attack error 
figure(2);
semilogx(1:max_iterations, a_err_dsso, 'Color', [1, 0.5, 0], 'LineWidth', 1); hold on;
semilogx(1:max_iterations, a_err_sso, 'b', 'LineWidth', 1);
xlabel('Iterations');
ylabel('Support attack error');
legend('D-SSO', 'SSO');
title('Support attack error - D-SSO vs SSO');
grid on;