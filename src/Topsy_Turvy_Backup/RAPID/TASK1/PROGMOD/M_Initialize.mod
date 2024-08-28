MODULE M_Initialize
    
    ! Error number booking
    VAR errnum ERR_PEG_NOT_ASSIGNED := -1;
    
    PROC initialize (VAR c_station_io station_io)
        !initialize_STATION_IO station_io;
        initialize_EE_IO station_io.ee_io;
        BookErrNo ERR_PEG_NOT_ASSIGNED;
    ENDPROC
    
    PROC initialize_STATION_IO (VAR c_station_io station_io)
        IO_CONNECT_AI station_io.peg, <ARG>, <ARG>;
        IO_CONNECT_AO station_io.peg_readback, <ARG>;
        IO_CONNECT_AI station_io.target_height, <ARG>, <ARG>;
        IO_CONNECT_AO station_io.target_height_readback, <ARG>;
        IO_CONNECT_DI station_io.execute, <ARG>, <ARG>;
        IO_CONNECT_DO station_io.execute_readback, <ARG>;
        IO_CONNECT_DO station_io.motion_complete, <ARG>;
        IO_CONNECT_DI station_io.motion_complete_readback, <ARG>, <ARG>;
        IO_CONNECT_DO station_io.clear_of_uframe, <ARG>;
        IO_CONNECT_DI station_io.clear_of_uframe_readback, <ARG>, <ARG>;
        IO_CONNECT_DI station_io.partner_clear_of_uframe, <ARG>, <ARG>;
        IO_CONNECT_DO station_io.partner_clear_of_uframe_readback, <ARG>;
    ENDPROC
    
    PROC initialize_EE_IO (VAR c_ee_io ee_io)
        IO_CONNECT_DO ee_io.actuate_signal, VDO_EE_Actuate;
        IO_CONNECT_DI ee_io.feedback_signal, VDI_EE_Actuate_Feedback, VDI_EE_Actuate_Feedback_MOCK;
        IO_CONNECT_DI ee_io.object_held_signal, VDI_EE_Obj_Held, VDI_EE_Obj_Held_MOCK;
    ENDPROC

ENDMODULE