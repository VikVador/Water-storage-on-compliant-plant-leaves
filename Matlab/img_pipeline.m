%--------------------------------------------------------------------------
%                            Image pipeline
%--------------------------------------------------------------------------
% @ Victor Mangeleer
%
function image = img_pipeline(bkg, img, treshold, filter)
%--------------
% Documentation
%--------------
% Process the image for computation where:
%
% - Bkg      : Background image
% - Img      : Image to be processed
% - trehsold : defines which part of the grayscale is conserved
% - filter   : defined the intensity of the filter over the image
%
% Substracting images (in absolute value)
image = abs(bkg - img);

imshow(image);
waitforbuttonpress;

% Converting to gray scale
image = im2gray(image);

imshow(image);
waitforbuttonpress;

% Keeping gray values over threshold
image = image > treshold;

imshow(image);
waitforbuttonpress;

% Filtering the noise
image = imfilter(image, ones(filter, filter)/(filter * filter));

imshow(image);
waitforbuttonpress;
