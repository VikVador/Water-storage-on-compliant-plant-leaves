%--------------------------------------------------------------------------
%                            Image processing
%--------------------------------------------------------------------------
% @ Victor Mangeleer
%
%--------------
% Documentation
%--------------
% This script has for purpose to process the images 
% before making any computation.
%
%
% 1 - File names
%---------------
Photos_names = {dir("Photos/").name};
Photos_names = Photos_names(~strncmp(Photos_names, '.', 1));

% 2 - Shaping the images
%-----------------------
for i = 1 : length(Photos_names)

    % Opening the image
    image = imread("Photos/" + Photos_names{i});

    % Resizing the image
    image = imresize(image , 0.5);

    % Cropping the image
    image = imcrop(image, [293.5 322.5 1532 1023]);

    % Saving the image
    imwrite(image, "Processed/" + Photos_names{i})
end

% 2 - Processing the images
%--------------------------
% Loading backgrounds, surface and reference
bkg_1 = imread("Processed/" + Photos_names{1});
sfr = imread("Processed/" + Photos_names{5});
bkg_2 = imread("Processed/" + Photos_names{1});
ref = imread("Processed/" + Photos_names{4});

imshow(sfr);
waitforbuttonpress;
imshow(ref);
waitforbuttonpress;

% Image processing
surface_img = img_pipeline(bkg_1, sfr, 40, 5);
ref_img = img_pipeline(bkg_2, ref, 40, 15);

% Showing results
imshow(surface_img);
waitforbuttonpress;
imshow(ref_img);

% 3 - Computing the reference
%----------------------------
ref_value = img_ref(ref_img);

% 4 - Computing the surface of the leaf
%--------------------------------------
surface = nnz(surface_img)/ref_value;

disp("The total surface of the leaf is : " + num2str(surface) + " cm^2");
















