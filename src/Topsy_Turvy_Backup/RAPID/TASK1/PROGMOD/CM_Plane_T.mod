MODULE CM_Plane_T
    PROC test_plane_RUN ()
        test_plane_LEAST_SQUARES_FIT;
    ENDPROC
    
    PROC test_plane_LEAST_SQUARES_FIT ()
        VAR pos plane_points{10};
        VAR c_plane calculated_plane;
        VAR c_plane expected_plane;
        
        plane_points{1} := [0.488, 2.917, 1.358];
        plane_points{2} := [2.152, 0.289, 6.974];
        plane_points{3} := [1.028, 0.680, 4.437];
        plane_points{4} := [0.449, 4.256, -0.529];
        plane_points{5} := [-0.763, -4.290, 5.252];
        plane_points{6} := [1.459, -4.129, 10.177];
        plane_points{7} := [-0.624, -4.798, 6.722];
        plane_points{8} := [3.918, 3.326, 7.361];
        plane_points{9} := [4.637, 2.782, 9.946];
        plane_points{10} := [-1.166, 3.700, -3.322];
        
        expected_plane.normal_vector := [0.82606, -0.40041, -0.396616];
        expected_plane.origin := [1.1578, 0.4733, 4.8376];
        plane_LEAST_SQUARES_FIT calculated_plane, plane_points, \data_points:=10;
        !ErrWrite \I, ValToStr(calculated_plane.normal_vector), "";
        !ErrWrite \I, ValToStr(calculated_plane.origin), "";
        assert pos_IS_EQUAL(calculated_plane.origin, expected_plane.origin), "Plane least squares origin 1 test";
        assert pos_IS_EQUAL(calculated_plane.normal_vector, expected_plane.normal_vector), "Plane least squares normal vector 1 test";
    ENDPROC
    
ENDMODULE