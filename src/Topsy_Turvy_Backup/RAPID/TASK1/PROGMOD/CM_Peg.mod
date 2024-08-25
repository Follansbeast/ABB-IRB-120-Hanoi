MODULE CM_Peg

    !To Do:
    ! Need algorithm for determining peg pose (peg_SET_WOBJ_DATA).
    ! get wobjdata for uframe
    ! Identify if uframe has been set or not.
    ! Be able to adjust uframe based on moving ToH and still be able to do tower

    RECORD c_peg
        wobjdata wobj;
    ENDRECORD
    
    PROC peg_SET_WOBJ_DATA (INOUT wobjdata wobj)
        ! Set up peg w/ work object data
        ! Use base plane from station as UFrrame
        ! Get axis of cylinder
        ! get point on top of cylinder
        ! Create plane normal to cylinder axis that intersects top point
        ! Create origin where axis instersects plane
        ! Align wobj to world frame
    ENDPROC
    
ENDMODULE