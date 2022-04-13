%--------------------------------------------------------------------------
%                            Image processing
%--------------------------------------------------------------------------
% @ Victor Mangeleer
% @ Arnaud Rémi
%
function [alpha_low, alpha_mean, alpha_high, ...
          RMSE_low, RMSE_mean, RMSE_high] = img_alphas(image)
    %--------------
    % Documentation
    %--------------
    % Compute the low, mean and top value of the angle alpha using a
    % linear regression as well as the associated RMSE where:
    %
    % image = the image that has to be processed
    
    % Dimensions of the image
    [~, n_coll] = size(image);
    
    % Contains the different points used to compute linear regression
    x      = NaN(n_coll, 1);
    y_low  = NaN(n_coll, 1);
    y_mean = NaN(n_coll, 1);
    y_high = NaN(n_coll, 1);

    % Going through each column
    for j = 1 : n_coll

        % Checks if a portion of the leaf is visible in the column
        if ~isempty(find(image(:,j) ~= 0, 1))
    
            % Bottom of the leaf
            y_low(j)  = find(image(:,j) ~= 0, 1, 'last');

            % Top of the leaf
            for i = 1 : y_low(j) - 1
                    
                % Modified index
                k =  y_low(j) - i;

                if(image(k, j) == 1)
                    y_high(j) = k + 1;
                end
            end

            % Mean value
            y_mean(j) = (y_low(j) + y_high(j)) * 0.5;

            % Horizontal position
            x(j) = j;
        end
    end

    % Index of nan values (Fix size problem)
    x_low = x(~isnan(y_low));
    x_mean = x(~isnan(y_mean));
    x_high = x(~isnan(y_high));

    % Removing bad data (NaN)
    y_low = y_low(~isnan(y_low));
    y_mean = y_mean(~isnan(y_mean));
    y_high = y_high(~isnan(y_high));

    % Remove bad data
    x = x(~isnan(x));

    % Linear regression
    p_low = polyfit(x_low, y_low, 1);
    p_mean = polyfit(x_mean, y_mean, 1);
    p_high = polyfit(x_high, y_high, 1);

    % Predictions
    y_fit_low = polyval(p_low, x_low);
    y_fit_mean = polyval(p_mean,x_mean);
    y_fit_high = polyval(p_high, x_high);

    % Residuals
    y_residuals_low = y_low - y_fit_low;
    y_residuals_mean = y_mean - y_fit_mean;
    y_residuals_high = y_high - y_fit_high;

    % Mean square of the errors
    SSresid_low = mean(y_residuals_low.^2);
    SSresid_mean = mean(y_residuals_mean.^2);
    SSresid_high = mean(y_residuals_high.^2);

    % RMSE
    RMSE_low = sqrt(SSresid_low);
    RMSE_mean = sqrt(SSresid_mean);
    RMSE_high = sqrt(SSresid_high);

    % End values of horizontal axis
    x_start = find(x ~= 0, 1);
    x_end   = find(x ~= 0, 1, 'last');

    % Computing dy and dx
    dx = x_end - x_start;
    dy_low = polyval(p_low, x_start) - polyval(p_low, x_end);
    dy_mean = polyval(p_mean, x_start) - polyval(p_mean, x_end);
    dy_high = polyval(p_high, x_start) - polyval(p_high, x_end);
    
    % Computing the corresponding angles
    alpha_low  = atan(dy_low/dx);
    alpha_mean = atan(dy_mean/dx);
    alpha_high = atan(dy_high/dx);
end
