MODULE CM_EndEffector    
    
    !TODO
    ! TCP Calibration
    ! Incorporate tool calibration angle from station
    ! Actuator motion calibrration
    ! 
    
    RECORD c_EE
        tooldata tool_data;
        num rotation;
        c_num_props rotation_props;
        num alignment_to_object;
        bool actuated;
        
        bool has_actuation_motion;
        speeddata actuation_move_speed;
        speeddata move_speed;
        pose actuate_position;
        pose release_position;
        
        bool has_actuation_signal;
        IO_signaldo actuate_signal;
        
        bool has_feedback_signal;
        IO_signaldi feedback_signal;
        
        bool has_object_held_signal;
        IO_signaldi object_held_signal;
    ENDRECORD
    
    LOCAL CONST num BOTTOM := 1;
    LOCAL CONST num MIDDLE := 2;
    LOCAL CONST num TOP := 3;
    
    LOCAL PERS tooldata tool := [TRUE,[[0,0,0],[1,0,0,0]],[0,[0,0,0],[1,0,0,0],0,0,0]];
    
    PROC ee_SETUP_MENU (VAR c_ee ee, \num calibration_angle)
        VAR menu_selection selection;
        VAR string menu_items{8};
        VAR num calibration_angle_local := 0;
        IF Present(calibration_angle) calibration_angle_local := calibration_angle;
        
        WHILE TRUE DO
            menu_items{1} := "Calibrate Tool Load via LoadID";
            menu_items{2} := "Calibrate Tool Center Point";
            menu_items{3} := "Toggle Actuation Signal Exists, Current: " + ValToStr(ee.has_actuation_signal);
            menu_items{4} := "Toggle Actuation Feedback Exists, Current: " + ValToStr(ee.has_feedback_signal);
            menu_items{5} := "Toggle Object Held Signal Exists, Current: " + ValToStr(ee.has_object_held_signal);
            menu_items{6} := "Toggle Actuation Motion Exists, Current: " + ValToStr(ee.has_actuation_motion);
            menu_items{7} := "Define Actuation Motion";
            menu_items{8} := "Actuator Test Menu";
            
            selection := menu_LIST ("End Effector Setup", menu_items, ["SELECT", "BACK"], \previous_selection:=selection);
            TEST selection.button_selection
                CASE 2: RETURN;
                CASE 1:
                    TEST selection.list_selection
                        CASE 1: tool_DEFINE_LOAD ee.tool_data, \calibration_angle:= calibration_angle_local;
                        CASE 2: !Probably need an alternative way to calculate TCP than 4 pt
                        CASE 3: 
                            IF ee.has_actuation_signal
                                THEN ee.has_actuation_signal := FALSE;
                                ELSE ee.has_actuation_signal := TRUE;
                            ENDIF
                        CASE 4: 
                            IF ee.has_feedback_signal
                                THEN ee.has_feedback_signal := FALSE;
                                ELSE ee.has_feedback_signal := TRUE;
                            ENDIF
                        CASE 5: 
                            IF ee.has_object_held_signal
                                THEN ee.has_object_held_signal := FALSE;
                                ELSE ee.has_object_held_signal := TRUE;
                            ENDIF
                        CASE 6: 
                            IF ee.has_actuation_motion
                                THEN ee.has_actuation_motion := FALSE;
                                ELSE ee.has_actuation_motion := TRUE;
                            ENDIF
                        CASE 7: ee_MOTION_MENU ee;
                        CASE 8: ee_TEST_MENU ee;
                    ENDTEST
            ENDTEST
        ENDWHILE
    ENDPROC
    
    PROC ee_TEST_MENU (VAR c_ee ee)
        VAR menu_selection selection;
        VAR string menu_items{4};
        
        WHILE TRUE DO
            menu_items{1} := "Actuation Signal Status: " + ValToStr(IO_GET_DO(ee.actuate_signal));
            menu_items{2} := "Actuation Feedback Status: " + ValToStr(IO_GET_DI(ee.feedback_signal));
            menu_items{3} := "Object Held Status: " + ValToStr(IO_GET_DI(ee.object_held_signal));
            if ee.actuated menu_items{4} := "Release Actuator";
            if NOT ee.actuated menu_items{4} := "SET Actuator";
            
            
            selection := menu_LIST ("End Effector Setup", menu_items, ["SELECT", "BACK"], \previous_selection:=selection);
            TEST selection.button_selection
                CASE 2: RETURN;
                CASE 1:
                    TEST selection.list_selection
                        CASE 1: 
                        CASE 2: 
                        CASE 3: 
                        CASE 4: 
                        CASE 5: 
                        CASE 6: 
                        CASE 7: 
                    ENDTEST
            ENDTEST
        ENDWHILE
    ENDPROC
    
    PROC ee_MOTION_MENU (VAR c_ee ee)
    ENDPROC
    
    
    PROC ee_SET_ACTUATOR (VAR c_ee ee)
        VAR robtarget target;
        
        IF ee.has_actuation_signal IO_SET_DO ee.actuate_signal, TRUE;
        
        IF ee.has_actuation_motion THEN
            tool := ee.tool_data;
            target := CRobT(\Tool:=tool,\WObj:=wobj0);
            ee.tool_data.tframe := ee.actuate_position;
            tool := ee.tool_data;
            MoveL target, ee.actuation_move_speed, fine, tool, \WObj:= wobj0;
        ENDIF
        
        IF ee.has_feedback_signal IO_WAIT_DI ee.feedback_signal, TRUE;
    ENDPROC

    PROC ee_RELEASE_ACTUATOR (VAR c_ee ee)
        VAR robtarget target;
        
        IF ee.has_actuation_signal IO_SET_DO ee.actuate_signal, FALSE;
        
        IF ee.has_actuation_motion THEN
            tool := ee.tool_data;
            target := CRobT(\Tool:=tool,\WObj:=wobj0);
            ee.tool_data.tframe := ee.release_position;
            tool := ee.tool_data;
            MoveL target, ee.actuation_move_speed, fine, tool, \WObj:= wobj0;
        ENDIF
        
        IF ee.has_feedback_signal IO_WAIT_DI ee.feedback_signal, FALSE;
    ENDPROC
    
ENDMODULE