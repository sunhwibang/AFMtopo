function output_txt = myundatefcn( ~ , event_obj )
    % ~             current not used (empty)
    % event_obj     object containing event data structure
    % output_txt    data cursor text
    
    pos = get( event_obj , 'Position' );
    output_txt = {['x: ' num2str(pos(1))], ['z: ' num2str(pos(2))]};
end

