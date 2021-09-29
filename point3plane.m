function [estimate_z, estimate_z_error] = point3plane( make_x_point, make_y_point, data )
% point3place estimates the mean and standard deviation of z values.
% input make_x_point and make_y_point are in the 
% reduced indexed coordinates (0 ~ 1023)
% input data is in the indexed coordinates

for i = 1 : length(make_x_point)
    x_point = make_x_point(i);
    y_point = make_y_point(i);
    
    % find the integer values of near values using floor and ceil function.
    list_x_point = [ floor(x_point), ceil(x_point), floor(x_point), ceil(x_point), floor(x_point), ceil(x_point), floor(x_point), ceil(x_point) ];
    list_y_point = [ floor(y_point), ceil(y_point), ceil(y_point), floor(y_point), floor(y_point), ceil(y_point), ceil(y_point), floor(y_point) ];

    % estimate z (height) based on 4 points on the index coordinates.
        for j = 1:4
        % a_point = [ list_x_point(j), list_y_point(j), data( list_y_point(j) + 1, list_x_point(j) + 1) ];
        % b_point = [ list_x_point(j+1), list_y_point(j+1), data( list_y_point(j+1) + 1, list_x_point(j+1) + 1) ];
        % c_point = [ list_x_point(j+2), list_y_point(j+2), data( list_y_point(j+2) + 1, list_x_point(j+2) + 1) ];
        
        a_point = [ list_x_point(j), list_y_point(j), data( list_y_point(j) , list_x_point(j) ) ];
        b_point = [ list_x_point(j+1), list_y_point(j+1), data( list_y_point(j+1) , list_x_point(j+1) ) ];
        c_point = [ list_x_point(j+2), list_y_point(j+2), data( list_y_point(j+2) , list_x_point(j+2) ) ];
        
        % perform cross product to find the plane connecting abc points.
        abc_cross = cross( a_point - b_point, a_point - c_point );
        abc_cross = abc_cross./norm(abc_cross);

        % find an estimated value of z:
        find_z = @(x, y) ( sum( a_point .* abc_cross) - abc_cross(1)*x - abc_cross(2)*y )/abc_cross(3);

        temp_z(j)= find_z(x_point, y_point);
        end
    
    % output values
    estimate_z(i) = mean( temp_z );
    estimate_z_error(i) = std( temp_z );
    
    % reset temp_z
    temp_z = 0;
    
end

% make sure to add 1 for calling the data cell.

% check the values for the random 3 points out of 4:
% for i = 1:4
%     a_point = [ list_x_point(i), list_y_point(i), data( list_x_point(i) + 1, list_y_point(i) + 1 ) ];
%     b_point = [ list_x_point(i+1), list_y_point(i+1), data( list_x_point(i+1) + 1, list_y_point(i+1) + 1) ];
%     c_point = [ list_x_point(i+2), list_y_point(i+2), data( list_x_point(i+2) + 1, list_y_point(i+2) + 1) ];
% 
%     abc_cross = cross( a_point - b_point, a_point - c_point );
% 
%     % find an estimated value of z:
%     find_z = @(x, y) ( sum( a_point .* abc_cross) - abc_cross(1)*x - abc_cross(2)*y )/abc_cross(3);
% 
%     test_x_point = mean(list_x_point) - 0.1;
%     test_y_point = mean(list_y_point) + 0.1;
%     
%     save_a_point(i,:) = a_point;
%     save_find_z(i)= find_z(test_x_point, test_y_point);
% end

%mean(save_find_z);
%std(save_find_z);



end

