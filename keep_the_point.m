function [decision] = keep_the_point(hline)
% check whether we want to keep the point
prompt = 'save the distance and angle? (yes:1) ';

decision = input( prompt );

% delete the line between two temporary coordinates
if decision ~= 1
    delete(hline)
end

end

