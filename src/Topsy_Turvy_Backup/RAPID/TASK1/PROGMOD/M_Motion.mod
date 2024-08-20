MODULE M_Motion
    
    LOCAL PERS wobjdata work_object := [FALSE, TRUE, "",[[450, 0, 0],[1, 0, 0, 0]],[[0,0,0],[1,0,0,0]]];
    LOCAL PERS tooldata tool := [TRUE,[[0,0,0],[1.91069E-15,-1,-4.37114E-08,-4.37114E-08]],[0.01,[0,0,0.01],[1,0,0,0],0,0,0]];
    
    LOCAL CONST num BOTTOM := 1;
    LOCAL CONST num MIDDLE := 2;
    LOCAL CONST num TOP := 3;
    
    PROC motion_MOVE_DISC (VAR c_station station, c_disc disc_arr{*}, c_peg peg_arr{*}, num peg_number_from, num peg_number_to)
        VAR num selected_disc;
        VAR num selected_disc_thickness;
        
        VAR c_peg from_peg;
        VAR num from_stack_height;
        VAR num from_height_clearance;
        VAR num from_height_actuate;
        VAR num from_height_clearance_with_disc;
        
        VAR c_peg to_peg;
        VAR num to_height_clearance_with_disc;
        VAR num to_height_release;
        VAR num to_height_clearance;
        
        selected_disc := disc_arr_GET_TOP_DISC(disc_arr, peg_number_from);
        IF disc_arr_LEGAL_TO_MOVE_DISC (disc_arr, selected_disc, peg_number_to) = FALSE RETURN;
        from_stack_height := disc_arr_GET_STACK_HEIGHT (disc_arr, peg_number_from);
        selected_disc_thickness := disc_arr_GET_DISC_THICKNESS (disc_arr, selected_disc);
        
        from_peg := peg_arr{peg_number_from};
        to_peg := peg_arr{peg_number_to};
        
        TEST station.ee.alignment_to_object
            CASE BOTTOM: 
                from_height_clearance := station.peg_clearance;
                from_height_actuate := from_stack_height - selected_disc_thickness;
                from_height_clearance_with_disc := from_height_clearance;
                
                to_height_clearance_with_disc := station.peg_clearance;
                to_height_release := -selected_disc_thickness;
                to_height_clearance := station.peg_clearance;
            CASE MIDDLE:
                from_height_clearance := station.peg_clearance + selected_disc_thickness/2;
                from_height_actuate := from_stack_height - selected_disc_thickness/2;
                from_height_clearance_with_disc := from_height_clearance;
                
                to_height_clearance_with_disc := station.peg_clearance + selected_disc_thickness/2;
                to_height_release := -selected_disc_thickness/2;
                to_height_clearance := station.peg_clearance + selected_disc_thickness/2;
            CASE TOP:
                from_height_clearance := station.peg_clearance;
                from_height_actuate := from_stack_height;
                from_height_clearance_with_disc := from_height_clearance + selected_disc_thickness;
                
                to_height_clearance_with_disc := station.peg_clearance + selected_disc_thickness;
                to_height_release := 0;
                to_height_clearance := station.peg_clearance;
        ENDTEST

        motion_SHAFT_REFERENCED_MOVE station.ee, from_peg, from_height_clearance;
        motion_SHAFT_REFERENCED_MOVE station.ee, from_peg, from_height_actuate;
        ee_SET_ACTUATOR station.ee;
        motion_SHAFT_REFERENCED_MOVE station.ee, from_peg, from_height_clearance_with_disc;
        disc_arr_MOVE_DISC disc_arr, selected_disc, 0;
        
        motion_SHAFT_REFERENCED_MOVE station.ee, to_peg, to_height_clearance_with_disc;
        motion_SHAFT_REFERENCED_MOVE station.ee, to_peg, to_height_release;
        ee_RELEASE_ACTUATOR station.ee;
        disc_arr_MOVE_DISC disc_arr, selected_disc, peg_number_to;
        motion_SHAFT_REFERENCED_MOVE station.ee, to_peg, to_height_clearance;
    ENDPROC
    
    PROC motion_SHAFT_REFERENCED_MOVE (VAR c_ee end_effector, VAR c_peg peg, num height)
        VAR robtarget target:=[[0,0,0],[1,0,0,0],[0,0,1,0],[9E9,9E9,9E9,9E9,9E9,9E9]];
        target := Offs(target, 0, 0, height);
        work_object := peg.wobj;
        tool := end_effector.tool_data;
        SingArea \Wrist;
        !ConfL \off;
        MoveL reltool(target,0,0,0,\Rz:=end_effector.rotation), end_effector.move_speed, fine, tool \WObj:=work_object;
    ENDPROC
ENDMODULE