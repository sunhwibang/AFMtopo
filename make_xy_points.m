function [make_x_point, make_y_point] = make_xy_points( temp_coordinates, number_point )
%% make_xy_point generates points along the coordinates selected using ginput

% find the linear equation between two points
coefficients = polyfit( temp_coordinates(:,1), temp_coordinates(:,2), 1);
a = coefficients(1); % slope
b = coefficients(2); % y-intercepts

% define an anonymous function using slope and y-intercept.
find_y = @(x) a*x + b;

% generate the data points using the anonymous function.
% note that make_x_point and make_y_point are in the indexed coordinate.
make_x_point = linspace( temp_coordinates(1,1) , temp_coordinates(2,1), number_point);
make_y_point = find_y( make_x_point );

end

