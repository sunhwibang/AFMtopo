function [temp_coordinates, hline, h1] = get_coordinates(loop_count)
% get the coordinates using ginput.

hold on

% select two points using forloop.
for i = 1:2
    % select a single point using ginput.
    [x,y] = ginput(1);
    
    % temp_coordinates measure the value in indexed coordinates (0 ~ 1023).
    temp_coordinates(i,:) = [x,y];
  
    if i == 1
        direction = 'L';
    elseif i == 2 
        direction = 'R';
    end
    
    % h1 saves the label information. Use delete(h1) to remove the label.
    h1(i) = text(x,y, [num2str(loop_count), direction], 'FontSize', 10);
end

% draw a line two selected points. Use delete(hline) to remove the line.
hline = plot( temp_coordinates(:,1), temp_coordinates(:,2), 'LineWidth',2 );
hold on

end
