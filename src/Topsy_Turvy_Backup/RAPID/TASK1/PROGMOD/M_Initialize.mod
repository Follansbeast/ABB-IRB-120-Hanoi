MODULE M_Initialize
   
    PROC initialize (VAR c_station station, INOUT c_disc disc_arr{*}, INOUT c_peg peg_arr{*})
        ! Set safety data, traps, etc.
        ! Reset any counters or anything like that.
        
        initialize_EE station.ee;
    ENDPROC
    
    PROC initialize_EE (VAR c_ee ee)
        IO_CONNECT_DO VDO_EE_Actuate,ee.actuate_signal;
        IO_CONNECT_DI_WITH_MOCK VDI_EE_Actuate_Feedback, VDI_EE_Actuate_Feedback_MOCK, ee.feedback_signal;
        IO_CONNECT_DI_WITH_MOCK VDI_EE_Obj_Held, VDI_EE_Obj_Held_MOCK, ee.object_held_signal;
    ENDPROC
    
ENDMODULE