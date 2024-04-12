function rotation_matrix = rotationMatrix(type,angle)
    angle = angle*(2*pi)/360;
    if type == 'x'
        rotation_matrix=[1     0         0
                         0 cos(angle) -sin(angle)
                         0 sin(angle) cos(angle) ];
    elseif type == 'y'
        rotation_matrix=[cos(angle)       0    sin(angle)
                            0             1       0
                         -sin(angle)      0    cos(angle) ];
   elseif type == 'z'
        rotation_matrix=[cos(angle) -sin(angle)    0;
                         sin(angle)  cos(angle)    0;
                           0            0          1 ];
    else
        fprintf("Invailed input for type");
    end
end