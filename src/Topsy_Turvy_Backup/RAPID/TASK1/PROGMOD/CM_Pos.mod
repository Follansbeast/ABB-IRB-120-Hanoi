MODULE CM_Pos

    FUNC bool pos_IS_EQUAL(pos pos1, pos pos2, \num tolerance)
        IF Present(tolerance) THEN
            RETURN 
                num_IS_EQUAL(pos1.x, pos2.x, \tolerance:= tolerance) AND
                num_IS_EQUAL(pos1.y, pos2.y, \tolerance:= tolerance) AND
                num_IS_EQUAL(pos1.z, pos2.z, \tolerance:= tolerance);
        ELSE
            RETURN 
                num_IS_EQUAL(pos1.x, pos2.x) AND
                num_IS_EQUAL(pos1.y, pos2.y) AND
                num_IS_EQUAL(pos1.z, pos2.z);
        ENDIF
    ENDFUNC
    
    FUNC pos pos_MEAN (pos points {*}, \num data_points)
        VAR pos pos_mean := [0,0,0];
        VAR num data_points_local := 0;
        IF     Present(data_points) data_points_local := data_points;
        IF NOT Present(data_points) data_points_local := dim(points, 1);

        !Add all values
        FOR i FROM 1 TO data_points_local DO
            pos_mean.x := points{i}.x + pos_mean.x;
            pos_mean.y := points{i}.y + pos_mean.y;
            pos_mean.z := points{i}.z + pos_mean.z;
        ENDFOR
        
        !Divide by number of values
        pos_mean := [
            pos_mean.x/data_points_local,
            pos_mean.y/data_points_local,
            pos_mean.z/data_points_local];
        
        RETURN pos_mean;
    ENDFUNC
    
    FUNC pos pos_ORIGIN_FROM_POINTS (pos X1, pos X2, pos Y1)
        VAR robtarget pX1 := [[0,0,0],[1,0,0,0],[0,0,0,0],[0,0,0,0,0,0]];
        VAR robtarget pX2 := [[0,0,0],[1,0,0,0],[0,0,0,0],[0,0,0,0,0,0]];
        VAR robtarget pY1 := [[0,0,0],[1,0,0,0],[0,0,0,0],[0,0,0,0,0,0]];
        VAR pose peFrame;
        
        pX1.trans := X1;
        pX2.trans := X2;
        pY1.trans := Y1;
        
        peFrame := DefFrame(pX1, pX2, pY1 \Origin:= 3);
        RETURN peFrame.trans;
    ENDFUNC

ENDMODULE