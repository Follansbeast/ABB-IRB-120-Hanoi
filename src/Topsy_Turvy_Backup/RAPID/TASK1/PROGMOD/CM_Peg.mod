MODULE CM_Peg

    !To Do:
    ! Need algorithm for determining peg pose (peg_SET_WOBJ_DATA).
    ! get wobjdata for uframe
    ! Identify if uframe has been set or not.
    ! Be able to adjust uframe based on moving ToH and still be able to do tower

    RECORD c_peg
        wobjdata wobj;
    ENDRECORD
    
    PROC peg_arr_SET_UFRAME (INOUT c_peg peg_arr{*}, pose user_frame, \switch maintain_global_pos)
        ! TODO implement maintain_global_pos to prevent change in uframe from changing oframe global position
        ! Allows for refinement or alteration of uframe without changing position of set work objects
        FOR i from 1 TO Dim(peg_arr, 1) DO
            peg_arr{i}.wobj.uframe := user_frame;
        ENDFOR
    ENDPROC
    
    PROC peg_SET_WOBJ_DATA (INOUT c_peg peg)
        ! TODO
        ! Set up peg w/ work object data
        ! Use base plane from station as UFrrame
        ! Get axis of cylinder
        ! get point on top of cylinder
        ! Create plane normal to cylinder axis that intersects top point
        ! Create origin where axis instersects plane
        ! Align wobj to world frame
    ENDPROC
    
ENDMODULE