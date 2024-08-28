MODULE M_Game
    
    PROC game_GET_NEXT_MOVE (num start{*}, num target{*}, INOUT num move_disc, INOUT num move_to_peg, \switch show_move)
        VAR num index := 0;
        VAR bool game_complete := TRUE;
        move_disc := 0;
        move_to_peg := 0;
        FOR index FROM 1 TO dim(start, 1) DO
            IF   start{index} = 0 OR  start{index} > G_ToH_number_of_pegs OR 
                target{index} = 0 OR target{index} > G_ToH_number_of_pegs
                RAISE ERR_PEG_NOT_ASSIGNED;
            IF start{index} <> target{index} game_complete := FALSE;
        ENDFOR
        
        IF game_complete = TRUE THEN
            move_disc := 0;
            move_to_peg := 0;
            RETURN;
        ENDIF
        
        IF Present (show_move) THEN
            game_GET_NEXT_MOVE_RECURSIVE start, target, start, dim(start,1), move_disc, move_to_peg, \show_move;
        ELSE
           game_GET_NEXT_MOVE_RECURSIVE start, target, start, dim(start,1), move_disc, move_to_peg;
        ENDIF
        
        ERROR
            TEST ERRNO
                CASE ERR_PEG_NOT_ASSIGNED:
                    IF NOT test_RUNNING() ErrWrite \W, "Disc " + NumToStr(index, 0) + " not assigned to valid peg. Recheck setup.", "";
                    RAISE;
                    RETURN;
            ENDTEST
    ENDPROC
    
    LOCAL PROC game_GET_NEXT_MOVE_RECURSIVE (INOUT num start{*}, num target{*}, num intermediate{*}, num dim_size, INOUT num move_disc, INOUT num move_to_peg, \switch show_move)
        VAR num nonmatching_disc;
        VAR num aux_peg;
        nonmatching_disc := game_GET_FIRST_NONMATCHING_DISC (start, target, dim_size);
        IF nonmatching_disc = 0 RETURN;
        
        ! Populate intermediate such that aux peg contains all discs smaller than 
        IF nonmatching_disc < dim_size THEN
            aux_peg := 6 - start{nonmatching_disc} - target{nonmatching_disc};
            FOR i FROM nonmatching_disc + 1 TO dim_size DO
                intermediate{i} := aux_peg;
            ENDFOR
        ENDIF
        IF Present(show_move) THEN
            game_GET_NEXT_MOVE_RECURSIVE start, intermediate, start, dim_size, move_disc, move_to_peg, \show_move;
        ELSE
            game_GET_NEXT_MOVE_RECURSIVE start, intermediate, start, dim_size, move_disc, move_to_peg;
        ENDIF
    
        IF move_disc <> 0 RETURN;
        move_disc := nonmatching_disc;
        move_to_peg := target{nonmatching_disc};
        IF Present(show_move) ErrWrite \I, "Disc " + NumToStr(move_disc, 0) + " from " + NumToStr(start{nonmatching_disc}, 0) + " to " + NumToStr(move_to_peg, 0), "";
    ENDPROC
    
    LOCAL FUNC num game_GET_FIRST_NONMATCHING_DISC (num start{*}, num target{*}, num dim_size)
        ! Index of the first nonmatching numbers in two arrays
        FOR i FROM 1 TO dim_size DO
            IF NOT start{i} = target{i} RETURN i;
        ENDFOR
        RETURN 0;
    ENDFUNC
    
!    PROC game_SOLVE (num start{*}, num target{*})
!        game_SOLVE_RECURSIVE start, target, start, dim(start,1);
!    ENDPROC
    
!    LOCAL PROC game_SOLVE_RECURSIVE (INOUT num start{*}, num target{*}, num intermediate{*}, num dim_size)
        
!        VAR num nonmatching_disc;
!        VAR num aux_peg;
!        nonmatching_disc := game_GET_FIRST_NONMATCHING_DISC (start, target, dim_size);
!        IF nonmatching_disc = 0 RETURN;
        
!        ! Populate intermediate such that aux peg contains all discs smaller than 
!        IF nonmatching_disc < dim_size THEN
!            aux_peg := 6 - start{nonmatching_disc} - target{nonmatching_disc};
!            FOR i FROM nonmatching_disc + 1 TO dim_size DO
!                intermediate{i} := aux_peg;
!            ENDFOR
!        ENDIF
!        game_SOLVE_RECURSIVE start, intermediate, start, dim_size;
        
!        ! INSERT MOVE FUNCTION HERE
!        ErrWrite \I, "Move Disc " + NumToStr(nonmatching_disc,0) + " from " + NumToStr(start{nonmatching_disc},0) + " to " + NumToStr(target{nonmatching_disc},0), "";
!        start{nonmatching_disc} := target{nonmatching_disc};
!        ! ErrWrite \I, ValToStr(start),"";
!        !move := move + 1;
!        !IF move MOD 500 = 0 ErrWrite \I, "Move: " + NumToStr(move, 0), "";
        
!        game_SOLVE_RECURSIVE start, target, start, dim_size;
!    ENDPROC
    
ENDMODULE