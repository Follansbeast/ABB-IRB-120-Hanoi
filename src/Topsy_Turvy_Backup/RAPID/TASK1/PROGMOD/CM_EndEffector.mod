MODULE CM_EndEffector    
    
    !TODO
    ! TCP Calibration
    ! Incorporate tool calibration angle from station
    ! Actuator motion calibration
    
    RECORD c_EE
        tooldata tool_data;
        num rotation;
        c_num_props rotation_props;
        num alignment_to_object;
        bool actuated;
        bool has_actuation_motion;
        bool has_actuation_signal;
        bool has_feedback_signal;
        bool has_object_held_signal;
        speeddata actuation_move_speed;
        speeddata move_speed;
        pose actuate_position;
        pose release_position;
    ENDRECORD

    RECORD c_EE_io
        IO_signaldo actuate_signal;
        IO_signaldi feedback_signal;
        IO_signaldi object_held_signal;
    ENDRECORD
    
    LOCAL CONST num BOTTOM := 1;
    LOCAL CONST num MIDDLE := 2;
    LOCAL CONST num TOP := 3;
    
    LOCAL PERS tooldata tool := [TRUE,[[0,0,0],[1,0,0,0]],[0,[0,0,0],[1,0,0,0],0,0,0]];

    PROC ee_SET_ACTUATOR (INOUT c_ee ee, VAR c_EE_io ee_io)
        VAR robtarget target;
        
        IF ee.has_actuation_signal IO_SET_DO ee_io.actuate_signal, TRUE;
        
        IF ee.has_actuation_motion THEN
            tool := ee.tool_data;
            target := CRobT(\Tool:=tool,\WObj:=wobj0);
            ee.tool_data.tframe := ee.actuate_position;
            tool := ee.tool_data;
            MoveL target, ee.actuation_move_speed, fine, tool, \WObj:= wobj0;
        ENDIF
        
        IF ee.has_feedback_signal IO_WAIT_DI ee_io.feedback_signal, TRUE;
    ENDPROC

    PROC ee_RELEASE_ACTUATOR (INOUT c_ee ee, VAR c_EE_io ee_io)
        VAR robtarget target;
        
        IF ee.has_actuation_signal IO_SET_DO ee_io.actuate_signal, FALSE;
        
        IF ee.has_actuation_motion THEN
            tool := ee.tool_data;
            target := CRobT(\Tool:=tool,\WObj:=wobj0);
            ee.tool_data.tframe := ee.release_position;
            tool := ee.tool_data;
            MoveL target, ee.actuation_move_speed, fine, tool, \WObj:= wobj0;
        ENDIF
        
        IF ee.has_feedback_signal IO_WAIT_DI ee_io.feedback_signal, FALSE;
    ENDPROC
    
ENDMODULE