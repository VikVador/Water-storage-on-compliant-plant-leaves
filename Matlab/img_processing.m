%--------------------------------------------------------------------------
%                            Image processing
%--------------------------------------------------------------------------
% @ Victor Mangeleer
% @ Arnaud Rémi
%
function img_processing(bkg, img_shaped, img_processed, treshold, filter, debug)
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
if debug == 1
    imshow(image);
    waitforbuttonpress;
end

% Converting to gray scale
image = im2gray(image);
if debug == 1
    imshow(image);
    waitforbuttonpress;
end

% Keeping gray values over threshold
image = image > treshold;
if debug == 1
    imshow(image);
    waitforbuttonpress;
end

% Filtering the noise
image = imfilter(image, ones(filter, filter)/(filter * filter));
if debug == 1
    imshow(image);
    waitforbuttonpress;
end

% Saving the processed image
imwrite(image, img_processed);

end
