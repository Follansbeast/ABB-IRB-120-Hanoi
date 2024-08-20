MODULE M_Geometry
    
    FUNC num point_to_plane_distance (pos point, c_plane plane)
        VAR num distance;
        distance := Abs((plane.normal_vector.x * point.x  + plane.normal_vector.y * point.y  + plane.normal_vector.z * point.z) -
                         (plane.normal_vector.x * plane.origin.x + plane.normal_vector.y * plane.origin.y + plane.normal_vector.z * plane.origin.z))
                         /VectMagn(plane.normal_vector);
        RETURN distance;
    ENDFUNC
    
    FUNC num point_to_line_distance (pos Point, pos line_point1, pos line_point2)
        VAR num nDistance;
        nDistance := VectMagn((line_point2-line_point1)*(line_point1-Point))/VectMagn(line_point2-line_point1);
        RETURN nDistance;
    ENDFUNC
    
    FUNC num line_to_line_distance (pos point_A1, pos point_A2, pos point_B1, pos point_B2, \INOUT pos intersect_point, \num angle_tolerance)
        VAR pos normal_vector_A;
        VAR pos normal_vector_B;
        VAR pos cross_vector_B;
        VAR pos cross_vector_A;
        VAR pos closest_point_A;
        VAR pos closest_point_B;
        VAR num distance;
        VAR num angle;
        VAR num tolerance;
        
        !Distance is measured between the two points
        !Intersect point is either the intersection or the mid point for skew lines. This is the average of the intersections with the cross product line
        
        normal_vector_A := point_A2 - point_A1;
        normal_vector_B := point_B2 - point_B1;
        
        !If lines are parallel, distance between them can be solved using DistancePointLine
        !Check parallelism
        Angle := line_to_line_angle (point_A1, point_A2, point_B1, point_B2);
        
        !Trigger error if parallel enough and requesting a ridiculous intersection point
        !Best to do this with raiseerror, but this is a lazy version for now
        IF Angle < 0.00001 AND Present(intersect_point) THEN
            ErrWrite "Improper function inputs", 
                "Vectors specified in line_to_line_distance are parallel",
                \RL2 := " and cannot produce an intersection.";
            STOP;
        ENDIF
        
        IF Angle = 0 THEN
            Distance := point_to_line_distance(point_A1,point_B1,point_B2);
            RETURN Distance;
        ENDIF
        
        !If they are not parallel, get cross product
        
        !Solve with cross product and each vector to get intersections with the two vectors
        cross_vector_B := normal_vector_B * (normal_vector_A * normal_vector_B);
        closest_point_A := point_A1 + 
            (DotProd((point_B1 - point_A1), cross_vector_B)/
            DotProd(normal_vector_A, cross_vector_B)) 
            *normal_vector_A;
        
        cross_vector_A := normal_vector_A * (normal_vector_A * normal_vector_B);
        closest_point_B := point_B1 + 
            (DotProd((point_A1 - point_B1), cross_vector_A)/
            DotProd(normal_vector_B, cross_vector_A)) 
            *normal_vector_B;
        
        IF Present(intersect_point) intersect_point := closest_point_A + (closest_point_B - closest_point_A)*(1/2);
        
        Distance := VectMagn(closest_point_B - closest_point_A);
        RETURN Distance;
    ENDFUNC
    
    FUNC num line_to_line_angle (pos point_A1, pos point_A2, pos point_B1, pos point_B2)
        VAR num angle;
        
        Angle := ACos(
            (
                (point_A2.x - point_A1.x) * (point_B2.x - point_B1.x) + 
                (point_A2.y - point_A1.y) * (point_B2.y - point_B1.y) + 
                (point_A2.z - point_A1.z) * (point_B2.z - point_B1.z)
            )/(VectMagn(point_A2-point_A1) * VectMagn(point_B2-point_B1)));
            
        IF angle > 90 angle := 180 - angle;
        RETURN angle;
    ENDFUNC
    
    FUNC pos point_to_plane_projection (pos point, c_plane plane)
        VAR num dot_prod1;
        VAR num dot_prod2;
        
        dot_prod1 := DotProd(plane.normal_vector, point);
        dot_prod2 := DotProd(plane.normal_vector, plane.origin);
        RETURN point - (dot_prod1 - dot_prod2) * plane.normal_vector;
    ENDFUNC
ENDMODULE