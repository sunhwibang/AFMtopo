%% ZnO_AFM_dihedral analysis manual select
% use g%% ZnO_AFM_dihedral analysis
% use ginput
clear all; close all; clc
data = importdata('../data/p14k_height.mat')';

%x_mesh = [0 : 2500/1024 : (2500/1024)*49];
%y_mesh = [0 : 2500/1024 : (2500/1024)*49];

% create the mesh starting from index 0
%x_mesh = [0 : 1 : length(data)-1];
%y_mesh = [0 : 1 : length(data)-1];

% create the mesh starting from index 1 to match with the index coordinates
x_mesh = [ 1 : 1 : length(data) ];
y_mesh = [ 1 : 1 : length(data) ];

[x_mesh, y_mesh] = meshgrid( x_mesh, y_mesh );

contour(x_mesh, y_mesh, data, 50);

% initialize the loop count
loop_count = 512;
continue_flag = 1;


%% big loop for the dihedral angle measurement

while continue_flag == 1
    
%% get coordinates of two points
hold on
[temp_coordinates, hline, h1] = get_coordinates(loop_count);
hold off


%% generate x and y points along the line
number_point = 500;
[make_x_point, make_y_point] = make_xy_points( temp_coordinates, number_point );

%% estimate topographic values of off-grid coordinates
[estimate_z, estimated_z_error] = point3plane( make_x_point, make_y_point, data );

%% find the top points manually
[ top_top_distance , dihedral_angle , height_info, top_position ] = find_angle_manually( temp_coordinates , estimate_z );
disp( ['top to top: ', num2str(top_top_distance) 'nm ', 'dihedral_angle: ', num2str(dihedral_angle), ' depth: ', num2str( (height_info(3)+height_info(1))/2 - height_info(2)) ])

%% save the measurements and continue the loop
global_save( loop_count , : ) = [ top_top_distance, dihedral_angle, height_info, top_position, temp_coordinates(1,1), temp_coordinates(1,2), temp_coordinates(2,1), temp_coordinates(2,2) ];   
save global_save.mat

%% loop
decision = input( 'save the current distance and angle? (yes: anykey) (no:1) (terminate:0)' );

% delete the line between two temporary coordinates
% terminate the measurement
if decision == 0
    continue_flag = 0; 
    disp('measurement terminated and the current meassurement is saved')


elseif decision == 1
    continue_flag = 1;
    close Figure 2
    delete(hline)
    delete(h1)
    disp('did not save the current measurement')
    
else 
    continue_flag = 1;
    close Figure 2
    disp( ['save the curretment measurement: ', num2str(loop_count)] )
    loop_count = loop_count+1;   
    
end
end