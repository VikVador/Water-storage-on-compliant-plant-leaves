%--------------------------------------------------------------------------
%                            Image reference
%--------------------------------------------------------------------------
% @ Victor Mangeleer
%
function A_cm_sq = img_ref(ref)
%--------------
% Documentation
%--------------
% Determine the number of pixels per cm^2
%
% - ref      : reference image
%
A_cm_sq = nnz(ref);