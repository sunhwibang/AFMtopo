function [left_half_index, right_half_index, dihedral_angle] = find_angle(scaled_distance, estimate_z, min_z_index, left_top_index, right_top_index)
% find_angle calculates the dihedral angle between half of left top point
% and minimum point, 

% find the half length from the minimum point
left_half_index = floor( (min_z_index + left_top_index)/2 );
right_half_index = ceil( (min_z_index + right_top_index)/2 );

% find the dihedral angle of left and right side:
adjacent = abs(estimate_z(left_half_index) - estimate_z( min_z_index));
opposite = abs(scaled_distance( min_z_index) - scaled_distance(left_half_index));
left_angle = atand( opposite/adjacent );

adjacent = abs(estimate_z(right_half_index) - estimate_z( min_z_index));
opposite = abs(scaled_distance( right_half_index) - scaled_distance(min_z_index));
right_angle = atand( opposite/adjacent );

dihedral_angle = left_angle + right_angle;


end

