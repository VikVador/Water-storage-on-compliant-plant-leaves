%--------------------------------------------------------------------------
%                            Image processing
%--------------------------------------------------------------------------
% @ Victor Mangeleer
% @ Arnaud Rémi
%
function img_processing(bkg, img_shaped, img_processed, treshold, filter)
%--------------
% Documentation
%--------------
% Process the image for computation where:
%
% - bkg           : path to the background image
% - img_shaped    : path to the shaped image
% - img_processed : path to the processed image
% - trehsold : defines which part of the grayscale is conserved
% - filter   : defined the intensity of the filter over the image
%
% Loading the image and the background
background   = imread(bkg);
image_shaped = imread(img_shaped);
 
% Substracting images (in absolute value)
image = abs(background - image_shaped);

% Converting to gray scale
image = im2gray(image);

% Keeping gray values over threshold
image = image > treshold;

% Filtering the noise
image = imfilter(image, ones(filter, filter)/(filter * filter));

% Saving the processed image
imwrite(image, img_processed);

end
