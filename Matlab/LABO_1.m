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
          21    21.6  21.4  21.2  20.5;];

% Critical angle [°]
Alpha = [12   12   13   13   13;
         14.5 12.5 14   14.5 14;
         19   16.5 17   15   15;
         20.5 16   17.5 19   17;
         32   28   25   26   27] * 2;

%--------------------------------------------------------------------------
%                            Data Processing 
%--------------------------------------------------------------------------
% Mean volume of the droplet [uL]
V_mean = mean(V_real, 2);

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
%------------
%   Volume
%------------
FIG_volume = figure(1);
set(FIG_volume, 'defaulttextinterpreter','latex');
errorbar(V_mean, Alpha_mean, Alpha_std, Alpha_std, V_std, V_std, 'o', ...
         'color', [1, 0, 0], 'markersize', 6, 'LineWidth', 1);
xlabel('$V_{mean}$ [$\mu L$]');
ylabel('$\alpha_{critical}$ [$^{\circ}$]');
set(gca, 'fontsize', 24, 'fontname', 'Times', 'LineWidth', 0.5);
grid on;


%------------
%   Radius
%------------
FIG_radius = figure(2);
set(FIG_radius, 'defaulttextinterpreter','latex');
errorbar(R_mean, Alpha_mean, Alpha_std, Alpha_std, R_std, R_std, 'o', ...
         'color', [1, 0, 0], 'markersize', 6, 'LineWidth', 1);
xlabel('$R_{mean}$ [$mm$]');
ylabel('$\alpha_{critical}$ [$^{\circ}$]');
set(gca, 'fontsize', 24, 'fontname', 'Times', 'LineWidth', 0.5);
grid on;









    