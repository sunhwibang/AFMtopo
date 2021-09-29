function [top_top_distance] = plot_topo(scaled_distance, estimate_z, left_top_index, min_z_index, right_top_index, left_half_index, right_half_index, dihedral_angle)
% plot the topography and display the top-to-top distance and dihedral
% angle

figure(2)
% plot the topography
plot( scaled_distance, estimate_z )
hold on
% show the minimum point
plot( scaled_distance( min_z_index ), estimate_z( min_z_index), '*')
hold on
% show the left top point
plot( scaled_distance( left_top_index ), estimate_z( left_top_index ), 'o')
hold on 
% show the right top point
plot( scaled_distance( right_top_index ), estimate_z( right_top_index ), 'o')
% show the half way life
plot( [scaled_distance(left_half_index), scaled_distance(min_z_index), scaled_distance(right_half_index)], ...
      [estimate_z(left_half_index), estimate_z(min_z_index), estimate_z(right_half_index)], 'Linewidth', 8)

top_top_distance = abs(scaled_distance( left_top_index) - scaled_distance( right_top_index));
title(['top-to-top distance: ' num2str(top_top_distance) 'nm ' 'Angle: ' num2str(dihedral_angle)])

xlabel('nm')
ylabel('nm')

hold off
end