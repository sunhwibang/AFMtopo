function [scaled_distance, min_z_index, left_top_index, right_top_index ] = find_top( temp_coordinates, estimate_z, slope_threshold )
%% find_top locates the top and minimum

number_point = length( estimate_z );

% compute the scaled_distance matching with the dimension of AFM dimension.
scaled_distance = linspace( 0 , (2500/1024)*abs( diff( temp_coordinates(:,1))), number_point );

% find the derivative of z
for i = 1 : number_point-1
    diff_z(i) = ( estimate_z( i + 1) - estimate_z(i)) / (scaled_distance( i + 1) - scaled_distance(i));
end

% find the index and value of the local minimum
min_z_value = min( estimate_z );
min_z_index = find( estimate_z == min_z_value );

% find the top of the particle based on the derivative thresholding
% left side
left_scaled_distance = flip(scaled_distance(1 : find( estimate_z == min( estimate_z))));
left_z = flip( estimate_z(1 : find( estimate_z == min(estimate_z))));

% mapping between flip index to original index
left_index = [ find( estimate_z == min(estimate_z)) : -1 : 1 ];

% find the first index that satisfies the slope threshold
left_satisfying_index = find( abs( diff(left_z) < slope_threshold ) );

% check whether the satisfying index does not exist
    while isempty(left_satisfying_index) == 1
        break
    end
    
left_satisfying_index = left_satisfying_index(1);

left_top_index = left_index( left_satisfying_index );

left_top_x = scaled_distance( left_index( left_satisfying_index ));
left_top_z = estimate_z( left_index( left_satisfying_index));

% right side
right_scaled_distance = scaled_distance( find( estimate_z == min( estimate_z )): end);
right_z = estimate_z(find( estimate_z == min(estimate_z)) : end);
right_index = [ find( estimate_z == min(estimate_z)) : 1 : length( scaled_distance) ];
right_satisfying_index = find( abs( diff(right_z) < slope_threshold ) );

% check whether the satisfying index does not exist
    while isempty(right_satisfying_index) == 1
       break;   
    end
pause;    
    
right_satisfying_index = right_satisfying_index(1);

right_top_index = right_index( right_satisfying_index );

right_top_x = scaled_distance( right_index( right_satisfying_index ));
right_top_z = estimate_z( right_index( right_satisfying_index));

end

