MODULE CM_Plane
    
    RECORD c_plane
        pos origin;
        pos normal_vector;
    ENDRECORD
    
    PROC plane_LEAST_SQUARES_FIT
        (VAR c_plane plane, pos points {*}, \num data_points, \INOUT num residuals_out{*}, \INOUT c_num_stats stats)
        
        VAR num data_points_local;
        CONST num max_points := 30;
        CONST num dimensions := 3;
        VAR dnum dn_points{max_points,dimensions};
        VAR dnum dn_U{max_points, max_points};
        VAR dnum dn_S{dimensions};
        VAR dnum dn_V{dimensions ,dimensions};
        
        VAR num residuals {max_points};
        VAR num sum_RMS;
        VAR c_num_stats stats_local;
        
        !Get number of points
        data_points_local := dim(points,1);
        IF present (data_points) data_points_local := data_points;
        
        !Solve for centroid
        plane.origin := pos_MEAN(points, \data_points := data_points);
        
        !Convert points adjusted by centroid
        FOR i FROM 1 TO data_points_local DO
            dn_points{i,1} := NumToDnum(points{i}.x-plane.origin.x);
            dn_points{i,2} := NumToDnum(points{i}.y-plane.origin.y);
            dn_points{i,3} := NumToDnum(points{i}.z-plane.origin.z);
        ENDFOR

        !Do the SVD calc
        MatrixSVD dn_points, dn_U, dn_S, dn_V;
        
        !pull normal unit vector out of results
        plane.normal_vector := [
            DnumToNum(dn_V{1,dimensions}),
            DnumToNum(dn_V{2,dimensions}),
            DnumToNum(dn_V{3,dimensions})];

        !Solve for residuals and stats if requested
        IF Present(stats) THEN
            FOR i FROM 1 TO data_points_local DO
                residuals{i} := point_to_plane_distance (points{i}, plane);
            ENDFOR
            stats := num_CALC_STATS (residuals, \data_points := data_points_local);
        ENDIF
        
        !Output optional statistics
        IF present(residuals_out) THEN
            FOR i from 1 to data_points_local DO
                residuals_out{i} := residuals{i};
            ENDFOR
        ENDIF
    ENDPROC
    
    PROC plane_DEFINE_FRAME (INOUT pose plane_frame, INOUT wobjdata wobj, INOUT tooldata tool)
        CONST num plane_points_count := 10;
        VAR pos plane_points {plane_points_count};
        CONST num origin_points_count := 3;
        VAR pos origin_points {origin_points_count};
        VAR pos origin_points_projected {origin_points_count};
        
        VAR menu_selection selection;
        VAR string menu_items{plane_points_count + origin_points_count};
        
        VAR robtarget user_jog_point;
        VAR c_plane plane;
        VAR c_num_stats stats;
        VAR pose oriented_plane;
        
        VAR num plane_point_index;
        VAR btnres resQueryAnswer;
        VAR num plane_message_response;
        VAR robtarget frame_calc{3};
        
        WHILE TRUE DO
            menu_items{1} := "Y Axis Point 1: " + ValToStr(origin_points{1});
            menu_items{2} := "Y Axis Point 2: " + ValToStr(origin_points{2});
            menu_items{3} := "X Axis Point 1: " + ValToStr(origin_points{3});
            FOR i FROM 1 TO plane_points_count DO
                menu_items{i + 3} := "Plane Point " + NumToStr(i,0) + ": " + ValToStr(plane_points{i});
            ENDFOR
            
            selection := menu_LIST ("Define Plane Points", menu_items, ["DEFINE", "CLEAR", "CALCULATE PLANE", "RETURN"], \previous_selection:=selection);
            TEST selection.button_selection
                CASE 4: RETURN;
                CASE 1: ! DEFINE
                    TEST selection.list_selection
                        CASE 1: 
                            user_GET_JOG_POINT tool, "Y Axis Point 1", \target:= user_jog_point;
                            origin_points{1} := user_jog_point.trans;
                        CASE 2:
                            user_GET_JOG_POINT tool, "Y Axis Point 2", \target:= user_jog_point;
                            origin_points{2} := user_jog_point.trans;
                        CASE 3:
                            user_GET_JOG_POINT tool, "X Axis Point 1", \target:= user_jog_point;
                            origin_points{3} := user_jog_point.trans;
                        DEFAULT:
                            plane_point_index := selection.list_selection - 3;
                            user_GET_JOG_POINT tool, "Plane Point " + NumToStr(plane_point_index,0), \target:= user_jog_point;
                            plane_points{plane_point_index} := user_jog_point.trans;
                    ENDTEST
                    
                CASE 2: ! CLEAR
                    UIMsgBox
                        \Header := "Clear Point?",
                        "This action cannot be undone.",
                        \Msgline2 := "Press OK to proceed.",
                        \Buttons:=btnOKCancel,
                        \Result:=resQueryAnswer;
                    IF resQueryAnswer=resOK THEN
                        IF selection.list_selection <= 3 
                            THEN origin_points{selection.list_selection} := [0,0,0];
                            ELSE plane_points{selection.list_selection-3} := [0,0,0];
                        ENDIF
                    ENDIF
                        
                CASE 3: ! CALCULATE PLANE
                    plane_LEAST_SQUARES_FIT plane, plane_points, \data_points:=10, \stats:= stats;
                    
                    FOR i FROM 1 TO DIM(origin_points,1) DO
                        origin_points_projected{i} := point_to_plane_projection(origin_points{i}, plane);
                    ENDFOR
                    
                    frame_calc{1}.trans := pos_ORIGIN_FROM_POINTS (origin_points_projected{1}, origin_points_projected{2}, origin_points_projected{3}); ! Origin
                    frame_calc{2}.trans := origin_points_projected{3}; ! X
                    frame_calc{3}.trans := origin_points_projected{2}; ! Y
                    oriented_plane := DefFrame(frame_calc{1}, frame_calc{2}, frame_calc{3});
                    
                    plane_message_response := UIMessageBox (
                        \Header := "Plane Calculated",
                        \MsgArray:= [
                            "Plane calculation from points complete.",
                            "",
                            "Residuals Stats:",
                            "RMS: " + NumToStr(stats.RMS,2),
                            "Max: Point " + NumToStr(stats.index_max,0) + ": " + NumToStr(stats.max,2)
                            ]
                        \BtnArray:=["ACCEPT", "ADJUST VALUES"]
                        );
                    IF plane_message_response = 1 THEN
                        plane_frame := oriented_plane;
                        RETURN;
                    ENDIF
            ENDTEST
        ENDWHILE
    ENDPROC
    
ENDMODULE