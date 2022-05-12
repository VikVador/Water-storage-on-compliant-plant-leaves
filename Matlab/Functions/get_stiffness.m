function [k] = get_stiffness(alpha, m, L_tilde, g)
% get_stiffness returns the stiffness of a torsion spring
% --- get_stiffness(alpha, m, L)    --> g is set as 9.81 [m/s^2]
% --- get_stiffness(alpha, m, L, g) --> g is tunable
% ----[alpha] = rad
% ----[m]     = kg
% ----[L]     = m
% ----[g]     = m/s^2
%
% @ Victor Mangeleer
% @ Arnaud Remi

if nargin == 3
    g = 9.81;
end
k = abs(m * L_tilde * 0.001 * g * cos(alpha) / (alpha));

if ~isfinite(k)
    disp('Warning : infinite stiffness');
end

end