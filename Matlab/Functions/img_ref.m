%--------------------------------------------------------------------------
%                            Image reference
%--------------------------------------------------------------------------
% @ Victor Mangeleer
% @ Arnaud Rémi
%
function ref_value = img_ref(bkg, ref)
%--------------
% Documentation
%--------------
% Process the reference image and determine the number of 
% pixels per cm^2 where:
%
% - bkg : path to the background
% - ref : path to the reference image
%
background   = imread(bkg);
ref_shaped = imread(ref);
 
% Substracting images (in absolute value)
image = abs(background - ref_shaped);

% Converting to gray scale
image = im2gray(image);

% Keeping gray values over threshold
image = image > 40;

% Filtering the noise
image = imfilter(image, ones(15, 15)/(15 * 15));

% Determine the reference value
ref_value = nnz(image);

end