function [nu_sso] = initVar(C)

q = size(C, 1);                    % Number of sensors 

G = [C eye(q)];
nu_sso = 0.99/(norm(G, 2)^2);      % Calculate nu for D-SSO algorithm

end