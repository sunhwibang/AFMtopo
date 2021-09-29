function [ top_top_distance , dihedral_angle, height_info, top_position ] = find_angle_manually( temp_coordinates , estimate_z )
% find_angle_manually selects the two top points manually then calculates
% the dihedral angle.


% compute the scaled_distance matching with the dimension of AFM dimension.
number_point = length( estimate_z );
% scaled_distance = linspace( 0 , (2500/1024)*abs( diff( temp_coordinates(:,1))), number_point );
% resolution between index coordinate to physical coordinate.
resolution = 2500 / 2014;
scaled_distance = linspace( 0 , resolution*pdist( temp_coordinates, 'euclidean'), number_point );

% find the derivative of z
for i = 1 : number_point-1
    diff_z(i) = ( estimate_z( i + 1) - estimate_z(i)) / (scaled_distance( i + 1) - scaled_distance(i));
end

% find the index and value of the local minimum
min_z_value = min( estimate_z );
min_z_index = find( estimate_z == min_z_value );

%% show the estimated topo and minimum point
fig = figure(2)
plot( scaled_distance, estimate_z )
hold on
% show the minimum point
plot( scaled_distance( min_z_index ), estimate_z( min_z_index), '*')
hold off

% enable data cursor mode
datacursormode on
dcm_obj = datacursormode(fig);
position_threshold = 0.00005;

% select the two top points
for i = 1:2
    % set update function
    set( dcm_obj, 'UpdateFcn', @myundatefcn );

    % Wait while the user to click
    disp( 'select top point, then press any key to continue' )
    pause
    info_struct(i) = getCursorInfo( dcm_obj );

    if isfield( info_struct, 'Position' )
        disp( info_struct(i).Position );
    end
    
    % find the index of the top point 
    top_x_index(i) = find( scaled_distance < info_struct(i).Position(1) + position_threshold & ...
                         scaled_distance > info_struct(i).Position(1) - position_threshold );              
                     
    % plot the point one point to the minimum point
    hold on
    plot( scaled_distance(top_x_index(i)), estimate_z( top_x_index(i)), 'o');
end
hold off

left_top_index = top_x_index(1);
right_top_index = top_x_index(2);

[left_half_index, right_half_index, dihedral_angle] = find_angle(scaled_distance, estimate_z, min_z_index, left_top_index, right_top_index);

height_info = [estimate_z(left_top_index), estimate_z(min_z_index), estimate_z(right_top_index)];

hold on
plot( [scaled_distance(left_half_index), scaled_distance(min_z_index), scaled_distance(right_half_index)], ...
      [estimate_z(left_half_index), estimate_z(min_z_index), estimate_z(right_half_index)], 'Linewidth', 8)

top_position = [ scaled_distance( left_top_index ), scaled_distance( right_top_index ) ];
top_top_distance = abs(scaled_distance( left_top_index) - scaled_distance( right_top_index));

title(['top-to-top distance: ' num2str(top_top_distance) 'nm ' 'Angle: ' num2str(dihedral_angle)]);

xlabel('nm')
ylabel('nm')
hold off 

end
