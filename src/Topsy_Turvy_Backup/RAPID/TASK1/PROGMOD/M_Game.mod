MODULE M_Game
    
    PROC game_SOLVE (INOUT num start{*}, num target{*}, num intermediate{*}, num dim_size)
        ! Dim size is included to cut down on processing time
        
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
        game_SOLVE start, intermediate, start, dim_size;
        
        ! INSERT MOVE FUNCTION HERE
        start{nonmatching_disc} := target{nonmatching_disc};
        ! ErrWrite \I, "Move Disc " + NumToStr(nonmatching_disc,0) + " from " + NumToStr(start{nonmatching_disc},0) + " to " + NumToStr(target{nonmatching_disc},0), "";
        ! ErrWrite \I, ValToStr(start),"";
        !move := move + 1;
        !IF move MOD 500 = 0 ErrWrite \I, "Move: " + NumToStr(move, 0), "";
        
        game_SOLVE start, target, start, dim_size;
    ENDPROC
    
    FUNC num game_GET_FIRST_NONMATCHING_DISC (num start{*}, num target{*}, num dim_size)
        ! Index of the first nonmatching numbers in two arrays
        FOR i FROM 1 TO dim_size DO
            IF NOT start{i} = target{i} RETURN i;
        ENDFOR
        RETURN 0;
    ENDFUNC
    
ENDMODULE