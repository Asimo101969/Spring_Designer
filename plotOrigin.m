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