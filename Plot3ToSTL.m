function Plot3ToSTL(X, Y, Z)
    name = 'Spring.stl';
    output = fopen(name, 'w');
    fprintf(output, ['solid ' name '\n']);

    rows = size(X, 1);
    columns = size(X, 2);

    for i = 1:rows - 1
        for j = 1:columns - 1
            v1 = [X(i, j), Y(i, j), Z(i, j)];
            v2 = [X(i, j + 1), Y(i, j + 1), Z(i, j + 1)];
            v3 = [X(i + 1, j + 1), Y(i + 1, j + 1), Z(i + 1, j + 1)];

            vector1 = v1 - v2;
            vector2 = v1 - v3;
            norm = cross(vector1, vector2);
            mag = sqrt(norm(1)^2 + norm(2)^2 + norm(3)^2);
            unit_normal = norm / mag;

            fprintf(output, 'facet normal %.7E %.7E %.7E\n', unit_normal); 
            fprintf(output, 'outer loop\n');
            fprintf(output, 'vertex %.7E %.7E %.7E\n', v1);
            fprintf(output, 'vertex %.7E %.7E %.7E\n', v2);
            fprintf(output, 'vertex %.7E %.7E %.7E\n', v3);
            fprintf(output, 'endloop\n');
            fprintf(output, 'endfacet\n');

            v1 = [X(i + 1, j + 1), Y(i + 1, j + 1), Z(i + 1, j + 1)];
            v2 = [X(i + 1, j), Y(i + 1, j), Z(i + 1, j)];
            v3 = [X(i, j), Y(i, j), Z(i, j)];

            vector1 = v1 - v2;
            vector2 = v1 - v3;
            norm = cross(vector1, vector2);
            mag = sqrt(norm(1)^2 + norm(2)^2 + norm(3)^2);
            unit_normal = norm / mag;

            fprintf(output, 'facet normal %.7E %.7E %.7E\n', unit_normal);
            fprintf(output, 'outer loop\n');
            fprintf(output, 'vertex %.7E %.7E %.7E\n', v1);
            fprintf(output, 'vertex %.7E %.7E %.7E\n', v2);
            fprintf(output, 'vertex %.7E %.7E %.7E\n', v3);
            fprintf(output, 'endloop\n');
            fprintf(output, 'endfacet\n');
        end
    end

fprintf(output, 'endsolid\n');
fclose(output);
end
