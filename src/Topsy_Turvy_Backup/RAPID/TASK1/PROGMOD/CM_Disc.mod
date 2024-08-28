MODULE CM_Disc
    
    RECORD c_disc
        num thickness;
        num peg_current;
        num peg_target_1;
        num peg_target_2;
        num peg_target_3;
        num peg_target_4;
        num peg_target_5;
        num peg_target_6;
        num peg_target_7;
        num peg_target_8;
        num peg_target_9;
        num peg_target_10;
    ENDRECORD
    
    RECORD c_disc_props
        c_num_props thickness_props;
    ENDRECORD 
    
    FUNC string disc_arr_GET_DISC_SUMMARY (INOUT c_disc disc_arr{*}, \num peg_number)
        ! Return a summary of which discs are on which pegs, as a string.
        ! Select the peg number to only return the discs on that peg
        !   Peg 0 returns any discs not currently on a peg
        
        VAR string peg_summary{G_ToH_number_of_pegs + 1};
        VAR bool has_discs{3} := [FALSE, FALSE, FALSE];
        VAR string total_summary;
        VAR errnum NO_SUCH_PEG := 1;
        
        VAR num selected_peg;
        FOR i FROM 1 TO dim(disc_arr,1) DO
            selected_peg := disc_arr{i}.peg_current;
            IF 0 < selected_peg AND selected_peg <= dim(peg_summary,1) - 1 THEN
                peg_summary{selected_peg} := peg_summary{selected_peg} + NumToStr(i,0) + ", ";
            ELSE
                peg_summary{Dim(peg_summary,1)} := peg_summary{4} + NumToStr(i,0) + ", ";
            ENDIF
            
        ENDFOR
        FOR i FROM 1 TO dim(peg_summary, 1) DO
            IF StrLen(peg_summary{i}) > 0 peg_summary{i} := StrPart(peg_summary{i}, 1, StrLen(peg_summary{i}) - 2);
            peg_summary{i} := "[" + peg_summary{i} + "]";
        ENDFOR
        
        IF present (peg_number) AND peg_number > G_ToH_number_of_pegs RAISE NO_SUCH_PEG;
        IF present (peg_number) AND peg_number = 0 RETURN peg_summary{dim(peg_summary,1)};
        IF present (peg_number) RETURN peg_summary{peg_number};
        
        FOR i FROM 1 TO Dim(peg_summary, 1) DO
            IF i <> Dim(peg_summary, 1) THEN
                total_summary := total_summary + peg_summary{i} + ", ";
            ELSE
                total_summary := total_summary + peg_summary{i};
            ENDIF
        ENDFOR
        RETURN total_summary;
        
        ERROR
            TEST ERRNO
                CASE NO_SUCH_PEG:
                    IF NOT test_RUNNING() ErrWrite \W, "Peg selection out of bounds", "disc_arr_GET_DISC_SUMMARY was called with non-existent peg";
                    RETURN "";
            ENDTEST
    ENDFUNC
    
    FUNC num disc_arr_GET_TOP_DISC (c_disc disc_arr{*}, num peg_number)
        FOR i FROM Dim(disc_arr, 1) TO 1 DO
            IF disc_arr{i}.peg_current = peg_number RETURN i;
        ENDFOR
        RETURN 0;
    ENDFUNC
    
    FUNC num disc_arr_GET_DISC_THICKNESS (c_disc disc_arr{*}, num disc_number)
        RETURN disc_arr{disc_number}.thickness;
    ENDFUNC
    
    FUNC num disc_arr_GET_TOP_DISC_THICKNESS(c_disc disc_arr{*}, num peg_number)
        RETURN disc_arr_GET_DISC_THICKNESS (disc_arr, disc_arr_GET_TOP_DISC (disc_arr, peg_number));
    ENDFUNC
    
    FUNC num disc_arr_GET_STACK_HEIGHT (c_disc disc_arr{*}, num peg_number)
        VAR num stack_height := 0;
        FOR i FROM 1 to Dim(disc_arr, 1) DO
            IF disc_arr{i}.peg_current = peg_number stack_height := stack_height + disc_arr{i}.thickness;
        ENDFOR
        RETURN stack_height;
    ENDFUNC
    
    FUNC bool disc_arr_LEGAL_TO_MOVE_DISC (c_disc disc_arr {*}, num disc_value, num peg_number_to, \bool override)
        VAR bool override_value := FALSE;
        VAR num peg_number_from;
        peg_number_from := disc_arr{disc_value}.peg_current;
        IF Present(override) AND override = TRUE override_value := TRUE;
        
        ! Not on peg
        IF peg_number_from < 1 OR 3 < peg_number_from RETURN TRUE;
        
        ! 
        IF disc_arr_GET_TOP_DISC(disc_arr, peg_number_from) <> disc_value THEN
            errwrite "Move is not allowed.", "Selected disc is not the top disc on the sahft.";
            RETURN FALSE;
        ENDIF
        
        IF override_value RETURN TRUE;
        
        IF  disc_arr_GET_TOP_DISC(disc_arr, peg_number_from) <= disc_arr_GET_TOP_DISC(disc_arr, peg_number_to) THEN
            errwrite "Move is not allowed.", "Selected disc is larger than disc on target peg.";
            RETURN FALSE;
        ENDIF
        RETURN TRUE;
    ENDFUNC
    
    PROC disc_arr_MOVE_DISC (INOUT c_disc disc_arr{*}, num disc_value, num peg_number \bool override)
        VAR bool override_value := FALSE;
        IF Present(override) AND override = TRUE override_value := TRUE;
        
        IF disc_arr_LEGAL_TO_MOVE_DISC(disc_arr, disc_value, peg_number, \override:= override_value) THEN
            disc_arr{disc_value}.peg_current := peg_number;
        ENDIF
    ENDPROC
    
    PROC disc_arr_REMOVE_ALL_DISCS (INOUT c_disc disc_arr{*})
        FOR i FROM 1 TO Dim(disc_arr, 1) DO
             disc_arr{i}.peg_current := 0;
        ENDFOR
    ENDPROC
    
ENDMODULE