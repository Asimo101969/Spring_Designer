function spring
    P = app.MaxSpringForceNEditField.Value;
            deflection = app.MaxDeflectionmmEditField.Value;
            UTS = app.UTSNmmEditField.Value;
            G = app.ModulusofrigidityGEditField.Value;
            C = app.SpringIndexCEditField.Value;
            tau = 0.5*UTS;
            K = ((4*C-1)/(4*C-4))+(0.615/C);
            d = round(sqrt((8*K*P*C)/(pi*tau)));
            D = C*d;
            N = round((deflection*G*d^4)/(8*P*D^3));
            Nt = N+(app.EndConditionDropDown.Value);% Type of spring end
            solid_length = Nt*d;
            actual_deflection = (8*P*N*D^3)/(G*d^4);
            total_gap = (Nt-1)*1;
            free_length = solid_length + total_gap + deflection;
            pitch = free_length/(Nt-1);
            k = (G*d^4)/(8*N*D^3);
            r_in = (D-d)/2;
            r_out  = (D+d)/2;
            L = free_length;
            loop = Nt;
    

            frac = 20;
            nNodes = 50;
            nCS = 1400;

            %plotOrigin([-2 2],[-2 2],[-1 6],[0 0 0]); axis off
        
            alpha = loop*360 + frac;


            th = linspace(0,2*pi,nNodes);
            r = 0.5*(r_out-r_in)*ones(1,nNodes);
            z = r.*cos(th);
            y = r.*sin(th)+r_in+0.5*(r_out-r_in);
            x = zeros(1,nNodes);

            dz = linspace(0,L,nCS);
            phi = linspace(0,alpha,nCS);
            X =[];
            Y =[];
            Z =[];
            for i=1:nCS
                temp_CS = rotationMatrix('z',phi(i)) * [x;y;z];
                X =[X; temp_CS(1,:)];
                Y =[Y; temp_CS(2,:)];
                Z =[Z; temp_CS(3,:)+dz(i)];
                plot3(app.UIAxes,X(i,:),Y(i,:),Z(i,:),'ok');
            end
            % solidifing 
            [X, Y, Z] = get_plates(X, Y, Z, nNodes, r_out, r_in, alpha, L) ;
            % doing surfacing in adjecent rings
            surf(app.UIAxes,X,Y,Z);




            function [X, Y, Z] = get_plates(X, Y, Z, nNodes, r_out, r_in, alpha, L) 
                plate1 = [0; 0.5*(r_out-r_in) + r_in; 0];
                plate2 = rotationMatrix('z', alpha)*plate1;
                plate1 = repmat(plate1, 1, nNodes); 
                plate2 = repmat (plate2, 1, nNodes);
                X = [plate1(1,:); X; plate2(1,:)]; 
                Y = [plate1(2,:); Y; plate2(2,:)];
                Z = [plate1(3,:); Z; plate2(3,:) + L];
            end





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



            
            function plotOrigin(rangeX,rangeY,rangeZ,offset)
                x0 = offset(1);
                y0 = offset(2);
                z0 = offset(3);
            
                if x0<rangeX(1)|| x0>rangeX(2)
                    fprintf('Origin is not within x axis range')
                elseif y0<rangeY(1)|| y0>rangeY(2)
                    fprintf('Origin is not within y axis range')
                    return
                elseif z0<rangeZ(1)|| z0>rangeZ(2)
                    fprintf('Origin is not within Z axis range')
                    return
                end
            
            
                plot3(rangeX+x0,[y0 y0],[z0,z0],'--r')
                axis equal
                hold on
                plot3([x0 x0],rangeY+y0,[z0,z0],'--g')
                plot3([x0 x0],[y0 y0],rangeZ+z0,'--b')
            end
end