%--------------------------------------------------------------------------
%
%                            Image shaping
%
%--------------------------------------------------------------------------
% @ Victor Mangeleer
% @ Arnaud Rémi
%
function img_shaping(img_raw, img_save, resize, crop)
    %--------------
    % Documentation
    %--------------
    % Shape the images before processing them where:
    %
    % img_raw  : path to the raw image
    % img_save : path to the save folder
    % resize   : resizing factor 
    % crop     : vertices of the rectangular crop box
    %
    % Opening the image
    img_shaped = imread(img_raw);

    % Resizing the image
    img_shaped = imresize(img_shaped , resize);
 
    % Cropping the image
    img_shaped = imcrop(img_shaped, crop);

    % Saving the image
    imwrite(img_shaped, img_save);
end