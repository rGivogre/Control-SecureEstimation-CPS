close all
clear all
clc

addpath("functions");
run("config.m");

% Start the run

[nu_sso, G] = initVar(D);

% Execute SSO algorithm that returns the metrics of the run 
[x_err_sso, a_err_sso] = sso(xtrue0, atrue, y, G, A, lambda, nu_sso, time_stamps);

% Execute D-SSO algorithm and returns the metrics of the run
[x_err_dsso, a_err_dsso] = dsso(xtrue0, atrue, y, G, A, lambda_dsso, nu_dsso, time_stamps);


% Plot: Support State error 
figure(1);
plot(1:time_stamps, x_err_sso, 'b', 'LineWidth', 1);
xlabel('Time step');
ylabel('Support State error');
title('Support State error - SSO');
grid on;

% Plot: Support Attack error 
figure(2);
plot(1:time_stamps, a_err_sso, 'b', 'LineWidth', 1);
xlabel('Time step');
ylabel('Support Attack error');
title('Support Attack error - SSO');
grid on;

% Plot: Support State error 
figure(3);
plot(1:time_stamps, x_err_dsso, 'b', 'LineWidth', 1);
ylim([0, max(x_err_dsso)]);
xlabel('Time step');
ylabel('Support State error');
title('Support State error - DSSO');
grid on;

% Plot: Support Attack error 
figure(4);
plot(1:time_stamps, a_err_dsso, 'b', 'LineWidth', 1);
ylim([0, max(a_err_dsso)]);
xlabel('Time step');
ylabel('Support Attack error');
title('Support Attack error - DSSO');
grid on;