MODULE CM_Station
    
    !TODO
    ! Handle worker commands
    ! Set clearance for avoiding contacting other robot
    
    RECORD c_station
        c_EE ee;
        tooldata probe;
        num peg_clearance;
        c_num_props peg_clearance_props;
        num calibration_angle;
        c_num_props calibration_angle_props;
        num control_mode;
        bool manual_mode;
        pose base_plane;
        IO_signalai peg;
        IO_signalao peg_readback;
        IO_signalai peg_height;
        IO_signalao peg_height_readback;
        IO_signaldi execute;
        IO_signaldo execute_readback;
        IO_signaldo motion_complete;
        IO_signaldi motion_complete_readback;
        IO_signaldo clear_of_uframe;
        IO_signaldi clear_of_uframe_readback;
        IO_signaldi partner_clear_of_uframe;
        IO_signaldo partner_clear_of_uframe_readback;
    ENDRECORD
    
    PROC station_SETUP_MENU (VAR c_station station)
        VAR menu_selection selection;
        VAR string menu_items{5} := [
            "Adjust LoadID Calibration Angle",
            "Probe Tool Setup",
            "Define Game Base Plane",
            "Disc Mover Tool Setup",
            "Set peg motion clearance"
            ];
        VAR string worker_mode;
        
        WHILE TRUE DO
            selection := menu_LIST ("Station Setup", menu_items, ["SELECT", "BACK"], \previous_selection:=selection);
            if selection.button_selection = 2 RETURN;
            TEST selection.list_selection
                CASE 1: num_props_MENU station.calibration_angle, station.calibration_angle_props;
                CASE 2: tool_DEFINE_TOOL_MENU station.probe, "Probe", \calibration_angle := station.calibration_angle;
                CASE 3: plane_DEFINE_FRAME station.base_plane, wobj0, station.probe;
                CASE 4: ee_SETUP_MENU station.ee, \calibration_angle := station.calibration_angle;
                CASE 5: num_props_MENU station.peg_clearance, station.peg_clearance_props;
            ENDTEST
        ENDWHILE
    ENDPROC
    
    PROC station_CONTROL_MODE_MENU (VAR c_station station)
        VAR menu_selection selection;

        VAR string menu_items{3} := [
            "Solo",
            "Controller",
            "Worker"
            ];
        VAR string worker_mode;
        
        selection := menu_LIST ("Select Control Mode", menu_items, ["SELECT", "BACK"], \previous_selection:=[station.control_mode + 1,0]);
        if selection.button_selection = 2 RETURN;
        TEST selection.list_selection
            CASE 1: station.control_mode := 0;
            CASE 2: station.control_mode := 1;
            CASE 3: station.control_mode := 2;
        ENDTEST
    ENDPROC
    
ENDMODULE