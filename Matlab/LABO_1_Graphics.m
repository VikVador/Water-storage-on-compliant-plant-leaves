%--------------------------------------------------------------------------
%
%                             Laboratory 1
%                         
%                         Evolution of alpha(R)
%
%--------------------------------------------------------------------------
% @ Victor Mangeleer
% @ Arnaud Rémi
%
clc;
clear all;
%--------------------------------------------------------------------------
%                              Measurements 
%--------------------------------------------------------------------------
% Volume of the droplet (Theoretical)  [uL]
V_th     = [60 50 40 30 20];

% Volume of the droplet (Experimental) [uL]
V_real = [60.5  60.8  60.2  61.2  62.1;
          50.9  51.3  50.7  51    50.9;
          41.8  40.5  41.1  41.5  40.9;
          32    30.7  31.7  30.9  30.3;
          25.8  26.7  26.1  26.1  26.3;
          21    21.6  21.4  21.2  20.5;
          15.7  16.3  15.8  16.2  16.5;
          13    13.5  12.7  12.6  13.3];

% Critical angle [°]
Alpha = [12   12   13   13   13;
         14.5 12.5 14   14.5 14;
         19   16.5 17   15   15;
         20.5 16   17.5 19   17;
         25   21.5 24.5 27   23.5;
         32   28   25   26   27;
         45   38   35   45   45;
         45   45   45   45   45;] * 2;

%--------------------------------------------------------------------------
%                            Data Processing 
%--------------------------------------------------------------------------
% Mean volume of the droplet [uL]
V_mean = mean(V_real, 2);

% Last value of the volume measured
V_seuil = V_mean(end);

% Standard deviation volume of the droplet [uL]
V_std = std(V_real, 0, 2);

% Mean critical angle [°]
Alpha_mean = mean(Alpha, 2);

% Standard deviation critical angle [°]
Alpha_std = std(Alpha, 0, 2);

% Radius of the droplet (Theoretically) [mm]
R_th = ( V_th * (3/4) * (1/pi) ).^(1/3);

% Mean radius of the droplet [mm]
R_mean = ( V_mean * (3/4) * (1/pi) ).^(1/3);

% Standard deviation radius of the droplet [mm]
R_std = ( V_std * (3/4) * (1/pi) ).^(1/3);

%--------------------------------------------------------------------------
%                       Graphical Representation
%--------------------------------------------------------------------------
clf;

% Figure pigment color
pigment_color = [0.0, 0.65, 0.31];

%---------------------
%      Version 1
%---------------------
FIG_volume = figure(1);
set(FIG_volume, 'defaulttextinterpreter','latex');
errorbar(V_mean, Alpha_mean, Alpha_std, Alpha_std, V_std, V_std, 'o', ...
         'color', pigment_color, 'CapSize', 4, 'markersize', 6, 'LineWidth', 1.2);
xlabel('$V$ [$\mu$L]');
ylabel('$\alpha_{\star}$ [$^{\circ}$]');
set(gca, 'fontsize', 18, 'fontname', 'Times', 'LineWidth', 0.5);
grid on;


%---------------------
%      Version 2
%---------------------
B = -1:0.001:1;

err_min = inf;

index = 0;

% Knowing that alpha = 90 * exp(B*V), this loop
% finds B such that the error is minimized with 
% the data
for i = 1 : length(B)
    a = 90 * exp(B(i) * (V_mean - V_seuil* ones(length(V_mean), 1)));

    % mean squared error
    err = immse(a, Alpha_mean);
    if(err < err_min || isnan(err_min))
        err_min = err;
        index = i;
    end
    
end

V = 0:0.1:80;
alpha_opt = exp(B(index) * (V - V_seuil* ones(1, length(V)))) * exp(log(90));
Asymptot = 90 * ones(1, length(V));
for i = 1 : length(V)
   if V(i) < V_seuil
       alpha_real(i) = 90;
   else
       alpha_real(i) = alpha_opt(i);
   end
end
hold on;
plot(V, alpha_opt, '--k', 'linewidth', 0.5);
plot(V, Asymptot , '--k', 'linewidth', 0.5);
plot(V, alpha_real, '-k', 'linewidth', 1);
xlim([0 65]);
ylim([0 98]);
FIG_volume2 = figure(2);
set(FIG_volume2, 'defaulttextinterpreter','latex');
errorbar(V_mean, Alpha_mean, Alpha_std, Alpha_std, V_std, V_std, 'o', ...
         'color', pigment_color, 'CapSize', 0, 'markersize', 6, 'LineWidth', 1.2);
xlabel('$V$ [$\mu$L]');
ylabel('$\alpha_{\star}$ [$^{\circ}$]');
set(gca, 'fontsize', 18, 'fontname', 'Times', 'LineWidth', 0.5);
grid on;
hold on;
plot(V, alpha_opt, '--k', 'linewidth', 0.5);
plot(V, Asymptot , '--k', 'linewidth', 0.5);
plot(V, alpha_real, '-k', 'linewidth', 1);
ylim([0 100]);




%---------------------
%      Version 3
%---------------------
A = 0:0.000001:0.1;

err_min = inf;

index = 0;

% Knowing that alpha = 90 * exp(B*V), this loop
% finds B such that the error is minimized with 
% the data
for i = 1 : length(A)
    a_inv = A(i) * V_mean + (1/90 - 13*A(i));

    % mean squared error
    err = immse(1./a_inv, Alpha_mean);
    if(err < err_min || isnan(err_min))
        err_min = err;
        index = i;
        1./a_inv;
    end
    
end
A(index);
V = 0:0.1:80;
alpha_opt_2 = 1./( A(index)*V + (1/90 - 13 * A(index)) );

for i = 1 : length(V)
   if V(i) < V_seuil
       alpha_real(i) = 90;
   else
       alpha_real(i) = alpha_opt_2(i);
   end
end


FIG_volume3 = figure(3);
set(FIG_volume3, 'defaulttextinterpreter','latex');
errorbar(V_mean, Alpha_mean, Alpha_std, Alpha_std, V_std, V_std, 'o', ...
         'color', [0.898, 0.5843, 0], 'CapSize', 4, 'markersize', 6, 'LineWidth', 1.2);
xlabel('$V$ [$\mu$L]');
ylabel('$\alpha_{\star}$ [$^{\circ}$]');
set(gca, 'fontsize', 18, 'fontname', 'Times', 'LineWidth', 0.5);
grid on;
hold on;
plot(V, alpha_real, '-k', 'linewidth', 1);
legend('Experimental', 'Inverse regression', 'fontsize', 16)
plot(V, alpha_opt_2, '--k', 'linewidth', 0.5);
plot(V, Asymptot , '--k', 'linewidth', 0.5);
ylim([10 100]);
xlim([10 70]);
