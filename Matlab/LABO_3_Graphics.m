%--------------------------------------------------------------------------
%
%                             Laboratory 3
%                         
%                         Verification of alpha(m)
%
%--------------------------------------------------------------------------
% @ Victor Mangeleer
% @ Arnaud Rémi
%
% Experimental results
m     = [0.28, 0.4917, 0.7221, 0.9489, 1.2271, 1.4515, 1.7060];
alpha = [17.4249, 28.442, 41.41, 49.0338, 54.7, 58.8, 63.79];

% Theoretical
k = 0.0002113;
g = 9.81;
l = 0.049;
alpha_vec = (0:0.1:pi/2);

% Graphics
plot(2*k*alpha_vec./(g*l*cos(alpha_vec))*1000, alpha_vec*360/(2*pi));
hold on;
plot(m, alpha, 'o');
xlim([0.28, 1.7])
yline(60)
xlabel("mass [g]");
ylabel("alpha [°]");
grid minor;
legend(["Theoretical", "Experimental"])

