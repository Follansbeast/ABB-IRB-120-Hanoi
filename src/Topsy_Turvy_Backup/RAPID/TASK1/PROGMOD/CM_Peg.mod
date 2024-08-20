MODULE CM_Peg

    !To Do:
    ! Need algorithm for determining peg pose (peg_SET_WOBJ_DATA).
    ! get wobjdata for uframe
    ! Identify if uframe has been set or not.
    ! Be able to adjust uframe based on moving ToH and still be able to do tower

    RECORD c_peg
        wobjdata wobj;
    ENDRECORD
    
    PROC peg_arr_MENU (INOUT c_peg peg_arr{*})
        VAR menu_selection selection;
        VAR string menu_items{G_number_of_pegs};
        
        FOR i FROM 1 TO Dim(menu_items, 1) DO
            menu_items{i} := "Set Peg Work Object, Peg " + NumToStr(i,0);
        ENDFOR
        
        WHILE TRUE DO
            selection := menu_LIST ("Peg Setup", menu_items, ["SELECT", "BACK"], \previous_selection := selection);
            IF selection.button_selection = 2 RETURN;
            peg_SET_WOBJ_DATA peg_arr{selection.list_selection}.wobj;
        ENDWHILE
    ENDPROC
    
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