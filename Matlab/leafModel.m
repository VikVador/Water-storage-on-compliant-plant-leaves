%% ------------------------------
%  Personnal Experimental Project
%  ------------------------------
% @ Victor Mangeleer
% @ Arnaud Remi
%
% Documentation :
%     This script finds the relationship between the mass of a leaf and
%     its inclination angle.
%     Below the critical inclination angle, the mass is expected to
%     follow a linear law in time. Thus, this relationship can be expres-
%     sed with respect to the time.

clear all, close all

%% Global parameters
global k g m_0 L Q rho alpha_0
g = 9.81;    % [m/s^2]
L = 0.07;     % [m]
m_0 = 0.00025; % [kg]
Q = 1e-6;    % [m^3/s]
rho = 1000;  % [kg/m^3]
alpha_0 = 0.01; % [rad] -----> TO BE CHANGED, CREATE A FUNCTION get_alpha0()
               %              with image processing
k = get_stiffness(alpha_0, m_0, L);  % [N.m]

%% Solving momentum equations
t = 0:0.01:60; % [s]
alpha = zeros(size(t)); % [rad]
m = m_0 + rho * Q .* t; % [kg]
for i = 1 : length(t)
    F = @(x) [-k * x + m(i) * g * L * cos(x) / 2];
    options = optimoptions('fsolve','Display','none');
    alpha(i) = fsolve(F, [0], options);
end

%% Plots
figure;
plot(t, abs(alpha), 'k', 'Linewidth', 1.5);
grid on;
xlabel('$t$ [s]', 'Fontsize', 14, 'Interpreter', 'latex');
ylabel('$\alpha$ [rad]', 'Fontsize', 14, 'Interpreter', 'latex');
ylim([0 pi/2]);
yticks([0 pi/4 pi/2]);
yticklabels({'0', '\pi/4', '\pi/2'});
set(gca,'fontsize',16);

figure;
plot(m, abs(alpha), 'k', 'Linewidth', 1.5);
grid on;
xlabel('$m$ [kg]', 'Fontsize', 14, 'Interpreter', 'latex');
ylabel('$\alpha$ [rad]', 'Fontsize', 14, 'Interpreter', 'latex');
ylim([0 pi/2]);
yticks([0 pi/4 pi/2]);
yticklabels({'0', '\pi/4', '\pi/2'});
xlim([m(1) m(end)]);
set(gca,'fontsize',16);