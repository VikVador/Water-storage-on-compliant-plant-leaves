%--------------------------------------------------------------------------
%                            Image Analysis
%--------------------------------------------------------------------------
% @ Victor Mangeleer
% @ Arnaud Rémi
%
function [alpha_low, alpha_high, alpha_mean] = image_analysis(images)

% Retrieving the number of images
SIZE = size(images);

% Loop over each images
for i = 1 : SIZE(1)
    
    % convers images into a binary matrix
    image_binary = imread(images);    
    image_binary(find(image_binary < 0.5 * max(image_binary))) = 0;
    image_binary = imcrop(image_binary);
        
    % --------------
    % Find dy and dx
    % --------------
    [n_rows, n_coll] = size(image_binary);
    for j = 1 : n_coll
        if ~isempty( find(image_binary(:,j) ~= 0) )
            % low : looking at the bottom of the leaf
            y_low(j) = max( find(image_binary(:,j) ~= 0) );
            
            % high : looking at the top of the leaf
            y_high(j) = min( find(image_binary(:,j) ~= 0) );
        else
            y_low(j) = NaN;
            y_high(j) = NaN;
        end
        x(j) = 0;
        if ~isempty(  find(image_binary(:,j) ~= 0) );
            x(j) = j;
        end
    end
    
    ymin_low = min(y_low);
    ymax_low = max(y_low);
    ymin_high = min(y_high);
    ymax_high = max(y_high);
    
    dy_low = ymin_low - ymax_low;
    dy_high = ymin_high - ymax_high; 
    dx = max(find(x ~= 0)) - min(find(x ~= 0));

    % computing the corresponding angles (outputs)
    alpha_high(i) = atan(dy_high/dx);
    alpha_low(i) = atan(dy_low/dx);
    alpha_mean(i) = 0.5 * (alpha_high + alpha_low);
end

end