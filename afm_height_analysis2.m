%% AFM height analysis test 2
format long; clc; clear all; close all;

% parameter setup
resolution = 1024; % data point
scan_length = 2.5; % um

% import data
p2k_data = importdata('../data/p2k_height.xlsx');
p6k_data = importdata('p6k_height.txt');
p10k_data = importdata('p10k_height.txt');
p14k_data = importdata('../data/p14k_height.txt');
height_data = reshape( p14k_data, [resolution, resolution])';

% form meshgrid
[x,y] = meshgrid( 0: scan_length / (resolution-1) : scan_length, 0: scan_length / (resolution-1) : scan_length);

% offset z-axis
height_data_offset = height_data + abs(min(min(height_data)));

[px, py] = gradient( height_data_offset );

% plotting
% mesh(x,y,p2k_data_offset)

% deal with smaller area
% x_small = 1000 * x(130:179,225:274);
% y_small = 1000 * y(130:179,225:274);
% height_data_small = height_data_offset(130:179,225:274);


figure
%contour( x_small, y_small, height_data_small, resolution )
contour( 1000*x, 1000*y, height_data_offset, resolution)
%hold on
%quiver( 1000*x, 1000*y,px,py)
hold off

%% watershed
watershed = height_data_offset;

for xi = 1:resolution
    for yi = 1:resolution
        if watershed(yi,xi) < 25
            watershed(yi,xi) = -100;
        end
    end
end

figure
contour( x, y, watershed, resolution );