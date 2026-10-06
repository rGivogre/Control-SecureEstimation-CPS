function [nu_sso, G] = initVar(D)

q = size(D, 1);                % Number of sensors (15)

G = [D eye(q)];
G = normalize(G);

nu_sso = (norm(G, 2))^-2;      % Calculate nu for SSO algorithm

end