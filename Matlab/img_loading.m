%--------------------------------------------------------------------------
%                             Image loading
%--------------------------------------------------------------------------
% @ Victor Mangeleer
% @ Arnaud Rémi
%
%--------------
% Documentation
%--------------
% Retreive the name of all the pictures, backgrounds, reference and paths
S_raw_name = {dir("../Experiments/Initial/Surface_raw/").name};
S_raw   = "../Experiments/Initial/Surface_raw/";
S_save  = "../Experiments/--|--/Surface_shaped/";
S_final = "../Experiments/Final/Surface_processed/";

C_raw_name = {dir("../Experiments/Initial/Curvature_raw/").name};
C_raw   = "../Experiments/Initial/Curvature_raw/";
C_save = "../Experiments/--|--/Curvature_shaped/";
C_final = "../Experiments/Final/Curvature_processed/";

S_ref_name = "../Experiments/Initial/Surface_bkg_ref/Reference.jpg";
S_ref_save = "../Experiments/--|--/Surface_bkg_ref_shaped/Reference.jpg";

S_bkg_name = "../Experiments/Initial/Surface_bkg_ref/Background.jpg";
S_bkg_save = "../Experiments/--|--/Surface_bkg_ref_shaped/Background.jpg";

C_bkg_name = "../Experiments/Initial/Curvature_bkg/Background.jpg";
C_bkg_save = "../Experiments/--|--/Curvature_bkg_shaped/Background.jpg";

% Removing useless files
S_raw_name = S_raw_name(~strncmp(S_raw_name, '.', 1));
C_raw_name = C_raw_name(~strncmp(C_raw_name, '.', 1));