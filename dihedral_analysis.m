%% ZnO_AFM_dihedral analysis
% use g%% ZnO_AFM_dihedral analysis
% use ginput
clear all; close all; clc
data = importdata('../data/z_2k_small_50_50.mat');

%x_mesh = [0 : 2500/1024 : (2500/1024)*49];
%y_mesh = [0 : 2500/1024 : (2500/1024)*49];

x_mesh = [0 : 1 : 49];
y_mesh = [0 : 1 : 49];

[x_mesh, y_mesh] = meshgrid( x_mesh, y_mesh );

contour(x_mesh, y_mesh, data, 500);

% setup:
count = 1;


%% while loop starts here
while count < 5

temp_coordinates = zeros(2,2);

%% get coordinates of two points
hold on
[temp_coordinates, hline] = get_coordinates();
hold on


%% generate x and y points along the line
number_point = 100;
[make_x_point, make_y_point] = make_xy_points( temp_coordinates, number_point );

%% estimate topographic values of off-grid coordinates
[estimate_z, estimated_z_error] = point3plane( make_x_point, make_y_point, data );

%% find the top points using the slope threshold
slope_threshold = 0.008;
[scaled_distance, min_z_index, left_top_index, right_top_index ] = find_top( temp_coordinates, estimate_z, slope_threshold );

%% find the dihedral angle between half way point:
[left_half_index, right_half_index, dihedral_angle] = find_angle(scaled_distance, estimate_z, min_z_index, left_top_index, right_top_index);


%% plotting
[top_top_distance] = plot_topo(scaled_distance, estimate_z, left_top_index, min_z_index, right_top_index, left_half_index, right_half_index, dihedral_angle);

% determine whether we can to save this data point:

[decision] = keep_the_point(hline);

if decision == 1
    global_save(count,:) = [ top_top_distance, dihedral_angle, temp_coordinates(1,1), temp_coordinates(1,2), temp_coordinates(2,1), temp_coordinates(2,2) ];   
end

close figure 2
    
    count = count + 1;
end

prompt = 'continue taking measurements? (yes:1) ';