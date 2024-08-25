MODULE CM_Station
    
    !TODO
    ! Handle worker commands
    ! Set clearance for avoiding contacting other robot
    
    RECORD c_station
        c_EE ee;
        tooldata probe;
        num peg_clearance;
        c_num_props peg_clearance_props;
        c_disc_props disc_props;
        num calibration_angle;
        c_num_props calibration_angle_props;
        num control_mode;
        bool manual_mode;
        pose user_frame;
    ENDRECORD
    
    RECORD c_station_io
        c_EE_io ee_io;
        IO_signalai peg;
        IO_signalao peg_readback;
        IO_signalai target_height;
        IO_signalao target_height_readback;
        IO_signaldi execute;
        IO_signaldo execute_readback;
        IO_signaldo motion_complete;
        IO_signaldi motion_complete_readback;
        IO_signaldo clear_of_uframe;
        IO_signaldi clear_of_uframe_readback;
        IO_signaldi partner_clear_of_uframe;
        IO_signaldo partner_clear_of_uframe_readback;
    ENDRECORD
    
ENDMODULE